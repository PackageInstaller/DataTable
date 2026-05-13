local UnitCsv = require("csvdata.unit")
local ProfessionCsv = require("csvdata.profession")
local TowerBattleCsv = require("csvdata.tower_battle")
local TowerMonsterCsv = require("csvdata.tower_monster")
local TowerBackupCsv = require("csvdata.tower_backup")
local TowerBossCsv = require("csvdata.tower_boss")
local TowerAICsv = require("csvdata.tower_ai")
local Battle = require("logical.battle.Battle")
local BaseBattleLayer = import(".BaseBattleLayer")
local SkillBar = import(".SkillBar")
local AutoSkillBar = import(".AutoSkillBar")
local TasteBar = import(".TasteBar")
local TowerBattleLayer = class("TowerBattleLayer", BaseBattleLayer)
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

function TowerBattleLayer:ctor(params)
  params = params or {}
  self.floorId = params.floorId
  self.floorInfo = params.floorInfo
  self.carbonData = TowerBattleCsv[self.floorId]
  if self.floorInfo.type == 1 then
    self.monsterId = self.floorInfo.id
  end
  if self.floorInfo.type == 2 then
    self.monsterId = tonumber(self.carbonData.monsterLib)
  end
  if self.floorInfo.type == 3 then
    local backup = self.floorInfo.backup
    if backup then
      self.monsterId = TowerBackupCsv[backup].monsterID
    else
      local sceneData = {}
      local member = json.decode(self.floorInfo.member)
      for slot = 1, 5 do
        local hero = member.formatData[tostring(slot)]
        if hero then
          local aiSet = TowerAICsv[hero.type]
          hero.skillOrder = nil
          table.merge(hero, aiSet)
          hero.unitType = hero.type
          hero.skillInfo = {
            blockLv = self.carbonData.blockLv,
            specialLv = self.carbonData.specialLv
          }
          table.insert(sceneData, hero)
        end
      end
      self.sceneCsv = {sceneData}
    end
  end
  if self.floorInfo.type == 4 then
    self.monsterId = TowerBossCsv[self.floorInfo.id].monsterId
  end
  if self.monsterId then
    self.monsterData = TowerMonsterCsv[self.monsterId]
    self.sceneCsv = require(self.monsterData.scene)
  end
  self.leftInfo = params.leftInfo
  self.currentPhase = 1
  self.totalPhase = table.nums(self.sceneCsv)
  if self.carbonData.mapPlugin ~= "" then
    self.mapPlugin = require(self.carbonData.mapPlugin)
  end
  BaseBattleLayer.ctor(self, params)
end

function TowerBattleLayer:__init()
  game:playMusic(2)
  self.enemyHasLoaded = false
  self.enemyDead = 0
  self.frameEvents = {}
  self.battleLogic = Battle:create({
    totalPhase = self.totalPhase,
    battleType = BattleType.PvE
  })
  self:loadTMXMapData()
  self.skillBar = SkillBar:create({
    formatEffect = self.leftInfo.formatEffect[0]
  }):pos(display.width, 0):addTo(self.uiLayer):hide()
  self.tasteBar = TasteBar:create({
    battle = self.battleLogic
  }):addTo(self.uiLayer):hide()
  self.autoSkillBar = AutoSkillBar:create({
    level = self.carbonData.battleLevel
  })
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
  table.insert(self.frameEvents, self.autoSkillBar)
  for _, _player in ipairs(self.battleLogic:getPlayers(SIDE_LEFT)) do
    _player.displayNode:hide()
  end
  for _, _player in ipairs(self.battleLogic:getPlayers(SIDE_RIGHT)) do
    _player.displayNode:hide()
  end
  self.leftAngle:hide()
  self.rightAngle:hide()
  self.btnPause:setTouchEnabled(false)
  self.btnExit:setTouchEnabled(false)
  
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
    end, sp.EventType.ANIMATION_END)
  end
  
  enterBattle()
end

function TowerBattleLayer:sendGameEndRequest(starNum)
  local info = {}
  local check = {}
  local players = self.battleLogic:getPlayers(SIDE_LEFT)
  for _, value in pairs(self.leftInfo.heros) do
    local hp = 0
    for _, heroInfo in pairs(players) do
      if value.id == heroInfo.id then
        hp = heroInfo.hp
      end
    end
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
    game:sendData(actionCodes.Tower_battleEndRpc, MsgPack.pack({
      passTime = self.battleLogic:getTime(),
      starNum = starNum,
      info = info,
      key = game.role.__battleKey,
      check = check,
      checkEnemy = self:getEnemyBattleValue(self.enemys)
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Tower_battleEndRpc, function(event)
      UIHelper.removeWaiting()
      NetManager:removeEventListenersByEvent("networkLogin")
      local msg = MsgPack.unpack(event.data)
      msg.starNum = starNum
      msg.floorId = self.floorId
      msg.win = 0 < starNum
      game:createView("tower.TowerResultLayer", msg)
    end)
  end
  
  sendGameInfo()
end

function TowerBattleLayer:initLeftInfo()
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
      self:showSpecialSkill(player, event.skillId)
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

function TowerBattleLayer:loadTMXMapData()
  self.viewNode = cc.ParallaxNode:create()
  self:addChild(self.viewNode, -2)
  self:parseTmxMap(self.carbonData.mapRes .. "/map.tmx", self.viewNode, -self.carbonData.mapOffset)
  if self.mapPlugin then
    self:loadPlugin()
  end
  self.viewBeginXPosition = 0
  self.viewEndXPosition = BATTLE_PHASE_LENGTH_1
end

function TowerBattleLayer:enterNextPhase()
  self.battleLogic:updateMoveRange(self.viewBeginXPosition + 50, self.viewEndXPosition - 50)
  self.battleLogic:reset({
    currentPhase = self.currentPhase
  })
end

function TowerBattleLayer:loadPhaseEnemys()
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
    enemy.quality = csvData.quality
    enemy.dress = csvData.dress
    enemy.skillInfo = csvData.skillInfo
    table.insert(self.enemys, enemy)
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
  
  for _, enemyData in ipairs(self.enemys) do
    if enemyData.randomTaste > 0 then
      enemyData.taste = randomTaste()
    end
    local enemy = self:addPlayer(enemyData, RIGHT_PLAYER_ORDER + enemyData.zorder)
    enemy:addEventListener("playerDead", function(event)
      self:onPlayerDead(enemy)
    end)
    if enemyData.leader then
      enemy:addEventListener("releaseSpecial", function(event)
        self:showBossSpecial(enemy, event.skillId)
      end)
    end
    if enemyData.skillInfo then
      enemy.skillBar = self.autoSkillBar
      self.autoSkillBar:addPlayer(enemy)
    end
  end
end

function TowerBattleLayer:onPlayerDead(player)
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

function TowerBattleLayer:step(dt)
  self:baseStep(dt)
  for _, event in ipairs(self.frameEvents) do
    event:update(dt)
  end
  if not self.enemyHasLoaded then
    self:loadPhaseEnemys()
  end
end

function TowerBattleLayer:showView()
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

return TowerBattleLayer
