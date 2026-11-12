local PreProductionItemCtrl = class("PreProductionItemCtrl", BaseCtrl)
PreProductionItemCtrl._mapNodeConfig = {
  anAudioUI = {sNodeName = "btnGrid", sComponentName = "AkAudioUI"},
  goItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  txtProductionName = {sComponentName = "TMP_Text"},
  txtHave = {sComponentName = "TMP_Text"},
  txtHaveCount = {sComponentName = "TMP_Text"},
  goLock = {},
  imgSelect = {},
  txtLock = {sComponentName = "TMP_Text"}
}
PreProductionItemCtrl._mapEventConfig = {}

function PreProductionItemCtrl:SetData(tbProduction)
  self.nId = tbProduction.Id
  self.bUnlock = tbProduction.Unlock
  self._mapNode.goLock.gameObject:SetActive(not self.bUnlock)
  if not self.bUnlock then
    NovaAPI.SetTMPText(self._mapNode.txtLock, tbProduction.UnlockTip)
  end
  local nItemId = tbProduction.ShowProductionId == 0 and tbProduction.ProductionId or tbProduction.ShowProductionId
  local nCount = tbProduction.ShowProductionId == 0 and tbProduction.ProductionPerBatch or tbProduction.ShowProductionPerBatch
  if nCount <= 1 then
    nCount = nil
  end
  self._mapNode.goItem:SetItem(nItemId, nil, nCount)
  NovaAPI.SetTMPText(self._mapNode.txtProductionName, tbProduction.Name)
  local hasCount = PlayerData.Item:GetItemCountByID(nItemId)
  NovaAPI.SetTMPText(self._mapNode.txtHaveCount, hasCount)
  self:SetSelect(false)
  local sAudioEvent = self.bUnlock and "ui_common_slide" or "ui_systerm_locked"
  self._mapNode.anAudioUI:SetAkAudioWiseEventName(sAudioEvent)
end

function PreProductionItemCtrl:SetSelect(bSelect)
  self.bSelect = bSelect
  self._mapNode.imgSelect.gameObject:SetActive(self.bSelect)
end

function PreProductionItemCtrl:OnSelectItem(nId)
  self:SetSelect(nId == self.nId)
end

return PreProductionItemCtrl
