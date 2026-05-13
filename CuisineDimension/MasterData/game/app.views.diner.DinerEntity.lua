local DinerFitRes = "diner/fit/"
local DinerBoxUI = "ui/diner/box/"
local DinerItemCsv = require("csvdata.diner_fitment")
local DressCsv = require("csvdata.hero_skin")
local TalkBgCsv = require("csvdata.diner_bubbles")
local HeroPose = {
  [1] = "sit",
  [2] = "sleep",
  [3] = "moe"
}
local DinerEntity = class("DinerEntity", function()
  return UIHelper.extend(ccui.Widget:create())
end)

function DinerEntity:ctor(params)
  params = params or {}
  self.touchNode = display.newNode():addTo(self)
  self.sideNode = display.newNode():addTo(self)
  self.shadowNode = display.newNode():addTo(self)
  self.displayNode = display.newNode():addTo(self)
  self.menuNode = display.newNode():addTo(self)
  self.type = params.type
  self.item = params.item
  self.side = params.side
  self._id = params._id or 0
  self._mx = params.mx or 1
  self._my = params.my or 1
  self._side = params.side
  self._bFlip = (params.flip or 0) == 1
  if self.side ~= nil then
    self._bFlip = self.side == WallSide.left
  end
  self.eventHandler = params.eventHandler
  self.boxLogic = params.boxLogic
  self.content = params.content
  if self.type == EntityType.hero then
    self.heroType = params.heroType
    self.heroDress = params.heroDress
    self.refreshTime = math.randomFloat(2, 5)
    self.talk = params.talk
    self.moveAction = nil
  end
  self.itemSet = DinerItemCsv[self.item]
  self.xWidth = 1
  self.yWidth = 1
  self.status = "default"
  self.bMoving = false
  self._canSetToPos = true
  self._boxHold = {}
  self._lastBoxMp = nil
  self:init(params)
end

function DinerEntity:init(params)
  local touchSize, touchAnch, gp
  if self.type == EntityType.hero then
    local dressType
    local dressId = self.heroType * 10 + self.heroDress
    local dressSet = DressCsv[dressId]
    if not dressSet then
      dressType = self.heroType
    else
      dressType = dressSet.hero
    end
    local spine, scale = UIHelper.createSpineNode(dressType)
    spine:addTo(self.displayNode)
    spine:setAnimation(0, "idle", true)
    spine:scale(scale * 1.25)
    touchSize = cc.size(100, 150)
    touchAnch = cc.p(0.5, 0.16)
    self.displayEntity = spine
    self.xWidth = 1
    self.yWidth = 1
    self:initPoseOffset(dressSet)
    display.newSprite("ui/battle/player_shadow.png"):addTo(self.shadowNode)
    local mp = self.boxLogic:getRandomPos(self.type, cc.size(self.xWidth, self.yWidth))
    self._mx = mp.x
    self._my = mp.y
    gp = self.boxLogic:m2g(self._mx, self._my, {
      type = EntityType.fitment
    })
    self:startTalk()
  elseif self.type == EntityType.fitment or self.type == EntityType.rug then
    local sprite = UIHelper.newImageView(DinerFitRes .. self.itemSet.res)
    local anchX, anchY = self.itemSet.anch:match("(%d+)=(%d+)")
    local size = sprite:getContentSize()
    sprite:anch(anchX / size.width, anchY / size.height)
    sprite:addTo(self.displayNode)
    if self._bFlip then
      sprite:setFlippedX(self._bFlip)
    end
    touchSize = sprite:getContentSize()
    touchAnch = sprite:getAnchorPoint()
    self.displayEntity = sprite
    self.xWidth = self.itemSet.xw
    self.yWidth = self.itemSet.yw
    gp = self.boxLogic:m2g(params.mx, params.my, {
      type = self.type
    })
    if self.itemSet.sitPoint ~= "" then
      self.sitPoints = {}
      self.sitList = {}
      local points = self.itemSet.sitPoint:toTableArray()
      for _, p in ipairs(points) do
        table.insert(self.sitPoints, cc.p(tonumber(p[1]), tonumber(p[2])))
      end
    end
    self.sitNode = display.newNode():addTo(self.displayEntity)
    self.uplayerNode = display.newNode():addTo(self.displayEntity)
    if self.itemSet.upLayer ~= "" then
      local up = display.newSprite(DinerFitRes .. self.itemSet.upLayer)
      up:anch(0, 0):addTo(self.uplayerNode)
    end
  elseif self.type == EntityType.wallItem then
    local sprite = UIHelper.newImageView(DinerFitRes .. self.itemSet.res)
    local anchX, anchY = self.itemSet.anch:match("(%d+)=(%d+)")
    local size = sprite:getContentSize()
    sprite:anch(anchX / size.width, anchY / size.height)
    sprite:addTo(self.displayNode)
    if self._bFlip then
      sprite:setFlippedX(self._bFlip)
    end
    touchSize = sprite:getContentSize()
    touchAnch = sprite:getAnchorPoint()
    self.displayEntity = sprite
    self.xWidth = self.itemSet.xw
    self.yWidth = self.itemSet.yw
    gp = self.boxLogic:m2g(params.mx, params.my, {
      type = self.type,
      side = self.side
    })
  end
  local touchLayer = UIHelper.newMask({size = touchSize})
  touchLayer:anch(touchAnch.x, touchAnch.y)
  touchLayer:addTo(self.touchNode)
  touchLayer:setTouchEnabled(true)
  touchLayer:addTouchEventListener(function(sender, type)
    self:handler(sender, type)
  end)
  if self._bFlip then
    touchLayer:setFlippedX(self._bFlip)
  end
  self.touchLayer = touchLayer
  self:addTo(self.content):pos(gp.x, gp.y)
end

function DinerEntity:initPoseOffset(dressSet)
  self._sleepRotate = 10
  self._sleepOffset = cc.p(0, 0)
  self._sitOffset = cc.p(0, 0)
  if not dressSet then
    return
  end
  self._sleepRotate = self._sleepRotate + dressSet.sleepRotate
  if dressSet.sleepOffset ~= "" then
    local x, y = dressSet.sleepOffset:match("%s*([-]?%d+)=([-]?%d+)%s*")
    self._sleepOffset = cc.p(tonumber(x), tonumber(y))
  end
  if dressSet.sitOffset ~= "" then
    local x, y = dressSet.sitOffset:match("%s*([-]?%d+)=([-]?%d+)%s*")
    self._sitOffset = cc.p(tonumber(x), tonumber(y))
  end
end

function DinerEntity:handler(sender, type)
  if self.boxLogic.editStatus == EditStatus.normal then
    if self.type ~= EntityType.hero then
      return
    end
    self:handlerHero(sender, type)
    return
  elseif self.type == EntityType.hero then
    return
  end
  if self.status == "default" then
    if type == ccui.TouchEventType.ended then
      self:selectEntity()
    end
    return
  end
  if self.status == "selected" then
    if type == ccui.TouchEventType.began then
      self._beginPos = cc.p(self:getPosition())
    end
    if type == ccui.TouchEventType.moved then
      self.bMoving = true
      local movePos = sender:getTouchMovePosition()
      local beginPos = sender:getTouchBeganPosition()
      local zoom = self.boxLogic:getZoom()
      self:setPos(self._beginPos.x + (movePos.x - beginPos.x) / zoom, self._beginPos.y + (movePos.y - beginPos.y) / zoom)
    end
    if type == ccui.TouchEventType.ended or type == ccui.TouchEventType.canceled then
      self.bMoving = false
      local endPos = sender:getTouchEndPosition()
      local beginPos = sender:getTouchBeganPosition()
      local zoom = self.boxLogic:getZoom()
      self:setPosFinal(self._beginPos.x + (endPos.x - beginPos.x) / zoom, self._beginPos.y + (endPos.y - beginPos.y) / zoom)
    end
  end
end

function DinerEntity:showTalk()
  if self.talk and self.talk.talk and self.talk.talk ~= "" and not self.isTalking and self.canTalk then
    if not self.talkPao or tolua.isnull(self.talkPao) then
      local talkBgData = TalkBgCsv[self.talk.talkBg or 1]
      self.talkPao = display.newSprite(talkBgData.path):pos(70 + talkBgData.x_offset, 200 + talkBgData.y_offset):addTo(self):name("talkbg")
      self.talkPao:setCascadeOpacityEnabled(true)
      display.newTTFLabel({
        text = self.talk.talk,
        size = 18,
        dimensions = cc.size(130, 36),
        align = cc.TEXT_ALIGNMENT_CENTER,
        valign = cc.VERTICAL_TEXT_ALIGNMENT_CENTER,
        color = UIHelper.hex2rgb("#5d5044")
      }):anch(0.5, 0.5):center(self.talkPao):name("text"):addTo(self.talkPao)
    end
    self.isTalking = true
    self.talkPao:stopAllActions()
    self.talkPao:show()
    self.talkPao:setOpacity(255)
    self.talkPao:scale(0.4)
    local randomTime = math.randomFloat(6, 15)
    self.talkPao:runAction(transition.sequence({
      cc.EaseElasticOut:create(cc.ScaleTo:create(0.8, 1)),
      cc.DelayTime:create(2),
      cc.FadeOut:create(0.3),
      cc.CallFunc:create(function()
        self.talkPao:hide()
        self.isTalking = false
      end),
      cc.DelayTime:create(randomTime),
      cc.CallFunc:create(function()
        self:showTalk()
      end)
    }))
  end
end

function DinerEntity:hideTalk()
  self.canTalk = false
  self.isTalking = false
  if not self.talkPao or tolua.isnull(self.talkPao) then
    return
  end
  self.talkPao:stopAllActions()
  self.talkPao:hide()
end

function DinerEntity:startTalk()
  self.canTalk = true
  self.isTalking = false
  local randomTime = math.randomFloat(1, 15)
  self:runAction(transition.sequence({
    cc.DelayTime:create(randomTime),
    cc.CallFunc:create(function()
      self:showTalk()
    end)
  }))
end

function DinerEntity:showReward(show)
  if show then
    if not self.rewardPao then
      self.rewardPao = UIHelper.newImageView("ui/diner/box/" .. "reward.png"):pos(-60, 170):addTo(self)
      self.rewardPao:setCallback(function()
        game:sendData(actionCodes.Diner_getBoxRewardRpc, MsgPack.pack({
          slot = self.boxLogic.boxId
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Diner_getBoxRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          if next(msg.reward) then
            MedalRewardLayer.new({
              items = msg.reward
            })
          end
        end)
      end)
    end
  elseif self.rewardPao then
    self.rewardPao:removeSelf()
  end
end

function DinerEntity:heroTouchLong()
  if self.longTouchHandler then
    scheduler.unscheduleGlobal(self.longTouchHandler)
  end
  self._touchLong = true
  if self._sitFitment then
    self:removeFromFitment(self._sitFitment)
  end
  self._beginPos = cc.p(self:getPosition())
  self.bMoving = true
  if self.moveAction then
    self:stopAllActions()
    self.moveAction = nil
  end
  self.displayEntity:setToSetupPose()
  self.displayEntity:setAnimation(0, "pick", true)
  self.displayEntity:setRotation(0)
  self.displayEntity:pos(0, 80)
  self:setPos(self._beginPos.x, self._beginPos.y)
  self.shadowNode:hide()
end

function DinerEntity:handlerHero(sender, type)
  if type == ccui.TouchEventType.began then
    self._touchLong = false
    if self.longTouchHandler then
      scheduler.unscheduleGlobal(self.longTouchHandler)
    end
    self.longTouchHandler = scheduler.scheduleGlobal(function()
      self:heroTouchLong()
    end, 0.2)
  end
  if type == ccui.TouchEventType.moved and self._touchLong == true then
    local movePos = sender:getTouchMovePosition()
    local beginPos = sender:getTouchBeganPosition()
    local zoom = self.boxLogic:getZoom()
    self:setPos(self._beginPos.x + (movePos.x - beginPos.x) / zoom, self._beginPos.y + (movePos.y - beginPos.y) / zoom)
  else
  end
  if type == ccui.TouchEventType.ended or type == ccui.TouchEventType.canceled then
    if self._touchLong == true then
      self.bMoving = false
      local endPos = sender:getTouchEndPosition()
      local beginPos = sender:getTouchBeganPosition()
      local zoom = self.boxLogic:getZoom()
      self.shadowNode:show()
      self.displayEntity:pos(0, 0)
      if self._sitFitment then
        self:sitToFitment(self._sitFitment)
      else
        self:setPosFinal(self._beginPos.x + (endPos.x - beginPos.x) / zoom, self._beginPos.y + (endPos.y - beginPos.y) / zoom)
        self.displayEntity:setToSetupPose()
        self.displayEntity:setAnimation(0, "idle", true)
        self.displayEntity:setRotation(0)
      end
      self.sideNode:hide()
    else
      if self.longTouchHandler then
        scheduler.unscheduleGlobal(self.longTouchHandler)
      end
      local beginPos = sender:getBeginPos()
      local endPos = sender:getEndPos()
      if math.abs(beginPos.x - endPos.x) < 20 and math.abs(beginPos.y - endPos.y) < 20 then
        self:showTalk()
      end
    end
  end
end

function DinerEntity:setPos(x, y)
  if self.type == EntityType.wallItem then
    local side = self.boxLogic:getWallSide(x, y)
    if side ~= self.side then
      self:onFlip()
      self.side = side
    end
  end
  self:pos(x, y)
  local canOccupy, result = self.boxLogic:getOccupy(self)
  if not next(result) then
    canOccupy = false
  end
  self._sitFitment = nil
  if self.type == EntityType.hero and not canOccupy then
    local holdEntity
    for i, data in pairs(result) do
      for j, _entity in pairs(data) do
        if type(_entity) == "userdata" then
          holdEntity = _entity
          break
        end
      end
    end
    if holdEntity and holdEntity:canSit(self) then
      result = nil
      canOccupy = true
      self._sitFitment = holdEntity
    end
  end
  self._canSetToPos = canOccupy
  self:showBoxRect(result)
end

function DinerEntity:setPosFinal(x, y, skipSet)
  local mp = cc.p(self._mx, self._my)
  if self._canSetToPos or skipSet then
    mp = self.boxLogic:g2m(x, y, {
      type = self.type,
      side = self.side
    })
  elseif self.side ~= self._side then
    self:onFlip()
    self.side = self.side == WallSide.right and WallSide.left or WallSide.right
  end
  local gp = self.boxLogic:m2g(mp.x, mp.y, {
    type = self.type,
    side = self.side
  })
  if not skipSet then
    self:pos(gp.x, gp.y)
  end
  self._mx = mp.x
  self._my = mp.y
  self._side = self.side
  self:showBoxRect()
  self:setEvent("setPos")
end

function DinerEntity:showBoxRect(occupy)
  self.sideNode:show()
  local sp = cc.p(self:getPosition())
  local mp = self.boxLogic:g2m(sp.x, sp.y, {
    type = self.type,
    side = self.side
  })
  if self._lastBoxMp and self._lastBoxMp == mp then
    return
  end
  self._lastBoxMp = mp
  self.sideNode:removeAllChildren()
  local rect = self:getBoxRect()
  for i = rect.x, rect.x + rect.width - 1 do
    for j = rect.y, rect.y + rect.height - 1 do
      local gp = self.boxLogic:m2g(i, j, {
        type = self.type,
        side = self.side
      })
      if self.type == EntityType.fitment or self.type == EntityType.hero or self.type == EntityType.rug then
        local res = "rect_ok.png"
        if occupy and occupy[i][j] then
          res = "rect_hold.png"
        end
        display.newSprite(DinerBoxUI .. res):pos(gp.x - sp.x, gp.y - sp.y):addTo(self.sideNode)
      else
        local res = "wall_ok.png"
        if occupy and occupy[i][j] then
          res = "wall_hold.png"
        end
        display.newSprite(DinerBoxUI .. res):pos(gp.x - sp.x, gp.y - sp.y):addTo(self.sideNode):flipX(self._bFlip)
      end
    end
  end
end

function DinerEntity:showMenu()
  if self.type == EntityType.hero then
    return
  end
  self.menuNode:show()
  self.menuNode:removeAllChildren()
  local size = self.touchLayer:getContentSize()
  local anchp = self.touchLayer:getAnchorPoint()
  local menuBg = display.newSprite(DinerBoxUI .. "item_menu_circle.png")
  local x = size.width * (0.5 - anchp.x)
  local y = size.height * (0.5 - anchp.y)
  if self._bFlip then
    x = x * -1
  end
  menuBg:pos(x, y):addTo(self.menuNode)
  local removeBtn = UIHelper.extend(ccui.Button:create())
  removeBtn:setImages(DinerBoxUI, {
    "item_menu_remove.png",
    "item_menu_remove.png"
  })
  removeBtn:pos(0, menuBg:getContentSize().height / 2):addTo(menuBg)
  removeBtn:setCallback(function()
    self:onRemove()
  end)
  local okBtn = UIHelper.extend(ccui.Button:create())
  okBtn:setImages(DinerBoxUI, {
    "item_menu_confirm.png",
    "item_menu_confirm.png"
  })
  okBtn:pos(menuBg:getContentSize().width, menuBg:getContentSize().height / 2):addTo(menuBg)
  okBtn:setCallback(function()
    self:onOk()
  end)
  if self.itemSet.canflip == 1 then
    local flipBtn = UIHelper.extend(ccui.Button:create())
    flipBtn:setImages(DinerBoxUI, {
      "item_menu_flip.png",
      "item_menu_flip.png"
    })
    flipBtn:pos(menuBg:getContentSize().width / 2, menuBg:getContentSize().height):addTo(menuBg)
    flipBtn:setCallback(function()
      self:onFlip()
    end)
  end
end

function DinerEntity:onRemove()
  if self.type == EntityType.hero then
    return
  end
  if self.bMoving then
    return
  end
  self:clearStatus()
  self:setEvent("remove")
end

function DinerEntity:onOk()
  self:clearStatus()
end

function DinerEntity:onFlip()
  local canOccupy = true
  if self.type == EntityType.fitment or self.type == EntityType.rug then
    local rect = self:getBoxRect(not self._bFlip)
    canOccupy, _ = self.boxLogic:getOccupy(self, rect)
  end
  if canOccupy then
    self._bFlip = not self._bFlip
    if self.type == EntityType.hero then
      local scale = self.displayEntity:getScaleX()
      self.displayEntity:setScaleX(math.abs(scale) * (self._bFlip and -1 or 1))
    else
      self.displayEntity:setFlippedX(self._bFlip)
      self:showMenu()
      self:showBoxRect()
    end
    self.touchLayer:setFlippedX(self._bFlip)
    self:setEvent("setPos")
  else
    SysError(SYS_ERR_DINER_BOX_CAN_NOT_FLIP)
  end
end

function DinerEntity:getBoxRect(flip)
  if flip == nil then
    flip = self._bFlip
  end
  local sp = cc.p(self:getPosition())
  local mp = self.boxLogic:g2m(sp.x, sp.y, {
    type = self.type,
    side = self.side,
    noLimit = true
  })
  if self.type == EntityType.hero and not self.bMoving then
    mp = cc.p(self._mx, self._my)
  end
  local left = math.huge
  local buttom = math.huge
  if self.type == EntityType.fitment or self.type == EntityType.rug then
    for i = 1, self.xWidth do
      for j = 1, self.yWidth do
        if flip then
          left = math.min(left, mp.x - (j - 1))
          buttom = math.min(buttom, mp.y - (i - 1))
        else
          left = math.min(left, mp.x - (i - 1))
          buttom = math.min(buttom, mp.y - (j - 1))
        end
      end
    end
    if flip then
      return cc.rect(left, buttom, self.yWidth, self.xWidth)
    else
      return cc.rect(left, buttom, self.xWidth, self.yWidth)
    end
  elseif self.type == EntityType.wallItem then
    left = mp.x
    buttom = mp.y
    return cc.rect(left, buttom, self.xWidth, self.yWidth)
  elseif self.type == EntityType.hero then
    left = mp.x
    buttom = mp.y
    return cc.rect(left, buttom, self.xWidth, self.yWidth)
  end
end

function DinerEntity:selectEntity()
  self.status = "selected"
  self:setEvent("selected")
  self:showBoxRect()
  self:showMenu()
end

function DinerEntity:clearStatus()
  self.status = "default"
  self.sideNode:hide()
  self.menuNode:hide()
  self:setEvent("unselected")
end

function DinerEntity:setEvent(event, params)
  if self.eventHandler then
    self.eventHandler(self, event, params)
  end
end

function DinerEntity:setOrder(value)
  self:zorder(value)
end

function DinerEntity:heroUpdate(dt)
  if self.moveAction then
    return
  end
  if self.bMoving then
    return
  end
  if self._sitFitment then
    return
  end
  if self.refreshTime > 0 then
    self.refreshTime = self.refreshTime - dt
    return
  end
  self.refreshTime = math.randomFloat(3, 20)
  local random = {
    {0, 1},
    {0, -1},
    {1, 0},
    {-1, 0}
  }
  local neibor = {}
  for i = 1, 4 do
    local index = math.randomInt(1, #random)
    table.insert(neibor, random[index])
    table.remove(random, index)
  end
  local map = self.boxLogic._mapFloor
  local nextPos
  for _, pos in ipairs(neibor) do
    local x = self._mx + pos[1]
    local y = self._my + pos[2]
    if map[x] and map[x][y] and not map[x][y].holdEntity then
      nextPos = cc.p(x, y)
      break
    end
  end
  if not nextPos then
    self:onFlip()
  else
    local direction = "left"
    if nextPos.x < self._mx or nextPos.y > self._my then
      direction = "right"
    end
    if self._bFlip and direction == "right" or not self._bFlip and direction == "left" then
      self:onFlip()
    end
    local endPos = self.boxLogic:m2g(nextPos.x, nextPos.y, {
      type = self.type
    })
    local sp = cc.p(self:getPosition())
    local time = math.sqrt((endPos.x - sp.x) * (endPos.x - sp.x) + (endPos.y - sp.y) * (endPos.y - sp.y)) / 20
    self:setPosFinal(endPos.x, endPos.y, true)
    self.displayEntity:setToSetupPose()
    self.displayEntity:setAnimation(0, "walk", true)
    self.moveAction = self:runAction(transition.sequence({
      cc.MoveTo:create(time, endPos),
      cc.CallFunc:create(function()
        self.moveAction = nil
        self.displayEntity:setToSetupPose()
        if math.randomInt(1, 100) < 30 then
          self.displayEntity:setToSetupPose()
          self.displayEntity:setAnimation(0, "moe", false)
          self.displayEntity:addAnimation(0, "idle", true)
        else
          self.displayEntity:setToSetupPose()
          self.displayEntity:setAnimation(0, "idle", true)
        end
      end)
    }))
    self.sideNode:hide()
  end
end

function DinerEntity:canSit(heroEntity)
  if self.type ~= EntityType.fitment then
    return false
  end
  if self.itemSet.pose == 0 then
    return false
  end
  for _, pos in ipairs(self.sitList) do
    if pos.entity == heroEntity then
      return true
    end
  end
  if #self.sitList == #self.sitPoints then
    return false
  end
  return true
end

function DinerEntity:sitToFitment(target)
  if not target then
    return
  end
  local params = target:addPoseHero(self)
  if params then
    self.shadowNode:hide()
    self:retain()
    self:getParent():removeChild(self, false)
    self:addTo(params.content, params.order)
    self:release()
    local p = params.p
    if params.pose == 1 then
      p = cc.p(params.p.x + self._sitOffset.x, params.p.y + self._sitOffset.y)
    elseif params.pose == 2 then
      p = cc.p(params.p.x + self._sleepOffset.x, params.p.y + self._sleepOffset.y)
    end
    self:pos(p.x, p.y)
    local pose = HeroPose[params.pose]
    if pose then
      self.displayEntity:setToSetupPose()
      self.displayEntity:setAnimation(0, pose, true)
      if params.pose == 2 then
        self.displayEntity:setRotation(self._sleepRotate)
      end
    end
    if self._bFlip then
      self:onFlip()
    end
    self._offsetPos = params.offset
    self:hideTalk()
  end
end

function DinerEntity:removeFromFitment(target)
  if not target then
    return
  end
  local targetPos = cc.p(target:getPosition())
  target:removePoseHero(self)
  local offset = self._offsetPos or cc.p(0, 0)
  local p = cc.p(targetPos.x + offset.x, targetPos.y + offset.y)
  self:retain()
  self:getParent():removeChild(self, false)
  self:addTo(self.content)
  self:release()
  self:pos(p.x, p.y)
  self._sitFitment = nil
  self:startTalk()
end

function DinerEntity:addPoseHero(heroEntity)
  for _, pos in ipairs(self.sitList) do
    if pos.entity == heroEntity then
      return
    end
  end
  local occupy = {}
  for _, pos in ipairs(self.sitList) do
    occupy[pos.index] = true
  end
  local index
  for i = 1, #self.sitPoints do
    if not occupy[i] then
      index = i
      break
    end
  end
  if not index then
    return
  end
  table.insert(self.sitList, {entity = heroEntity, index = index})
  local p = self.sitPoints[index]
  local cx, cy = self.itemSet.anch:match("(%d+)=(%d+)")
  local offset = cc.p(0, 0)
  if self._bFlip then
    offset = cc.p(-p.x + tonumber(cx), p.y - tonumber(cy))
  else
    offset = cc.p(p.x - tonumber(cx), p.y - tonumber(cy))
  end
  return {
    p = cc.p(p.x, p.y),
    offset = offset,
    pose = self.itemSet.pose,
    content = self.sitNode,
    bFlip = self._bFlip,
    order = index
  }
end

function DinerEntity:removePoseHero(heroEntity)
  for index, pos in ipairs(self.sitList) do
    if pos.entity == heroEntity then
      table.remove(self.sitList, index)
      break
    end
  end
end

function DinerEntity:getHotPoint()
  if self.type == EntityType.hero then
    return 0
  end
  if not self.itemSet then
    return 0
  end
  if self.itemSet.box == self.boxLogic:getBoxId() then
    return self.itemSet.point2
  else
    return self.itemSet.point1
  end
end

function DinerEntity:updateEditStatus()
  if self.type == EntityType.hero then
    return
  end
  if not self.touchNode then
    return
  end
  if self.boxLogic.editStatus == EditStatus.normal then
    self.touchNode:hide()
  else
    self.touchNode:show()
  end
end

return DinerEntity
