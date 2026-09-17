local this = class("modulePetDevelop", G_UIModuleBase)

function this.bind()
  return {
    toggleModuleName = "",
    moduleTabList = {
      moduleName = "pages/common/modules/moduleCommonTab"
    },
    toggleModuleBar = {
      type = "toggleModule",
      modulePetFeed = {
        assetName = "UI/Pages/Pet/modulePetFeed",
        moduleName = "pages/Pet/modulePetFeed"
      },
      modulePetStarSoul = {
        assetName = "UI/Pages/Pet/modulePetStarSoul",
        moduleName = "pages/Pet/modulePetStarSoul"
      }
    },
    active_topBar = true
  }
end

function this:open()
  this.super.open(self)
  self:initTabList()
  self:switchPage(1)
end

function this:setShowPetGuid(petGuid)
  self.petGuid = petGuid
end

function this:refreshUI()
  if not self.petGuid then
    return
  end
  if self.tabIdx == 1 then
    self.modules.toggleModuleBar.modulePetFeed:setShowPetGuid(self.petGuid)
    self.modules.toggleModuleBar.modulePetFeed:refreshUI()
  end
  if self.tabIdx == 2 then
    self.modules.toggleModuleBar.modulePetStarSoul:setShowPetGuid(self.petGuid)
    self.modules.toggleModuleBar.modulePetStarSoul:refreshUI()
    self.modules.toggleModuleBar.modulePetStarSoul:SetJumpCall(function()
      self:switchTab(1)
    end)
  end
end

function this:initTabList()
  local tabList = {
    [1] = {
      id = 1,
      name = L_WordsTpl:getValue("ui_kibo_fruit_tab")
    },
    [2] = {
      id = 2,
      name = L_WordsTpl:getValue("ui_kibo_starsoul_tab")
    }
  }
  self.modules.moduleTabList:initData(tabList, function(tabId)
    if tabId == -1 then
      return
    end
    self:switchPage(tabId)
  end, 1)
  self.modules.moduleTabList:setWillSelectTab(function(tabId)
    if tabId == 2 then
      return C_IntegrateMgr.SystemUnlockModule:checkAndTip(L_SystemConst.enum.petFruitStrengthen)
    end
    return true
  end)
end

function this:switchTab(idx)
  self.modules.moduleTabList:setSelectTabId(idx)
end

function this:switchPage(idx)
  if self.tabIdx == idx then
    return
  end
  if idx == 1 then
    self.bind.toggleModuleName = "modulePetFeed"
    if self.tabIdx == 2 then
      L_PetManager:switchToFeed()
    end
    local args = CS.Lens.Gameplay.Modules.BigWorld.CommonIntEventArgs()
    args.objIndex = 1
    C_ExternalManager.DispatchEvent(C_EExternalEventType.SwitchPetPage, args)
  else
    self.bind.toggleModuleName = "modulePetStarSoul"
    L_PetManager:switchToStarSoul()
    local args = CS.Lens.Gameplay.Modules.BigWorld.CommonIntEventArgs()
    args.objIndex = 2
    C_ExternalManager.DispatchEvent(C_EExternalEventType.SwitchPetPage, args)
  end
  self.tabIdx = idx
  self:refreshUI()
end

function this:setTabListShow(isShow)
  if isShow then
    self.modules.moduleTabList:customShow()
  else
    self.modules.moduleTabList:customHide()
  end
end

return this
