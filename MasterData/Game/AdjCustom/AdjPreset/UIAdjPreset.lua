local UIAdjPreset = class("UIAdjPreset", UIBaseWindow)
local base = UIBaseWindow
local UINAdjPresetSingleItem = require("Game.AdjCustom.AdjPreset.UINAdjPresetSingleItem")
local UINAdjPresetMultItem = require("Game.AdjCustom.AdjPreset.UINAdjPresetMultItem")
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local CS_ResLoader = CS.ResLoader

function UIAdjPreset:OnInit()
  UIUtil.SetTopStatus(self, self.__BackAdjPresetWin, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Random, self, self.OnClickRandomPreset)
  UIUtil.AddButtonListener(self.ui.btn_HideText, self, self.OnClickHideText)
  self._singlePool = UIItemPool.New(UINAdjPresetSingleItem, self.ui.presetSingleItem)
  self.ui.presetSingleItem:SetActive(false)
  self._multItem = UINAdjPresetMultItem.New()
  self._multItem:Init(self.ui.presetMultItem)
  self._multItem:Hide()
  self._presetIDItemDic = nil
  self.__OnSelectCallback = BindCallback(self, self.__OnSelect)
  self.__OnEnterEditCallback = BindCallback(self, self.__OnEnterEdit)
  self.__OnBackPresetCallback = BindCallback(self, self.__OnBackPreset)
  self._resloader = CS_ResLoader.Create()
  self.__RefreshItemCallback = BindCallback(self, self.__RefreshItem)
  MsgCenter:AddListener(eMsgEventId.AdjCustomModify, self.__RefreshItemCallback)
  self.__RefreshLockStateCallback = BindCallback(self, self.__RefreshLockState)
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__RefreshLockStateCallback)
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI:OpenOtherCoverWin()
  end
  self._switchRandomMainPresentTog = UINCommonSwitchToggle.New()
  self._switchRandomMainPresentTog:Init(self.ui.tog_SwitchRandomMainPresent)
  self._switchHideTextTog = UINCommonSwitchToggle.New()
  self._switchHideTextTog:Init(self.ui.tog_SwitchHideText)
end

function UIAdjPreset:InitAdjPreset(callback)
  local allAdjCustomData = PlayerDataCenter.allAdjCustomData
  self.allAdjCustomData = allAdjCustomData
  self._callback = callback
  self._singlePool:HideAll()
  self._multItem:Hide()
  self._curSelect = allAdjCustomData:GetUsingAdjCustomPresetId()
  self._presetIDItemDic = {}
  for i = 1, ConfigData.game_config.adjCustomTeamMax do
    local item
    if ConfigData.game_config.adjCustomMultDic[i] then
      item = self._multItem
      item:Show()
    else
      item = self._singlePool:GetOne()
    end
    item:InitAdjPresetItem(i, self._resloader, self.__OnSelectCallback, self.__OnEnterEditCallback)
    self._presetIDItemDic[i] = item
  end
  local selectItem = self._presetIDItemDic[self._curSelect or 0]
  if selectItem ~= nil then
    selectItem:SetSelectAdjPresetItemState(true)
  end
  local isRandomMainPresent = allAdjCustomData:IsRandomMainPresent()
  self.isRandomMainPresent = isRandomMainPresent
  self._switchRandomMainPresentTog:InitCommonSwitchToggle(self.isRandomMainPresent, nil)
  local isHideText = allAdjCustomData:IsHideText()
  self.isHideText = isHideText
  self._switchHideTextTog:InitCommonSwitchToggle(not self.isHideText, nil)
  local nowNum = self._curSelect
  nowNum = math.clamp(nowNum, 1, ConfigData.game_config.adjCustomTeamMax)
  local offsetNum = 1 < ConfigData.game_config.adjCustomTeamMax and (nowNum - 1) / (ConfigData.game_config.adjCustomTeamMax - 2) or 0
  self.ui.rect_single.horizontalNormalizedPosition = offsetNum
end

function UIAdjPreset:__RefreshView()
  for k, item in pairs(self._presetIDItemDic) do
    item:RefreshAdjPresetItem()
    item:SetSelectAdjPresetItemState(k == self._curSelect)
  end
end

function UIAdjPreset:__RefreshItem(id)
  self:__RefreshView()
end

function UIAdjPreset:__RefreshLockState()
  for k, item in pairs(self._presetIDItemDic) do
    item:RefreshAdjLockState()
  end
end

function UIAdjPreset:__OnSelect(teamId)
  if self._curSelect == teamId then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.AdjCustom)
  network:CS_MainInterface_PresetChange(teamId, function()
    local selectItem = self._presetIDItemDic[self._curSelect or 0]
    if selectItem ~= nil then
      selectItem:SetSelectAdjPresetItemState(false)
    end
    self._curSelect = teamId
    local selectItem = self._presetIDItemDic[self._curSelect or 0]
    if selectItem ~= nil then
      selectItem:SetSelectAdjPresetItemState(true)
    end
  end)
end

function UIAdjPreset:__OnEnterEdit(teamId, index)
  UIManager:ShowWindowAsync(UIWindowTypeID.AdjEditor, function(window)
    if window == nil then
      return
    end
    self:Hide()
    window:InitUIAdjEditor(teamId, index, self.__OnBackPresetCallback)
  end)
end

function UIAdjPreset:__OnBackPreset()
  self:Show()
end

function UIAdjPreset:OnClickConfirm()
  UIUtil.OnClickBackByUiTab(self)
end

function UIAdjPreset:OnClickRandomPreset()
  self.isRandomMainPresent = not self.isRandomMainPresent
  if self._switchRandomMainPresentTog ~= nil then
    self._switchRandomMainPresentTog:SetCommonSwitchToggleValue(self.isRandomMainPresent)
  end
end

function UIAdjPreset:OnClickHideText()
  self.isHideText = not self.isHideText
  if self._switchHideTextTog ~= nil then
    self._switchHideTextTog:SetCommonSwitchToggleValue(not self.isHideText)
  end
end

function UIAdjPreset:SaveRandomPreset()
  local allAdjCustomData = self.allAdjCustomData
  if allAdjCustomData == nil then
    return
  end
  if self.isRandomMainPresent == nil then
    return
  end
  if self._switchRandomMainPresentTog == nil then
    return
  end
  local originIsRandomMainPresent = allAdjCustomData:IsRandomMainPresent()
  if self.isRandomMainPresent ~= originIsRandomMainPresent then
    local newIsRandomMainPresent = self.isRandomMainPresent
    local network = NetworkManager:GetNetwork(NetworkTypeID.AdjCustom)
    if network ~= nil then
      network:CS_MainInterface_RandomTog(newIsRandomMainPresent, function()
        if self._switchRandomMainPresentTog ~= nil then
          self._switchRandomMainPresentTog:SetCommonSwitchToggleValue(newIsRandomMainPresent)
        end
      end)
    end
  end
end

function UIAdjPreset:SaveHideText()
  local allAdjCustomData = self.allAdjCustomData
  if allAdjCustomData == nil then
    return
  end
  if self.isHideText == nil then
    return
  end
  if self._switchHideTextTog == nil then
    return
  end
  local originIsHideText = allAdjCustomData:IsHideText()
  if self.isHideText ~= originIsHideText then
    local newIsHideText = self.isHideText
    local network = NetworkManager:GetNetwork(NetworkTypeID.AdjCustom)
    if network ~= nil then
      network:CS_MainInterface_Setting(newIsHideText, function()
        if self._switchHideTextTog ~= nil then
          self._switchHideTextTog:SetCommonSwitchToggleValue(not newIsHideText)
        end
      end)
    end
  end
end

function UIAdjPreset:__BackAdjPresetWin()
  self:Delete()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI:BackFromOtherCoverWin()
  end
  if self._callback ~= nil then
    self._callback()
  end
end

function UIAdjPreset:OnDelete()
  base.OnDelete(self)
  self:SaveRandomPreset()
  self:SaveHideText()
  self._multItem:Delete()
  self._singlePool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.AdjCustomModify, self.__RefreshItemCallback)
  MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__RefreshLockStateCallback)
  if self._switchRandomMainPresentTog ~= nil then
    self._switchRandomMainPresentTog:Delete()
    self._switchRandomMainPresentTog = nil
  end
  if self._switchHideTextTog ~= nil then
    self._switchHideTextTog:Delete()
    self._switchHideTextTog = nil
  end
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
end

return UIAdjPreset
