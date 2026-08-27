local UINEpCommonModeSelectDiffNode = class("UINEpCommonModeSelectDiffNode", UIBaseNode)
local base = UIBaseNode
local StageChallengeData = require("Game.StageChallenge.Data.StageChallengeData")
local UINEpCommonModeSelectDiffItem = require("Game.CommonUI.ModeSelect.UINEpCommonModeSelectDiffItem")
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local cs_MessageCommon = CS.MessageCommon
local EpCommonModeSelectUtil = require("Game.CommonUI.ModeSelect.EpCommonModeSelectUtil")
local UINEpCommonModeSelectDiffInfinityNode = require("Game.CommonUI.ModeSelect.UINEpCommonModeSelectDiffInfinityNode")
local EpInifinityData = require("Game.CommonUI.ModeSelect.Data.EpInifinityData")

function UINEpCommonModeSelectDiffNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if not IsNull(self.ui.btn_Back) then
    UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnClickCloseMode)
  end
  self._itemPool = UIItemPool.New(UINEpCommonModeSelectDiffItem, self.ui.modeItems)
  self.ui.modeItems:SetActive(false)
  self.infinityItem = UINEpCommonModeSelectDiffInfinityNode.New()
  self.infinityItem:Init(self.ui.obj_UnlimitedItem)
  self.infinityItem:Hide()
  self._switchChallengeTog = UINCommonSwitchToggle.New()
  self._switchChallengeTog:Init(self.ui.tog_SwitchChallenge)
  self._switchChallengeTog:CommonSwitchTogAutoSetValue(false)
  self._setChallengeModeOpen = BindCallback(self, self._SetChallengeModeOpen)
  UIUtil.AddButtonListener(self.ui.btn_Challenge, self, self._OnClickChallenge)
  UIUtil.AddButtonListener(self.ui.btn_QuickBattle, self, self.__OnClickSpring23QuickBattle)
  UIUtil.AddButtonListener(self.ui.btn_QuickBattleTip, self, self.__OnClickQuickBattleTip)
  self.__OnSelectItemCallback = BindCallback(self, self.__OnSelectItem)
  self._OnQuickBattleCompleteFunc = BindCallback(self, self._OnQuickBattleComplete)
  MsgCenter:AddListener(eMsgEventId.OnEpQuickBattleComplete, self._OnQuickBattleCompleteFunc)
  self._OnCommonDayPassFunc = BindCallback(self, self._OnCommonDayPass)
  MsgCenter:AddListener(eMsgEventId.OnCommonDayPass, self._OnCommonDayPassFunc)
end

function UINEpCommonModeSelectDiffNode:InitSpring23SelectMode(modeData, envId, selectCallback, closeCallback, quickBattleCallback)
  self.__curIndex = nil
  self.__isEpInifinity = nil
  self._modeData = modeData
  self._mainCfg = modeData:getMainCfg()
  self._envId = envId
  self._selectCallback = selectCallback
  self._closeCallback = closeCallback
  self._quickBattleCallback = quickBattleCallback
  self._itemPool:HideAll()
  local envCfg = ConfigData.act_general_ep_env[envId]
  for index, diffId in ipairs(envCfg.difficulty_des) do
    local diffCfg = ConfigData.act_general_ep_difficulty[diffId]
    if EpCommonModeSelectUtil.IsEpCommonInfinity(diffId) then
      if #envCfg.use_team == 1 then
        self.__epInifinitySelectedTeamId = envCfg.use_team[1]
        self.__epInifinityData = EpInifinityData.New()
        self.__epInifinityData:InitEpInifinityDataByTeamId(self.__epInifinitySelectedTeamId)
      else
        print("todo 可选存档的形式")
      end
      self:InitInfinityMode(index, diffCfg)
    elseif EpCommonModeSelectUtil.IsEpCommonEnvHaveDiff(envId, diffId, index) then
      local item = self._itemPool:GetOne()
      local isUnlock, unlockDes = EpCommonModeSelectUtil.IsEpCommonDiffUnlock(envId, diffId, index)
      item:InitModelDiffItem(diffCfg, index, self.__OnSelectItemCallback, self._mainCfg)
      item:SetModelDiffItemUnLocke(isUnlock, unlockDes)
    end
  end
  TimerManager:AddLateCommand(function()
    cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.itemList)
    local defaultSelect = self._itemPool.listItem[1]
    self:__OnSelectItem(defaultSelect)
  end)
end

function UINEpCommonModeSelectDiffNode:__OnSelectItem(item)
  if item == nil then
    return
  end
  if not item.isUnlock then
    return
  end
  local diffcultyInfoCfg, index = item:GetModeItemDiffInfoCfg()
  if self.__curIndex == index then
    return
  end
  self.__curIndex = index
  self.__diffcultyInfoCfg = diffcultyInfoCfg
  self.__isEpInifinity = nil
  self.infinityItem:SetIsSelected(false)
  local selectDiffId = diffcultyInfoCfg.difficulty_id
  local selectIndex = index
  self.ui.select:SetActive(true)
  self.ui.select.transform:SetParent(item.transform)
  self.ui.select.transform:SetAsFirstSibling()
  self.ui.select.transform.anchoredPosition = Vector2.zero
  if self._selectCallback ~= nil then
    self._selectCallback(selectDiffId, selectIndex)
  end
  self:RefreshSpring23ChallengeMode(selectIndex, diffcultyInfoCfg)
  self:RefreshSpring23QuickBattle(diffcultyInfoCfg)
end

function UINEpCommonModeSelectDiffNode:RefreshSpring23ChallengeMode(index, diffcultyInfoCfg)
  self._stgChallengeData = nil
  self.ui.btn_Challenge.gameObject:SetActive(false)
  if self.__isEpInifinity then
    return
  end
  local envCfg = ConfigData.act_general_ep_env[self._envId]
  local stageId = envCfg.stage_id[index]
  if stageId == nil then
    return
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg == nil then
    return
  end
  if not PlayerDataCenter.sectorAchievementDatas:HasStageChallengeTask(stageCfg.id) then
    return
  end
  self.ui.btn_Challenge.gameObject:SetActive(true)
  self._stgChallengeData = StageChallengeData.Create(stageCfg.id)
  local isOpen = PlayerDataCenter.sectorAchievementDatas:IsStageChallengeTaskOpen(stageCfg.id)
  self._clgIsCompleteStageUnlock = diffcultyInfoCfg.challenge_unlock
  if self._clgIsCompleteStageUnlock then
    self.ui.img_LockChallenge:SetActive(not isOpen)
  else
    self.ui.img_LockChallenge:SetActive(false)
  end
  local isChallengeMode = false
  if isOpen then
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    isChallengeMode = saveUserData:GetChallengeStageSwitch(stageCfg.id)
  end
  self._stgChallengeData:SetStageChallengeOpen(isChallengeMode)
  self._switchChallengeTog:InitCommonSwitchToggle(isChallengeMode, self._setChallengeModeOpen)
end

function UINEpCommonModeSelectDiffNode:InitInfinityMode(index, diffCfg)
  self.infinityItem:InitEpCommonModeSelectDiffInfinityNode(self._modeData, diffCfg, self.__epInifinityData, function()
    self.__isEpInifinity = true
    self.__curIndex = index
    self.__diffcultyInfoCfg = diffCfg
    self.ui.select:SetActive(false)
    if self._selectCallback ~= nil then
      self._selectCallback(diffCfg.difficulty_id, index)
    end
    self:RefreshSpring23ChallengeMode(nil, nil)
    self:RefreshSpring23QuickBattle(nil)
  end)
  self.infinityItem:Show()
end

function UINEpCommonModeSelectDiffNode:_SetChallengeModeOpen(isChallengeMode, notOpen)
  if self._clgIsCompleteStageUnlock and not self._stgChallengeData:IsChallengeTaskUnlcok() then
    return
  end
  if not notOpen and self._stgChallengeData:IsStageChallengeOpen() == isChallengeMode then
    return
  end
  if isChallengeMode and not notOpen then
    UIManager:ShowWindowAsync(UIWindowTypeID.FmtChallengeInfo, function(win)
      if win == nil then
        return
      end
      win:InitFmtChallengeInfo(self._stgChallengeData)
      win:SetCustomLeftTip(ConfigData:GetTipContent(20009))
    end)
  end
  self._stgChallengeData:SetStageChallengeOpen(isChallengeMode)
  self._switchChallengeTog:SetCommonSwitchToggleValue(isChallengeMode)
end

function UINEpCommonModeSelectDiffNode:_OnClickChallenge()
  if self._stgChallengeData == nil then
    return
  end
  if self._clgIsCompleteStageUnlock and not self._stgChallengeData:IsChallengeTaskUnlcok() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FmtChallengeInfo, function(win)
    if win == nil then
      return
    end
    win:InitFmtChallengeInfo(self._stgChallengeData, function()
      if self._stgChallengeData:IsStageChallengeOpen() then
        return
      end
      self:_SetChallengeModeOpen(true, true)
    end)
    win:SetCustomLeftTip(ConfigData:GetTipContent(20009))
  end)
end

function UINEpCommonModeSelectDiffNode:GetSatgeChallengeData()
  return self._stgChallengeData
end

function UINEpCommonModeSelectDiffNode:GetEpInifinityData()
  if not self.__isEpInifinity then
    return nil
  end
  return self.__epInifinityData
end

function UINEpCommonModeSelectDiffNode:_QuickBattleIsOpen()
  if self._stgChallengeData ~= nil or self.__diffcultyInfoCfg.is_quick then
    return true
  end
  return
end

function UINEpCommonModeSelectDiffNode:RefreshSpring23QuickBattle(diffcultyInfoCfg)
  self.ui.btn_QuickBattle.gameObject:SetActive(false)
  if not self:_QuickBattleIsOpen() then
    return
  end
  local envCfg = ConfigData.act_general_ep_env[self._envId]
  local stageId = envCfg.stage_id[self.__curIndex]
  local isCouldUse = PlayerDataCenter.sectorStage:GetIsStagePassedWithoutHelp(stageId)
  self.ui.tex_QuickBattleDes:SetIndex(3)
  if isCouldUse then
    self:_UpdQuickBattleNum()
  else
    self.ui.tex_QuickBattleDes:SetIndex(self._stgChallengeData ~= nil and 0 or 2)
  end
  self.ui.img_LockQuickBattle:SetActive(not isCouldUse)
  self.ui.btn_QuickBattle.gameObject:SetActive(true)
end

function UINEpCommonModeSelectDiffNode:__OnClickSpring23QuickBattle()
  if not self:_QuickBattleIsOpen() then
    return
  end
  local envCfg = ConfigData.act_general_ep_env[self._envId]
  local stageId = envCfg.stage_id[self.__curIndex]
  local isCouldUse = PlayerDataCenter.sectorStage:GetIsStagePassedWithoutHelp(stageId)
  if not isCouldUse then
    return
  end
  local quickBattlLimitTimes = self.__diffcultyInfoCfg.quick_daily_time
  if 0 < quickBattlLimitTimes then
    local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass)
    local cusNum = timePassCtrl:GetEpQuickBattleNum(stageId)
    if quickBattlLimitTimes <= cusNum then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(2907))
      return
    end
  end
  if self._quickBattleCallback ~= nil then
    self._quickBattleCallback()
  end
end

function UINEpCommonModeSelectDiffNode:__OnClickQuickBattleTip()
  UIManager:CreateWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfoByRule(21)
  end)
end

function UINEpCommonModeSelectDiffNode:_OnCommonDayPass()
  self:_UpdQuickBattleNum()
end

function UINEpCommonModeSelectDiffNode:_OnQuickBattleComplete()
  self:_UpdQuickBattleNum()
  local diffItem = self._itemPool.listItem[self.__curIndex]
  if diffItem then
    diffItem:UpdIsHaveDropEpCmDiffItem()
  end
end

function UINEpCommonModeSelectDiffNode:_UpdQuickBattleNum()
  if not self:_QuickBattleIsOpen() then
    return
  end
  local envCfg = ConfigData.act_general_ep_env[self._envId]
  local stageId = envCfg.stage_id[self.__curIndex]
  local isCouldUse = PlayerDataCenter.sectorStage:GetIsStagePassedWithoutHelp(stageId)
  if not isCouldUse then
    return
  end
  local quickBattlLimitTimes = self.__diffcultyInfoCfg.quick_daily_time
  if 0 < quickBattlLimitTimes then
    local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass)
    local cusNum = timePassCtrl:GetEpQuickBattleNum(stageId)
    self.ui.tex_QuickBattleDes:SetIndex(1, tostring(quickBattlLimitTimes - cusNum), tostring(quickBattlLimitTimes))
  end
end

function UINEpCommonModeSelectDiffNode:OnClickCloseMode()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
end

function UINEpCommonModeSelectDiffNode:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnEpQuickBattleComplete, self._OnQuickBattleCompleteFunc)
  MsgCenter:RemoveListener(eMsgEventId.OnCommonDayPass, self._OnCommonDayPassFunc)
  self.infinityItem:Delete()
  base.OnDelete(self)
end

return UINEpCommonModeSelectDiffNode
