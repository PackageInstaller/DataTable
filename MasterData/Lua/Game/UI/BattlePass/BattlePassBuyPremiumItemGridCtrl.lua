local BattlePassBuyPremiumItemGridCtrl = class("BattlePassBuyPremiumItemGridCtrl", BaseCtrl)
BattlePassBuyPremiumItemGridCtrl._mapNodeConfig = {
  tcItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnGrid = {sComponentName = "UIButton"},
  TMPDesc = {sComponentName = "TMP_Text"}
}
BattlePassBuyPremiumItemGridCtrl._mapEventConfig = {}
BattlePassBuyPremiumItemGridCtrl._mapRedDotConfig = {}

function BattlePassBuyPremiumItemGridCtrl:OnEnable()
  local rtShow = self.gameObject.transform:Find("btnGrid/AnimRoot/rtTopInfo")
  if rtShow ~= nil then
    local tmpHint = rtShow:Find("TMPRewardHintSPremium")
    NovaAPI.SetTMPText(tmpHint:GetComponent("TMP_Text"), ConfigTable.GetUIText("BattlePassRewardPremiumTopGridHint"))
  end
end

function BattlePassBuyPremiumItemGridCtrl:Refresh(nTid)
  local rtShow = self.gameObject.transform:Find("btnGrid/AnimRoot/rtTopInfo")
  if nTid == nil then
    self._mapNode.TMPDesc.gameObject:SetActive(false)
    self._mapNode.tcItem.gameObject:SetActive(false)
    if rtShow ~= nil then
      rtShow.gameObject:SetActive(true)
    end
    return
  else
    self._mapNode.TMPDesc.gameObject:SetActive(true)
    self._mapNode.tcItem.gameObject:SetActive(true)
    if rtShow ~= nil then
      rtShow.gameObject:SetActive(false)
    end
  end
  self.nTid = nTid
  local mapItemCfgData = ConfigTable.GetData_Item(self.nTid)
  if mapItemCfgData == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPDesc, mapItemCfgData.Title)
  self._mapNode.tcItem:SetItem(nTid, nil, nil, nil, false, false, false, true, false)
end

return BattlePassBuyPremiumItemGridCtrl
