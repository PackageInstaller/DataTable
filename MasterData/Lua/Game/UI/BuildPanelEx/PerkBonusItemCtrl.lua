local PerkBonusItemCtrl = class("PerkBonusItemCtrl", BaseCtrl)
PerkBonusItemCtrl._mapNodeConfig = {
  imgRare = {sComponentName = "Image"},
  img_markNew = {},
  img_perkIcon = {sComponentName = "Image"},
  img_perkLogo = {sComponentName = "Image"},
  btn_Star = {sComponentName = "Button", nCount = 5},
  txt_perkName = {sComponentName = "Text"},
  img_gray = {sComponentName = "Image"},
  rt_starContent = {}
}
PerkBonusItemCtrl._mapEventConfig = {}

function PerkBonusItemCtrl:SetGrid(mapInfo)
  local mapPerkData = ConfigTable.GetData_Item(mapInfo.nTid)
  local mapPerk = ConfigTable.GetData_Perk(mapInfo.nTid)
  self:SetIconItem(self._mapNode.img_perkIcon, mapInfo.nTid)
  self:SetFrameColorSprite(self._mapNode.imgRare, mapPerkData.Rarity, AllEnum.FrameType_New.Item, true)
  NovaAPI.SetText(self._mapNode.txt_perkName, mapPerkData.Title)
  if mapPerk.LogoIcon == "" or mapPerk.LogoIcon == nil then
    self._mapNode.img_perkLogo.gameObject:SetActive(false)
  else
    self._mapNode.img_perkLogo.gameObject:SetActive(true)
    NovaAPI.SetImageSpriteAsset(self._mapNode.img_perkLogo, self:GetPerkLogo(mapPerk.LogoIcon))
  end
  self._mapNode.rt_starContent:SetActive(not mapInfo.bOverLimit)
  self._mapNode.img_gray.gameObject:SetActive(mapInfo.bOverLimit)
  self._mapNode.img_markNew:SetActive(mapInfo.bNew)
  if mapInfo.bOverLimit then
    return
  end
  for i = 1, 5 do
    self._mapNode.btn_Star[i].interactable = i <= mapInfo.nStar + mapInfo.nNewStar
    if i > mapInfo.nStar and i < mapInfo.nNewStar then
      NovaAPI.SetImageColor(self._mapNode.btn_Star[i].gameObject:GetComponent("Image"), Color(1, 1, 1, 0.5))
    else
      NovaAPI.SetImageColor(self._mapNode.btn_Star[i].gameObject:GetComponent("Image"), Color(1, 1, 1, 1))
    end
    self._mapNode.btn_Star[i].gameObject:SetActive(i <= mapPerk.MaxLevel - 1)
  end
end

function PerkBonusItemCtrl:Awake()
end

function PerkBonusItemCtrl:OnEnable()
end

function PerkBonusItemCtrl:OnDisable()
end

function PerkBonusItemCtrl:OnDestroy()
end

function PerkBonusItemCtrl:OnRelease()
end

return PerkBonusItemCtrl
