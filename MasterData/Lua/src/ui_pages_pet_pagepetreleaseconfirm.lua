local this = class("pagePetReleaseConfirm", G_UIPageBase)
local propertyPath = "UI/Pages/Formation/moduleFormationPetProperty.prefab"
local propetyLuaPath = "UI/pages/formation/formationModule/moduleFormationPetProperty"

function this.bind()
  return {
    tipboard = L_Const.ModuleInfo.ModuleCommonTip,
    toggle_petListAlignLeft = false,
    petList = {
      moduleName = "pages/pet/cellPixelPet"
    },
    petScrollList = {
      moduleName = "pages/pet/cellPixelPet"
    },
    rewardList = L_Const.ModuleInfo.CellIconBag,
    rewardsListActive = true,
    emptyTipActive = false
  }
end

function this.methods()
  return {
    tipboard = {
      onClick_confirm = function(self)
        self:dealConfirmRelease()
      end,
      onClick_cancel = function(self)
        if C_InputManager.IsEnableGamePad and self.bindComponents.navMgr and self.bindComponents.navMgr.navigationEnabled then
          self.bindComponents.navMgr.navigationEnabled = false
          self:refreshShortKeyFlag()
          return
        end
        L_UI:close(self.pageName)
        if self.options.cancelCallback then
          self.options.cancelCallback()
        end
      end,
      onClick_close = function(self)
        L_UI:close(self.pageName)
        if self.options.cancelCallback then
          self.options.cancelCallback()
        end
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
        if self.options.cancelCallback then
          self.options.cancelCallback()
        end
      end
    }
  }
end

function this:dealConfirmRelease()
  if self.bindComponents.navMgr and self.bindComponents.navMgr.navigationEnabled then
    return
  end
  self:reqPetRelease()
end

function this:reqPetRelease()
  local data = {
    pet_list = self.options.pets
  }
  self.closeReleaseMode = true
  local needCloseGetPet = self:checkCloseGetPet(data)
  if self.options.pets and table.containsValue(self.options.pets, L_PetReleaseManager.getLastSelectedPetId()) then
    L_PetReleaseManager.resetLastSelected()
  end
  L_PetStore:req_removePet(data, function()
    L_PetReleaseManager:setIsReleaseMode(false)
    L_UI:close(self.pageName)
    if self.options.confirmCallback then
      self.options.confirmCallback()
    end
    if needCloseGetPet then
      L_UI:close("pageGetPet")
    end
  end)
end

function this:checkCloseGetPet(data)
  local curGetPetGuid = L_PetManager.curGetPetGuid
  local petList = data.pet_list
  for i = 1, #petList do
    if petList[i] == curGetPetGuid then
      return true
    end
  end
  return false
end

function this:preOpen(options)
  L_PetReleaseManager:setIsReleaseMode(false, true)
  self.options = options
  table.sort(self.options.pets, function(a, b)
    local petA = L_PetStore:getPetItem(a)
    local petB = L_PetStore:getPetItem(b)
    return petA.box_id < petB.box_id
  end)
  self:initPage()
end

function this:open()
  self.closeReleaseMode = false
  self.isOpen = true
  self.isTop = true
  if self.bindComponents.navMgr then
    self.bindComponents.navMgr.navigationEnabled = false
  end
  self:registerShortCut()
  self:refreshShortKeyFlag()
end

function this:close()
  if not self.closeReleaseMode and not self.options.quickRelease then
    L_PetReleaseManager:setIsReleaseMode(true, true)
  end
  self.isOpen = false
  self.isTop = false
  self:unregisterShortCut()
  self:clearShortKeyFlag()
end

function this:escHandle()
  if C_InputManager.IsEnableGamePad and self.bindComponents.navMgr and self.bindComponents.navMgr.navigationEnabled then
    return
  end
  L_UI:close(self.pageName)
end

function this:initPage()
  local moduleTip = self.modules.tipboard
  moduleTip:initModule({
    txtTitle = L_WordsTpl:getValue("ui_pet_release_confirm_title")
  })
  self.currentChooseGuid = self.options.pets[1]
  self:initPetList()
  self:initRewardList()
end

function this:initRewardList()
  self.rewards = L_PetReleaseManager:calculateReleaseRewards(self.options.pets)
  self.bind.rewardList:clear()
  self.bind.rewardList:insert_array(self.rewards)
  self.bind.rewardsListActive = #self.rewards > 0
  self.bind.emptyTipActive = #self.rewards == 0
end

function this:initPetList()
  if not self.isBind then
    return
  end
  
  local function onClick_Choose(cell)
    self:onClickCell(cell)
  end
  
  local lst = {}
  for i = 1, #self.options.pets do
    local cell = {}
    cell.guid = self.options.pets[i]
    cell.itemType = L_Const.resType.pet
    cell.callback = onClick_Choose
    cell.filterType = L_PetConst.filterPetBox.grade
    cell.choice = false
    table.insert(lst, cell)
  end
  self.bind.petList:clear()
  self.bind.petScrollList:clear()
  if #self.options.pets > 8 then
    self.bind.petScrollList:insert_array(lst)
    self.bind.toggle_petListAlignLeft = true
  else
    self.bind.petList:insert_array(lst)
    self.bind.toggle_petListAlignLeft = false
  end
end

function this:onClickCell(cell)
  local guid = cell.bind.guid
  L_UI:open("pageTipBubble", {
    data = {
      propertyPath,
      propetyLuaPath,
      {
        guid = guid,
        arrowActive = false,
        isShow = true
      },
      cell.gameObject.transform,
      2,
      false,
      0,
      C_Vector2(10, 10),
      C_Vector2(60, 60),
      nil,
      true,
      nil,
      {2, 0}
    }
  })
end

function this:onTopChange(options)
  if not self.isOpen then
    return
  end
  local preIsTop = self.isTop
  local curPageName = L_UI:currentPage(L_UI.groupKeys.stack)
  self.isTop = self.pageName == curPageName
  if preIsTop ~= self.isTop then
    C_InputManager.SetGamepadUIInputMap(self.pageName, self.isTop)
  end
end

function this:registerShortCut()
  C_InputManager.SetGamepadUIInputMap(self.pageName, true)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPagePetReleaseConfirmFocusOnPetList, function()
    if not self.isTop then
      return
    end
    if self.bindComponents.navMgr and not self.bindComponents.navMgr.navigationEnabled then
      self.bindComponents.navMgr.navigationEnabled = true
      self.bindComponents.navMgr:DisableAllArea(true)
      self.bindComponents.navMgr:SelectArea("AreaPetList")
      self:refreshShortKeyFlag()
    end
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPagePetReleaseConfirmFocusOnRewardList, function()
    if not self.isTop then
      return
    end
    if self.bindComponents.navMgr and not self.bindComponents.navMgr.navigationEnabled then
      self.bindComponents.navMgr.navigationEnabled = true
      self.bindComponents.navMgr:DisableAllArea(true)
      self.bindComponents.navMgr:SelectArea("AreaItemList")
      self:refreshShortKeyFlag()
    end
  end)
end

function this:unregisterShortCut()
  L_ShortCutManager:unregisterShortCut(self.pageName, C_InputManager_KeyType.EPagePetReleaseConfirmFocusOnPetList)
  L_ShortCutManager:unregisterShortCut(self.pageName, C_InputManager_KeyType.EPagePetReleaseConfirmFocusOnRewardList)
  C_InputManager.SetGamepadUIInputMap(self.pageName, false)
end

function this:refreshShortKeyFlag()
  if self.bindComponents.navMgr then
    L_ShortCutManager:removeShortKeyFlag(self, "PagePetReleaseConfirm_FocusOnPetList")
    L_ShortCutManager:removeShortKeyFlag(self, "PagePetReleaseConfirm_FocusOnRewardList")
    if not self.bindComponents.navMgr.navigationEnabled then
      L_ShortCutManager:addShortKeyFlag(self, "PagePetReleaseConfirm_FocusOnPetList", L_Const.AnchorType.Middle, self.bindComponents.rect_imgArrow, L_Vector3.new(-835, 0), 1.3)
      L_ShortCutManager:addShortKeyFlag(self, "PagePetReleaseConfirm_FocusOnRewardList", L_Const.AnchorType.Middle, self.bindComponents.rect_imgArrow, L_Vector3.new(55, 0), 1.3)
    end
  end
end

function this:clearShortKeyFlag()
  L_ShortCutManager:clearShortKeyFlag(self)
end

return this
