local this = class("pageMultiDungeon", G_UIPageBase)

function this.bind()
  return {
    txt_chatNum = "",
    go_chatNum = false,
    module_task = {
      moduleName = "pages/task/moduleTask"
    },
    module_moveBlock = {
      moduleName = "modulePages/moduleMovementBlock"
    },
    module_miniMap = {
      moduleName = "pages/main/moduleMainMiniMap"
    },
    go_moduleHero = true,
    module_hero = {
      moduleName = "pages/main/moduleMainPlayer"
    },
    module_mount = {
      moduleName = "pages/main/moduleMount"
    },
    module_general = {
      moduleName = "pages/main/moduleMainCityGeneral"
    },
    module_mainCitySkill = {
      moduleName = "pages/main/moduleMainCitySkill"
    },
    module_screenGuide = {
      moduleName = "pages/main/moduleScreenGuide"
    },
    module_sceneBorderTransfer = {
      moduleName = "pages/main/moduleScreenBorderTransfer"
    },
    module_dungeonCountdown = {
      moduleName = "pages/main/moduleDungeonCountdown"
    }
  }
end

function this.methods()
  return {
    onClick_menu = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.mainMenu)
    end,
    onClick_chat = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.chat)
    end,
    onClick_exitDungeon = function(self)
      L_MultiDungeonStore:req_CSProtoMultiCampaignQuit()
    end
  }
end

function this:preOpen(options)
  L_UI:addListener(L_UI.pageEvent.preOpen, self.onEvent_showPage, self)
  L_UI:addListener(L_UI.pageEvent.closed, self.onEvent_hidePage, self)
  self._onCutWorldComplete = handler(self, self.onEvent_switchSceneEnd)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_WorldLevelStore:listenCallFunc(L_WorldLevelStore.event.upWorldLevel, self.refreshShowWorldLevel, self)
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshConversationList, self.onEvent_refreshChatNum, self)
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshMessage, self.onEvent_refreshChatNum, self)
  L_ChatStore:listenCallFunc(L_ChatStore.event.clearUnreadNum, self.onEvent_refreshChatNum, self)
  L_ReddotManager:registerReddot(self.bindComponents.menuDot, L_ReddotManager.DotDef.Menu)
  self:initSystem()
  self:initReddot()
  self:refreshChatNum()
  self:bindPcKey()
end

function this:show()
  self._pageReady = true
  self.modules.module_moveBlock:refresh()
  self:refreshShowWorldLevel()
  L_ShortCutManager:registerPageMainShortCut()
end

function this:hide()
  self._pageReady = false
end

function this:close(options)
  L_UI:removeListener(L_UI.pageEvent.preOpen, self.onEvent_showPage)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onEvent_hidePage)
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_WorldLevelStore:unListenCallFunc(L_WorldLevelStore.event.upWorldLevel, self.refreshShowWorldLevel)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshConversationList, self.onEvent_refreshChatNum)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshMessage, self.onEvent_refreshChatNum)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.clearUnreadNum, self.onEvent_refreshChatNum)
  self:destroyAllLocker()
  L_ShortCutManager:clearShortKeyFlag(self)
  self:disposeTween()
end

function this:disposeTween()
  if self.healingTween then
    self.healingTween:Kill()
    self.healingTween = nil
  end
  if self.increaseTween then
    self.increaseTween:Kill()
    self.increaseTween = nil
  end
end

function this:escHandle()
end

function this:update()
  if self._pageReady then
    self.modules.module_general:update()
    self.modules.module_miniMap:update()
    self.modules.module_screenGuide:update()
  end
end

function this:onEvent_switchSceneEnd()
  self:refreshProxyModule()
end

function this:onEvent_refreshChatNum()
  self:refreshChatNum()
end

function this:onEvent_showPage(pageName)
  if pageName == "pageBattleSettle" then
    self.bind.go_moduleHero = false
  elseif pageName == "pageMultiDungeonSettle" then
    self.modules.module_dungeonCountdown:closeCountdown()
  end
end

function this:onEvent_hidePage(pageName)
  if pageName == "pageBattleSettle" then
    self.bind.go_moduleHero = true
    self.modules.module_hero:show()
  end
end

function this:refreshChatNum()
  local unreadMessageNum = L_ChatStore:getAllUnReadNum()
  local isShow = not math.isEmpty(unreadMessageNum)
  self.bind.go_chatNum = isShow
  if isShow then
    self.bind.txt_chatNum = 99 < unreadMessageNum and "99+" or tostring(unreadMessageNum)
  end
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

function this:refreshProxyModule()
  local curModule = L_WorldManager:getCurModule()
  local isHome = curModule == L_Const.worldModule.home
  if not isHome then
    self.modules.module_miniMap:refreshNodeListPos()
  end
end

function this:bindPcKey()
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openActivity, L_Const.AnchorType.Bottom, self.bindComponents.transActivity, L_Vector3.new(0, -3, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openBag, L_Const.AnchorType.Bottom, self.bindComponents.transBag, L_Vector3.new(0, -3, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openHero, L_Const.AnchorType.Bottom, self.bindComponents.transHero, L_Vector3.new(0, -3, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openPet, L_Const.AnchorType.Bottom, self.bindComponents.transPet, L_Vector3.new(0, -3, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openMenu, L_Const.AnchorType.Bottom, self.bindComponents.transCaiDan)
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openChat, L_Const.AnchorType.Right, self.bindComponents.transChat)
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openTask, L_Const.AnchorType.Right, self.bindComponents.transBtnTask)
end

function this:initReddot()
  local reddotMap = {
    [L_ReddotManager.DotDef.Activity] = self.bindComponents.activityDot,
    [L_ReddotManager.DotDef.Bag] = self.bindComponents.bagDot,
    [L_ReddotManager.DotDef.Pet] = self.bindComponents.petDot,
    [L_ReddotManager.DotDef.Hero] = self.bindComponents.heroDot
  }
  for key, go in pairs(reddotMap) do
    L_ReddotManager:registerReddot(go, key)
  end
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.recover] = {
      self.bindComponents.transRecover
    },
    [L_SystemConst.enum.chat] = {
      self.bindComponents.transChat
    },
    [L_SystemConst.enum.mainMenu] = {
      self.bindComponents.transCaiDan
    },
    [L_SystemConst.enum.activation] = {
      self.bindComponents.transActivity
    },
    [L_SystemConst.enum.pet] = {
      self.bindComponents.transPet
    },
    [L_SystemConst.enum.hero] = {
      self.bindComponents.transHero
    },
    [L_SystemConst.enum.task] = {
      self.bindComponents.transTask
    },
    [L_SystemConst.enum.map] = {
      self.bindComponents.transMap
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

function this:destroyAllLocker()
  for _, v in pairs(self.systemToTrans) do
    local locker = v.locker
    if locker then
      C_IntegrateMgr.SystemUnlockModule:RemoveLocker(locker)
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
end

return this
