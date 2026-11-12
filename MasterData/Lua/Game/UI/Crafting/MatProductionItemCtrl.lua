local MatProductionItemCtrl = class("MatProductionItemCtrl", BaseCtrl)
MatProductionItemCtrl._mapNodeConfig = {
  anAudioUI = {sNodeName = "btnGrid", sComponentName = "AkAudioUI"},
  goItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  txtHave = {
    sComponentName = "TMP_Text",
    sLanguageId = "Crafting_Material_QTY"
  },
  txtHaveCount = {sComponentName = "TMP_Text"},
  txtProductionName = {sComponentName = "TMP_Text"},
  goLock = {},
  imgSelect = {},
  txtLock = {sComponentName = "TMP_Text"}
}
MatProductionItemCtrl._mapEventConfig = {}

function MatProductionItemCtrl:SetData(tbProduction)
  self.nId = tbProduction.Id
  self.bUnlock = tbProduction.Unlock
  self._mapNode.goLock.gameObject:SetActive(not self.bUnlock)
  if not self.bUnlock then
    NovaAPI.SetTMPText(self._mapNode.txtLock, tbProduction.UnlockTip)
  end
  self.nItemId = tbProduction.ShowProductionId == 0 and tbProduction.ProductionId or tbProduction.ShowProductionId
  local nCount = tbProduction.ShowProductionId == 0 and tbProduction.ProductionPerBatch or tbProduction.ShowProductionPerBatch
  if nCount <= 1 then
    nCount = nil
  end
  self:RefreshCraftingItem()
  self._mapNode.goItem:SetItem(self.nItemId, nil)
  NovaAPI.SetTMPText(self._mapNode.txtProductionName, tbProduction.Name)
  self:SetSelect(false)
  local sAudioEvent = self.bUnlock and "ui_common_slide" or "ui_systerm_locked"
  self._mapNode.anAudioUI:SetAkAudioWiseEventName(sAudioEvent)
end

function MatProductionItemCtrl:RefreshCraftingItem()
  local nMaxCraftingCount = -1
  local tbCfgData = PlayerData.Crafting:GetProductionById(self.nId)
  if tbCfgData ~= nil then
    for k, v in ipairs(tbCfgData.MaterialList) do
      local hasCount = PlayerData.Item:GetItemCountByID(v.nItemId)
      local nCount = math.floor(hasCount / v.nCount)
      if -1 == nMaxCraftingCount then
        nMaxCraftingCount = nCount
      end
      nMaxCraftingCount = math.min(nCount, nMaxCraftingCount)
      nMaxCraftingCount = math.max(nMaxCraftingCount, 0)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtHaveCount, nMaxCraftingCount)
end

function MatProductionItemCtrl:SetSelect(bSelect)
  self.bSelect = bSelect
  self._mapNode.imgSelect.gameObject:SetActive(self.bSelect)
end

return MatProductionItemCtrl
