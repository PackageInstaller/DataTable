local BaseCtrl = require("GameCore.UI.BaseCtrl")
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
local SoldierCharAttriTipsCtrl = class("SoldierCharAttriTipsCtrl", BaseCtrl)
SoldierCharAttriTipsCtrl._mapNodeConfig = {
  snapshot = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  aniRoot = {sNodeName = "Window", sComponentName = "Animator"},
  aniBlur = {
    sNodeName = "t_fullscreen_blur_black",
    sComponentName = "Animator"
  },
  goBlur = {
    sNodeName = "t_fullscreen_blur_black"
  },
  imgIcon = {sComponentName = "Image"},
  txt_CharName = {sComponentName = "TMP_Text"},
  txtStatus = {sNodeName = "TextStatus", sComponentName = "TMP_Text"},
  imgStatusIcon = {
    sNodeName = "ImageStatusIcon",
    sComponentName = "Image"
  },
  loopSv = {
    sComponentName = "LoopScrollView",
    sNodeName = "Scroll View"
  },
  goLevel = {nCount = 3},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_CharDetail"
  },
  imgRare = {sComponentName = "Image"},
  rtSwitch = {},
  aniSwitch = {sNodeName = "rtSwitch", sComponentName = "Animator"},
  goSwitch = {nCount = 2},
  txtBtnSwitch2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_CharDetail_Switch2"
  },
  txtBtnSwitch1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_CharDetail_Switch1"
  },
  txtBtnSwitch3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_CharDetail_Switch1"
  },
  txtBtnSwitch4 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_CharDetail_Switch2"
  },
  btnSwitch = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Switch"
  }
}
SoldierCharAttriTipsCtrl._mapEventConfig = {}
SoldierCharAttriTipsCtrl._mapRedDotConfig = {}
local RootPath = "Icon/SoldierOtherIcon/"

function SoldierCharAttriTipsCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self._nCharId = tbParam[1]
    self._bShowSwitchBtn = tbParam[2]
  end
  self.bSwitchCharGrowth = true
  if self._bShowSwitchBtn == nil then
    self._bShowSwitchBtn = false
  end
  if self._bShowSwitchBtn then
    local cfgChess = ConfigTable.GetData("SoldierCharacter", self._nCharId)
    if cfgChess == nil then
      return
    end
    if cfgChess.Type == GameEnum.SoldierCharacterType.Monster then
      self._bShowSwitchBtn = false
    elseif cfgChess.Type == GameEnum.SoldierCharacterType.Actor then
      local mapChar = PlayerData.Char:GetCharDataByTid(cfgChess.CharacterId)
      if mapChar == nil then
        self._bShowSwitchBtn = false
      end
    end
  end
  self:SetSwitchBtnShow()
end

function SoldierCharAttriTipsCtrl:OnEnable()
  self._mapNode.goBlur:SetActive(true)
  self._mapNode.aniRoot:Play("t_window_04_t_in")
  if self._nCharId ~= nil then
    self:OnRefresh(self._nCharId)
  end
end

function SoldierCharAttriTipsCtrl:OnDisable()
end

function SoldierCharAttriTipsCtrl:OnDestroy()
end

function SoldierCharAttriTipsCtrl:SetSwitchBtnShow()
  self._mapNode.rtSwitch.gameObject:SetActive(self._bShowSwitchBtn)
end

function SoldierCharAttriTipsCtrl:OnRefresh(nCharId)
  local cfgChess = ConfigTable.GetData("SoldierCharacter", nCharId)
  if cfgChess == nil then
    printError("SoldierCharAttriTips: SoldierCharacter not found, nCharId=" .. tostring(nCharId))
    return
  end
  local cfgSkin = ConfigTable.GetData("SoldierSkin", cfgChess.Skin)
  if cfgSkin ~= nil and cfgSkin.Icon then
    self:SetPngSprite(self._mapNode.imgIcon, cfgSkin.Icon .. "_L")
  end
  local sName = cfgChess.Name
  NovaAPI.SetTMPText(self._mapNode.txt_CharName, sName)
  local nChessType = cfgChess.Type
  local tbChessTypeConfig = CacheTable.GetData("_SoldierChessType", nChessType)
  if tbChessTypeConfig ~= nil then
    local sPath = "Icon/SoldierOtherIcon/" .. tbChessTypeConfig.Icon
    self:SetPngSprite(self._mapNode.imgStatusIcon, sPath)
    NovaAPI.SetTMPText(self._mapNode.txtStatus, tbChessTypeConfig.Name)
    local rarePath = RootPath .. AllEnum.SoldierChessRarityIcon[cfgChess.Rarity] .. AllEnum.SoldierChessIconSurfix.L
    self:SetPngSprite(self._mapNode.imgRare, rarePath)
  end
  self.maxLevel = cfgChess.MaxStar
  for i = 1, self.maxLevel do
    local goLevel = self._mapNode.goLevel[i]
    if goLevel then
      goLevel:SetActive(i <= self.maxLevel)
    end
  end
  self:_RefreshAttrItems(cfgChess.Id, self._bShowSwitchBtn and self.bSwitchCharGrowth)
  if self._bShowSwitchBtn then
    self._mapNode.aniSwitch:Play("CharAttriTipsSwitch_2")
  end
end

function SoldierCharAttriTipsCtrl:_RefreshAttrItems(nCharId, bAddCharGrowth)
  local tbAttr = SoldierAttrData.CalcCharacterAttr(nCharId, 1, nil, nil, nil, bAddCharGrowth)
  self._tbShowAttr = {}
  for _, attr in ipairs(tbAttr or {}) do
    if attr.sKey ~= "Energy" and attr.sKey ~= "InitialEnergy" then
      table.insert(self._tbShowAttr, attr)
    end
  end
  self._mapNode.loopSv:Init(#self._tbShowAttr, self, self.RefreshAttrItem)
end

function SoldierCharAttriTipsCtrl:RefreshAttrItem(goGird, gridIndex)
  local index = gridIndex + 1
  local attr = self._tbShowAttr and self._tbShowAttr[index]
  if attr == nil then
    return
  end
  local mapAttributeDesc = CacheTable.GetData("_AttributeDesc", attr.sKey)
  if not mapAttributeDesc then
    return
  end
  local imgIcon = goGird.transform:Find("ImageIcon"):GetComponent("Image")
  local txtName = goGird.transform:Find("TextName"):GetComponent("TMP_Text")
  self:SetPngSprite(imgIcon, mapAttributeDesc.Icon)
  if attr.sLanguageId ~= nil then
    NovaAPI.SetTMPText(txtName, ConfigTable.GetUIText(attr.sLanguageId))
  else
    NovaAPI.SetTMPText(txtName, mapAttributeDesc.Desc)
  end
  local tbAttrByLevel = {}
  local bAddCharGrowth = self._bShowSwitchBtn and self.bSwitchCharGrowth
  for i = 1, self.maxLevel do
    local tbAttr = SoldierAttrData.CalcCharacterAttr(self._nCharId, i, nil, nil, nil, bAddCharGrowth)
    local curAttr
    for _, item in ipairs(tbAttr or {}) do
      if item.sKey == attr.sKey then
        curAttr = item
        break
      end
    end
    tbAttrByLevel[i] = curAttr
  end
  for i = 1, 3 do
    local txtValue = goGird.transform:Find("TextValue" .. i):GetComponent("TMP_Text")
    if i > self.maxLevel then
      NovaAPI.SetTMPText(txtValue, "")
    else
      local curAttr = tbAttrByLevel[i]
      if curAttr ~= nil then
        local sValue = self:_TransValueFormat(curAttr.nValue, mapAttributeDesc.isPercent, mapAttributeDesc.Format)
        NovaAPI.SetTMPText(txtValue, sValue)
      else
        NovaAPI.SetTMPText(txtValue, "")
      end
    end
  end
end

function SoldierCharAttriTipsCtrl:_TransValueFormat(nValue, bPercent, nFormat, bAdd)
  local sValue = FormatEffectValue(nValue, bPercent, nFormat)
  if bAdd then
    sValue = "+" .. sValue
  end
  return sValue
end

function SoldierCharAttriTipsCtrl:OnBtnClick_Close()
  self._mapNode.aniRoot:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.3, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCharAttriTips)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function SoldierCharAttriTipsCtrl:OnBtnClick_Switch()
  self.bSwitchCharGrowth = not self.bSwitchCharGrowth
  if self.bSwitchCharGrowth then
    self._mapNode.aniSwitch:Play("CharAttriTipsSwitch_2")
  else
    self._mapNode.aniSwitch:Play("CharAttriTipsSwitch_1")
  end
  self:SetSwitchBtnShow()
  self:_RefreshAttrItems(self._nCharId, self._bShowSwitchBtn and self.bSwitchCharGrowth)
end

return SoldierCharAttriTipsCtrl
