local UnitCsv = require("csvdata.unit")
local ProfessionCsv = require("csvdata.profession")
local ChapterBattleCsv = require("csvdata.chapter_battle")
local MonsterCsv = require("csvdata.monster")
local GhostCsv = require("csvdata.ghost")
local AutoBattleCsv = require("csvdata.auto_battle")
local Battle = require("logical.battle.Battle")
local BaseBattleLayer = import(".BaseBattleLayer")
local SkillBar = import(".SkillBar")
local TasteBar = import(".TasteBar")
local PveBattleLayer = class("PveBattleLayer", BaseBattleLayer)
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

function PveBattleLayer:ctor(params)
  params = params or {}
  self.carbonId = params.carbonId
  self.masterId = params.masterId
  self.bossId = params.bossId
  self.leftInfo = params.leftInfo
  self.format = params.format
  self.energy = params.energy or 0
  self.carbonBuff = params.buff
  self.weatherFactor = params.weatherFactor
  self.__battleKey = params.battleKey
  self.autoBattle = params.autoBattle
  self.modeType = params.modeType
  self.carbonData = ChapterBattleCsv[self.carbonId]
  self.monsterData = MonsterCsv[self.masterId]
  self.sceneCsv = require(self.monsterData.scene)
  if self.carbonData.mapPlugin ~= "" then
    self.mapPlugin = require(self.carbonData.mapPlugin)
  end
  if self.bossId > 0 then
    self.bossSet = GhostCsv[self.bossId]
  end
  self.currentPhase = 1
  self.totalPhase = table.nums(self.sceneCsv)
  BaseBattleLayer.ctor(self, params)
end

function PveBattleLayer:__init()
  game:playMusic(self.carbonData.bgm)
  self.enemyHasLoaded = false
  self.enemys = {}
  self.enemyDead = 0
  self.frameEvents = {}
  self.battleLogic = Battle:create({
    totalPhase = self.totalPhase,
    battleType = BattleType.PvE,
    modeType = self.modeType
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
  if self.autoBattle then
    local idxs = game.role.autoBattle.idxs:toArray("=", true)
    local autoCarbonlevel = AutoBattleCsv[idxs[1]].monsterSet:toArray("=", true)
    display.newTTFLabel({
      text = string.format("第%d/%d波", idxs[2], #autoCarbonlevel),
      size = 36
    }):enableOutline(UIHelper.hex2rgb("#3c2d24"), 2):pos(563, 0):addTo(self.btnPause)
  end
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
      self:checkGuide()
      self.btnPause:setTouchEnabled(true)
      self.btnExit:setTouchEnabled(true)
      if self.forbiddenTip then
        self.forbiddenTip:show()
      end
    end, sp.EventType.ANIMATION_END)
  end
  
  self.leftAngle:hide()
  self.rightAngle:hide()
  self.btnPause:setTouchEnabled(false)
  self.btnExit:setTouchEnabled(false)
  local carbon = game.role.carbons[self.carbonId]
  if 0 > carbon.score and 0 < self.monsterData.story1 then
    game:createView("talk.PlotTalkLayer", {
      talkId = self.monsterData.story1,
      csvNo = self.monsterData.readcsv or 0,
      onComplete = function()
        enterBattle()
      end
    })
  else
    enterBattle()
  end
  local layer = UIHelper.extend(ccui.Layout:create())
  layer:size(80, 76):anch(0.5, 0.5):pos(-40, 15):addTo(self.rightAngle)
  local chatBtn = UIHelper.extend(ccui.Button:create())
  chatBtn:setCascadeOpacityEnabled(true)
  chatBtn:setImages("ui/home/btns/", {"chat_b.png", "chat_b.png"})
  chatBtn:pos(40, 38):addTo(layer)
  chatBtn:setTouchScale()
  chatBtn:setCallback(function()
    game:createView("chat.ChatMainLayer")
  end)
  display.newSprite("ui/home/btns/chat_c.png"):anch(0.5, 0):pos(18, 5):addTo(chatBtn)
  chatBtn:setVisible(game.role.majorGuideStep > MAX_MAJOR_STEP)
end

function PveBattleLayer:sendGameEndRequest(starNum, cancel)
  local function endBattle()
    local info = {}
    
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
      info[value.id] = hp
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
      if self.autoBattle then
        game:sendData(actionCodes.Carbon_autoEndBattleRpc, MsgPack.pack({
          passTime = self.battleLogic:getTime(),
          cancel = cancel,
          starNum = starNum,
          info = info,
          check = check,
          key = game.role.autoBattle.key,
          checkEnemy = self:getEnemyBattleValue(self.enemys)
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Carbon_autoEndBattleRpc, function(event)
          UIHelper.removeWaiting()
          NetManager:removeEventListenersByEvent("networkLogin")
          local msg = MsgPack.unpack(event.data)
          msg.format = self.format
          msg.starNum = starNum
          msg.enemyDead = self.enemyDead
          msg.carbonId = self.carbonId
          msg.carbonType = BattleType.PvE
          msg.autoBattle = true
          msg.modeType = self.modeType
          msg.herosHurtValue = herosHurtValue
          game:createView("carbon.NewBattleResultLayer", msg)
        end)
      else
        game:sendData(actionCodes.Carbon_endGameRpc, MsgPack.pack({
          passTime = self.battleLogic:getTime(),
          starNum = starNum,
          info = info,
          check = check,
          key = self.__battleKey,
          checkEnemy = self:getEnemyBattleValue(self.enemys)
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Carbon_endGameRpc, function(event)
          UIHelper.removeWaiting()
          NetManager:removeEventListenersByEvent("networkLogin")
          local msg = MsgPack.unpack(event.data)
          msg.format = self.format
          msg.starNum = starNum
          msg.enemyDead = self.enemyDead
          msg.carbonId = self.carbonId
          msg.carbonType = BattleType.PvE
          msg.modeType = self.modeType
          msg.herosHurtValue = herosHurtValue
          game:createView("carbon.NewBattleResultLayer", msg)
        end)
      end
    end
    
    sendGameInfo()
  end
  
  local carbon = game.role.carbons[self.carbonId]
  if carbon.score < 0 and 0 < self.monsterData.story2 then
    game:createView("talk.PlotTalkLayer", {
      talkId = self.monsterData.story2,
      csvNo = self.monsterData.readcsv or 0,
      onComplete = function()
        endBattle()
      end
    })
  else
    endBattle()
  end
end

function PveBattleLayer:initLeftInfo()
  local heroData = {}
  for _, heroInfo in ipairs(self.leftInfo.heros) do
    if heroInfo.hp > 0 then
      table.insert(heroData, heroInfo)
    end
  end
  if #heroData == 0 then
    for _, heroInfo in ipairs(self.leftInfo.heros) do
      if heroInfo.hp <= 0 then
        heroInfo.hp = 1
        table.insert(heroData, heroInfo)
        break
      end
    end
  end
  table.sort(heroData, function(a, b)
    local factorA = -UnitCsv[a.type].profession * 10000000 + a.fullHp
    local factorB = -UnitCsv[b.type].profession * 10000000 + b.fullHp
    return factorA > factorB
  end)
  local frontData = UnitCsv[heroData[1].type]
  local distance = ProfessionCsv[frontData.profession].maxAtkDis
  local count = 1
  local forbiddenPlayer = 0
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
    if self.carbonBuff then
      for _, buffId in ipairs(self.carbonBuff) do
        player:addBuff({buffId = buffId, releaser = player})
      end
    end
    if not player.magicValue or player.magicValue == 0 then
    end
  end
  if 0 < forbiddenPlayer then
    local content = display.newSprite("ui/carbon/travel/visit_tip.png"):pos(display.cx, display.height - 50):addTo(self.uiLayer):hide()
    display.newSprite("ui/battle/forbidden.png"):pos(35, 25):addTo(content)
    display.newTTFLabel({
      text = "资源不足，食灵无力战斗，建议撤退",
      size = 22
    }):enableOutline(UIHelper.hex2rgb("#000000"), 2):pos(225, 26):addTo(content)
    self.forbiddenTip = content
  end
  self.battleLogic:initStar()
end

function PveBattleLayer:loadTMXMapData()
  self.viewNode = cc.ParallaxNode:create()
  self:addChild(self.viewNode, -2)
  self:parseTmxMap(self.carbonData.mapRes .. "/map.tmx", self.viewNode, -self.carbonData.mapOffset)
  if self.mapPlugin then
    self:loadPlugin()
  end
  self.viewBeginXPosition = 0
end

function PveBattleLayer:updateMaxXposByPhase()
  local xPos = {
    [1] = BATTLE_PHASE_LENGTH_1,
    [2] = BATTLE_PHASE_LENGTH_2,
    [3] = BATTLE_PHASE_LENGTH_3,
    [4] = BATTLE_PHASE_LENGTH_4,
    [5] = BATTLE_PHASE_LENGTH_5
  }
  self.viewEndXPosition = xPos[self.currentPhase]
end

function PveBattleLayer:enterNextPhase()
  self:updateMaxXposByPhase()
  self.battleLogic:updateMoveRange(self.viewBeginXPosition + 50, self.viewEndXPosition - 50)
  local time = table.values(self.sceneCsv[self.currentPhase])[1].time or 0
  self.battleLogic:reset({
    currentPhase = self.currentPhase,
    spaceTime = time
  })
end

function PveBattleLayer:loadPhaseEnemys()
  self.enemyHasLoaded = true
  local enemys = {}
  local allEnemys = table.values(self.sceneCsv[self.currentPhase])
  table.sort(allEnemys, function(a, b)
    return a.id < b.id
  end)
  for idx, csvData in ipairs(allEnemys) do
    local enemy = self:packCsvPlayer(csvData)
    enemy.side = SIDE_RIGHT
    enemy.id = csvData.id
    enemy.zorder = csvData.zorder
    enemy.index = self.battleLogic:nextPlayerIdx(SIDE_RIGHT)
    enemy.xPos = csvData.xOffset * 100
    for attr, _ in pairs(AttsEnum) do
      if enemy[attr] then
        enemy[attr] = enemy[attr] * (1 + globalCsv.eatEnergyToAttr * self.energy / 10)
      end
    end
    table.insert(self.enemys, enemy)
    table.insert(enemys, enemy)
  end
  local tastes = {}
  if game.role.majorGuideStep == 11 then
    tastes = {2}
  end
  
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
  
  for _, enemy in ipairs(enemys) do
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

function PveBattleLayer:onPlayerDead(player)
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

function PveBattleLayer:step(dt)
  self:baseStep(dt)
  for _, event in ipairs(self.frameEvents) do
    event:update(dt)
  end
  if not self.enemyHasLoaded then
    self:loadPhaseEnemys()
  end
end

function PveBattleLayer:showView()
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

function PveBattleLayer:checkGuide()
  if game.role.majorGuideStep == 11 then
    game.role.minorGuideStep = 12
    NewGuideLayer.new({
      step = 11,
      callback = function()
        self:resume()
        NewGuideLayer.new({step = 11})
        scheduler.performWithDelayGlobal(function()
          self:pause()
        end, 2)
      end
    })
    scheduler.performWithDelayGlobal(function()
      self:pause()
    end, 3.9)
  end
end

return PveBattleLayer
