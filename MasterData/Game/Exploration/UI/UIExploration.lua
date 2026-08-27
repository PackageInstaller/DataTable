local UIExploration = class("UIExploration", UIBaseWindow)
local base = UIBaseWindow
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local WCEnum = require("Game.WeeklyChallenge.WCEnum")
local UINMonsterLevel = require("Game.Exploration.UI.MonsterLevel.UINMonsterLevel")
local UINEpTaskItemDetail = require("Game.Exploration.UI.EpTask.UINEpTaskItemDetail")
local EpCommonUtil = require("Game.Exploration.Util.EpCommonUtil")
local UINAutoModuleSwitch = require("Game.Exploration.UI.AutoMode.UINAutoModuleSwitch")
local cs_MessageCommon = CS.MessageCommon

function UIExploration:OnInit()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
  end
  self.resloader = CS.ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_Deploy, self, self.OnBtnDeployClicked)
  UIUtil.AddButtonListener(self.ui.btn_Retreat, self, self.OnBtnRetreatClicked)
  UIUtil.AddButtonListener(self.ui.btn_EpStore, self, self.OnBtnStoreClicked)
  UIUtil.AddButtonListener(self.ui.btn_RewardBag, self, self._OnClickRewardBag)
  UIUtil.AddButtonListener(self.ui.btn_ChipBag, self, self.OnClickChipPreview)
  self.monsterLevelNode = UINMonsterLevel.New()
  self.monsterLevelNode:Init(self.ui.monsterLevel)
  self.monsterLevelNode:Hide()
  local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
  if not isUnlockBattleExit then
    self.ui.btn_Retreat.gameObject:SetActive(false)
  end
  local isUnlockBattleDeploy = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleDeploy)
  if not isUnlockBattleDeploy then
    self.ui.btn_Deploy.gameObject:SetActive(false)
  end
  if ExplorationManager.epCtrl:GetSupportAutoEpType() == ExplorationEnum.eAutoEpSwitchType.EpWindow then
    self.__showAutoEpBtn = EpCommonUtil.IsSupportEpAutoMode()
  else
    self.__showAutoEpBtn = false
  end
  if self.__showAutoEpBtn then
    self.__autoSwitchNode = UINAutoModuleSwitch.New()
    self.__autoSwitchNode:Init(self.ui.autoModuleNode)
    self.__autoSwitchNode:Show()
    local defaultAuto = ExplorationManager.epCtrl.autoCtrl:IsDefaultAutoEp()
    if defaultAuto then
      self.__autoSwitchNode:RefreshAutoModeState(true, true)
    end
  else
    self.ui.autoModuleNode:SetActive(false)
  end
  if ExplorationManager.epCtrl.overclockCtrl:IsLevelHasOverclock() then
    self.ui.btn_Overclock.gameObject:SetActive(true)
    UIUtil.AddButtonListener(self.ui.btn_Overclock, self, self.OnBtnOverclockClicked)
  end
  self.hasEpRewardBag = ExplorationManager:HasEpRewardBag()
  self.ui.btn_RewardBag.gameObject:SetActive(self.hasEpRewardBag)
  self.__onRefreshFightingPower = BindCallback(self, self.__RefreshFightingPower)
  MsgCenter:AddListener(eMsgEventId.OnEpPlayerFightPowerChang, self.__onRefreshFightingPower)
  self.ui.btn_EpStore.gameObject:SetActive(ExplorationManager.epCtrl.residentStoreCtrl:HasEpResidentStore())
  self.ui.obj_epTaskItem:SetActive(false)
  self.ui.obj_epTaskDetail:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_CloseEpTaskDetail, self, self.OnCloseEpTaskDetailClick)
  self.ui.btn_CloseEpTaskDetail.gameObject:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_ShowScore, self, self.OnClickWcScore)
  self.ui.btn_ShowScore.gameObject:SetActive(ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge)
  self.__OnEpTaskGetListener = BindCallback(self, self.OnEpTaskGetListener)
  MsgCenter:AddListener(eMsgEventId.OnEpOpStore, self.__OnEpTaskGetListener)
  self.__OnEpTaskUpdateListener = BindCallback(self, self.OnEpTaskUpdateListener)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__OnEpTaskUpdateListener)
  self.__OnWcScoreChange = BindCallback(self, self.OnWcScoreChange)
  MsgCenter:AddListener(eMsgEventId.OnWCEpScoreChange, self.__OnWcScoreChange)
  self.__OnChipScoreChange = BindCallback(self, self.RefreshChipScore)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.__OnChipScoreChange)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffListChange, self.__OnChipScoreChange)
  MsgCenter:AddListener(eMsgEventId.OnEpPlayerHeroDataChange, self.__OnChipScoreChange)
  UIUtil.AddButtonListener(self.ui.btn_fxMarkScore, self, self.OnClickFxMarkScore)
  local chipScoreId = ExplorationManager:GetChipScoreId()
  local isShowFxMarkScore = 0 < chipScoreId and not ExplorationManager:IsEpInifinity()
  if isShowFxMarkScore then
    self:RefreshChipScore()
  end
  self.ui.btn_fxMarkScore.gameObject:SetActive(isShowFxMarkScore)
  local overridBgEffectStr = ExplorationManager:GetEpBottomOverride()
  self.resloader:LoadABAssetAsync(PathConsts:GetExplorationBGEffect(overridBgEffectStr), function(prefab)
    if IsNull(prefab) then
      return
    end
    if self.ui == nil then
      return
    end
    if self.ui.obj_background == nil then
      return
    end
    prefab:Instantiate(self.ui.obj_background)
  end)
end

function UIExploration:ShowExplorationFirst(dynPlayer)
  self:RefreshPlayerData(dynPlayer)
  self.monsterLevelNode:InitMonsterLevelUI(dynPlayer)
  self:OnEpTaskGetListener()
  self:OnWcScoreChange(dynPlayer:GetWcCurrentScore())
end

function UIExploration:RefreshPlayerData(playerData)
  self.dnyPlayer = playerData or ExplorationManager:GetDynPlayer()
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  self:__RefreshFightingPower()
  self.ui.tex_Level:SetIndex(0, tostring(ExplorationManager:GetCurLevelIndex() + 1), tostring(ExplorationManager:GetLevelCount()))
end

function UIExploration:__RefreshFightingPower(fightPower)
  local power
  power = fightPower == nil and self.dnyPlayer:GetCacheFightPower() or fightPower
  self.ui.tex_Power.text = tostring(power)
end

function UIExploration:OnBtnDeployClicked()
  ExplorationManager.epCtrl.autoCtrl:DisableEpAutoMode()
  local opDetail = ExplorationManager:GetDynPlayer():GetOperatorDetail()
  if opDetail.state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    return
  end
  if ExplorationManager.epCtrl.autoCtrl:IsAutoModeRunning() then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(283))
    return
  end
  self:Hide()
  ExplorationManager.epCtrl:EnterDeployRoom()
end

function UIExploration:OnBtnRetreatClicked()
  ExplorationManager.epCtrl.autoCtrl:DisableEpAutoMode()
  UIManager:ShowWindowAsync(UIWindowTypeID.BattlePause, function(win)
    if win == nil then
      return
    end
    win:InitBattlePause(function()
      self:_RetreatDungeon()
      AudioManager:PlayAudioById(1082)
    end)
    win:SetAboutBattleUIActive(false)
    win:SetBattlePauseIntro(PicTipsConsts.Exploration)
  end)
end

function UIExploration:_RetreatDungeon()
  if ExplorationManager.epCtrl:IsCompleteExploration() then
    ExplorationManager.epCtrl:StartCompleteExploration()
    return
  end
  if self.hasEpRewardBag then
    local hasReward = ExplorationManager:GetDynPlayer().dynRewardBag:HasEpRewardBagData()
    local msg
    if hasReward then
      msg = ConfigData:GetTipContent(753)
    else
      msg = ConfigData:GetTipContent(752)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageBox, function(win)
      if win == nil then
        return
      end
      win:ShowTextBoxWithYesAndNo(msg, function()
        UIManager:HideWindow(UIWindowTypeID.BattlePause)
        ExplorationManager.epCtrl:ExplorationFailSettle()
      end)
    end)
  elseif ExplorationManager:GetIsInWeeklyChallenge() then
    local msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageBox, function(win)
      if win == nil then
        return
      end
      win:ShowTextBoxWithYesAndNo(msg, function()
        UIManager:HideWindow(UIWindowTypeID.BattlePause)
        ExplorationManager.epCtrl:ExplorationFailSettle()
      end)
    end)
  else
    local returnStamina = ExplorationManager:GetReturnStamina()
    local msg
    if returnStamina <= 0 then
      msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
    else
      msg = string.format(ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpoWithStaminaBack), returnStamina)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageBox, function(win)
      if win == nil then
        return
      end
      win:ShowTextBoxWithYesAndNo(msg, function()
        UIManager:HideWindow(UIWindowTypeID.BattlePause)
        ExplorationManager.resultCtrl:EnterResultProcess(false, true)
      end)
    end)
  end
end

function UIExploration:OnBtnStoreClicked()
  ExplorationManager.epCtrl.autoCtrl:DisableEpAutoMode()
  ExplorationManager.epCtrl:OpenResidentStore()
end

function UIExploration:IsShowAutoEpBtn()
  return self.__showAutoEpBtn
end

function UIExploration:_OnClickRewardBag()
  ExplorationManager.epCtrl.autoCtrl:DisableEpAutoMode()
  UIManager:ShowWindowAsync(UIWindowTypeID.EpRewardPreview, function(window)
    if window == nil then
      return
    end
    local rewardList = ExplorationManager:GetDynPlayer().dynRewardBag:GetEpRewardBagDataList()
    local epModuleId = ExplorationManager:GetEpModuleId()
    local stageId = ExplorationManager:GetEpDungeonId()
    window:InitEpRewardPreview(rewardList, epModuleId, stageId)
  end)
end

function UIExploration:OnClickChipPreview()
  ExplorationManager.epCtrl.autoCtrl:DisableEpAutoMode()
  local chipDataList = ExplorationManager:GetChipDataPreview()
  if chipDataList ~= nil and 0 < #chipDataList then
    UIManager:ShowWindowAsync(UIWindowTypeID.CurrentChip, function(window)
      window:InitCurrentChip(chipDataList)
      window:SetCurrentChipCloseFunc(function()
        UIUtil.SetTopStatusBtnShow(false, false)
      end)
    end)
  end
end

function UIExploration:OnBtnOverclockClicked()
  ExplorationManager.epCtrl.autoCtrl:DisableEpAutoMode()
  ExplorationManager.epCtrl.overclockCtrl:ShowEpOverclockUI()
end

function UIExploration:StartFlyRewardBag()
  if not ExplorationManager:IsInExplorationAndScene() then
    return
  end
  local posItem = ExplorationManager.epCtrl.mapCtrl:GetPlayerPosItem()
  if posItem == nil then
    return
  end
  local pos = posItem.transform.position
  pos = UIManager:World2UIPosition(pos)
  local dpos = self.transform:InverseTransformPoint(self.ui.fx_RewardBag.transform.position)
  local startPos = Vector3.New(pos.x, pos.y)
  local destPos = Vector3.New(dpos.x, dpos.y)
  local width = destPos.x - startPos.x
  local height = startPos.y - destPos.y
  local numPos = #ConfigData.buildinConfig.RewardBagFlyOffset + 2
  self.ui.fx_lineBg.positionCount = numPos
  self.ui.fx_line.positionCount = numPos
  self.ui.fx_lineBg:SetPosition(0, startPos)
  self.ui.fx_line:SetPosition(0, startPos)
  for index, v in pairs(ConfigData.buildinConfig.RewardBagFlyOffset) do
    local x = startPos.x + v[1] * width
    local y = destPos.y + v[2] * height
    local newPos = Vector3.New(x, y, 0)
    self.ui.fx_lineBg:SetPosition(index, newPos)
    self.ui.fx_line:SetPosition(index, newPos)
  end
  self.ui.fx_lineBg:SetPosition(numPos - 1, destPos)
  self.ui.fx_line:SetPosition(numPos - 1, destPos)
  self.ui.fx_RewardFly.gameObject:SetActive(true)
  self.ui.fx_RewardBag:SetActive(false)
  local matBg = self.ui.fx_lineBg:GetMaterial()
  local mat = self.ui.fx_line:GetMaterial()
  matBg:SetFloat("_BFAlpha", 0)
  mat:SetFloat("_BFAlpha", 0)
  mat:SetFloat("_BFPanner01", 0)
  if self.__rewardFlyTween == nil then
    local CS_DOTween = CS.DG.Tweening.DOTween
    local sequence = CS_DOTween.Sequence()
    sequence:SetAutoKill(false)
    sequence:Append(matBg:DOFloat(1, "_BFAlpha", ConfigData.buildinConfig.RewardBagFlyAppear))
    sequence:Join(mat:DOFloat(1, "_BFAlpha", ConfigData.buildinConfig.RewardBagFlyAppear))
    sequence:AppendCallback(function()
      self.ui.fx_RewardBag:SetActive(true)
    end)
    sequence:Append(mat:DOFloat(1, "_BFPanner01", ConfigData.buildinConfig.RewardBagFlyTime))
    sequence:Join(matBg:DOFloat(0, "_BFAlpha", ConfigData.buildinConfig.RewardBagFlyDisappear):SetDelay(ConfigData.buildinConfig.RewardBagFlyTime * ConfigData.buildinConfig.RewardBagDisappearRatio))
    sequence:AppendCallback(function()
      self.ui.fx_RewardFly.gameObject:SetActive(false)
    end)
    self.__rewardFlyTween = sequence
  else
    self.__rewardFlyTween:Restart()
  end
end

function UIExploration:Show(withTween)
  if self.active then
    return
  end
  base.Show(self)
  if withTween then
    self:__ClearFadeTween()
    self.__fadeTween = UIManager:PlayDoFade(self.ui.canvasGroup, 0, 1, 0.5)
  end
end

function UIExploration:Hide(withTween)
  if not self.active then
    return
  end
  base.Hide(self)
  if withTween then
    self:__ClearFadeTween()
    self.__fadeTween = UIManager:PlayDoFade(self.ui.canvasGroup, 1, 0, 0.5)
  end
end

function UIExploration:__ClearFadeTween()
  if self.__fadeTween ~= nil then
    self.__fadeTween:Kill()
    self.__fadeTween = nil
  end
end

function UIExploration:OnEpTaskGetListener()
  local taskId = ExplorationManager.epCtrl.dynPlayer:GetQuestId()
  if (taskId or 0) == 0 then
    if self.epTaskItem ~= nil then
      local isComplete = self.epTaskItem.taskData ~= nil and self.epTaskItem.taskData:CheckComplete()
      self.epTaskItem:ClearTask(isComplete)
    end
    if self.epTaskDetail ~= nil and self.epTaskDetail.active then
      self:OnCloseEpTaskDetailClick()
    end
    return
  end
  if self.epTaskItem == nil then
    self.epTaskItem = self:_InitEpTaskItem()
  end
  self.epTaskItem:Show()
  if taskId ~= self.epTaskItem:GetTaskId() then
    local taskData = PlayerDataCenter.allTaskData.taskDatas[taskId]
    if taskData == nil then
      self.epTaskItem:ClearTask()
      error("epTask error ：data is NIL")
      return
    end
    self.epTaskItem:RefreshItemUI(taskData)
  end
end

function UIExploration:OnEpTaskUpdateListener(taskData)
  if self.epTaskItem ~= nil and self.epTaskItem.taskData == taskData then
    if self.epTaskDetail ~= nil and self.epTaskDetail.active then
      self.epTaskDetail:Hide()
    end
    self.epTaskItem:RefreshProcessUI()
    if taskData:CheckComplete() then
      self.epTaskItem:ShowComplete()
    end
  end
end

function UIExploration:_InitEpTaskItem()
  self._onEpTaskClick = BindCallback(self, self._OnEpTaskClick)
  local UINEpTaskItem = require("Game.Exploration.UI.EpTask.UINEpTaskItem")
  local epTaskItem = UINEpTaskItem.New()
  epTaskItem:Init(self.ui.obj_epTaskItem)
  epTaskItem:SetTaskClickCallback(self._onEpTaskClick)
  return epTaskItem
end

function UIExploration:_OnEpTaskClick()
  if self.epTaskItem.taskData ~= nil and self.epTaskItem.taskData:CheckComplete() then
    local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
    taskCtrl:SendCommitQuestReward(self.epTaskItem.taskData)
    local rewardId = self.epTaskItem.taskData.stcData.rewardIds[1]
    local rewardCount = self.epTaskItem.taskData.stcData.rewardNums[1]
    if rewardId ~= nil then
      local itemCfg = ConfigData.item[rewardId]
      if itemCfg ~= nil then
        CS.MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(119), LanguageUtil.GetLocaleText(itemCfg.name), tostring(rewardCount)))
      end
    end
    return
  end
  if self.epTaskDetail == nil then
    self._onEpTaskDteailClick = BindCallback(self, self._OnEpTaskDteailClick)
    self.epTaskDetail = self:_InitEpTaskDetail()
    self.ui.btn_CloseEpTaskDetail.gameObject:SetActive(true)
  end
  self.epTaskDetail:Show()
  self.ui.btn_CloseEpTaskDetail.gameObject:SetActive(true)
  UIManager:HideWindow(UIWindowTypeID.EpChipSuit)
  self.epTaskItem:Hide()
  local taskData = self.epTaskItem.taskData
  self.epTaskDetail:InitTaskItem(taskData, self._onEpTaskDteailClick, 1)
end

function UIExploration:_InitEpTaskDetail()
  local UINEpTaskDetail = require("Game.Exploration.UI.EpTask.UINEpTaskItemDetail")
  local epTaskDetail = UINEpTaskDetail.New()
  epTaskDetail:Init(self.ui.obj_epTaskDetail)
  return epTaskDetail
end

function UIExploration:_OnEpTaskDteailClick(taskID)
  local taskData = self.epTaskItem.taskData
  local isComplete = taskData ~= nil and taskData:CheckComplete()
  local epNet = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  epNet:CS_EXPLORATION_QuestDrop()
end

function UIExploration:OnCloseEpTaskDetailClick()
  if self.epTaskItem == nil or self.epTaskDetail == nil then
    return
  end
  if self.epTaskItem:GetTaskId() > 0 then
    self.epTaskItem:Show()
  end
  UIManager:ShowWindowOnly(UIWindowTypeID.EpChipSuit)
  self.epTaskDetail:Hide()
  self.ui.btn_CloseEpTaskDetail.gameObject:SetActive(false)
end

function UIExploration:OnClickWcScore()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonTextFrame, function(win)
    if win == nil then
      return
    end
    local curWCScore = ExplorationManager.epCtrl.dynPlayer:GetWcCurrentScore()
    if ExplorationManager:GetEpDungeonId() ~= WCEnum.eWeeklyChallengeId[WCEnum.eWeeklyChallengeType.special] then
      local min, max = ExplorationManager.epCtrl.dynPlayer:GetWcScoreScope()
      win:SetWCScoreText(curWCScore, string.format("[%s-%s]", tostring(min), tostring(max)))
    else
      win:SetWCScoreText(curWCScore)
    end
  end)
end

function UIExploration:OnWcScoreChange(score)
  self.ui.tex_Score.text = tostring(score)
end

function UIExploration:OnClickFxMarkScore()
  UIManager:ShowWindowAsync(UIWindowTypeID.ChipScoreShow, function(win)
    if win == nil then
      return
    end
    win:InitChipScoreShow()
  end)
end

function UIExploration:RefreshChipScore()
  local totalScore = ExplorationManager:GetChipScoreInBattle()
  self.ui.tex_markScore.text = tostring(totalScore)
end

function UIExploration:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerFightPowerChang, self.__onRefreshFightingPower)
  MsgCenter:RemoveListener(eMsgEventId.OnEpOpStore, self.__OnEpTaskGetListener)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__OnEpTaskUpdateListener)
  MsgCenter:RemoveListener(eMsgEventId.OnWCEpScoreChange, self.__OnWcScoreChange)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.__OnChipScoreChange)
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffListChange, self.__OnChipScoreChange)
  MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerHeroDataChange, self.__OnChipScoreChange)
  if self.__rewardFlyTween ~= nil then
    self.__rewardFlyTween:Kill()
    self.__rewardFlyTween = nil
  end
  self.monsterLevelNode:Delete()
  if self.epTaskItem ~= nil then
    self.epTaskItem:Delete()
  end
  if self.epTaskDetail ~= nil then
    self.epTaskDetail:Delete()
  end
  if self.__autoSwitchNode ~= nil then
    self.__autoSwitchNode:Delete()
  end
  self.resloader:Put2Pool()
  base.OnDelete(self)
end

return UIExploration
