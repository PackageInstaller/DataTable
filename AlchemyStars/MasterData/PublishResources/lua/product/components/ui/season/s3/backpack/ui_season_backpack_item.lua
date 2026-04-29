_class("UISeasonBackpackItem", UICustomWidget)
UISeasonBackpackItem = UISeasonBackpackItem

function UISeasonBackpackItem:OnShow(uiParams)
  self._atlas = self:GetAsset("UIS3Stage.spriteatlas", LoadType.SpriteAtlas)
  self:InitWidget()
end

function UISeasonBackpackItem:InitWidget()
  self._quality = self:GetUIComponent("Image", "Quality")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._count = self:GetUIComponent("UILocalizationText", "Count")
  self._typeImg = self:GetUIComponent("Image", "TypeImg")
  self._typeImgGO = self:GetGameObject("TypeImg")
  self._gotGO = self:GetGameObject("Got")
end

function UISeasonBackpackItem:SetData(id, data, callback)
  self._id = id
  self._itemid = data.id
  self._itemCount = data.count
  self._callback = callback
  self:_OnValue()
end

function UISeasonBackpackItem:_OnValue()
  local cfg = Cfg.cfg_item[self._itemid]
  if cfg == nil then
    Log.fatal("cfg_item is nil." .. self._itemid)
  end
  self._quality.sprite = self._atlas:GetSprite("exp_s3_map_gq_se0" .. tostring(cfg.Color))
  self._icon:LoadImage(cfg.Icon)
  self._name:SetText(StringTable.Get(cfg.Name))
  self._count:SetText("x" .. self._itemCount)
  self._typeImg.sprite = self._atlas:GetSprite("exp_s3_map_gq_icon12")
  local isDone = self:GetModule(SeasonModule):GetHasPassedDebris(self._id)
  self._typeImgGO:SetActive(not isDone)
  self._gotGO:SetActive(isDone)
end

function UISeasonBackpackItem:BtnOnClick(go)
  if self._callback then
    self._callback(self._itemid, go.transform.position)
  end
end
