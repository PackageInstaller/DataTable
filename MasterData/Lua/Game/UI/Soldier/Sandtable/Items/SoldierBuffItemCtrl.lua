local SoldierBuffItemCtrl = class("SoldierBuffItemCtrl", BaseCtrl)
local RootPath = "Icon/SoldierBuffCard/"
local bgPath = "Icon/SoldierOtherIcon/"
SoldierBuffItemCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  imgBg = {sComponentName = "Image"},
  imgpoint = {}
}
SoldierBuffItemCtrl._mapEventConfig = {}
SoldierBuffItemCtrl._mapRedDotConfig = {}

function SoldierBuffItemCtrl:Awake()
end

function SoldierBuffItemCtrl:OnEnable()
end

function SoldierBuffItemCtrl:OnDisable()
end

function SoldierBuffItemCtrl:OnDestroy()
end

function SoldierBuffItemCtrl:SetData(mapCfg)
  if mapCfg == nil then
    return
  end
  self._mapNode.imgIcon.gameObject:SetActive(true)
  self._mapNode.imgBg.gameObject:SetActive(true)
  self:SetPngSprite(self._mapNode.imgIcon, RootPath .. mapCfg.Icon)
  if mapCfg.Rarity ~= 0 then
    self:SetPngSprite(self._mapNode.imgBg, bgPath .. AllEnum.SoldierStrategyCardRarityIcon[mapCfg.Rarity] .. AllEnum.SoldierChessIconSurfix.S)
  end
end

function SoldierBuffItemCtrl:SetEmpty()
  self._mapNode.imgIcon.gameObject:SetActive(false)
  self._mapNode.imgBg.gameObject:SetActive(false)
  self._mapNode.imgpoint.gameObject:SetActive(false)
end

function SoldierBuffItemCtrl:OnRefresh()
end

return SoldierBuffItemCtrl
