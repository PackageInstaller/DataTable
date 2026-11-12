local MallSkinItemCtrl = class("MallSkinItemCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local ClientManager = CS.ClientManager.Instance
MallSkinItemCtrl._mapNodeConfig = {
  txtName = {sComponentName = "TMP_Text"},
  imgSkin = {sComponentName = "Image"},
  goTime = {},
  txtTime = {sComponentName = "TMP_Text"},
  goNormalPrice = {},
  goCurrency = {},
  imgCurrency = {sComponentName = "Image"},
  txtPrice = {sComponentName = "TMP_Text"},
  txtSalePrice = {sComponentName = "TMP_Text"},
  txtHas = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Skin_Unlock"
  },
  goSale = {},
  txtSale = {sComponentName = "TMP_Text"},
  img2D = {},
  img3D = {},
  imgCG = {},
  imgBGM = {},
  goSaleRate = {
    sComponentName = "RectTransform"
  },
  fxSaleRate = {sNodeName = "goSaleRate", sComponentName = "UIShiny"},
  txtSaleRate = {sComponentName = "TMP_Text"},
  imgMask = {},
  imgSaleMask = {},
  reddotPkg = {},
  imgRoleBg = {},
  txtRoleName = {sComponentName = "TMP_Text"},
  reddotNew = {}
}
MallSkinItemCtrl._mapEventConfig = {}

function MallSkinItemCtrl:Refresh(mapData)
  local mapCfg = ConfigTable.GetData("MallPackage", mapData.sId)
  self.sId = mapData.sId
  self:RefreshInfo(mapCfg)
  self:RefreshPrice(mapCfg)
  self:RefreshTime(mapCfg, mapData)
  self:RegisterRedDot(mapCfg)
end

function MallSkinItemCtrl:RefreshPrice(mapCfg)
  local tbParam = decodeJson(mapCfg.Items)
  local nSkinId = 0
  for nId, v in pairs(tbParam) do
    nSkinId = tonumber(nId)
    break
  end
  self._mapNode.imgRoleBg.gameObject:SetActive(false)
  local mapSkinCfg = ConfigTable.GetData_CharacterSkin(nSkinId)
  if mapSkinCfg ~= nil then
    local nCharId = mapSkinCfg.CharId
    local mapCharCfg = ConfigTable.GetData_Character(nCharId)
    if mapCharCfg ~= nil then
      self._mapNode.imgRoleBg.gameObject:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtRoleName, mapCharCfg.Name)
    end
  end
  self.bUnlock = PlayerData.CharSkin:CheckSkinUnlock(nSkinId)
  self._mapNode.goNormalPrice.gameObject:SetActive(not self.bUnlock)
  self._mapNode.txtHas.gameObject:SetActive(self.bUnlock)
  self._mapNode.goSale.gameObject:SetActive(false)
  if not self.bUnlock then
    local bSale = mapCfg.IsSaleSkin
    if bSale then
      local nDeListTime = PlayerData.Shop:ChangeToTimeStamp(mapCfg.DeListTime)
      local nCurTime = ClientManager.serverTimeStamp
      local nTime = nDeListTime - nCurTime
      if 0 < nTime then
        self._mapNode.goSale.gameObject:SetActive(true)
        local sTimeStr = self:GetTimeStr(nTime)
        NovaAPI.SetTMPText(self._mapNode.txtSale, orderedFormat(ConfigTable.GetUIText("Mall_Skin_Sale_End"), sTimeStr))
      end
    end
    self._mapNode.txtSalePrice.gameObject:SetActive(0 < mapCfg.BasePrice)
    if mapCfg.CurrencyType == GameEnum.currencyType.Cash then
      self._mapNode.goCurrency:SetActive(false)
      NovaAPI.SetTMPText(self._mapNode.txtPrice, tostring(mapCfg.CurrencyShowPrice))
      NovaAPI.SetTMPText(self._mapNode.txtSalePrice, tostring(mapCfg.CurrencyShowBasePrice))
    elseif mapCfg.CurrencyType == GameEnum.currencyType.Item then
      self._mapNode.goCurrency:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtPrice, mapCfg.CurrencyItemQty)
      NovaAPI.SetTMPText(self._mapNode.txtSalePrice, mapCfg.BasePrice)
      self:SetPngSprite(self._mapNode.imgCurrency, ConfigTable.GetData_Item(mapCfg.CurrencyItemId).Icon2)
    elseif mapCfg.CurrencyType == GameEnum.currencyType.Free then
      self._mapNode.goCurrency:SetActive(false)
      self._mapNode.txtSalePrice:SetActive(false)
      NovaAPI.SetTMPText(self._mapNode.txtPrice, ConfigTable.GetUIText("Mall_Package_Free"))
    end
  end
end

function MallSkinItemCtrl:RefreshInfo(mapCfg)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  self:SetPngSprite(self._mapNode.imgSkin, mapCfg.Icon)
  self._mapNode.goSaleRate.gameObject:SetActive(mapCfg.SaleRate ~= 0)
  if mapCfg.SaleRate ~= 0 then
    if mapCfg.SaleRate == -1 then
      NovaAPI.SetTMPText(self._mapNode.txtSaleRate, ConfigTable.GetUIText("Mall_Package_Recommend"))
    else
      NovaAPI.SetTMPText(self._mapNode.txtSaleRate, string.format("%s%%", mapCfg.SaleRate))
    end
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.goSaleRate)
  end
  self._mapNode.img2D.gameObject:SetActive(false)
  self._mapNode.img3D.gameObject:SetActive(false)
  self._mapNode.imgBGM.gameObject:SetActive(false)
  self._mapNode.imgCG.gameObject:SetActive(false)
  for k, v in ipairs(mapCfg.ContentIcon) do
    if v == GameEnum.skinExtraTag.TWOD then
      self._mapNode.img2D.gameObject:SetActive(true)
    elseif v == GameEnum.skinExtraTag.MODEL then
      self._mapNode.img3D.gameObject:SetActive(true)
    elseif v == GameEnum.skinExtraTag.MUSIC then
      self._mapNode.imgBGM.gameObject:SetActive(true)
    elseif v == GameEnum.skinExtraTag.IMAGE then
      self._mapNode.imgCG.gameObject:SetActive(true)
    end
  end
end

function MallSkinItemCtrl:GetTimeStr(nRemainTime)
  local str = ""
  if nRemainTime <= 3600 then
    str = ConfigTable.GetUIText("Mall_Package_WithinHour")
  elseif 3600 < nRemainTime and nRemainTime <= 86400 then
    str = orderedFormat(ConfigTable.GetUIText("Mall_Package_Hour") or "", math.floor(nRemainTime / 3600))
  elseif 86400 < nRemainTime then
    str = orderedFormat(ConfigTable.GetUIText("Mall_Package_Day") or "", math.floor(nRemainTime / 86400))
  end
  return str
end

function MallSkinItemCtrl:RefreshTime(mapCfg, mapData)
  local nDeListTime = 0
  if mapCfg.ProDeListTime ~= nil and mapCfg.ProDeListTime ~= "" then
    self._mapNode.goTime:SetActive(true)
    nDeListTime = PlayerData.Shop:ChangeToTimeStamp(mapCfg.ProDeListTime)
    local bDisposable = mapCfg.RefreshType == GameEnum.mallPackageRefreshType.None
    self._mapNode.goTime.gameObject:SetActive(0 < mapData.nNextRefreshTime and bDisposable and not self.bUnlock)
    if 0 < mapData.nNextRefreshTime and bDisposable then
      local sSuffix = ConfigTable.GetUIText("Mall_Package_Delist")
      local nRemaining = nDeListTime - CS.ClientManager.Instance.serverTimeStamp
      local sPrefix = self:GetTimeStr(nRemaining)
      NovaAPI.SetTMPText(self._mapNode.txtTime, sPrefix .. sSuffix)
    end
  else
    self._mapNode.goTime:SetActive(false)
  end
end

function MallSkinItemCtrl:RegisterRedDot(mapCfg)
  local groupCfg = ConfigTable.GetData("MallPackagePage", mapCfg.GroupId)
  if groupCfg == nil then
    return
  end
  RedDotManager.RegisterNode(RedDotDefine.Mall_Package_New, {
    AllEnum.MallToggle.Skin,
    groupCfg.Sort,
    self.sId
  }, self._mapNode.reddotNew)
end

function MallSkinItemCtrl:Awake()
end

function MallSkinItemCtrl:OnEnable()
end

function MallSkinItemCtrl:OnDisable()
end

function MallSkinItemCtrl:OnDestroy()
end

return MallSkinItemCtrl
