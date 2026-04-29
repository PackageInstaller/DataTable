_class("UIN25VampireLevelInfoItem", UICustomWidget)
UIN25VampireLevelInfoItem = UIN25VampireLevelInfoItem

function UIN25VampireLevelInfoItem:Constructor()
  self.mCampaign = self:GetModule(CampaignModule)
end

function UIN25VampireLevelInfoItem:OnShow(uiParams)
  self._atlas = self:GetAsset("UIN25VampireTaskAndLevel.spriteatlas", LoadType.SpriteAtlas)
  self.iconimg = self:GetUIComponent("Image", "icon")
  self.contenttxt = self:GetUIComponent("UILocalizationText", "contenttxt")
end

function UIN25VampireLevelInfoItem:OnHide()
end

function UIN25VampireLevelInfoItem:Flush(data, callback)
  self.callback = callback
  self.data = data
  self.contenttxt:SetText(StringTable.Get(self.data.MissionDec))
end

function UIN25VampireLevelInfoItem:IconOnClick(go)
  if self.callback then
    self.callback()
  end
end
