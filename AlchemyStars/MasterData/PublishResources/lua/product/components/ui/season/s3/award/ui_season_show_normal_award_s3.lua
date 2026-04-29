_class("UISeasonShowNormalAwardS3", UIController)
UISeasonShowNormalAwardS3 = UISeasonShowNormalAwardS3

function UISeasonShowNormalAwardS3:GetComponents()
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._img = self:GetUIComponent("RawImageLoader", "Img")
end

function UISeasonShowNormalAwardS3:OnShow(uiParams)
  self._closeCallback = uiParams[2]
  self:GetComponents()
  local item_module = GameGlobal.GetModule(ItemModule)
  if not uiParams[1] then
    Log.fatal("###[UISeasonShowCollectionAward] uiParams[1] is nil !")
  end
  self.roleAsset = uiParams[1]
  self:ShowEvidenceInfo()
end

function UISeasonShowNormalAwardS3:ShowEvidenceInfo()
  if self.roleAsset then
    local assetid = self.roleAsset.assetid
    local cfg = Cfg.cfg_item[assetid]
    if not cfg then
      Log.error("###[UISeasonShowNormalAwardS3] cfg is nil ! id : ", assetid)
    end
    local icon = cfg.Icon
    local name = cfg.Name
    local desc = cfg.Intro
    self._title:SetText(StringTable.Get(name))
    self._img:LoadImage(icon)
    self._desc:SetText(StringTable.Get(desc))
  end
end

function UISeasonShowNormalAwardS3:ClosePanel()
  self:CloseDialog()
end

function UISeasonShowNormalAwardS3:OnHide()
  if self._closeCallback then
    self._closeCallback()
  end
end

function UISeasonShowNormalAwardS3:BgOnClick(go)
  self:ClosePanel()
end

function UISeasonShowNormalAwardS3:CloseBtnOnClick(go)
  self:ClosePanel()
end
