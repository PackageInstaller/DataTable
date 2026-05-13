local unitCsv = require("csvdata.unit")
local treatRes = "ui/treat/"
local kitchenRes = "ui/kitchen/"
local uiData = {
  csbFile = "ui/treat/TreatHeroLayer.csb",
  mask = true,
  widgets = {
    mainBg = "mainBg",
    touch = "touch",
    angle1 = "angle1",
    angle2 = "angle2",
    upBar = "upBar",
    infoBg = "infoBg",
    btnLeft = "btnLeft",
    btnRight = "btnRight",
    useCount = "infoBg/useCount",
    quickCount = "infoBg/quickCount",
    list = "list"
  }
}
local TreatHeroLayer = class("TreatHeroLayer", UIBase)

function TreatHeroLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TreatHeroLayer:init(params)
  local clock = display.newSprite(kitchenRes .. "angle_clock.png"):anch(0, 0):addTo(self)
  display.newSprite(kitchenRes .. "hour_hand.png"):anch(0.5, 0.7):pos(53, 58):addTo(clock):runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.touch)
    UIHelper.fitForiPhoneX(self.upBar, true)
    self.angle1:setPositionX(self.angle1:getPositionX() - 125)
    self.angle2:setPositionX(self.angle2:getPositionX() + 125)
    clock:setPositionX(clock:getPositionX() - 125)
  end
  TopBar:show(TopBarType.full, "治疗")
  TopBar:showAnimation(true)
  self.useCount:setString(string.format("%d/8", game.role.treatSlot))
  self.infoBg:setCascadeOpacityEnabled(true)
  self.quickCount:setString(game.role.items[globalCsv.quickRepair] or 0)
  UIHelper.MoveToUp({node = clock, time = 0.2})
  UIHelper.MoveToDown({
    node = self.upBar
  })
  UIHelper.MoveToLeft({
    node = self.infoBg,
    delay = 0.2,
    time = 0.3
  })
  self.btnLeft:hide()
  self.btnLeft:runAction(cc.RepeatForever:create(transition.sequence({
    cc.FadeOut:create(0.5),
    cc.DelayTime:create(0.2),
    cc.FadeIn:create(0.5),
    cc.DelayTime:create(0.2)
  })))
  self.btnRight:runAction(cc.RepeatForever:create(transition.sequence({
    cc.FadeOut:create(0.5),
    cc.DelayTime:create(0.2),
    cc.FadeIn:create(0.5),
    cc.DelayTime:create(0.2)
  })))
  self.touch:setTouchEnabled(true)
  self.touch:enableNodeEvents()
  local touchEvent = {
    [ccui.TouchEventType.began] = handler(self, self.onTouchBegan),
    [ccui.TouchEventType.moved] = handler(self, self.onTouchMoved),
    [ccui.TouchEventType.ended] = handler(self, self.onTouchEnded),
    [ccui.TouchEventType.canceled] = handler(self, self.onTouchCancelled)
  }
  self.touch:addTouchEventListener(function(sender, type)
    touchEvent[type](sender)
  end)
  self.isShow = false
  self.needShow = {}
  self.originX = 0
  self:initTable()
end

function TreatHeroLayer:initTable()
  self.list:removeAllChildren()
  display.newSprite(treatRes .. "desk.png"):anch(0, 0):pos(-125, 0):addTo(self.list)
  display.newSprite(treatRes .. "desk.png"):anch(0, 0):pos(1136, 0):addTo(self.list)
  local xPos, yPos, interval = 135, 170, 285
  self.slots = {}
  for index = 1, 8 do
    local heroNode = display.newNode():pos(xPos + (index - 1) * interval, yPos + 70):addTo(self.list, -index)
    local deskNode = display.newNode():pos(xPos + (index - 1) * interval, yPos):addTo(self.list)
    display.newSprite(treatRes .. "stool.png"):pos(xPos + (index - 1) * interval, yPos - 130):addTo(self.list)
    self.slots[index] = {heroNode = heroNode, deskNode = deskNode}
    if 2 < index then
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(treatRes, {
        "reserve_a.png",
        "reserve_b.png"
      })
      btn:anch(0.5, 0):pos(0, 0):addTo(deskNode)
      btn:setCallback(function(sender)
        SysError(SYS_ERR_TREAT_TABLE_NOT_OPEN)
      end)
    end
  end
end

function TreatHeroLayer:showSlot(index)
  if index > game.role.treatSlot then
    return
  end
  local slot = self.slots[index]
  local data = self.treatData[tostring(index)]
  slot.heroNode:removeAllChildren()
  slot.deskNode:removeAllChildren()
  display.newSprite("ui/kitchen/quality/pan.png"):pos(0, 15):addTo(slot.deskNode)
  local timeBg = display.newSprite(treatRes .. "time_bg.png"):pos(0, -47):addTo(slot.deskNode)
  if not data then
    local man = UIHelper.newImageView("ui/global/blackman.png"):anch(0.5, 0):pos(0, 10):addTo(slot.deskNode):name("treatMan" .. index)
    display.newSprite("ui/global/jianying.png"):center(man):addTo(man):opacity(0):runAction(cc.RepeatForever:create(transition.sequence({
      cc.FadeIn:create(1),
      cc.FadeOut:create(1)
    })))
    man:setCallback(function()
      local needTreat = false
      for _, hero in pairs(game.role.heros) do
        if hero.hpPercent < 1000 and not hero:bOnTreat() then
          needTreat = true
          break
        end
      end
      if not needTreat then
        SysError(SYS_ERR_TREAT_NO_HERO_NEEDED)
        return
      end
      self:chooseHero(index)
    end)
  else
    local hero = game.role.heros[data.id]
    UIHelper.createSpineNode(hero:getDressType()):anch(0.5, 0):pos(0, 0):addTo(slot.deskNode):name("spine")
    local mask = UIHelper.newImageView(treatRes .. "mask.png"):anch(0.5, 0):pos(0, -20):addTo(slot.deskNode):name("mask")
    local curTime = display.newTTFLabel({
      text = "00:00:00",
      size = 18,
      color = UIHelper.hex2rgb("#0f7d03")
    }):pos(75, 18):addTo(timeBg)
    local card = HeroBigCard.new({
      heroId = hero.id,
      showPic = true,
      quality = hero.quality
    }):scale(0.83):addTo(slot.heroNode):name("card")
    card:setColor(cc.c3b(140, 140, 140))
    if data.time < game:nowTime() then
      self.needShow[tostring(index)] = false
      self:sendFinish(index, false)
    else
      local function setTime()
        local leftTime = data.time - game:nowTime()
        
        if 0 <= leftTime then
          curTime:setString(UIHelper.getTimeStr(leftTime))
          curTime:runAction(transition.sequence({
            cc.DelayTime:create(1),
            cc.CallFunc:create(function()
              setTime()
            end)
          }))
        else
          curTime:setString("00:00:00")
          self.needShow[tostring(index)] = false
          self:sendFinish(index, false)
        end
      end
      
      setTime()
      mask:setCallback(function()
        self:maskHandler(mask, index, curTime)
      end)
    end
  end
end

function TreatHeroLayer:chooseHero(index)
  local function rule(hero)
    local state = hero:getState()
    
    return not (hero.hpPercent < 1000) or not self:checkHeroInTreat(hero.id)
  end
  
  self:hide()
  local layer = game:createView("hero.ChooseHeroLayer", {
    rule = rule,
    multiChoose = true,
    cure = "cure",
    callback = function(choose)
      if not next(choose) then
        return
      end
      game:createView("treat.TreatCostLayer", {
        heroIds = choose,
        callback = function(quick)
          TopBar:show(TopBarType.full, "治疗")
          game:sendData(actionCodes.Hero_treatRpc, MsgPack.pack({ids = choose, needQuick = quick}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Hero_treatRpc, function(event)
            UIHelper.removeWaiting()
            game:playMusic(1100)
            self.treatData = json.decode(game.role.treatJson or "[]")
            local result = MsgPack.unpack(event.data)
            local count = 1
            for slot, data in pairs(result) do
              if quick then
                game.role:dispatchEvent({
                  name = "hero_cure",
                  heroId = data.heroId
                })
              elseif not data.big then
                game.role:dispatchEvent({
                  name = "hero_cure",
                  heroId = data.heroId
                })
              end
              if tolua.isnull(self) then
                return
              end
              self:showTreatEffect(slot, data.heroId, quick or not data.big, 1 < count)
              count = count + 1
            end
          end)
        end
      })
    end
  })
  BackManager:push(function()
    layer:close()
    self:show()
  end)
end

function TreatHeroLayer:showTreatEffect(index, heroId, quick, skipCV)
  local hero = game.role.heros[heroId]
  if not skipCV then
    CommonHelper.playCV(hero.type, "repair")
  end
  if game.role.majorGuideStep == 12 then
    self.guideMask = UIHelper.newMask({
      size = cc.size(display.width, display.height),
      opacity = 0
    })
    self.guideMask:addTo(display.getRunningScene()):zorder(POPUP_LAYER_ORDER)
    if UIHelper.isiPhoneX() then
      UIHelper.fitForiPhoneX(self.guideMask, true)
    end
    self.guideMask:setTouchEnabled(true)
  end
  local slot = self.slots[index]
  local heroSpine = UIHelper.createSpineNode(hero:getDressType()):anch(0.5, 0):pos(0, 0):addTo(slot.deskNode):name("spine")
  heroSpine:setAnimation(0, "failure", false)
  slot.deskNode:removeChildByName("treatMan" .. index)
  local card = HeroBigCard.new({
    heroId = hero.id,
    showPic = true,
    quality = hero.quality
  }):scale(0.83):addTo(slot.heroNode):name("card")
  card:setColor(cc.c3b(140, 140, 140))
  local mask = UIHelper.newImageView(treatRes .. "mask.png"):anch(0.5, 0):pos(0, 150):addTo(slot.deskNode):name("mask")
  mask:runAction(transition.sequence({
    cc.DelayTime:create(0.5),
    cc.MoveBy:create(0.5, cc.p(0, -170)),
    cc.CallFunc:create(function()
      if quick then
        self:showFinishEffect(index)
      else
        self:showData({slot = index})
      end
    end)
  }))
end

function TreatHeroLayer:showFinishEffect(index)
  local slot = self.slots[index]
  local spine = slot.deskNode:getChildByName("spine")
  spine:setToSetupPose()
  spine:setAnimation(1, "idle", true)
  local card = slot.heroNode:getChildByName("card")
  card:runAction(transition.sequence({
    cc.FadeOut:create(0.4),
    cc.RemoveSelf:create()
  }))
  local mask = slot.deskNode:getChildByName("mask")
  mask:setTouchEnabled(false)
  mask:runAction(transition.sequence({
    cc.CallFunc:create(function()
      local smoke = UIHelper.loadAnimation(treatRes, "cure", 24, 30)
      smoke.sprite:pos(0, 70):addTo(slot.deskNode)
      smoke.sprite:playAnimationOnce(smoke.animation, true)
    end),
    cc.MoveBy:create(1, cc.p(0, 190)),
    cc.CallFunc:create(function()
      spine:setToSetupPose()
      spine:setAnimation(1, "cheer", true)
    end),
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      spine:removeSelf()
      self:showData({slot = index})
    end)
  }))
  self.quickCount:setString(game.role.items[globalCsv.quickRepair] or 0)
  if not tolua.isnull(self.guideMask) then
    self.guideMask:removeSelf()
  end
  NewGuideLayer.new({
    step = 12,
    callback = function()
      game:enterScene("MainScene")
    end
  })
end

function TreatHeroLayer:showData(params)
  self.treatData = json.decode(game.role.treatJson or "[]")
  if params.slot then
    self:showSlot(params.slot)
  else
    for index = 1, 8 do
      self:showSlot(index)
    end
  end
end

function TreatHeroLayer:sendFinish(index, quick)
  if self.dialog and not tolua.isnull(self.dialog) and not quick then
    self.dialog:removeSelf()
    self.dialog = nil
  end
  if self.isShow then
    return
  end
  self.isShow = true
  local data = self.treatData[tostring(index)]
  local heroId = data.id
  game:sendData(actionCodes.Hero_finishTreatRpc, MsgPack.pack({slot = index, needQuick = quick}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Hero_finishTreatRpc, function(event)
    UIHelper.removeWaiting()
    if tolua.isnull(self) then
      return
    end
    self.isShow = false
    self:showFinishEffect(index)
    game.role:dispatchEvent({name = "hero_cure", heroId = heroId})
    self.needShow[tostring(index)] = nil
    local slot, res
    for key, temp in pairs(self.needShow) do
      slot = key
      res = temp
      break
    end
    if slot then
      self:sendFinish(tonumber(slot), res)
    end
  end)
end

function TreatHeroLayer:maskHandler(mask, index, timeLabel)
  mask:setTouchEnabled(false)
  mask:runAction(transition.sequence({
    cc.RotateBy:create(0.05, 10),
    cc.RotateBy:create(0.05, -20),
    cc.RotateBy:create(0.05, 10),
    cc.CallFunc:create(function()
      if self.dialog then
        return
      end
      self.dialog = MDialog:double({
        title = "快速治疗",
        text = "确定消耗 <img src='ui/global/icon_quick2.png' scale=0.5 />x1 立即完成治疗么？",
        okCallback = function()
          if (game.role.items[globalCsv.quickRepair] or 0) < 1 then
            UIHelper.showCookTip({
              type = 5,
              callback = function()
                self.quickCount:setString(game.role.items[globalCsv.quickRepair] or 0)
              end
            })
          else
            timeLabel:stopAllActions()
            timeLabel:setString("00:00:00")
            self.needShow[tostring(index)] = true
            self:sendFinish(index, true)
          end
          self.dialog = nil
          return true
        end,
        cancelCallback = function()
          self.dialog = nil
          return true
        end
      })
      mask:setTouchEnabled(true)
    end)
  }))
end

function TreatHeroLayer:checkHeroInTreat(heroId)
  for slot, data in pairs(self.treatData) do
    if data.id == heroId then
      return false
    end
  end
  return true
end

function TreatHeroLayer:onTouchBegan(sender)
  self.beginPos = sender:getTouchBeganPosition()
end

function TreatHeroLayer:onTouchMoved(sender)
  local pos = sender:getTouchMovePosition()
  self:setListPosition(pos)
end

function TreatHeroLayer:onTouchEnded(sender)
  self.originX = self.list:getPositionX()
end

function TreatHeroLayer:onTouchCancelled(sender)
  self:onTouchEnded(sender)
end

function TreatHeroLayer:setListPosition(pos)
  self.btnLeft:show()
  self.btnRight:show()
  local tempX = self.beginPos.x - pos.x
  local endX = self.originX - tempX
  if 0 < endX then
    self.btnLeft:hide()
    endX = 0
  end
  if endX < -1136 then
    self.btnRight:hide()
    endX = -1136
  end
  self.list:setPositionX(endX)
end

return TreatHeroLayer
