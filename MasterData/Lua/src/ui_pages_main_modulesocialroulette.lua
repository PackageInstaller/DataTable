local this = class("moduleSocialRoulette", G_UIModuleBase)

function this.bind()
  return {chatActive = false}
end

function this.methods()
  return {
    onClick_SocialRoulette = function(self)
      L_UI:open("pageSocialQuickRoulette")
    end
  }
end

function this:open()
  self.bind.chatActive = not L_DeviceTpl:getIsPc()
  self:showShortCut(20, not C_InputManager.IsEnableGamePad)
  self:registerEvents()
  self:refreshChatNum()
  self:initSystem()
  self:bindPcKey()
end

function this:show(options)
  self:refreshShowWorldLevel()
  self:setShortcutActive(20, true)
  if L_DeviceTpl:getIsPc() then
    self.bind.chatActive = false
  end
end

function this:hide(options)
  self:setShortcutActive(20, false)
end

function this:onEvent_refreshChatNum()
  self:refreshChatNum()
end

function this:refreshChatNum()
end

function this:close()
  self:unRegisterEvents()
  self:destroyAllLocker()
  self:showShortCut(20, false)
  L_ShortCutManager:clearShortKeyFlag(self)
end

function this:bindPcKey()
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openSocialRoulette, L_Const.AnchorType.Bottom, self.bindComponents.transSocialRoulette)
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.socialRoulette] = {
      self.bindComponents.transSocialRoulette
    }
  }
  for systemId, v in pairs(self.systemToTrans) do
    v.locker = C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(systemId)
    if v.locker then
      self:refreshSystem(systemId, false)
    end
  end
end

function this:refreshSystem(systemId, isUnlock)
  local node = self.systemToTrans[systemId]
  local locker = node.locker
  self:showShortCut(20, isUnlock and not C_InputManager.IsEnableGamePad)
  for _, v in ipairs(node) do
    local isNeedShow = locker:tryShowOrHide(v, isUnlock)
    if isNeedShow then
      local lock = v:Find("lock")
      local unlock = v:Find("unlock")
      if lock then
        lock.gameObject:ActiveTrans(not isUnlock)
      end
      if unlock then
        unlock.gameObject:ActiveTrans(isUnlock)
      end
    end
  end
  if systemId == L_SystemConst.enum.socialRoulette then
    L_BattleDataManager:sendEvent(L_BattleDataManager.event.refreshPageMainLeftBottomLayout)
  end
end

function this:registerEvents()
  self:registerReddot(self.bindComponents.reddotSmall, L_ReddotManager.DotDef.SocialEmotion)
  self.systemUnlockHandleId = C_IntegrateMgr.SystemUnlockModule:listenCallFunc(C_IntegrateMgr.SystemUnlockModule.updateSystem, self.refreshSystemUnlock, self)
  L_BattleManager:addListener(L_BattleManager.event.battleStart, self.onEvent_battleStart, self)
  self._onControlSchemeChangeHandle = handler(self, self.onControlSchemeChange)
  C_ExternalManager.AddEvent(C_EExternalEventType.ControlSchemeChange, self._onControlSchemeChangeHandle)
end

function this:unRegisterEvents()
  C_IntegrateMgr.SystemUnlockModule:unListenCallFunc(self.systemUnlockHandleId)
  L_BattleManager:removeListener(L_BattleManager.event.battleStart, self.onEvent_battleStart, self)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.ControlSchemeChange, self._onControlSchemeChangeHandle)
  self._onControlSchemeChangeHandle = nil
end

function this:onEvent_battleStart()
end

function this:onEvent_exitBattle()
  local isShow = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.socialRoulette)
end

function this:refreshShowWorldLevel()
end

function this:refreshSystemUnlock(id)
  if id ~= L_SystemConst.enum.socialRoulette then
    return
  end
  local isShow = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.socialRoulette)
  if not L_DeviceTpl:getIsPc() then
    self.gameObject:SetActive(isShow)
  end
  self:showShortCut(20, isShow and not C_InputManager.IsEnableGamePad)
end

function this:showShortCut(id, idAdd)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuideEventArgs()
  args.isLuaEvent = true
  args.luaTable = {
    tdId = id,
    isAdd = idAdd,
    isGray = false
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcChange, args)
end

function this:setShortcutActive(id, isShow)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuideActiveEventArgs()
  args.isLuaEvent = true
  args.luaTable = {
    tdId = id,
    isHide = not isShow
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcActive, args)
end

function this:destroyAllLocker()
  for _, v in pairs(self.systemToTrans) do
    local locker = v.locker
    if locker then
      C_IntegrateMgr.SystemUnlockModule:RemoveLocker(locker)
    end
  end
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
  L_BattleDataManager:sendEvent(L_BattleDataManager.event.refreshPageMainLeftBottomLayout)
end

function this:onControlSchemeChange(args)
  local isShow = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.socialRoulette)
  local top = C_UIMgr.GetTopPage(0)
  local isTopPage = top and top.name == "pageMainCity"
  self:showShortCut(20, isShow and not C_InputManager.IsEnableGamePad and isTopPage)
end

return this
