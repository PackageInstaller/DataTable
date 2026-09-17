local page = class("pageFaceIn", G_UIPageBase)

function page.bind()
  return {}
end

function page.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function page:created(...)
  page.super.created(self, ...)
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self._onLateCutWorldStart = handler(self, self.closeMe)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.LateCutWorldStart, self._onLateCutWorldStart)
  local virCamera = C_CameraManager.GetTactics().cineMachineCamera
  local trans = virCamera.transform
  local characterControlProperty = C_EntityManager.ControllingHeroEntity.data.characterControlProperty
  characterControlProperty:EnableIK(C_EntityManager.ControllingHeroEntity, trans)
  if L_DeviceTpl:getIsPc() then
    self:setShortcutGuidePCActive(true)
  end
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EMainBack, function(value)
    L_UI:close("pageFaceIn")
  end)
end

function page:escHandle()
end

function page:close()
  page.super.close(self)
  L_ShortCutManager:removeShortCut(self.pageName)
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.LateCutWorldStart, self._onLateCutWorldStart)
  local characterControlProperty = C_EntityManager.ControllingHeroEntity.data.characterControlProperty
  characterControlProperty:DisableIK(C_EntityManager.ControllingHeroEntity)
  local fixedFollow = C_CameraManager.GetTactics().fixFollow
  if L_CommonUtil.isValid(fixedFollow) then
    fixedFollow:ZoomOutWithTarget(false)
  end
  if L_DeviceTpl:getIsPc() then
    self:setShortcutGuidePCActive(false)
  end
end

function page:closeMe(pageName)
  L_UI:close(self.pageName)
end

function page:onEvent_otherOpen(pageName)
  if pageName and pageName ~= self.pageName then
    L_UI:close(self.pageName)
  end
end

function page:setShortcutGuidePCActive(isShow)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuidePcUiPanelEventArgs()
  args.isLuaEvent = true
  args.luaTable = {shortcutGuidePcUiPanel = 16}
  if isShow then
    C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcShowUiPanel, args)
  else
    C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcHideUiPanel, args)
  end
end

return page
