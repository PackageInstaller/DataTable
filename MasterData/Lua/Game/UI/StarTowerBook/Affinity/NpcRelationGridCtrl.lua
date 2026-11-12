local NpcRelationGridCtrl = class("NpcRelationGridCtrl", BaseCtrl)
NpcRelationGridCtrl._mapNodeConfig = {
  rtUnlock = {},
  rtLock = {},
  TMPStroyChp = {sComponentName = "TMP_Text"},
  TMPStroyName = {sComponentName = "TMP_Text"},
  TMPRewardCount = {sComponentName = "TMP_Text"},
  imgRewardIcon = {sComponentName = "Image"},
  TMPCond = {sComponentName = "TMP_Text"}
}
NpcRelationGridCtrl._mapEventConfig = {}
NpcRelationGridCtrl._mapRedDotConfig = {}

function NpcRelationGridCtrl:Awake()
end

function NpcRelationGridCtrl:FadeIn()
end

function NpcRelationGridCtrl:FadeOut()
end

function NpcRelationGridCtrl:OnEnable()
end

function NpcRelationGridCtrl:OnDisable()
end

function NpcRelationGridCtrl:OnDestroy()
end

function NpcRelationGridCtrl:OnRelease()
end

function NpcRelationGridCtrl:Refresh(mapPlot, mapPlotData)
  NovaAPI.SetTMPText(self._mapNode.TMPStroyChp, mapPlot.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPStroyName, mapPlot.Desc)
  NovaAPI.SetTMPText(self._mapNode.TMPRewardCount, "×" .. mapPlot.ItemQty)
  local mapItemCfgData = ConfigTable.GetData_Item(mapPlot.ItemId)
  if mapItemCfgData ~= nil then
    self._mapNode.imgRewardIcon.gameObject:SetActive(true)
    self:SetPngSprite(self._mapNode.imgRewardIcon, mapItemCfgData.Icon)
  else
    self._mapNode.imgRewardIcon.gameObject:SetActive(false)
  end
  local str = orderedFormat(ConfigTable.GetUIText("NPCAffinity_UnlockCnd") or "", mapPlot.AffinityLevel)
  NovaAPI.SetTMPText(self._mapNode.TMPCond, str)
  self._mapNode.TMPRewardCount.gameObject:SetActive(not PlayerData.StarTower:GetNpcPlotReceived(mapPlot.NPCId, mapPlot.Id))
  self._mapNode.rtUnlock:SetActive(mapPlot.AffinityLevel <= mapPlotData.Level)
  self._mapNode.rtLock:SetActive(mapPlot.AffinityLevel > mapPlotData.Level)
end

return NpcRelationGridCtrl
