local SoldierHandbookParnerListItem = class("SoldierHandbookParnerListItem", BaseCtrl)
local iconPath = "Icon/SoldierPartner/"
SoldierHandbookParnerListItem._mapNodeConfig = {
  icon_partnerdetail = {nCount = 2, sComponentName = "Image"},
  txt_partnerdetail = {nCount = 2, sComponentName = "TMP_Text"},
  go_partnerdetail_on = {},
  go_partnerdetail_off = {}
}
SoldierHandbookParnerListItem._mapEventConfig = {
  SoldierHandbookPartnerSelect = "OnEvent_SelectPartner"
}
SoldierHandbookParnerListItem._mapRedDotConfig = {}

function SoldierHandbookParnerListItem:SetPartnerGroup(groupData, bSelect)
  self.groupData = groupData
  for i = 1, 2 do
    local icon = self._mapNode.icon_partnerdetail[i]
    local txt = self._mapNode.txt_partnerdetail[i]
    self:SetPngSprite(icon, iconPath .. groupData.Icon .. AllEnum.SoldierChessIconSurfix.M)
    NovaAPI.SetTMPText(txt, groupData.Name)
  end
  self._mapNode.go_partnerdetail_on.gameObject:SetActive(bSelect)
  self._mapNode.go_partnerdetail_off.gameObject:SetActive(not bSelect)
end

function SoldierHandbookParnerListItem:OnEvent_SelectPartner(nPartnerGroupId)
  self._mapNode.go_partnerdetail_on.gameObject:SetActive(nPartnerGroupId == self.groupData.Id)
  self._mapNode.go_partnerdetail_off.gameObject:SetActive(nPartnerGroupId ~= self.groupData.Id)
end

return SoldierHandbookParnerListItem
