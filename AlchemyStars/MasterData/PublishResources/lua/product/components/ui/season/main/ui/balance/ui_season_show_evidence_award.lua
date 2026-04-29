_class("UISeasonShowEvidenceAward", UIController)
UISeasonShowEvidenceAward = UISeasonShowEvidenceAward

function UISeasonShowEvidenceAward:GetComponents()
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._img = self:GetUIComponent("RawImageLoader", "Img")
  self._atlas = self:GetAsset("UIS2Balance.spriteAtlas", LoadType.SpriteAtlas)
  self._type2img = {}
  self._type2name = {}
end

function UISeasonShowEvidenceAward:OnShow(uiParams)
  self._closeCallback = uiParams[2]
  self:GetComponents()
  local item_module = GameGlobal.GetModule(ItemModule)
  if not uiParams[1] then
    Log.fatal("###[UISeasonShowCollectionAward] uiParams[1] is nil !")
  end
  self.roleAsset = uiParams[1]
  self:ShowEvidenceInfo()
end

function UISeasonShowEvidenceAward:ShowEvidenceInfo()
  if self.roleAsset then
    local assetid = self.roleAsset.assetid
    local cfg = Cfg.cfg_item[assetid]
    if not cfg then
      Log.error("###[UISeasonShowEvidenceAward] cfg is nil ! id : ", assetid)
    end
    local icon = cfg.Icon
    local name = cfg.Name
    local desc = cfg.Intro
    self._title:SetText(StringTable.Get(name))
    self._img:LoadImage(icon)
    self._desc:SetText(StringTable.Get(desc))
  end
end

function UISeasonShowEvidenceAward:ClosePanel()
  self:CloseDialog()
end

function UISeasonShowEvidenceAward:OnHide()
  if self._closeCallback then
    self._closeCallback()
  end
end

function UISeasonShowEvidenceAward:BgOnClick(go)
  self:ClosePanel()
end

function UISeasonShowEvidenceAward:CloseBtnOnClick(go)
  self:ClosePanel()
end
