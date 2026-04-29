_class("UILostLandMissionInfoItem", UICustomWidget)
UILostLandMissionInfoItem = UILostLandMissionInfoItem

function UILostLandMissionInfoItem:OnShow(uiParams)
  self:GetComponents()
end

function UILostLandMissionInfoItem:Active(active)
  self._go:SetActive(active)
end

function UILostLandMissionInfoItem:bgOnClick(go)
  if self._callback then
    self._callback(self._id, go.transform.position)
  end
end

function UILostLandMissionInfoItem:SetData(idx, petAwardCount, callback)
  self._idx = idx
  self._callback = callback
  self._id = GameGlobal.GetUIModule(LostAreaModule):GetPetAwardInfo().assetid
  local cfg_item = Cfg.cfg_item[self._id]
  if not cfg_item then
    Log.error("###[UILostLandMissionInfoItem] cfg_item is nil ! id --> ", self._id)
  end
  self._idxTex:SetText(self._idx)
  self._iconImg:LoadImage(cfg_item.Icon)
  if idx <= petAwardCount then
    self._got:SetActive(true)
  else
    self._got:SetActive(false)
  end
end

function UILostLandMissionInfoItem:GetComponents()
  self._go = self:GetGameObject("rect")
  self._iconImg = self:GetUIComponent("RawImageLoader", "icon")
  self._got = self:GetGameObject("get")
  self._idxTex = self:GetUIComponent("UILocalizationText", "idx")
end
