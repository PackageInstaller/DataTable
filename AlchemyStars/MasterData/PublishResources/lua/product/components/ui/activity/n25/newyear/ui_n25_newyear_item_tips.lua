_class("UIN25NewYearItemTips", UICustomWidget)
UIN25NewYearItemTips = UIN25NewYearItemTips

function UIN25NewYearItemTips:Constructor()
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._roleModule = GameGlobal.GetModule(RoleModule)
end

function UIN25NewYearItemTips:OnShow(uiParams)
  self:_GetComponents()
end

function UIN25NewYearItemTips:_GetComponents()
  self._parentGo = self:GetGameObject("Parent")
  self._itemInfoGo = self:GetGameObject("ItemInfo")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._count = self:GetUIComponent("UILocalizationText", "Count")
  self._content = self:GetUIComponent("UILocalizationText", "Content")
  self._uIItem = self:GetUIComponent("UISelectObjectPath", "UIItem")
  self._uiItemWidget = self._uIItem:SpawnObject("UIN25NewYearItem")
  self._parentGo:SetActive(false)
end

function UIN25NewYearItemTips:SetData(roleAsset, position)
  local cfg = Cfg.cfg_item[roleAsset.assetid]
  if not cfg then
    return
  end
  self._name:SetText(StringTable.Get(cfg.Name))
  local count = self._roleModule:GetAssetCount(roleAsset.assetid)
  local str = string.format("<color=#d57f48>%s</color>", self:_FormatItemCount(count))
  self._count:SetText(StringTable.Get("str_item_public_owned") .. str)
  self._content:SetText(StringTable.Get(cfg.Intro))
  self._uiItemWidget:Flush(roleAsset)
  self._itemInfoGo.transform.position = position
  self._itemInfoGo.transform.localPosition = Vector3(self._itemInfoGo.transform.localPosition.x + 380, self._itemInfoGo.transform.localPosition.y + 130, 0)
  self._parentGo:SetActive(true)
end

function UIN25NewYearItemTips:CloseBtnOnClick(go)
  self._parentGo:SetActive(false)
end

function UIN25NewYearItemTips:_FormatItemCount(itemCount)
  return HelperProxy:GetInstance():FormatItemCount(itemCount)
end
