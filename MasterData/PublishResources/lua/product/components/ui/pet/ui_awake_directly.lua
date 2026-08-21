_class("UIAwakeDirectly", UIController)
UIAwakeDirectly = UIAwakeDirectly

function UIAwakeDirectly:OnShow(uiParams)
  self:InitWidget()
  self._itemData = uiParams[1]
  self._itemOnUse = uiParams[2]
  if not self._itemData then
    Log.exception("直升物品为空")
  end
  if not self._itemData:IsAwakeDirectlyItem() then
    Log.exception("该物品不是觉醒直升道具")
  end
  self._petMd = self:GetModule(PetModule)
  self._itemMd = self:GetModule(ItemModule)
  local paramStr = self._itemData:GetTemplate().UseEffect
  local params = string.split(paramStr, ",")
  local awake = tonumber(params[2])
  local level = tonumber(params[3])
  local icons = {
    [1] = "spirit_juexing3_sml1",
    [2] = "spirit_juexing3_sml2",
    [3] = "spirit_juexing3_sml3"
  }
  self.awakeIcon.sprite = self:GetAsset("UIAwakeDirectly.spriteatlas", LoadType.SpriteAtlas):GetSprite(icons[awake])
  self.tip:RefreshText(StringTable.Get("str_pet_detail_awake_directly_tip", awake, level))
  self._awake = awake
  self._level = level
  local pets = {}
  local allPets = self._petMd:GetPets()
  for pstID, pet in pairs(allPets) do
    if awake <= pet:GetMaxGrade() and awake > pet:GetPetGrade() then
      pets[#pets + 1] = pet
    end
  end
  table.sort(pets, function(a, b)
    local p1 = a
    local p2 = b
    if p1:GetPetStar() ~= p2:GetPetStar() then
      return p1:GetPetStar() > p2:GetPetStar()
    end
    if p1:GetPetFirstElement() ~= p2:GetPetFirstElement() then
      return p1:GetPetFirstElement() < p2:GetPetFirstElement()
    end
    return p1:GetTemplateID() < p2:GetTemplateID()
  end)
  if #pets == 0 then
    Log.warn("直升材料没有符合条件的星灵:", self._itemID)
  end
  self._noneTip:SetActive(#pets == 0)
  self._pets = pets
  self._raw = 6
  local count = math.ceil(#pets / self._raw)
  self._curPet = nil
  
  function self._onClickCard(pstID)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSelectUIHeartItem, pstID)
    if self._curPet == pstID then
      return
    end
    self._curPet = pstID
  end
  
  self.scrollView:InitListView(count, function(_scrollView, _index)
    return self:newRaw(_scrollView, _index)
  end)
end

function UIAwakeDirectly:InitWidget()
  self.tip = self:GetUIComponent("RollingText", "tip")
  self.scrollView = self:GetUIComponent("UIDynamicScrollView", "Scroll View")
  self.awakeIcon = self:GetUIComponent("Image", "awakeIcon")
  self._noneTip = self:GetGameObject("noneTip")
end

function UIAwakeDirectly:newRaw(_scrollView, _index)
  if _index < 0 then
    return nil
  end
  local item = _scrollView:NewListViewItem("raw")
  item.gameObject.transform.localScale = Vector3(0.8, 0.8, 0.8)
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  local idx = _index * self._raw + 1
  local count = math.min(#self._pets - idx + 1, self._raw)
  local items = rowPool:SpawnObjects("UIAwakeDirectItem", count)
  for i = 1, count do
    local data = self._pets[idx + i - 1]
    items[i]:SetData(data, self._onClickCard, false, true, TeamOpenerType.Main, PetSkinEffectPath.CARD_PET_LIST, self._curPet == data:GetPstID())
  end
  return item
end

function UIAwakeDirectly:ButtonOnClick(go)
  if not self._curPet then
    ToastManager.ShowToast(StringTable.Get("str_pet_detail_awake_directly_choose_pet"))
    return
  end
  local itemName = StringTable.Get(self._itemData:GetTemplate().Name)
  local petName = StringTable.Get(self._petMd:GetPet(self._curPet):GetPetName())
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_pet_detail_awake_directly_confirm", itemName, petName, self._awake, self._level), function(param)
    Log.error("使用直升道具:", self._itemData:GetTemplateID())
    self._itemOnUse(self._itemData, self._curPet)
    self:CloseDialog()
    ToastManager.ShowToast(StringTable.Get("str_pet_detail_awake_directly_success", petName, self._awake, self._level))
  end, nil, function(param)
  end, nil)
end

function UIAwakeDirectly:BlankOnClick(go)
  self:CloseDialog()
end
