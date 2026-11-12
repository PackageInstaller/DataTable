local SoldierPartnerListCtrl = class("SoldierPartnerListCtrl", BaseCtrl)
local iconPath = "Icon/SoldierOtherIcon/"
local partnerPath = "Icon/SoldierPartner/"
SoldierPartnerListCtrl._mapNodeConfig = {
  sv_partner = {
    sNodeName = "PartnerContainer",
    sComponentName = "LoopScrollView"
  }
}
SoldierPartnerListCtrl._mapEventConfig = {
  SoldierPartnerTrace = "OnEvent_SoldierPartnerTrace",
  SoldierPartnerNewActive = "OnEvent_SoldierPartnerNewActive"
}
SoldierPartnerListCtrl._mapRedDotConfig = {}

function SoldierPartnerListCtrl:SetData(tbPartner)
  self.tbPartner = tbPartner
  self:RefreshPartnerList()
end

function SoldierPartnerListCtrl:SetTipsRoot(tr)
  self.trTipsRoot = tr
end

function SoldierPartnerListCtrl:RefreshPartnerList()
  if self.tbPartner == nil or #self.tbPartner == 0 then
    self._mapNode.sv_partner.gameObject:SetActive(false)
    return
  end
  self._mapNode.sv_partner.gameObject:SetActive(true)
  self._mapNode.sv_partner:Init(#self.tbPartner, self, self.OnPartnerRefreshGrid, self.OnPartnerGridBtnClick, false)
  self.tbNewPartner = {}
end

function SoldierPartnerListCtrl:OnPartnerRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local partner = self.tbPartner[nIndex]
  local partnerGroupCfg = CacheTable.GetData("_SoldierPartnerGroup", partner.nType)
  if partnerGroupCfg == nil then
    return
  end
  local nIndex = table.indexof(partner.tbNumList, partner.nActiveNum)
  local partnerCfgList = CacheTable.GetData("_SoldierPartner", partner.nType)
  if partnerCfgList == nil then
    return
  end
  local partnerCfg = partnerCfgList[partner.nActiveLevel]
  if partnerCfg == nil then
    partnerCfg = partnerCfgList[1]
  end
  local img_bg = goGrid.transform:Find("Common/ImageIcon"):GetComponent("Image")
  local img_icon = goGrid.transform:Find("Common/imgPartnericon"):GetComponent("Image")
  local txt_name = goGrid.transform:Find("Common/TextName"):GetComponent("TMP_Text")
  local txtPartner = goGrid.transform:Find("Common/imgPartnerbg/txtPartner"):GetComponent("TMP_Text")
  local txtPartner2 = goGrid.transform:Find("Common/txtPartner2"):GetComponent("TMP_Text")
  local img_Trace = goGrid.transform:Find("Common/imgBuildsIcon")
  local fxRoot = goGrid.transform:Find("Common/PartnerQualityFx")
  fxRoot.gameObject:SetActive(partner.nActiveLevel > 0 and (partnerCfg.PartnerLevelQuality == GameEnum.PartnerLevelQuality.Color or partnerCfg.PartnerLevelQuality == GameEnum.PartnerLevelQuality.Special))
  if partner.nActiveLevel == 0 then
    self:SetPngSprite(img_bg, iconPath .. AllEnum.SoldierPartnerLevelIcon[GameEnum.PartnerLevelQuality.None].bg)
  else
    self:SetPngSprite(img_bg, iconPath .. AllEnum.SoldierPartnerLevelIcon[partnerCfg.PartnerLevelQuality].bg)
  end
  self:SetPngSprite(img_icon, partnerPath .. partnerGroupCfg.Icon .. AllEnum.SoldierChessIconSurfix.M)
  NovaAPI.SetTMPText(txt_name, partnerCfg.Name)
  NovaAPI.SetTMPText(txtPartner2, partner.nCurNum)
  local bTrace = PlayerData.SoldierData:GetCurLevelData():CheckPartnerTrace(partner.nType)
  local bRecommend = PlayerData.SoldierData:CheckPartnerRecommendState(partner.nType)
  img_Trace.gameObject:SetActive(bTrace or bRecommend)
  local strLevel = ""
  for i = 1, #partner.tbNumList do
    if 1 < i then
      strLevel = strLevel .. "/"
    end
    if i ~= partner.nActiveLevel then
      strLevel = strLevel .. partner.tbNumList[i]
    else
      strLevel = strLevel .. "<color=#FAFAFA>" .. partner.tbNumList[i] .. "</color>"
    end
  end
  NovaAPI.SetTMPText(txtPartner, strLevel)
  local animator = goGrid.transform:GetComponent("Animator")
  if animator ~= nil and self.tbNewPartner ~= nil and 0 < table.indexof(self.tbNewPartner, partner.nType) then
    animator:Play("PartnerActive")
  end
end

function SoldierPartnerListCtrl:OnPartnerGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local partner = self.tbPartner[nIndex]
  local bTrace = PlayerData.SoldierData:GetCurLevelData():CheckPartnerTrace(partner.nType)
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierPartnerTips, self.trTipsRoot, partner.nType, partner.nActiveLevel, bTrace)
  local tr = self.trTipsRoot
  EventManager.Hit("OnSetParnterTipsPosition", tr:GetChild(0).position, tr:GetChild(1).position, tr:GetChild(2).position, tr:GetChild(3).position)
end

function SoldierPartnerListCtrl:OnEvent_SoldierPartnerTrace()
  self:RefreshPartnerList()
end

function SoldierPartnerListCtrl:OnEvent_SoldierPartnerNewActive(tbActivePartner)
  self.tbNewPartner = {}
  for k, v in pairs(tbActivePartner) do
    table.insert(self.tbNewPartner, k)
  end
  if not PlayerData.Guide:CheckGuideFinishById(508) then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_Solider_508")
  end
end

return SoldierPartnerListCtrl
