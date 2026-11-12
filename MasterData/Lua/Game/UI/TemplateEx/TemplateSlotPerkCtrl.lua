local TemplateSlotPerkCtrl = class("TemplateSlotPerkCtrl", BaseCtrl)
local _, Gray = ColorUtility.TryParseHtmlString("#A0A9B2")
TemplateSlotPerkCtrl._mapNodeConfig = {
  imgRare = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  imgSelect = {},
  goStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
  },
  imgSlot = {sComponentName = "Image"},
  rtOn = {},
  txtSlot = {sComponentName = "TMP_Text"},
  imgDescBg = {sComponentName = "Image"}
}
TemplateSlotPerkCtrl._mapEventConfig = {}

function TemplateSlotPerkCtrl:SetSlotPerk(nTid, nIndex, nStar, nMaxStar)
  self._mapNode.rtOn:SetActive(nTid ~= nil)
  NovaAPI.SetImageColor(self._mapNode.imgDescBg, nTid ~= nil and White_Dark or Gray_Dark)
  NovaAPI.SetImageColor(self._mapNode.imgSlot, nTid ~= nil and White_Normal or Gray)
  NovaAPI.SetTMPColor(self._mapNode.txtSlot, nTid ~= nil and White_Normal or Gray)
  self:SetAtlasSprite(self._mapNode.imgSlot, "10_ico", "zs_vestige_icon_" .. nIndex)
  NovaAPI.SetImageNativeSize(self._mapNode.imgSlot)
  NovaAPI.SetTMPText(self._mapNode.txtSlot, ConfigTable.GetUIText("Slot_Title_" .. nIndex))
  if nTid then
    local sPath = AllEnum.FrameType_New.SlotPerk .. AllEnum.FrameColor_New[ConfigTable.GetData_Item(nTid).Rarity]
    self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sPath)
    self:SetPngSprite(self._mapNode.imgIcon, ConfigTable.GetData_Item(nTid).Icon)
    self._mapNode.goStar:SetStar(nStar, nMaxStar)
    self:SetSelect(false)
  end
end

function TemplateSlotPerkCtrl:SetSelect(bSelect)
  self._mapNode.imgSelect:SetActive(bSelect)
end

return TemplateSlotPerkCtrl
