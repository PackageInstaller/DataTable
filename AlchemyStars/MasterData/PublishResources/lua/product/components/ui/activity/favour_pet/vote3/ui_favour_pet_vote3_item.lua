_class("UIFavourPetVote3Item", UICustomWidget)
UIFavourPetVote3Item = UIFavourPetVote3Item

function UIFavourPetVote3Item:SetData(campaign, component, petId, isChampion, clickCallback)
  self._campaign = campaign
  self._component = component
  self._petId = petId
  self._clickCallback = clickCallback
  self:_SetCrown(isChampion)
  self:_SetPet(petId)
  self:_SetPetCg(petId)
  self:_SetVote(petId)
end

function UIFavourPetVote3Item:PlayAnimationInSequence(index)
  local animName, duration = "uieff_UIFavourPet_Vote_Item_in", 400
  local delay = index * 66
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_root", animName, delay, duration, nil, false)
end

function UIFavourPetVote3Item:_SetCrown(isShow)
  isShow = isShow or false
  self:GetGameObject("_crown"):SetActive(isShow)
end

function UIFavourPetVote3Item:_SetPet(petId)
  local name = UIFavourPetHelper.GetPetName(petId)
  UIWidgetHelper.SetLocalizationText(self, "_petName", name)
  local atlas1, sprite1, atlas2, sprite2 = UIFavourPetHelper.GetPetFirstElement(petId)
  UIWidgetHelper.SetImageSprite(self, "_elementBox", atlas1, sprite1)
  UIWidgetHelper.SetImageSprite(self, "_element", atlas2, sprite2)
  local star = UIFavourPetHelper.GetPetStar(petId)
  UIWidgetHelper.SpawnObjects(self, "_star", "UICustomWidget", star)
end

function UIFavourPetVote3Item:_SetPetCg(petId)
  local info = UIFavourPetHelper.GetPetCgInfo(self._component, petId)
  local isShow = info ~= nil
  self:GetGameObject("_petCg"):SetActive(isShow)
  if isShow then
    local trans = self:GetUIComponent("RectTransform", "_petCg")
    trans.sizeDelta = info.size
    trans.localScale = info.scale
    trans.anchoredPosition = info.pos
    local rawImageName = info.rawImageName
    if not string.isnullorempty(rawImageName) then
      UIWidgetHelper.SetRawImage(self, "_petCg", rawImageName)
    end
  end
end

function UIFavourPetVote3Item:_SetVote(petId)
  local costItemId = self._component:GetVoteCostItemId()
  UIWidgetHelper.SetItemIcon(self, costItemId, "_costIcon")
  local totalVote = self._component:GetZonePetVote(petId)
  UIWidgetHelper.SetLocalizationText(self, "_totalVote", totalVote)
  local myVote = self._component:GetPetVote(petId)
  UIWidgetHelper.SetLocalizationText(self, "_myVote", StringTable.Get("str_favour_pet_vote_my_count", myVote))
  self:GetGameObject("_myVote"):SetActive(myVote ~= 0)
end

function UIFavourPetVote3Item:BtnOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._petId)
  end
end
