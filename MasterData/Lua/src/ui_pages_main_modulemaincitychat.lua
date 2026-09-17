local this = class("moduleMainCityChat", G_UIModuleBase)

function this.bind()
  return {go_chatNum = false}
end

function this.methods()
  return {
    onClick_chat = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.chat)
    end
  }
end

function this:open()
  self:registerEvents()
  self:refreshChatNum()
  self:initSystem()
  self:bindPcKey()
end

function this:show(options)
  self:refreshShowWorldLevel()
end

function this:onEvent_refreshChatNum()
  self:refreshChatNum()
end

function this:refreshChatNum()
  local unreadMessageNum = L_ChatStore:getAllUnReadNum()
  local isShow = not math.isEmpty(unreadMessageNum)
  self.bind.go_chatNum = isShow
  if isShow then
  end
end

function this:close()
  self:unRegisterEvents()
  self:destroyAllLocker()
  L_ShortCutManager:clearShortKeyFlag(self)
end

function this:bindPcKey()
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openChat, L_Const.AnchorType.Bottom, self.bindComponents.transChat)
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.chat] = {
      self.bindComponents.transChat
    }
  }
  for systemId, v in pairs(self.systemToTrans) do
    v.locker = C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(systemId)
    if v.locker then
      self:refreshSystem(systemId, false)
      v.locker:setCallback(self.refreshSystem, self, self.gameObject)
    end
  end
end

function this:refreshSystem(systemId, isUnlock)
  local node = self.systemToTrans[systemId]
  local locker = node.locker
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
  if systemId == L_SystemConst.enum.chat then
    L_BattleDataManager:sendEvent(L_BattleDataManager.event.refreshPageMainLeftBottomLayout)
  end
end

function this:registerEvents()
  L_WorldLevelStore:listenCallFunc(L_WorldLevelStore.event.upWorldLevel, self.refreshShowWorldLevel, self)
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshConversationList, self.onEvent_refreshChatNum, self)
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshMessage, self.onEvent_refreshChatNum, self)
  L_ChatStore:listenCallFunc(L_ChatStore.event.clearUnreadNum, self.onEvent_refreshChatNum, self)
  L_ReddotManager:registerReddot(self.bindComponents.reddotSmall, L_ReddotManager.DotDef.Chat)
end

function this:unRegisterEvents()
  L_WorldLevelStore:unListenCallFunc(L_WorldLevelStore.event.upWorldLevel, self.refreshShowWorldLevel)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshConversationList, self.onEvent_refreshChatNum)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshMessage, self.onEvent_refreshChatNum)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.clearUnreadNum, self.onEvent_refreshChatNum)
  self:disposeReddot()
end

function this:refreshShowWorldLevel()
  if L_WorldLevelStore:getNeedShowLevel() then
    L_WorldLevelStore:setNeedShowLevel()
    L_UI:open("pageWorldLevelConfirm", {
      targetLevel = L_WorldLevelStore:getMaxLevel(),
      canUp = true
    })
  end
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

return this
