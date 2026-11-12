local SoldierPartnerTipsDesItemCtrl = class("SoldierPartnerTipsDesItemCtrl", BaseCtrl)
SoldierPartnerTipsDesItemCtrl._mapNodeConfig = {
  imgEffectLv = {sComponentName = "Image"},
  btnImgEffectLv = {
    sNodeName = "imgEffectLv",
    sComponentName = "Button"
  },
  txtEffectDesc = {sComponentName = "TMP_Text"}
}
SoldierPartnerTipsDesItemCtrl._mapEventConfig = {}
SoldierPartnerTipsDesItemCtrl._mapRedDotConfig = {}
local COLOR_ACTIVE_HEX = "#5fdc6e"
local COLOR_INACTIVE_HEX = "#9b3a3a"
local iconPath = "Icon/SoldierOtherIcon/"

function SoldierPartnerTipsDesItemCtrl:Awake()
end

function SoldierPartnerTipsDesItemCtrl:OnEnable()
end

function SoldierPartnerTipsDesItemCtrl:OnDisable()
end

function SoldierPartnerTipsDesItemCtrl:OnDestroy()
end

function SoldierPartnerTipsDesItemCtrl:OnRefresh(cfg, bActive)
  if cfg == nil then
    return
  end
  self._mapCfg = cfg
  local iconCfg = AllEnum.SoldierPartnerLevelIcon[self._mapCfg.PartnerLevelQuality]
  if iconCfg ~= nil then
    local sPath = iconPath .. iconCfg.levelIcon
    self:SetPngSprite(self._mapNode.imgEffectLv, sPath)
  end
  local sHex = bActive and COLOR_ACTIVE_HEX or COLOR_INACTIVE_HEX
  NovaAPI.SetTMPText(self._mapNode.txtEffectDesc, string.format("<color=%s>%s</color>", sHex, cfg.Desc))
  self._mapNode.btnImgEffectLv.interactable = bActive == true
end

return SoldierPartnerTipsDesItemCtrl
