_class("UIFavourPetVote2Item", UICustomWidget)
UIFavourPetVote2Item = UIFavourPetVote2Item

function UIFavourPetVote2Item:SetData(campaign, component, voteId, isChampion, clickCallback)
  self._campaign = campaign
  self._component = component
  self._voteId = voteId
  self._clickCallback = clickCallback
  self:_SetCrown(isChampion)
  self:_SetName(voteId)
  self:_SetCg(voteId)
  self:_SetVote(voteId)
end

function UIFavourPetVote2Item:PlayAnimationInSequence(index)
  local animName, duration = "uieff_UIFavourPet_Vote2_Item_in", 1167
  local delay = index * 100
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_root", animName, delay, duration, nil, true)
end

function UIFavourPetVote2Item:_SetCrown(isShow)
  isShow = isShow or false
  self:GetGameObject("_crown"):SetActive(isShow)
end

function UIFavourPetVote2Item:_SetName(voteId)
  local petName = ""
  local skinName = ""
  local cfg = UIFavourPetHelper.GetSkinInfo(self._component, voteId)
  if cfg then
    skinName = StringTable.Get(cfg.SkinName)
    petName = UIFavourPetHelper.GetPetName(cfg.PetId)
  end
  UIWidgetHelper.SetLocalizationText(self, "_petName", petName)
  UIWidgetHelper.SetLocalizationText(self, "_skinName", skinName)
end

function UIFavourPetVote2Item:_SetCg(voteId)
  local widgetName = "_skinCg"
  local info = UIFavourPetHelper.GetPetCgInfo(self._component, voteId)
  local isShow = info ~= nil
  self:GetGameObject(widgetName):SetActive(isShow)
  if isShow then
    local trans = self:GetUIComponent("RectTransform", widgetName)
    trans.sizeDelta = info.size
    trans.localScale = info.scale
    trans.anchoredPosition = info.pos
    local rawImageName = info.rawImageName
    if not string.isnullorempty(rawImageName) then
      UIWidgetHelper.SetRawImage(self, widgetName, rawImageName)
    end
  end
end

function UIFavourPetVote2Item:_SetVote(voteId)
  local isVoted = UIFavourPetHelper.NotEnoughVoteItem(self._component)
  local myVote = self._component:GetPetVote(voteId)
  local tb = {
    [1] = "str_favour_pet_vote",
    [2] = "str_favour_pet_vote_finish"
  }
  local strId = isVoted and myVote ~= 0 and tb[2] or tb[1]
  UIWidgetHelper.SetLocalizationText(self, "_txtVoteBtn", StringTable.Get(strId))
  local totalVote = self._component:GetZonePetVote(voteId)
  UIWidgetHelper.SetLocalizationText(self, "_totalVote", totalVote)
end

function UIFavourPetVote2Item:DetailBtnOnClick(go)
  self:ShowDialog("UIFavourPetVote2Detail", self._component, self._voteId)
end

function UIFavourPetVote2Item:BtnOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._voteId)
  end
end
