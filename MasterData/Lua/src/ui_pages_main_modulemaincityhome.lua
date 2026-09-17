local this = class("moduleMainCityHome", G_UIModuleBase)
local _BlockTpl = L_GameTpl:getHomeBlockTpl()
local HomeMainMode = L_HomeConst.homeMainMode

function this.bind()
  return {
    contentActive = false,
    module_homeCrop = {
      moduleName = "pages/home/homeCrop/moduleHomeCrop"
    },
    active_Crop = false,
    module_belt = {
      moduleName = "pages/home/homeBag/moduleHomeBeltPlatform"
    },
    module_homeCropHud = {
      moduleName = "pages/Home/homeCrop/moduleHomeCropHud"
    },
    module_homeScience = {
      moduleName = "pages/home/homeScience/moduleHomeScience"
    },
    module_homeMainRightCenter = {
      moduleName = "pages/home/homeMain/moduleHomeMainRightCenter"
    },
    txt_homeName = "",
    size_nameBg = C_Vector2(0, 62),
    active_buildLock = false,
    text_buildLock = ""
  }
end

function this.methods()
  return {
    onClick_info = function(self)
      L_UI:open("pageHomeLevelInfo")
    end,
    onClick_FurnitureShop = function(self)
      L_ShopStore:req_listShopItems(210000, function()
        L_UI:open("pageHomeFurnitureShop", {shopID = 210000})
      end)
    end,
    onClick_dormManage = function(self)
      L_UI:open("pageHomeDormitoryManage")
    end
  }
end

function this:open()
  self.parentPageName = "pageMainCity"
  self.csHomeManager = AzurWorld.HomeMgr
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "moduleMainCityHome.update")
  self._onCutWorldComplete = handler(self, self.refreshState)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshPlayerStatus, self.updateButtonsActive, self)
  L_HomeStore:listenCallFunc(L_HomeStore.event.syncHomeContentUnlock, self.onEvent_syncHomeContentUnlock, self)
  L_HomeStore:listenCallFunc(L_HomeStore.event.refreshHomeInfo, self.refreshHomeName, self)
  if not C_HomeUtil:OnCheckIsUnLockHomePlowLand() then
    self._refreshTaskHandler = self._refreshTaskHandler or handler(self, self.onEvent_refreshTask)
    AzurWorld.TaskMgr:RegisterEvent(C_ETaskEvent.RefreshUITask, self._refreshTaskHandler)
  end
  L_UI:addListener(L_UI.pageEvent.showed, self.onEventMessageUIShowed, self)
  self:registerReddot(self.bindComponents.trans_homeTechLevelShowReddot, L_ReddotManager.DotDef.MainCityHomeTechLevelShow)
  self:refreshHomeName()
  self:refreshState()
  self:bindPcKey()
  self:initSystem()
end

function this:bindPcKey()
end

function this:refreshHomeName()
  self.bind.txt_homeName = L_HomeStore:getHomeName()
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_nameInfo)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_horizontal)
end

function this:hide()
end

function this:close()
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshPlayerStatus, self.updateButtonsActive, self)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.syncHomeContentUnlock, self.onEvent_syncHomeContentUnlock)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.refreshHomeInfo, self.refreshHomeName, self)
  L_UI:removeListener(L_UI.pageEvent.showed, self.onEventMessageUIShowed, self)
  if self._refreshTaskHandler then
    AzurWorld.TaskMgr:UnregisterEvent(C_ETaskEvent.RefreshUITask, self._refreshTaskHandler)
  end
  L_ShortCutManager:clearShortKeyFlag(self)
  self:destroyAllLocker()
end

function this:refreshState()
  local curModule = L_WorldManager:getCurModule()
  local isHome = curModule == L_Const.worldModule.home
  self.bind.contentActive = isHome
  if not isHome then
    return
  end
end

function this:registerShortCut(pageName)
  self.modules.module_belt:registerShortCut(pageName)
end

function this:show()
  self:updateButtonsActive()
  self.modules.module_homeCrop:show()
  self.modules.module_belt:refreshView()
  if not self.parentPageName then
    return
  end
  self:registerShortCut(self.parentPageName)
end

function this:isCropAvaliable()
  return self._currMode == HomeMainMode.CROP
end

function this:update()
  local curModule = L_WorldManager:getCurModule()
  if curModule ~= L_Const.worldModule.home then
    return
  end
  self:updateButtonsActive()
end

function this:updateButtonsActive(isForce)
  local playerEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if not playerEntity then
    return
  end
  local currMode = self.csHomeManager.curHomeMainMode:GetHashCode()
  if not isForce and currMode == self._currMode then
    return
  end
  self._currMode = currMode
  local currBlockId, currGridId = self.csHomeManager:GetInteractBlockIdAndGridIdWithPlayerByOffset()
  self.bind.active_Crop = currMode == HomeMainMode.CROP
  self.bind.active_buildLock = currMode == HomeMainMode.BUILD_LOCK
  if currMode == HomeMainMode.CROP then
    self.modules.module_belt:refreshBagShow(L_Const.HomeShortcutBarType.HSBT_CROP)
    self.modules.module_belt:activeBelt()
    self.modules.module_homeCrop:initPage(self.modules.module_belt)
    self.modules.module_homeMainRightCenter:onRefreshFarmModel(true)
  elseif currMode == HomeMainMode.BUILD then
    self.modules.module_homeMainRightCenter:onRefreshFarmModel(true)
    self.modules.module_belt:activeBelt()
    self._curBlockId = currBlockId
    self.modules.module_belt:refreshBagShow(L_Const.HomeShortcutBarType.HSBT_BUILD)
    self.modules.module_belt:setBelt(L_Const.HomeShortcutBarType.HSBT_BUILD, false, {
      onClickCell = function(id, viewId)
        if not C_HomeUtil.GetIsBlockUnlock(currBlockId) then
          return
        end
        local build = L_HomeStore:getBuildingInBag(id)
        if not build then
          return
        end
        local num = build.total_num - build.used_num
        local placeUnlock = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.homePlace)
        if not placeUnlock then
          return
        end
        if 0 < num then
          if L_DeviceTpl:getIsPc() then
            L_UI:open("pageHomePlayerEditCS", {buildingId = id})
          else
            L_UI:open("pageHomePlayerEditMobile", {buildingId = id})
          end
        else
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_homeProduction_36"))
        end
      end
    })
  elseif currMode == HomeMainMode.BUILD_LOCK then
    self.modules.module_homeMainRightCenter:onRefreshFarmModel(false)
    self.modules.module_belt:hideBelt()
    if 0 < currBlockId then
      local blockTpl = _BlockTpl:getTplById(currBlockId)
      local condition = _BlockTpl:getUnlockCondi(blockTpl)
      if table.isEmpty(condition) then
        self.bind.active_buildLock = false
      else
        self.bind.text_buildLock = L_ConditionManager:getTipDesc({condition})
      end
    else
      self.bind.active_buildLock = false
    end
  else
    self.modules.module_homeMainRightCenter:onRefreshFarmModel(false)
    self.modules.module_belt:hideBelt()
  end
end

function this:getCurrMode()
  return self._currMode
end

function this:onEvent_syncHomeContentUnlock()
  self:updateButtonsActive()
end

function this:onEvent_refreshTask(type, list)
  self:updateButtonsActive()
  if C_HomeUtil:OnCheckIsUnLockHomePlowLand() and self._refreshTaskHandler then
    AzurWorld.TaskMgr:UnregisterEvent(C_ETaskEvent.RefreshUITask, self._refreshTaskHandler)
  end
end

function this:onEventMessageUIShowed(pageName)
  if pageName == "pageMainCity" then
    self:updateButtonsActive(true)
  end
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.furnitureShop] = {
      self.bindComponents.root_furnitureShopBtn
    },
    [L_SystemConst.enum.homeDormManage] = {
      self.bindComponents.root_homeDormManage
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
    locker:tryShowOrHide(v, isUnlock)
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

function this:activate(...)
  local data = {
    ...
  }
  self.parentPageName = data[1]
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
end

return this
