local CcsHelper = {}

function CcsHelper.loadCCSFile(name)
  local node = cc.CSLoader:createNode(name)
  node:size(display.width, display.height)
  ccui.Helper:doLayout(node)
  return node
end

function CcsHelper.initPanelLayout(panel)
  local scale = UIHelper.getPlatformScale()
  panel:setTag(1)
  local downPanel = panel:getChildByName("down")
  if downPanel then
    downPanel:setAnchorPoint(cc.p(0.5, 0))
    downPanel:setScale(scale)
    downPanel:setPosition(cc.p(display.cx, 0))
  end
  local upPanel = panel:getChildByName("up")
  if upPanel then
    upPanel:setAnchorPoint(cc.p(0.5, 1))
    upPanel:setScale(scale)
    upPanel:setPosition(cc.p(display.cx, display.height))
  end
  local leftPanel = panel:getChildByName("left")
  if leftPanel then
    leftPanel:setAnchorPoint(cc.p(0, 0.5))
    leftPanel:setScale(scale)
    leftPanel:setPosition(cc.p(0, display.cy))
  end
  local rightPanel = panel:getChildByName("right")
  if rightPanel then
    rightPanel:setAnchorPoint(cc.p(1, 0.5))
    rightPanel:setScale(scale)
    rightPanel:setPosition(cc.p(display.width, display.cy))
  end
  local centerPanel = panel:getChildByName("center")
  if centerPanel then
    centerPanel:setAnchorPoint(cc.p(0.5, 0.5))
    centerPanel:setScale(scale)
    centerPanel:setPosition(cc.p(display.cx, display.cy))
  end
  local left_down_panel = panel:getChildByName("left_down")
  if left_down_panel then
    left_down_panel:setAnchorPoint(cc.p(0, 0))
    left_down_panel:setScale(scale)
    left_down_panel:setPosition(cc.p(0, 0))
  end
  local right_down_panel = panel:getChildByName("right_down")
  if right_down_panel then
    right_down_panel:setAnchorPoint(cc.p(1, 0))
    right_down_panel:setScale(scale)
    right_down_panel:setPosition(cc.p(display.width, 0))
  end
  local left_up_panel = panel:getChildByName("left_up")
  if left_up_panel then
    left_up_panel:setAnchorPoint(cc.p(0, 1))
    left_up_panel:setScale(scale)
    left_up_panel:setPosition(cc.p(0, display.height))
  end
  local right_up_panel = panel:getChildByName("right_up")
  if right_up_panel then
    right_up_panel:setAnchorPoint(cc.p(1, 1))
    right_up_panel:setScale(scale)
    right_up_panel:setPosition(cc.p(display.width, display.height))
  end
end

function CcsHelper.parseUIdata(rootPanel, widgets, interface)
  if type(rootPanel) == "string" then
    rootPanel = self.loadCCSFile(rootPanel)
  end
  CcsHelper.initPanelLayout(rootPanel)
  interface = interface or {}
  for name, path in pairs(widgets) do
    local widget = UIHelper.getChildControl(rootPanel, path)
    if widget then
      UIHelper.extend(widget)
      interface[name] = widget
    else
      printError("CcsHelper.parseUIdata, not eixst node %s = ", path)
    end
  end
  interface.rootPanel = rootPanel
  interface.rootNode = rootPanel
  return interface
end

return CcsHelper
