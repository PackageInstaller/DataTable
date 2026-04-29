_class("UIFavourPetVote2Detail", UIController)
UIFavourPetVote2Detail = UIFavourPetVote2Detail

function UIFavourPetVote2Detail:OnShow(uiParams)
  local component = uiParams and uiParams[1]
  local voteId = uiParams and uiParams[2]
  local cfg = UIFavourPetHelper.GetSkinInfo(component, voteId)
  if cfg then
    local skinName = cfg.SkinName
    UIWidgetHelper.SetLocalizationText(self, "_name", StringTable.Get(skinName))
    local skinDesc = cfg.SkinDesc
    UIWidgetHelper.SetLocalizationText(self, "_desc", StringTable.Get(skinDesc))
    local skinImg = cfg.SkinIntroImg
    UIWidgetHelper.SetRawImage(self, "_introImg", skinImg)
  end
end

function UIFavourPetVote2Detail:OnHide()
end

function UIFavourPetVote2Detail:CloseBtnOnClick()
  self:_CloseDialogWithAnim()
end

function UIFavourPetVote2Detail:_CloseDialogWithAnim(callback)
  UIWidgetHelper.PlayAnimation(self, "_anim", "uianim_UIFavourPetVote2Detail_out", 433, function()
    if callback then
      callback()
    end
    self:CloseDialog()
  end)
end
