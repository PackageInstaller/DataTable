_class("UISeasonShowNormalAwardS6", UIController)
UISeasonShowNormalAwardS6 = UISeasonShowNormalAwardS6

function UISeasonShowNormalAwardS6:GetComponents()
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._img = self:GetUIComponent("RawImageLoader", "Img")
end

function UISeasonShowNormalAwardS6:OnShow(uiParams)
  self._closeCallback = uiParams[2]
  self:GetComponents()
  local item_module = GameGlobal.GetModule(ItemModule)
  if not uiParams[1] then
    Log.fatal("###[UISeasonShowCollectionAward] uiParams[1] is nil !")
  end
  self.roleAsset = uiParams[1]
  self:ShowEvidenceInfo()
end

function UISeasonShowNormalAwardS6:ShowEvidenceInfo()
  if self.roleAsset then
    local assetid = self.roleAsset.assetid
    local cfg = Cfg.cfg_item[assetid]
    if not cfg then
      Log.error("###[UISeasonShowNormalAwardS6] cfg is nil ! id : ", assetid)
    end
    local icon = cfg.Icon
    local name = cfg.Name
    local desc = cfg.Intro
    self._title:SetText(StringTable.Get(name))
    self._img:LoadImage(icon)
    self._desc:SetText(StringTable.Get(desc))
  end
end

function UISeasonShowNormalAwardS6:ClosePanel()
  self:CloseDialog()
end

function UISeasonShowNormalAwardS6:OnHide()
  if self._closeCallback then
    self._closeCallback()
  end
end

function UISeasonShowNormalAwardS6:BgOnClick(go)
  self:ClosePanel()
end

function UISeasonShowNormalAwardS6:CloseBtnOnClick(go)
  self:ClosePanel()
end
