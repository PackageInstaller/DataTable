local SpliderRecommendPartnerCtrl = class("SpliderRecommendPartnerCtrl", BaseCtrl)
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
local iconPath = "Icon/SoldierOtherIcon/"
local partnerPath = "Icon/SoldierPartner/"
SpliderRecommendPartnerCtrl._mapNodeConfig = {
  sv_partner = {
    sComponentName = "LoopScrollView"
  }
}
SpliderRecommendPartnerCtrl._mapEventConfig = {}
SpliderRecommendPartnerCtrl._mapRedDotConfig = {}

function SpliderRecommendPartnerCtrl:Awake()
end

function SpliderRecommendPartnerCtrl:OnDestroy()
end

function SpliderRecommendPartnerCtrl:RefreshPartner(tbCharList, tbExPartner)
  self.tbCharList = tbCharList
  local _, tbUIData = SoldierAttrData.CalcActivePartners(self.tbCharList, tbExPartner)
  self.tbPartner = tbUIData
  self:RefreshPartnerUI()
end

function SpliderRecommendPartnerCtrl:RefreshPartnerUI()
  self._mapNode.sv_partner:Init(#self.tbPartner, self, self.OnPartnerRefreshGrid, self.OnPartnerGridBtnClick, false)
end

function SpliderRecommendPartnerCtrl:OnPartnerRefreshGrid(goGrid, gridIndex)
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
  local img_bg = goGrid.transform:Find("img_icon"):GetComponent("Image")
  local img_icon = goGrid.transform:Find("img_icon/img_Partnericon"):GetComponent("Image")
  local txt_name = goGrid.transform:Find("txt_name"):GetComponent("TMP_Text")
  local txtPartner = goGrid.transform:Find("imgPartnerbg/txt_level"):GetComponent("TMP_Text")
  local txtPartner2 = goGrid.transform:Find("imgLevelBg/txt_level2"):GetComponent("TMP_Text")
  if partner.nActiveLevel == 0 then
    self:SetPngSprite(img_bg, iconPath .. AllEnum.SoldierPartnerLevelIcon[GameEnum.PartnerLevelQuality.None].bg)
  else
    self:SetPngSprite(img_bg, iconPath .. AllEnum.SoldierPartnerLevelIcon[partnerCfg.PartnerLevelQuality].bg)
  end
  self:SetPngSprite(img_icon, partnerPath .. partnerGroupCfg.Icon .. AllEnum.SoldierChessIconSurfix.M)
  NovaAPI.SetTMPText(txt_name, partnerCfg.Name)
  NovaAPI.SetTMPText(txtPartner2, partner.nCurNum)
  local strLevel = ""
  for i = 1, #partner.tbNumList do
    if 1 < i then
      strLevel = strLevel .. "/"
    end
    if i ~= partner.nActiveLevel then
      strLevel = strLevel .. partner.tbNumList[i]
    else
      strLevel = strLevel .. "<color=#EED9BD>" .. partner.tbNumList[i] .. "</color>"
    end
  end
  NovaAPI.SetTMPText(txtPartner, strLevel)
end

function SpliderRecommendPartnerCtrl:SetPartnerDetailRoot(tr)
  self.partnerDetailRoot = tr
end

function SpliderRecommendPartnerCtrl:OnPartnerGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapPartner = self.tbPartner[nIndex]
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierPartnerTips, self.partnerDetailRoot, mapPartner.nType, mapPartner.nActiveLevel, false, self.tbCharList)
  local tr = self.partnerDetailRoot:GetChild(0)
  EventManager.Hit("OnSetParnterTipsPosition", tr.position, tr:GetChild(0).position, tr:GetChild(1).position)
  EventManager.Hit("SoldierCharTips_ShowBg")
end

return SpliderRecommendPartnerCtrl
