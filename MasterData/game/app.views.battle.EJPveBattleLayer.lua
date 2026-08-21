local UnitCsv = require("csvdata.unit")
local ProfessionCsv = require("csvdata.profession")
local ChapterBattleCsv = require("csvdata.awaken_battle")
local Battle = require("logical.battle.Battle")
local BaseBattleLayer = import(".BaseBattleLayer")
local SkillBar = import(".SkillBar")
local TasteBar = import(".TasteBar")
local EJPveBattleLayer = class("EJPveBattleLayer", BaseBattleLayer)
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

function EJPveBattleLayer:ctor(params)
  params = params or {}
  local bossType = params.bossType
  local bossDegree = params.bossDegree
  self.leftInfo = params.leftInfo
  self.format = params.format
  self.carbonData = ChapterBattleCsv[bossType][bossDegree]
  self.sceneCsv = require(self.carbonData.scene)
  if self.carbonData.mapPlugin ~= "" then
    self.mapPlugin = require(self.carbonData.mapPlugin)
  end
  self.timeShow = params.bossType == 5 and true or false
  self.currentPhase = 1
  self.totalPhase = table.nums(self.sceneCsv)
  BaseBattleLayer.ctor(self, params)
end

function EJPveBattleLayer:__init()
  game:playMusic(self.carbonData.bgm)
  self.enemyHasLoaded = false
  self.enemyDead = 0
  self.frameEvents = {}
  self.battleLogic = Battle:create({
    totalPhase = self.totalPhase,
    battleType = BattleType.EJ
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
      if self.timeShow then
        local timeBg = display.newSprite("ui/battle/pvp_time.png"):pos(display.cx, display.height - 20):addTo(self.uiLayer)
        self.timeLabel = display.newTTFLabel({
          text = "00:00",
          size = 30,
          color = UIHelper.hex2rgb("a5f723")
        }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(88, 20):addTo(timeBg)
      end
      self.btnPause:setTouchEnabled(true)
      self.btnExit:setTouchEnabled(true)
    end, sp.EventType.ANIMATION_END)
  end
  
  enterBattle()
  self.leftAngle:hide()
  self.rightAngle:hide()
  self.btnPause:setTouchEnabled(false)
  self.btnExit:setTouchEnabled(false)
end

function EJPveBattleLayer:sendGameEndRequest(starNum)
  local passTime = math.ceil(self.battleLogic:getTime())
  
  local function endBattle()
    local brokenCount = 0
    local check = {}
    local herosHurtValue = {}
    local players = self.battleLogic:getPlayers(SIDE_LEFT)
    for _, value in pairs(self.leftInfo.heros) do
      local had = false
      local hurt = 0
      for _, heroInfo in pairs(players) do
        if value.id == heroInfo.id then
          had = true
          hurt = heroInfo.totalAttackValue or 0
          if heroInfo.hp * 100 / value.fullHp <= 30 then
            brokenCount = brokenCount + 1
          end
          break
        end
      end
      if not had then
        brokenCount = brokenCount + 1
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
      game:sendData(actionCodes.Carbon_eijiEndGameRpc, MsgPack.pack({
        passTime = self.battleLogic:getTime(),
        starNum = starNum,
        check = check,
        key = (json.decode(game.role.eijiCarbonInfo or "[]") or {}).key,
        bossType = self.carbonData.type,
        scoreInfo = {hurt = brokenCount, time = passTime},
        bossDegree = self.carbonData.degree,
        checkEnemy = self:getEnemyBattleValue(self.enemys)
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Carbon_eijiEndGameRpc, function(event)
        UIHelper.removeWaiting()
        NetManager:removeEventListenersByEvent("networkLogin")
        local msg = MsgPack.unpack(event.data)
        msg.starNum = starNum
        msg.enemyDead = self.enemyDead
        msg.bossType = self.carbonData.type
        msg.bossDegree = self.carbonData.degree
        msg.carbonType = BattleType.EJ
        msg.format = self.format
        msg.herosHurtValue = herosHurtValue
        game:createView("carbon.NewBattleResultLayer", msg)
      end)
    end
    
    sendGameInfo()
  end
  
  endBattle()
end

function EJPveBattleLayer:initLeftInfo()
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
    self.skillBar:addPlayer(player, index ~= #heroData)
  end
  self.battleLogic:initStar()
end

function EJPveBattleLayer:loadTMXMapData()
  self.viewNode = cc.ParallaxNode:create()
  self:addChild(self.viewNode, -2)
  self:parseTmxMap(self.carbonData.mapRes .. "/map.tmx", self.viewNode, -self.carbonData.mapOffset)
  if self.mapPlugin then
    self:loadPlugin()
  end
  self.viewBeginXPosition = 0
  self.viewEndXPosition = BATTLE_PHASE_LENGTH_1
end

function EJPveBattleLayer:enterNextPhase()
  self.battleLogic:updateMoveRange(self.viewBeginXPosition + 50, self.viewEndXPosition - 50)
  self.battleLogic:reset({
    currentPhase = self.currentPhase
  })
end

function EJPveBattleLayer:loadPhaseEnemys()
  self.enemyHasLoaded = true
  self.enemys = {}
  local allEnemys = table.values(self.sceneCsv[self.currentPhase])
  table.sort(allEnemys, function(a, b)
    return a.id < b.id
  end)
  for idx, csvData in ipairs(allEnemys) do
    local enemy = self:packCsvPlayer(csvData)
    enemy.side = SIDE_RIGHT
    enemy.id = csvData.id
    enemy.zorder = csvData.zorder or idx
    enemy.index = self.battleLogic:nextPlayerIdx(SIDE_RIGHT)
    enemy.xPos = csvData.xOffset * 100
    for attr, _ in pairs(AttsEnum) do
      if enemy[attr] then
        enemy[attr] = enemy[attr]
      end
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

function EJPveBattleLayer:onPlayerDead(player)
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

function EJPveBattleLayer:step(dt)
  self:baseStep(dt)
  for _, event in ipairs(self.frameEvents) do
    event:update(dt)
  end
  if not self.enemyHasLoaded then
    self:loadPhaseEnemys()
  end
  if self.timeShow then
    if self.battleLogic:gameOver() then
      self.timeLabel:setString(UIHelper.getTimeStr(math.ceil(self.battleLogic:getTime()), true))
      return
    end
    if not self.timeLabel then
      return
    end
    self.timeLabel:setString(UIHelper.getTimeStr(math.ceil(self.battleLogic:getTime()), true))
  end
end

function EJPveBattleLayer:showView()
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

return EJPveBattleLayer
