_class("UIAssetComponentLevel", UIAssetComponentBase)
UIAssetComponentLevel = UIAssetComponentLevel

function UIAssetComponentLevel:OnInit()
  self._levelObj = self._gameObject.transform:Find("g_level").gameObject
  self._levelTxt = self._gameObject.transform:Find("g_level/et_levelnum"):GetComponent("UILocalizationText")
end

function UIAssetComponentLevel:ShowLevel(show)
  self._levelObj:SetActive(show)
end

function UIAssetComponentLevel:SetLevel(level)
  if level < 0 then
    self:ShowLevel(false)
  else
    self:ShowLevel(true)
    self._levelTxt:SetText(level)
  end
end
