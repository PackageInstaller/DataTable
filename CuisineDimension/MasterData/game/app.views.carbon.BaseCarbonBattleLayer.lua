local BattleRes = "ui/carbon/battle/"
local GlobalRes = "ui/global/"
local MonsterCsv = require("csvdata.monster")
local DialogCsv = require("csvdata.battle_dialog")
local ItemCsv = require("csvdata.item")
local TAG_FLAG = 1
local TAG_ENERGY = 2
local TAG_GUANG = 3
local SKIP_BATTLE = false
local MY_TURN = 1
local ENEMY_TURN = 2
local uiData = {
  csbFile = "ui/carbon/CarbonBattleLayer.csb",
  mask = true,
  widgets = {
    weatherBg = "weatherBg",
    tip_bg = "tip_bg",
    up = "up",
    weatherMask = "weatherBg/weatherMask",
    weatherNow = "weatherBg/weatherNow",
    weatherNext = "weatherBg/weatherNext",
    labelDay = "weatherBg/labelDay",
    weatherLastLab = "weatherBg/weatherLastLab",
    weatherText = "tip_bg/text",
    zoomBg = "zoomBg",
    zoomOut = "zoomBg/zoomOut",
    zoomIn = "zoomBg/zoomIn",
    zoomPoint = "zoomBg/zoomPoint",
    down = "down",
    downP = "downP",
    btnNode = "downP/btnNode",
    btnCancel = "downP/btnCancel",
    cancelBg = "downP/cancelBg",
    angle_1 = "downP/angle_1",
    cancelText = "downP/cancelBg/labelCancel",
    btnInfo = "downP/btnInfo",
    btnEnd = "downP/btnEnd",
    labelPoint = "downP/activeBg/labelPoint",
    labelCancel = "downP/cancelBg/labelCancel",
    labelHour = "downP/timeSlot/labelHour",
    timeSlot = "downP/timeSlot",
    zbInfo = "downP/zbInfo",
    angle_2 = "downP/angle_2",
    activeBg = "downP/activeBg",
    mapNode = "mapNode",
    turnLayer = "turnLayer"
  }
}
local BaseCarbonBattleLayer = class("BaseCarbonBattleLayer", UIBase)

function BaseCarbonBattleLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
  self.handlers = {}
end

function BaseCarbonBattleLayer:getBattleData()
end

function BaseCarbonBattleLayer:getBattleInfo()
end

function BaseCarbonBattleLayer:battleInfoCache(data)
end

function BaseCarbonBattleLayer:showGuide()
end

function BaseCarbonBattleLayer:showResultLayer(params)
end

function BaseCarbonBattleLayer:showExitResultLayer(params)
end

function BaseCarbonBattleLayer:getActionCodes()
end

function BaseCarbonBattleLayer:onCleanup()
  NetManager:removeEventListenersByEvent("networkLogin")
end

local SpeedMultSwitch = true
local SpeedMult = 1.7

function BaseCarbonBattleLayer:getSpeedMult()
  return SpeedMultSwitch and SpeedMult or 1
end

function BaseCarbonBattleLayer:init(params)
  self.carbonId = params.carbonId
  self.modeType = params.modeType
  self.mapData = require(self.carbonData.map)
  self.arrange = {}
  self.zoom = 1
  self.MapMaxZoom = UserData.MapMaxZoom or self.zoom
  self.MapMaxZoom = math.max(math.min(self.carbonData.maxZoom, self.MapMaxZoom), self.carbonData.minZoom)
  self.currentTime = game:nowTime()
  self.curEvents = {}
  self.weatherMusic = {}
  self:initUI()
  self.battleInfo = clone(self:getBattleData())
  if self:battleInfoCache() then
    for key, value in pairs(self:battleInfoCache()) do
      if key ~= "kill" and key ~= "kills" then
        self.battleInfo[key] = value
      end
    end
    if self.battleInfo.moveType == 1 then
      self:showRightPanel(true, true)
    else
      self:showRightPanel(false, true)
    end
    self.lastCamera = self:battleInfoCache().lastCamera
    self.selectPlayerId = self:battleInfoCache().selectPlayerId
    self.lastPlayer = self:battleInfoCache().lastPlayer
    self.curEvents = self:battleInfoCache().events or {}
    self.endResult = self:battleInfoCache().endResult
    self:battleInfoCache(nil, true)
  end
  if game.role.battlePathTemp then
    self.battlePathTemp = game.role.battlePathTemp
    game.role.battlePathTemp = nil
  end
  local chatBtn = UIHelper.extend(ccui.Button:create())
  chatBtn:setCascadeOpacityEnabled(true)
  chatBtn:setImages("ui/home/btns/", {"chat_b.png", "chat_b.png"})
  chatBtn:pos(440, 0):addTo(self.tip_bg)
  chatBtn:setTouchScale()
  chatBtn:setCallback(function()
    game:createView("chat.ChatMainLayer")
  end)
  display.newSprite("ui/home/btns/chat_c.png"):anch(0.5, 0):pos(18, 5):addTo(chatBtn)
  chatBtn:setVisible(game.role.majorGuideStep > MAX_MAJOR_STEP)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.up, true)
    UIHelper.fitForiPhoneX(self.down, true)
    self.weatherBg:setPositionX(self.weatherBg:getPositionX() - UIHelper.getMoveXForX())
    self.tip_bg:setPositionX(self.tip_bg:getPositionX() - UIHelper.getMoveXForX())
    self.zoomBg:setPositionX(self.zoomBg:getPositionX() - UIHelper.getMoveXForX() + 50)
    self.mapNode:setPositionX(self.mapNode:getPositionX() - UIHelper.getMoveXForX())
    self.timeSlot:setPositionX(self.timeSlot:getPositionX() - UIHelper.getMoveXForX() * 2)
    self.cancelBg:setPositionX(self.cancelBg:getPositionX() - UIHelper.getMoveXForX() * 2)
    self.angle_1:setPositionX(self.angle_1:getPositionX() - UIHelper.getMoveXForX() * 2)
    self.btnCancel:setPositionX(self.btnCancel:getPositionX() - UIHelper.getMoveXForX() * 2)
    self.downP:setPositionX(self.downP:getPositionX() + UIHelper.getMoveXForX())
  end
  self:initMap()
  if (self.battleInfo.carbonId or 0) ~= self.carbonId then
    self:onNewGame()
    self:showRightPanel(false, false)
  end
  self:refreshMap()
  self:refreashUI()
  if self.selectPlayerId then
    local playerId = self.selectPlayerId
    self.selectPlayerId = nil
    self:onSelectPlayer(playerId)
  end
  self:resetCamera()
  if self.newGame then
    self:setZoom(self.zoom)
    self:showArrangeTip()
    self:cameraScale()
  elseif self.battleInfo.moveType == 2 then
    self.dragLayer:setTouchEnabled(false)
    self:setZoom(self.carbonData.minZoom)
  else
    if not self.lastCamera then
      for _, data in pairs(self.battleInfo.playerList) do
        local stage = data.stage
        self:setZoom(self.MapMaxZoom)
        local xpos, ypos = self:convertPos(stage)
        self.lastCamera = {
          zoom = self.MapMaxZoom,
          xpos = xpos,
          ypos = ypos
        }
        break
      end
    end
    self:resetCamera()
    self:onLeftTurn(true)
  end
  self.refreshHandler = scheduler.scheduleGlobal(function()
    self:isPassTime()
  end, 60)
  self:isPassTime()
  self.eventHandlers = {
    move = handler(self, self.onMove),
    occupy = handler(self, self.onOccupy),
    fly = handler(self, self.onFly),
    addenemy = handler(self, self.onAddEnemy),
    delenemy = handler(self, self.onDelEnemy),
    battle = handler(self, self.onBattle),
    resetLeft = handler(self, self.onResetLeft),
    energy = handler(self, self.onEnergy),
    stageEnergy = handler(self, self.onStageEnergy),
    award = handler(self, self.onAward),
    movePoint = handler(self, self.onMovePoint),
    material = handler(self, self.onMaterial),
    delplayer = handler(self, self.onDelplayer),
    select = handler(self, self.onSelect),
    map = handler(self, self.onMap),
    changeStage = handler(self, self.onChangeStage),
    weather = handler(self, self.onWeather),
    gameover = handler(self, self.onGameOver),
    box = handler(self, self.onBox),
    cure = handler(self, self.onCure),
    attr = handler(self, self.onAttr)
  }
end

function BaseCarbonBattleLayer:eventHandler()
  self.playerMove = false
  if #self.curEvents == 0 then
    self:onAutoMove()
    return
  end
  local event = self.curEvents[1]
  table.remove(self.curEvents, 1)
  local handler = self.eventHandlers[event.type]
  if handler then
    handler(event)
  else
    self:eventHandler()
  end
  self.behaviourLayer:removeAllChildren()
end

function BaseCarbonBattleLayer:onAward(event)
  self:eventHandler()
end

function BaseCarbonBattleLayer:onMovePoint(event)
  self.battleInfo.movePoint = event.param1
  self:refreashUI()
  self:eventHandler()
  if self.selectPlayerId then
    local player = self:getPlayerData(self.selectPlayerId)
    if player then
      self:showMoveAble(player.stage)
    end
  end
end

function BaseCarbonBattleLayer:onMaterial(event)
  local player
  for _, _player in ipairs(self.battleInfo.playerList) do
    if _player.format == event.param1 then
      player = _player
      break
    end
  end
  if player and player.display then
    self:updateMaterialBar(player)
    local doc = ""
    if event.param2 and event.param2 > 0 then
      doc = doc .. string.format("食油-%d ", event.param2)
    end
    if event.param3 and 0 < event.param3 then
      doc = doc .. string.format("魔力-%d ", event.param3)
    end
    if doc ~= "" then
      display.newTTFLabel({
        text = doc,
        size = 32,
        color = UIHelper.hex2rgb("#ffffff")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(0, 140):addTo(player.display):runAction(transition.sequence({
        cc.DelayTime:create(0.5),
        cc.Spawn:create({
          cc.MoveBy:create(0.75, cc.p(0, 50)),
          cc.FadeOut:create(0.75)
        }),
        cc.RemoveSelf:create()
      }))
    end
  end
  self:eventHandler()
end

function BaseCarbonBattleLayer:onDelplayer(event)
  local player = self:getPlayerData(event.param1)
  if player.display then
    player.display:removeSelf()
  end
  self.lastPlayer = player.format
  if self.selectPlayerId == event.param1 then
    self.selectPlayerId = nil
  end
  local stageInfo = self.mapInfo[player.stage]
  stageInfo.playerId = nil
  for index, info in ipairs(self.battleInfo.playerList) do
    if info.id == player.id then
      table.remove(self.battleInfo.playerList, index)
      break
    end
  end
  self:eventHandler()
end

function BaseCarbonBattleLayer:onMap(event)
  for idx, _ in pairs(event.param2 or {}) do
    self.battleInfo.open[tostring(idx)] = 1
  end
  
  local function enterFunc()
    self:refreshMap()
    self:returnSelect()
    self:eventHandler()
  end
  
  self:moveCamera(event.param1, 0.5, enterFunc)
end

function BaseCarbonBattleLayer:onChangeStage(event)
  local index = event.param1
  local type = event.param2
  self.battleInfo.stageExtra[tostring(index)] = type
  if self.mapInfo[index].type ~= type then
    self.mapInfo[index].type = type
    self:initStage(index)
  end
  self:eventHandler()
end

function BaseCarbonBattleLayer:onWeather(event)
  if self.currentWeather ~= event.param1 then
    local effect = UIHelper.loadAnimation("ui/global/", "tianqi_1", 39, 30)
    local parentSize = self.weatherBg:getContentSize()
    effect.sprite:anch(0, 1):pos(0, parentSize.height):addTo(self.weatherBg)
    effect.sprite:playAnimationOnce(effect.animation, true)
    game:playMusic(1804)
  end
  self.battleInfo.weather = clone(self:getBattleData().weather)
  self:refreashUI()
  self:eventHandler()
end

function BaseCarbonBattleLayer:onGameOver(event)
  if self.selectPlayerId then
    self:unSelectPlayer(self.selectPlayerId)
  end
  
  local function gameOver()
    local flagPlayer
    if self.battleInfo and self.battleInfo.playerList then
      for key, value in ipairs(self.battleInfo.playerList) do
        flagPlayer = value.format
      end
    end
    local id = self.lastPlayer and self.lastPlayer or flagPlayer
    self:showResultLayer({
      endResult = self.endResult,
      carbonId = self.carbonId,
      id = id
    })
  end
  
  local mask = UIHelper.newMask({
    size = cc.size(display.width, display.height),
    opacity = 0
  })
  mask:addTo(display.getRunningScene()):zorder(POPUP_LAYER_ORDER)
  mask:setTouchEnabled(true)
  
  local function afterEffect()
    if not tolua.isnull(mask) then
      mask:removeSelf()
    end
    if self.endResult and self.endResult.bFirstWin and self.carbonData.story2 ~= 0 then
      game:createView("talk.PlotTalkLayer", {
        talkId = self.carbonData.story2,
        csvNo = self.carbonData.readcsv or 0,
        onComplete = function()
          gameOver()
        end
      })
    else
      gameOver()
    end
  end
  
  if self.endResult.win then
    local spine = UIHelper.createSpineNodeByRes("spine/ui/battle/success")
    local cx = display.cx
    if UIHelper.isiPhoneX() then
      cx = cx + UIHelper.getMoveXForX()
    end
    spine:pos(cx, display.cy):addTo(self.mapNode)
    spine:setAnimation(0, "special", false)
    spine:setTimeScale(self:getSpeedMult())
    spine:registerSpineEventHandler(function(event)
      afterEffect()
      scheduler.performWithDelayGlobal(function()
        spine:removeSelf()
      end, 0.016666666666666666)
    end, sp.EventType.ANIMATION_END)
  else
    self.content = display.newSprite("ui/battle/tip_bg.png"):anch(1, 0.5):pos(0, display.height / 2):addTo(self.mapNode)
    if UIHelper.isiPhoneX() then
      self.content:setPositionX(self.content:getPositionX() + UIHelper.getMoveXForX())
    end
    local txtpng = self.endResult.win and "battle_win.png" or "battle_lose.png"
    display.newSprite("ui/battle/" .. txtpng):center(self.content):addTo(self.content)
    self.content:runAction(transition.sequence({
      cc.MoveBy:create(0.1, cc.p(display.width, 0)),
      cc.DelayTime:create(1.3),
      cc.MoveBy:create(0.1, cc.p(display.width, 0)),
      cc.CallFunc:create(function()
        afterEffect()
      end),
      cc.RemoveSelf:create()
    }))
  end
end

function BaseCarbonBattleLayer:onMove(event)
  local player = self:getPlayerData(event.param2, event.param1 == "left" and self.battleInfo.playerList or self.battleInfo.enemyList)
  local display2 = player.display
  local spine = player.spine
  local oldStageInfo = self.mapInfo[player.stage]
  local oldStage = player.stage
  player.stage = event.param3
  local waitTime = 1
  local stageInfo = self.mapInfo[player.stage]
  local mask
  if event.param1 == "left" then
    oldStageInfo.playerId = nil
    stageInfo.playerId = player.id
    mask = UIHelper.newMask({
      size = cc.size(display.width, display.height),
      opacity = 0
    })
    mask:anch(0.5, 0.5):pos(display.width / 2, display.height / 2):addTo(display.getRunningScene(), 100)
    mask:setTouchEnabled(true)
    mask:setSwallowTouches(true)
    if stageInfo.type == StageType.Supply then
      self.tipLayer:removeChildByName("supply")
    end
  else
    if not event.param4 then
      oldStageInfo.enemyId = nil
    end
    if self.lastMonster == event.param2 then
      waitTime = 0.1
    else
      waitTime = 1
    end
    self.lastMonster = event.param2
  end
  if event.param6 then
    self:changeStage(oldStage, event.param6)
  end
  local moveTime = 0.2
  local path = self:BFS(oldStage, player.stage)
  if 0 < #path then
    table.remove(path, 1)
  end
  local moveAction
  
  function moveAction()
    if #path == 0 then
      player.touchLimit = false
      spine:setToSetupPose()
      if event.param1 == "left" and self.selectPlayerId == event.param2 then
        self:showMoveAble(event.param3)
      else
        spine:setAnimation(0, "idle", true)
      end
      if mask and not tolua.isnull(mask) then
        mask:removeSelf()
      end
      self:eventHandler()
      return
    end
    local targetId = path[1]
    table.remove(path, 1)
    local disData = self.mapDisData[targetId]
    local direction = display2:getPositionX() > disData.xpos and -1 or 1
    spine:setScaleX(math.abs(spine:getScaleX()) * direction)
    display2:runAction(transition.sequence({
      cc.MoveTo:create(moveTime / self:getSpeedMult(), cc.p(disData.xpos, disData.ypos)),
      cc.CallFunc:create(moveAction)
    }))
  end
  
  spine:setToSetupPose()
  spine:setAnimation(0, "move", true)
  self.playerMove = true
  if event.param1 == "left" then
    moveAction()
  else
    self:moveCamera(oldStage, 0.5, moveAction)
  end
end

function BaseCarbonBattleLayer:onOccupy(event)
  local player = self:getPlayerData(event.param2, event.param1 == "left" and self.battleInfo.playerList or self.battleInfo.enemyList)
  local stageInfo = self.mapInfo[event.param3]
  if event.param1 == "left" then
    stageInfo.playerId = player.id
    stageInfo.enemyId = nil
  else
    stageInfo.enemyId = player.id
    stageInfo.playerId = nil
  end
  self:setStage(event.param3, event.param1 == "left" and 1 or 2)
  local display = player.display
  if display and event.param1 ~= "left" then
    display:runAction(transition.sequence({
      cc.DelayTime:create(event.param1 == "left" and 0 / self:getSpeedMult() or 0.5 / self:getSpeedMult()),
      cc.CallFunc:create(function()
        self:eventHandler()
      end)
    }))
  else
    self:eventHandler()
  end
end

function BaseCarbonBattleLayer:onFly(event)
  local player = self:getPlayerData(event.param2, event.param1 == "left" and self.battleInfo.playerList or self.battleInfo.enemyList)
  local startStage = self.mapInfo[player.stage]
  local startDis = self.mapDisData[startStage.mapId]
  local endStage = self.mapInfo[event.param3]
  local endDis = self.mapDisData[endStage.mapId]
  player.display:hide()
  player.display:pos(endDis.xpos, endDis.ypos)
  local mask
  if event.param1 == "left" then
    mask = UIHelper.newMask({
      size = cc.size(display.width, display.height),
      opacity = 0
    })
    mask:anch(0.5, 0.5):pos(display.width / 2, display.height / 2):addTo(display.getRunningScene(), 100)
    mask:setTouchEnabled(true)
    mask:setSwallowTouches(true)
  end
  local startEffect = UIHelper.createSpineNodeByRes("spine/ui/carbon/csm_inout"):pos(startDis.xpos, startDis.ypos - 20):addTo(self.unitLayer, 1000)
  startEffect:setAnimation(0, "in", false)
  startEffect:setTimeScale(self:getSpeedMult())
  self.isMoving = true
  startEffect:registerSpineEventHandler(function(e)
    if e.type ~= "end" then
      return
    end
    self:comeToCamera(event.param3)
    local endEffect = UIHelper.createSpineNodeByRes("spine/ui/carbon/csm_inout"):pos(endDis.xpos, endDis.ypos - 20):addTo(self.unitLayer, 1000)
    endEffect:setAnimation(0, "out", false)
    endEffect:setTimeScale(self:getSpeedMult())
    endEffect:registerSpineEventHandler(function(f)
      if f.type ~= "end" then
        return
      end
      player.display:show()
      player.stage = event.param3
      if event.param1 == "left" then
        if startStage.playerId == player.id then
          startStage.playerId = nil
        end
        endStage.playerId = player.id
      elseif event.param1 == "right" then
        if startStage.enemyId == player.id then
          startStage.enemyId = nil
        end
        endStage.enemyId = player.id
      end
      if event.param1 == "left" and event.param4 then
        self:showMoveAble(event.param3)
      end
      if mask and not tolua.isnull(mask) then
        mask:removeSelf()
      end
      self:eventHandler()
      self.isMoving = false
      scheduler.performWithDelayGlobal(function()
        endEffect:removeSelf()
      end, 0.016666666666666666)
    end, sp.EventType.ANIMATION_END)
    scheduler.performWithDelayGlobal(function()
      startEffect:removeSelf()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
end

function BaseCarbonBattleLayer:onAddEnemy(event)
  local function cameraMoveBefore()
    local enemy = {
      id = event.param1,
      
      enemyId = event.param2,
      stage = event.param3
    }
    local monsterSet = MonsterCsv[enemy.enemyId]
    local stageInfo = self.mapInfo[enemy.stage]
    enemy.display = display.newNode():pos(stageInfo.stage:getPosition()):addTo(self.unitLayer)
    local spine = UIHelper.createSpineNode(monsterSet.bossId)
    spine:addTo(enemy.display)
    enemy.spine = spine
    spine:setAnimation(0, "idle", true)
    if monsterSet.type == MonsterType.Eat then
      UIHelper.newImageView(BattleRes .. "energy.png"):pos(-10, 95):addTo(enemy.display)
      local energy = self.carbonData.initDevour
      enemy.tag = display.newTTFLabel({
        text = energy,
        size = 26,
        color = UIHelper.hex2rgb("#04ff2d")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(30, 95):addTo(enemy.display, nil, TAG_ENERGY)
    elseif monsterSet.type == MonsterType.Boss then
      UIHelper.newImageView(BattleRes .. "boss.png"):pos(0, monsterSet.bossIcon):addTo(enemy.display)
    end
    game:playMusic(1802)
    table.insert(self.battleInfo.enemyList, enemy)
    if event.param4 then
      spine:setScale(0.2)
      spine:runAction(transition.sequence({
        cc.ScaleTo:create(0.5 / self:getSpeedMult(), 1),
        cc.CallFunc:create(function()
          self:eventHandler()
        end)
      }))
    else
      local eat = self:getPlayerData(event.param5, self.battleInfo.enemyList)
      eat.spine:setAnimation(1, "attack", false)
      eat.spine:setToSetupPose()
      spine:setScale(0)
      spine:runAction(transition.sequence({
        cc.DelayTime:create(1 / self:getSpeedMult()),
        cc.ScaleTo:create(0.5 / self:getSpeedMult(), 1),
        cc.CallFunc:create(function()
          eat.spine:setAnimation(0, "idle", true)
          self:eventHandler()
        end)
      }))
    end
  end
  
  self:moveCamera(event.param3, 0.5, cameraMoveBefore)
end

function BaseCarbonBattleLayer:onDelEnemy(event)
  local player = self:getPlayerData(event.param1, self.battleInfo.enemyList)
  if player and player.display then
    player.display:removeSelf()
  end
  local stageInfo = self.mapInfo[player.stage]
  if not event.param2 then
    stageInfo.enemyId = nil
  end
  for index, info in ipairs(self.battleInfo.enemyList) do
    if info.id == player.id then
      table.remove(self.battleInfo.enemyList, index)
      break
    end
  end
  for _, player in ipairs(self.battleInfo.playerList) do
    self:updateMaterialBar(player)
  end
  if event.param3 then
    local eat = self:getPlayerData(event.param3, self.battleInfo.enemyList)
    if eat.spine then
      eat.spine:setAnimation(1, "attack", false)
      eat.spine:setToSetupPose()
      eat.spine:runAction(transition.sequence({
        cc.DelayTime:create(0.5 / self:getSpeedMult()),
        cc.CallFunc:create(function()
          eat.spine:setAnimation(0, "idle", true)
          self:eventHandler()
        end)
      }))
    end
  else
    self:eventHandler()
  end
end

function BaseCarbonBattleLayer:onResetLeft(event)
  self.lastMonster = 0
  self.battleInfo.day = self.battleInfo.day + 1
  if self:scaleIsCanMove() then
    self.dragLayer:setTouchEnabled(true)
  end
  self.btnSpine:setToSetupPose()
  self.btnSpine:setAnimation(1, "moveEnd", false)
  self.btnSpine:addAnimation(1, "end", true)
  self:showRightPanel(true, true)
  self:showEffect()
  self.battleInfo.lastPoint = event.param1
  self:resetCamera()
  for _, player in pairs(self.battleInfo.playerList) do
    self:updateMaterialBar(player)
  end
  for index, stage in pairs(self.mapInfo) do
    local stageDis = self.mapDisData[stage.mapId]
    if stage.conquer == 1 and (stage.type == StageType.Supply or stage.type == StageType.SupplyStep) then
      local tip = display.newTTFLabel({
        text = "行动点+1",
        size = 24,
        color = UIHelper.hex2rgb("#58ed16")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(stageDis.xpos, stageDis.ypos - 15):addTo(self.tipLayer)
      tip:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.FadeOut:create(0.8),
        cc.RemoveSelf:create()
      }))
    end
  end
  self:onLeftTurn()
end

function BaseCarbonBattleLayer:onEnergy(event)
  local enemy = self:getPlayerData(event.param1, self.battleInfo.enemyList)
  local enemyTag = enemy.display:getChildByTag(TAG_ENERGY)
  if enemyTag then
    local oldNum = tonumber(enemyTag:getString())
    enemy.energy = event.param2
    enemyTag:setString(enemy.energy)
    UIHelper.numVaryEffect({
      node = enemyTag,
      orginNum = oldNum,
      repeatTimes = 30,
      endNum = enemy.energy,
      effectTime = 0.5
    })
  end
  self:eventHandler()
end

function BaseCarbonBattleLayer:onStageEnergy(event)
  local text = event.param1 > 0 and "吞噬层数增加" or "吞噬层数降低"
  text = text .. event.param1
  for index, stage in pairs(self.mapInfo) do
    local stageDis = self.mapDisData[stage.mapId]
    if stage.conquer ~= 0 and stage.type == StageType.Power then
      local tip = display.newTTFLabel({
        text = text,
        size = 24,
        color = UIHelper.hex2rgb("#58ed16")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(stageDis.xpos, stageDis.ypos - 15):addTo(self.tipLayer)
      tip:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.FadeOut:create(0.8),
        cc.RemoveSelf:create()
      }))
    end
  end
  self:eventHandler()
end

function BaseCarbonBattleLayer:onBattle()
  self.battleInfo = json.decode(self:getBattleInfo())
  if not self.battleInfo.battle then
    return
  end
  local enemy = self:getPlayerData(self.battleInfo.battle.enemyId, self.battleInfo.enemyList)
  local enemyData = MonsterCsv[enemy.enemyId]
  local playerData
  for index, player in pairs(self.battleInfo.playerList) do
    if player.id == self.battleInfo.battle.playerId then
      playerData = self.battleInfo.playerList[index]
    end
  end
  local format = playerData.format
  self:battleInfoCache(clone(self.battleInfo))
  self:battleInfoCache().selectPlayerId = self.selectPlayerId
  self:battleInfoCache().lastPlayer = format
  if self.battleInfo.moveType == 2 then
    self:battleInfoCache().lastCamera = self.lastCamera
  else
    local xpos, ypos = self.map:getPosition()
    self:battleInfoCache().lastCamera = {
      zoom = self.zoom,
      xpos = xpos,
      ypos = ypos
    }
  end
  game.role.battlePathTemp = self.battlePathTemp
  local buff = {}
  for _, data in pairs(self.battleInfo.buff) do
    if self.battleInfo.battle.playerId == data.playerId then
      table.insert(buff, data.id)
    end
  end
  local bossId = 0
  local extraBattle = json.decode(game.role.extraBattle)
  if extraBattle.carbonId and extraBattle.carbonId == self.carbonId and enemy.enemyId == extraBattle.curMonster then
    bossId = extraBattle.bossId
  end
  game:enterScene("BattleScene", {
    type = self:getActionCodes().battleType,
    carbonId = self.carbonId,
    modeType = self:getActionCodes().modeType,
    masterId = enemy.enemyId,
    leftInfo = game.role:getBattleAttrs(format, self:getActionCodes().battleType, self.battleInfo, self.battleInfo.attrUp),
    format = format,
    energy = enemy.energy,
    buff = buff,
    bossId = bossId,
    weatherFactor = enemyData.type == MonsterType.Dregs and self.currentWeather == 3,
    battleKey = self.battleInfo.key or "zhaolu",
    activityBuff = self.battleInfo.activityBuff
  })
end

function BaseCarbonBattleLayer:onBox(event)
  local player = self:getPlayerData(event.param1, self.battleInfo.playerList)
  display.newTTFLabel({
    text = "发现了一个谢礼堆",
    size = 24,
    color = UIHelper.hex2rgb("#58ed16")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(0, 140):addTo(player.display):runAction(transition.sequence({
    cc.DelayTime:create(0.5),
    cc.Spawn:create({
      cc.MoveBy:create(0.75, cc.p(0, 50)),
      cc.FadeOut:create(0.75)
    }),
    cc.RemoveSelf:create()
  }))
  self:eventHandler()
end

function BaseCarbonBattleLayer:onCure(event)
  if event.param3 then
    local player = self:getPlayerData(event.param1, self.battleInfo.playerList)
    display.newTTFLabel({
      text = "治疗完成",
      size = 24,
      color = UIHelper.hex2rgb("#58ed16")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(0, 140):addTo(player.display):runAction(transition.sequence({
      cc.DelayTime:create(0.5),
      cc.Spawn:create({
        cc.MoveBy:create(0.75, cc.p(0, 50)),
        cc.FadeOut:create(0.75)
      }),
      cc.RemoveSelf:create()
    }))
    self:updateMaterialBar(player)
    self:eventHandler()
    return
  end
  game:createView("carbon.CarbonTreatHerosLayer", {
    index = event.param1,
    condition = self.mapData[event.param2].content2,
    battleType = self:getActionCodes().battleType,
    callback = function(heroIds)
      if not next(heroIds) then
        self:eventHandler()
        return
      end
      game:sendData(self:getActionCodes().treatHerosRpc, MsgPack.pack({
        ids = heroIds,
        format = event.param1,
        index = event.param2
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(self:getActionCodes().treatHerosRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        self.curEvents = msg
        self:eventHandler()
      end)
    end,
    cancelBack = function()
      self:eventHandler()
    end
  })
end

function BaseCarbonBattleLayer:onAttr(event)
  if event.param3 then
    for index, stageInfo in pairs(self.mapInfo) do
      if self.mapData[index].type == StageType.attrUp then
        local label = stageInfo.stage.label
        if label then
          local oldNum = tonumber(label:getString())
          UIHelper.numVaryEffect({
            node = label,
            orginNum = oldNum,
            repeatTimes = 20,
            endNum = math.min(event.param1, self.mapData[index].content),
            effectTime = 0.5,
            stringFormat = "能力+%d%%"
          })
        end
        local spine = stageInfo.stage.spine
        if spine then
          spine:setAnimation(0, "wofang", true)
        end
      end
    end
    self:eventHandler()
    return
  end
  self.battleInfo.attrUp = event.param1
  local player = self:getPlayerData(event.param2, self.battleInfo.playerList)
  display.newTTFLabel({
    text = string.format("攻击+%d%% 防御+%d%%", event.param1, event.param1),
    size = 24,
    color = UIHelper.hex2rgb("#58ed16")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(0, 140):addTo(player.display):runAction(transition.sequence({
    cc.DelayTime:create(0.5),
    cc.Spawn:create({
      cc.MoveBy:create(0.75, cc.p(0, 50)),
      cc.FadeOut:create(0.75)
    }),
    cc.RemoveSelf:create()
  }))
  self:eventHandler()
end

function BaseCarbonBattleLayer:initUI()
  game:playMusic(self.carbonData.bgm)
  TopBar:show(TopBarType.full)
  self.weatherMask:zorder(-1)
  self.weatherBar = display.newProgressTimer(BattleRes .. "weather_bar.png", display.PROGRESS_TIMER_RADIAL):center(self.weatherMask):addTo(self.weatherMask, 100)
  self.weatherBar:setPercentage(100)
  self.weatherBar:setScaleX(-1)
  self.btnOk = UIHelper.extend(ccui.Layout:create())
  self.btnOk:size(129, 116):pos(-65, -58):anch(0, 0):addTo(self.btnNode):name("btnOk")
  self.btnOk:setTouchEnabled(true)
  UIHelper.newImageView(BattleRes .. "circle_back.png"):pos(65, 58):addTo(self.btnOk)
  self.btnSpine = UIHelper.createSpineNodeByRes("spine/ui/carbon/button"):pos(65, 58):addTo(self.btnOk)
  self.btnCancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#722c02"), 1)
  self.btnCancel:setTouchScale()
  self.btnEnd:setTouchScale()
  self.btnInfo:setTouchScale()
  self.btnCancel:setMusicId(1012)
  self.btnEnd:setMusicId(1013)
  self.btnOk:setCallback(function()
    if next(self.curEvents) then
      return
    end
    if game:nowTime() - self.currentTime >= 2 then
      self.currentTime = game:nowTime()
    else
      return
    end
    self:clearBehaviour()
    self:onNext()
  end)
  self.btnCancel:setCallback(function()
    if next(self.curEvents) then
      return
    end
    if self.battleInfo.moveType == 2 then
      return
    end
    self:onCancel()
  end)
  self.btnInfo:setCallback(function()
    self:mapCheckTool()
    if self.battleInfo.moveType == 2 then
      return
    end
    local layer = game:createView("carbon.CarbonInfoLayer", {
      carbonData = self.carbonData,
      battleType = self:getActionCodes().battleType
    })
    BackManager:push(function()
      layer:close()
      self:checkGuide()
    end)
  end)
  self.btnEnd:setCallback(function()
    if self.newGame then
      SysError(SYS_ERR_FIGHT_END_NOT_STARTED)
      return
    end
    if self.battleInfo.moveType == 2 then
      return
    end
    MDialog:double({
      text = "终止作战将丢失当前作战进度\n \n主厨，确定要终止吗？"
    }, function()
      self:sendExitGame()
    end)
  end)
  self.zoomOut:setCallback(function()
    if self.battleInfo.moveType == 2 then
      return
    end
    self:setZoom(self.zoom - 0.1)
    UserData.MapMaxZoom = self.zoom
    GameState.save(UserData)
  end)
  self.zoomIn:setCallback(function()
    if self.battleInfo.moveType == 2 then
      return
    end
    self:setZoom(self.zoom + 0.1)
    UserData.MapMaxZoom = self.zoom
    GameState.save(UserData)
  end)
end

function BaseCarbonBattleLayer:initMap()
  local width, height = self.carbonData.size:match("(%d+)=(%d+)")
  self.mapSize = cc.size(tonumber(width), tonumber(height))
  self:loadTMXMapData()
  self.mapInfo = {}
  for index, data in ipairs(self.mapData) do
    local info = {
      type = data.type,
      conquer = data.conquer
    }
    self.mapInfo[index] = info
  end
  local height1 = (self.map:getMapSize().height - 1) * self.map:getTileSize().height
  local height2 = (self.map:getMapSize().height / 2 + 0.5) * self.map:getTileSize().height
  local group = self.map:getObjectGroup("object")
  local objects = group:getObjects()
  self.mapDisData = {}
  for index, object in pairs(objects) do
    local id = tonumber(object.id)
    local stageIndex = tonumber(object.key)
    if 0 < stageIndex then
      self.mapInfo[stageIndex].mapId = id
    end
    local disData = {
      xpos = object.x + object.width / 2,
      ypos = height2 - (height1 - object.y) + object.height / 2,
      neighbor = {},
      object = object
    }
    for _index, _object in pairs(objects) do
      if _index ~= index and math.abs(object.x - _object.x) == object.width / 2 and math.abs(object.y - _object.y) == object.height / 2 then
        table.insert(disData.neighbor, tonumber(_object.id))
      end
    end
    self.mapDisData[id] = disData
  end
  for index, data in ipairs(self.mapData) do
    local stage = self.mapInfo[index]
    local stageDis = self.mapDisData[stage.mapId]
    local touch = UIHelper.extend(ccui.Layout:create())
    touch:size(140, 110):anch(0.5, 0):pos(stageDis.xpos, stageDis.ypos - 20):addTo(self.touchLayer):name("stage" .. index)
    touch:setTouchEnabled(true)
    touch:setSwallowTouches(false)
    touch:setCallback(function()
      self:stageHandler(index)
    end)
    self:initStage(index)
  end
end

local posOffset = {
  {x = 80, y = 40},
  {x = 80, y = -40},
  {x = -80, y = 40},
  {x = -80, y = -40},
  {x = 80, y = 0},
  {x = -80, y = 0},
  {x = 0, y = 40},
  {x = 0, y = -40}
}
local touchMove = 0

function BaseCarbonBattleLayer:loadTMXMapData()
  local bg = UIHelper.newImageView(self.carbonData.back .. ".png"):pos(display.cx, display.cy):addTo(self.mapNode, -2)
  if UIHelper.isiPhoneX() then
    bg:setPositionX(bg:getPositionX() + UIHelper.getMoveXForX())
  end
  UIHelper.fitForiPhoneX(bg)
  local offsetNode = display.newNode():addTo(self.mapNode)
  self.map = cc.TMXTiledMap:create(self.carbonData.levelRes .. ".tmx")
  self.map:addTo(offsetNode)
  self.touchLayer = display.newNode():addTo(self.map, 80)
  self.underLayer = display.newNode():addTo(self.map, 90)
  self.unitLayer = display.newNode():addTo(self.map, 100)
  self.behaviourLayer = display.newNode():addTo(self.map, 101)
  self.tipLayer = display.newNode():addTo(self.map, 110)
  self.weatherLayer = display.newNode():addTo(self.mapNode)
  if UIHelper.isiPhoneX() then
    self.weatherLayer:setPositionX(self.weatherLayer:getPositionX() + UIHelper.getMoveXForX())
  end
  local layers = {
    "buildings",
    "road",
    "detail",
    "ground",
    "back"
  }
  for _, layerName in ipairs(layers) do
    local layer = self.map:getLayer(layerName)
    if layer then
      layer:getTexture():setAntiAliasTexParameters()
    end
  end
  local diff = math.floor(self.carbonData.id / 10000)
  local yinghuo
  if diff == 3 then
  else
    yinghuo = cc.ParticleSystemQuad:create("spine/ui/battle/lizi.plist")
    yinghuo:setPositionType(cc.POSITION_TYPE_RELATIVE)
    yinghuo:setPosVar(cc.p(1500, 0))
    yinghuo:pos(display.width / 2, -30):addTo(self.mapNode, -1)
  end
  if UIHelper.isiPhoneX() and yinghuo then
    yinghuo:setPositionX(yinghuo:getPositionX() + UIHelper.getMoveXForX())
  end
  local height = (self.map:getMapSize().height / 2 + 0.5) * self.map:getTileSize().height
  self.dragLayer = UIHelper.extend(ccui.Layout:create())
  self.dragLayer:size(self.map:getContentSize().width, self.map:getContentSize().height):addTo(self.map)
  self.dragLayer:setTouchEnabled(true)
  local oldPos
  self.dragLayer:addTouchEventListener(function(sender, type)
    if not self:mapCanMove() then
      return
    end
    if type == ccui.TouchEventType.began then
      oldPos = sender:getBeginPos()
    elseif type == ccui.TouchEventType.moved then
      pos = sender:getMovePos()
      local xpos, ypos = self.map:getPosition()
      xpos = xpos + pos.x - oldPos.x
      ypos = ypos + pos.y - oldPos.y
      xpos = math.max(xpos, -self.mapSize.width * self.zoom + display.width)
      xpos = math.min(xpos, 0)
      ypos = math.max(ypos, display.height - self.zoom * self.mapSize.height)
      ypos = math.min(ypos, 0)
      self.map:pos(xpos, ypos)
    elseif type == ccui.TouchEventType.ended then
      local xpos, ypos = self.map:getPosition()
      if touchMove == 0 then
        touchMove = math.randomFloat(-0.5, 0.5)
      else
        touchMove = 0
      end
      self.map:pos(xpos + touchMove, ypos + touchMove)
    end
  end)
end

function BaseCarbonBattleLayer:initStage(stageIndex)
  local stageSet = self.mapData[stageIndex]
  local stageInfo = self.mapInfo[stageIndex]
  local disData = self.mapDisData[stageInfo.mapId]
  if stageInfo.stage then
    stageInfo.stage:removeFromParent()
  end
  local stage = display.newNode():pos(disData.xpos, disData.ypos):addTo(self.map, 99)
  stageInfo.open = stageSet.open
  if stageInfo.open == 0 and (not self.battleInfo.open or not self.battleInfo.open[tostring(stageIndex)]) then
    stage:hide()
  end
  if stageInfo.type ~= StageType.Arrange and stageInfo.type ~= StageType.Select and stageInfo.type ~= StageType.Cross and stageInfo.type ~= StageType.RandSelect then
    local pic = UIHelper.createSpineNodeByRes("spine/ui/carbon/common")
    pic:setAnimation(0, "special", true)
    pic:pos(0, 0):addTo(stage)
    if stageInfo.type == StageType.WeakArrange or stageInfo.type == StageType.OnceArrange or stageInfo.type == StageType.WeakEnemyArrange then
      pic:hide()
    end
    stage.pic = pic
  end
  local statusRes = {
    [StageType.Supply] = {
      res = "spine/ui/carbon/hua",
      p = cc.p(0, 0)
    },
    [StageType.WeakArrange] = {
      res = "spine/ui/carbon/cuiruodechuansongzhen",
      p = cc.p(0, 0)
    },
    [StageType.OnceArrange] = {
      res = "spine/ui/carbon/cuiruodechuansongzhen",
      p = cc.p(0, 0)
    },
    [StageType.Arrange] = {
      res = "spine/ui/carbon/chuansongzhen",
      p = cc.p(0, 10)
    },
    [StageType.Power] = {
      res = "spine/ui/carbon/ziyuandian",
      p = cc.p(0, 10)
    },
    [StageType.Select] = {
      res = "spine/ui/carbon/choose_normal",
      p = cc.p(0, 0)
    },
    [StageType.RandSelect] = {
      res = "spine/ui/carbon/choose_normal",
      p = cc.p(0, 0)
    },
    [StageType.Cross] = {
      res = "spine/ui/carbon/csm_idle",
      p = cc.p(0, -15)
    },
    [StageType.WeakEnemyArrange] = {
      res = "spine/ui/carbon/cuiruodechuansongzhen",
      p = cc.p(0, 0),
      name = "脆弱敌方召唤点"
    },
    [StageType.SupplyMaterial] = {
      res = "spine/ui/carbon/cxdd",
      p = cc.p(0, 0),
      name = "补给资源点"
    },
    [StageType.SupplyStep] = {
      res = "spine/ui/carbon/cbjd",
      p = cc.p(0, 0),
      name = "补给行动点"
    },
    [StageType.Box] = {
      res = "spine/ui/carbon/bx",
      p = cc.p(0, 0),
      name = "宝箱点"
    },
    [StageType.Cure] = {
      res = "spine/ui/carbon/czld",
      p = cc.p(0, 0),
      name = "治疗点"
    },
    [StageType.attrUp] = {
      res = "spine/ui/carbon/zswofang",
      p = cc.p(0, 0),
      name = "属性提升点"
    }
  }
  local status = statusRes[stageInfo.type]
  if status then
    local spine = UIHelper.createSpineNodeByRes(status.res)
    spine:pos(status.p.x, status.p.y):addTo(stage, 10, TAG_FLAG)
    if stageInfo.type == StageType.Cross or stageInfo.type == StageType.Select or stageInfo.type == StageType.RandSelect then
      spine:setAnimation(0, "special", true)
    elseif stageInfo.type == StageType.Box or stageInfo.type == StageType.SupplyMaterial or stageInfo.type == StageType.SupplyStep or stageInfo.type == StageType.Cure or stageInfo.type == StageType.attrUp then
      if stageInfo.type == StageType.attrUp then
        stage.Label = display.newTTFLabel({
          text = string.format("能力+%d%%", self:getAttrUpSum(stageIndex)),
          size = 20,
          color = UIHelper.hex2rgb("#ff00ff")
        }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(0, 85):addTo(stage)
        spine:setAnimation(0, next(self.battleInfo.kill or {}) and "wofang" or "zhongli", true)
      elseif stageInfo.conquer == 1 then
        spine:setAnimation(0, "wofang", true)
      else
        spine:setAnimation(0, "zhongli", true)
      end
    elseif stageInfo.conquer == 1 then
      spine:setAnimation(0, "wofang", true)
    elseif stageInfo.conquer == 2 then
      spine:setAnimation(0, "difang", true)
    elseif stageInfo.conquer == 0 then
      spine:setAnimation(0, "zhongli", true)
    end
    if stageInfo.type == StageType.Supply then
      spine:setScaleX(-1 * spine:getScaleX())
    end
    stage.spine = spine
  end
  stageInfo.stage = stage
end

function BaseCarbonBattleLayer:refreshMap()
  for index, data in ipairs(self.mapData) do
    self.mapInfo[index].conquer = data.conquer
  end
  if self.battleInfo.mapStatus and self.battleInfo.mapStatus.conquer then
    for index, conquer in pairs(self.battleInfo.mapStatus.conquer) do
      self:setStageConquer(index, conquer)
      self:refreshBuildSpine(index, conquer)
    end
  end
  if self.battleInfo.stageExtra then
    for index, stageType in pairs(self.battleInfo.stageExtra) do
      if self.mapInfo[tonumber(index)].type ~= stageType then
        self.mapInfo[tonumber(index)].type = stageType
        self:initStage(tonumber(index))
      end
    end
  end
  local layers = {}
  local shows = {}
  for index, info in ipairs(self.mapInfo) do
    local stage = info.stage
    if stage and self.battleInfo.open and self.battleInfo.open[tostring(index)] then
      shows[math.max(self.mapData[index].group or 1, 1)] = 1
      stage:show()
    end
    if self.mapData[index].open == 0 then
      layers[math.max(self.mapData[index].group or 1, 1)] = 1
    end
  end
  for group, _ in pairs(layers) do
    for id = 1, 3 do
      local layer = self.map:getLayer(string.format("extralayer%d", (group - 1) * 3 + id))
      if layer then
        layer:setVisible(shows[group] and true or false)
      end
    end
  end
  for index, enemy in ipairs(self.battleInfo.enemyList) do
    local stageInfo = self.mapInfo[enemy.stage]
    stageInfo.enemyId = enemy.id
  end
  for index, player in ipairs(self.battleInfo.playerList) do
    local stageInfo = self.mapInfo[player.stage]
    stageInfo.playerId = player.id
  end
  for index, info in ipairs(self.mapInfo) do
    local disData = self.mapDisData[info.mapId]
    if info.playerId then
      local unitData = self:getPlayerData(info.playerId)
      if unitData.display then
        unitData.display:removeAllChildren()
      else
        unitData.display = display.newNode():pos(disData.xpos, disData.ypos):addTo(self.unitLayer)
      end
      local formation = game.role.formation
      local heroId = formation[tostring(unitData.format)].list["1"]
      local hero = game.role.heros[heroId]
      local spine = UIHelper.createSpineNode(hero:getDressType())
      spine:addTo(unitData.display)
      spine:setAnimation(0, "idle", true)
      unitData.spine = spine
      local materialNode = display.newNode():addTo(unitData.display)
      unitData.materialNode = materialNode
      self:updateMaterialBar(unitData)
      if game.role.majorGuideStep == 11 then
        if index == 1 then
          game.role.minorGuideStep = 10
        elseif index == 2 then
          game.role.minorGuideStep = 11
        else
          game.role.minorGuideStep = 12
        end
      end
    end
    if info.enemyId then
      local unitData = self:getPlayerData(info.enemyId, self.battleInfo.enemyList)
      if unitData.display then
        unitData.display:removeAllChildren()
      else
        unitData.display = display.newNode():pos(disData.xpos, disData.ypos):addTo(self.unitLayer)
      end
      local monsterSet = MonsterCsv[unitData.enemyId]
      local spine = UIHelper.createSpineNode(monsterSet.bossId)
      spine:addTo(unitData.display)
      spine:setAnimation(0, "idle", true)
      unitData.spine = spine
      if monsterSet.type == MonsterType.Eat then
        UIHelper.newImageView(BattleRes .. "energy.png"):pos(-10, 95):addTo(unitData.display)
        local energy = 0
        if self.newGame then
          energy = self.carbonData.initDevour
        else
          energy = unitData.energy or 0
        end
        unitData.tag = display.newTTFLabel({
          text = energy,
          size = 26,
          color = UIHelper.hex2rgb("#04ff2d")
        }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(30, 95):addTo(unitData.display, nil, TAG_ENERGY)
      elseif monsterSet.type == MonsterType.Boss then
        UIHelper.newImageView(BattleRes .. "boss.png"):pos(0, monsterSet.bossIcon):addTo(unitData.display)
      elseif monsterSet.type == MonsterType.Ghost then
        UIHelper.newImageView(BattleRes .. "ghost.png"):pos(0, monsterSet.bossIcon):addTo(unitData.display)
      end
    end
  end
end

function BaseCarbonBattleLayer:exitTeam(playerId)
  local player = self:getPlayerData(playerId)
  local stage = self.mapInfo[player.stage]
  local arrange = stage.type == StageType.Arrange or stage.type == StageType.WeakArrange or stage.type == StageType.OnceArrange
  local text = arrange and "确定要撤退吗?" or "不在召唤点/脆弱召唤点上撤退，会丢失所有资源。\n                         确定要撤退吗？"
  MDialog:double({
    text = text,
    size = arrange and 24 or 18,
    color = UIHelper.hex2rgb("#430602")
  }, function()
    game:sendData(self:getActionCodes().exitTeamRpc, MsgPack.pack({id = playerId}))
    UIHelper.showWaiting()
    game:addResponseHandler(self:getActionCodes().exitTeamRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if self.selectPlayerId then
        self:unSelectPlayer(self.selectPlayerId)
      end
      self.curEvents = msg
      self:showData()
    end)
  end)
end

function BaseCarbonBattleLayer:showEffect()
  for index, data in pairs(self.mapInfo) do
    if data.type == StageType.Power then
      local stage = data.stage
      if data.conquer == 1 then
        local effect = UIHelper.loadAnimation("battleEff/carbon/", "qswf", 12, 12)
        effect.sprite:pos(80, 82):addTo(stage, 10)
        effect.sprite:playAnimationOnce(effect.animation, true)
      elseif data.conquer == 2 then
        local effect = UIHelper.loadAnimation("battleEff/carbon/", "qsdf", 12, 12)
        effect.sprite:pos(80, 82):addTo(stage, 10)
        effect.sprite:playAnimationOnce(effect.animation, true)
      end
    end
  end
end

function BaseCarbonBattleLayer:returnSelect()
  if self.selectPlayerId then
    local player = self:getPlayerData(self.selectPlayerId)
    if player then
      player.spine:setAnimation(0, "move", true)
      player.display:removeChildByName("arrow")
      local arraw = UIHelper.createSpineNodeByRes("spine/ui/carbon/xzjt")
      arraw:pos(0, 180):name("arrow"):addTo(player.display)
      arraw:setAnimation(0, "special", true)
      self:showMoveAble(player.stage)
    end
  end
end

function BaseCarbonBattleLayer:showMoveAble(stageIndex)
  self.underLayer:removeAllChildren()
  if self.battlePathTemp then
    return
  end
  local canMoveStage = self:findCanMoveStage(stageIndex)
  for _, index in ipairs(canMoveStage) do
    local stage = self.mapInfo[index]
    local stageDis = self.mapDisData[stage.mapId]
    local effect = UIHelper.createSpineNodeByRes("spine/ui/carbon/showmove"):pos(stageDis.xpos, stageDis.ypos):addTo(self.underLayer)
    effect:setAnimation(0, "special", true)
  end
end

function BaseCarbonBattleLayer:clearMoveAlbe()
  self.underLayer:removeAllChildren()
end

function BaseCarbonBattleLayer:stageHandler(index)
  if self:isEndGame() then
    return
  end
  if not self:isStageOpen(index) then
    return
  end
  if self.playerMove then
    return
  end
  local stage = self.mapInfo[index]
  local stageName = {
    nil,
    "召唤点",
    "脆弱召唤点",
    "采集点",
    "魔法石",
    "抉择点",
    "穿越黑洞",
    "抉择点",
    "一次性出生点",
    "竹道",
    "邮箱",
    "谢礼堆",
    "续饭桶",
    "镇石",
    "脆弱召唤点"
  }
  if stage.type and stageName[stage.type] and stageName[stage.type] ~= "" then
    if self.typeTip and not tolua.isnull(self.typeTip) then
      self.typeTip:stopAllActions()
      self.typeTip:removeSelf()
    end
    local stageDis = self.mapDisData[stage.mapId]
    local txtBg = display.newSprite(GlobalRes .. "guide_txt.png"):scale(0.6):pos(stageDis.xpos, stageDis.ypos + 60):addTo(self.unitLayer)
    txtBg:setCascadeOpacityEnabled(true)
    MRichText.new({
      text = stageName[stage.type],
      size = 28,
      color = UIHelper.hex2rgb("#3e1700"),
      maxWidth = 160
    }):anch(0.5, 0.5):pos(85, 30):addTo(txtBg)
    local angle = display.newSprite(GlobalRes .. "guide_angle.png"):anch(0.5, 1):addTo(txtBg):pos(100, 3)
    txtBg:runAction(transition.sequence({
      cc.DelayTime:create(0.5 / self:getSpeedMult()),
      cc.FadeOut:create(0.3 / self:getSpeedMult()),
      cc.RemoveSelf:create(),
      cc.CallFunc:create(function()
        self.typeTip = nil
      end)
    }))
    self.typeTip = txtBg
  end
  if next(self.curEvents) then
    return
  end
  if self.newGame then
    if stage.conquer ~= 1 then
      return
    end
    if stage.type == StageType.Arrange or stage.type == StageType.OnceArrange or stage.type == StageType.WeakArrange then
      self:showBattleList(index)
    end
    return
  end
  if self.battleInfo.moveType == 2 then
    return
  end
  self.behaviourLayer:removeAllChildren()
  if stage.playerId then
    self:onTouchPlayer(stage.playerId)
    return
  end
  if self.selectPlayerId then
    local curPlayer = self:getPlayerData(self.selectPlayerId)
    if not self.movePathTemp or not self.movePathTemp[index] then
      MFlashMsg:show({
        text = string.format("套餐%d已取消选定！", curPlayer.format)
      })
      self:unSelectPlayer(self.selectPlayerId)
    else
      if (stage.type == StageType.Arrange or stage.type == StageType.OnceArrange or stage.type == StageType.WeakArrange) and stage.conquer == 1 then
        self:showBehaviour({
          stageIndex = index,
          mode1 = "move",
          mode2 = "stage"
        })
        return
      end
      if not self:adjacentTwoPoint(curPlayer.stage, index) then
        self:startAutoMove(index)
      else
        self:movePlayer(index)
      end
    end
    return
  end
  if stage.conquer ~= 1 then
    return
  end
  if stage.type == StageType.Arrange or stage.type == StageType.WeakArrange or stage.type == StageType.OnceArrange then
    self:showBattleList(index)
  end
end

function BaseCarbonBattleLayer:onTouchPlayer(playerId)
  local curPlayer = self:getPlayerData(playerId)
  local stageIndex = curPlayer.stage
  local stage = self.mapInfo[stageIndex]
  if not self.selectPlayerId then
    self:onSelectPlayer(playerId)
  elseif self.selectPlayerId == playerId then
    local function exitTeam()
      if #self.battleInfo.playerList <= 1 then
        MDialog:double({
          text = "终止作战将丢失当前作战进度\n \n主厨，确定要终止吗？"
        }, function()
          self:sendExitGame()
        end)
      else
        self:exitTeam(playerId)
      end
      BackManager:pop()
    end
    
    if stage.type == StageType.Supply then
      local layer = game:createView("hero.BattleListLayer", {
        battleType = self:getActionCodes().battleType,
        heroInfo = self:getBattleData().heroList or {},
        battle = "补给",
        num = #self.battleInfo.playerList,
        index = curPlayer.format,
        callback = function(choose)
          self:sendSupplyRpc()
          BackManager:pop()
        end,
        cancelCall = exitTeam
      })
      BackManager:push(function()
        TopBar:show(TopBarType.full)
        layer:close()
      end)
    else
      local layer = game:createView("hero.BattleListLayer", {
        battleType = self:getActionCodes().battleType,
        heroInfo = self:getBattleData().heroList or {},
        battle = "确定",
        num = #self.battleInfo.playerList,
        index = curPlayer.format,
        callback = function(choose)
          BackManager:pop()
        end,
        cancelCall = exitTeam
      })
      BackManager:push(function()
        TopBar:show(TopBarType.full)
        layer:close()
      end)
    end
  else
    local oldPlayer = self:getPlayerData(self.selectPlayerId)
    if self.movePathTemp and self.movePathTemp[curPlayer.stage] then
      self:showBehaviour({
        stageIndex = stageIndex,
        mode1 = "change",
        mode2 = "select"
      })
    else
      self:unSelectPlayer(self.selectPlayerId)
      self:onSelectPlayer(playerId)
    end
  end
end

function BaseCarbonBattleLayer:onSelectPlayer(playerId)
  local curPlayer = self:getPlayerData(playerId)
  local stageIndex = curPlayer.stage
  local stage = self.mapInfo[stageIndex]
  self.selectPlayerId = playerId
  curPlayer.spine:setAnimation(0, "move", true)
  local arrow = UIHelper.createSpineNodeByRes("spine/ui/carbon/xzjt"):pos(0, 180):addTo(curPlayer.display):name("arrow")
  arrow:setAnimation(0, "special", true)
  self:showMoveAble(stageIndex)
  if stage.conquer ~= 1 then
    return
  end
  if stage.type == StageType.Arrange or stage.type == StageType.WeakArrange or stage.type == StageType.OnceArrange then
    self:showBehaviour({stageIndex = stageIndex, mode1 = "exit"})
  elseif stage.type == StageType.Supply then
    self:showBehaviour({stageIndex = stageIndex, mode1 = "stage"})
  end
end

function BaseCarbonBattleLayer:unSelectPlayer(playerId)
  local player = self:getPlayerData(playerId)
  if player then
    player.spine:setAnimation(0, "idle", true)
    player.display:removeChildByName("arrow")
  end
  self.selectPlayerId = nil
  self:clearMoveAlbe()
end

function BaseCarbonBattleLayer:clearBehaviour()
  self.behaviourLayer:removeAllChildren()
end

function BaseCarbonBattleLayer:showBehaviour(params)
  self.behaviourLayer:removeAllChildren()
  local stage = self.mapInfo[params.stageIndex]
  local stageDis = self.mapDisData[stage.mapId]
  local stageIndex = params.stageIndex
  local TipString = {
    move = "移动",
    change = "交换",
    select = "选中"
  }
  
  local function GetButtonWays(type)
    if type == "exit" then
      if #self.battleInfo.playerList <= 1 then
      else
        return "撤退"
      end
    elseif type == "stage" then
      if stage.type == StageType.Arrange or stage.type == StageType.WeakArrange or stage.type == StageType.OnceArrange then
        return "召唤"
      end
      if stage.type == StageType.Supply then
        return "补给"
      end
    elseif type == "move" then
      if self.battleInfo.movePoint <= 0 then
        return
      end
      return TipString[type]
    else
      return TipString[type]
    end
  end
  
  local function GetButtonFunc(type)
    if type == "stage" then
      if stage.type == StageType.Arrange or stage.type == StageType.WeakArrange or stage.type == StageType.OnceArrange then
        return self:showBattleList(stageIndex)
      end
      if stage.type == StageType.Supply then
        return self:sendSupplyRpc()
      end
    elseif type == "select" then
      local player = self:getPlayerData(stage.playerId, self.battleInfo.playerList)
      if player then
        if self.selectPlayerId then
          self:unSelectPlayer(self.selectPlayerId)
        end
        self:onSelectPlayer(stage.playerId)
      end
    elseif type == "exit" then
      self:exitTeam(stage.playerId)
    elseif type == "move" then
      local curPlayer = self:getPlayerData(self.selectPlayerId)
      if not self:adjacentTwoPoint(curPlayer.stage, stageIndex) then
        self:startAutoMove(stageIndex)
      else
        self:movePlayer(stageIndex)
      end
    elseif type == "change" then
      local curPlayer = self:getPlayerData(self.selectPlayerId)
      if not self:adjacentTwoPoint(curPlayer.stage, stageIndex) then
        self:startAutoMove(stageIndex)
      else
        self:sendChangePos(self.selectPlayerId, stageIndex)
      end
    end
  end
  
  local xpos, ypos = stageDis.xpos, stageDis.ypos
  if params.mode1 then
    local text = GetButtonWays(params.mode1)
    if text then
      local quickBtn = UIHelper.extend(ccui.Button:create())
      quickBtn:setImages("ui/carbon/battle/", {"action.png", "action.png"})
      quickBtn:pos(xpos + 100, ypos + 50):addTo(self.behaviourLayer)
      display.newTTFLabel({
        text = text,
        size = 18,
        color = UIHelper.hex2rgb("#ffffff")
      }):enableOutline(UIHelper.hex2rgb("#410909"), 1):center(quickBtn):addTo(quickBtn)
      quickBtn:runAction(transition.sequence({
        cc.Spawn:create({
          cc.FadeIn:create(0.5 / self:getSpeedMult()),
          cc.MoveBy:create(0.5 / self:getSpeedMult(), cc.p(10, -10))
        })
      }))
      quickBtn:setCallback(function()
        GetButtonFunc(params.mode1)
        self:clearBehaviour()
      end)
    end
  end
  if params.mode2 then
    local text = GetButtonWays(params.mode2)
    if text then
      local quickBtn = UIHelper.extend(ccui.Button:create())
      quickBtn:setImages("ui/carbon/battle/", {"action.png", "action.png"})
      quickBtn:pos(xpos + 69, ypos + 2):addTo(self.behaviourLayer)
      display.newTTFLabel({
        text = text,
        size = 18,
        color = UIHelper.hex2rgb("#ffffff")
      }):enableOutline(UIHelper.hex2rgb("#410909"), 1):center(quickBtn):addTo(quickBtn)
      quickBtn:runAction(transition.sequence({
        cc.Spawn:create({
          cc.FadeIn:create(0.5 / self:getSpeedMult()),
          cc.MoveBy:create(0.5 / self:getSpeedMult(), cc.p(-10, 10))
        })
      }))
      quickBtn:setCallback(function()
        GetButtonFunc(params.mode2)
        self:clearBehaviour()
      end)
    end
  end
end

function BaseCarbonBattleLayer:showBattleList(index)
  if not self:getBattleNum() then
    SysError(SYS_ERR_CARBON_NO_TEAM_AVAILABLE)
    return
  end
  self.open = true
  local layer = game:createView("hero.BattleListLayer", {
    battleType = self:getActionCodes().battleType,
    heroInfo = self:getBattleData().heroList or {},
    battle = "召唤",
    callback = function(choose)
      local format = game.role.formation[tostring(choose)]
      if not format then
        return
      end
      if self:getActionCodes().battleType ~= BattleType.Paradise then
        for slot, id in pairs(format.list) do
          local hero = game.role.heros[id]
          if hero.hpPercent == 0 then
            SysError(SYS_ERR_FIGHT_SET_NO_HP)
            return
          end
        end
      end
      local state = game.role:getFormationState(choose)
      if state[1] then
        SysError(SYS_ERR_HERO_LOCKED_CURE_FIGHT)
        return
      end
      if self.newGame then
        self:newGameArrange(choose, index)
      else
        if 0 >= self.battleInfo.movePoint then
          SysError(SYS_ERR_FIGHT_MOVEPOINT_NOT_ENOUGH)
          return
        end
        self:sendArrange({
          [choose] = index
        })
      end
      return true
    end,
    cancelCall = function(choose, currentLayer)
      local format = game.role.formation[tostring(choose)]
      if not format then
        return
      end
      local need, material1, material2 = false, 0, 0
      for slot, id in pairs(format.list) do
        local hero = game.role.heros[id]
        if hero.material1 < 100 or 100 > hero.material2 then
          need = true
        end
        local temp1, temp2 = hero:getMaterialCost()
        material1 = material1 + temp1
        material2 = material2 + temp2
      end
      if not need then
        SysError(SYS_ERR_START_SUPPLY_FULL)
        return
      end
      if material1 > game.role.material1 or material2 > game.role.material2 then
        SysError(SYS_ERR_FIGHT_SUPPLY_NOT_ENOUGH)
        return
      end
      game:sendData(self:getActionCodes().supplyRpc, MsgPack.pack({id = choose}))
      UIHelper.showWaiting()
      game:addResponseHandler(self:getActionCodes().supplyRpc, function(event)
        UIHelper.removeWaiting()
        SysError(SYS_ERR_CARBON_SUPPLY_SUCCESS)
        currentLayer:showFormation(choose)
        currentLayer:showDes(-material1, -material2)
        for _, player in pairs(self.battleInfo.playerList) do
          if player.format == choose then
            self:updateMaterialBar(player)
          end
        end
        if self.newGame and self.arrange[choose] then
          self:updateMaterialBar(self.arrange[choose].player)
        end
      end)
    end,
    cureCall = function(choose)
      for _, player in pairs(self.battleInfo.playerList) do
        if player.format == choose then
          self:updateMaterialBar(player)
        end
      end
      if self.newGame and self.arrange[choose] then
        self:updateMaterialBar(self.arrange[choose].player)
      end
    end
  })
  BackManager:push(function()
    layer:close()
    self.open = false
    TopBar:show(TopBarType.full)
  end)
end

function BaseCarbonBattleLayer:adjacentTwoPoint(index1, index2)
  local mapSet = self.mapData[index1]
  for _, index in ipairs(mapSet.neighbor:toArray("=", true)) do
    if index == index2 then
      return true
    end
  end
  return false
end

function BaseCarbonBattleLayer:movePlayer(index)
  local info = self.mapInfo[index]
  local player = self:getPlayerData(self.selectPlayerId, self.battleInfo.playerList)
  local battleInfo = json.decode(self:getBattleInfo())
  if battleInfo.select then
    return
  end
  if self.battleInfo.moveType == 2 then
    SysError(SYS_ERR_FIGHT_MOVE_ENEMY_ROUND)
    return
  end
  if self.battleInfo.movePoint <= 0 then
    SysError(SYS_ERR_FIGHT_MOVEPOINT_NOT_ENOUGH)
    return
  end
  self:sendMove(self.selectPlayerId, index)
end

function BaseCarbonBattleLayer:setStage(index, conquer)
  local stage = self.mapInfo[index]
  local oldConquer = stage.conquer
  self.battleInfo.mapStatus.conquer[index] = conquer
  self.mapInfo[index].conquer = conquer
  if oldConquer ~= conquer then
    self:changeStage(index, conquer, oldConquer)
  end
end

function BaseCarbonBattleLayer:changeStage(index, conquer, oldState)
  local type = self.mapInfo[index].type
  local stage = self.mapInfo[index].stage
  local spine = stage.spine
  if type == StageType.Box or type == StageType.attrUp or type == StageType.WeakEnemyArrange or type == StageType.Cross then
    return
  end
  if type == StageType.Cure then
    if conquer == 1 then
      spine:setAnimation(1, "zhonglibianwofang", false)
      game:playMusic(1800)
      spine:setToSetupPose()
    end
    return
  end
  if type ~= StageType.Common and type ~= StageType.Select and type ~= StageType.RandSelect then
    if oldState == 0 then
      if conquer == 2 then
        spine:setAnimation(1, "zhonglibiandifang", false)
        game:playMusic(1801)
      else
        spine:setAnimation(1, "zhonglibianwofang", false)
        game:playMusic(1800)
      end
    elseif oldState == 1 then
      spine:setAnimation(1, "wofangbiandifang", false)
      game:playMusic(1801)
    elseif oldState == 2 then
      spine:setAnimation(1, "difangbianwofang", false)
      game:playMusic(1800)
    end
    stage:runAction(transition.sequence({
      cc.DelayTime:create(0.9 / self:getSpeedMult()),
      cc.CallFunc:create(function()
        if conquer == 1 then
          spine:setAnimation(0, "wofang", true)
        else
          spine:setAnimation(0, "difang", true)
        end
        spine:setToSetupPose()
      end)
    }))
  end
end

function BaseCarbonBattleLayer:setStageConquer(index, conquer)
  local stage = self.mapInfo[index]
  stage.conquer = conquer
  local temp = stage.stage
  local spine = temp.spine
  if not spine then
    return
  end
  if stage.type == StageType.attrUp then
    return
  end
  self.battleInfo.mapStatus.conquer[index] = conquer
  if stage.type == StageType.WeakEnemyArrange or stage.type == StageType.Box or stage.type == StageType.SupplyMaterial or stage.type == StageType.SupplyStep then
    if self.battleInfo.stageExtra and self.battleInfo.stageExtra[index] then
      spine:hide()
    else
      if conquer == 1 then
        spine:setAnimation(0, "wofang", true)
      else
        spine:setAnimation(0, "zhongli", true)
      end
      spine:setToSetupPose()
    end
  elseif stage.type ~= StageType.Common and stage.type ~= StageType.Select and stage.type ~= StageType.RandSelect and stage.type ~= StageType.Cross and stage.type ~= StageType.Cure then
    if conquer == 1 then
      spine:setAnimation(0, "wofang", true)
    elseif conquer == 2 then
      spine:setAnimation(0, "difang", true)
    elseif conquer == 0 then
      spine:setAnimation(0, "zhongli", true)
    end
    spine:setToSetupPose()
  end
end

function BaseCarbonBattleLayer:weatherEffect(weather)
  self.weatherLayer:removeAllChildren()
  local effect
  if weather == 2 then
    effect = UIHelper.createSpineNodeByRes("spine/ui/carbon/dashu")
    effect:setAnimation(0, "special", true)
    effect:pos(display.width / 2 + 10, display.height / 2 + 300):addTo(self.weatherLayer)
    effect:setOpacity(204)
  elseif weather == 3 then
    effect = cc.ParticleRain:create()
    effect:setTexture(cc.Director:getInstance():getTextureCache():addImage("ui/global/rain.png"))
    effect:addTo(self.weatherLayer)
    effect:setStartSize(10)
    effect:setStartSizeVar(0)
    effect:setEndSize(20)
    effect:setEndSizeVar(5)
    effect:setSpeed(800)
  elseif weather == 4 then
    effect = cc.ParticleSnow:create()
    effect:setTexture(cc.Director:getInstance():getTextureCache():addImage("ui/global/snow.png"))
    effect:addTo(self.weatherLayer)
    effect:setStartSize(20)
    effect:setStartSizeVar(0)
    effect:setEndSize(10)
    effect:setEndSizeVar(5)
    effect:setSpeed(200)
  end
  if UIHelper.isiPhoneX() and effect then
    UIHelper.fitForiPhoneX(effect)
  end
  local strs = {
    "普通的日子，没有特殊效果",
    "制造者变成突击者",
    "渣滓的攻击力+50%，吞食者层数变为0",
    "吞食者无法通过吞食提升饱食度"
  }
  if not self.weatherText then
    return
  end
  self.weatherText:setString(strs[weather])
end

function BaseCarbonBattleLayer:refreashUI()
  self.labelDay:setString(string.format("%02d", self.battleInfo.day))
  self.labelPoint:setString(self.battleInfo.movePoint)
  self.cancelText:setString(string.format("%02d", self.battleInfo.moveCancel))
  local oldWeather = self.currentWeather
  self.currentWeather = self.battleInfo.weather[self.battleInfo.day]
  self.nextWeather = self.battleInfo.weather[self.battleInfo.day + 1]
  if not oldWeather or oldWeather ~= self.currentWeather then
    self:weatherEffect(self.currentWeather)
    self.weatherNow:setTexture(BattleRes .. string.format("weather_%d.png", self.currentWeather))
    self.weatherNext:setTexture(BattleRes .. string.format("weather_%s.png", self.nextWeather))
  end
  self.weatherBar:setPercentage(self.battleInfo.day / 15 * 100)
  local lastChangeDay = #self.battleInfo.weather - self.battleInfo.day + 1
  for i = self.battleInfo.day + 1, 16 do
    if self.battleInfo.weather[i] ~= self.currentWeather then
      lastChangeDay = i - self.battleInfo.day
      break
    end
  end
  self.weatherLastLab:setString(lastChangeDay .. "天后天气变化")
  self:refreashLastTime()
  self:refreshRightAngle()
end

function BaseCarbonBattleLayer:refreshRightAngle()
  if not self.newGame then
    if self.angle_2 then
      self.angle_2:removeFromParent()
      self.angle_2 = nil
    end
    if self.zbInfo then
      self.zbInfo:removeFromParent()
      self.zbInfo = nil
    end
  end
  if self.battleInfo.moveType == 1 then
    self.btnOk:setEnabled(true)
    self.btnSpine:setToSetupPose()
    if self.battleInfo.movePoint == 0 then
      self.btnSpine:setAnimation(1, "end2", true)
    else
      self.btnSpine:setAnimation(1, "end", true)
    end
  else
    self.btnOk:setEnabled(false)
    self.btnSpine:setToSetupPose()
    self.btnSpine:setAnimation(1, "move", true)
  end
end

function BaseCarbonBattleLayer:refreashLastTime()
  self.labelHour:stopAllActions()
  if self.battleInfo.moveType == 1 and not self.newGame then
    self.timeSlot:show()
    local setTime
    
    function setTime()
      local leftTime = self.battleInfo.moveTime - game:nowTime()
      if 0 <= leftTime then
        self.labelHour:setString(UIHelper.getTimeStr(leftTime, true) .. "后敌方回合")
        self.labelHour:runAction(transition.sequence({
          cc.DelayTime:create(1),
          cc.CallFunc:create(function()
            setTime()
          end)
        }))
      end
    end
    
    setTime()
  else
    self.timeSlot:hide()
    self.labelHour:setString("")
  end
end

function BaseCarbonBattleLayer:refreshBuildSpine(index, conquer)
  local type = self.mapInfo[index].type
  if type == StageType.Common or type == StageType.Select or type == StageType.RandSelect then
    return
  end
  if (type == StageType.WeakArrange or type == StageType.OnceArrange) and self.battleInfo.mapStatus.enemyTime[index] == 1 then
    return
  end
  if type == StageType.WeakEnemyArrange and self.battleInfo.mapStatus.playerTime[index] == 1 then
    return
  end
  if type == StageType.Cure or type == StageType.attrUp or type == StageType.Cross or type == StageType.Box then
    return
  end
  local stage = self.mapInfo[index].stage
  local spine = stage.spine
  if conquer == 0 then
    spine:setAnimation(0, "zhongli", true)
  elseif conquer == 1 then
    spine:setAnimation(0, "wofang", true)
  elseif conquer == 2 then
    spine:setAnimation(0, "difang", true)
  end
end

function BaseCarbonBattleLayer:showSupplyDialog()
  local function showDialog()
    local tip = self.tipLayer:getChildByName("supply")
    
    if not tolua.isnull(tip) then
      tip:removeFromParent()
    end
    if not self.battleInfo.moveType or self.battleInfo.moveType ~= 1 then
      return
    end
    for _, stage in pairs(self.mapInfo) do
      if stage.type == StageType.Supply and self:isStageOpen(_) and not stage.playerId and not stage.enemyId then
        local stageDis = self.mapDisData[stage.mapId]
        local dialogBg = display.newSprite(BattleRes .. "dialog_bg.png"):anch(0, 0):pos(stageDis.xpos, stageDis.ypos + 50):addTo(self.tipLayer):name("supply")
        dialogBg:setCascadeOpacityEnabled(true)
        display.newTTFLabel({
          text = "资源不足，可以在这补给哦。",
          size = 18,
          color = UIHelper.hex2rgb("#2a8507"),
          dimensions = cc.size(170, 40)
        }):pos(93, 32):addTo(dialogBg)
        dialogBg:runAction(transition.sequence({
          cc.DelayTime:create(10),
          cc.FadeOut:create(0.3),
          cc.RemoveSelf:create()
        }))
        break
      end
    end
  end
  
  showDialog()
  self.tipLayer:stopAllActions()
  self.tipLayer:runAction(cc.RepeatForever:create(transition.sequence({
    cc.DelayTime:create(20),
    cc.CallFunc:create(function()
      showDialog()
    end)
  })))
end

function BaseCarbonBattleLayer:updateMaterialBar(player)
  local materialNode = player.materialNode
  materialNode:removeAllChildren()
  local percent1, percent2, percent3 = game.role:getMaterialPercent(player.format)
  local materialbar = display.newSprite(BattleRes .. "kuang.png"):pos(80, 100):addTo(materialNode)
  local barSlot1 = display.newSprite(BattleRes .. "kuang_2.png"):pos(30, 20):addTo(materialbar)
  local bar1 = display.newProgressTimer(BattleRes .. (37 < percent1 and "kuang_4.png" or "kuang_3.png"), display.PROGRESS_TIMER_RADIAL)
  bar1:setScaleX(-1)
  bar1:center(barSlot1):addTo(barSlot1, -1)
  bar1:setBarChangeRate(cc.p(1, 0))
  bar1:setPercentage(percent1)
  local coin1 = display.newSprite("ui/global/base_1.png"):scale(0.7):center(barSlot1):addTo(barSlot1)
  local barSlot2 = display.newSprite(BattleRes .. "kuang_2.png"):pos(70, 20):addTo(materialbar)
  local bar2 = display.newProgressTimer(BattleRes .. (37 < percent2 and "kuang_4.png" or "kuang_3.png"), display.PROGRESS_TIMER_RADIAL)
  bar2:setScaleX(-1)
  bar2:center(barSlot2):addTo(barSlot2, -1)
  bar2:setBarChangeRate(cc.p(1, 0))
  bar2:setPercentage(percent2)
  local coin2 = display.newSprite("ui/global/base_2.png"):scale(0.8):center(barSlot2):addTo(barSlot2)
  display.newTTFLabel({
    text = "套餐" .. player.format,
    size = 14,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(20, -10):addTo(materialbar)
  display.newSprite(BattleRes .. "small_1.png"):pos(65, -10):addTo(materialbar)
  local bar3 = display.newProgressTimer(BattleRes .. "small_2.png", display.PROGRESS_TIMER_BAR)
  bar3:pos(65, -10):addTo(materialbar)
  bar3:setMidpoint(cc.p(0, 0.5))
  bar3:setBarChangeRate(cc.p(1, 0))
  bar3:setPercentage(percent3)
  if percent1 <= 25 or percent2 <= 25 then
    local dialog = display.newSprite(BattleRes .. "dialog_bg.png")
    dialog:pos(60, 70):addTo(materialbar)
    local text
    if percent1 <= 25 and 25 < percent2 then
      text = "没有吃的，要饿昏过去了……"
    elseif percent2 <= 25 and 25 < percent1 then
      text = "没有力气战斗了……"
    else
      text = "需要……补给，不然的话……"
    end
    display.newTTFLabel({
      text = text,
      size = 18,
      color = UIHelper.hex2rgb("#c94708"),
      dimensions = cc.size(170, 40)
    }):pos(90, 32):addTo(dialog)
    dialog:runAction(transition.sequence({
      cc.DelayTime:create(3),
      cc.RemoveSelf:create()
    }))
    if percent1 <= 25 then
      coin1:runAction(cc.RepeatForever:create(transition.sequence({
        cc.FadeOut:create(1),
        cc.FadeIn:create(1)
      })))
    end
    if percent2 <= 25 then
      coin2:runAction(cc.RepeatForever:create(transition.sequence({
        cc.FadeOut:create(1),
        cc.FadeIn:create(1)
      })))
    end
  end
end

function BaseCarbonBattleLayer:showArrangeTip()
  self.tipLayer:removeAllChildren()
  if not self.newGame then
    return
  end
  local arrange = {}
  for format, data in pairs(self.arrange) do
    arrange[data.stageIndex] = true
  end
  for index, stage in ipairs(self.mapInfo) do
    if not stage.playerId and not arrange[index] and stage.conquer == 1 then
      local showTip = false
      if stage.type == StageType.WeakArrange or self.mapInfo[index].type == StageType.OnceArrange then
        showTip = true
        if self.battleInfo.mapStatus and self.battleInfo.mapStatus.enemyTime and self.battleInfo.mapStatus.enemyTime[index] == 1 then
          showTip = false
        end
      end
      if stage.type == StageType.Arrange then
        showTip = true
      end
      if stage.open == 0 then
        showTip = false
      end
      if showTip then
        local stageDis = self.mapDisData[stage.mapId]
        local effect = UIHelper.createSpineNodeByRes("spine/ui/carbon/summon")
        effect:pos(stageDis.xpos, stageDis.ypos + 40):addTo(self.tipLayer)
        effect:setAnimation(0, "special", true)
      end
    end
  end
end

function BaseCarbonBattleLayer:convertPos(index)
  local stageInfo = self.mapInfo[index]
  local data = self.mapDisData[stageInfo.mapId]
  local size = self.mapSize
  local zoomSize = {
    width = size.width * self.zoom,
    height = size.height * self.zoom
  }
  local xpos = data.xpos * self.zoom
  local ypos = data.ypos * self.zoom
  if xpos + display.width / 2 >= zoomSize.width then
    xpos = zoomSize.width - display.width / 2
  end
  if ypos + display.height / 2 >= zoomSize.height then
    ypos = zoomSize.height - display.height / 2
  end
  local resultX = display.width / 2 - xpos
  local resultY = display.height / 2 - ypos
  if xpos < display.width / 2 then
    resultX = 0
  end
  if ypos < display.height / 2 then
    resultY = 0
  end
  return resultX, resultY
end

function BaseCarbonBattleLayer:comeToCamera(from)
  if not self:scaleIsCanMove() then
    return
  end
  local xpos, ypos = self:convertPos(from)
  self.map:setPositionX(xpos)
  self.map:setPositionY(ypos)
end

function BaseCarbonBattleLayer:resetCamera()
  if not self.lastCamera then
    return
  end
  self.zoom = self.lastCamera.zoom
  self:setZoom(self.zoom)
  self.map:setPosition(self.lastCamera.xpos, self.lastCamera.ypos)
end

function BaseCarbonBattleLayer:moveCamera(to, time, callback, tempTime)
  if not self:scaleIsCanMove() then
    self.map:runAction(transition.sequence({
      cc.DelayTime:create(tempTime and tempTime / self:getSpeedMult() or 0),
      cc.CallFunc:create(function()
        callback()
      end)
    }))
  else
    local xpos, ypos = self:convertPos(to)
    self.map:runAction(transition.sequence({
      cc.MoveTo:create(time / self:getSpeedMult(), cc.p(xpos, ypos)),
      cc.CallFunc:create(function()
        callback()
      end)
    }))
  end
end

function BaseCarbonBattleLayer:showRightPanel(move, btn)
  self.activeBg:setVisible(move)
  if btn then
    if not self.btnOk:isVisible() then
      self.btnSpine:setToSetupPose()
      self.btnSpine:setAnimation(1, "noStart", false)
      self.btnSpine:addAnimation(1, "start", true)
      if self.angle_2 then
        self.angle_2:runAction(transition.sequence({
          cc.MoveBy:create(0.5 / self:getSpeedMult(), cc.p(self.angle_2:getContentSize().width, -self.angle_2:getContentSize().height)),
          cc.CallFunc:create(function()
            self.angle_2:removeFromParent()
            self.angle_2 = nil
          end)
        }))
      end
    end
    self.btnOk:show()
  else
    self.btnOk:hide()
  end
end

function BaseCarbonBattleLayer:cameraScale()
  if self.zoom >= self.carbonData.minZoom + 0.02 then
    self.map:runAction(transition.sequence({
      cc.DelayTime:create(0.03 / self:getSpeedMult()),
      cc.CallFunc:create(function()
        self:setZoom(self.zoom - 0.02)
        self:cameraScale()
        local width = self.mapSize.width * self.zoom
        local height = self.mapSize.height * self.zoom
        self.map:pos((display.width - width) / 2, (display.height - height) / 2)
      end)
    }))
  else
    self:setZoom(self.carbonData.minZoom)
    self.dragLayer:setTouchEnabled(false)
    self.map:stopAllActions()
    self.map:runAction(transition.sequence({
      cc.DelayTime:create(0.5 / self:getSpeedMult()),
      cc.CallFunc:create(function()
        self:cameraScaleToNormal()
      end)
    }))
  end
end

function BaseCarbonBattleLayer:cameraScaleToNormal()
  if self.zoom <= self.MapMaxZoom then
    self.map:runAction(transition.sequence({
      cc.DelayTime:create(0.02 / self:getSpeedMult()),
      cc.CallFunc:create(function()
        self:setZoom(self.zoom + 0.01, true, true)
        self:cameraScaleToNormal()
      end)
    }))
  else
    local function stopAction()
      self.dragLayer:setTouchEnabled(true)
      
      self.map:stopAllActions()
      self:showGuide()
    end
    
    self:setZoom(self.MapMaxZoom)
    self:moveCamera(self.carbonData.initStage, 0.5, stopAction, 1.5)
  end
end

function BaseCarbonBattleLayer:onCancel()
  if self:isPassTime() then
    MDialog:single({
      text = "时间超过无法回撤"
    }, function()
    end)
    return
  end
  local tempBattle = json.decode(self:getBattleInfo())
  if tempBattle.moveCancel and tempBattle.moveCancel <= 0 then
    MDialog:single({
      text = "已经没有撤销次数了"
    }, function()
    end)
    return
  end
  if tempBattle.lastMove and 0 < #tempBattle.lastMove and tempBattle.moveCancel > 0 then
    game:sendData(self:getActionCodes().cancelMoveRpc, MsgPack.pack(""))
    UIHelper.showWaiting()
    game:addResponseHandler(self:getActionCodes().cancelMoveRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      self.battleInfo.lastMove = msg.move
      self.battleInfo.movePoint = self.battleInfo.movePoint + 1
      self.battleInfo.moveCancel = self.battleInfo.moveCancel - 1
      self:clearBehaviour()
      if #self.curEvents == 0 then
        self.curEvents = msg.events or {}
        self:showData()
      else
        for key, event in ipairs(msg.events) do
          table.insert(self.curEvents, event)
        end
      end
    end)
  else
    local battleInfo = json.decode(self:getBattleInfo())
    local type = not tempBattle.lastMove and 0 or battleInfo.reason
    local desc = {
      [0] = "请先开始行动",
      [1] = "食灵在激战后疲惫不堪，没有力气回撤了…",
      [2] = "由于建筑的特殊效果，套餐无法回撤了！",
      [3] = "食灵们已经撤退，无法再回撤了…",
      [4] = "交换位置后食灵十分疲惫，无法进行回撤了…"
    }
    MDialog:single({
      text = desc[type] or "只有移动后才可以回撤套餐哟！"
    }, function()
    end)
  end
end

function BaseCarbonBattleLayer:onSelect()
  local battleInfo = json.decode(self:getBattleInfo())
  if not battleInfo.select then
    self:showData()
    return
  end
  self.battleInfo.select = battleInfo.select
  
  local function selectFunc(index, layer)
    game:sendData(self:getActionCodes().SelectRpc, MsgPack.pack({selectId = index}))
    UIHelper.showWaiting()
    game:addResponseHandler(self:getActionCodes().SelectRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      local items = {}
      for _, data in ipairs(msg.select or {}) do
        if data.type == "resource" then
          items[data.param1] = (items[data.param1] or 0) + data.param2
        end
      end
      self:showItemReward(items)
      battleInfo = json.decode(self:getBattleInfo())
      self.battleInfo.select = battleInfo.select
      self.curEvents = msg.events
      self:showData()
      layer:close()
    end)
  end
  
  game:createView("carbon.CarbonSelectLayer", {
    id = battleInfo.select.id,
    callback = selectFunc
  })
end

function BaseCarbonBattleLayer:onNewGame()
  self.battleInfo = {
    carbonId = self.carbonId,
    movePoint = self.carbonData.move,
    moveTime = game:nowTime() + globalCsv.roundTime * 60,
    moveCancel = 0,
    day = 1,
    enemyList = {},
    playerList = {},
    lastMove = {},
    eventList = {},
    moveType = 1,
    weather = {},
    open = {},
    boxNum = {},
    attrUp = 0,
    kills = {}
  }
  local id = 1
  local extraBattle = json.decode(game.role.extraBattle)
  local stageId
  local use = true
  if extraBattle.carbonId and extraBattle.carbonId == self.carbonId then
    stageId = self.carbonData.ghostSet
  end
  for stageIndex, enemyId in pairs(self.carbonData.monsterSet:toNumMap()) do
    if stageId and stageId == stageIndex then
      table.insert(self.battleInfo.enemyList, {
        id = id,
        enemyId = extraBattle.curMonster,
        stage = stageIndex,
        energy = self.carbonData.initDevour
      })
      use = false
    else
      table.insert(self.battleInfo.enemyList, {
        id = id,
        enemyId = enemyId,
        stage = stageIndex
      })
    end
    id = id + 1
  end
  if extraBattle.carbonId and extraBattle.carbonId == self.carbonId and use then
    table.insert(self.battleInfo.enemyList, {
      id = id,
      enemyId = extraBattle.curMonster,
      stage = stageId,
      energy = self.carbonData.initDevour
    })
  end
  local weather = self.carbonData.weather:toTableArray()
  local day = 0
  while day < 16 do
    for _, data in pairs(weather) do
      for index = 1, tonumber(data[2]) do
        day = day + 1
        self.battleInfo.weather[day] = tonumber(data[1])
      end
    end
  end
  self.newGame = true
end

function BaseCarbonBattleLayer:newGameArrange(format, stageIndex)
  local info = self.arrange[format]
  if info and info.stageIndex == stageIndex then
    return
  end
  for _format, info in pairs(self.arrange) do
    info.player.display:removeSelf()
    if info.stageIndex == stageIndex then
      self.arrange[_format] = nil
    end
  end
  local player = {
    id = 0,
    stage = stageIndex,
    format = format
  }
  self.arrange[format] = {stageIndex = stageIndex, player = player}
  for _format, info in pairs(self.arrange) do
    local disData = self.mapDisData[self.mapInfo[info.stageIndex].mapId]
    local displayNode = display.newNode():pos(disData.xpos, disData.ypos):addTo(self.unitLayer)
    local formation = game.role.formation
    local heroId = formation[tostring(_format)].list["1"]
    local hero = game.role.heros[heroId]
    local spine = UIHelper.createSpineNode(hero:getDressType())
    spine:addTo(displayNode)
    spine:setAnimation(0, "idle", true)
    local materialNode = display.newNode():addTo(displayNode)
    info.player.display = displayNode
    info.player.materialNode = materialNode
    self:updateMaterialBar(info.player)
  end
  if not self.btnOk:isVisible() then
    self:showRightPanel(false, true)
  end
  self:showArrangeTip()
end

function BaseCarbonBattleLayer:onNext()
  if self.newGame then
    if next(self.arrange) then
      local arrange = {}
      for format, info in pairs(self.arrange) do
        arrange[format] = info.stageIndex
      end
      self:sendArrange(arrange)
    else
      SysError(SYS_ERR_FIGHT_NO_TEAM_SET)
    end
    return
  end
  if self.selectPlayerId then
    self:unSelectPlayer(self.selectPlayerId)
  end
  if self:isEndGame() then
    return
  end
  if self.battleInfo.moveType == 2 or self.isMoving then
    return
  end
  local battleInfo = json.decode(self:getBattleInfo())
  if battleInfo.select then
    return
  end
  self:clearMoveAlbe()
  
  local function nextFunc()
    self.lastCamera = {
      xpos = self.map:getPositionX(),
      ypos = self.map:getPositionY(),
      zoom = self.zoom
    }
    game:sendData(self:getActionCodes().actionEndRpc, MsgPack.pack(""))
    UIHelper.showWaiting()
    game:addResponseHandler(self:getActionCodes().actionEndRpc, function(event)
      UIHelper.removeWaiting()
      self.battleInfo.moveType = 2
      local msg = MsgPack.unpack(event.data)
      self:showRightPanel(false, true)
      self.endResult = msg.endResult
      self.dragLayer:setTouchEnabled(false)
      self:zoomTo(self.carbonData.minZoom)
      for _, event in ipairs(msg.events) do
        table.insert(self.curEvents, event)
      end
      self:showTip(ENEMY_TURN)
      self.btnSpine:setToSetupPose()
      self.btnSpine:setAnimation(1, "endMove", false)
      self.btnSpine:addAnimation(1, "move", true)
      self.btnInfo:runAction(transition.sequence({
        cc.DelayTime:create(2 / self:getSpeedMult()),
        cc.CallFunc:create(function()
          self:onRightTurn()
          self:showData()
        end)
      }))
    end)
  end
  
  if self.battleInfo.movePoint == self.battleInfo.lastPoint then
    MDialog:double({
      text = "主厨还没有移动套餐，确定要结束吗？"
    }, function()
      nextFunc()
    end)
  else
    nextFunc()
  end
end

function BaseCarbonBattleLayer:showTip(type, callback)
  self.turnLayer:removeAllChildren()
  UIHelper.newMask({
    size = cc.size(display.width, display.height)
  }):addTo(self.turnLayer):setTouchEnabled(true)
  local file = type == MY_TURN and "wfhh" or "dfhh"
  game:playMusic(1805)
  local spine = UIHelper.createSpineNodeByRes("ui/carbon/battle/" .. file)
  spine:pos(display.width / 2, display.height / 2):addTo(self.turnLayer)
  spine:setAnimation(0, "special", false)
  spine:setTimeScale(self:getSpeedMult())
  spine:registerSpineEventHandler(function(event)
    if event.animation ~= "special" then
      return
    end
    scheduler.performWithDelayGlobal(function()
      if type == MY_TURN then
        self:showResetDay()
      end
      if callback then
        callback()
      end
      self.turnLayer:removeAllChildren()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
end

function BaseCarbonBattleLayer:onLeftTurn(skipEffect)
  print(">>>>>>>>己方回合")
  self.battleInfo.moveType = 1
  
  local function action()
    self:returnSelect()
    self:refreashUI()
    if not self.selectPlayerId then
      if #self.battleInfo.playerList == 1 then
        self:onSelectPlayer(self.battleInfo.playerList[1].id)
      else
        SysError(SYS_ERR_CARBON_SELECT_TIP)
      end
    end
    self:showSupplyDialog()
    if not skipEffect then
      self:eventHandler()
      self:checkGuide()
    end
  end
  
  if skipEffect then
    action()
  else
    self:showTip(MY_TURN, action)
  end
end

function BaseCarbonBattleLayer:onRightTurn()
  print(">>>>>>>>敌方回合")
  self.battleInfo.moveType = 2
  self:refreashUI()
end

function BaseCarbonBattleLayer:showResetDay()
  if self.carbonData.endconditionType == 2 then
    return
  end
  local content = display.newSprite("ui/battle/tip_bg.png"):anch(1, 0.5):pos(0, display.height / 2):addTo(self.mapNode)
  if UIHelper.isiPhoneX() then
    content:setPositionX(content:getPositionX() + UIHelper.getMoveXForX())
  end
  local condition = self.carbonData.assessment:toTableArray()
  local limitDay1, limitDay2 = tonumber(condition[1][2]), tonumber(condition[2][2])
  if limitDay2 < self.battleInfo.day then
    local bg = display.newSprite(BattleRes .. "image_bg_1.png"):center(content):addTo(content)
    ui.newBMFontLabel({
      text = 15 - self.battleInfo.day + 1,
      font = "font/num.fnt"
    }):pos(530, 50):addTo(bg)
  else
    local limitDay = limitDay1 < self.battleInfo.day and limitDay2 or limitDay1
    local result = limitDay1 < self.battleInfo.day and "image_a.png" or "image_s.png"
    local bg = display.newSprite(BattleRes .. "image_bg_2.png"):center(content):addTo(content)
    display.newSprite(BattleRes .. result):pos(-25, 40):addTo(bg)
    ui.newBMFontLabel({
      text = limitDay - self.battleInfo.day + 1,
      font = "font/num.fnt"
    }):pos(410, 50):addTo(bg)
  end
  content:runAction(transition.sequence({
    cc.MoveBy:create(0.1 / self:getSpeedMult(), cc.p(display.width, 0)),
    cc.DelayTime:create(1.5 / self:getSpeedMult()),
    cc.MoveBy:create(0.1 / self:getSpeedMult(), cc.p(display.width, 0)),
    cc.RemoveSelf:create()
  }))
end

function BaseCarbonBattleLayer:showItemReward(items)
  if not next(items) then
    return
  end
  for itemId, count in pairs(items) do
    local itemSet = ItemCsv[itemId]
    local icon = display.newSprite(itemSet.icon)
    local cx, y = 510, 0
    if UIHelper.isiPhoneX() then
      cx = cx + UIHelper.getMoveXForX()
      y = 100
    end
    icon:pos(cx, display.cy):addTo(display.getRunningScene())
    icon:runAction(transition.sequence({
      cc.Spawn:create({
        cc.MoveTo:create(0.3, cc.p(cx + y + (itemId - 1) * 120, 625)),
        cc.ScaleTo:create(0.3, 0.1)
      }),
      cc.RemoveSelf:create(),
      cc.CallFunc:create(function()
        local label = display.newTTFLabel({
          text = "+" .. count,
          size = 26,
          color = display.COLOR_GREEN
        }):enableOutline(UIHelper.hex2rgb("#2c0000"), 2):pos(cx + 20 + (itemId - 1) * 120, 595):addTo(TopBar)
        label:runAction(transition.sequence({
          cc.Spawn:create({
            cc.FadeIn:create(0.3),
            cc.MoveBy:create(0.5, cc.p(0, 5))
          }),
          cc.DelayTime:create(0.9),
          cc.Spawn:create({
            cc.FadeOut:create(0.5),
            cc.MoveBy:create(0.5, cc.p(0, 15))
          }),
          cc.RemoveSelf:create()
        }))
      end)
    }))
  end
end

function BaseCarbonBattleLayer:zoomTo(zoom)
  self.zoom = zoom
  self.map:setScale(self.zoom)
  local size = self.mapSize
  local width = size.width * self.zoom
  local height = size.height * self.zoom
  self.map:pos((display.width - width) / 2, (display.height - height) / 2)
  local percent = (self.zoom - self.carbonData.minZoom) / (self.carbonData.maxZoom - self.carbonData.minZoom)
  self.zoomPoint:setPositionY(self.zoomBg:getContentSize().height * percent)
end

function BaseCarbonBattleLayer:setZoom(zoom, temp, extra)
  if math.floor(zoom * 10) > math.floor(self.carbonData.maxZoom * 10) then
    return
  end
  if math.floor(zoom * 10) < math.floor(self.carbonData.minZoom * 10) then
    return
  end
  local deltaZoom = zoom - self.zoom
  self.zoom = zoom
  self.map:setScale(self.zoom)
  local size = self.mapSize
  local width = size.width * self.zoom
  local height = size.height * self.zoom
  if width < display.width or height < display.height then
    self.map:pos((display.width - width) / 2, (display.height - height) / 2)
  else
    local xpos, ypos = self.map:getPosition()
    local resultX = xpos - self.mapSize.width * deltaZoom / 2
    local resultY = ypos - self.mapSize.height * deltaZoom / 2
    if 0 <= xpos and deltaZoom < 0 and xpos < display.width / 2 then
      resultX = 0
    end
    if xpos + width <= display.width and deltaZoom < 0 then
      resultX = display.width - width
    end
    if 0 <= ypos and deltaZoom < 0 then
      resultY = self.mapSize.height * deltaZoom / 2
    end
    if ypos + height <= display.height and deltaZoom < 0 then
      resultY = display.height - height
    end
    self.map:pos(resultX, resultY)
    if not temp then
      self.dragLayer:setTouchEnabled(true)
    end
  end
  if extra then
    self.map:pos((display.width - width) / 2, (display.height - height) / 2)
  end
  local percent = (self.zoom - self.carbonData.minZoom) / (self.carbonData.maxZoom - self.carbonData.minZoom)
  self.zoomPoint:setPositionY(self.zoomBg:getContentSize().height * percent)
end

function BaseCarbonBattleLayer:showData()
  if #self.curEvents > 0 then
    self:eventHandler()
  else
    if self.battleInfo.battle then
      self:onBattle()
      return
    end
    if self.battleInfo.select then
      self:onSelect()
      return
    end
  end
  self:checkGuide()
end

function BaseCarbonBattleLayer:onExit()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
  for k, v in pairs(self.weatherMusic) do
    game:stopMusic(v)
    self.weatherMusic[k] = nil
  end
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
end

function BaseCarbonBattleLayer:checkGuide()
  if game.role.majorGuideStep ~= 11 then
    return
  end
  if game.role.minorGuideStep >= 12 then
    return
  end
  if not self.guideNode then
    self.guideNode = display.newNode():addTo(display.getRunningScene(), NEW_GUIDE_LAYER_ORDER)
    UIHelper.newMask({
      size = cc.size(display.width, 90)
    }):anch(0, 1):pos(0, display.height):addTo(self.guideNode):setTouchEnabled(true)
  end
  NewGuideLayer.new({step = 11})
end

function BaseCarbonBattleLayer:sendMove(id, stage)
  local glView = cc.Director:getInstance():getOpenGLView()
  local framesize = glView:getFrameSize()
  local sendGameInfo
  
  function sendGameInfo()
    NetManager:removeEventListenersByEvent("networkLogin")
    NetManager:addEventListener("networkLogin", function()
      sendGameInfo()
    end)
    game:sendData(self:getActionCodes().moveRpc, MsgPack.pack({
      id = id,
      stage = stage,
      key = self.battleInfo.key or "zhaolu",
      w = math.floor(framesize.width * 10) / 10,
      h = math.floor(framesize.height * 10) / 10,
      s = math.floor(self.zoom * 10) / 10,
      n = cc.Native:getDeviceName()
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(self:getActionCodes().moveRpc, function(event)
      UIHelper.removeWaiting()
      NetManager:removeEventListenersByEvent("networkLogin")
      local msg = MsgPack.unpack(event.data)
      local events = msg.events
      self.endResult = msg.endResult
      self.curEvents = self.curEvents or {}
      if #self.curEvents == 0 then
        self.curEvents = events
        self:showData()
      else
        for key, event in ipairs(events) do
          table.insert(self.curEvents, event)
        end
      end
      self:decMovePoint()
      self:refreashUI()
    end)
  end
  
  sendGameInfo()
end

function BaseCarbonBattleLayer:decMovePoint()
  self.battleInfo.movePoint = self.battleInfo.movePoint - 1
end

function BaseCarbonBattleLayer:sendChangePos(id, stage)
  local sendGameInfo
  
  function sendGameInfo()
    NetManager:removeEventListenersByEvent("networkLogin")
    NetManager:addEventListener("networkLogin", function()
      sendGameInfo()
    end)
    game:sendData(self:getActionCodes().changePosRpc, MsgPack.pack({id = id, stage = stage}))
    UIHelper.showWaiting()
    game:addResponseHandler(self:getActionCodes().changePosRpc, function(event)
      UIHelper.removeWaiting()
      NetManager:removeEventListenersByEvent("networkLogin")
      local events = MsgPack.unpack(event.data)
      self.curEvents = events
      self:showData()
      self:refreashUI()
    end)
  end
  
  sendGameInfo()
end

function BaseCarbonBattleLayer:sendExitGame()
  game:sendData(self:getActionCodes().endCarbonRpc, MsgPack.pack(""))
  UIHelper.showWaiting()
  game:addResponseHandler(self:getActionCodes().endCarbonRpc, function(event)
    UIHelper.removeWaiting()
    self.content = display.newSprite("ui/battle/tip_bg.png"):anch(1, 0.5):pos(0, display.height / 2 + 100):addTo(self.mapNode)
    if UIHelper.isiPhoneX() then
      self.content:setPositionX(self.content:getPositionX() + UIHelper.getMoveXForX())
    end
    display.newSprite("ui/battle/battle_lose.png"):center(self.content):addTo(self.content)
    self.content:runAction(transition.sequence({
      cc.MoveBy:create(0.1, cc.p(display.width, 0)),
      cc.DelayTime:create(1.3),
      cc.MoveBy:create(0.1, cc.p(display.width, 0)),
      cc.CallFunc:create(function()
        if not self.battleInfo then
          return
        end
        local id
        for _, player in pairs(self.battleInfo.playerList) do
          id = player.format
        end
        if self.selectPlayerId then
          self:unSelectPlayer(self.selectPlayerId)
        end
        local msg = MsgPack.unpack(event.data)
        self:showExitResultLayer({
          endResult = msg.endResult,
          carbonId = self.carbonId,
          id = id
        })
      end),
      cc.RemoveSelf:create()
    }))
  end)
end

function BaseCarbonBattleLayer:sendSupplyRpc()
  local player = self:getPlayerData(self.selectPlayerId, self.battleInfo.playerList)
  if game.role:testSupplyFull(player.format) then
    SysError(SYS_ERR_START_SUPPLY_FULL)
    return
  end
  if not game.role:supplyFormation(player.format) then
    SysError(SYS_ERR_FIGHT_SUPPLY_NOT_ENOUGH)
    return
  end
  game:sendData(self:getActionCodes().supplyRpc, MsgPack.pack({
    id = player.format
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(self:getActionCodes().supplyRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    self.curEvents = msg
    self:updateMaterialBar(player)
    SysError(SYS_ERR_CARBON_SUPPLY_SUCCESS)
    self:showData()
  end)
end

function BaseCarbonBattleLayer:canNewGameArrange()
  return true
end

function BaseCarbonBattleLayer:sendArrange(arrange)
  if self.newGame and not self:canNewGameArrange() then
    return
  end
  game:sendData(self:getActionCodes().arrangeCarbonRpc, MsgPack.pack({
    carbonId = self.carbonId,
    arrange = arrange
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(self:getActionCodes().arrangeCarbonRpc, function(event)
    UIHelper.removeWaiting()
    game:playMusic(1802)
    self.curEvents = MsgPack.unpack(event.data)
    if tolua.isnull(self.unitLayer) then
      return
    end
    self.unitLayer:removeAllChildren()
    self:clearMoveAlbe()
    self.selectPlayerId = nil
    self:showRightPanel(true, true)
    self.battleInfo = json.decode(self:getBattleInfo())
    self:refreshMap()
    if self.newGame then
      self.newGame = false
      self.arrange = {}
      self:showArrangeTip()
      self.btnSpine:setToSetupPose()
      self.btnSpine:setAnimation(1, "startEnd", false)
      self.btnSpine:addAnimation(1, "end", true)
      if self.zbInfo then
        local x, y = self.zbInfo:getPosition()
        self.zbInfo:runAction(transition.sequence({
          cc.MoveBy:create(0.5 / self:getSpeedMult(), cc.p(0, -y)),
          cc.CallFunc:create(function()
            self.zbInfo:removeFromParent()
            self.zbInfo = nil
          end)
        }))
      end
      local format = self.battleInfo.playerList[1].format
      local heroId = game.role.formation[tostring(format)].list["1"]
      CommonHelper.playCV(game.role.heros[heroId].type, "set")
      self:onLeftTurn()
    else
      self:eventHandler()
      self:refreashUI()
    end
  end)
end

function BaseCarbonBattleLayer:BFS(src, dest)
  src = self.mapInfo[src].mapId
  dest = self.mapInfo[dest].mapId
  local S, visit, Path = {}, {}, {}
  visit[src] = true
  table.insert(S, src)
  for id, _ in pairs(self.mapDisData) do
    Path[id] = {}
  end
  while 0 < #S do
    local p = S[1]
    table.remove(S, 1)
    table.insert(Path[p], p)
    for _, q in ipairs(self.mapDisData[p].neighbor) do
      if not visit[q] then
        for _, _p in ipairs(Path[p]) do
          table.insert(Path[q], _p)
        end
        if q == dest then
          table.insert(Path[q], q)
          return Path[q]
        end
        visit[q] = true
        table.insert(S, q)
      end
    end
  end
  return false
end

function BaseCarbonBattleLayer:findCanMoveStage(curStageIndex)
  local canMove = {}
  local parent = {}
  local hadGo = {
    [curStageIndex] = true
  }
  local nextCheck = {curStageIndex}
  local curCheck = {}
  for step = 1, self.battleInfo.movePoint do
    curCheck = nextCheck
    nextCheck = {}
    if not next(curCheck) then
      break
    end
    for _, checkStage in ipairs(curCheck) do
      for _, index in ipairs(self.mapData[checkStage].neighbor:toArray("=", true)) do
        if self:isStageOpen(index) and not hadGo[index] then
          hadGo[index] = true
          table.insert(canMove, index)
          if self.mapInfo[index].playerId then
            table.insert(curCheck, index)
          elseif self.mapInfo[index].type == StageType.Cross then
          else
            table.insert(nextCheck, index)
          end
          if self.mapInfo[checkStage].type == StageType.Cross then
            if checkStage == curStageIndex then
              parent[index] = curStageIndex
            elseif self.mapInfo[checkStage].playerId then
              parent[index] = checkStage
            else
              parent[index] = self.mapData[checkStage].content
            end
          else
            parent[index] = checkStage
          end
        end
      end
    end
  end
  if self.battleInfo.movePoint == 0 then
    for _, index in ipairs(self.mapData[curStageIndex].neighbor:toArray("=", true)) do
      if self:isStageOpen(index) and not hadGo[index] then
        hadGo[index] = true
        if self.mapInfo[index].playerId then
          table.insert(canMove, index)
          parent[index] = curStageIndex
        end
      end
    end
  end
  self.movePathTemp = parent
  return canMove
end

function BaseCarbonBattleLayer:startAutoMove(aim)
  if not self.movePathTemp or not self.movePathTemp[aim] then
    return
  end
  self.battlePathTemp = {}
  while self.movePathTemp[aim] do
    if true then
      table.insert(self.battlePathTemp, aim)
      aim = self.movePathTemp[aim]
    else
      break
    end
  end
  self:drawPathLine(self.battlePathTemp, aim)
  self:onAutoMove()
end

function BaseCarbonBattleLayer:onAutoMove()
  if not self.battlePathTemp or self.battleInfo.moveType ~= 1 then
    return
  end
  local aim = table.remove(self.battlePathTemp)
  if not self.selectPlayerId or not self:getPlayerData(self.selectPlayerId) then
    self:stopAutoMove()
    return
  end
  if not next(self.battlePathTemp) then
    self:stopAutoMove()
  end
  if self.mapInfo[aim].playerId then
    self:sendChangePos(self.selectPlayerId, aim)
  else
    if 1 > self.battleInfo.movePoint then
      self:stopAutoMove()
      return
    end
    self:movePlayer(aim)
  end
end

function BaseCarbonBattleLayer:stopAutoMove()
  self:clearPathLine()
  self.battlePathTemp = nil
end

function BaseCarbonBattleLayer:drawPathLine(movePath, start)
  local function drawLine(path)
    if not path then
      return
    end
    if 1 < #path then
      for i = 1, #path - 1 do
        local disData = self.mapDisData[path[i]]
        local disData2 = self.mapDisData[path[i + 1]]
        self.movePathLine:drawLine(cc.p(disData.xpos, disData.ypos), cc.p(disData2.xpos, disData2.ypos), cc.c4f(0, 1, 0, 1))
      end
    end
  end
  
  if DEBUG > 0 then
    if not self.movePathLine or tolua.isnull(self.movePathLine) then
      self.movePathLine = display.newDrawNode():addTo(self.map, 98)
    end
    self.movePathLine:clear()
    if start then
      drawLine(self:BFS(start, movePath[#movePath]))
    end
    for i = #movePath, 1, -1 do
      if not movePath[i - 1] then
        break
      end
      drawLine(self:BFS(movePath[i], movePath[i - 1]))
    end
  end
end

function BaseCarbonBattleLayer:clearPathLine()
  if DEBUG > 0 and self.movePathLine and not tolua.isnull(self.movePathLine) then
    self.movePathLine:clear()
  end
end

function BaseCarbonBattleLayer:isStageOpen(stageIndex)
  local stage = self.mapInfo[stageIndex]
  if stage.open == 1 then
    return true
  end
  if stage.open == 0 and self.battleInfo.open and self.battleInfo.open[tostring(stageIndex)] then
    return true
  end
  return false
end

function BaseCarbonBattleLayer:isPassTime()
  local temp = json.decode(self:getBattleInfo())
  if not temp.moveTime then
    return
  end
  if game:nowTime() > temp.moveTime and self.carbonId ~= 10101 then
    self.battleInfo.movePoint = 0
    self:refreashUI()
    return true
  end
end

function BaseCarbonBattleLayer:getPlayerData(id, list)
  list = list or self.battleInfo.playerList
  for _, info in ipairs(list) do
    if info.id == id then
      return info
    end
  end
end

function BaseCarbonBattleLayer:isEndGame()
  local battleInfo = json.decode(self:getBattleInfo())
  if self.newGame then
    return false
  elseif battleInfo.carbonId then
    return false
  else
    return true
  end
end

function BaseCarbonBattleLayer:getBattleNum()
  local newNum = 0
  for index, data in pairs(game.role.formation) do
    if data.list["1"] then
      local states = game.role:getFormationState(tonumber(index))
      if not states[1] and not states[2] and not states[3] then
        newNum = newNum + 1
      end
    end
  end
  return 0 < newNum
end

function BaseCarbonBattleLayer:mapCanMove()
  local size = self.mapSize
  local width = size.width * self.zoom
  local height = size.height * self.zoom
  if width < display.width and height < display.height then
    return false
  else
    return true
  end
end

function BaseCarbonBattleLayer:scaleIsCanMove()
  self.map:setScale(self.zoom)
  local size = self.mapSize
  local width = size.width * self.zoom
  local height = size.height * self.zoom
  if width < display.width and height < display.height then
    return false
  else
    return true
  end
end

function BaseCarbonBattleLayer:getAttrUpSum(stageIndex)
  local all = 0
  for monsterId, count in pairs(self.battleInfo.kills or {}) do
    local data = MonsterCsv[tonumber(monsterId)] or {}
    all = all + (data.attrUp or 0) * count
  end
  return math.min(self.mapData[stageIndex].content, all)
end

function BaseCarbonBattleLayer:mapCheckTool()
  print("开始检测---------------------------------")
  for key, value in pairs(self.mapData) do
    local neighour = value.neighbor:toArray("=", true)
    for _, dd in pairs(neighour) do
      local path = self:BFS(value.id, dd)
      if not path then
        print(string.format("地图从%d到%d出现问题", value.id, dd))
      end
      local aim = self.mapData[dd].neighbor:toArray("=", true)
      local flag = false
      for _, ss in pairs(aim) do
        if ss == value.id then
          flag = true
        end
      end
      if not flag then
        print(string.format("配表从%d相邻中没有%d点", dd, value.id))
      end
    end
  end
  print("检测完成---------------------------------")
end

return BaseCarbonBattleLayer
