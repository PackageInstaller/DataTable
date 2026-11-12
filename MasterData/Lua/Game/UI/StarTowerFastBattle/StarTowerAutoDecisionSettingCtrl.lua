local StarTowerAutoDecisionSettingCtrl = class("StarTowerAutoDecisionSettingCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local StarTowerSettingGate = require("Game.Adventure.StarTower.StarTowerSettingGate")
local ClientManager = CS.ClientManager
StarTowerAutoDecisionSettingCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  goContentAnim = {},
  animRoot = {
    sNodeName = "goContentAnim",
    sComponentName = "Animator"
  },
  presetListLSV = {
    sComponentName = "LoopScrollView"
  },
  txtPresetTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDecision_PresetSelect"
  },
  btnClosePanel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePanel"
  },
  txtTime = {sComponentName = "TMP_Text"},
  txtBtnReset = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDecision_PresetReset"
  },
  btnResetPlan = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reset"
  },
  btnRename = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Rename"
  },
  txtPresetName = {sComponentName = "TMP_Text"},
  goRename = {
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerAutoDecisionRenameCtrl"
  },
  PresetFirst = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  PresetOnly = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  PotentialSort = {
    sCtrlName = "Game.UI.Settings.OptionMultiSelect"
  },
  txtTitlePotential = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDecision_Potential"
  },
  PotentialReroll = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  PotentialRerollCoin = {
    sCtrlName = "Game.UI.TemplateEx.TemplateSimpleQuantitySelectorCtrl"
  },
  txtPotentialRerollCoin = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDecision_PotentialCoinRerollNum"
  },
  PriorityConsumption = {
    sCtrlName = "Game.UI.Settings.OptionChooseCtrl"
  },
  ShopSelect = {
    sCtrlName = "Game.UI.Settings.OptionMultiSelect"
  },
  goShopDropdown = {
    sCtrlName = "Game.UI.TemplateEx.TemplateDropdownCtrl"
  },
  txtTitleShop = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDecision_Shop"
  },
  txtShopUpgrade = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDecision_ShopUpgradePrice"
  },
  ShopCoin = {
    sCtrlName = "Game.UI.TemplateEx.TemplateSimpleQuantitySelectorCtrl"
  },
  txtShopCoinReroll = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDecision_PotentialCoinRerollNum"
  },
  ShopRefresh = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  LastStageRefresh = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  LastStageAllin = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  txtTitleEvent = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDecision_Event"
  },
  TendencySelect = {
    sCtrlName = "Game.UI.Settings.OptionChooseCtrl"
  },
  EventSelect = {
    sCtrlName = "Game.UI.Settings.OptionMultiSelect"
  },
  txtTokenBar = {sComponentName = "TMP_Text"},
  rtTokenBarFill = {
    sComponentName = "RectTransform"
  },
  btnAddToken = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AddToken"
  }
}
StarTowerAutoDecisionSettingCtrl._mapEventConfig = {
  CloseAutoDecisionSetting = "OnEvent_CloseAutoDecisionSetting",
  SelectTemplateDD = "OnEvent_ShopDropdown",
  RefreshTokenItemList = "RefreshTokenValue"
}

local function _GetOptionTextList(mapConfig)
  local tbOptionTextList = {}
  if mapConfig ~= nil then
    local sKey = "OptionText"
    for i = 1, 10 do
      local sThisKey = sKey .. i
      local sValue = mapConfig[sThisKey]
      if sValue ~= nil and sValue ~= "" then
        table.insert(tbOptionTextList, sValue)
      else
        break
      end
    end
  end
  return tbOptionTextList
end

local function _IsArrayEqual(tbLeft, tbRight)
  if type(tbLeft) ~= "table" or type(tbRight) ~= "table" then
    return tbLeft == tbRight
  end
  if #tbLeft ~= #tbRight then
    return false
  end
  for i = 1, #tbLeft do
    if tbLeft[i] ~= tbRight[i] then
      return false
    end
  end
  return true
end

local function _GetOptionListValue(mapOption)
  if type(mapOption) ~= "table" or type(mapOption.List) ~= "table" then
    return nil
  end
  return mapOption.List.Values or mapOption.List.List or mapOption.List.Value
end

local function _IsServerOptionEqual(mapLeft, mapRight)
  if type(mapLeft) ~= "table" or type(mapRight) ~= "table" then
    return mapLeft == mapRight
  end
  if mapLeft.Id ~= mapRight.Id then
    return false
  end
  if mapLeft.Boolean ~= mapRight.Boolean or mapLeft.Integer ~= mapRight.Integer then
    return false
  end
  return _IsArrayEqual(_GetOptionListValue(mapLeft), _GetOptionListValue(mapRight))
end

local function _IsServerProjectEqual(mapLeft, mapRight)
  if type(mapLeft) ~= "table" or type(mapRight) ~= "table" then
    return mapLeft == mapRight
  end
  if mapLeft.Id ~= mapRight.Id then
    return false
  end
  if mapLeft.Name ~= mapRight.Name then
    return false
  end
  local tbLeftOptions = mapLeft.Options or {}
  local tbRightOptions = mapRight.Options or {}
  if #tbLeftOptions ~= #tbRightOptions then
    return false
  end
  for i = 1, #tbLeftOptions do
    if not _IsServerOptionEqual(tbLeftOptions[i], tbRightOptions[i]) then
      return false
    end
  end
  return true
end

function StarTowerAutoDecisionSettingCtrl:CacheOriginalServerProject()
  self.mapOriginalServerProjectByPlanId = {}
  self.mapOriginalDirtyByPlanId = {}
  for _, mapPlan in pairs(self.tbPresetList or {}) do
    self.mapOriginalServerProjectByPlanId[mapPlan.nPlanId] = PlayerData.StarTowerAutoPlan:BuildServerProject(mapPlan.nPlanId)
    self.mapOriginalDirtyByPlanId[mapPlan.nPlanId] = PlayerData.StarTowerAutoPlan:IsDirty(mapPlan.nPlanId)
  end
end

function StarTowerAutoDecisionSettingCtrl:RefreshPresetList()
  if self.nCurSelectIndex == nil or self.nCurSelectIndex <= 0 then
    self.nCurSelectIndex = PlayerData.StarTowerAutoPlan:GetSelectedPlanId()
  end
  self.tbPresetList = PlayerData.StarTowerAutoPlan:GetPlanList(true)
  self.tbGoGrid = {}
  self._mapNode.presetListLSV:Init(#self.tbPresetList, self, self.OnGridRefresh, self.OnGridClick)
end

function StarTowerAutoDecisionSettingCtrl:OnGridRefresh(go, nGridIndex)
  local nIndex = nGridIndex + 1
  if self.tbGoGrid[nIndex] == nil then
    self.tbGoGrid[nIndex] = go
  end
  local imgSelectBg = go.transform:Find("btnGrid/AnimRoot/phoneItem/imgSelectBg")
  imgSelectBg.gameObject:SetActive(nIndex == self.nCurSelectIndex)
  local imgChoose = go.transform:Find("btnGrid/AnimRoot/phoneItem/imgChoose")
  imgChoose.gameObject:SetActive(nIndex == self.nCurSelectIndex)
  local txtName = go.transform:Find("btnGrid/AnimRoot/phoneItem/goNormal/txtName"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtName, self.tbPresetList[nIndex].sName)
  local txtName1 = go.transform:Find("btnGrid/AnimRoot/phoneItem/imgSelectBg/txtName1"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtName1, self.tbPresetList[nIndex].sName)
end

function StarTowerAutoDecisionSettingCtrl:OnGridClick(go, nGridIndex)
  local nIndex = nGridIndex + 1
  self.nCurSelectIndex = nIndex
  for k, v in pairs(self.tbGoGrid) do
    local imgSelectBg = v.transform:Find("btnGrid/AnimRoot/phoneItem/imgSelectBg")
    imgSelectBg.gameObject:SetActive(k == self.nCurSelectIndex)
    local imgChoose = v.transform:Find("btnGrid/AnimRoot/phoneItem/imgChoose")
    imgChoose.gameObject:SetActive(k == self.nCurSelectIndex)
  end
  self:RefreshPresetDetail()
  local sCurPlanName = self.tbPresetList[nIndex].sName
  local sTip = orderedFormat(ConfigTable.GetUIText("AutoDecision_SelectPlanTip"), sCurPlanName)
  EventManager.Hit(EventId.OpenMessageBox, sTip)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function StarTowerAutoDecisionSettingCtrl:RefreshPresetBase()
  self._mapNode.PresetFirst:SetText(ConfigTable.GetUIText("AutoDecision_PresetFirst"))
  local func_Handler = ui_handler(self, self.OnBtnClick_PresetSwitch)
  self._mapNode.PresetFirst:Init(func_Handler, true)
  self._mapNode.PresetFirst:SetEnable(true)
  self._mapNode.PresetOnly:SetText(ConfigTable.GetUIText("AutoDecision_PresetOnly"))
  func_Handler = ui_handler(self, self.OnBtnClick_PresetOnlySwitch)
  local sPresetOnlyLockTxt = orderedFormat(ConfigTable.GetUIText("AutoDecision_SettingLock"), ConfigTable.GetUIText("AutoDecision_PresetFirst"))
  self._mapNode.PresetOnly:Init(func_Handler, true, sPresetOnlyLockTxt)
  local mapConfigPotentialSort = ConfigTable.GetData("TowerVitaOption", AllEnum.StarTowerAutoDecisionSettings.PotentialSort)
  local tbPotentialSortOption = _GetOptionTextList(mapConfigPotentialSort)
  func_Handler = ui_handler(self, self.OnBtnClick_PotentialSort)
  self._mapNode.PotentialSort:Init(tbPotentialSortOption, ConfigTable.GetUIText("AutoDecision_PotentialSort"), func_Handler)
  self._mapNode.PotentialReroll:SetText(ConfigTable.GetUIText("AutoDecision_PotentialNoMatchReroll"))
  func_Handler = ui_handler(self, self.OnBtnClick_PotentialRerollSwitch)
  self._mapNode.PotentialReroll:Init(func_Handler, true)
  func_Handler = ui_handler(self, self.OnBtnClick_PotentialRerollCoin)
  local sGrayText = ConfigTable.GetUIText("AutoDecision_PotentialRefreshGray")
  self._mapNode.PotentialRerollCoin:Init(1000, 100, func_Handler, sGrayText)
  local mapConfigShopSort = ConfigTable.GetData("TowerVitaOption", AllEnum.StarTowerAutoDecisionSettings.ShopSort)
  local tbShopSortOption = _GetOptionTextList(mapConfigShopSort)
  func_Handler = ui_handler(self, self.OnBtnClick_ShopSort)
  self._mapNode.ShopSelect:Init(tbShopSortOption, ConfigTable.GetUIText("AutoDecision_ShopSort"), func_Handler)
  self._mapNode.ShopRefresh:SetText(ConfigTable.GetUIText("AutoDecision_ShopCoinReroll"))
  func_Handler = ui_handler(self, self.OnBtnClick_ShopRefreshSwitch)
  self._mapNode.ShopRefresh:Init(func_Handler, true)
  func_Handler = ui_handler(self, self.OnBtnClick_ShopCoin)
  local sShopGrayText = ConfigTable.GetUIText("AutoDecision_ShopRefreshGray")
  self._mapNode.ShopCoin:Init(1000, 100, func_Handler, sShopGrayText)
  self._mapNode.LastStageRefresh:SetText(ConfigTable.GetUIText("AutoDecision_ShopFinalReroll"))
  func_Handler = ui_handler(self, self.OnBtnClick_ShopFinalRerollSwitch)
  self._mapNode.LastStageRefresh:Init(func_Handler, true)
  self._mapNode.LastStageAllin:SetText(ConfigTable.GetUIText("AutoDecision_ShopFinalAllIn"))
  func_Handler = ui_handler(self, self.OnBtnClick_ShopFinalAllInSwitch)
  self._mapNode.LastStageAllin:Init(func_Handler, true)
  local mapConfigEventSort = ConfigTable.GetData("TowerVitaOption", AllEnum.StarTowerAutoDecisionSettings.EventSort)
  local tbEventSortOption = _GetOptionTextList(mapConfigEventSort)
  func_Handler = ui_handler(self, self.OnBtnClick_EventSort)
  self._mapNode.EventSelect:Init(tbEventSortOption, ConfigTable.GetUIText("AutoDecision_EventSort"), func_Handler)
end

function StarTowerAutoDecisionSettingCtrl:RefreshPresetDetail()
  self.mapCurPreset = self.tbPresetList[self.nCurSelectIndex]
  NovaAPI.SetTMPText(self._mapNode.txtPresetName, self.mapCurPreset.sName)
  self._mapNode.PresetFirst:SetOn(self.mapCurPreset.mapPotential.bPresetFirst)
  if not self.mapCurPreset.mapPotential.bPresetFirst then
    self.mapCurPreset.mapPotential.bPresetOnly = false
  end
  self._mapNode.PresetOnly:SetOn(self.mapCurPreset.mapPotential.bPresetOnly)
  self._mapNode.PresetOnly:SetEnable(self.mapCurPreset.mapPotential.bPresetFirst)
  self._mapNode.PotentialSort:SetSelect(self.mapCurPreset.mapPotential.tbPotentialSort)
  self._mapNode.PotentialReroll:SetOn(self.mapCurPreset.mapPotential.bPotentialReroll)
  self._mapNode.PotentialRerollCoin:SetGray(not self.mapCurPreset.mapPotential.bPotentialReroll)
  self._mapNode.PotentialRerollCoin:SetValue(self.mapCurPreset.mapPotential.nPotentialRerollCoinNum)
  local mapConfigShopChoose = ConfigTable.GetData("TowerVitaOption", AllEnum.StarTowerAutoDecisionSettings.ShopFirstChoose)
  local tbShopChooseOption = _GetOptionTextList(mapConfigShopChoose)
  self.nShopChooseOptionCount = #tbShopChooseOption
  func_Handler = ui_handler(self, self.OnBtnClick_ShopChoose)
  self._mapNode.PriorityConsumption:Init(func_Handler, self.mapCurPreset.mapShop.nShopFirst, self.nShopChooseOptionCount)
  self._mapNode.PriorityConsumption:SetText(tbShopChooseOption[1], tbShopChooseOption[2], tbShopChooseOption[3], ConfigTable.GetUIText("AutoDecision_ShopFirst"))
  local mapConfigShopDropdown = ConfigTable.GetData("TowerVitaOption", AllEnum.StarTowerAutoDecisionSettings.ShopUpgradeDropdown)
  self.tbDropdownOption = _GetOptionTextList(mapConfigShopDropdown)
  local nRecordValue = self.mapCurPreset.mapShop.nShopUpgradePrice
  local nDropdownValue = 0
  for nIndex, sValue in ipairs(self.tbDropdownOption) do
    if tonumber(sValue) == nRecordValue then
      nDropdownValue = nIndex - 1
      break
    end
  end
  self._mapNode.goShopDropdown:SetList(self.tbDropdownOption, nDropdownValue, true)
  self._mapNode.ShopSelect:SetSelect(self.mapCurPreset.mapShop.tbShopSort)
  self._mapNode.ShopRefresh:SetOn(self.mapCurPreset.mapShop.bShopCoinReroll)
  self._mapNode.ShopCoin:SetGray(not self.mapCurPreset.mapShop.bShopCoinReroll)
  self._mapNode.ShopCoin:SetValue(self.mapCurPreset.mapShop.nShopCoinNum)
  self._mapNode.LastStageRefresh:SetOn(self.mapCurPreset.mapShop.bShopFinalReroll)
  self._mapNode.LastStageAllin:SetOn(self.mapCurPreset.mapShop.bShopFinalAllIn)
  local mapConfigTendency = ConfigTable.GetData("TowerVitaOption", AllEnum.StarTowerAutoDecisionSettings.EventTendency)
  local tbTendencyOption = _GetOptionTextList(mapConfigTendency)
  self.nTendencyCount = #tbTendencyOption
  func_Handler = ui_handler(self, self.OnBtnClick_TendencySelect)
  self._mapNode.TendencySelect:Init(func_Handler, self.mapCurPreset.mapEvent.nEventTendency, self.nTendencyCount)
  self._mapNode.TendencySelect:SetText(tbTendencyOption[1], tbTendencyOption[2], tbTendencyOption[3], ConfigTable.GetUIText("AutoDecision_EventTendency"))
  self._mapNode.EventSelect:SetSelect(self.mapCurPreset.mapEvent.tbEventSort)
end

local nMaxBarLength = 344

function StarTowerAutoDecisionSettingCtrl:RefreshTokenValue()
  local nTokenCount = PlayerData.StarTowerAutoPlan:GetTokenCount()
  local nMaxTokenCount = PlayerData.StarTowerAutoPlan:GetMaxTokenCount()
  local nRatio = nTokenCount / nMaxTokenCount
  if nRatio < 0.01 and 0 < nRatio then
    nRatio = 0.01
  end
  NovaAPI.SetTMPText(self._mapNode.txtTokenBar, math.floor(nRatio * 100) .. "%")
  local nBarLength = nMaxBarLength * nRatio
  self._mapNode.rtTokenBarFill.sizeDelta = Vector2(nBarLength, self._mapNode.rtTokenBarFill.sizeDelta.y)
end

function StarTowerAutoDecisionSettingCtrl:SetTime()
  local curTime = ClientManager.serverTimeStamp
  NovaAPI.SetTMPText(self._mapNode.txtTime, (os.date("%H:%M", curTime)))
end

function StarTowerAutoDecisionSettingCtrl:ShowPhoneTime()
  self:SetTime()
  if nil == self.phoneTimer then
    self.phoneTimer = self:AddTimer(0, 1, "SetTime", true, true, true)
  end
end

function StarTowerAutoDecisionSettingCtrl:Awake()
  self._mapNode.imgBlurredBg:SetActive(false)
  self._mapNode.goContentAnim:SetActive(false)
end

function StarTowerAutoDecisionSettingCtrl:OnEnable()
  self._bSettingActive = true
  self.tbPresetList = nil
  self.phoneTimer = nil
  self.nCurSelectIndex = 0
  if PanelManager.CheckPanelOpen(PanelId.StarTowerFastBattle) then
    local canvas = self.gameObject:GetComponent("Canvas")
    NovaAPI.SetCanvasSortingOrder(canvas, AllEnum.UI_SORTING_ORDER.StarTowerAutoDecisionSetting)
  end
  GamepadUIManager.EnableGamepadUI("StarTowerAutoDecisionSettingCtrl", {}, nil, true, false, self._panel._nIndex)
  EventManager.Hit("StarTowerAutoDecisionSettingStateChanged", true)
  
  local function wait()
    self._mapNode.imgBlurredBg:SetActive(true)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if not self._bSettingActive then
      return
    end
    self._mapNode.goContentAnim:SetActive(true)
    self.nCurSelectIndex = 0
    
    local function init()
      if not self._bSettingActive then
        return
      end
      self:ShowPhoneTime()
      self:RefreshTokenValue()
      self:RefreshPresetList()
      self:RefreshPresetBase()
      self:RefreshPresetDetail()
      self:CacheOriginalServerProject()
    end
    
    PlayerData.StarTowerAutoPlan:EnsureInited(init)
  end
  
  cs_coroutine.start(wait)
end

function StarTowerAutoDecisionSettingCtrl:OnDisable()
  self._bSettingActive = false
  if self.phoneTimer ~= nil then
    self.phoneTimer:Cancel()
    self.phoneTimer = nil
  end
  StarTowerSettingGate.ResumeAfterSetting()
  GamepadUIManager.DisableGamepadUI("StarTowerAutoDecisionSettingCtrl")
  if self.tbPresetList == nil or self.nCurSelectIndex == nil or self.nCurSelectIndex <= 0 then
    EventManager.Hit("StarTowerAutoDecisionSettingStateChanged", false)
    return
  end
  for k, v in pairs(self.tbPresetList) do
    PlayerData.StarTowerAutoPlan:UpdatePlanFromDecisionPlan(v.nPlanId, v)
    local mapOriginalProject = self.mapOriginalServerProjectByPlanId and self.mapOriginalServerProjectByPlanId[v.nPlanId] or nil
    local mapCurProject = PlayerData.StarTowerAutoPlan:BuildServerProject(v.nPlanId)
    local bOriginalDirty = self.mapOriginalDirtyByPlanId and self.mapOriginalDirtyByPlanId[v.nPlanId]
    if bOriginalDirty ~= true and _IsServerProjectEqual(mapOriginalProject, mapCurProject) then
      PlayerData.StarTowerAutoPlan:ClearDirty(v.nPlanId)
    end
  end
  PlayerData.StarTowerAutoPlan:SyncDirtyPlans()
  PlayerData.StarTowerAutoPlan:SendSetSelectedPlanId(self.nCurSelectIndex)
  EventManager.Hit("StarTowerAutoDecisionSettingStateChanged", false)
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_Reset()
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sTitle = ConfigTable.GetUIText("AutoDecision_ResetConfirmTitle"),
    sContent = ConfigTable.GetUIText("AutoDecision_ResetConfirm"),
    callbackConfirm = function()
      self.tbPresetList[self.nCurSelectIndex] = PlayerData.StarTowerAutoPlan:GetDefaultPlan(self.tbPresetList[self.nCurSelectIndex].nPlanId)
      self:RefreshPresetDetail()
      self:RefreshPresetList()
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_Rename()
  local function cb(sNewName)
    self:RefreshPresetList()
    
    self:RefreshPresetDetail()
  end
  
  self._mapNode.goRename:Open(self.tbPresetList[self.nCurSelectIndex], cb)
end

function StarTowerAutoDecisionSettingCtrl:OnEvent_CloseAutoDecisionSetting()
  EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerAutoDecisionSettingPanel)
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_ClosePanel()
  self._mapNode.animRoot:Play("PhonePanel_out")
  local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
    "PhonePanel_out"
  })
  self:AddTimer(1, nAnimLength, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerAutoDecisionSettingPanel)
  end)
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_PresetSwitch(_, bOn)
  self.mapCurPreset.mapPotential.bPresetFirst = bOn
  if not bOn then
    self.mapCurPreset.mapPotential.bPresetOnly = false
    self._mapNode.PresetOnly:SetOn(false)
  end
  self._mapNode.PresetOnly:SetEnable(bOn)
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_PresetOnlySwitch(_, bOn)
  self.mapCurPreset.mapPotential.bPresetOnly = bOn
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_PotentialSort(_, tbCurSelect)
  self.mapCurPreset.mapPotential.tbPotentialSort = tbCurSelect
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_PotentialRerollSwitch(_, bOn)
  self.mapCurPreset.mapPotential.bPotentialReroll = bOn
  self._mapNode.PotentialRerollCoin:SetGray(not bOn)
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_PotentialRerollCoin(_, nAmount)
  self.mapCurPreset.mapPotential.nPotentialRerollCoinNum = nAmount
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_ShopChoose(_, nChosenIndex)
  self.mapCurPreset.mapShop.nShopFirst = nChosenIndex
end

function StarTowerAutoDecisionSettingCtrl:OnEvent_ShopDropdown(nDropdownValue)
  local nOptionIndex = nDropdownValue + 1
  local nUpgradePrice = tonumber(self.tbDropdownOption[nOptionIndex])
  if nUpgradePrice ~= nil then
    self.mapCurPreset.mapShop.nShopUpgradePrice = nUpgradePrice
  end
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_ShopSort(_, tbCurSelect)
  self.mapCurPreset.mapShop.tbShopSort = tbCurSelect
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_ShopRefreshSwitch(_, bOn)
  self.mapCurPreset.mapShop.bShopCoinReroll = bOn
  self._mapNode.ShopCoin:SetGray(not bOn)
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_ShopFinalAllInSwitch(_, bOn)
  self.mapCurPreset.mapShop.bShopFinalAllIn = bOn
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_ShopCoin(_, nAmount)
  self.mapCurPreset.mapShop.nShopCoinNum = nAmount
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_ShopFinalRerollSwitch(_, bOn)
  self.mapCurPreset.mapShop.bShopFinalReroll = bOn
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_TendencySelect(_, nChosenIndex)
  self.mapCurPreset.mapEvent.nEventTendency = nChosenIndex
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_EventSort(_, tbCurSelect)
  self.mapCurPreset.mapEvent.tbEventSort = tbCurSelect
end

function StarTowerAutoDecisionSettingCtrl:OnBtnClick_AddToken()
  EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerTokenBuyPanel)
end

return StarTowerAutoDecisionSettingCtrl
