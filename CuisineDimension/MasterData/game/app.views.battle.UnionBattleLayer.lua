local UnitCsv = require("csvdata.unit")
local ProfessionCsv = require("csvdata.profession")
local PvpBattleCsv = require("csvdata.pvp_battle")
local Battle = require("logical.battle.Battle")
local BaseBattleLayer = import(".BaseBattleLayer")
local SkillBar = import(".SkillBar")
local AutoSkillBar = import(".AutoSkillBar")
local UnionBattleLayer = class("UnionBattleLayer", BaseBattleLayer)
local uiData = {
  csbFile = "ui/battle/MainLayer.csb",
  order = -1,
  widgets = {
    leftAngle = "leftAngle",
    btnPause = "leftAngle/btnPause",
    rightAngle = "rightAngle",
    btnExit = "rightAngle/btnExit"
  }
}
local logicData = {}

function UnionBattleLayer:ctor(params)
  params = params or {}
  self.leftInfo = params.leftInfo
  self.rightInfo = params.rightInfo
  self.rightLevel = params.rightLevel
  local mapIndex = math.randomInt(1, #PvpBattleCsv)
  self.carbonData = PvpBattleCsv[mapIndex]
  if self.carbonData.mapPlugin ~= "" then
    self.mapPlugin = require(self.carbonData.mapPlugin)
  end
  self.currentPhase = 1
  self.totalPhase = 1
  self.killTime = globalCsv.unionRoundTime
  self.lastKillTime = 0
  self.buffTimeInterval = globalCsv.unionPowerTime
  BaseBattleLayer.ctor(self, params)
end

function UnionBattleLayer:__init()
  game:playMusic(11)
  self.enemyHasLoaded = false
  self.enemyDead = 0
  self.frameEvents = {}
  self.battleLogic = Battle:create({
    totalPhase = self.totalPhase,
    battleType = BattleType.PvE
  })
  self:loadTMXMapData()
  self.skillBar = SkillBar:create({
    pvpBattle = true,
    formatEffect = self.leftInfo.formatEffect[0]
  }):pos(display.width, 0):addTo(self.uiLayer):hide()
  self.autoSkillBar = AutoSkillBar:create({
    pvpBattle = true,
    level = self.rightLevel,
    formatEffect = self.rightInfo.formatEffect[0]
  })
  self:fitForiPhoneX()
  self:initLeftInfo()
  self:initRightInfo()
  self:enterNextPhase()
  self.leftAngle:setCascadeOpacityEnabled(true)
  self.rightAngle:setCascadeOpacityEnabled(true)
  self.btnPause:setTouchScale()
  self.btnPause:setCallback(function()
    self:pause()
    game:createView("battle.BattlePauseLayer", {
      battleType = BattleType.PvE,
      parent = self
    })
  end)
  self.btnExit:setTouchScale()
  self.btnExit:setCallback(function()
    self:pause()
    MDialog:double({
      text = textByKey("battle_cancelGame"),
      size = 24,
      color = UIHelper.hex2rgb("#430602"),
      cancelCallback = function()
        self:resume()
        return true
      end,
      okCallback = function()
        self:resume()
        self:cancelGame()
        return true
      end
    })
  end)
  self.battleLogic:addEventListener("gameOver", function(event)
    self:gameEndAction()
    self.leftAngle:hide()
    self.rightAngle:hide()
  end)
  self.battleLogic:addEventListener("teamOver", function(event)
    self.currentPhase = self.currentPhase + 1
    self.battleLogic:reset({
      currentPhase = self.currentPhase
    })
    if self.currentPhase > self.totalPhase then
      return
    end
    self.enemyHasLoaded = false
    local frontestLeft = self.battleLogic:frontestTeamer(SIDE_LEFT)
    if not frontestLeft then
      return
    end
    self:enterNextPhase()
  end)
  table.insert(self.frameEvents, self.battleLogic)
  table.insert(self.frameEvents, self.skillBar)
  table.insert(self.frameEvents, self.autoSkillBar)
  for _, _player in ipairs(self.battleLogic:getPlayers(SIDE_LEFT)) do
    _player.displayNode:hide()
  end
  for _, _player in ipairs(self.battleLogic:getPlayers(SIDE_RIGHT)) do
    _player.displayNode:hide()
  end
  
  local function enterBattle()
    local spine = UIHelper.createSpineNodeByRes("ui/battle/start")
    spine:pos(display.width / 2, display.height / 2):addTo(self)
    spine:setAnimation(0, "special", false)
    spine:registerSpineEventHandler(function(event)
      if event.animation ~= "special" then
        return
      end
      scheduler.performWithDelayGlobal(function()
        spine:removeSelf()
      end, 0.016666666666666666)
      self:scheduleUpdate(handler(self, self.step))
      for _, _player in ipairs(self.battleLogic:getPlayers(SIDE_LEFT)) do
        _player.displayNode:show()
      end
      for _, _player in ipairs(self.battleLogic:getPlayers(SIDE_RIGHT)) do
        _player.displayNode:show()
      end
      self.skillBar:show()
      UIHelper.MoveToLeft({
        node = self.skillBar,
        pos = {500, 150}
      })
      self:checkGuide()
      local timeBg = display.newSprite("ui/battle/pvp_time.png"):pos(display.cx, display.height - 20):addTo(self.uiLayer)
      self.timeLabel = display.newTTFLabel({
        text = "00:00",
        size = 30,
        color = UIHelper.hex2rgb("a5f723")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(88, 20):addTo(timeBg)
    end, sp.EventType.ANIMATION_END)
  end
  
  self.leftAngle:hide()
  self.rightAngle:hide()
  self.btnPause:setTouchEnabled(false)
  self.btnExit:setTouchEnabled(false)
  self.btnPause:hide()
  self.btnExit:hide()
  enterBattle()
end

function UnionBattleLayer:sendGameEndRequest(starNum)
  local sendGameInfo = function()
    NetManager:removeEventListenersByEvent("networkLogin")
    NetManager:addEventListener("networkLogin", function()
      sendGameInfo()
    end)
    game:sendData(actionCodes.Activity_unionBattleEndBattleRpc, MsgPack.pack({
      passTime = self.battleLogic:getTime(),
      is_win = 0 < starNum
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_unionBattleEndBattleRpc, function(event)
      UIHelper.removeWaiting()
      NetManager:removeEventListenersByEvent("networkLogin")
      local msg = MsgPack.unpack(event.data)
      msg.starNum = starNum
      game:createView("union.UnionBattleResultLayer", msg)
    end)
  end
  sendGameInfo()
end

function UnionBattleLayer:initLeftInfo()
  local heroData = {}
  for _, heroInfo in ipairs(self.leftInfo.heros) do
    table.insert(heroData, heroInfo)
  end
  table.sort(heroData, function(a, b)
    local factorA = -UnitCsv[a.type].profession * 10000000 + a.fullHp
    local factorB = -UnitCsv[b.type].profession * 10000000 + b.fullHp
    return factorA > factorB
  end)
  local frontData = UnitCsv[heroData[1].type]
  local distance = ProfessionCsv[frontData.profession].maxAtkDis
  local count = 1
  for index, info in ipairs(heroData) do
    info.zorder = index
    info.skillBar = self.skillBar
    info.side = SIDE_LEFT
    info.index = self.battleLogic:nextPlayerIdx(SIDE_LEFT)
    local unitData = UnitCsv[info.type]
    info.xPos = -(ProfessionCsv[unitData.profession].maxAtkDis - distance) - 100
    if heroData[index - 1] then
      local nextUnit = UnitCsv[heroData[index - 1].type]
      if unitData.profession == nextUnit.profession then
        count = count + 1
      else
        count = 1
      end
    end
    if 3 < count then
      info.xPos = info.xPos - 150
    end
    if self.leftInfo.formatEffect[unitData.profession] then
      info.formatEffect = self.leftInfo.formatEffect[unitData.profession]
    end
    local player = self:addPlayer(info)
    player:addEventListener("releaseSpecial", function(event)
    end)
    player:addEventListener("releaseBlock", function(event)
      self:showBlockSkill(player, event.skillId)
    end)
    player:addEventListener("playerDead", function(event)
      self:onPlayerDead(player)
    end)
    player:addEventListener("playerHpChange", function(event)
    end)
    self.skillBar:addPlayer(player)
  end
  self.battleLogic:initStar()
end

function UnionBattleLayer:initRightInfo()
  local heroData = {}
  for _, heroInfo in ipairs(self.rightInfo.heros) do
    table.insert(heroData, heroInfo)
  end
  table.sort(heroData, function(a, b)
    local factorA = -UnitCsv[a.type].profession * 10000000 + a.fullHp
    local factorB = -UnitCsv[b.type].profession * 10000000 + b.fullHp
    return factorA > factorB
  end)
  local frontData = UnitCsv[heroData[1].type]
  local distance = ProfessionCsv[frontData.profession].maxAtkDis
  local count = 1
  for index, info in ipairs(heroData) do
    info.zorder = RIGHT_PLAYER_ORDER + index
    info.skillBar = self.autoSkillBar
    info.side = SIDE_RIGHT
    info.index = self.battleLogic:nextPlayerIdx(SIDE_RIGHT)
    local unitData = UnitCsv[info.type]
    info.xPos = display.width + (ProfessionCsv[unitData.profession].maxAtkDis - distance) + 100
    if heroData[index - 1] then
      local nextUnit = UnitCsv[heroData[index - 1].type]
      if unitData.profession == nextUnit.profession then
        count = count + 1
      else
        count = 1
      end
    end
    if 3 < count then
      info.xPos = info.xPos + 150
    end
    if self.rightInfo.formatEffect[unitData.profession] then
      info.formatEffect = self.rightInfo.formatEffect[unitData.profession]
    end
    if self.rightInfo.formatEffect[7] then
      info.formatEffect = info.formatEffect or {}
      for _, effect in ipairs(self.rightInfo.formatEffect[7]) do
        table.insert(info.formatEffect, effect)
      end
    end
    local player = self:addPlayer(info)
    player:addEventListener("playerDead", function(event)
      self:onPlayerDead(player)
    end)
    self.autoSkillBar:addPlayer(player)
  end
end

function UnionBattleLayer:loadTMXMapData()
  self.viewNode = cc.ParallaxNode:create()
  self:addChild(self.viewNode, -2)
  self:parseTmxMap(self.carbonData.mapRes .. "/map.tmx", self.viewNode, -self.carbonData.mapOffset)
  if self.mapPlugin then
    self:loadPlugin()
  end
  self.viewBeginXPosition = 0
  self.viewEndXPosition = BATTLE_PHASE_LENGTH_1
end

function UnionBattleLayer:enterNextPhase()
  self.battleLogic:updateMoveRange(self.viewBeginXPosition + 50, self.viewEndXPosition - 50)
  self.battleLogic:reset({
    currentPhase = self.currentPhase
  })
end

function UnionBattleLayer:onPlayerDead(player)
  player.displayNode:zorder(COLOR_BG_ORDER + 1)
  player.armatureNode:runAction(transition.sequence({
    cc.DelayTime:create(3),
    cc.CallFunc:create(function()
      local effect = UIHelper.loadAnimation("battleEff/fight/", "dead", 34, 30)
      local xPos, yPos = player.displayNode:getPosition()
      xPos = xPos + player.unit.deathOffset * (player.side == SIDE_RIGHT and 1 or -1)
      effect.sprite:anch(0.5, 0):pos(xPos, yPos - 20):addTo(player.map, COLOR_BG_ORDER + 1)
      effect.sprite:playAnimationOnce(effect.animation)
    end),
    cc.FadeOut:create(1),
    cc.CallFunc:create(function()
      player:dispose()
    end)
  }))
end

function UnionBattleLayer:step(dt)
  self:baseStep(dt)
  self:updateTime(dt)
  for _, event in ipairs(self.frameEvents) do
    event:update(dt)
  end
end

function UnionBattleLayer:updateTime(dt)
  if self.runState == "stop" then
    return
  end
  if self.battleLogic:gameOver() then
    return
  end
  self.buffTimeInterval = self.buffTimeInterval - dt
  if self.buffTimeInterval <= 0 then
    self.buffTimeInterval = globalCsv.unionPowerTime
    local buffId = 99999
    for index, player in ipairs(table.values(self.battleLogic:getPlayers(SIDE_LEFT))) do
      player:addBuff({buffId = buffId, releaser = player})
    end
    for index, player in ipairs(table.values(self.battleLogic:getPlayers(SIDE_RIGHT))) do
      player:addBuff({buffId = buffId, releaser = player})
    end
    display.newTTFLabel({
      text = "双方食灵受到鼓舞，攻击力提升10%",
      size = 20,
      color = UIHelper.hex2rgb("#26de1d")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(display.cx, display.height - 80):addTo(self.uiLayer):opacity(0):runAction(transition.sequence({
      cc.Spawn:create({
        cc.FadeIn:create(0.3),
        cc.MoveBy:create(0.3, cc.p(0, 20))
      }),
      cc.DelayTime:create(10),
      cc.Spawn:create({
        cc.FadeOut:create(0.3),
        cc.MoveBy:create(0.3, cc.p(0, 20))
      }),
      cc.RemoveSelf:create()
    }))
  end
  self.killTime = self.killTime - dt
  if 1 > math.abs(self.lastKillTime - self.killTime) then
    return
  end
  self.lastKillTime = self.killTime
  if not self.timeLabel then
    return
  end
  if 0 <= self.killTime then
    self.timeLabel:setString(UIHelper.getTimeStr(self.killTime, true))
  end
  if 10 > self.killTime then
    self.timeLabel:setTextColor(UIHelper.hex2rgb("#ff0101"))
  end
  if 0 >= self.killTime then
    for index, player in ipairs(table.values(self.battleLogic:getPlayers(SIDE_LEFT))) do
      player:hurtAction(player.hp, "normal", "normal", {})
    end
  end
end

function UnionBattleLayer:showView()
  for index, heroData in ipairs(self.leftInfo.heros) do
    CommonHelper.cacheUnitRes(heroData.type, heroData.skillInfo or {})
  end
  for index, heroData in ipairs(self.rightInfo.heros) do
    CommonHelper.cacheUnitRes(heroData.type, heroData.skillInfo or {})
  end
  ResourceMgr:addTileMaps({
    self.carbonData.mapRes .. "/map.tmx"
  })
  ResourceMgr:addPlists(GlobalEffectRes)
  ResourceMgr:addSpineRes(GlobalSpineRes)
  local loadingLayer = LoadingLayer.new({
    callback = function()
      local uiView = UIView:create(uiData, self)
      uiView:show(self)
    end
  })
  loadingLayer:setResourceMgr(ResourceMgr):addTo(self)
end

function UnionBattleLayer:checkGuide()
end

return UnionBattleLayer
