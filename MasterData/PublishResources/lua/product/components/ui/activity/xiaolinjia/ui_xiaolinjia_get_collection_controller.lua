_class("UIXiaoLinJiaGetCollectionController", UIController)
UIXiaoLinJiaGetCollectionController = UIXiaoLinJiaGetCollectionController

function UIXiaoLinJiaGetCollectionController:OnShow(uiParams)
  self.atlas = self:GetAsset("XiaoLinJia.spriteatlas", LoadType.SpriteAtlas)
  self.callback = uiParams[1]
  self.cfg = uiParams[2]
  self.headIcon = uiParams[3]
  self.roleName = uiParams[4]
  self.collectionImage = self:GetUIComponent("Image", "collectionImage")
  self.headIconImage = self:GetUIComponent("Image", "headIcon")
  self.collectionRoleSpeakingText = self:GetUIComponent("UILocalizationText", "collectionRoleSpeakingText")
  self.collectionDesc = self:GetUIComponent("UILocalizationText", "collectionDesc")
  self.anim = self:GetUIComponent("Animation", "anim")
  self:OnValue()
end

function UIXiaoLinJiaGetCollectionController:OnValue()
  self.collectionImage.sprite = self.atlas:GetSprite(self.cfg.Icon)
  self.headIconImage.sprite = self.atlas:GetSprite(self.headIcon)
  self.collectionRoleSpeakingText:SetText(StringTable.Get("str_xiaolinjia_text_gift_1", self.roleName))
  self.collectionDesc:SetText(StringTable.Get(self.cfg.UnlockName))
end

function UIXiaoLinJiaGetCollectionController:CloseBtnOnClick()
  self:Lock("UIXiaoLinJiaRewardController_Close")
  self.anim:Play("uieffanim_UIXiaoLinJiaGetCollectionController_out")
  self:StartTask(function(TT)
    YIELD(TT, 500)
    if self.callback then
      self.callback()
    end
    self:CloseDialog()
    self:UnLock("UIXiaoLinJiaRewardController_Close")
  end)
end
