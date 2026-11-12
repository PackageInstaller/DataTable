local DepotPotentialItemCtrl = class("DepotPotentialItemCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
DepotPotentialItemCtrl._mapNodeConfig = {
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
  txtReCount = {sComponentName = "TMP_Text"}
}
DepotPotentialItemCtrl._mapEventConfig = {
  SelectDepotPotential = "OnEvent_SelectDepotPotential"
}
DepotPotentialItemCtrl._mapRedDotConfig = {}
local level_txt_color = {
  [1] = "#264278",
  [2] = "#2c5fd5",
  [3] = "#8cac59",
  [4] = "#e74470"
}

function DepotPotentialItemCtrl:InitItem(nPotentialId, nLevel, nPotentialAdd, bShowAdd, bHideChoose, recommendLv)
  self.nPotentialId = nPotentialId
  self.nLevel = nLevel
  self.nPotentialAdd = nPotentialAdd
  self.bHideChoose = bHideChoose
  
  function self.WaitLayoutTxtFunc()
    self:WaitLayoutTxt()
  end
  
  local itemCfg = ConfigTable.GetData_Item(nPotentialId)
  local potentialCfg = ConfigTable.GetData("Potential", nPotentialId)
  if nil == potentialCfg or nil == itemCfg then
    return
  end
  self._mapNode.imgLock.gameObject:SetActive(nLevel <= 0)
  self._mapNode.imgMask.gameObject:SetActive(nLevel <= 0)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 1)
  local bSpecial = itemCfg.Stype == GameEnum.itemStype.SpecificPotential
  self.bSpecial = bSpecial
  self._mapNode.goNormal.gameObject:SetActive(not bSpecial)
  self._mapNode.goSpecial.gameObject:SetActive(bSpecial)
  if recommendLv == nil then
    recommendLv = -1
  end
  if not bSpecial then
    self:SetNormalPotential(itemCfg, potentialCfg, bShowAdd, recommendLv)
  else
    self:SetSpecialPotential(itemCfg, potentialCfg)
  end
  self:RefreshRecommend(recommendLv)
end

function DepotPotentialItemCtrl:SetNormalPotential(itemCfg, potentialCfg, bShowAdd, recommendLv)
  local sFrame = AllEnum.FrameType_New.PotentialS .. AllEnum.FrameColor_New[itemCfg.Rarity]
  self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sFrame)
  self._mapNode.goIcon:SetIcon(potentialCfg.Id)
  NovaAPI.SetTMPText(self._mapNode.txtName, itemCfg.Title)
  local nPotentialAdd = self.nPotentialAdd
  if not bShowAdd then
    nPotentialAdd = 0
  end
  local sColor = nPotentialAdd == 0 and level_txt_color[1] or level_txt_color[2]
  if 0 < recommendLv then
    if recommendLv > self.nLevel then
      sColor = level_txt_color[4]
    elseif recommendLv <= self.nLevel then
      sColor = level_txt_color[3]
    end
  end
  local _, color = ColorUtility.TryParseHtmlString(sColor)
  local nCurLevel = self.nLevel + nPotentialAdd
  NovaAPI.SetTMPText(self._mapNode.txtLevelValue, nCurLevel)
  NovaAPI.SetTMPColor(self._mapNode.txtLevelValue, color)
end

function DepotPotentialItemCtrl:SetSpecialPotential(itemCfg, potentialCfg)
  NovaAPI.SetTMPText(self._mapNode.txtSpName, itemCfg.Title)
  self:SetPngSprite(self._mapNode.imgSpIcon, itemCfg.Icon .. AllEnum.PotentialIconSurfix.A)
end

function DepotPotentialItemCtrl:RefreshPreselectionLevel(nLevel)
  self.nLevel = nLevel
  self._mapNode.imgLock.gameObject:SetActive(nLevel <= 0)
  self._mapNode.imgMask.gameObject:SetActive(nLevel <= 0)
  NovaAPI.SetTMPText(self._mapNode.txtLevelValue, self.nLevel)
end

function DepotPotentialItemCtrl:GetPotentialID()
  return self.nPotentialId
end

function DepotPotentialItemCtrl:RefreshRecommend(recommendLv)
  self.recommendLv = recommendLv
  self._mapNode.recomContainer.gameObject:SetActive(-1 < recommendLv)
  if -1 < recommendLv then
    if self.bSpecial then
      NovaAPI.SetTMPText(self._mapNode.txtReCount, "")
    else
      NovaAPI.SetTMPText(self._mapNode.txtReCount, recommendLv)
      if recommendLv > self.nLevel then
        sColor = level_txt_color[4]
      elseif recommendLv <= self.nLevel then
        sColor = level_txt_color[3]
      end
      local _, color = ColorUtility.TryParseHtmlString(sColor)
      NovaAPI.SetTMPColor(self._mapNode.txtLevelValue, color)
    end
  elseif not self.bSpecial then
    local _, color = ColorUtility.TryParseHtmlString(level_txt_color[1])
    NovaAPI.SetTMPColor(self._mapNode.txtLevelValue, color)
  end
  if -1 < recommendLv then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.imageRecomBg.gameObject:GetComponent("RectTransform"))
    end
    
    cs_coroutine.start(wait)
  end
end

function DepotPotentialItemCtrl:OnBtnClick_Item()
  EventManager.Hit("SelectDepotPotential", self.nPotentialId, self.nLevel, self.nPotentialAdd, self._mapNode.btnItem)
end

function DepotPotentialItemCtrl:OnEvent_SelectDepotPotential(nId)
  if self.bHideChoose then
    return
  end
  self._mapNode.imgChoose:SetActive(self.nPotentialId == nId)
end

return DepotPotentialItemCtrl
