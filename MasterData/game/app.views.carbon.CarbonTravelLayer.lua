local BattleRes = "ui/battle/"
local TravelRes = "ui/carbon/travel/"
local ChapterBattleCsv = require("csvdata.chapter_tour")
local ChapterInfoCsv = require("csvdata.tour_info")
local MonsterCsv = require("csvdata.monster_tour")
local TraveItemCsv = require("csvdata.tour_item")
local HeadframCsv = require("csvdata.head_circle")
local HeadpicCsv = require("csvdata.head_pic")
local UnitCsv = require("csvdata.unit")
local uiData = {
  csbFile = "ui/carbon/CarbonTravelLayer.csb",
  mask = true,
  widgets = {
    mapNode = "mapNode",
    scoreBg = "scoreBg",
    scoreBar = "scoreBg/scoreBar",
    scoreLabel = "scoreBg/scoreLabel",
    iconNode = "scoreBg/iconNode",
    btnInfo = "btnInfo",
    btnBack = "top_angle/backBtn",
    visitNode = "visitNode",
    logNode = "logNode",
    logListBg = "logListBg",
    btnArrow = "logListBg/btnArrow",
    logList = "logListBg/logList",
    btnDice = "downBg/btnDice",
    btnTalk = "downBg/talkBtn",
    timeLabel = "downBg/timeNode/timeLabel",
    turnLabel = "downBg/timeNode/turnLabel",
    skillNode = "downBg/skillNode",
    skillMask = "downBg/skillMask",
    headNode = "rightPanel/headNode",
    talkMask = "talkMask",
    effectNode = "effectNode",
    talkBg = "talkBg",
    huanying = "talkBg/huanying",
    kaixin = "talkBg/kaixin",
    fennu = "talkBg/fennu",
    beishang = "talkBg/beishang",
    cuicu = "talkBg/cuicu",
    wuyu = "talkBg/wuyu"
  }
}
local logs = {
  [1] = "<div color=#9e4008>%s</div>获胜，积分<div color=#27580f>+%s</div>。<div color=#9e4008>%s</div>失败了，积分<div color=#27580f>-%s</div>。",
  [2] = "<div color=#9e4008>%s</div>被<div color=#9e4008>%s</div>打败了。",
  [3] = "<div color=#9e4008>%s</div>发现了传说中的宝藏，积分<div color=#27580f>+1</div>。",
  [4] = "<div color=#9e4008>%s</div>享受了温泉浴，现在元气充沛。",
  [5] = "<div color=#9e4008>%s</div>发现了神秘道具。",
  [6] = "<div color=#9e4008>%s</div>对<div color=#9e4008>%s</div>使用了<div color=#27580f>%s</div>，积分<div color=#27580f>+%s</div>。",
  [7] = "<div color=#9e4008>%s</div>对自己使用了<div color=#27580f>%s</div>，积分<div color=#27580f>+%s</div>。",
  [8] = "野生的<div color=#9e4008>%s</div>出现了！",
  [9] = "<div color=#9e4008>%s</div>离开了。",
  [10] = "<div color=#9e4008>%s</div>可以移动<div color=#27580f>%s</div>格。",
  [11] = "%s",
  [12] = "<div color=#9e4008>%s</div>战胜了<div color=#9e4008>%s</div>，积分<div color=#27580f>+%s</div>。",
  [13] = "<div color=#9e4008>%s</div>的回合开始了，积分<div color=#27580f>+%s</div>。",
  [14] = "<div color=#9e4008>%s</div>筋疲力尽，积分<div color=#27580f>-%s</div>。 ",
  [15] = "<div color=#9e4008>%s</div>进行了投掷。"
}
local CarbonTravelLayer = class("CarbonTravelLayer", UIBase)

function CarbonTravelLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function CarbonTravelLayer:init(params)
  self.roomInfo = params.roomInfo
  self.turnCount = self.roomInfo.turnCount
  self.carbonId = self.roomInfo.roomType
  self.carbonSet = ChapterBattleCsv[self.carbonId]
  self.mapSet = require(self.carbonSet.map)
  self.difficult = self.roomInfo.difficult
  self.teamIndex = self.roomInfo.teamIndex
  self.exploreStatus = json.decode(game.role.exploreStatus)
  self.exploreScore = game.role.dailyExploreScore:getv(self.difficult, 0)
  self._mainPlayers = {}
  self._waitPlayers = {}
  self._mapData = {}
  self._msgId = self.roomInfo.msgId
  self.eventList = {}
  self.logTips = {}
  self.logTexts = {}
  self.logOpen = false
  self.skillCards = {}
  self.selfRoleId = game.role.id
  self.eventWait = false
  self.listenHandlers = {}
  self.eventHandlers = {
    [RoomEvent.move] = handler(self, self.playerMove),
    [RoomEvent.useItem] = handler(self, self.playerUseItem),
    [RoomEvent.playerOnStage] = handler(self, self.playerBorn),
    [RoomEvent.playerStart] = handler(self, self.playerStart),
    [RoomEvent.playerEnd] = handler(self, self.playerEnd),
    [RoomEvent.playerExit] = handler(self, self.playerExit),
    [RoomEvent.playerDice] = handler(self, self.playerDice),
    [RoomEvent.playerFight] = handler(self, self.playerFight),
    [RoomEvent.eventCross] = handler(self, self.eventCross),
    [RoomEvent.eventFight] = handler(self, self.eventFight),
    [RoomEvent.eventScore] = handler(self, self.eventScore),
    [RoomEvent.eventItem] = handler(self, self.eventItem),
    [RoomEvent.eventCure] = handler(self, self.eventCure),
    [RoomEvent.updateMap] = handler(self, self.updateMap),
    [RoomEvent.addScore] = handler(self, self.addScore),
    [RoomEvent.playerRevive] = handler(self, self.playerRevive),
    [RoomEvent.playerTalk] = handler(self, self.playerTalk),
    [RoomEvent.addHealth] = handler(self, self.addHealth)
  }
  local exploreStatus = json.decode(game.role.exploreStatus)
  self.difficult = exploreStatus.difficult
  self.btnInfo:setCallback(function()
    local layer = game:createView("carbon.TravelInfoLayer", {
      difficult = self.difficult
    })
    BackManager:push(function()
      layer:close()
    end)
  end)
  self.btnTalk:setCallback(function()
    self:openTalkLayer()
  end)
  self.btnBack:setCallback(function()
    MDialog:double({
      title = "退出游历",
      text = "确定要退出当前游历吗？"
    }, function()
      game:sendData(actionCodes.Explore_exitGameRpc, MsgPack.pack({targetIndex = index}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Explore_exitGameRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg == SERVER_EXPLORE_EXIT_SUCCESS then
          print("退出成功")
        end
      end)
      return true
    end)
  end)
  self.scoreLabel:setLocalZOrder(10)
  self.iconNode:setLocalZOrder(10)
  self.btnDiceEff = UIHelper.createSpineNodeByRes("spine/ui/carbon/button"):pos(58, 57):addTo(self.btnDice)
  display.newSprite("ui/carbon/travel/" .. string.format("icon_%d.png", self.difficult)):addTo(self.iconNode)
  self.scoreBox = display.newSprite("ui/carbon/chooseTravel/" .. string.format("box_%d.png", self.difficult)):pos(270, 0):addTo(self.iconNode):scale(0.6)
  self.btnArrow:setCallback(function()
    if self.logOpen then
      self.logListBg:stopAllActions()
      self.logListBg:runAction(transition.sequence({
        cc.MoveTo:create(0.3, cc.p(6, 331))
      }))
    else
      self.logListBg:stopAllActions()
      self.logListBg:runAction(transition.sequence({
        cc.MoveTo:create(0.3, cc.p(356, 331))
      }))
      self:layoutLogList()
    end
    self.btnArrow:setImage("ui/home/formatInfo/" .. (self.logOpen and "btn_a.png" or "btn_b.png"))
    self.logOpen = not self.logOpen
  end)
  self.scoreBar:hide()
  self.scoreBar = display.newProgressTimer(TravelRes .. "score_bar.png", 1):center(self.scoreBg):addTo(self.scoreBg, 0)
  self.scoreBar:setBarChangeRate(cc.p(1, 0))
  self.scoreBar:setMidpoint(cc.p(0, 0.5))
  local effectNode = display.newNode():pos(0, 0):addTo(self.scoreBar)
  local effect = UIHelper.loadAnimation(TravelRes, "jdt", 24, 30)
  effect.sprite:anch(1, 0):pos(14, -11):addTo(effectNode)
  effect.sprite:playAnimationForever(effect.animation)
  effect.sprite:setBlendFunc(cc.blendFunc(gl.ONE, gl.ONE))
  self.scoreEffect = effectNode
  self:showScoreBar()
  self:initTalkLayer()
  self:initMap()
  self:firstEnter()
  self:netListen()
  UIHelper.showGuide(10006, self)
  game:playMusic(8)
end

function CarbonTravelLayer:showData()
end

function CarbonTravelLayer:eventHandler()
  self.waitMove = false
  if #self.eventList == 0 then
    self.eventWait = false
    return
  end
  self.eventWait = true
  local event = self.eventList[1]
  table.remove(self.eventList, 1)
  local handler = self.eventHandlers[event.action]
  if handler then
    handler(event)
  else
    self:eventHandler()
  end
  if not tolua.isnull(self) and event.action ~= RoomEvent.playerExit then
    self.mapTipLayer:removeAllChildren()
    self.chooseLayer:hide()
  end
end

function CarbonTravelLayer:playerMove(event)
  local player = self:findPlayer(event.roleId)
  player.hasMove = true
  local curIndex = event.startPos
  local endIndex = event.endPos
  local path = self:BFS(curIndex, endIndex)
  local moveAction
  
  function moveAction()
    if #path == 0 then
      player.spine:setToSetupPose()
      player.spine:setAnimation(0, "idle", true)
      player.stageIndex = endIndex
      self:eventHandler()
      return
    end
    local targetIndex = path[1]
    table.remove(path, 1)
    local stageDis = self.mapDisData[targetIndex]
    player.display:stopAllActions()
    local direction = player.display:getPositionX() > stageDis.xPos and -1 or 1
    player.spine:setScaleX(math.abs(player.spine:getScaleX()) * direction)
    local time = 0.5933333333333334
    self:moveCamera(targetIndex, time)
    player.display:zorder(stageDis.zorder)
    player.display:runAction(transition.sequence({
      cc.MoveTo:create(time, cc.p(stageDis.xPos, stageDis.yPos)),
      cc.CallFunc:create(moveAction)
    }))
  end
  
  self.waitMove = true
  if path then
    table.remove(path, 1)
    if 0 < #path then
      player.spine:setToSetupPose()
      player.spine:setAnimation(0, "move", true)
    end
    moveAction()
  end
  self:showDiceBar()
end

function CarbonTravelLayer:playerBorn(event)
  if event.firstBorn then
    self:addNewPlayer(event.unit, event.roleIndex)
    self:showHeads()
    if event.roleId == self.selfRoleId then
      self.visitNode:removeAllChildren()
    end
  end
  local player = self:findPlayer(event.roleId)
  local stageDis = self.mapDisData[event.stageIndex]
  player.display:stopAllActions()
  player.display:pos(stageDis.xPos, stageDis.yPos)
  player.display:zorder(stageDis.zorder)
  player.stageIndex = event.stageIndex
  player.health = event.health
  player.healthBar:setPercentage(player.health / globalCsv.tourEnergy * 100)
  if player.health == 0 then
    player.spine:setAnimation(0, "dead", false)
  end
  local effect = UIHelper.createSpineNodeByRes("spine/ui/carbon/in_out")
  effect:setAnimation(0, "in", false)
  effect:pos(0, 75):addTo(player.display)
  effect:registerSpineEventHandler(function(e)
    if e.type ~= "end" then
      return
    end
    self:eventHandler()
    scheduler.performWithDelayGlobal(function()
      effect:removeSelf()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
  self:moveCamera(event.stageIndex, 0.5)
end

function CarbonTravelLayer:playerStart(event, firstEnter)
  self.currentPlayer = event.roleId
  local player = self:findPlayer(self.currentPlayer)
  player.waitingTime = event.waitingTime or player.waitingTime
  player.hasMove = false
  player.display:removeChildByName("arrow")
  local effect = UIHelper.createSpineNodeByRes("spine/ui/carbon/xzjt")
  effect:pos(0, 200):name("arrow"):addTo(player.display)
  effect:setAnimation(0, "special", true)
  self:moveCamera(player.stageIndex)
  player.timeNode:removeAllChildren()
  if event.buffs then
    player.buffs = clone(event.buffs)
    self:layoutBuffs(self.currentPlayer)
  end
  self:showDiceBar()
  self:showTimeBar(self.currentPlayer)
  self:chooseHead(event.roleId)
  if player.roleId == self.selfRoleId then
    local spine = UIHelper.createSpineNodeByRes("ui/carbon/battle/wfhh")
    spine:pos(display.width / 2, display.height / 2):addTo(self.mapNode)
    spine:setAnimation(0, "special", false)
    spine:registerSpineEventHandler(function(event)
      if event.animation ~= "special" then
        return
      end
      scheduler.performWithDelayGlobal(function()
        spine:removeSelf()
      end, 0.016666666666666666)
    end, sp.EventType.ANIMATION_END)
    if firstEnter then
      if not player.hasMove and 0 < player.moveStep then
        self:showMoveAble(player.roleId, player.moveStep)
      end
      self:layoutBuffs(player.roleId)
    end
  end
  if not firstEnter then
    self:addLog(13, {
      pm1 = player.roleInfo.name,
      pm2 = event.score
    })
    self:eventHandler()
  end
end

function CarbonTravelLayer:playerEnd(event)
  local player = self:findPlayer(event.roleId)
  player.display:removeChildByName("arrow")
  player.timeNode:removeAllChildren()
  if event.buffs then
    player.buffs = clone(event.buffs)
    self:layoutBuffs(event.roleId)
  end
  self.currentPlayer = nil
  self:eventHandler()
end

function CarbonTravelLayer:playerExit(event)
  if event.roleId == self.selfRoleId then
    game:enterScene("MainScene", {
      layer = "carbon",
      selected = 3,
      skipMusic = true
    })
    return
  end
  if event.type == "mainPlayer" then
    local player = self:findPlayer(event.roleId)
    self:addLog(9, {
      pm1 = player.roleInfo.name
    })
    for roleIndex, player in ipairs(self._mainPlayers) do
      if player.roleId == event.roleId then
        local display = player.display
        scheduler.performWithDelayGlobal(function()
          if display and not tolua.isnull(display) then
            display:removeSelf()
          end
        end, 0.016666666666666666)
        table.remove(self._mainPlayers, roleIndex)
        break
      end
    end
  end
  self:showHeads()
  self:eventHandler()
end

function CarbonTravelLayer:playerDice(event)
  local player = self:findPlayer(event.roleId)
  player.moveStep = event.moveStep
  player.dice = event.dice
  if player.roleId ~= self.selfRoleId and event.moveStep <= 6 then
    self:addLog(15, {
      pm1 = player.roleInfo.name,
      pm2 = event.moveStep
    })
  end
  self:showDiceBar()
  self:eventHandler()
end

function CarbonTravelLayer:playerUseItem(event)
  local player = self:findPlayer(event.roleId)
  table.remove(player.items, event.itemIndex)
  local itemSet = TraveItemCsv[event.itemId]
  if event.roleId == self.selfRoleId then
    local card = self.skillCards[event.itemIndex]
    if card then
      local x, y = card:getPosition()
      local effect = UIHelper.loadAnimation(TravelRes, "use", 23, 30)
      effect.sprite:anch(0, 0):pos(x - 40, y - 40):addTo(self.skillNode)
      effect.sprite:playAnimationOnce(effect.animation, true, function()
        self:layoutItemBar()
      end)
      card:removeSelf()
      table.remove(self.skillCards, event.itemIndex)
    end
  end
  local targetPlayer = self:findPlayer(event.targetId)
  if event.targetId == event.roleId then
    self:addLog(7, {
      pm1 = player.roleInfo.name,
      pm2 = itemSet.name,
      pm3 = event.score
    })
  else
    self:addLog(6, {
      pm1 = player.roleInfo.name,
      pm2 = targetPlayer.roleInfo.name,
      pm3 = itemSet.name,
      pm4 = event.score
    })
  end
  if event.useState == 0 then
    self:addPlayerBuff(event.targetId, event.buffState)
    if event.roleId == self.selfRoleId and (itemSet.type == ExploreItemType.Dice1 or itemSet.type == ExploreItemType.Dice2 or itemSet.type == ExploreItemType.Dice3 or itemSet.type == ExploreItemType.Dice4 or itemSet.type == ExploreItemType.Dice5 or itemSet.type == ExploreItemType.Dice6) then
    elseif itemSet.log ~= "" then
      local log = string.format(itemSet.log, targetPlayer.roleInfo.name)
      self:addLog(11, {pm1 = log})
    end
  else
    print("对方免疫")
  end
  self:eventHandler()
end

function CarbonTravelLayer:playerFight(event)
  local player = self:findPlayer(event.roleId)
  local targetPlayer = self:findPlayer(event.targetId)
  
  local function fightEnd()
    local winer = event.point <= 4 and player.roleInfo.name or targetPlayer.roleInfo.name
    local loser = event.point <= 4 and targetPlayer.roleInfo.name or player.roleInfo.name
    self:addLog(1, {
      pm1 = winer,
      pm2 = event.score,
      pm3 = loser,
      pm4 = math.ceil(event.score * globalCsv.tourCreditReduce)
    })
    self:eventHandler()
  end
  
  player.display:hide()
  targetPlayer.display:hide()
  local stageDis = self.mapDisData[event.stageIndex]
  local effect = UIHelper.createSpineNodeByRes("spine/ui/carbon/fight")
  effect:pos(stageDis.xPos, stageDis.yPos + 75):addTo(self.unitLayer, 1000)
  effect:setAnimation(0, "special", true)
  if not self.fightMusic then
    self.fightMusic = game:playMusic(1905, nil, true)
  end
  effect:runAction(transition.sequence({
    cc.DelayTime:create(4),
    cc.RemoveSelf:create(),
    cc.CallFunc:create(function()
      player.display:show()
      targetPlayer.display:show()
      if self.fightMusic then
        game:stopMusic(self.fightMusic)
        self.fightMusic = nil
      end
      if event.roleId == self.selfRoleId or event.targetId == self.selfRoleId then
      else
        fightEnd()
      end
    end)
  }))
  if event.stageIndex2 then
    local stageDis = self.mapDisData[event.stageIndex2]
    local effect = UIHelper.createSpineNodeByRes("spine/ui/carbon/fight")
    effect:pos(stageDis.xPos, stageDis.yPos + 75):addTo(self.unitLayer, 1000)
    effect:setAnimation(0, "special", true)
    if not self.fightMusic then
      self.fightMusic = game:playMusic(1905, nil, true)
    end
    effect:runAction(transition.sequence({
      cc.DelayTime:create(4),
      cc.RemoveSelf:create(),
      cc.CallFunc:create(function()
        if self.fightMusic then
          game:stopMusic(self.fightMusic)
          self.fightMusic = nil
        end
      end)
    }))
  end
  if event.roleId == self.selfRoleId or event.targetId == self.selfRoleId then
    self.effectNode:removeAllChildren()
    local win = false
    if event.roleId == self.selfRoleId and 4 >= event.point or event.targetId == self.selfRoleId and 4 < event.point then
      win = true
    end
    local mask = UIHelper.newMask({
      size = cc.size(display.width, display.height),
      color = "#000000",
      opacity = 110
    })
    mask:addTo(self.effectNode)
    mask:setTouchEnabled(true)
    local effect = display.newNode():pos(display.cx, display.cy):addTo(mask)
    local content = display.newNode():pos(display.cx, display.cy):addTo(mask)
    local battleEffect = UIHelper.createSpineNodeByRes("spine/ui/carbon/battle")
    battleEffect:addTo(effect)
    battleEffect:setAnimation(0, "begin", false)
    local leftRole, rightRole, fightEffect
    
    function showResult()
      fightEffect:removeSelf()
      if self.fightMusic then
        game:stopMusic(self.fightMusic)
        self.fightMusic = nil
      end
      leftRole:pos(-245, -65):show()
      leftRole:setAnimation(0, event.point <= 4 and "cheer" or "dead", event.point <= 4)
      leftRole:setToSetupPose()
      rightRole:pos(245, -65):show()
      rightRole:setAnimation(0, event.point > 4 and "cheer" or "dead", event.point > 4)
      rightRole:setToSetupPose()
      battleEffect:setToSetupPose()
      battleEffect:setAnimation(0, win and "win" or "lose", false)
      battleEffect:registerSpineEventHandler(function(e)
        if e.type ~= "end" then
          return
        end
        scheduler.performWithDelayGlobal(function()
          mask:removeSelf()
          fightEnd()
        end, 0.016666666666666666)
      end, sp.EventType.ANIMATION_END)
      battleEffect:runAction(transition.sequence({
        cc.DelayTime:create(2.1666666666666665),
        cc.CallFunc:create(function()
          content:removeAllChildren()
        end)
      }))
    end
    
    mask:runAction(transition.sequence({
      cc.DelayTime:create(0.26666666666666666),
      cc.CallFunc:create(function()
        local leftHead = self:createFightHead(player.roleId)
        leftHead:pos(-430, 150):addTo(content)
        local rightHead = self:createFightHead(targetPlayer.roleId, true)
        rightHead:pos(430, 150):addTo(content)
        leftRole = UIHelper.createSpineNode(player.roleInfo.leader.type)
        leftRole:pos(-245, -65):addTo(content)
        leftRole:setAnimation(0, "move", true)
        leftRole:runAction(transition.sequence({
          cc.DelayTime:create(0.5),
          cc.MoveBy:create(0.3, cc.p(245, 0)),
          cc.Hide:create()
        }))
        rightRole = UIHelper.createSpineNode(targetPlayer.roleInfo.leader.type)
        rightRole:pos(245, -65):addTo(content)
        rightRole:setAnimation(0, "move", true)
        rightRole:setScaleX(rightRole:getScaleX() * -1)
        rightRole:runAction(transition.sequence({
          cc.DelayTime:create(0.5),
          cc.MoveBy:create(0.3, cc.p(-245, 0)),
          cc.Hide:create()
        }))
        local tipBg = display.newSprite(TravelRes .. "fight_tip.png"):pos(0, -125):addTo(content)
        display.newTTFLabel({
          text = "点数为1/2/3/4时，进攻方胜利；5/6时，防守方胜利",
          size = 18
        }):center(tipBg):addTo(tipBg)
      end),
      cc.DelayTime:create(0.8),
      cc.CallFunc:create(function()
        fightEffect = UIHelper.createSpineNodeByRes("spine/ui/carbon/fight")
        fightEffect:addTo(content)
        fightEffect:setAnimation(0, "special", true)
        if not self.fightMusic then
          self.fightMusic = game:playMusic(1905, nil, true)
        end
      end),
      cc.DelayTime:create(0.3),
      cc.CallFunc:create(function()
        local animation = tostring(event.point)
        game:playMusic(1900)
        local diceEffect = UIHelper.createSpineNodeByRes("spine/ui/carbon/dice"):pos(display.cx, display.cy + 30):addTo(mask)
        diceEffect:setAnimation(0, "chuxian", false)
        diceEffect:addAnimation(0, animation, false)
        diceEffect:registerSpineEventHandler(function(e)
          if e.type ~= "end" then
            return
          end
          if e.animation ~= animation then
            return
          end
          showResult()
          scheduler.performWithDelayGlobal(function()
            diceEffect:removeSelf()
          end, 0.016666666666666666)
        end, sp.EventType.ANIMATION_END)
      end)
    }))
  end
end

function CarbonTravelLayer:playerRevive(event)
  local player = self:findPlayer(event.roleId)
  player.health = globalCsv.tourEnergy
  player.healthBar:setPercentage(100)
  player.spine:setAnimation(0, "idle", true)
  local effect = UIHelper.createSpineNodeByRes("spine/ui/carbon/in_out")
  effect:setAnimation(0, "in", false)
  effect:pos(0, 75):addTo(player.display)
  effect:registerSpineEventHandler(function(e)
    if e.type ~= "end" then
      return
    end
    self:eventHandler()
    scheduler.performWithDelayGlobal(function()
      effect:removeSelf()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
end

function CarbonTravelLayer:addHealth(event)
  local player = self:findPlayer(event.roleId)
  player.health = event.health
  player.healthBar:setPercentage(player.health / globalCsv.tourEnergy * 100)
  if player.health == 0 then
    self:addLog(14, {
      pm1 = player.roleInfo.name,
      pm2 = globalCsv.tourRevive
    })
  end
  self:eventHandler()
end

function CarbonTravelLayer:eventCross(event)
  local player = self:findPlayer(event.roleId)
  local startStage = self.mapDisData[event.startPos]
  local endStage = self.mapDisData[event.endPos]
  self:moveCamera(event.startPos)
  player.stageIndex = event.endPos
  player.display:hide()
  player.display:pos(endStage.xPos, endStage.yPos)
  player.display:zorder(endStage.zorder)
  local startEffect = UIHelper.createSpineNodeByRes("spine/ui/carbon/csm_inout"):pos(startStage.xPos, startStage.yPos):addTo(self.unitLayer, 1000)
  startEffect:setAnimation(0, "in", false)
  startEffect:registerSpineEventHandler(function(e)
    if e.type ~= "end" then
      return
    end
    self:moveCamera(event.endPos, 0.1)
    local endEffect = UIHelper.createSpineNodeByRes("spine/ui/carbon/csm_inout"):pos(endStage.xPos, endStage.yPos):addTo(self.unitLayer, 1000)
    endEffect:setAnimation(0, "out", false)
    endEffect:registerSpineEventHandler(function(f)
      if f.type ~= "end" then
        return
      end
      player.display:show()
      scheduler.performWithDelayGlobal(function()
        endEffect:removeSelf()
      end, 0.016666666666666666)
      scheduler.performWithDelayGlobal(function()
        self:eventHandler()
      end, 0.2)
    end, sp.EventType.ANIMATION_END)
    scheduler.performWithDelayGlobal(function()
      startEffect:removeSelf()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
end

function CarbonTravelLayer:eventFight(event)
  local player = self:findPlayer(event.roleId)
  local stageDis = self.mapDisData[event.stageIndex]
  local enemyId = event.enemyId
  local enemySet = MonsterCsv[enemyId]
  
  local function fightEnd()
    if self.fightMusic then
      game:stopMusic(self.fightMusic)
      self.fightMusic = nil
    end
    if event.win then
      stageDis.display:runAction(transition.sequence({
        cc.FadeOut:create(1),
        cc.RemoveSelf:create()
      }))
      stageDis.display = nil
      local stage = self._mapData[event.stageIndex]
      stage.content = 0
      self:addLog(12, {
        pm1 = player.roleInfo.name,
        pm2 = enemySet.desc,
        pm3 = event.score
      })
    else
      self:addLog(2, {
        pm1 = player.roleInfo.name,
        pm2 = enemySet.desc
      })
    end
  end
  
  if player.roleId == self.selfRoleId then
    self.effectNode:removeAllChildren()
    local mask = UIHelper.newMask({
      size = cc.size(display.width, display.height),
      color = "#000000",
      opacity = 110
    })
    mask:addTo(self.effectNode)
    mask:setTouchEnabled(true)
    local effect = display.newNode():pos(display.cx, display.cy):addTo(mask)
    local content = display.newNode():pos(display.cx, display.cy):addTo(mask)
    local battleEffect = UIHelper.createSpineNodeByRes("spine/ui/carbon/battle")
    battleEffect:pos(0, 30):addTo(effect)
    battleEffect:setAnimation(0, "begin", false)
    local leftRole, rightRole, fightEffect
    
    function showResult()
      fightEffect:removeSelf()
      if self.fightMusic then
        game:stopMusic(self.fightMusic)
        self.fightMusic = nil
      end
      leftRole:pos(-245, -45):show()
      leftRole:setAnimation(0, event.win and "cheer" or "dead", event.win)
      leftRole:setToSetupPose()
      rightRole:pos(245, -45):show()
      rightRole:setAnimation(0, not event.win and "idle" or "dead", event.win)
      rightRole:setToSetupPose()
      battleEffect:setToSetupPose()
      battleEffect:setAnimation(0, event.win and "win" or "lose", false)
      battleEffect:registerSpineEventHandler(function(e)
        if e.type ~= "end" then
          return
        end
        scheduler.performWithDelayGlobal(function()
          mask:removeSelf()
          fightEnd()
          self:eventHandler()
        end, 0.016666666666666666)
      end, sp.EventType.ANIMATION_END)
      battleEffect:runAction(transition.sequence({
        cc.DelayTime:create(2.1666666666666665),
        cc.CallFunc:create(function()
          content:removeAllChildren()
        end)
      }))
    end
    
    mask:runAction(transition.sequence({
      cc.DelayTime:create(0.26666666666666666),
      cc.CallFunc:create(function()
        local textBg = display.newSprite(TravelRes .. "battleValue_bg.png"):pos(-245, -125):addTo(content)
        display.newTTFLabel({
          text = "美味度：" .. player.roleInfo.battleValue,
          size = 18,
          color = UIHelper.hex2rgb("76f80d")
        }):center(textBg):addTo(textBg)
        local textBg = display.newSprite(TravelRes .. "battleValue_bg.png"):pos(245, -125):addTo(content)
        display.newTTFLabel({
          text = "美味度：" .. enemySet.battleValue * player.roleInfo.difficult,
          size = 18,
          color = UIHelper.hex2rgb("ee2c2c")
        }):center(textBg):addTo(textBg)
        leftRole = UIHelper.createSpineNode(player.roleInfo.leader.type)
        leftRole:pos(-245, -45):addTo(content)
        leftRole:setAnimation(0, "move", true)
        leftRole:runAction(transition.sequence({
          cc.DelayTime:create(0.5),
          cc.MoveBy:create(0.3, cc.p(245, 0)),
          cc.Hide:create()
        }))
        rightRole = UIHelper.createSpineNode(enemySet.unitType)
        rightRole:pos(245, -45):addTo(content)
        rightRole:setAnimation(0, "move", true)
        rightRole:setScaleX(rightRole:getScaleX() * -1)
        rightRole:runAction(transition.sequence({
          cc.DelayTime:create(0.5),
          cc.MoveBy:create(0.3, cc.p(-245, 0)),
          cc.Hide:create()
        }))
      end),
      cc.DelayTime:create(0.8),
      cc.CallFunc:create(function()
        fightEffect = UIHelper.createSpineNodeByRes("spine/ui/carbon/fight")
        fightEffect:addTo(content)
        fightEffect:setAnimation(0, "special", true)
        if not self.fightMusic then
          self.fightMusic = game:playMusic(1905, nil, true)
        end
      end),
      cc.DelayTime:create(2),
      cc.CallFunc:create(function()
        showResult()
      end)
    }))
  else
    player.display:hide()
    local effect = UIHelper.createSpineNodeByRes("spine/ui/carbon/fight")
    effect:pos(stageDis.xPos, stageDis.yPos + 75):addTo(self.unitLayer, 1000)
    effect:setAnimation(0, "special", true)
    if not self.fightMusic then
      self.fightMusic = game:playMusic(1905, nil, true)
    end
    effect:runAction(transition.sequence({
      cc.DelayTime:create(2),
      cc.RemoveSelf:create(),
      cc.CallFunc:create(function()
        player.display:show()
        fightEnd()
        self:eventHandler()
      end)
    }))
  end
end

function CarbonTravelLayer:eventCure(event)
  local player = self:findPlayer(event.roleId)
  self:addLog(4, {
    pm1 = player.roleInfo.name
  })
  local stageDis = self.mapDisData[player.stageIndex]
  game:playMusic(1906)
  local cureEffect = UIHelper.createSpineNodeByRes("spine/ui/carbon/cure"):pos(stageDis.xPos, stageDis.yPos):addTo(self.unitLayer, 1000)
  cureEffect:setAnimation(0, "special", false)
  cureEffect:registerSpineEventHandler(function(e)
    if e.type ~= "end" then
      return
    end
    self:eventHandler()
    scheduler.performWithDelayGlobal(function()
      cureEffect:removeSelf()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
end

function CarbonTravelLayer:eventScore(event)
  local player = self:findPlayer(event.roleId)
  self:addLog(3, {
    pm1 = player.roleInfo.name
  })
  local stageDis = self.mapDisData[event.stageIndex]
  local effect = UIHelper.createSpineNodeByRes("spine/ui/carbon/score"):pos(stageDis.xPos, stageDis.yPos + 50):addTo(self.unitLayer, 1000)
  game:playMusic(1904)
  effect:setAnimation(0, "special", false)
  effect:registerSpineEventHandler(function(e)
    if e.type ~= "end" then
      return
    end
    self:eventHandler()
    scheduler.performWithDelayGlobal(function()
      effect:removeSelf()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
end

function CarbonTravelLayer:eventItem(event)
  local player = self:findPlayer(event.roleId)
  self:addLog(5, {
    pm1 = player.roleInfo.name
  })
  local stageDis = self.mapDisData[event.stageIndex]
  local displayNode = stageDis.display
  displayNode:zorder(1000)
  local effect = stageDis.spine
  effect:setToSetupPose()
  effect:setAnimation(0, "get", false)
  effect:registerSpineEventHandler(function(e)
    if e.type ~= "end" then
      return
    end
    if player.roleId == game.role.id then
      self:addItemBar(event.itemId)
      table.insert(player.items, event.itemId)
    end
    self:eventHandler()
    scheduler.performWithDelayGlobal(function()
      displayNode:removeSelf()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
  stageDis.display = nil
  local stage = self._mapData[event.stageIndex]
  stage.content = 0
end

function CarbonTravelLayer:updateMap(event)
  local roomInfo = event.roomInfo
  for stageIndex, data in ipairs(roomInfo.mapData) do
    local stage = self._mapData[stageIndex]
    local bRefresh = false
    if data.content ~= stage.content then
      bRefresh = true
    end
    stage.content = data.content
    stage.active = data.active
    stage.bRefresh = bRefresh
  end
  for roleIndex, player in ipairs(self._mainPlayers) do
    player.moveStep = 0
    player.dice = 0
    player.hasMove = false
    local remote = roomInfo.mainPlayers[roleIndex]
    if not remote then
      self.eventList = {}
      self:reConnect()
      break
    else
      player.buffs = clone(remote.buffs)
      self:layoutBuffs(player.roleId)
    end
  end
  self.turnCount = roomInfo.turnCount
  self:refreshStage()
  self:eventHandler()
end

function CarbonTravelLayer:addScore(event)
  if event.roleId == self.selfRoleId then
    self:showScoreBar(event.score)
  end
  self:eventHandler()
end

local talkTexts = {
  [1] = {
    "欢迎你哟~",
    "欢迎你哟~",
    "欢迎你哟~"
  },
  [2] = {
    "好开心~",
    "好开心~",
    "好开心~"
  },
  [3] = {
    "我生气啦！",
    "我生气啦！",
    "我生气啦！"
  },
  [4] = {
    "好忧伤~",
    "好忧伤~",
    "好忧伤~"
  },
  [5] = {
    "快一点！",
    "快一点！",
    "快一点！"
  },
  [6] = {
    "什么鬼！",
    "什么鬼！",
    "什么鬼！"
  }
}

function CarbonTravelLayer:playerTalk(event)
  local roleIndex = event.roleIndex
  local head = self.headNode:getChildByName("head" .. roleIndex)
  if not head then
    return
  end
  head:removeChildByName("talkBg")
  local talkBg = display.newSprite(TravelRes .. "talk_bg_1.png")
  talkBg:anch(0, 0.5):pos(0, 0):addTo(head, -1):name("talkBg")
  talkBg:setCascadeOpacityEnabled(true)
  talkBg:opacity(0)
  local rand = talkTexts[event.talkId]
  display.newTTFLabel({
    text = rand[math.randomInt(1, #rand)],
    size = 20,
    color = UIHelper.hex2rgb("#3a1609")
  }):pos(73, 19):addTo(talkBg)
  talkBg:runAction(transition.sequence({
    cc.Spawn:create({
      cc.FadeIn:create(0.2),
      cc.MoveBy:create(0.2, cc.p(-210, 0))
    }),
    cc.DelayTime:create(2),
    cc.FadeOut:create(0.2),
    cc.RemoveSelf:create()
  }))
end

local SkillCard = class("SkillCard", function()
  return UIHelper.newImageView(TravelRes .. "skill_frame.png")
end)

function SkillCard:ctor(params)
  self.itemId = params.itemId
  self:scale(0.5)
  local itemSet = TraveItemCsv[self.itemId]
  local skillBg = display.newSprite(TravelRes .. "skill_bg.png"):pos(83, 133):addTo(self)
  display.newSprite(itemSet.icon):center(skillBg):addTo(skillBg)
  display.newTTFLabel({
    text = itemSet.name,
    size = 28,
    color = UIHelper.hex2rgb("#777052")
  }):pos(84, 37):addTo(self)
end

function CarbonTravelLayer:addItemBar(itemId)
  local skillCard = SkillCard.new({itemId = itemId})
  skillCard:anch(0, 0):pos(500, 0):addTo(self.skillNode)
  table.insert(self.skillCards, skillCard)
  skillCard:setCallback(function()
    if self:hasBuffType(self.selfRoleId, ExploreItemType.Forbiden) then
      SysError(SERVER_EXPLORE_BUFF_FORBIDDEN)
      return
    end
    if (skillCard.itemId == ExploreItemType.Dice1 or skillCard.itemId == ExploreItemType.Dice2 or skillCard.itemId == ExploreItemType.Dice3 or skillCard.itemId == ExploreItemType.Dice4 or skillCard.itemId == ExploreItemType.Dice5 or skillCard.itemId == ExploreItemType.Dice6 or skillCard.itemId == ExploreItemType.DiceAll) and self:hasBuffType(self.selfRoleId, ExploreItemType.Bomb) then
      SysError(SERVER_EXPLORE_BUFF_BOMB)
      return
    end
    local player = self:findPlayer(self.selfRoleId)
    self:showItemChoose(skillCard)
  end)
  self:layoutItemBar()
end

function CarbonTravelLayer:layoutItemBar()
  if #self.skillCards == 0 then
    return
  end
  local interval = 105
  local xBegin = 0
  for index, card in ipairs(self.skillCards) do
    card:stopAllActions()
    card:runAction(cc.MoveTo:create(0.2, cc.p(xBegin + (index - 1) * interval, 3)))
  end
end

function CarbonTravelLayer:showItemChoose(card)
  local itemId = card.itemId
  local itemSet = TraveItemCsv[card.itemId]
  local itemIndex = table.indexof(self.skillCards, card)
  if not itemIndex then
    SysError(SERVER_EXPLORE_ITEM_NOT_EXIST)
    return
  end
  self.mapTipLayer:hide()
  self.chooseLayer:show()
  self.chooseLayer:removeAllChildren()
  
  local function sendUse(item, targetId)
    game:sendData(actionCodes.Explore_useItemRpc, MsgPack.pack({itemIndex = item, targetId = targetId}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Explore_useItemRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if msg.result == SERVER_EXPLORE_ACTION_SUCCESS then
        if itemId == ExploreItemType.Dice1 or itemId == ExploreItemType.Dice2 or itemId == ExploreItemType.Dice3 or itemId == ExploreItemType.Dice4 or itemId == ExploreItemType.Dice5 or itemId == ExploreItemType.Dice6 or itemId == ExploreItemType.DiceAll then
          self:sendMsgDice(true)
        end
      else
        SysError(msg.result)
      end
    end)
  end
  
  local targets = {}
  if itemSet.target == 1 then
    sendUse(itemIndex, self.currentPlayer)
  else
    for roleIndex, player in ipairs(self._mainPlayers) do
      if player.roleId ~= game.role.id then
        table.insert(targets, player.roleId)
      end
    end
  end
  for _, roleId in ipairs(targets) do
    local player = self:findPlayer(roleId)
    local stageDis = self.mapDisData[player.stageIndex]
    local touchLayer = UIHelper.newMask({
      size = cc.size(145, 160)
    }):addTo(self.chooseLayer)
    touchLayer:anch(0.5, 0):pos(stageDis.xPos, stageDis.yPos - 10)
    touchLayer:setCallback(function()
      self.chooseLayer:hide()
      self.mapTipLayer:show()
      if self:hasBuffType(roleId, ExploreItemType.Invincible) then
        SysError(SERVER_EXPLORE_BUFF_INVINCIBLE)
        return
      end
      if card.itemId == ExploreItemType.Weak and self:hasBuffType(roleId, ExploreItemType.Victory) then
        SysError(SERVER_EXPLORE_BUFF_WEAK)
        return
      end
      if card.itemId == ExploreItemType.Victory and self:hasBuffType(roleId, ExploreItemType.Weak) then
        SysError(SERVER_EXPLORE_BUFF_VICTORY)
        return
      end
      game:sendData(actionCodes.Explore_useItemRpc, MsgPack.pack({
        itemIndex = itemIndex,
        targetId = player.roleId
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Explore_useItemRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg.result == SERVER_EXPLORE_ACTION_SUCCESS then
        else
          SysError(msg.result)
        end
      end)
    end)
    local effect = UIHelper.createSpineNodeByRes("spine/ui/carbon/target")
    effect:center(touchLayer):addTo(touchLayer)
    effect:setAnimation(0, "special", true)
  end
  if 0 < #targets then
    SysError(SERVER_EXPLORE_ACTION_ITEM_TIP)
  end
end

function CarbonTravelLayer:showTimeBar(roleId)
  self.turnLabel:setString(string.format("第%d回合", self.turnCount))
  self.timeLabel:stopAllActions()
  local player = self:findPlayer(roleId)
  local tick
  
  function tick()
    local leftTime = player.waitingTime - game:nowTime()
    if leftTime <= 6 and 0 <= leftTime then
      player.timeNode:removeAllChildren()
      if not player.hasMove then
        local timeBg = display.newSprite(TravelRes .. "time_bg.png"):addTo(player.timeNode)
        display.newSprite(TravelRes .. string.format("time_%d.png", leftTime)):center(timeBg):addTo(timeBg):scale(2):runAction(cc.ScaleTo:create(0.5, 1))
      end
    end
    if 0 <= leftTime then
      self.timeLabel:setString(UIHelper.getTimeStr(leftTime, true))
      self.timeLabel:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.CallFunc:create(tick)
      }))
    end
  end
  
  tick()
end

function CarbonTravelLayer:showDiceBar()
  local player = self:findPlayer(self.currentPlayer)
  if not player then
    return
  end
  if player.roleId ~= game.role.id then
    self.skillMask:show()
    self.btnDice:hide()
    return
  end
  if player.hasMove or player.moveStep > 0 then
    self.btnDice:hide()
    self.skillMask:show()
    return
  end
  self.skillMask:hide()
  self.btnDice:show()
  local bStop = self:hasBuffType(self.currentPlayer, ExploreItemType.Bomb)
  if not bStop then
    self.btnDiceEff:setToSetupPose()
    self.btnDiceEff:setAnimation(1, "start", true)
    self.btnDice:setCallback(function()
      self:sendMsgDice()
    end)
  else
    self.btnDiceEff:setToSetupPose()
    self.btnDiceEff:setAnimation(1, "end", true)
    self.btnDice:setCallback(function()
      game:sendData(actionCodes.Explore_endTurnRpc, "")
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Explore_endTurnRpc, function(event)
        UIHelper.removeWaiting()
      end)
    end)
  end
end

function CarbonTravelLayer:showHeads()
  self.headNode:removeAllChildren()
  for roleIndex, player in ipairs(self._mainPlayers) do
    local iconTag = player.roleInfo.headIconTag
    local framTag = player.roleInfo.headFrameTag
    local content = display.newNode():pos(0, -100 * (roleIndex - 1)):addTo(self.headNode):name("head" .. roleIndex)
    local headBg = UIHelper.newImageView("ui/home/roleNode/head_bg.png")
    headBg:scale(0.7):addTo(content)
    headBg:setTouchEnabled(true)
    headBg:setCallback(function(sender)
      self:moveCamera(player.stageIndex, 0.2)
    end)
    display.newSprite(HeadpicCsv[iconTag].res):center(headBg):addTo(headBg)
    display.newSprite(HeadframCsv[framTag].res):center(headBg):addTo(headBg)
    local _index = roleIndex
    if player.roleId == self.selfRoleId then
      _index = 0
    end
    display.newSprite(TravelRes .. string.format("player_%d.png", _index)):pos(-30, 30):addTo(content)
    if player.isAI then
      display.newSprite(TravelRes .. "robot.png"):pos(30, 30):addTo(content)
    end
    local nameBg = display.newSprite(TravelRes .. "name_bg.png"):pos(0, -40):addTo(content)
    local name = display.newTTFLabel({
      text = player.roleInfo.name,
      size = 16
    }):center(nameBg):addTo(nameBg)
    if name:getContentSize().width > 88 then
      name:scale(88 / name:getContentSize().width)
    end
    local topBar = player.display:getChildByName("topBar")
    if topBar then
      local indexBg = topBar:getChildByName("indexBg")
      indexBg:removeAllChildren()
      display.newSprite(TravelRes .. string.format("player_%d.png", _index)):center(indexBg):addTo(indexBg)
    end
  end
  self.headArrow = display.newSprite(TravelRes .. "arrow.png"):anch(1, 0.5):pos(-30, 0):addTo(self.headNode)
end

function CarbonTravelLayer:chooseHead(roleId)
  local index
  for playerIndex, player in ipairs(self._mainPlayers) do
    if player.roleId == roleId then
      index = playerIndex
    end
  end
  self.visitNode:removeAllChildren()
  if index then
    self.headArrow:setPositionY(-100 * (index - 1))
    if roleId ~= self.selfRoleId then
      local content = display.newSprite(TravelRes .. "visit_tip.png"):pos(display.cx, display.height - 75):addTo(self.visitNode)
      display.newTTFLabel({
        text = "其他主厨的回合，请稍等…",
        size = 28
      }):enableOutline(UIHelper.hex2rgb("#000000"), 2):center(content):addTo(content)
    end
  else
    local maskLayer = UIHelper.newMask({
      size = cc.size(display.width, display.height)
    })
    maskLayer:addTo(self.visitNode)
    maskLayer:setTouchEnabled(true)
    local content = display.newSprite(TravelRes .. "visit_tip.png"):pos(display.cx, display.height - 75):addTo(maskLayer)
    display.newTTFLabel({
      text = "观战中，请稍等…",
      size = 28
    }):enableOutline(UIHelper.hex2rgb("#000000"), 2):center(content):addTo(content)
  end
end

function CarbonTravelLayer:showScoreBar(score)
  score = score or 0
  self.exploreScore = self.exploreScore + score
  self.exploreScore = math.max(self.exploreScore, 0)
  self.exploreScore = math.min(self.exploreScore, globalCsv.tourMaxCredit)
  local process = self.exploreScore / globalCsv.tourRewardCost * 100
  process = math.min(process, 100)
  self.scoreBar:runAction(cc.ProgressTo:create(0.5, process))
  self.scoreLabel:setString(string.format("%d/%d", self.exploreScore, globalCsv.tourRewardCost))
  self.scoreBox:stopAllActions()
  self.scoreBox:rotation(0)
  if process == 100 then
    self.scoreBox:runAction(cc.RepeatForever:create(transition.sequence({
      cc.RotateBy:create(0.1, -25),
      cc.RotateBy:create(0.2, 50),
      cc.RotateBy:create(0.2, -50),
      cc.RotateBy:create(0.1, 25),
      cc.DelayTime:create(2)
    })))
  end
  self.scoreEffect:stopAllActions()
  self.scoreEffect:runAction(cc.MoveTo:create(0.5, cc.p(process * 256 / 100, 0)))
end

function CarbonTravelLayer:addPlayerBuff(roleId, buff)
  local player = self:findPlayer(roleId)
  local buffIndex = self:hasBuffType(roleId, buff.id)
  if buffIndex then
    table.remove(player.buffs, buffIndex)
  end
  table.insert(player.buffs, buff)
  if buff.id == ExploreItemType.Weak or buff.id == ExploreItemType.Slow then
    game:playMusic(1902)
  elseif buff.id == ExploreItemType.Invincible or buff.id == ExploreItemType.Victory then
    game:playMusic(1903)
  elseif buff.id == ExploreItemType.Forbiden then
    game:playMusic(1901)
  end
  self:layoutBuffs(roleId)
end

function CarbonTravelLayer:hasBuffType(roleId, buffId)
  local player = self:findPlayer(roleId)
  if not player then
    return
  end
  for buffIndex, buff in ipairs(player.buffs) do
    if buff.id == buffId then
      return buffIndex
    end
  end
end

function CarbonTravelLayer:layoutBuffs(roleId)
  local player = self:findPlayer(roleId)
  player.buffNode:removeAllChildren()
  local spineShow = {}
  local iconShow = {}
  for _, buff in ipairs(player.buffs) do
    local buffSet = TraveItemCsv[buff.id]
    if buffSet.buffRes ~= "" then
      table.insert(spineShow, buff.id)
    end
    if buffSet.buffIcon ~= "" then
      table.insert(iconShow, buff.id)
    end
  end
  for index, buffId in ipairs(spineShow) do
    local buffSet = TraveItemCsv[buffId]
    local buffEffect = UIHelper.createSpineNodeByRes(buffSet.buffRes)
    buffEffect:pos(0, buffSet.processYOffset):addTo(player.buffNode)
    if buffId == ExploreItemType.Weak or buffId == ExploreItemType.Bomb or buffId == ExploreItemType.Victory then
      buffEffect:setAnimation(0, "special", false)
    else
      buffEffect:setAnimation(0, "special", true)
    end
  end
  local xInterval = 34
  local xBegin = -(#iconShow - 1) * xInterval / 2
  for index, buffId in ipairs(iconShow) do
    local buffSet = TraveItemCsv[buffId]
    display.newSprite(buffSet.buffIcon):anch(0.5, 0):pos(xBegin + (index - 1) * xInterval, 75):addTo(player.buffNode)
  end
  if roleId == self.selfRoleId then
    for stageIndex, stage in ipairs(self._mapData) do
      local stageDis = self.mapDisData[stageIndex]
      if stage.type == ExploreType.Enemy and stage.content ~= 0 and stageDis.display and not tolua.isnull(stageDis.display) then
        local rateBar = stageDis.display:getChildByName("rateBar")
        if rateBar then
          rateBar:removeAllChildren()
          local monster = MonsterCsv[stage.content]
          local enemyValue = monster.battleValue * self.difficult * ChapterInfoCsv[self.difficult].factor
          local roleValue = self.exploreStatus.battleValue
          local rate
          if enemyValue <= roleValue then
            rate = math.floor(math.min(100, 60 + (roleValue / enemyValue - 1) * 40))
          else
            rate = math.floor(math.max(0, 40 + (roleValue / enemyValue - 1) * 60))
          end
          if self:hasBuffType(roleId, ExploreItemType.Weak) then
            rate = 0
          end
          if self:hasBuffType(roleId, ExploreItemType.Victory) then
            rate = 100
          end
          display.newTTFLabel({
            text = string.format("%d%%", rate),
            size = 20,
            color = UIHelper.hex2rgb("#f54db1")
          }):pos(45, 15):addTo(rateBar)
        end
      end
    end
  end
end

function CarbonTravelLayer:initTalkLayer()
  local talkBt = {
    self.huanying,
    self.kaixin,
    self.fennu,
    self.beishang,
    self.cuicu,
    self.wuyu
  }
  for i = 1, #talkBt do
    talkBt[i]:setTouchScale()
    talkBt[i]:setCallback(function()
      self:closeTalkLayer()
      game:sendData(actionCodes.Explore_talkRpc, MsgPack.pack({talkId = i}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Explore_talkRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg.result == SERVER_EXPLORE_TALK_SUCCESS then
        else
          SysError(msg.result)
        end
      end)
    end)
  end
  self:closeTalkLayer()
end

function CarbonTravelLayer:closeTalkLayer()
  self.talkBg:stopAllActions()
  self.talkMask:removeAllChildren()
  self.talkBg:pos(-145, 3)
end

function CarbonTravelLayer:openTalkLayer()
  self:closeTalkLayer()
  local mask = UIHelper.newMask({
    size = cc.size(display.width, display.height)
  }):addTo(self.talkMask)
  mask:setCallback(function()
    self:closeTalkLayer()
  end)
  transition.moveTo(self.talkBg, {
    x = 221,
    y = 3,
    time = 0.3
  })
end

function CarbonTravelLayer:createFightHead(roleId, right)
  local player = self:findPlayer(roleId)
  local roleInfo = player.roleInfo
  local root = ccui.Widget:create()
  local bgNode = ccui.Widget:create():addTo(root)
  local content = ccui.Widget:create():addTo(root)
  display.newSprite("ui/home/roleNode/head_name_bg.png"):pos(179, -28):addTo(bgNode)
  display.newSprite("ui/home/roleNode/head_bg.png"):pos(34, -21):addTo(bgNode)
  local xOffset = right and -1 or 1
  display.newSprite(HeadpicCsv[roleInfo.headIconTag].res):pos(34 * xOffset, -28):addTo(content)
  display.newSprite(HeadframCsv[roleInfo.headFrameTag].res):pos(34 * xOffset, -28):addTo(content)
  display.newSprite(HeadframCsv[roleInfo.headFrameTag].res2):pos(83 * xOffset, -26):addTo(content)
  display.newTTFLabel({
    text = roleInfo.level,
    size = 24
  }):enableOutline(UIHelper.hex2rgb("#000000", 1)):pos(81 * xOffset + (right and -4 or 0), -37):addTo(content)
  display.newTTFLabel({
    text = roleInfo.name,
    size = 18
  }):enableOutline(UIHelper.hex2rgb("#000000", 1)):pos(179 * xOffset, -21):addTo(content)
  bgNode:setFlippedX(right)
  return root
end

function CarbonTravelLayer:addLog(type, params)
  if #self.logTips == 2 then
    local tip = self.logTips[1]
    table.remove(self.logTips, 1)
    tip:stopAllActions()
    tip:pos(336, display.height - 55 - 70)
    tip:runAction(transition.sequence({
      cc.Spawn:create({
        cc.FadeOut:create(0.2),
        cc.MoveBy:create(0.2, cc.p(0, -70))
      }),
      cc.RemoveSelf:create()
    }))
  end
  if #self.logTips == 1 then
    local tip = self.logTips[1]
    tip:stopAllActions()
    tip:pos(336, display.height - 55)
    tip:runAction(transition.sequence({
      cc.MoveBy:create(0.1, cc.p(0, -70)),
      cc.DelayTime:create(4),
      cc.CallFunc:create(function()
        for index, _tip in ipairs(self.logTips) do
          if _tip == tip then
            table.remove(self.logTips, index)
            break
          end
        end
      end),
      cc.Spawn:create({
        cc.FadeOut:create(0.2),
        cc.MoveBy:create(0.2, cc.p(0, -70))
      }),
      cc.RemoveSelf:create()
    }))
  end
  local log = string.format(logs[type], params.pm1, params.pm2, params.pm3, params.pm4)
  local logBg = display.newSprite(TravelRes .. "log_bg.png"):anch(1, 1):pos(0, display.height - 55):addTo(self.logNode)
  MRichText.new({
    text = log,
    size = 18,
    color = UIHelper.hex2rgb("#704825"),
    maxWidth = 310
  }):anch(0.5, 0.5):center(logBg):addTo(logBg)
  logBg:runAction(transition.sequence({
    cc.Spawn:create({
      cc.FadeIn:create(0.2),
      cc.MoveBy:create(0.2, cc.p(336, 0))
    }),
    cc.DelayTime:create(5),
    cc.CallFunc:create(function()
      for index, _tip in ipairs(self.logTips) do
        if _tip == logBg then
          table.remove(self.logTips, index)
          break
        end
      end
    end),
    cc.MoveBy:create(0.1, cc.p(0, -70)),
    cc.Spawn:create({
      cc.FadeOut:create(0.2),
      cc.MoveBy:create(0.2, cc.p(0, -70))
    }),
    cc.RemoveSelf:create()
  }))
  table.insert(self.logTips, logBg)
  self:addLogToList(log)
end

function CarbonTravelLayer:addLogToList(log)
  table.insert(self.logTexts, log)
  if #self.logTexts > 20 then
    table.remove(self.logTexts, 1)
  end
  if self.logOpen then
    self:layoutLogList()
  end
end

local cellSize = display.newSprite(TravelRes .. "log_bg.png"):getContentSize()

function CarbonTravelLayer:layoutLogList()
  self.logList:removeAllChildren()
  for index, log in ipairs(self.logTexts) do
    local viewNode = ccui.Widget:create()
    viewNode:size(cellSize):addTo(self.logList)
    local logBg = display.newSprite(TravelRes .. "log_bg.png"):center(viewNode):addTo(viewNode)
    MRichText.new({
      text = log,
      size = 18,
      color = UIHelper.hex2rgb("#704825"),
      maxWidth = 310
    }):anch(0.5, 0.5):center(logBg):addTo(logBg)
  end
  self.logList:requestDoLayout()
  self.logList:jumpToBottom()
end

function CarbonTravelLayer:showMoveAble(roleId, moveStep)
  self.mapTipLayer:show()
  local player = self:findPlayer(roleId)
  local path = {}
  if moveStep == 7 then
    for step = 1, 6 do
      local p = {}
      self:getPath(player.stageIndex, step, path)
    end
  else
    self:getPath(player.stageIndex, moveStep, path)
  end
  local unique = {}
  local count = 0
  for _, q in ipairs(path) do
    if not unique[q] then
      unique[q] = true
      count = count + 1
    end
  end
  if count <= 1 then
    self:sendMsgMove(path[1])
  else
    SysError(SERVER_EXPLORE_ACTION_MOVE_TIP)
    self.moveAbles = {}
    for stageIndex, _ in pairs(unique) do
      local stageDis = self.mapDisData[stageIndex]
      local tip = UIHelper.createSpineNodeByRes("spine/ui/carbon/showmove"):pos(stageDis.xPos, stageDis.yPos):addTo(self.mapTipLayer)
      tip:setAnimation(0, "special", true)
      local touchLayer = UIHelper.extend(ccui.Layout:create())
      touchLayer:size(140, 250)
      touchLayer:anch(0.5, 0.5):pos(stageDis.xPos, stageDis.yPos):addTo(self.mapTipLayer)
      touchLayer:setTouchEnabled(true)
      touchLayer:setCallback(function()
        self:sendMsgMove(stageIndex)
      end)
    end
  end
end

function CarbonTravelLayer:initMap()
  UIHelper.newImageView(TravelRes .. "bg.png"):anch(0, 0):addTo(self.mapNode)
  self.tiledMap = cc.TMXTiledMap:create(self.carbonSet.levelRes .. ".tmx")
  self.tiledMap:addTo(self.mapNode)
  for _, child in pairs(self.tiledMap:getChildren()) do
    child:getTexture():setAntiAliasTexParameters()
  end
  local width, height = self.carbonSet.size:match("(%d+)=(%d+)")
  self.mapSize = {
    width = tonumber(width),
    height = tonumber(height)
  }
  local tileSize = self.tiledMap:getTileSize()
  local mapSize = self.tiledMap:getMapSize()
  local height1 = (mapSize.height - 1) * tileSize.height
  local height2 = (mapSize.height / 2 + 0.5) * tileSize.height
  local size = self.tiledMap:getContentSize()
  self.unitLayer = UIHelper.extend(ccui.Layout:create())
  self.unitLayer:size(size.width, size.height):addTo(self.tiledMap, 100)
  self.mapTipLayer = UIHelper.extend(ccui.Layout:create())
  self.mapTipLayer:size(size.width, size.height):addTo(self.tiledMap, 99)
  self.chooseLayer = UIHelper.extend(ccui.Layout:create())
  self.chooseLayer:size(size.width, size.height):addTo(self.tiledMap, 101)
  self.chooseLayer:hide()
  self.touchLayer = UIHelper.extend(ccui.Layout:create())
  self.touchLayer:size(size.width, size.height):addTo(self.tiledMap)
  self.touchLayer:setTouchEnabled(true)
  self.mapDisData = {}
  local zorder = {}
  local group = self.tiledMap:getObjectGroup("object")
  for index, object in pairs(group:getObjects()) do
    local stageIndex = tonumber(object.key)
    if stageIndex ~= 0 then
      local data = {
        index = index,
        xPos = object.x + object.width / 2,
        yPos = height2 - (height1 - object.y) + object.height / 2,
        width = object.width,
        height = object.height
      }
      local stageSet = self.mapSet[stageIndex]
      data.neighbor = stageSet.neighbor:toArray("=", true)
      self.mapDisData[stageIndex] = data
      if not zorder[data.yPos] then
        zorder[data.yPos] = {}
      end
      table.insert(zorder[data.yPos], {
        index = stageIndex,
        x = data.xPos
      })
    end
  end
  local sort = {}
  for yPos, list in pairs(zorder) do
    table.insert(sort, {y = yPos, list = list})
  end
  table.sort(sort, function(a, b)
    return a.y > b.y
  end)
  local z = 1
  for _, data in ipairs(sort) do
    table.sort(data.list, function(a, b)
      return a.x < b.x
    end)
    for _, pos in ipairs(data.list) do
      local stageDis = self.mapDisData[pos.index]
      stageDis.zorder = z
      z = z + 10
    end
  end
  local oldPos
  self.touchLayer:addTouchEventListener(function(sender, type)
    if self.waitMove then
      return
    end
    if type == ccui.TouchEventType.began then
      oldPos = sender:convertToNodeSpace(sender:getTouchBeganPosition())
    elseif type == ccui.TouchEventType.moved then
      pos = sender:convertToNodeSpace(sender:getTouchMovePosition())
      local xpos, ypos = self.tiledMap:getPosition()
      local deltaX, deltaY = oldPos.x - pos.x, oldPos.y - pos.y
      if 0 <= xpos and deltaX < 0 then
        deltaX = 0
      end
      if xpos <= -size.width + display.width and 0 < deltaX then
        deltaX = 0
      end
      if 0 <= ypos and deltaY < 0 then
        deltaY = 0
      end
      if ypos <= display.height - height2 and 0 < deltaY then
        deltaY = 0
      end
      self.tiledMap:setPositionX(xpos - deltaX)
      self.tiledMap:setPositionY(ypos - deltaY)
    end
  end)
end

function CarbonTravelLayer:moveCamera(index, time, callback)
  local xPos, yPos = self:convertPos(index)
  if time then
    self.tiledMap:runAction(transition.sequence({
      cc.MoveTo:create(time, cc.p(xPos, yPos)),
      cc.CallFunc:create(function()
        if callback then
          callback()
        end
      end)
    }))
  else
    self.tiledMap:pos(xPos, yPos)
  end
end

function CarbonTravelLayer:refreshStage()
  for stageIndex, stage in ipairs(self._mapData) do
    if stage.bRefresh then
      stage.bRefresh = false
      local stageDis = self.mapDisData[stageIndex]
      if stageDis.display and not tolua.isnull(stageDis.display) then
        stageDis.display:removeAllChildren()
      end
      stageDis.display = display.newNode():pos(stageDis.xPos, stageDis.yPos):addTo(self.unitLayer, stageDis.zorder - 1)
      stageDis.display:setCascadeOpacityEnabled(true)
      if stage.type == ExploreType.Enemy and stage.content ~= 0 then
        local monster = MonsterCsv[stage.content]
        local spine = UIHelper.createSpineNode(monster.unitType)
        spine:setToSetupPose()
        spine:setAnimation(0, "idle", true)
        spine:pos(0, 0):addTo(stageDis.display)
        local enemyValue = monster.battleValue * self.difficult * ChapterInfoCsv[self.difficult].factor
        local roleValue = self.exploreStatus.battleValue
        local rate
        if enemyValue <= roleValue then
          rate = math.floor(math.min(100, 60 + (roleValue / enemyValue - 1) * 40))
        else
          rate = math.floor(math.max(0, 40 + (roleValue / enemyValue - 1) * 60))
        end
        if self:hasBuffType(self.selfRoleId, ExploreItemType.Weak) then
          rate = 0
        end
        if self:hasBuffType(self.selfRoleId, ExploreItemType.Victory) then
          rate = 100
        end
        local unitSet = UnitCsv[monster.unitType]
        local rateBar = display.newSprite(TravelRes .. "rate_bg.png"):anch(0.5, 0):pos(0, unitSet.hpBarHeight):addTo(stageDis.display):name("rateBar")
        display.newTTFLabel({
          text = string.format("%d%%", rate),
          size = 20,
          color = UIHelper.hex2rgb("#f54db1")
        }):pos(45, 15):addTo(rateBar)
        stageDis.spine = spine
      end
      if stage.type == ExploreType.Cross then
        local spine = UIHelper.createSpineNodeByRes("spine/ui/carbon/csm_idle")
        spine:pos(0, -15):addTo(stageDis.display)
        spine:setAnimation(0, "special", true)
        stageDis.spine = spine
      end
      if stage.type == ExploreType.Item and stage.content ~= 0 then
        local item = TraveItemCsv[stage.type]
        local spine = UIHelper.createSpineNodeByRes("spine/ui/carbon/card")
        spine:setToSetupPose()
        spine:setAnimation(0, "idle", true)
        spine:pos(0, 20):addTo(stageDis.display)
        stageDis.spine = spine
      end
    end
  end
end

function CarbonTravelLayer:firstEnter()
  for stageIndex, data in ipairs(self.roomInfo.mapData) do
    local stage = clone(data)
    stage.bRefresh = true
    self._mapData[stageIndex] = stage
  end
  local visitor = true
  for roleIndex, player in ipairs(self.roomInfo.mainPlayers) do
    self:addNewPlayer(player, roleIndex)
    if player.roleId == game.role.id then
      for _, itemId in ipairs(player.items) do
        self:addItemBar(itemId)
      end
      visitor = false
    end
    if player.waiting then
      self.currentPlayer = player.roleId
    end
  end
  self:refreshStage()
  self:showHeads()
  if self.currentPlayer then
    self:playerStart({
      roleId = self.currentPlayer
    }, true)
  end
end

function CarbonTravelLayer:addNewPlayer(unit, roleIndex)
  local player = clone(unit)
  local displayNode = display.newNode()
  local spine = UIHelper.createSpineNode(player.roleInfo.leader.type)
  spine:addTo(displayNode)
  spine:setToSetupPose()
  spine:setAnimation(0, "idle", true)
  local topBar = display.newSprite(BattleRes .. "hpbar_slot.png"):pos(0, 145):addTo(displayNode):name("topBar")
  local indexBg = display.newSprite(TravelRes .. "index_bg.png"):anch(1, 0.5):pos(0, -5):addTo(topBar):name("indexBg")
  local index = roleIndex
  if player.roleId == self.selfRoleId then
    index = 0
  end
  display.newSprite(TravelRes .. string.format("player_%d.png", index)):center(indexBg):addTo(indexBg)
  local healthBar = display.newProgressTimer(BattleRes .. "hpbar_action.png", display.PROGRESS_TIMER_BAR):pos(35, 3):addTo(topBar)
  healthBar:setMidpoint(cc.p(0, 0.5))
  healthBar:setBarChangeRate(cc.p(1, 0))
  healthBar:setPercentage(player.health / globalCsv.tourEnergy * 100)
  player.buffNode = display.newNode():pos(0, 75):addTo(displayNode)
  player.timeNode = display.newNode():pos(60, 75):addTo(displayNode)
  local stageDis = self.mapDisData[player.stageIndex]
  displayNode:pos(stageDis.xPos, stageDis.yPos):addTo(self.unitLayer, stageDis.zorder)
  player.display = displayNode
  player.spine = spine
  player.healthBar = healthBar
  table.insert(self._mainPlayers, player)
end

function CarbonTravelLayer:netListen()
  self.netHandler = NetManager:addEventListener(actionHandlers[actionCodes.Explore_updateActions], function(event)
    local msg = MsgPack.unpack(event.data)
    if msg.msgId ~= self._msgId then
      self.eventList = {}
      self:reConnect()
      return
    end
    self._msgId = self._msgId + 1
    local count = #self.eventList
    for index, event in ipairs(msg.events) do
      if event.action == RoomEvent.playerExit and event.roleId == self.selfRoleId then
        self.eventList = {}
        self:playerExit(event)
        return
      elseif event.action == RoomEvent.playerTalk then
        self:playerTalk(event)
      else
        table.insert(self.eventList, event)
      end
    end
    if count == 0 and not self.eventWait then
      self:eventHandler()
    end
  end)
end

function CarbonTravelLayer:onExit()
  NetManager:removeEventListener(self.netHandler)
  if self.fightMusic then
    game:stopMusic(self.fightMusic)
    self.fightMusic = nil
  end
end

function CarbonTravelLayer:BFS(src, dest)
  local S, visit, Path = {}, {}, {}
  visit[src] = true
  table.insert(S, src)
  for index, _ in ipairs(self.mapDisData) do
    Path[index] = {}
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

function CarbonTravelLayer:getPath(src, step, path)
  if step == 0 then
    table.insert(path, src)
    return
  end
  local q = self.mapDisData[src]
  for _, p in ipairs(q.neighbor) do
    self:getPath(p, step - 1, path)
  end
end

function CarbonTravelLayer:findPlayer(roleId)
  for _, player in ipairs(self._mainPlayers) do
    if player.roleId == roleId then
      return player
    end
  end
end

function CarbonTravelLayer:convertPos(index)
  local data = self.mapDisData[index]
  local size = self.mapSize
  local newxpos = data.xPos
  local newypos = data.yPos
  if newxpos + display.width / 2 >= size.width then
    newxpos = size.width - display.width / 2
  end
  if newypos + display.height / 2 >= size.height then
    newypos = size.height - display.height / 2
  end
  local xpos = display.width / 2 - newxpos
  local ypos = display.height / 2 - newypos - 50
  local xpos = display.width / 2 - newxpos
  local ypos = display.height / 2 - newypos - 50
  if newxpos < display.width / 2 then
    xpos = 0
  end
  return xpos, ypos
end

function CarbonTravelLayer:sendMsgMove(targetIndex)
  game:sendData(actionCodes.Explore_moveRpc, MsgPack.pack({targetIndex = targetIndex}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Explore_moveRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    if msg.result == SERVER_EXPLORE_ACTION_SUCCESS then
    else
      SysError(msg.result)
    end
  end)
end

function CarbonTravelLayer:sendMsgDice(skipEffect)
  local player = self:findPlayer(self.currentPlayer)
  game:sendData(actionCodes.Explore_diceRpc, "")
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Explore_diceRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    if msg.result == SERVER_EXPLORE_DICE_SUCCESS then
      print("投掷了", msg.dice)
      print("可以移动", msg.moveStep)
      
      local function diceEnd()
        if msg.moveStep == 7 then
        else
          self:addLog(10, {
            pm1 = player.roleInfo.name,
            pm2 = msg.moveStep
          })
        end
        self:showMoveAble(self.selfRoleId, msg.moveStep)
      end
      
      if not skipEffect then
        self.effectNode:removeAllChildren()
        local diceMask = UIHelper.newMask({
          size = cc.size(display.width, display.height),
          color = "#000000",
          opacity = 110
        })
        diceMask:addTo(self.effectNode)
        diceMask:setTouchEnabled(true)
        local animation = tostring(msg.dice)
        game:playMusic(1900)
        local diceEffect = UIHelper.createSpineNodeByRes("spine/ui/carbon/dice"):pos(display.cx, display.cy):addTo(diceMask)
        diceEffect:setAnimation(0, "chuxian", false)
        diceEffect:addAnimation(0, animation, false)
        diceEffect:registerSpineEventHandler(function(event)
          if event.type ~= "end" then
            return
          end
          if event.animation ~= animation then
            return
          end
          diceEnd()
          scheduler.performWithDelayGlobal(function()
            self.effectNode:removeAllChildren()
          end, 0.016666666666666666)
        end, sp.EventType.ANIMATION_END)
      else
        diceEnd()
      end
      self:showDiceBar()
    else
      SysError(msg.result)
    end
  end)
end

function CarbonTravelLayer:reConnect()
  if self.netHandler then
    NetManager:removeEventListener(self.netHandler)
    self.netHandler = nil
  end
  game:sendData(actionCodes.Explore_enterRpc, MsgPack.pack({
    difficult = self.difficult,
    teamIndex = self.teamIndex
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Explore_enterRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    if msg.result == SERVER_EXPLORE_ENTER_SUCCESS then
      game:enterScene("TravelScene", msg)
    else
      game:enterScene("MainScene")
      SysError(msg.result)
    end
  end)
end

return CarbonTravelLayer
