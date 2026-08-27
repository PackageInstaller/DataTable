local UINSpring23ModeSelectDiffNode = class("UINSpring23ModeSelectDiffNode", UIBaseNode)
local base = UIBaseNode
local StageChallengeData = require("Game.StageChallenge.Data.StageChallengeData")
local UINSpring23ModeSelectDiffItem = require("Game.ActivitySpring.UI.SelectLevel.UINSpring23ModeSelectDiffItem")
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local cs_MessageCommon = CS.MessageCommon

function UINSpring23ModeSelectDiffNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if not IsNull(self.ui.btn_Back) then
    UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnClickCloseMode)
  end
  self._itemPool = UIItemPool.New(UINSpring23ModeSelectDiffItem, self.ui.modeItems)
  self.ui.modeItems:SetActive(false)
  self._switchChallengeTog = UINCommonSwitchToggle.New()
  self._switchChallengeTog:Init(self.ui.tog_SwitchChallenge)
  self._switchChallengeTog:CommonSwitchTogAutoSetValue(false)
  self._setChallengeModeOpen = BindCallback(self, self._SetChallengeModeOpen)
  UIUtil.AddButtonListener(self.ui.btn_Challenge, self, self._OnClickChallenge)
  UIUtil.AddButtonListener(self.ui.btn_QuickBattle, self, self.__OnClickSpring23QuickBattle)
  self.__OnSelectItemCallback = BindCallback(self, self.__OnSelectItem)
end

function UINSpring23ModeSelectDiffNode:InitSpring23SelectMode(actSpringData, envId, selectCallback, closeCallback, quickBattleCallback)
  self._data = actSpringData
  self._envId = envId
  self._selectCallback = selectCallback
  self._closeCallback = closeCallback
  self._quickBattleCallback = quickBattleCallback
  self._itemPool:HideAll()
  local envCfg = ConfigData.activity_spring_advanced_env[envId]
  for index, diffId in ipairs(envCfg.difficulty_des) do
    local diffCfg = ConfigData.activity_spring_difficulty[diffId]
    if self._data:IsSpring23EnvHaveDiff(envId, diffId, index) then
      local item = self._itemPool:GetOne()
      local isUnlock, unlockDes = self._data:IsSpring23DiffUnlock(envId, diffId, index)
      item:InitModelDiffItem(diffCfg, index, self.__OnSelectItemCallback)
      item:SetModelDiffItemUnLocke(isUnlock, unlockDes)
    end
  end
  TimerManager:AddLateCommand(function()
    cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.itemList)
    local defaultSelect = self._itemPool.listItem[1]
    self:__OnSelectItem(defaultSelect)
  end)
end

function UINSpring23ModeSelectDiffNode:__OnSelectItem(item)
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
  local selectDiffId = diffcultyInfoCfg.difficulty_id
  local selectIndex = index
  self.ui.select:SetActive(true)
  self.ui.select.transform.position = item.transform.position
  if self._selectCallback ~= nil then
    self._selectCallback(selectDiffId, selectIndex)
  end
  self:RefreshSpring23ChallengeMode(selectIndex)
  self:RefreshSpring23QuickBattle()
end

function UINSpring23ModeSelectDiffNode:RefreshSpring23ChallengeMode(index)
  self._stgChallengeData = nil
  self.ui.btn_Challenge.gameObject:SetActive(false)
  local envCfg = ConfigData.activity_spring_advanced_env[self._envId]
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
  local isChallengeMode = false
  if PlayerDataCenter.sectorAchievementDatas:IsStageChallengeTaskOpen(stageCfg.id) then
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    isChallengeMode = saveUserData:GetChallengeStageSwitch(stageCfg.id)
  end
  self._stgChallengeData:SetStageChallengeOpen(isChallengeMode)
  self._switchChallengeTog:InitCommonSwitchToggle(isChallengeMode, self._setChallengeModeOpen)
end

function UINSpring23ModeSelectDiffNode:_SetChallengeModeOpen(isChallengeMode, notOpen)
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

function UINSpring23ModeSelectDiffNode:_OnClickChallenge()
  if self._stgChallengeData == nil then
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

function UINSpring23ModeSelectDiffNode:GetSatgeChallengeData()
  return self._stgChallengeData
end

function UINSpring23ModeSelectDiffNode:RefreshSpring23QuickBattle()
  self.ui.btn_QuickBattle.gameObject:SetActive(false)
  if self._stgChallengeData == nil then
    return
  end
  local envCfg = ConfigData.activity_spring_advanced_env[self._envId]
  local stageId = envCfg.stage_id[self.__curIndex]
  local isCouldUse = PlayerDataCenter.sectorStage:GetIsStagePassedWithoutHelp(stageId)
  if not isCouldUse then
    self.ui.img_bottom.color = self.ui.color_gray
    self.ui.text_quickBattle.color = self.ui.color_gray
    self.ui.img_cost.color = self.ui.color_gray
    self.ui.tex_Cost.color = self.ui.color_gray
  else
    self.ui.img_bottom.color = Color.white
    self.ui.text_quickBattle.color = Color.white
    self.ui.img_cost.color = Color.white
    self.ui.tex_Cost.color = Color.white
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  local costStamina = stageCfg.cost_strength_num
  self.ui.tex_Cost.text = "-" .. tostring(costStamina)
  self.ui.btn_QuickBattle.gameObject:SetActive(true)
end

function UINSpring23ModeSelectDiffNode:__OnClickSpring23QuickBattle()
  if self._stgChallengeData == nil then
    return
  end
  local envCfg = ConfigData.activity_spring_advanced_env[self._envId]
  local stageId = envCfg.stage_id[self.__curIndex]
  local isCouldUse = PlayerDataCenter.sectorStage:GetIsStagePassedWithoutHelp(stageId)
  if isCouldUse and self._quickBattleCallback ~= nil then
    self._quickBattleCallback()
  end
end

function UINSpring23ModeSelectDiffNode:OnClickCloseMode()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
end

return UINSpring23ModeSelectDiffNode
