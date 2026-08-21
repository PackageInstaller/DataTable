_class("UIAssetComponentNew", UIAssetComponentBase)
UIAssetComponentNew = UIAssetComponentNew

function UIAssetComponentNew:OnInit()
  self._redObj = self._gameObject.transform:Find("new").gameObject
end

function UIAssetComponentNew:SetNew(active)
  self._redObj:SetActive(active)
end
