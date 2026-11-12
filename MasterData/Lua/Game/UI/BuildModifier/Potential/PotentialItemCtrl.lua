local PotentialItemCtrl = class("PotentialItemCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
PotentialItemCtrl._mapNodeConfig = {
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  canvasGroup = {
    sNodeName = "goNormal",
    sComponentName = "CanvasGroup"
  },
  goNormal = {},
  imgRare = {sComponentName = "Image"},
  goIcon = {
    sCtrlName = "Game.UI.StarTower.Potential.PotentialIconCtrl"
  },
  txtName = {sComponentName = "TMP_Text"},
  txtLevelValue = {sComponentName = "TMP_Text"},
  txtLevelValue2 = {sComponentName = "TMP_Text"},
  goSpecial = {},
  imgSpIcon = {sComponentName = "Image"},
  txtSpName = {sComponentName = "TMP_Text"},
  imgChoose = {},
  imgLock = {},
  txtLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Depot_Potential_Lock"
  },
  imgMask = {},
  recomContainer = {},
  imageRecomBg = {},
  txtReCount = {sComponentName = "TMP_Text"},
  rtArrow = {},
  ImgArrow = {sComponentName = "Image"}
}
PotentialItemCtrl._mapEventConfig = {}
PotentialItemCtrl._mapRedDotConfig = {}
local level_txt_color = {
  [1] = "#264278",
  [2] = "#2c5fd5",
  [3] = "#8cac59",
  [4] = "#e74470"
}

function PotentialItemCtrl:InitItem(nPotentialId, nOriginLevel, nAfterLevel)
  self.nPotentialId = nPotentialId
  self.nOriginLevel = nOriginLevel
  self.nAfterLevel = nAfterLevel
  
  function self.WaitLayoutTxtFunc()
    self:WaitLayoutTxt()
  end
  
  local itemCfg = ConfigTable.GetData_Item(nPotentialId)
  local potentialCfg = ConfigTable.GetData("Potential", nPotentialId)
  if nil == potentialCfg or nil == itemCfg then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 1)
  local bSpecial = itemCfg.Stype == GameEnum.itemStype.SpecificPotential
  self.bSpecial = bSpecial
  self._mapNode.goNormal.gameObject:SetActive(not bSpecial)
  self._mapNode.goSpecial.gameObject:SetActive(bSpecial)
  self._mapNode.imgLock.gameObject:SetActive(false)
  self._mapNode.imgMask.gameObject:SetActive(false)
  if not bSpecial then
    self:SetNormalPotential(itemCfg, potentialCfg)
  else
    self:SetSpecialPotential(itemCfg, potentialCfg)
  end
end

function PotentialItemCtrl:SetNormalPotential(itemCfg, potentialCfg)
  local sFrame = AllEnum.FrameType_New.PotentialS .. AllEnum.FrameColor_New[itemCfg.Rarity]
  self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sFrame)
  self._mapNode.goIcon:SetIcon(potentialCfg.Id)
  NovaAPI.SetTMPText(self._mapNode.txtName, itemCfg.Title)
  local sColor
  if self.nOriginLevel > self.nAfterLevel then
    sColor = level_txt_color[4]
  elseif self.nOriginLevel < self.nAfterLevel then
    sColor = level_txt_color[3]
  end
  NovaAPI.SetTMPText(self._mapNode.txtLevelValue, self.nOriginLevel)
  if sColor ~= nil then
    self._mapNode.txtLevelValue2.gameObject:SetActive(true)
    self._mapNode.rtArrow.gameObject:SetActive(true)
    local _, color = ColorUtility.TryParseHtmlString(sColor)
    NovaAPI.SetTMPText(self._mapNode.txtLevelValue2, self.nAfterLevel)
    NovaAPI.SetTMPColor(self._mapNode.txtLevelValue2, color)
    NovaAPI.SetImageColor(self._mapNode.ImgArrow, color)
  else
    self._mapNode.txtLevelValue2.gameObject:SetActive(false)
    self._mapNode.rtArrow.gameObject:SetActive(false)
  end
end

function PotentialItemCtrl:SetSpecialPotential(itemCfg, potentialCfg)
  NovaAPI.SetTMPText(self._mapNode.txtSpName, itemCfg.Title)
  self:SetPngSprite(self._mapNode.imgSpIcon, itemCfg.Icon .. AllEnum.PotentialIconSurfix.A)
end

function PotentialItemCtrl:SetPotentialLevel(nOriginLevel, nAfterLevel)
  if self.bSpecial then
    return
  end
  if self.nOriginLevel == nOriginLevel and self.nAfterLevel == nAfterLevel then
    return
  end
  self.nOriginLevel = nOriginLevel
  self.nAfterLevel = nAfterLevel
  local sColor
  if self.nOriginLevel > self.nAfterLevel then
    sColor = level_txt_color[4]
  elseif self.nOriginLevel < self.nAfterLevel then
    sColor = level_txt_color[3]
  end
  NovaAPI.SetTMPText(self._mapNode.txtLevelValue, self.nOriginLevel)
  if sColor ~= nil then
    self._mapNode.txtLevelValue2.gameObject:SetActive(true)
    self._mapNode.rtArrow.gameObject:SetActive(true)
    local _, color = ColorUtility.TryParseHtmlString(sColor)
    NovaAPI.SetTMPText(self._mapNode.txtLevelValue2, self.nAfterLevel)
    NovaAPI.SetTMPColor(self._mapNode.txtLevelValue2, color)
    NovaAPI.SetImageColor(self._mapNode.ImgArrow, color)
  else
    self._mapNode.txtLevelValue2.gameObject:SetActive(false)
    self._mapNode.rtArrow.gameObject:SetActive(false)
  end
end

function PotentialItemCtrl:GetPotentialID()
  return self.nPotentialId
end

function PotentialItemCtrl:OnBtnClick_Item()
  EventManager.Hit("BuildModifier_ClickPotentialItem", self.nPotentialId)
end

function PotentialItemCtrl:OnEvent_SelectDepotPotential(nId)
end

return PotentialItemCtrl
