local this = class("moduleMainCityGeneral", G_UIModuleBase)

function this.bind()
  return {go_exitDungeonBtn = false}
end

function this.methods()
  return {
    onClick_activity = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.activation)
    end,
    onClick_bag = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.bag)
    end,
    onClick_email = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.mail)
    end,
    onClick_science = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.homeScience)
    end,
    onClick_specialShop = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.specialShop, {shopId = 9999})
    end,
    onClick_petBox = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.pet)
    end,
    onClick_hero = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.hero)
    end
  }
end

function this:open()
  self.systemUnlockHandleId = C_IntegrateMgr.SystemUnlockModule:listenCallFunc(C_IntegrateMgr.SystemUnlockModule.updateSystem, self.onEvent_updateSystem, self)
  L_NoviceTaskStore:listenCallFunc(L_NoviceTaskStore.event.refreshNoviceTask, self.onEvent_refreshNoviceTask, self)
  self:initRedDot()
  self:initSystem()
  self:bindPcKey()
  self:checkIsInDungeon()
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.bag] = {
      self.bindComponents.transBag
    },
    [L_SystemConst.enum.specialShop] = {
      self.bindComponents.transSpecialShop
    },
    [L_SystemConst.enum.activation] = {
      self.bindComponents.transActivity
    }
  }
  for systemId, v in pairs(self.systemToTrans) do
    v.locker = C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(systemId)
    if v.locker then
      self:refreshSystem(systemId, false)
      v.locker:setCallback(self.refreshSystem, self, self.gameObject)
    end
  end
  local specialSystemId = {
    L_SystemConst.enum.noviceTask
  }
  for _, systemId in pairs(specialSystemId) do
    self:refreshSpecialSystem(systemId)
  end
end

function this:initRedDot()
  local reddotMap = {
    [L_ReddotManager.DotDef.Activity] = self.bindComponents.activityDot,
    [L_ReddotManager.DotDef.Bag] = self.bindComponents.bagDot,
    [L_ReddotManager.DotDef.SpecialShop] = self.bindComponents.specialShopDot
  }
  for key, go in pairs(reddotMap) do
    L_ReddotManager:registerReddot(go, key)
  end
end

function this:bindPcKey()
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openActivity, L_Const.AnchorType.Bottom, self.bindComponents.transActivity, L_Vector3.new(0, -3, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openBag, L_Const.AnchorType.Bottom, self.bindComponents.transBag, L_Vector3.new(0, -3, 0))
end

function this:checkIsInDungeon()
  local isInDungeon = AzurWorld.DungeonMgr:CheckIsDungeonScene()
  self.bind.go_exitDungeonBtn = isInDungeon
end

function this:onEvent_updateSystem(systemId)
  self:refreshSpecialSystem(systemId)
end

function this:onEvent_refreshNoviceTask()
  self:refreshSpecialSystem(L_SystemConst.enum.noviceTask)
end

function this:close()
  self:destroyAllLocker()
  L_ShortCutManager:clearShortKeyFlag(self)
  C_IntegrateMgr.SystemUnlockModule:unListenCallFunc(self.systemUnlockHandleId)
  L_NoviceTaskStore:unListenCallFunc(L_NoviceTaskStore.event.refreshNoviceTask, self.onEvent_refreshNoviceTask, self)
end

function this:refreshState(isHome)
  self.bind.contentActive = not isHome
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

function this:checkIfNoviceTaskSystemActivateActivityTrans()
  local isActivationOpen = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.activation)
  local isNoviceOpen = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.noviceTask)
  if not isActivationOpen and not isNoviceOpen then
    return false
  end
  if isActivationOpen then
    return true
  end
  if isNoviceOpen then
    if L_NoviceTaskStore:checkIfAllTaskCompletedAndAllRewardReceived() then
      return false
    end
    return true
  end
end

function this:refreshSpecialSystem(systemId)
  if not self.systemId2Trans then
    self.systemId2Trans = {
      [L_SystemConst.enum.noviceTask] = self.bindComponents.transActivity
    }
  end
  if not self.systemId2CheckFunc then
    self.systemId2CheckFunc = {
      [L_SystemConst.enum.noviceTask] = "checkIfNoviceTaskSystemActivateActivityTrans"
    }
  end
  if not self.systemId2Trans[systemId] then
    return
  end
  local show = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(systemId) and self[self.systemId2CheckFunc[systemId]](self)
  self.systemId2Trans[systemId].gameObject:ActiveTrans(show)
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
end

return this
