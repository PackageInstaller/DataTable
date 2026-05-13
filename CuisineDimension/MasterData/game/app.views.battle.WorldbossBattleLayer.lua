local UnitCsv = require("csvdata.unit")
local ProfessionCsv = require("csvdata.profession")
local ChapterBattleCsv = require("csvdata.worldboss_battle")
local Battle = require("logical.battle.Battle")
local BaseBattleLayer = import(".BaseBattleLayer")
local SkillBar = import(".SkillBar")
local TasteBar = import(".TasteBar")
local WorldbossBattleLayer = class("WorldbossBattleLayer", BaseBattleLayer)
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

function WorldbossBattleLayer:ctor(params)
  params = params or {}
  local bossType = params.bossType
  local bossDegree = params.bossDegree
  self.leftInfo = params.leftInfo
  self.format = params.format
  self.bossHp = params.bossHp
  self.skills = params.skills
  self.buffs = params.buffs
  self.carbonData = ChapterBattleCsv[bossType][bossDegree]
  self.sceneCsv = require(self.carbonData.scene)
  if self.carbonData.mapPlugin ~= "" then
    self.mapPlugin = require(self.carbonData.mapPlugin)
  end
  self.killTime = globalCsv.WorldBossBattleLimitTime
  self.lastKillTime = 0
  self.currentPhase = 1
  self.totalPhase = table.nums(self.sceneCsv)
  BaseBattleLayer.ctor(self, params)
end

function WorldbossBattleLayer:__init()
  game:playMusic(self.carbonData.bgm)
  self.enemyHasLoaded = false
  self.enemyDead = 0
  self.frameEvents = {}
  self.battleLogic = Battle:create({
    totalPhase = self.totalPhase,
    battleType = BattleType.Worldboss
  })
  self:loadTMXMapData()
  self.skillBar = SkillBar:create({
    formatEffect = self.leftInfo.formatEffect[0]
  }):pos(display.width, 0):addTo(self.uiLayer):hide()
  self.tasteBar = TasteBar:create({
    battle = self.battleLogic
  }):addTo(self.uiLayer):hide()
  self:fitForiPhoneX()
  self:initLeftInfo()
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
    if game.role.majorGuideStep == 11 then
      SysError(SYS_ERR_GUIDE_EXIT)
      return
    end
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
      self.leftAngle:show()
      self.rightAngle:show()
      UIHelper.MoveToRight({
        node = self.leftAngle
      })
      UIHelper.MoveToLeft({
        node = self.rightAngle
      })
      self.tasteBar:show()
      UIHelper.MoveToRight({
        node = self.tasteBar
      })
      self.skillBar:show()
      UIHelper.MoveToLeft({
        node = self.skillBar,
        pos = {500, 150}
      })
      for _, _player in ipairs(self.battleLogic:getPlayers(SIDE_LEFT)) do
        _player.displayNode:show()
      end
      for _, _player in ipairs(self.battleLogic:getPlayers(SIDE_RIGHT)) do
        _player.displayNode:show()
      end
      self.btnPause:setTouchEnabled(true)
      self.btnExit:setTouchEnabled(true)
      local timeBg = display.newSprite("ui/battle/pvp_time.png"):pos(display.cx, display.height - 50):addTo(self.uiLayer)
      self.timeLabel = display.newTTFLabel({
        text = "00:00",
        size = 30,
        color = UIHelper.hex2rgb("a5f723")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(88, 20):addTo(timeBg)
    end, sp.EventType.ANIMATION_END)
  end
  
  enterBattle()
  self.leftAngle:hide()
  self.rightAngle:hide()
  self.btnPause:setTouchEnabled(false)
  self.btnExit:setTouchEnabled(false)
end

function WorldbossBattleLayer:sendGameEndRequest(starNum)
  local function endBattle()
    local check = {}
    
    local herosHurtValue = {}
    local players = self.battleLogic:getPlayers(SIDE_LEFT)
    for _, value in pairs(self.leftInfo.heros) do
      local hp = 0
      local hurt = 0
      for _, heroInfo in pairs(players) do
        if value.id == heroInfo.id then
          hp = heroInfo.hp
          hurt = heroInfo.totalAttackValue or 0
          if game.role.majorGuideStep == 11 and heroInfo.id == 2 then
            hp = hp - 1
          end
        end
      end
      herosHurtValue[value.id] = hurt
      check[value.id] = {
        battleValue = tonumber(value.__battleValue),
        fullHp = value.fullHp,
        atk = value.atk
      }
    end
    local sendGameInfo
    
    function sendGameInfo()
      NetManager:removeEventListenersByEvent("networkLogin")
      NetManager:addEventListener("networkLogin", function()
        sendGameInfo()
      end)
      local bossData = self.battleLogic:getPlayers(SIDE_RIGHT)[1]
      if not bossData.hurt then
        bossData.hurt = 0
      end
      game:sendData(actionCodes.World_endBattleRpc, MsgPack.pack({
        hurt = bossData.hurt
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.World_endBattleRpc, function(event)
        UIHelper.removeWaiting()
        NetManager:removeEventListenersByEvent("networkLogin")
        local msg = MsgPack.unpack(event.data)
        msg = {}
        msg.herosInfo = {}
        msg.herosInfo["27"] = {}
        msg.herosInfo["27"].exp = 0
        msg.herosInfo["27"].origExp = 0
        msg.herosInfo["27"].origLevel = 100
        msg.starNum = starNum
        msg.enemyDead = self.enemyDead
        msg.bossType = self.carbonData.type
        msg.bossDegree = self.carbonData.degree
        msg.carbonType = BattleType.Worldboss
        msg.format = self.format
        msg.hurt = math.modf(bossData.hurt)
        msg.herosHurtValue = herosHurtValue
        game:createView("carbon.NewBattleResultLayer", msg)
      end)
    end
    
    sendGameInfo()
  end
  
  endBattle()
end

function WorldbossBattleLayer:initLeftInfo()
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
    if self.leftInfo.formatEffect[7] then
      info.formatEffect = info.formatEffect or {}
      for _, effect in ipairs(self.leftInfo.formatEffect[7]) do
        table.insert(info.formatEffect, effect)
      end
    end
    local player = self:addPlayer(info)
    player:addEventListener("releaseSpecial", function(event)
      local autoStatus = game.role.autoStatus
      local state = autoStatus:getv(2, 1)
      if state == 1 and player.unit.cutinAv ~= "" then
        self:showSpecialSkill(player, event.skillId)
      else
        self:showSpecialSkill(player, event.skillId)
      end
    end)
    player:addEventListener("releaseBlock", function(event)
      self:showBlockSkill(player, event.skillId)
    end)
    player:addEventListener("playerDead", function(event)
      self:onPlayerDead(player)
    end)
    player:addEventListener("playerHpChange", function(event)
      if event.origPercent > 30 and 30 >= event.nowPercent then
        table.insert(self.brokenEffect, player.type)
        if #self.brokenEffect == 1 then
          self:showBrokenCard(player)
        end
      end
    end)
    if #self.skills ~= 0 then
      for i, skillId in ipairs(self.skills) do
        player:addPassiveSkill(skillId)
      end
    end
    if #self.buffs ~= 0 then
      for i, buffId in ipairs(self.buffs) do
        player:addBuff({buffId = buffId, releaser = player})
      end
    end
    self.skillBar:addPlayer(player, index ~= #heroData)
  end
  self.battleLogic:initStar()
end

function WorldbossBattleLayer:loadTMXMapData()
  self.viewNode = cc.ParallaxNode:create()
  self:addChild(self.viewNode, -2)
  self:parseTmxMap(self.carbonData.mapRes .. "/map.tmx", self.viewNode, -self.carbonData.mapOffset)
  if self.mapPlugin then
    self:loadPlugin()
  end
  self.viewBeginXPosition = 0
  self.viewEndXPosition = BATTLE_PHASE_LENGTH_1
end

function WorldbossBattleLayer:enterNextPhase()
  self.battleLogic:updateMoveRange(self.viewBeginXPosition + 50, self.viewEndXPosition - 50)
  self.battleLogic:reset({
    currentPhase = self.currentPhase
  })
end

function WorldbossBattleLayer:loadPhaseEnemys()
  self.enemyHasLoaded = true
  self.enemys = {}
  local allEnemys = table.values(self.sceneCsv[self.currentPhase])
  table.sort(allEnemys, function(a, b)
    return a.id < b.id
  end)
  local bossHpBarNode
  for idx, csvData in ipairs(allEnemys) do
    local enemy = self:packCsvPlayer(csvData)
    enemy.side = SIDE_RIGHT
    enemy.id = csvData.id
    enemy.zorder = csvData.zorder or idx
    enemy.index = self.battleLogic:nextPlayerIdx(SIDE_RIGHT)
    enemy.xPos = csvData.xOffset * 100
    enemy.hp = self.bossHp
    enemy.isWorldBoss = true
    for attr, _ in pairs(AttsEnum) do
      if enemy[attr] then
        enemy[attr] = enemy[attr]
      end
    end
    if not bossHpBarNode then
      bossHpBarNode = display.newNode():addTo(self.uiLayer):pos(display.cx + 100, display.height - 20)
      enemy.bossHpBarNode = bossHpBarNode
    end
    table.insert(self.enemys, enemy)
  end
  local tastes = {}
  
  local function randomTaste()
    if #tastes == 0 then
      tastes = {
        1,
        2,
        3,
        4
      }
    end
    local index = math.randomInt(1, #tastes)
    local taste = tastes[index]
    table.remove(tastes, index)
    return taste
  end
  
  for _, enemy in ipairs(self.enemys) do
    if enemy.randomTaste > 0 then
      enemy.taste = randomTaste()
    end
    local enemy = self:addPlayer(enemy, RIGHT_PLAYER_ORDER + enemy.zorder)
    enemy:addEventListener("playerDead", function(event)
      self:onPlayerDead(enemy)
    end)
    if enemy.leader then
      enemy:addEventListener("releaseSpecial", function(event)
        self:showBossSpecial(enemy, event.skillId)
      end)
    end
  end
end

function WorldbossBattleLayer:onPlayerDead(player)
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
  if player.side == SIDE_RIGHT then
    self.enemyDead = self.enemyDead + 1
    self.battleLogic:setTaste()
  end
end

function WorldbossBattleLayer:step(dt)
  self:baseStep(dt)
  self:updateTime(dt)
  for _, event in ipairs(self.frameEvents) do
    event:update(dt)
  end
  if not self.enemyHasLoaded then
    self:loadPhaseEnemys()
  end
end

function WorldbossBattleLayer:updateTime(dt)
  if self.runState == "stop" then
    return
  end
  if self.battleLogic:gameOver() then
    return
  end
  self.killTime = self.killTime - dt
  if math.abs(self.lastKillTime - self.killTime) < 1 then
    return
  end
  self.lastKillTime = self.killTime
  if not self.timeLabel then
    return
  end
  if self.killTime >= 0 then
    self.timeLabel:setString(UIHelper.getTimeStr(self.killTime, true))
  end
  if self.killTime < 10 then
    self.timeLabel:setTextColor(UIHelper.hex2rgb("#ff0101"))
  end
  if self.killTime <= 0 then
    for index, player in ipairs(table.values(self.battleLogic:getPlayers(SIDE_LEFT))) do
      player:hurtAction(player.hp, "normal", "normal", {})
    end
  end
end

function WorldbossBattleLayer:showView()
  for index, heroData in ipairs(self.leftInfo.heros) do
    CommonHelper.cacheUnitRes(heroData.type, heroData.skillInfo or {})
  end
  for phase = 1, self.totalPhase do
    for _, enemy in pairs(self.sceneCsv[phase]) do
      CommonHelper.cacheUnitRes(enemy.unitType, {})
    end
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

return WorldbossBattleLayer
