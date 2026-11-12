local iconPath2 = "Icon/SoldierOtherIcon/"
local SoldierEffectDesCtrl = class("SoldierEffectDesCtrl", BaseCtrl)
SoldierEffectDesCtrl._mapNodeConfig = {
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Sandtable_PositionEffect"
  },
  ImageIcon = {sComponentName = "Image"},
  TextDes = {sComponentName = "TMP_Text"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  }
}
SoldierEffectDesCtrl._mapEventConfig = {}
SoldierEffectDesCtrl._mapRedDotConfig = {}

function SoldierEffectDesCtrl:HideTips()
  self.gameObject:SetActive(false)
end

function SoldierEffectDesCtrl:ShowTips(nPositionIndex)
  self.gameObject:SetActive(true)
  local nCfgId = PlayerData.SoldierData:GetSoldierPositionEffectDataId(nPositionIndex)
  local cfg = ConfigTable.GetData("SoldierPositionEffect", nCfgId)
  if cfg then
    self:SetPngSprite(self._mapNode.ImageIcon, iconPath2 .. cfg.Icon)
    NovaAPI.SetTMPText(self._mapNode.TextDes, cfg.KeyEffectDes)
  end
end

function SoldierEffectDesCtrl:OnBtnClick_Close()
  self:HideTips()
end

return SoldierEffectDesCtrl
