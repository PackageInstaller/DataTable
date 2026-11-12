local ConsumableItemTipsCtrl = class("ConsumableItemTipsCtrl", BaseCtrl)
ConsumableItemTipsCtrl._mapNodeConfig = {
  TipsContent = {
    sComponentName = "RectTransform"
  },
  TMPItemTitle = {sComponentName = "TMP_Text"},
  TMPItemCount = {sComponentName = "TMP_Text"},
  TMPSubTitle = {sComponentName = "TMP_Text"},
  TMPItemDesc = {sComponentName = "TMP_Text"},
  rtJumptoContent = {
    sComponentName = "RectTransform"
  },
  goJumptoGrid = {},
  rtJumpTo = {
    sComponentName = "RectTransform"
  },
  srDesc = {
    sComponentName = "RectTransform"
  },
  rtDescContent = {
    sComponentName = "RectTransform"
  }
}
ConsumableItemTipsCtrl._mapEventConfig = {}

function ConsumableItemTipsCtrl:Awake()
end

function ConsumableItemTipsCtrl:FadeIn()
end

function ConsumableItemTipsCtrl:FadeOut()
end

function ConsumableItemTipsCtrl:Refresh(nTid)
  self.mapData = {nTid = nTid, bShowDepot = true}
  self._mapJumpto = {}
  self._mapNode.goJumptoGrid:SetActive(false)
  local mapItemCfgData = ConfigTable.GetData_Item(self.mapData.nTid)
  if mapItemCfgData == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPItemTitle, mapItemCfgData.Title)
  if mapItemCfgData.Desc then
    if mapItemCfgData.Literary and mapItemCfgData.Literary ~= "" then
      NovaAPI.SetTMPText(self._mapNode.TMPItemDesc, mapItemCfgData.Desc .. [[

<color=#5E89B4>]] .. mapItemCfgData.Literary .. "</color>")
    else
      NovaAPI.SetTMPText(self._mapNode.TMPItemDesc, mapItemCfgData.Desc)
    end
  elseif mapItemCfgData.Literary and mapItemCfgData.Literary ~= "" then
    NovaAPI.SetTMPText(self._mapNode.TMPItemDesc, mapItemCfgData.Literary)
  else
    NovaAPI.SetTMPText(self._mapNode.TMPItemDesc, "")
  end
  if self.mapData.bShowDepot then
    local nItemDepotCount = 0
    if self.mapData.nTid == AllEnum.CoinItemId.FREESTONE or self.mapData.nTid == AllEnum.CoinItemId.STONE then
      nItemDepotCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.FREESTONE) + PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.STONE)
    else
      nItemDepotCount = PlayerData.Item:GetItemCountByID(self.mapData.nTid)
    end
    self._mapNode.TMPItemCount.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.TMPItemCount, orderedFormat(ConfigTable.GetUIText("ItemTip_DepotCount"), nItemDepotCount))
  else
    self._mapNode.TMPItemCount.gameObject:SetActive(false)
  end
  local sLanguage = "ItemStype_" .. mapItemCfgData.Stype
  NovaAPI.SetTMPText(self._mapNode.TMPSubTitle, ConfigTable.GetUIText(sLanguage) or "")
  self._mapNode.rtJumpTo.gameObject:SetActive(false)
end

function ConsumableItemTipsCtrl:OnDestroy()
end

function ConsumableItemTipsCtrl:OnRelease()
end

return ConsumableItemTipsCtrl
