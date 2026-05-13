local uiGuideDataSet = require("csvdata.ui_guide")
local guidePassConditions = import(".GuidePassConditions")
local GlobalRes = "ui/global/"
local NewGuideLayer = class("NewGuideLayer")
MAX_MAJOR_STEP = 16

function NewGuideLayer:ctor(params)
  if SKIP_GUIDE then
    return
  end
  params = params or {}
  self.majorGuideStep = params.majorGuideStep or game.role.majorGuideStep
  self.minorGuideStep = params.minorGuideStep or game.role.minorGuideStep
  self.callback = params.callback
  if params.step < 10000 and params.step ~= self.majorGuideStep then
    return
  end
  local savedData = game.role.activeGuide[tostring(params.step)]
  if savedData and tonumber(savedData) > 0 then
    return
  end
  self:showView(params)
end

function NewGuideLayer:showView(params)
  params = params or {}
  local guideData = self:getCurrentGuideData()
  if not guideData then
    return
  end
  local rootMask = display.getRunningScene():getChildByTag(NEW_GUIDE_LAYER_TAG)
  if rootMask and not tolua.isnull(rootMask) then
    rootMask:removeAllChildren()
    self.maskLayer = rootMask
  else
    local width = display.width
    if UIHelper.isiPhoneX() then
      width = width + UIHelper.getMoveXForX() * 2
    end
    self.maskLayer = UIHelper.newMask({
      size = cc.size(width, display.height)
    })
    self.maskLayer:addTo(display.getRunningScene(), NEW_GUIDE_LAYER_ORDER, NEW_GUIDE_LAYER_TAG)
  end
  self.maskLayer.guideStep = self.majorGuideStep
  self.maskLayer:setTouchEnabled(true)
  self.maskLayer:setSwallowTouches(true)
  if guideData.validFunc > 0 and guidePassConditions[guideData.validFunc]() then
    if 0 < guideData.jumpToMinor then
      self.minorGuideStep = guideData.jumpToMinor
    else
      self.minorGuideStep = self.minorGuideStep + 1
    end
    self:nextStep()
    return
  end
  local delay = 0 < guideData.delay and guideData.delay or 0.016666666666666666
  scheduler.performWithDelayGlobal(function()
    self:showUI(params)
  end, guideData.delay)
end

function NewGuideLayer:showUI(params)
  local guideData = self:getCurrentGuideData()
  local typeHandlers = {
    [1] = self.nodeClick,
    [2] = self.showTalk,
    [3] = self.layerClick,
    [4] = self.showTips
  }
  typeHandlers[guideData.type](self, params)
end

function NewGuideLayer:nodeClick()
  local guideData = self:getCurrentGuideData()
  self.maskLayer:setTouchEnabled(true)
  local guideBtn = self:getGuideBtn(guideData)
  if not guideBtn then
    self:remove()
    return
  end
  local size = guideBtn:getContentSize()
  local x, y = guideBtn:getPosition()
  local btnPos = guideBtn:getParent():convertToWorldSpace({x = x, y = y})
  local btnCenterPos = guideBtn:convertToWorldSpace({
    x = 0.5 * size.width,
    y = 0.5 * size.height
  })
  local touchNode = UIHelper.newMask({size = size})
  touchNode:anch(0.5, 0.5):pos(btnCenterPos.x, btnCenterPos.y):addTo(self.maskLayer)
  touchNode:setCallback(function(sender)
    sender:setTouchEnabled(false)
    self:afterClick(guideData)
    if guideBtn.callback then
      guideBtn.touchBegin = os.time()
      guideBtn.callback(guideBtn)
    end
  end)
  self:addTips()
  self:addFinger(btnCenterPos)
end

function NewGuideLayer:showTalk()
  local guideData = self:getCurrentGuideData()
  local type, text, showBg = TopBar:getShowType()
  local reward = true
  if self.majorGuideStep == 9 then
    reward = false
  end
  local view = game:createView("talk.PlotTalkLayer", {
    scene = self.maskLayer,
    talkId = guideData.talkId,
    csvNo = guideData.readcsv or 0,
    reward = reward,
    hideReview = true,
    onComplete = function()
      TopBar:show(type, text, showBg)
      self:afterClick(guideData)
    end
  })
  if UIHelper.isiPhoneX() then
    view:setPositionX(view:getPositionX() + UIHelper.getMoveXForX(true))
  end
end

function NewGuideLayer:layerClick(params)
  local guideData = self:getCurrentGuideData()
  local clickNode = self:getGuideBtn({
    buttonName = params.target or guideData.buttonName
  })
  local x, y = clickNode:getPosition()
  local btnPos = clickNode:getParent():convertToWorldSpace({x = x, y = y})
  local size = clickNode:getContentSize()
  local btnCenterPos = clickNode:convertToWorldSpace({
    x = 0.5 * size.width,
    y = 0.5 * size.height
  })
  
  local function func(sender, type)
    if type == ccui.TouchEventType.began then
      local pos = self.maskLayer:getTouchBeganPosition()
      local rect = clickNode:getCascadeBoundingBox()
      if cc.rectContainsPoint(rect, cc.p(pos.x, pos.y)) then
        self.maskLayer:setSwallowTouches(false)
        self:afterClick(guideData)
        return false
      end
      self.maskLayer:setSwallowTouches(true)
      return true
    else
      self.maskLayer:setSwallowTouches(true)
    end
  end
  
  self.maskLayer:setTouchEnabled(true)
  self.maskLayer:addTouchEventListener(func)
  self:addTips()
  self:addFinger(btnCenterPos)
end

function NewGuideLayer:showTips(params)
  local guideData = self:getCurrentGuideData()
  
  local function handler()
    self:afterClick(guideData)
  end
  
  local content = self:addTips()
  if guideData.buttonName ~= "" then
    local button = UIHelper.extend(ccui.Button:create())
    button:setImages("ui/global/", {
      "btn_common_a.png",
      "btn_common_b.png"
    })
    button:setString({
      text = guideData.buttonName
    })
    button:setCallback(handler)
    button:scale(0.8):addTo(content)
    if content then
      if guideData.guyFace == 0 then
        button:pos(300, 30)
      else
        button:pos(content:getContentSize().width - 300, 30)
      end
    else
      local xOffset, yOffset = string.match(guideData.guyOffset, "%s*([-]?%d+)=([-]?%d+)%s*")
      local cx = display.cx
      if UIHelper.isiPhoneX() then
        cx = cx + UIHelper.getMoveXForX()
      end
      button:pos(cx + xOffset, display.cy + yOffset):addTo(self.maskLayer)
    end
    local size = button:getContentSize()
    local btnCenterPos = button:convertToWorldSpace({
      x = 0.5 * size.width,
      y = 0.5 * size.height
    })
    self:addFinger(btnCenterPos, true)
  else
    self.maskLayer:setCallback(handler)
  end
end

function NewGuideLayer:getCurrentGuideData()
  local majorDatas = uiGuideDataSet[self.majorGuideStep] or {}
  return majorDatas[self.minorGuideStep] or nil
end

function NewGuideLayer:nextStep()
  local guideData = self:getCurrentGuideData()
  if guideData.validFunc > 0 and guidePassConditions[guideData.validFunc]() then
    if 0 < guideData.jumpToMinor then
      self.minorGuideStep = guideData.jumpToMinor
    else
      self.minorGuideStep = self.minorGuideStep + 1
    end
    self:nextStep()
    return
  end
  local layer = display.getRunningScene():getChildByTag(NEW_GUIDE_LAYER_TAG)
  if not layer then
    return
  end
  layer:setCallback(function()
    return true
  end)
  layer:setTouchEnabled(true)
  layer:removeAllChildren()
  self:showView()
end

function NewGuideLayer:afterClick(guideData)
  if guideData["break"] > 0 then
    self:exit()
  else
    if 0 < guideData.jumpToMinor and guideData.validFunc == 0 then
      self.minorGuideStep = guideData.jumpToMinor
    else
      self.minorGuideStep = self.minorGuideStep + 1
    end
    self:nextStep()
  end
end

function NewGuideLayer:getGuideBtn(params)
  local button = UIHelper.getChildControl(display.getRunningScene(), params.buttonName)
  if not button then
    print(string.format("button %s not exist", params.buttonName))
    return
  end
  return button
end

function NewGuideLayer:addFinger(btnCenterPos, hideHand)
  local guideData = self:getCurrentGuideData()
  local x, y = 0, 0
  if guideData.circleOffset ~= "" then
    x, y = guideData.circleOffset:match("%s*([-]?%d+)=([-]?%d+)%s*")
  end
  local circle = UIHelper.loadAnimation(GlobalRes, "guide_circle", 12, 12)
  circle.sprite:pos(tonumber(x) + btnCenterPos.x, tonumber(y) + btnCenterPos.y):addTo(self.maskLayer, 1000):playAnimationForever(circle.animation)
  if not hideHand then
    local x, y = 0, 0
    if guideData.fingerOffset ~= "" then
      x, y = guideData.fingerOffset:match("%s*([-]?%d+)=([-]?%d+)%s*")
    end
    local hand = UIHelper.loadAnimation(GlobalRes, "guide_hand", 2, 4)
    hand.sprite:anch(0, 1):rotate(guideData.fingerRotate):pos(tonumber(x) + btnCenterPos.x, tonumber(y) + btnCenterPos.y):addTo(self.maskLayer, 1000):playAnimationForever(hand.animation)
  end
end

function NewGuideLayer:addTips()
  local guideData = self:getCurrentGuideData()
  if guideData.tips == "" then
    return
  end
  local x, y = 0, 0
  if guideData.tipsOffset ~= "" then
    x, y = guideData.tipsOffset:match("%s*([-]?%d+)=([-]?%d+)%s*")
  end
  local x = tonumber(x)
  if UIHelper.isiPhoneX() then
    x = x + UIHelper.getMoveXForX()
  end
  local txtBg = display.newSprite(GlobalRes .. "guide_txt.png"):pos(tonumber(x), tonumber(y)):addTo(self.maskLayer)
  MRichText.new({
    text = guideData.tips,
    size = 20,
    color = UIHelper.hex2rgb("#3e1700"),
    maxWidth = 160
  }):anch(0.5, 0.5):pos(85, 30):addTo(txtBg)
  local angle = display.newSprite(GlobalRes .. "guide_angle.png"):anch(0.5, 1):addTo(txtBg)
  if guideData.tipsFace == 0 then
    angle:pos(40, 3)
  else
    angle:flipX(true)
    angle:pos(140, 3)
  end
  return txtBg
end

function NewGuideLayer:exit()
  local guideData = self:getCurrentGuideData()
  
  local function saveGuideData(bFinish)
    if guideData.major > 10000 then
      game.role:saveGuideData({
        master = self.majorGuideStep,
        slave = self.minorGuideStep,
        finish = bFinish and 1 or 0,
        skip = 0
      })
      if 0 < guideData.keyStep then
        game.role.activeGuide[tostring(guideData.major)] = 1
      end
    else
      game.role.majorGuideStep = self.majorGuideStep
      game.role.minorGuideStep = self.minorGuideStep
      game.role:saveGuideData(nil, bFinish)
    end
  end
  
  saveGuideData(true)
  if guideData.major < 10000 then
    if guideData.jumpToMinor > 0 and guideData.validFunc == 0 then
      self.minorGuideStep = guideData.jumpToMinor
    else
      self.minorGuideStep = self.minorGuideStep + 1
    end
    local nextGuideData = self:getCurrentGuideData()
    if not nextGuideData then
      self.majorGuideStep = self.majorGuideStep + 1
      self.minorGuideStep = 1
      local newGuideData = self:getCurrentGuideData()
      if not newGuideData then
        self.majorGuideStep = 9999
        self.minorGuideStep = 1
      end
    end
    saveGuideData()
  end
  self:remove()
end

function NewGuideLayer:remove()
  display.getRunningScene():removeChildByTag(NEW_GUIDE_LAYER_TAG)
  if self.callback then
    self.callback()
  end
end

return NewGuideLayer
