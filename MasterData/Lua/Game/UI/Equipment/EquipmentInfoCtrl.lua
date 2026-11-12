local EquipmentInfoCtrl = class("EquipmentInfoCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
EquipmentInfoCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnCloseBg = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  txtWindowTitle = {sComponentName = "TMP_Text"},
  window = {},
  aniWindow = {sNodeName = "window", sComponentName = "Animator"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnNext = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Next"
  },
  btnPre = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Pre"
  },
  btnNextLock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NextLock"
  },
  btnPreLock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_PreLock"
  },
  txtEquipmentName = {nCount = 2, sComponentName = "TMP_Text"},
  imgEquipmentUp = {nCount = 2},
  goPoint = {},
  trPoint = {sComponentName = "Transform"},
  imgIcon = {nCount = 2, sComponentName = "Transform"},
  txtEquiped = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Equipped"
  },
  imgEquiped = {},
  txtLockSwitch = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Roll_LockRoll"
  },
  btnSwitch = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Switch"
  },
  aniIconMask = {sNodeName = "IconMask", sComponentName = "Animator"},
  goSwitch = {},
  Info = {sNodeName = "--Info--"},
  aniInfo = {sNodeName = "--Info--", sComponentName = "Animator"},
  goProperty = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateRandomPropertyCtrl"
  },
  btnEquip = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Equip"
  },
  btnRoll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Roll"
  },
  btnUnload = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Unload"
  },
  btnUpgrade = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Upgrade"
  },
  txtBtnEquip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_Equip"
  },
  txtBtnRoll = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_GotoRoll"
  },
  txtBtnUnload = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_Unload"
  },
  txtBtnUpgrade = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_Upgrade"
  },
  Active = {sNodeName = "--Active--"},
  txtTitleMat = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Active_Material"
  },
  goMat = {
    sCtrlName = "Game.UI.TemplateEx.TemplateMatCtrl"
  },
  btnAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_MatTip"
  },
  txtActiveTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Active_AttrTip"
  },
  btnActive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Active"
  },
  txtBtnActive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_Active"
  },
  FX = {sNodeName = "--FX--"}
}
EquipmentInfoCtrl._mapEventConfig = {}

function EquipmentInfoCtrl:Open()
  self._mapNode.blur:SetActive(true)
  self:PlayInAni()
  self:Init()
  self:Refresh()
  self:RefreshPoint()
end

function EquipmentInfoCtrl:Init()
  local nGemId = PlayerData.Equipment:GetGemIdBySlot(self.nCharId, self.nSlotId)
  self.mapGemCfg = ConfigTable.GetData("CharGem", nGemId)
  self.mapSlotCfg = ConfigTable.GetData("CharGemSlotControl", self.nSlotId)
  self.nSubSelectIndex = 1
  self.tbEquipmentIcon = {}
  for i = 1, 2 do
    local equipPrefab
    local sPrefab = self.mapGemCfg.Icon .. ".prefab"
    if GameResourceLoader.ExistsAsset(Settings.AB_ROOT_PATH .. sPrefab) == true then
      equipPrefab = self:LoadAsset(sPrefab)
    end
    if equipPrefab then
      delChildren(self._mapNode.imgIcon[i])
      self.tbEquipmentIcon[i] = instantiate(equipPrefab, self._mapNode.imgIcon[i])
    end
  end
  self.tbPoint = {}
  delChildren(self._mapNode.trPoint)
  for i = 1, self.mapSlotCfg.MaxAlterNum do
    local obj = instantiate(self._mapNode.goPoint, self._mapNode.trPoint)
    obj:SetActive(true)
    table.insert(self.tbPoint, obj)
  end
end

function EquipmentInfoCtrl:Refresh(bAfterActive)
  local tbEquipment = PlayerData.Equipment:GetEquipmentBySlot(self.nCharId, self.nSlotId)
  local mapEquipment = tbEquipment[self.nSelectGemIndex]
  local bEmpty = mapEquipment == nil
  self:RefreshTop()
  self:RefreshSwitch(tbEquipment)
  if bAfterActive then
    self._mapNode.FX:SetActive(false)
    self._mapNode.FX:SetActive(true)
    
    local function callback()
      self._mapNode.Info:SetActive(not bEmpty)
      self._mapNode.Active:SetActive(bEmpty)
      self._mapNode.aniInfo:Play("EquipmentInfoPanel_Info")
      WwiseAudioMgr:PostEvent("ui_charInfo_equipment_coagulate_ani")
    end
    
    self:AddTimer(1, 0.07, callback, true, true, true)
  else
    self._mapNode.Info:SetActive(not bEmpty)
    self._mapNode.Active:SetActive(bEmpty)
  end
  if not bEmpty then
    self:RefreshInfo(mapEquipment)
  else
    self:RefreshActive()
  end
end

function EquipmentInfoCtrl:RefreshSwitch(tbEquipment)
  local nCount = 0
  for i = 1, self.mapSlotCfg.MaxAlterNum do
    if tbEquipment[i] ~= nil then
      nCount = nCount + 1
    end
  end
  if nCount >= self.mapSlotCfg.MaxAlterNum - 1 then
    self._mapNode.btnPre.gameObject:SetActive(true)
    self._mapNode.btnPreLock.gameObject:SetActive(false)
    self._mapNode.btnNext.gameObject:SetActive(true)
    self._mapNode.btnNextLock.gameObject:SetActive(false)
    return
  end
  local bCurEmpty = tbEquipment[self.nSelectGemIndex] == nil
  local nNext = 0
  if self.mapSlotCfg.MaxAlterNum == self.nSelectGemIndex then
    nNext = 1
  else
    nNext = self.nSelectGemIndex + 1
  end
  local bNextEmpty = tbEquipment[nNext] == nil
  self._mapNode.btnNext.gameObject:SetActive(not bCurEmpty or not bNextEmpty)
  self._mapNode.btnNextLock.gameObject:SetActive(bCurEmpty and bNextEmpty)
  self._mapNode.btnPre.gameObject:SetActive(1 < self.nSelectGemIndex)
  self._mapNode.btnPreLock.gameObject:SetActive(self.nSelectGemIndex == 1)
end

function EquipmentInfoCtrl:RefreshTop()
  local sRoman = ConfigTable.GetUIText("RomanNumeral_" .. self.nSelectGemIndex)
  local sSuf = orderedFormat(ConfigTable.GetUIText("Equipment_NameIndexSuffix"), sRoman)
  NovaAPI.SetTMPText(self._mapNode.txtEquipmentName[self.nSubSelectIndex], self.mapGemCfg.Title .. sSuf)
  self._mapNode.imgEquiped:SetActive(self.nEquipedGemIndex == self.nSelectGemIndex)
  local tbEquipment = PlayerData.Equipment:GetEquipmentBySlot(self.nCharId, self.nSlotId)
  local mapEquipment = tbEquipment[self.nSelectGemIndex]
  local bUpgrade = mapEquipment and mapEquipment:GetUpgradeCount() > 0
  self._mapNode.imgEquipmentUp[self.nSubSelectIndex]:SetActive(bUpgrade)
  if self.tbEquipmentIcon[self.nSubSelectIndex] then
    self.tbEquipmentIcon[self.nSubSelectIndex].transform:Find("goFx").gameObject:SetActive(bUpgrade)
  end
  self:RefreshLock()
end

function EquipmentInfoCtrl:RefreshInfo(mapEquipment)
  NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, ConfigTable.GetUIText("Equipment_Title_Info"))
  self._mapNode.btnEquip.gameObject:SetActive(self.nEquipedGemIndex ~= self.nSelectGemIndex)
  self._mapNode.btnUnload.gameObject:SetActive(self.nEquipedGemIndex == self.nSelectGemIndex)
  if self.nEquipedGemIndex == 0 then
    NovaAPI.SetTMPText(self._mapNode.txtBtnEquip, ConfigTable.GetUIText("Equipment_Btn_Equip"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtBtnEquip, ConfigTable.GetUIText("Equipment_Btn_Replace"))
  end
  for i = 1, 4 do
    self._mapNode.goProperty[i]:SetProperty(mapEquipment.tbAffix[i], self.nCharId, false, mapEquipment.tbUpgradeCount[i])
  end
end

function EquipmentInfoCtrl:RefreshActive()
  NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, ConfigTable.GetUIText("Equipment_Title_Active"))
  self._mapNode.goMat:SetMat(self.mapGemCfg.GenerateCostTid, self.mapSlotCfg.GeneratenCostQty)
end

function EquipmentInfoCtrl:RefreshPoint()
  local tbEquipment = PlayerData.Equipment:GetEquipmentBySlot(self.nCharId, self.nSlotId)
  local bFirstEmpty = true
  for i = 1, self.mapSlotCfg.MaxAlterNum do
    local obj = self.tbPoint[i]
    local on = obj.transform:Find("imgPointOn").gameObject
    local off = obj.transform:Find("imgPointOff").gameObject
    local lock = obj.transform:Find("imgPointLock").gameObject
    local mapEquipment = tbEquipment[i]
    local bEmpty = mapEquipment == nil
    local bLock = not bFirstEmpty and bEmpty
    if bFirstEmpty and bEmpty then
      bFirstEmpty = false
    end
    on:SetActive(self.nSelectGemIndex == i)
    off:SetActive(self.nSelectGemIndex ~= i and not bLock)
    lock:SetActive(bLock)
  end
end

function EquipmentInfoCtrl:RefreshSelectPoint(nBefore, nAfter)
  local goBefore = self.tbPoint[nBefore]
  goBefore.transform:Find("imgPointOn").gameObject:SetActive(false)
  goBefore.transform:Find("imgPointOff").gameObject:SetActive(true)
  local goCur = self.tbPoint[nAfter]
  goCur.transform:Find("imgPointOn").gameObject:SetActive(true)
  goCur.transform:Find("imgPointOff").gameObject:SetActive(false)
end

function EquipmentInfoCtrl:RefreshLock()
  local tbEquipment = PlayerData.Equipment:GetEquipmentBySlot(self.nCharId, self.nSlotId)
  local mapEquipment = tbEquipment[self.nSelectGemIndex]
  local bEmpty = mapEquipment == nil
  self._mapNode.goSwitch:SetActive(not bEmpty)
  if not bEmpty then
    self._mapNode.btnSwitch[1].gameObject:SetActive(not mapEquipment.bLock)
    self._mapNode.btnSwitch[2].gameObject:SetActive(mapEquipment.bLock)
  end
end

function EquipmentInfoCtrl:PlayInAni()
  self._mapNode.window:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function EquipmentInfoCtrl:PlayOutAni()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, "Close", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function EquipmentInfoCtrl:Close()
  self._mapNode.window:SetActive(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.EquipmentInfo)
end

function EquipmentInfoCtrl:Awake()
  self._mapNode.window:SetActive(false)
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nCharId = tbParam[1]
    self.nSlotId = tbParam[2]
    self.nEquipedGemIndex = tbParam[3]
    self.nSelectGemIndex = tbParam[4]
    if self.nSelectGemIndex == nil then
      self.nSelectGemIndex = self.nEquipedGemIndex == 0 and 1 or self.nEquipedGemIndex
    end
    PlayerData.Equipment:CacheEquipmentSelect(self.nSlotId, self.nSelectGemIndex, self.nCharId)
  end
end

function EquipmentInfoCtrl:OnEnable()
  self:Open()
end

function EquipmentInfoCtrl:OnDisable()
  if self.timer ~= nil then
    self.timer:Cancel()
  end
end

function EquipmentInfoCtrl:OnDestroy()
end

function EquipmentInfoCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

function EquipmentInfoCtrl:OnBtnClick_Next()
  if self.timer ~= nil then
    self.timer:Cancel()
  end
  local nBefore = self.nSelectGemIndex
  if self.mapSlotCfg.MaxAlterNum == self.nSelectGemIndex then
    self.nSelectGemIndex = 1
  else
    self.nSelectGemIndex = self.nSelectGemIndex + 1
  end
  PlayerData.Equipment:CacheEquipmentSelect(self.nSlotId, self.nSelectGemIndex, self.nCharId)
  self.nSubSelectIndex = 2
  self._mapNode.aniIconMask:Play("IconMaskSwitch_R")
  self:RefreshSelectPoint(nBefore, self.nSelectGemIndex)
  self:Refresh()
  
  local function callback()
    self.nSubSelectIndex = 1
    self:RefreshTop()
  end
  
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.aniIconMask, {
    "IconMaskSwitch_R"
  })
  self.timer = self:AddTimer(1, nAnimTime, callback, true, true, true)
end

function EquipmentInfoCtrl:OnBtnClick_Pre()
  if self.timer ~= nil then
    self.timer:Cancel()
  end
  local nBefore = self.nSelectGemIndex
  if 1 == self.nSelectGemIndex then
    self.nSelectGemIndex = self.mapSlotCfg.MaxAlterNum
  else
    self.nSelectGemIndex = self.nSelectGemIndex - 1
  end
  PlayerData.Equipment:CacheEquipmentSelect(self.nSlotId, self.nSelectGemIndex, self.nCharId)
  self.nSubSelectIndex = 2
  self._mapNode.aniIconMask:Play("IconMaskSwitch_L")
  self:RefreshSelectPoint(nBefore, self.nSelectGemIndex)
  self:Refresh()
  
  local function callback()
    self.nSubSelectIndex = 1
    self:RefreshTop()
  end
  
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.aniIconMask, {
    "IconMaskSwitch_L"
  })
  self.timer = self:AddTimer(1, nAnimTime, callback, true, true, true)
end

function EquipmentInfoCtrl:OnBtnClick_NextLock()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_SlotGemEmpty"))
end

function EquipmentInfoCtrl:OnBtnClick_PreLock()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_SlotGemEmpty"))
end

function EquipmentInfoCtrl:OnBtnClick_Equip()
  local nSelectPreset = PlayerData.Equipment:GetSelectPreset(self.nCharId)
  
  local function callback()
    self.nEquipedGemIndex = self.nSelectGemIndex
    self:Refresh()
    EventManager.Hit("EquipmentSlotChanged")
  end
  
  PlayerData.Equipment:SendCharGemEquipGemReq(self.nCharId, self.nSlotId, self.nSelectGemIndex, nSelectPreset, callback)
end

function EquipmentInfoCtrl:OnBtnClick_Roll()
  EventManager.Hit(EventId.ClosePanel, PanelId.EquipmentInfo)
  EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentRoll, self.nCharId, self.nSlotId, self.nSelectGemIndex, self.nEquipedGemIndex)
end

function EquipmentInfoCtrl:OnBtnClick_Unload()
  local nSelectPreset = PlayerData.Equipment:GetSelectPreset(self.nCharId)
  
  local function callback()
    self.nEquipedGemIndex = 0
    self:Refresh()
    EventManager.Hit("EquipmentSlotChanged")
  end
  
  PlayerData.Equipment:SendCharGemEquipGemReq(self.nCharId, self.nSlotId, 0, nSelectPreset, callback)
end

function EquipmentInfoCtrl:OnBtnClick_Upgrade()
  local tbEquipment = PlayerData.Equipment:GetEquipmentBySlot(self.nCharId, self.nSlotId)
  local mapEquipment = tbEquipment[self.nSelectGemIndex]
  if mapEquipment and mapEquipment.bLock then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_UpgradeAfterUnlock"))
    return
  end
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, function()
    PlayerData.Equipment:ClearEquipmentSelect()
    EventManager.Hit(EventId.ClosePanel, PanelId.EquipmentInfo)
    EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentUpgrade, self.nCharId, self.nSlotId, self.nSelectGemIndex)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function EquipmentInfoCtrl:OnBtnClick_MatTip(btn)
  if self.mapGemCfg.GenerateCostTid > 0 then
    local mapData = {
      nTid = self.mapGemCfg.GenerateCostTid,
      nNeedCount = self.mapSlotCfg.GeneratenCostQty,
      bShowDepot = true,
      bShowJumpto = true
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
  end
end

function EquipmentInfoCtrl:OnBtnClick_Active()
  local nHas = PlayerData.Item:GetItemCountByID(self.mapGemCfg.GenerateCostTid)
  if nHas < self.mapSlotCfg.GeneratenCostQty then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_MatNotEnough_Active"))
    self:OnBtnClick_MatTip(self._mapNode.btnAdd)
    return
  end
  
  local function callback()
    self:RefreshPoint()
    PlayerData.Equipment:CacheEquipmentSelect(self.nSlotId, self.nSelectGemIndex, self.nCharId)
    self:Refresh(true)
  end
  
  PlayerData.Equipment:SendCharGemGenerateReq(self.nCharId, self.nSlotId, self.nSelectGemIndex, callback)
end

function EquipmentInfoCtrl:OnBtnClick_Switch(btn, nIndex)
  local bLock = nIndex == 1
  
  local function callback()
    self:RefreshLock()
  end
  
  PlayerData.Equipment:SendCharGemUpdateGemLockStatusReq(self.nCharId, self.nSlotId, self.nSelectGemIndex, bLock, callback)
end

return EquipmentInfoCtrl
