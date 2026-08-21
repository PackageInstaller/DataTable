_class("UIPetBackPackBox", UIController)
UIPetBackPackBox = UIPetBackPackBox

function UIPetBackPackBox:OnShow(uiParams)
  self._item = uiParams[1]
  self._previewMode = uiParams[2] and true or false
  if not self._item then
    return
  end
  if self._previewMode then
    local itemId = self._item
    self._item_templateID = itemId
    self._item_template = Cfg.cfg_item[itemId]
  else
    self._item_templateID = self._item:GetTemplateID()
    self._item_template = self._item:GetTemplate()
  end
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self._currentSelcetItem = nil
  local lst = self:GetItemList(self._item_templateID)
  self._itemIdList = {}
  for i, item in ipairs(lst) do
    self._itemIdList[#self._itemIdList + 1] = item[1]
  end
  self._have = {}
  self._notHave = {}
  for _, petID in ipairs(self._itemIdList) do
    local petModule = GameGlobal.GameLogic():GetModule(PetModule)
    if petModule:HasPet(petID) then
      table.insert(self._have, petID)
    else
      table.insert(self._notHave, petID)
    end
  end
  local petList = {
    [1] = {
      self._notHave,
      false
    },
    [2] = {
      self._have,
      true
    }
  }
  local petItemLoader = self:GetUIComponent("UISelectObjectPath", "Content")
  local petItemLoaderRect = self:GetUIComponent("RectTransform", "Content")
  local list = petItemLoader:SpawnObjects("UIPetBackPackBoxList", #petList)
  for i = 1, #list do
    list[i]:SetData(petList[i], self, self._scrollRect, self._previewMode)
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(petItemLoaderRect)
  self._nameLabel:SetText(StringTable.Get(self._item_template.Name))
  local strId = self._previewMode and "str_item_select_pet_select_tips_preview" or "str_item_select_pet_select_tips"
  UIWidgetHelper.SetLocalizationText(self, "Tips", StringTable.Get(strId))
  self:GetGameObject("BtnConfirm"):SetActive(not self._previewMode)
end

function UIPetBackPackBox:GetItemList(itemGiftID)
  local cfgItemGift = Cfg.cfg_item_gift[itemGiftID]
  if not cfgItemGift then
    return 0
  end
  local lst = cfgItemGift.ItemList
  return lst
end

function UIPetBackPackBox:SelectPetItem(selectItem)
  if self._currentSelcetItem == selectItem then
    return
  end
  if self._currentSelcetItem ~= nil then
    self._currentSelcetItem:RefreshSelectStatus(false)
  end
  self._currentSelcetItem = selectItem
  self._currentSelcetItem:RefreshSelectStatus(true)
end

function UIPetBackPackBox:MaskOnClick()
  self:CloseDialog()
end

function UIPetBackPackBox:BtnSelectOnClick()
  if self._previewMode then
    return
  end
  if self._currentSelcetItem == nil then
    return
  end
  self:ShowDialog("UIPetBackPackConfirm", self._item, self._currentSelcetItem:GetItemId(), function()
    GameGlobal.TaskManager():StartTask(self.UseItem, self, self._item, self._currentSelcetItem:GetItemId())
  end)
end

function UIPetBackPackBox:UseItem(TT, itemData, petId)
  local petModule = self:GetModule(PetModule)
  petModule:GetAllPetsSnapshoot()
  local index = self:GetPetItemIndex(petId)
  if index < 0 then
    Log.error("Find petid error")
    return
  end
  self:Lock("UIPetBackPackBox_UseItem")
  local itemModule = GameGlobal.GetModule(ItemModule)
  local res = itemModule:RequestChooseGift(TT, itemData:GetID(), index, 1)
  self:UnLock("UIPetBackPackBox_UseItem")
  if res:GetSucc() then
    local tempPets = {}
    local ra = RoleAsset:New()
    ra.assetid = petId
    ra.count = 1
    tempPets[#tempPets + 1] = ra
    self:ShowDialog("UIPetObtain", tempPets, function()
      self:CloseDialog()
      GameGlobal.UIStateManager():CloseDialog("UIPetBackPackConfirm")
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
    end)
  else
    Log.error("Use Item failed : ", self._item_templateID, " ret = ", res:GetResult())
  end
end

function UIPetBackPackBox:GetPetItemIndex(petId)
  local lst = self:GetItemList(self._item_templateID)
  for i, item in ipairs(lst) do
    if petId == item[1] then
      return i - 1
    end
  end
  return -1
end
