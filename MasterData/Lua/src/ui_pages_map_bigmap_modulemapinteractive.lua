local this = class("moduleMapInteractive", G_UIModuleBase)

function this.bind()
  return {
    list_button = {
      moduleName = "pages/map/bigMap/cellMapInteractive"
    },
    active_buttonBg = false,
    size_buttonBg = C_Vector2(608, 320),
    size_line1 = C_Vector2(100, 53),
    size_line2 = C_Vector2(100, 174)
  }
end

function this.methods()
  return {
    onClick_closeInteractive = function(self)
      if self.parent then
        self.parent:closeInteractive()
      end
    end
  }
end

function this:open(options)
  this.super.open(self, options)
  L_ShortCutManager:registerShortCut("pageBigMap", C_InputManager_KeyType.EPageBigMapInteract, handler(self, self.invokeSelectButton), true)
  if not L_DeviceTpl:getIsMobile() then
    self._mouseScrollWheelHandle = handler(self, self.onListen_mouseScrollWheel)
    C_InputManager.AddSingleAxisListener(C_InputManager.EInputSingleAxisType.EMainMouseScroll, self._mouseScrollWheelHandle)
    self.selectedIndex = 1
    self.selectedOption = 1
  end
  self._entity2ButtonDatas = {}
  self.bind.list_button:clear()
  self.bind.active_buttonBg = false
end

function this:close()
  L_ShortCutManager:removeShortCut(self.parent.pageName)
  if not L_DeviceTpl:getIsMobile() then
    C_InputManager.RemoveSingleAxisListener(C_InputManager.EInputSingleAxisType.EMainMouseScroll, self._mouseScrollWheelHandle)
    self._mouseScrollWheelHandle = nil
    self.selectedIndex = 1
    self.selectedOption = 1
    C_CameraManager.uiCanScaleView = true
  end
end

function this:refreshButtons(interactiveDatas)
  local isShow = not table.isEmpty(interactiveDatas)
  if not isShow then
    self.bind.list_button:clear()
    self.bind.active_buttonBg = false
    return
  end
  local tmp = {}
  for i, v in pairs(interactiveDatas) do
    table.insert(tmp, {
      index = #tmp + 1,
      nodeData = v.nodeData,
      type = v.type,
      onClick = v.onClick
    })
  end
  self.bind.list_button:clear()
  if not L_DeviceTpl:getIsMobile() then
    C_CameraManager.uiCanScaleView = #tmp <= 1
  end
  self.bind.active_buttonBg = 1 < #tmp and L_DeviceTpl:getIsPc()
  self.bind.size_buttonBg = C_Vector2(660, 320 + #tmp * 63)
  self.bind.list_button:insert_array(tmp)
  self.selectedIndex = 1
  self:_refreshButtons()
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.generalNode)
end

function this:_refreshButtons()
  if not L_DeviceTpl:getIsPc() then
    return
  end
  local selectIndex = self.selectedIndex or 0
  self.bind.size_line1 = C_Vector2(100, -10 + selectIndex * 63)
  self.bind.size_line2 = C_Vector2(100, 53 + (#self.modules.list_button - selectIndex) * 63)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.bgLineNode)
  for _, button in ipairs(self.modules.list_button) do
    button:refreshState()
  end
end

function this:hideButtons()
  self.bind.list_button:clear()
  self.bind.active_buttonBg = false
end

function this:onListen_mouseScrollWheel(dv)
  self.selectedIndex = self.selectedIndex + (0 < dv and -1 or dv < 0 and 1 or 0)
  self.selectedIndex = math.clamp(self.selectedIndex, 1, #self.modules.list_button)
  self:_refreshButtons()
end

function this:invokeSelectButton(isPress)
  if self.bind.active_buttonBg and not math.isEmpty(self.selectedIndex) and self.modules.list_button[self.selectedIndex] then
    self.modules.list_button[self.selectedIndex]:invokeClick()
  end
end

return this
