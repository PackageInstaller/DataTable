_class("UIFavourPetVote2Confirm", UIController)
UIFavourPetVote2Confirm = UIFavourPetVote2Confirm

function UIFavourPetVote2Confirm:OnShow(uiParams)
  local component = uiParams and uiParams[1]
  local voteId = uiParams and uiParams[2]
  self._callback = uiParams and uiParams[3]
  local cfg = UIFavourPetHelper.GetSkinInfo(component, voteId)
  if cfg then
    local skinName = cfg.SkinName
    UIWidgetHelper.SetLocalizationText(self, "_name", StringTable.Get(skinName))
  end
end

function UIFavourPetVote2Confirm:OnHide()
end

function UIFavourPetVote2Confirm:ConfirmBtnOnClick()
  self:_CloseDialogWithAnim(self._callback)
end

function UIFavourPetVote2Confirm:CancelBtnOnClick()
  self:_CloseDialogWithAnim()
end

function UIFavourPetVote2Confirm:_CloseDialogWithAnim(callback)
  UIWidgetHelper.PlayAnimation(self, "_anim", "uianim_UIFavourPetVote2Confirm_out", 467, function()
    if callback then
      callback()
    end
    self:CloseDialog()
  end)
end
