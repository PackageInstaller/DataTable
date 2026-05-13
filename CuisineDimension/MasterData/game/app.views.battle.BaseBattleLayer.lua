local SpritePlayer = import(".SpritePlayer")
local skillSet = require("csvdata.skill")
local skillPassiveSet = require("csvdata.skill_passive")
local unitCsv = require("csvdata.unit")
local CutinRes = "ui/battle/cutin/"
local fileUtils = cc.FileUtils:getInstance()
local ccScheduler = cc.Director:getInstance():getScheduler()
local BaseBattleLayer = class("BaseBattleLayer", function()
  return display.newLayer()
end)

function BaseBattleLayer:ctor(params)
  self.runState = "run"
  self.deadPlayers = {}
  self.uiLoadStep = 0
  self.dropItems = {}
  self.frameEvents = {}
  self.brokenEffect = {}
  self.uiLayer = display.newNode():addTo(self)
  self.handlers = {}
end

function BaseBattleLayer:fitForiPhoneX()
  if UIHelper.isiPhoneX() then
    self.leftAngle:setPositionX(self.leftAngle:getPositionX() - UIHelper.getMoveXForX())
    self.rightAngle:setPositionX(self.rightAngle:getPositionX() + UIHelper.getMoveXForX())
    if self.skillBar then
      self.skillBar:setPositionX(self.skillBar:getPositionX() + UIHelper.getMoveXForX())
    end
    if self.tasteBar then
      self.tasteBar:setPositionX(self.tasteBar:getPositionX() - UIHelper.getMoveXForX())
    end
  end
end

function BaseBattleLayer:addPlayer(playerInfo, zorder)
  local player = SpritePlayer:create(playerInfo)
  player.map = self.map
  player.mapLayers = self.viewNode
  player.layer = self
  self.battleLogic:addPlayer(player)
  player.displayNode:addTo(self.map, zorder)
  player:onUpdatePosition()
  return player
end

function BaseBattleLayer:parseTmxMap(tmxMap, viewNode, xOffset, scale)
  xOffset = xOffset or 0
  local mapData = ccexp.TMXTiledMap:create(tmxMap)
  
  local function transferLayer(layerName, ratio)
    local layer = mapData:getLayer(layerName)
    if not layer or tolua.isnull(layer) then
      return
    end
    if scale then
      layer:setScaleX(scale)
    end
    layer:setName(layerName)
    layer:retain()
    layer:removeSelf()
    viewNode:addChild(layer, layer:getLocalZOrder(), ratio, cc.p(layer:getPositionX() + xOffset, layer:getPositionY()))
    layer:release()
    return layer
  end
  
  self.map = display.newLayer()
  self.map:size(mapData:getContentSize().width, mapData:getContentSize().height)
  viewNode:addChild(self.map, mapData:getLayer("floor"):getLocalZOrder() + 1, cc.p(1, 1), cc.p(0, 0))
  self.sceneSkillLayer = display.newLayer():addTo(self.map, MAP_ABOVE_ORDER + 1):name("sceneSkillLayer")
  self.underNode = display.newLayer()
  viewNode:addChild(self.underNode, mapData:getLayer("floor"):getLocalZOrder(), cc.p(1, 1), cc.p(0, 0))
  self.underLayer = display.newLayer():addTo(self.underNode)
  local layerMeta = {
    floor = 1,
    jinjing = 1.5,
    zhongjing = 0.5,
    yuanjing = 0.2
  }
  for layerName, ratio in pairs(layerMeta) do
    transferLayer(layerName, {x = ratio, y = 1})
  end
  local yinghuo = cc.ParticleSystemQuad:create("ui/battle/yinghuo.plist")
  yinghuo:setPositionType(cc.POSITION_TYPE_RELATIVE)
  yinghuo:pos(display.cx, -20):addTo(self.uiLayer, -1)
end

function BaseBattleLayer:loadPlugin()
  local layerNames = {
    [1] = "floor",
    [2] = "jinjing",
    [3] = "zhongjing",
    [4] = "yuanjing"
  }
  for _, data in ipairs(self.mapPlugin) do
    local spine = UIHelper.createSpineNodeByRes(data.name)
    spine:pos(data.xOffset, data.yOffset)
    spine:addTo(self.viewNode:getChildByName(layerNames[data.mapOrder]))
    spine:setAnimation(0, "special", true)
  end
end

function BaseBattleLayer:packCsvPlayer(csvData)
  local unitData = unitCsv[csvData.unitType]
  if not unitData then
    return
  end
  local equipPower = self.bossSet and self.bossSet.equipPower or self.carbonData.equipPower
  local battlePower = self.bossSet and self.bossSet.battlePower or self.carbonData.battlePower
  local battleLevel = self.bossSet and self.bossSet.bossLevel or self.carbonData.battleLevel
  
  local function calAttrResult(name)
    return ((unitData[name] + (battleLevel - 1) * unitData[name .. "Growth"]) * battlePower + unitData[name] * equipPower) * csvData[name] / 10000
  end
  
  local function calSecondAttr(name)
    return 0 < csvData[name] and csvData[name] or nil
  end
  
  local atkFactor = self.weatherFactor and 1.5 or 1
  local enemy = {}
  enemy.side = SIDE_RIGHT
  enemy.id = csvData.id
  enemy.leader = csvData.beBoss and csvData.beBoss == 1 or false
  enemy.type = csvData.unitType
  enemy.level = self.carbonData.battleLevel
  enemy.hp = calAttrResult("hp")
  enemy.atk = calAttrResult("atk") * atkFactor
  enemy.phyDef = calAttrResult("phyDef")
  enemy.hurt = 0
  enemy.miss = calAttrResult("miss")
  enemy.hit = calAttrResult("hit")
  enemy.crit = calSecondAttr("crit")
  enemy.critHurt = calSecondAttr("critHurt")
  enemy.skillInfo = enemy.skillInfo or {}
  enemy.skillInfo.tebao = unitData.tebao + (csvData.tebao or 0)
  enemy.skillInfo.tekang = unitData.tekang + (csvData.tekang or 0)
  enemy.widthScale = csvData.scale
  enemy.scale = unitData.boneRatio * csvData.scale / 100
  enemy.skillOrders = csvData.skillOrder and csvData.skillOrder:toArray(" ", true)
  enemy.attackQueue = csvData.attackQueue and csvData.attackQueue:toArray(" ", true)
  enemy.randomTaste = csvData.randomTaste or 0
  if 0 > enemy.randomTaste then
    enemy.taste = math.abs(enemy.randomTaste)
  end
  enemy.battleTag = csvData.battleTag or 0
  enemy.AI = tonumber(csvData.AI)
  return enemy
end

function BaseBattleLayer:getEnemyBattleValue(enemys)
  enemys = enemys or {}
  local result = {}
  for _, enemy in ipairs(enemys) do
    result[enemy.id] = {
      hp = enemy.hp,
      atk = enemy.atk,
      phyDef = enemy.phyDef
    }
    local battleValue = math.floor(math.pow(enemy.hp * (1 + enemy.phyDef / enemy.atk * 7 / 27) * enemy.atk * (1 + enemy.miss) * enemy.hit * (1 + (enemy.crit or 0) / 1000 * (enemy.critHurt or 0) / 1000), 0.4) / 4)
    result[enemy.id].battleValue = battleValue
  end
  return result
end

function BaseBattleLayer:cancelGame()
  if self.battleLogic:gameOver() then
    return
  end
  self.frameEvents = {}
  self:unscheduleUpdate()
  for index, player in ipairs(self.battleLogic:getPlayers(SIDE_LEFT)) do
    player:playAnimation("idle")
  end
  for index, player in ipairs(self.battleLogic:getPlayers(SIDE_RIGHT)) do
    player:playAnimation("idle")
  end
  self:sendGameEndRequest(0, true)
end

function BaseBattleLayer:gameEndAction(params)
  self.battleLogic:onGameOver()
  self.frameEvents = {}
  local starNum = self.battleLogic:starResult()
  if 0 < starNum then
    for index, player in ipairs(self.battleLogic:getPlayers(SIDE_LEFT)) do
      if player:getState() == "Special" or player:getState() == "Block" then
      elseif player:canDoEvent("idle") then
        player:doEvent("idle")
      end
    end
  end
  for index, player in ipairs(self.battleLogic:getPlayers(SIDE_RIGHT)) do
    if player:getState() == "Special" or player:getState() == "Block" then
    elseif player:canDoEvent("idle") then
      player:doEvent("idle")
    end
  end
  self.uiLayer:runAction(transition.sequence({
    cc.DelayTime:create(2),
    cc.CallFunc:create(function()
      if 0 < starNum then
        for index, player in ipairs(self.battleLogic:getPlayers(SIDE_LEFT)) do
          if player:getState() == "Idle" or player:canDoEvent("idle") then
            player:doEvent("cheer")
          end
        end
      end
      for index, player in ipairs(self.battleLogic:getPlayers(SIDE_RIGHT)) do
        if player:canDoEvent("idle") then
          player:doEvent("idle")
        end
      end
      if 0 < starNum then
        local spine = UIHelper.createSpineNodeByRes("spine/ui/battle/win")
        spine:pos(display.cx, display.cy):addTo(display.getRunningScene())
        spine:setAnimation(0, "special", false)
        spine:registerSpineEventHandler(function(event)
          self:sendGameEndRequest(starNum)
          scheduler.performWithDelayGlobal(function()
            spine:removeSelf()
          end, 0.016666666666666666)
        end, sp.EventType.ANIMATION_END)
      else
        local content = display.newSprite("ui/battle/tip_bg.png"):anch(1, 0.5):pos(0, display.height / 2):addTo(display.getRunningScene())
        local txtpng = 0 < starNum and "txt_win.png" or "txt_lose.png"
        display.newSprite("ui/battle/" .. txtpng):center(content):addTo(content)
        content:runAction(transition.sequence({
          cc.MoveBy:create(0.1, cc.p(display.width, 0)),
          cc.DelayTime:create(2.8),
          cc.MoveBy:create(0.1, cc.p(display.width, 0)),
          cc.CallFunc:create(function()
            self:sendGameEndRequest(starNum)
          end),
          cc.RemoveSelf:create()
        }))
      end
    end)
  }))
end

function BaseBattleLayer:objectInSight(xPos)
  return xPos > math.abs(self.viewNode:getPositionX()) and xPos < math.abs(self.viewNode:getPositionX()) + display.width
end

local screenCenter = cc.p(display.width / 2, BATTLE_Y_POS)

function BaseBattleLayer:calViewPoint()
  local frontestLeft
  for _, player in ipairs(self.battleLogic:getPlayers(SIDE_LEFT)) do
    if player.unit.move > 0 then
      frontestLeft = player
      break
    end
  end
  if not frontestLeft then
    return
  end
  local leftBoundary = 0
  local rightBoudary = self.viewEndXPosition + 50
  local pminX = frontestLeft.xPos - screenCenter.x
  local pmaxX = frontestLeft.xPos + screenCenter.x
  leftBoundary = math.max(pminX, leftBoundary)
  rightBoudary = math.min(pmaxX, rightBoudary)
  local viewNode
  if pminX < leftBoundary then
    viewNode = cc.p(-math.max(leftBoundary, pminX), 0)
  else
    viewNode = cc.p(-math.min(rightBoudary - display.width, pminX), 0)
  end
  return viewNode
end

function BaseBattleLayer:updateViewPoint()
  if self.cacheViewPos then
    return
  end
  local viewPoint = self:calViewPoint()
  if viewPoint then
    self.viewNode:setPositionX(viewPoint.x)
    self.underLayer:pos(-self.viewNode:getPositionX(), 0)
    self.sceneSkillLayer:pos(-self.viewNode:getPositionX(), 0)
    local loadMask = self.map:getChildByTag(BATTLE_MASK_TAG)
    if loadMask then
      loadMask:pos(-self.viewNode:getPositionX(), 0)
      if UIHelper.isiPhoneX() then
        UIHelper.fitForiPhoneX(loadMask, true)
      end
    end
  end
end

function BaseBattleLayer:baseStep(dt)
  self:updateViewPoint()
end

function BaseBattleLayer:showSpecialSkill(player, skillId)
  if UserData.skipSkillAnima == 1 then
    return
  end
  game:playMusic(1601)
  self:pause(true)
  self.cacheViewPos = cc.p(self.viewNode:getPositionX(), 0)
  local xPos = self.viewNode:getPositionX()
  local offset = player.xPos - display.width * 0.25
  offset = math.max(offset, 0)
  xPos = xPos - offset
  xPos = math.max(xPos, display.width - (self.viewEndXPosition + display.width))
  CommonHelper.playCV(player.unit.type, "specialSkill")
  ccScheduler:setTimeScale(0.75)
  for _, _player in ipairs(self.battleLogic:getPlayers(player.side)) do
    if _player ~= player then
      _player.displayNode:hide()
    end
  end
  for _, _player in ipairs(self.battleLogic:getPlayers(player.otherSide)) do
    _player.displayNode:hide()
  end
  local time1, time2 = 0.1, 0.6
  local mapSize = self.map:getContentSize()
  local mask = display.newScale9Sprite(CutinRes .. "cutin_mask.png", 0, 0, mapSize):anch(0, 0):pos(0, 0):addTo(self.map, player.zorder - 1):opacity(0)
  mask:runAction(transition.sequence({
    cc.FadeTo:create(time1, 190),
    cc.DelayTime:create(time2),
    cc.FadeOut:create(time1),
    cc.CallFunc:create(function()
      self:resume(true)
      ccScheduler:setTimeScale(1)
      for _, _player in ipairs(self.battleLogic:getPlayers(player.side)) do
        _player.displayNode:show()
      end
      for _, _player in ipairs(self.battleLogic:getPlayers(player.otherSide)) do
        _player.displayNode:show()
      end
      if self.cacheViewPos then
        self.viewNode:pos(self.cacheViewPos.x, self.cacheViewPos.y)
      end
      self.cacheViewPos = nil
    end)
  }))
  self.viewNode:runAction(transition.sequence({
    cc.Spawn:create({
      cc.ScaleTo:create(time1, 1.2),
      cc.MoveTo:create(time1, cc.p(xPos, 0))
    }),
    cc.DelayTime:create(time2),
    cc.Spawn:create({
      cc.ScaleTo:create(time1, 1),
      cc.MoveTo:create(time1, self.cacheViewPos)
    })
  }))
  local frame1 = display.newSprite(CutinRes .. "cutin_frame1.png")
  frame1:pos(display.width - 300, display.cy):addTo(self.uiLayer):opacity(0)
  frame1:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
  frame1:runAction(transition.sequence({
    cc.Spawn:create({
      cc.FadeIn:create(time1),
      cc.MoveBy:create(time1, cc.p(120, 0))
    }),
    cc.MoveBy:create(time2, cc.p(40, 0)),
    cc.Spawn:create({
      cc.FadeOut:create(time1),
      cc.MoveBy:create(time1, cc.p(120, 0))
    }),
    cc.RemoveSelf:create()
  }))
  local frame2 = display.newSprite(CutinRes .. "cutin_frame2.png")
  frame2:pos(display.cx, display.height - 170):addTo(self.uiLayer):opacity(0)
  frame2:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
  frame2:runAction(transition.sequence({
    cc.Spawn:create({
      cc.FadeIn:create(time1),
      cc.MoveBy:create(time1, cc.p(0, 70))
    }),
    cc.MoveBy:create(time2, cc.p(0, 30)),
    cc.Spawn:create({
      cc.FadeOut:create(time1),
      cc.MoveBy:create(time1, cc.p(0, 70))
    }),
    cc.RemoveSelf:create()
  }))
  local skillData = skillSet[skillId]
  display.newTTFLabel({
    text = skillData.name,
    size = 60,
    color = UIHelper.hex2rgb("#000000")
  }):pos(300, display.height - 75):addTo(self.uiLayer):opacity(0):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):runAction(transition.sequence({
    cc.Spawn:create({
      cc.FadeIn:create(time1),
      cc.MoveBy:create(time1, cc.p(-90, 0))
    }),
    cc.MoveBy:create(time2, cc.p(-40, 0)),
    cc.Spawn:create({
      cc.FadeOut:create(time1),
      cc.MoveBy:create(time1, cc.p(-90, 0))
    }),
    cc.RemoveSelf:create()
  }))
  HeroBigCard.new({
    type = player.type,
    quality = player.quality
  }):anch(1, 0.5):pos(display.width + 20, display.cy + 20):addTo(self.uiLayer):opacity(0):runAction(transition.sequence({
    cc.Spawn:create({
      cc.FadeIn:create(time1),
      cc.MoveBy:create(time1, cc.p(0, -90))
    }),
    cc.MoveBy:create(time2, cc.p(0, -40)),
    cc.Spawn:create({
      cc.FadeOut:create(time1),
      cc.MoveBy:create(time1, cc.p(0, -90))
    }),
    cc.RemoveSelf:create()
  }))
  local xPos, yPos = player.displayNode:getPosition()
  local upEffect = UIHelper.createSpineNodeByRes("spineEff/sp_juqi_qian")
  upEffect:pos(xPos, yPos + player.nodeSize.height / 2):addTo(self.map, player.zorder + 1)
  upEffect:setAnimation(0, "special", false)
  upEffect:registerSpineEventHandler(function(event)
    if event.type ~= "end" then
      return
    end
    scheduler.performWithDelayGlobal(function()
      upEffect:removeSelf()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
  local downEffect = UIHelper.createSpineNodeByRes("spineEff/sp_juqi_hou")
  downEffect:pos(xPos, yPos + player.nodeSize.height / 2):addTo(self.map, player.zorder - 1)
  downEffect:setAnimation(0, "special", false)
  downEffect:registerSpineEventHandler(function(event)
    if event.type ~= "end" then
      return
    end
    scheduler.performWithDelayGlobal(function()
      downEffect:removeSelf()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(frame2, true)
    mask:setPositionX(mask:getPositionX() - 125)
  end
end

function BaseBattleLayer:showBossSpecial(player, skillId)
  do return end
  if self.cacheViewPos then
    return
  end
  self:pause()
  self.cacheViewPos = cc.p(self.viewNode:getPosition())
  local xPos = self.viewNode:getPositionX()
  local offset = player.xPos - display.width * 0.75
  offset = math.max(offset, 0)
  xPos = xPos - offset
  xPos = math.max(xPos, display.width - (self.viewEndXPosition + display.width))
  local time1, time2 = 0.23333333333333334, 0.8333333333333334
  local mapSize = self.map:getContentSize()
  display.newScale9Sprite(CutinRes .. "cutin_mask.png", 0, 0, mapSize):anch(0, 0):pos(0, 0):addTo(self.map, player.zorder - 1):opacity(0):runAction(transition.sequence({
    cc.FadeTo:create(time1, 190),
    cc.DelayTime:create(time2),
    cc.FadeOut:create(time1),
    cc.CallFunc:create(function()
      self:resume()
      ccScheduler:setTimeScale(1)
      for _, _player in ipairs(self.battleLogic:getPlayers(player.side)) do
        _player.displayNode:show()
      end
      for _, _player in ipairs(self.battleLogic:getPlayers(player.otherSide)) do
        _player.displayNode:show()
      end
      self.viewNode:pos(self.cacheViewPos.x, self.cacheViewPos.y)
      self.cacheViewPos = nil
    end)
  }))
  self.viewNode:runAction(transition.sequence({
    cc.Spawn:create({
      cc.ScaleTo:create(time1, 1.2),
      cc.MoveTo:create(time1, cc.p(xPos, 0))
    }),
    cc.DelayTime:create(time2),
    cc.Spawn:create({
      cc.ScaleTo:create(time1, 1),
      cc.MoveTo:create(time1, self.cacheViewPos)
    })
  }))
  local size = cc.size(690, 760)
  local mask = UIHelper.newMask({size = size})
  mask:anch(0.5, 0.5):pos(display.cx, display.cy - 90):addTo(self.uiLayer):opacity(0)
  mask:runAction(transition.sequence({
    cc.MoveBy:create(time1, cc.p(0, 90)),
    cc.MoveBy:create(time2, cc.p(0, 30)),
    cc.ScaleTo:create(time1, 1.7),
    cc.RemoveSelf:create()
  }))
  local spine = UIHelper.createHeroCard(player.type, {}):pos(size.width / 2, 0):addTo(mask)
  spine:runAction(transition.sequence({
    cc.FadeIn:create(time1),
    cc.DelayTime:create(time2),
    cc.FadeOut:create(time1)
  }))
  local ccScheduler = cc.Director:getInstance():getScheduler()
  ccScheduler:setTimeScale(0.75)
  for _, _player in ipairs(self.battleLogic:getPlayers(player.side)) do
    if _player ~= player then
      _player.displayNode:hide()
    end
  end
  for _, _player in ipairs(self.battleLogic:getPlayers(player.otherSide)) do
    _player.displayNode:hide()
  end
end

function BaseBattleLayer:showBlockSkill(player, skillId)
  if self.runState == "stop" then
    return
  end
  game:playMusic(1602)
  
  local function dispose(cutin)
    cutin:stopAllActions()
    cutin:runAction(transition.sequence({
      cc.Spawn:create({
        cc.MoveBy:create(0.1, cc.p(0, 55)),
        cc.FadeOut:create(0.25)
      }),
      cc.RemoveSelf:create()
    }))
  end
  
  if not tolua.isnull(self.blockCutin) then
    dispose(self.blockCutin)
  end
  local skillData = skillPassiveSet[skillId]
  local cutin = display.newSprite(UIHelper.getCardRes("cutin", player.unit.type, nil, player.quality)):anch(1, 0):pos(0, 400):addTo(self.uiLayer)
  if UIHelper.isiPhoneX() then
    cutin:setPositionX(cutin:getPositionX() - 125)
  end
  cutin:runAction(transition.sequence({
    cc.MoveBy:create(0.1, cc.p(cutin:getContentSize().width, 0)),
    cc.DelayTime:create(0.5),
    cc.CallFunc:create(function()
      dispose(cutin)
      self.blockCutin = nil
    end)
  }))
  local mask = display.newSprite(CutinRes .. "small_cutin_mask.png"):center(cutin):addTo(cutin):opacity(0):runAction(transition.sequence({
    cc.DelayTime:create(0.1),
    cc.FadeIn:create(0.03333333333333333),
    cc.DelayTime:create(0.03333333333333333),
    cc.FadeOut:create(0.03333333333333333),
    cc.RemoveSelf:create()
  }))
  self.blockCutin = cutin
end

function BaseBattleLayer:showBrokenCard(player)
  if self.battleLogic:gameOver() then
    return
  end
  if #self.brokenEffect == 0 then
    self:resume(true)
    return
  end
  local unitType = self.brokenEffect[1]
  self:pause(true)
  local unitSet = unitCsv[unitType]
  CommonHelper.stopCV()
  CommonHelper.playCV(unitType, "broken")
  display.newSprite(UIHelper.getCardRes("normal", unitType, nil, player.quality)):pos(338, 180):scale(0.6):addTo(self, MAP_ABOVE_ORDER * 2):runAction(transition.sequence({
    cc.ScaleTo:create(0.1, 1),
    cc.RemoveSelf:create()
  }))
  local card = display.newSprite(UIHelper.getCardRes("normal", unitType, true, player.quality)):pos(338, 180):addTo(self, MAP_ABOVE_ORDER * 2):hide()
  card:runAction(transition.sequence({
    cc.DelayTime:create(0.1),
    cc.Show:create(),
    cc.TintTo:create(0.1, 255, 0, 0),
    cc.CallFunc:create(function()
      card:setColor(display.COLOR_WHITE)
    end),
    cc.DelayTime:create(0.8),
    cc.Spawn:create({
      cc.MoveBy:create(0.4, cc.p(-240, 0)),
      cc.FadeOut:create(0.4)
    }),
    cc.RemoveSelf:create(),
    cc.CallFunc:create(function()
      table.remove(self.brokenEffect, 1)
      self:showBrokenCard(player)
    end)
  }))
  display.newSprite(UIHelper.getCardRes("normal", unitType, true, player.quality)):pos(338, 180):addTo(self, MAP_ABOVE_ORDER * 2):hide():opacity(153):runAction(transition.sequence({
    cc.DelayTime:create(0.1),
    cc.Show:create(),
    cc.ScaleTo:create(0.1, 1.2),
    cc.Spawn:create({
      cc.ScaleTo:create(0.4, 1.3),
      cc.FadeOut:create(0.4)
    }),
    cc.RemoveSelf:create()
  }))
end

function BaseBattleLayer:hideAllPlayers()
  self.map:hide()
end

function BaseBattleLayer:showAllPlayers()
  self.map:show()
end

function BaseBattleLayer:pause(shipAnimation)
  self.runState = "stop"
  self.battleLogic:onPause(shipAnimation)
  if self.skillBar then
    self.skillBar:pause()
  end
  if self.autoSkillBar then
    self.autoSkillBar:pause()
  end
  UIHelper.pauseNode(self)
end

function BaseBattleLayer:resume(shipAnimation)
  self.runState = "run"
  self.battleLogic:onResume(shipAnimation)
  if self.skillBar then
    self.skillBar:resume()
  end
  if self.autoSkillBar then
    self.autoSkillBar:resume()
  end
  UIHelper.resumeNode(self)
end

function BaseBattleLayer:onExit()
  if self.battleLogic then
    self.battleLogic:dispose()
  end
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
end

return BaseBattleLayer
