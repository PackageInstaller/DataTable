local CookieLevelGridCtrl = class("CookieLevelGridCtrl", BaseCtrl)
CookieLevelGridCtrl._mapNodeConfig = {
  imgLock = {},
  iconLock = {},
  imgIcon = {sComponentName = "Image"},
  txtLevelNumber = {sComponentName = "TMP_Text"},
  imgCmp = {},
  imgChoose = {},
  btnGrid = {sComponentName = "UIButton"}
}

function CookieLevelGridCtrl:Init(mapData, levelData, bTimeUnlock, bPreLevelUnlock, nIndex)
  local sIconPath = "UI_Activity/_" .. tostring(mapData.ActivityId or 0)
  self:SetPngSprite(self._mapNode.imgIcon, sIconPath .. AllEnum.CookieModeIcon[mapData.PackModel] or AllEnum.CookieModeIcon[1])
  NovaAPI.SetTMPText(self._mapNode.txtLevelNumber, nIndex)
  self._mapNode.imgChoose:SetActive(false)
  self._mapNode.imgLock:SetActive(not bTimeUnlock)
  self._mapNode.iconLock:SetActive(not bPreLevelUnlock or not bTimeUnlock)
  self._mapNode.imgCmp:SetActive(levelData.bFirstComplete == true)
end

function CookieLevelGridCtrl:SetSelect(bActive)
  self._mapNode.imgChoose:SetActive(bActive)
end

return CookieLevelGridCtrl
