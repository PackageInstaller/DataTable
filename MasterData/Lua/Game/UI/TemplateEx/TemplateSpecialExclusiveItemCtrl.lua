local TemplateSpecialExclusiveItemCtrl = class("TemplateSpecialExclusiveItemCtrl", BaseCtrl)
TemplateSpecialExclusiveItemCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  imgSelect = {},
  imgMask = {sComponentName = "Image"}
}
TemplateSpecialExclusiveItemCtrl._mapEventConfig = {}

function TemplateSpecialExclusiveItemCtrl:SetPerk(nTid, bHas)
  local mapCfg = ConfigTable.GetData_Item(nTid)
  self:SetPngSprite(self._mapNode.imgIcon, mapCfg.Icon)
  self._mapNode.imgSelect:SetActive(false)
  if bHas == false then
    self._mapNode.imgMask.gameObject:SetActive(true)
    self:SetPngSprite(self._mapNode.imgMask, mapCfg.Icon)
  else
    self._mapNode.imgMask.gameObject:SetActive(false)
  end
end

function TemplateSpecialExclusiveItemCtrl:SetSelect(bSelect)
  self._mapNode.imgSelect:SetActive(bSelect)
end

return TemplateSpecialExclusiveItemCtrl
