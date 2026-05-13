local UnitCsv = require("csvdata.unit")
local ItemCsv = require("csvdata.item")
local StoryCsv = require("csvdata.story")
local Story2Csv = require("csvdata.story2")
local BackGroundCsv = require("csvdata.background")
local GlobalRes = "ui/global/"
local PlotRes = "ui/talk/plot/"
local uiData = {
  csbFile = "ui/talk/PlotTalkLayer.csb",
  mask = true,
  widgets = {
    touchLayer = "touchLayer",
    angle1 = "angle1",
    angle2 = "angle2",
    line = "line",
    bgNode = "bgNode",
    heroNode = "heroNode",
    dialogBg = "dialogBg",
    nameLabel = "dialogBg/nameLabel",
    txtNode = "dialogBg/txtNode",
    reviewBtn = "dialogBg/reviewBtn",
    nextBtn = "dialogBg/nextBtn",
    cgNode = "cgNode",
    autoBtn = "autoBtn",
    skipBtn = "skipBtn",
    fastBtn = "fastBtn"
  }
}
local animations = {
  [0] = "moren",
  [1] = "jing",
  [2] = "nu",
  [3] = "xi",
  [4] = "xiu",
  [5] = "ai",
  [6] = "dapo",
  [7] = "renzhen",
  [8] = "baozou",
  [9] = "yinxian",
  [10] = "xiaoxi",
  [11] = "weizhi",
  [12] = "teshu"
}
local DefalutOffset = -50
local PlotTalkLayer = class("PlotTalkLayer", UIBase)

function PlotTalkLayer:ctor(params)
  if params.reward then
    uiData.opacity = 0
  end
  UIBase.ctor(self, uiData, params)
end

function PlotTalkLayer:init(params)
  local changeX = 0
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.bgNode)
    UIHelper.fitForiPhoneX(self.line, true)
    changeX = UIHelper.getMoveXForX()
    self.autoBtn:setPositionX(self.autoBtn:getPositionX() + UIHelper.getMoveXForX())
    self.skipBtn:setPositionX(self.skipBtn:getPositionX() + UIHelper.getMoveXForX())
  end
  if not tolua.isnull(TopBar) then
    local type, text, showBg = TopBar:getShowType()
    self.topbar = {
      type = type,
      text = text,
      showBg = showBg
    }
    TopBar:hide()
  end
  self.onComplete = params.onComplete
  self.onMaskShow = params.onMaskShow
  self.showSpeed = params.showSpeed
  self.reportSkip = params.reportSkip
  if params.csvNo and params.csvNo == 1 then
    self.talkData = Story2Csv[params.talkId]
  else
    self.talkData = StoryCsv[params.talkId]
  end
  self.step = 1
  self.actors = {}
  self.items = {}
  self.auto = false
  self.speedup = false
  self.reward = params.reward
  self.quick = params.quick
  self.hideReview = params.hideReview
  if params.music then
    game:playMusic(params.music)
  end
  local time = self.quick and 1 or 16
  self.angle1:setPositionX(0 - changeX)
  self.angle2:setPositionX(display.width + changeX)
  self.line:setPositionY(0)
  self.angle1:moveBy(time / 30, 292, 0)
  self.angle2:moveBy(time / 30, -292, 0)
  self.line:runAction(transition.sequence({
    cc.DelayTime:create(time / 30),
    cc.MoveBy:create(time / 30, cc.p(0, 44))
  }))
  self.dialogBg:hide()
  self.reviewBtn:setTouchScale()
  self.nextBtn:runAction(cc.RepeatForever:create(transition.sequence({
    cc.MoveBy:create(0.3, cc.p(0, 10)),
    cc.MoveBy:create(0.3, cc.p(0, -10))
  })))
  self.nextBtn:hide()
  self.touchLayer:setCallback(function()
    if not self.dialogBg:isVisible() then
      return
    end
    if self.richContent and not tolua.isnull(self.richContent) and self.richContent:isAnimationPlaying() then
      self.richContent:stopAnimation()
      self.nextBtn:show()
    elseif self.waitNextMove then
      self:nextStep()
    end
  end)
  self.skipBtn:setCallback(function()
    if self.reportSkip then
      game:sendData(actionCodes.Role_skipTalkStory, MsgPack.pack({
        talkId = params.talkId,
        step = self.step
      }))
    end
    self:complete()
  end)
  if params.hideSkip then
    self.skipBtn:hide()
  end
  self.autoBtn:setCallback(function()
    self.auto = not self.auto
    if self.auto and self.waitNextMove then
      self:nextStep()
    end
    self.autoBtn:setImage(PlotRes .. (self.auto and "auto_b.png" or "auto_a.png"))
  end)
  self.reviewBtn:setCallback(function()
    local auto = self.auto
    self.reviewLayer = game:createView("talk.TalkReviewLayer", {
      scene = self,
      talkId = params.talkId,
      step = self.step,
      csvNo = params.csvNo
    })
    if self.auto then
      self.auto = false
    end
    BackManager:push(function()
      self.reviewLayer:close()
      self.reviewLayer = nil
      self.auto = auto
      if self.auto and self.waitNextMove then
        self:nextStep()
      end
    end)
  end)
  self.fastBtn:setCallback(function()
    self.speedup = not self.speedup
    self.fastBtn:setState(self.speedup and 2 or 1)
  end)
  if self.reward then
    self.skipBtn:hide()
    self.fastBtn:hide()
    self.autoBtn:hide()
    self.reviewBtn:hide()
  else
    self:showMask(false)
  end
  if self.hideReview then
    self.reviewBtn:hide()
  end
end

function PlotTalkLayer:showData()
  local data = self.talkData[self.step]
  local content = data.content:toArray("=")
  self:excute(data, content)
end

function PlotTalkLayer:excute(data, content)
  if data.type == 1 then
    self["heroHandler" .. content[1]](self, data, content)
  elseif data.type == 2 then
    self["talkHandler" .. content[1]](self, data, content)
  elseif data.type == 3 then
    self["itemHandler" .. content[1]](self, data, content)
  end
  if data.shake > 0 then
    UIHelper.shake(self, {
      count = data.shake
    })
  end
  if 0 < data.background then
    self:setBackGround(data.background)
  end
  if data.bgColor ~= "" then
    if self.colorBg then
      self.colorBg:removeSelf()
    end
    local color = UIHelper.hex2rgba(data.bgColor)
    self.colorBg = UIHelper.newMask({
      size = cc.size(display.width, display.height),
      color = data.bgColor,
      opacity = color.a
    })
    self.colorBg:anch(0.5, 0.5):addTo(self.bgNode, 10)
    if UIHelper.isiPhoneX() then
      UIHelper.fitForiPhoneX(self.colorBg)
    end
  end
  if 0 < data.music then
    game:playMusic(data.music)
  end
  if 0 < data.sound then
    if self.soundHandler then
      game:stopMusic(self.soundHandler)
    end
    self.soundHandler = game:playMusic(data.sound)
  end
end

function PlotTalkLayer:talkHandler1(data, content)
  local id = tonumber(content[2])
  local text = content[3]
  local actor = self.actors[id]
  local unitData = UnitCsv[actor.type]
  self.nameLabel:setString(unitData.name)
  self.waitNextMove = true
  self.txtNode:removeAllChildren()
  self.txtNode:show()
  self.nameLabel:show()
  self.richContent = MRichText.new({
    text = string.gsub(text, "%[name%]", string.format("<div color=#77eb6e>%s</div>", game.role and game.role.name or "")),
    color = UIHelper.hex2rgb("#622c23"),
    size = 22,
    maxWidth = 650
  })
  self.richContent:addTo(self.txtNode)
  if not self.reward then
    self.reviewBtn:show()
  end
  if not self.speedup and not self.quick then
    self.richContent:show()
    self.richContent:playAnimation(nil, nil, function()
      if self.auto then
        self:nextStep(data.delay + 2)
      else
        self.nextBtn:show()
      end
    end)
  else
    self.richContent:show()
    if self.auto then
      self:nextStep(data.delay)
    else
      self.nextBtn:show()
    end
  end
  self:chooseActor(id)
end

function PlotTalkLayer:talkHandler2(data, content)
  local type = tonumber(content[2])
  local time = self.quick and 0.1 or 0.5
  local actions = {}
  if type == 1 then
    self.dialogBg:show()
    self.dialogBg:opacity(0)
    actions[#actions + 1] = cc.DelayTime:create(time * 2)
    actions[#actions + 1] = cc.FadeIn:create(time)
  else
    actions[#actions + 1] = cc.FadeOut:create(time)
  end
  actions[#actions + 1] = cc.CallFunc:create(function()
    self.txtNode:hide()
    self.nameLabel:hide()
    self:nextStep(data.delay)
  end)
  self.reviewBtn:hide()
  self.nextBtn:hide()
  self.dialogBg:runAction(transition.sequence(actions))
end

function PlotTalkLayer:heroHandler1(data, content)
  local id = tonumber(content[2])
  local type = tonumber(content[3])
  local xPos = tonumber(content[4])
  local zorder = tonumber(content[5])
  local showType = tonumber(content[6])
  local direction = tonumber(content[7])
  local scale = data.scale > 0 and data.scale or 1
  local spine = UIHelper.createHeroCard(type, {scale = scale})
  spine:pos(xPos, DefalutOffset + data.offset):addTo(self.heroNode, zorder)
  spine:setAnimation(0, animations[0], false)
  spine:setCascadeOpacityEnabled(true)
  if 0 < direction then
    spine:setScaleX(spine:getScaleX() * -1)
  end
  if UIHelper.isiPhoneX() and type == 29999 then
    UIHelper.fitForiPhoneX(spine, true)
  end
  self.actors[id] = {type = type, spine = spine}
  self:chooseActor(id)
  if showType == 1 then
    self:nextStep(data.delay)
  elseif showType == 2 then
    spine:opacity(0)
    spine:runAction(transition.sequence({
      cc.FadeIn:create(self.quick and 0.1 or 0.5),
      cc.CallFunc:create(function()
        self:nextStep(data.delay)
      end)
    }))
  end
end

function PlotTalkLayer:heroHandler2(data, content)
  local id = tonumber(content[2])
  local animate = tonumber(content[3])
  local actor = self.actors[id]
  actor.spine:setToSetupPose()
  actor.spine:setAnimation(0, animations[animate], false)
  self:chooseActor(id)
  self:nextStep(data.delay)
end

function PlotTalkLayer:heroHandler3(data, content)
  local id = tonumber(content[2])
  local disposeType = tonumber(content[3])
  local actor = self.actors[id]
  self.actors[id] = nil
  if disposeType == 1 then
    actor.spine:removeSelf()
    self:nextStep(data.delay)
  elseif disposeType == 2 then
    actor.spine:runAction(transition.sequence({
      cc.FadeOut:create(0.5),
      cc.CallFunc:create(function()
        actor.spine:removeSelf()
        self:nextStep(data.delay)
      end)
    }))
  end
end

function PlotTalkLayer:heroHandler4(data, content)
  local id = tonumber(content[2])
  local direct = tonumber(content[3])
  local actor = self.actors[id]
  local params = {
    count = 10,
    x = direct == 1 and 0 or 5,
    y = direct == 1 and 5 or 0,
    callback = handler(self, self.nextStep)
  }
  UIHelper.shake(actor.spine, params)
end

function PlotTalkLayer:heroHandler5(data, content)
  local id = tonumber(content[2])
  local type = tonumber(content[3])
  local actor = self.actors[id]
  if type == 1 then
    actor.highLight = true
    actor.spine:setColor(cc.c3b(255, 255, 255))
  else
    actor.highLight = nil
    actor.spine:setColor(cc.c3b(140, 140, 140))
  end
  self:nextStep()
end

function PlotTalkLayer:heroHandler6(data, content)
  local id = tonumber(content[2])
  local type = tonumber(content[3])
  local xPos = tonumber(content[4])
  local zorder = tonumber(content[5])
  local showType = tonumber(content[6])
  local direction = tonumber(content[7])
  local animation = tonumber(content[8])
  local scale = data.scale > 0 and data.scale or 1
  local spine = UIHelper.createHeroCard(type, {scale = scale})
  spine:pos(xPos, DefalutOffset + data.offset):addTo(self.heroNode, zorder)
  spine:setAnimation(0, animations[animation], false)
  spine:setCascadeOpacityEnabled(true)
  if 0 < direction then
    spine:setScaleX(spine:getScaleX() * -1)
  end
  self.actors[id] = {type = type, spine = spine}
  self:chooseActor(id)
  if showType == 1 then
    self:nextStep(data.delay)
  elseif showType == 2 then
    spine:opacity(0)
    spine:setCascadeOpacityEnabled(true)
    spine:runAction(transition.sequence({
      cc.FadeIn:create(0.5),
      cc.CallFunc:create(function()
        self:nextStep(data.delay)
      end)
    }))
  end
end

function PlotTalkLayer:heroHandler7(data, content)
  local id = tonumber(content[2])
  local type = tonumber(content[3])
  local xPos = tonumber(content[4])
  local zorder = tonumber(content[5])
  local showType = tonumber(content[6])
  local direction = tonumber(content[7])
  local animation = tonumber(content[8])
  local scale = data.scale > 0 and data.scale or 1
  local spine = UIHelper.createHeroCard(type, {scale = scale})
  spine:pos(xPos, DefalutOffset + data.offset):addTo(self.heroNode, zorder)
  spine:setAnimation(0, animations[animation], true)
  spine:setCascadeOpacityEnabled(true)
  if 0 < direction then
    spine:setScaleX(spine:getScaleX() * -1)
  end
  self.actors[id] = {type = type, spine = spine}
  self:chooseActor(id)
  if showType == 1 then
    self:nextStep(data.delay)
  elseif showType == 2 then
    spine:opacity(0)
    spine:runAction(transition.sequence({
      cc.FadeIn:create(0.5),
      cc.CallFunc:create(function()
        self:nextStep(data.delay)
      end)
    }))
  end
end

function PlotTalkLayer:heroHandler8(data, content)
  local id = tonumber(content[2])
  local offset = tonumber(content[3])
  local speed = tonumber(content[4])
  local scale = tonumber(content[5])
  local actor = self.actors[id]
  actor.spine:runAction(transition.sequence({
    cc.MoveBy:create(math.abs(offset / speed), cc.p(offset, 0)),
    cc.CallFunc:create(function()
      if scale == 1 then
        actor.spine:setScaleX(actor.spine:getScaleX() * -1)
      end
      self:nextStep(data.delay)
    end)
  }))
end

function PlotTalkLayer:heroHandler9(data, content)
  local id = tonumber(content[2])
  local offset = tonumber(content[3])
  local speed = tonumber(content[4])
  local scale = tonumber(content[5])
  local actor = self.actors[id]
  actor.spine:runAction(transition.sequence({
    cc.MoveBy:create(math.abs(offset / speed), cc.p(0, offset)),
    cc.CallFunc:create(function()
      if scale == 1 then
        actor.spine:setScaleX(actor.spine:getScaleX() * -1)
      end
      self:nextStep(data.delay)
    end)
  }))
end

function PlotTalkLayer:itemHandler1(data, content)
  local id = tonumber(content[2])
  local type = tonumber(content[3])
  local xPos = tonumber(content[4])
  local showType = tonumber(content[5])
  local item = ItemCsv[type]
  local icon
  if item.type == ItemType.Hero then
    icon = UIHelper.getClipNode({
      steRes = GlobalRes .. "mask_1.png",
      clipRes = item.icon
    }):scale(0.7)
  else
    icon = display.newSprite(item.icon)
  end
  icon:pos(xPos, data.offset):addTo(self)
  local size = icon:getContentSize()
  if size.width >= display.width and size.height >= display.height and UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(icon)
  end
  self.items[id] = icon
  if showType == 1 then
    self:nextStep(data.delay)
  elseif showType == 2 then
    icon:opacity(0)
    icon:runAction(transition.sequence({
      cc.FadeIn:create(0.5),
      cc.CallFunc:create(function()
        self:nextStep(data.delay)
      end)
    }))
  end
end

function PlotTalkLayer:itemHandler2(data, content)
  local id = tonumber(content[2])
  local disposeType = tonumber(content[3])
  local item = self.items[id]
  self.items[id] = nil
  if disposeType == 1 then
    item:removeSelf()
    self:nextStep(data.delay)
  elseif disposeType == 2 then
    item:runAction(transition.sequence({
      cc.FadeOut:create(0.5),
      cc.CallFunc:create(function()
        item:removeSelf()
        self:nextStep(data.delay)
      end)
    }))
  end
end

function PlotTalkLayer:itemHandler3(data, content)
  local id = tonumber(content[2])
  local name = content[3]
  local xPos = tonumber(content[4])
  local showType = tonumber(content[5])
  display.addSpriteFrames("storyEff/" .. name .. ".plist", "storyEff/" .. name .. ".png")
  local frames = {}
  for _, name in ipairs(UIHelper.loadPlistFrames("storyEff/" .. name .. ".plist")) do
    frames[#frames + 1] = display.newSpriteFrame(name)
  end
  local sprite = display.newSprite(frames[1])
  local animation = display.newAnimation(frames, 0.03333333333333333)
  sprite:pos(xPos, data.offset):addTo(self)
  sprite:setCascadeOpacityEnabled(true)
  sprite:playAnimationOnce(animation, true, function()
    self:nextStep(data.delay)
  end)
  if showType == 2 then
    sprite:opacity(0)
    sprite:fadeIn(0.5)
  end
end

function PlotTalkLayer:itemHandler4(data, content)
  local id = tonumber(content[2])
  local name = content[3]
  local xPos = tonumber(content[4])
  local showType = tonumber(content[5])
  local sprite = display.newSprite("cg/" .. name)
  sprite:pos(xPos, data.offset):addTo(self.cgNode)
  local size = sprite:getContentSize()
  if size.width >= display.width and size.height >= display.height and UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(sprite)
  end
  self.items[id] = sprite
  if showType == 1 then
    self:nextStep(data.delay)
  elseif showType == 2 then
    sprite:opacity(0)
    sprite:runAction(transition.sequence({
      cc.FadeIn:create(0.5),
      cc.CallFunc:create(function()
        self:nextStep(data.delay)
      end)
    }))
  end
end

function PlotTalkLayer:chooseActor(id)
  for actorId, actor in pairs(self.actors) do
    if actorId == id or actor.highLight then
      actor.spine:setColor(cc.c3b(255, 255, 255))
    else
      actor.spine:setColor(cc.c3b(140, 140, 140))
    end
  end
end

function PlotTalkLayer:setBackGround(id)
  local data = BackGroundCsv[id]
  if not self.background then
    self.background = display.newSprite(data.res):addTo(self.bgNode)
  else
    self.background:runAction(transition.sequence({
      cc.MoveBy:create(0.5, cc.p(-display.width, 0)),
      cc.RemoveSelf:create()
    }))
    local bg = display.newSprite(data.res):pos(display.width, 0):addTo(self.bgNode)
    bg:runAction(cc.MoveBy:create(0.5, cc.p(-display.width, 0)))
    self.background = bg
  end
end

function PlotTalkLayer:nextStep(delay)
  self.waitNextMove = false
  if self.richContent and not tolua.isnull(self.richContent) and self.richContent:isAnimationPlaying() then
    self.richContent:stopAnimation()
  end
  self.nextBtn:hide()
  self.step = self.step + 1
  if self.step > #self.talkData then
    self:complete()
    return
  end
  delay = delay or 0
  if 0 < delay then
    self:runAction(transition.sequence({
      cc.DelayTime:create(delay),
      cc.CallFunc:create(function()
        self:showData()
      end)
    }))
  else
    self:showData()
  end
end

function PlotTalkLayer:complete()
  if self.soundHandler then
    game:stopMusic(self.soundHandler)
  end
  if self.onMaskShow then
    self.onMaskShow()
  end
  self:showMask(true, function()
    if self.topbar then
      TopBar:show(self.topbar.type, self.topbar.text, self.topbar.showBg)
    end
    if self.reviewLayer and not tolua.isnull(self.reviewLayer) then
      BackManager:pop()
    end
    if self.onComplete then
      self.onComplete()
    end
    if not tolua.isnull(self) then
      self:close()
    end
  end)
end

function PlotTalkLayer:showMask(fadeIn, callback)
  local mask = UIHelper.extend(ccui.Layout:create())
  mask:size(display.width, display.height):anch(0.5, 0.5):pos(display.cx, display.cy):addTo(self)
  mask:setBackGroundColor(cc.c3b(0, 0, 0))
  mask:setBackGroundColorType(1)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(mask)
  end
  if fadeIn then
    mask:opacity(0)
  end
  local actions = {}
  if fadeIn then
    table.insert(actions, cc.FadeIn:create(0.5))
  else
    table.insert(actions, cc.FadeOut:create(0.5))
  end
  table.insert(actions, cc.RemoveSelf:create())
  table.insert(actions, cc.CallFunc:create(function()
    if callback then
      callback()
    end
  end))
  mask:runAction(cc.Sequence:create(actions))
end

return PlotTalkLayer
