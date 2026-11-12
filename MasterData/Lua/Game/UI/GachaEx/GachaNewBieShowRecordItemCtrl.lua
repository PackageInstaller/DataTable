local GachaNewBieShowRecordItemCtrl = class("GachaNewBieShowRecordItemCtrl", BaseCtrl)
GachaNewBieShowRecordItemCtrl._mapNodeConfig = {
  rtItem = {
    sNodeName = "item",
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 10
  },
  imgRec = {sNodeName = "imgRec_", nCount = 10},
  txt_line = {sComponentName = "TMP_Text"}
}
GachaNewBieShowRecordItemCtrl._mapEventConfig = {}

function GachaNewBieShowRecordItemCtrl:Awake()
end

function GachaNewBieShowRecordItemCtrl:FadeIn()
end

function GachaNewBieShowRecordItemCtrl:FadeOut()
end

function GachaNewBieShowRecordItemCtrl:OnEnable()
end

function GachaNewBieShowRecordItemCtrl:OnDisable()
end

function GachaNewBieShowRecordItemCtrl:OnDestroy()
end

function GachaNewBieShowRecordItemCtrl:SetItems(items, idx)
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

return GachaNewBieShowRecordItemCtrl
