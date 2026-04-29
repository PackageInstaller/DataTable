_class("UIEliminateSupportCampLevelGroup", UICustomWidget)
UIEliminateSupportCampLevelGroup = UIEliminateSupportCampLevelGroup

function UIEliminateSupportCampLevelGroup:OnShow(uiParams)
  self._campIconTxt = "qdhl_new_logo0"
  self:_GetComponents()
end

function UIEliminateSupportCampLevelGroup:_GetComponents()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._icon = self:GetUIComponent("Image", "Icon")
  self._content = self:GetUIComponent("UISelectObjectPath", "content")
end

function UIEliminateSupportCampLevelGroup:SetData(tagTb)
  self._tagTb = tagTb
  local tagCfg = Cfg.cfg_pet_tags[self._tagTb[1].Tag]
  local tagText = tagCfg.Name
  if tagCfg.ID == 1007 then
    self._icon.gameObject:SetActive(false)
  else
    self._icon.sprite = self.uiOwner.atlas:GetSprite(EliminateHelper.GetCampIcon(tagCfg.ID))
  end
  self._title:SetText(StringTable.Get(tagText))
  local campItems = self._content:SpawnObjects("UIEliminateSupportCampLevelInfo", table.count(self._tagTb))
  for i, item in pairs(campItems) do
    item:SetData(self._tagTb[i])
  end
end
