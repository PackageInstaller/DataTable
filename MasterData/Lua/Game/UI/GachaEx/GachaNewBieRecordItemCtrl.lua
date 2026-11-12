local GachaNewBieRecordItemCtrl = class("GachaNewBieRecordItemCtrl", BaseCtrl)
GachaNewBieRecordItemCtrl._mapNodeConfig = {
  rtItem = {
    sNodeName = "item",
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 10
  },
  imgRec = {sNodeName = "imgRec_", nCount = 10},
  txt_line = {sComponentName = "TMP_Text"},
  select = {},
  imgSelect = {},
  TMPSelectTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieSelect"
  }
}
GachaNewBieRecordItemCtrl._mapEventConfig = {}

function GachaNewBieRecordItemCtrl:Awake()
end

function GachaNewBieRecordItemCtrl:FadeIn()
end

function GachaNewBieRecordItemCtrl:FadeOut()
end

function GachaNewBieRecordItemCtrl:OnEnable()
end

function GachaNewBieRecordItemCtrl:OnDisable()
end

function GachaNewBieRecordItemCtrl:OnDestroy()
end

function GachaNewBieRecordItemCtrl:SetItems(items, idx)
  if idx == 0 then
    NovaAPI.SetTMPText(self._mapNode.txt_line, ConfigTable.GetUIText("Gacha_NewBieSaveItemCurrent"))
  else
    NovaAPI.SetTMPText(self._mapNode.txt_line, orderedFormat(ConfigTable.GetUIText("Gacha_NewBieSaveItem") or "", idx))
  end
  for idx, v in ipairs(items) do
    if v ~= 0 then
      self._mapNode.rtItem[idx].gameObject:SetActive(true)
      self._mapNode.rtItem[idx]:SetItem(v)
      local mapItemCfg = ConfigTable.GetData_Item(v)
      self._mapNode.imgRec[idx]:SetActive(mapItemCfg ~= nil and mapItemCfg.Rarity == GameEnum.itemRarity.SSR)
    else
      self._mapNode.rtItem[idx].gameObject:SetActive(false)
    end
  end
end

function GachaNewBieRecordItemCtrl:SetSelect(bSelect)
  self._mapNode.select.gameObject:SetActive(bSelect)
  self._mapNode.imgSelect.gameObject:SetActive(bSelect)
end

return GachaNewBieRecordItemCtrl
