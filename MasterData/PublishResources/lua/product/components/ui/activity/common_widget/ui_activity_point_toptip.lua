_class("UIActivityPointToptip", UICustomWidget)
UIActivityPointToptip = UIActivityPointToptip

function UIActivityPointToptip:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityPointToptip:InitWidget()
  self.icon = self:GetUIComponent("Image", "icon")
  self.text = self:GetUIComponent("UILocalizationText", "text")
end

function UIActivityPointToptip:SetData(camCpt, needCount)
  self._campComponent = camCpt
  local cmpID = self._campComponent:GetComponentCfgId()
  local campID = self._campComponent:GetComponentInfo().m_campaign_id
  self._campType = Cfg.cfg_campaign[campID].CampaignType
  local cfg = self._campComponent:GetActionPointConfig()
  if cfg == nil then
    Log.exception("cfg_component_action_point中找不到组件ID:", cmpID)
  end
  self._pointID = cfg.ItemID
  local module = self:GetModule(ItemModule)
  local count = module:GetItemCount(self._pointID)
  count = count or 0
  local ceiling = cfg.RegainMax
  local text
  if needCount > count then
    text = "<color=#00ffea>" .. count .. "</color>" .. " /" .. ceiling
  else
    text = count .. " /" .. ceiling
  end
  self.text:SetText(text)
  local itemCfg = Cfg.cfg_top_tips[self._pointID]
  if itemCfg == nil then
    Log.exception("cfg_top_tips中找不到配置:", self._pointID)
  end
  self.icon.sprite = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas):GetSprite(itemCfg.Icon)
end

function UIActivityPointToptip:itemOnClick(go)
  if self._campType == ECampaignType.CAMPAIGN_TYPE_SUMMER_I then
    self:ShowDialog("UIXH1PointDetail")
  elseif self._campType == ECampaignType.CAMPAIGN_TYPE_HALLOWEEN then
    Log.warn("N6不使用行动点")
  elseif self._campType == ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN then
    self:ShowDialog("UIEvePointDetail")
  elseif self._campType == ECampaignType.CAMPAIGN_TYPE_N9 then
    self:ShowDialog("UIActivityN9ActionPointDetail", self._campComponent:GetItemIcon())
  elseif self._campType == ECampaignType.CAMPAIGN_TYPE_N11 then
    self:ShowDialog("UIActivityN11ActionPointDetail", self._campComponent:GetItemReplaceIcon())
  elseif self._campType == ECampaignType.CAMPAIGN_TYPE_N14 then
    self:ShowDialog("UIActivityN14ActionPointDetail", self._campComponent:GetItemIcon())
  elseif self._campType == ECampaignType.CAMPAIGN_TYPE_N20 then
    self:ShowDialog("UIActivityN20ActionPointDetail", self._campComponent:GetItemIcon())
  else
    Log.exception("没有指定行动点详情界面")
  end
end
