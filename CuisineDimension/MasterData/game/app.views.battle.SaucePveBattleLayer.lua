local UnitCsv = require("csvdata.unit")
local ProfessionCsv = require("csvdata.profession")
local ChapterBattleCsv = require("csvdata.sauce_battle")
local Battle = require("logical.battle.Battle")
local BaseBattleLayer = import(".BaseBattleLayer")
local SkillBar = import(".SkillBar")
local TasteBar = import(".TasteBar")
local SaucePveBattleLayer = class("SaucePveBattleLayer", BaseBattleLayer)
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

function SaucePveBattleLayer:ctor(params)
  params = params or {}
  local bossId = params.bossId
  local special = (json.decode(game.role.sauceBossInfo or "[]") or {}).special
  self.leftInfo = params.leftInfo
  self.format = params.format
  self.carbonData = ChapterBattleCsv[1][bossId]
  self.realData = special and special.cur == bossId and ChapterBattleCsv[special.to][bossId] or self.carbonData
  self.sceneCsv = require(self.realData.scene)
  if self.carbonData.mapPlugin ~= "" then
    self.mapPlugin = require(self.carbonData.mapPlugin)
  end
  self.currentPhase = 1
  self.totalPhase = table.nums(self.sceneCsv)
  BaseBattleLayer.ctor(self, params)
end

function SaucePveBattleLayer:__init()
  game:playMusic(self.carbonData.bgm)
  self.enemyHasLoaded = false
  self.enemyDead = 0
  self.frameEvents = {}
  self.battleLogic = Battle:create({
    totalPhase = self.totalPhase,
    battleType = BattleType.PvE
  })
  self:loadTMXMapData()
  self.skillBar = SkillBar:create({
    formatEffect = self.leftInfo.formatEffect[0],
    sauceBattle = true
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
      local timeBg = display.newSprite("ui/battle/pvp_time.png"):pos(display.cx, display.height - 20):addTo(self.uiLayer)
      self.timeLabel = display.newTTFLabel({
        text = "00:00",
        size = 30,
        color = UIHelper.hex2rgb("a5f723")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(88, 20):addTo(timeBg)
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

function SaucePveBattleLayer:sendGameEndRequest(starNum)
  local passTime = math.ceil(self.battleLogic:getTime())
  
  local function backHome()
    game:enterScene("MainScene", {
      layer = "carbon",
      selected = 1,
      skipMusic = true
    })
  end
  
  local brokenCount = 0
  local check = {}
  local players = self.battleLogic:getPlayers(SIDE_LEFT)
  for _, value in pairs(self.leftInfo.heros) do
    local had = false
    for _, heroInfo in pairs(players) do
      if value.id == heroInfo.id then
        had = true
        if heroInfo.hp * 100 / value.fullHp <= 30 then
          brokenCount = brokenCount + 1
        end
        break
      end
    end
    if not had then
      brokenCount = brokenCount + 1
    end
    check[value.id] = {
      battleValue = tonumber(value.__battleValue),
      fullHp = value.fullHp,
      atk = value.atk
    }
  end
  
  local function realSend()
    local sendGameInfo
    
    function sendGameInfo()
      NetManager:removeEventListenersByEvent("networkLogin")
      NetManager:addEventListener("networkLogin", function()
        sendGameInfo()
      end)
      game:sendData(actionCodes.Sauce_bossEndGameRpc, MsgPack.pack({
        passTime = self.battleLogic:getTime(),
        starNum = starNum,
        check = check,
        key = (json.decode(game.role.sauceBossInfo or "[]") or {}).key,
        bossId = self.carbonData.id,
        scoreInfo = {hurt = brokenCount, time = passTime},
        checkEnemy = self:getEnemyBattleValue(self.enemys)
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Sauce_bossEndGameRpc, function(event)
        UIHelper.removeWaiting()
        NetManager:removeEventListenersByEvent("networkLogin")
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({
          items = msg.dropItems,
          callback = function()
            backHome()
          end
        })
      end)
    end
    
    sendGameInfo()
  end
  
  local gift = ""
  local curStar = 0
  if (json.decode(game.role.sauceBossInfo or "[]") or {}).special and special == self.carbonData.id and starNum <= 0 then
  elseif 0 < starNum then
    if special then
      gift = self.carbonData.specialGift
    else
      local endTime = passTime + (globalCsv.timePunish[brokenCount] or globalCsv.timePunish[5])
      for index, range in pairs(globalCsv.battleTime) do
        if endTime > range[1] and endTime <= range[2] then
          gift = self.carbonData["repeatGift" .. index]
          curStar = 4 - index
          break
        end
      end
    end
  else
    gift = ""
  end
  game:createView("sauce.SauceBattleResultLayer", {
    starNum = curStar,
    passTime = passTime,
    brokenCount = brokenCount,
    format = self.format,
    gift = gift,
    homeBack = backHome,
    sendBack = realSend
  })
end

function SaucePveBattleLayer:initLeftInfo()
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
  local buffHero = game.role:getBuffHero()
  local count = 1
  for index, info in ipairs(heroData) do
    info.zorder = index
    info.skillBar = self.skillBar
    if buffHero.heros[info.realType] then
      for attr, mult in pairs(buffHero.buff) do
        if info[attr] then
          info[attr] = info[attr] * mult
        end
      end
    end
    info.fullHp = info.hp
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
    self.skillBar:addPlayer(player)
  end
  self.battleLogic:initStar()
end

function SaucePveBattleLayer:loadTMXMapData()
  self.viewNode = cc.ParallaxNode:create()
  self:addChild(self.viewNode, -2)
  self:parseTmxMap(self.carbonData.mapRes .. "/map.tmx", self.viewNode, -self.carbonData.mapOffset)
  if self.mapPlugin then
    self:loadPlugin()
  end
  self.viewBeginXPosition = 0
  self.viewEndXPosition = BATTLE_PHASE_LENGTH_1
end

function SaucePveBattleLayer:enterNextPhase()
  self.battleLogic:updateMoveRange(self.viewBeginXPosition + 50, self.viewEndXPosition - 50)
  self.battleLogic:reset({
    currentPhase = self.currentPhase
  })
end

function SaucePveBattleLayer:loadPhaseEnemys()
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

function SaucePveBattleLayer:onPlayerDead(player)
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

function SaucePveBattleLayer:step(dt)
  self:baseStep(dt)
  for _, event in ipairs(self.frameEvents) do
    event:update(dt)
  end
  if not self.enemyHasLoaded then
    self:loadPhaseEnemys()
  end
  if self.battleLogic:gameOver() then
    self.timeLabel:setString(UIHelper.getTimeStr(math.ceil(self.battleLogic:getTime()), true))
    return
  end
  if not self.timeLabel then
    return
  end
  self.timeLabel:setString(UIHelper.getTimeStr(math.ceil(self.battleLogic:getTime()), true))
end

function SaucePveBattleLayer:showView()
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

return SaucePveBattleLayer
