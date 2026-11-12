local MallGemItemCtrl = class("MallGemItemCtrl", BaseCtrl)
MallGemItemCtrl._mapNodeConfig = {
  imgState = {nCount = 2},
  txtState1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Gem_Normal"
  },
  txtState2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Gem_Maiden"
  },
  txtName = {sComponentName = "TMP_Text"},
  imgIcon = {sComponentName = "Image"},
  imgRareBg = {sComponentName = "Image"},
  txtAdd = {sComponentName = "TMP_Text"},
  txtPrice = {sComponentName = "TMP_Text"}
}
MallGemItemCtrl._mapEventConfig = {}

function MallGemItemCtrl:Refresh(mapData)
  local mapCfg = ConfigTable.GetData("MallGem", mapData.Id)
  if not mapCfg then
    return
  end
  self._mapNode.imgState[1]:SetActive(not mapData.Maiden)
  self._mapNode.imgState[2]:SetActive(mapData.Maiden)
  local nAll = mapData.Maiden and mapCfg.MaidenBonusItemQty + mapCfg.BaseItemQty or mapCfg.ExperiencedBonusItemQty + mapCfg.BaseItemQty
  local sName = orderedFormat(mapCfg.Name, nAll)
  NovaAPI.SetTMPText(self._mapNode.txtName, sName)
  self:SetPngSprite(self._mapNode.imgIcon, mapCfg.Icon)
  self:SetPngSprite(self._mapNode.imgRareBg, mapCfg.IconBg)
  local sDesc = orderedFormat(mapCfg.Desc, mapCfg.BaseItemQty, mapData.Maiden and mapCfg.MaidenBonusItemQty or mapCfg.ExperiencedBonusItemQty)
  NovaAPI.SetTMPText(self._mapNode.txtAdd, sDesc)
  NovaAPI.SetTMPText(self._mapNode.txtPrice, tostring(mapCfg.ShowPrice))
end

function MallGemItemCtrl:Awake()
end

function MallGemItemCtrl:OnEnable()
end

function MallGemItemCtrl:OnDisable()
end

function MallGemItemCtrl:OnDestroy()
end

return MallGemItemCtrl
