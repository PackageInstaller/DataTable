local UIView = class("UIView")
local maskTag = 10000

function UIView:ctor(uiData, controller)
  self.uiData = uiData
  self.controller = controller
  self.initialized = false
  self.layer = UIHelper.extend(ccui.Layout:create())
  self:loadUIByData()
  self.layer:onNodeEvent("exit", function()
    if self.controller then
      self.controller:onExit()
    end
  end)
  self.layer:onNodeEvent("enter", function()
    self:onEnter()
  end)
  self:addMask()
end

function UIView:loadUIByData()
  self:initLayout(self.uiData.csbFile)
  self:initDataWidgets(self.uiData.widgets)
end

function UIView:addMask()
  if not self.uiData.mask then
    return
  end
  self.layer:size(display.width, display.height)
  self.layer:setBackGroundColorType(1)
  self.layer:setBackGroundColor(cc.c3b(0, 0, 0))
  self.layer:setTouchEnabled(true)
  self.layer:setSwallowTouches(true)
  self.layer:setBackGroundColorOpacity(self.uiData.opacity or 191)
  self.layer:setCallback(function()
    local click = self.uiData.maskClick or false
    if not click then
      return true
    end
    local pos = self.layer:getTouchEndPosition()
    local containTouch = false
    local children = self.root_panel:getChildren()
    for _, child in ipairs(children) do
      if child:getTag() ~= maskTag and child:isVisible() then
        local rect = child:getBoundingBox()
        if cc.rectContainsPoint(rect, cc.p(pos.x, pos.y)) then
          containTouch = true
        end
      end
    end
    if containTouch then
      return true
    end
    if type(click) == "function" then
      click()
    else
      self:close()
    end
  end, true)
end

function UIView:initLayout(csbFile)
  local panel = CcsHelper.loadCCSFile(csbFile)
  CcsHelper.initPanelLayout(panel)
  self.layer:addChild(panel)
  self.root_panel = panel
  local layerType = {
    "down",
    "up",
    "left",
    "right",
    "center",
    "left_down",
    "right_down",
    "left_up",
    "right_up"
  }
  for _, name in ipairs(layerType) do
    self[name] = panel:getChildByName(name)
  end
  local actionType = {
    "downAction",
    "upAction",
    "leftAction",
    "rightAction",
    "popAction"
  }
  for _, actionName in ipairs(actionType) do
    local action = panel:getChildByName(actionName)
    if not action then
      for index, name in ipairs(layerType) do
        if self[name] then
          action = self[name]:getChildByName(actionName)
          if action then
            break
          end
        end
      end
    end
    self[actionName] = action
  end
end

function UIView:initDataWidgets(widgets)
  for name, path in pairs(widgets) do
    local widget = UIHelper.getChildControl(self.root_panel, path)
    if widget then
      UIHelper.extend(widget)
      self.controller[name] = widget
    else
      printError("UIView:initDataWidgets, not eixst node %s = %s", name, path)
    end
  end
  self.controller.__layer = self.layer
  self.controller.__root_panel = self.root_panel
  self.controller.__right_down = self.right_down
  self.controller.__left_up = self.left_up
  self.controller.__right_up = self.right_up
  self.controller.__left_down = self.left_down
  self.controller.__right = self.right
  self.controller.__left = self.left
  self.controller.__up = self.up
  self.controller.__down = self.down
  self.controller.__center = self.center
end

function UIView:show(scene, ...)
  if self.initialized then
    if self.controller.showData then
      self.controller:showData(...)
    end
    self.layer:show()
    return
  end
  local order = self.uiData.order or 0
  local tag = self.uiData.tag or 0
  order = self.uiData.popup and POPUP_LAYER_ORDER or order
  if self.controller.__init then
    self.controller:__init(...)
    self.initialized = true
  end
  if self.controller.showData then
    self.controller:showData(...)
  end
  if not scene then
    if not display.getRunningScene():getChildByTag(tag) or tag == 0 then
      display.getRunningScene():addChild(self.layer, order, tag)
    end
  elseif not scene:getChildByTag(tag) or tag == 0 then
    scene:addChild(self.layer, order, tag)
  end
end

function UIView:onEnter()
  if self.downAction then
    local x, y = self.downAction:getPosition()
    self.downAction:pos(x, y + self.downAction:getContentSize().height)
    self.downAction:runAction(cc.EaseElasticOut:create(cc.MoveTo:create(0.6, cc.p(x, y))))
  end
  if self.upAction then
    local x, y = self.upAction:getPosition()
    self.upAction:pos(x, y - self.upAction:getContentSize().height)
    self.upAction:runAction(cc.EaseElasticOut:create(cc.MoveTo:create(0.6, cc.p(x, y))))
  end
  if self.leftAction then
    local x, y = self.leftAction:getPosition()
    self.leftAction:pos(x + self.leftAction:getContentSize().width, y)
    self.leftAction:runAction(cc.EaseElasticOut:create(cc.MoveTo:create(0.6, cc.p(x, y))))
  end
  if self.rightAction then
    local x, y = self.rightAction:getPosition()
    self.rightAction:pos(x - self.rightAction:getContentSize().width, y)
    self.rightAction:runAction(cc.EaseElasticOut:create(cc.MoveTo:create(0.6, cc.p(x, y))))
  end
  if self.popAction then
    local scale = self.popAction:getScale()
    self.popAction:scale(scale * 0.4)
    self.popAction:runAction(cc.EaseElasticOut:create(cc.ScaleTo:create(0.6, scale)))
  end
end

function UIView:hide()
  self.layer:hide()
end

function UIView:close()
  if self.layer and not tolua.isnull(self.layer) then
    self.layer:removeSelf()
  end
  self.initialized = false
end

return UIView
