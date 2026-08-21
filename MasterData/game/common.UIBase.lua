local UIBase = class("UIBase", function()
  return UIHelper.extend(ccui.Layout:create())
end)
local maskTag = 10000

function UIBase:ctor(uiData, params)
  params = params or {}
  self.uiData = uiData
  self:onNodeEvent("enter", handler(self, self.__enter))
  self:__loadUIByData()
  self:__addMask()
  self:__show(params)
end

function UIBase:__loadUIByData()
  self:__initLayout(self.uiData.csbFile)
  self:__initDataWidgets(self.uiData.widgets)
end

function UIBase:__initLayout(csbFile)
  local panel = CcsHelper.loadCCSFile(csbFile)
  CcsHelper.initPanelLayout(panel)
  self:addChild(panel)
  self.root_panel = panel
  self.__layer = self
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
    self["__" .. name] = panel:getChildByName(name)
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
        if self["__" .. name] then
          action = self["__" .. name]:getChildByName(actionName)
          if action then
            break
          end
        end
      end
    end
    self[actionName] = action
  end
end

function UIBase:__initDataWidgets(widgets)
  for name, path in pairs(widgets) do
    local widget = UIHelper.getChildControl(self.root_panel, path)
    if widget then
      UIHelper.extend(widget)
      self[name] = widget
    else
      printError("UIBase:initDataWidgets, not eixst node %s = %s", name, path)
    end
  end
end

function UIBase:__addMask()
  if not self.uiData.mask then
    return
  end
  local mask = UIHelper.extend(ccui.Layout:create())
  mask:size(display.width, display.height)
  mask:setBackGroundColorType(1)
  mask:setBackGroundColor(cc.c3b(0, 0, 0))
  mask:setBackGroundColorOpacity(self.uiData.opacity or 210)
  mask:setTouchEnabled(true)
  mask:anch(0.5, 0.5):pos(display.cx, display.cy):addTo(self, -1)
  UIHelper.fitForiPhoneX(mask)
  mask:setCallback(function()
    local click = self.uiData.maskClick or false
    if not click then
      return true
    end
    local pos = mask:getTouchEndPosition()
    local containTouch = false
    local children = self.root_panel:getChildren()
    for _, child in ipairs(children) do
      if child:getTag() ~= maskTag and child:isVisible() then
        local rect = child:getBoundingBox()
        if cc.rectContainsPoint(rect, cc.p(pos.x, pos.y)) then
          containTouch = true
          break
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
  end)
end

function UIBase:__show(params)
  local order = self.uiData.order or 0
  local tag = self.uiData.tag or 0
  order = self.uiData.popup and POPUP_LAYER_ORDER or order
  if self.uiData.order and self.uiData.order > 0 then
    order = self.uiData.order
  end
  self:init(params)
  self:showData(params)
  local scene = params.scene or display.getRunningScene()
  if tag == 0 or not scene:getChildByTag(tag) then
    scene:addChild(self, order, tag)
  end
end

function UIBase:__enter()
  if self.downAction then
    UIHelper.MoveToDown({
      node = self.downAction
    })
  end
  if self.upAction then
    UIHelper.MoveToUp({
      node = self.upAction
    })
  end
  if self.leftAction then
    UIHelper.MoveToLeft({
      node = self.leftAction
    })
  end
  if self.rightAction then
    UIHelper.MoveToRight({
      node = self.rightAction
    })
  end
  if self.popAction then
    local scale = self.popAction:getScale()
    self.popAction:scale(scale * 0.4)
    self.popAction:runAction(cc.EaseElasticOut:create(cc.ScaleTo:create(0.8, scale)))
  end
end

function UIBase:init(params)
end

function UIBase:showData(params)
end

function UIBase:close()
  if self and not tolua.isnull(self) then
    self:removeSelf()
  end
end

return UIBase
