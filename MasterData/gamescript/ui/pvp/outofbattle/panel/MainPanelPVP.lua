local PvpType = PvpDefine.PvpType
local BtnType = CommonDefine.BtnType
local SeasonGameplayType = CommonDefine.SeasonGameplayType
local UIAnimationController = CS.Z1Client.UIAnimationController
local MainPanelPVP, Super = System.NewClass("MainPanelPVP", BaseView)
MainPanelPVP.uiResCls = UI_Pvp_Panel_Main_1Resource

function MainPanelPVP:ctor()
  Super.ctor(self)
  self.assumedOpenAnimTime = 0
end

function MainPanelPVP:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Exclamation_Mark, System.fn(self, self._OnClickBtnExclamationMark))
  self:AddButtonClickListener(self.ui.Btn_Ranking, System.fn(self, self._OnClickBtnRanking))
  self:AddButtonClickListener(self.ui.Btn_Record, System.fn(self, self._OnClickBtnRecord))
  self:AddButtonClickListener(self.ui.Btn_Collection, System.fn(self, self._OnClickBtnCollection))
  self:AddButtonClickListener(self.ui.Btn_Expression, System.fn(self, self._OnClickBtnExpression))
  self:AddButtonClickListener(self.ui.Btn_CardEdit, System.fn(self, self._OnClickBtnCardEdit))
  self:AddButtonClickListener(self.ui.Btn_Password, System.fn(self, self._OnClickBtnPassword))
  self:AddButtonClickListener(self.ui.Btn_Reward_Precon, System.fn(self, self._OnClickBtnRewardPrecon))
  self:AddButtonClickListener(self.ui.Btn_Reward_DraftPick, System.fn(self, self._OnClickBtnRewardDraftPick))
  self:AddButtonClickListener(self.ui.Btn_Matching, System.fn(self, self._OnClickMatchBtn))
  self:BindEvent(EventMgr.Instance.OnCareerLevelDataChanged, System.fn(self, self._OnCareerLevelDataChanged))
  self:BindEvent(EventMgr.Instance.RankUpdate, System.fn(self, self._OnRankUpdate))
  self:BindEvent(EventMgr.Instance.TaskViewUpdate, System.fn(self, self._OnTaskViewUpdate))
  self:BindEvent(EventMgr.Instance.OnStoryEnd, function()
    local content = LT.Textf("PVPInstructions", PlayerDataUtils.GetRoleData().dayExp or 0, PlayerDataUtils.GetRoleDayExpLimit())
    PlayerDataUtils.OpenFirstTimeIllustrate(self.__name, nil, content)
  end)
end

function MainPanelPVP:_OnRankUpdate()
  self:_RefreshRankLevel()
end

function MainPanelPVP:_OnCareerLevelDataChanged()
  self:_RefreshCareerLevelRedDot()
  self:_RefreshCareerLevelProgress()
end

function MainPanelPVP:_OnTaskViewUpdate()
  self:_RefreshTaskProgress()
  self:_RefreshSeasonTaskRewardArea()
end

function MainPanelPVP:_OnClickBtnRewardPrecon()
  PvpController.Instance:OpenPvpHistoryLevelView(CareerLevelDefine.CareerLevelType.PvpPreBuilt)
end

function MainPanelPVP:_OnClickBtnRewardDraftPick()
  PvpController.Instance:OpenPvpHistoryLevelView(CareerLevelDefine.CareerLevelType.PvpDraft)
end

function MainPanelPVP:_OnClickBtnExclamationMark()
  UIManager.Instance:Reopen(Urls.PvpillustratePanel)
end

function MainPanelPVP:_OnClickBtnStore()
  if self:_IsPVPShopLocked() then
    self:_ShowPVPShopUnlockTips()
    return
  end
  MainShopDataUtils.OnOpenShop(CommonDefine.MainShopTypeTag.DailyChallenge)
end

function MainPanelPVP:_OnClickBtnRanking()
  UIManager.Instance:Reopen(Urls.PVPRankPanel)
end

function MainPanelPVP:_OnClickBtnRecord()
  PvpController.Instance:OpenPvpTaskView()
end

function MainPanelPVP:_OnClickBtnCollection()
  PVPCollectionDataUtils.OpenCollectionListPanel()
end

function MainPanelPVP:_OnClickBtnExpression()
  UIManager.Instance:Reopen(Urls.EmojiMainView)
end

function MainPanelPVP:_OnClickBtnCardEdit()
  PvpController.Instance:OpenPvPTeamBuildMainOnlyEditPanel()
end

function MainPanelPVP:_OnClickBtnPassword()
  UIManager.Instance:Reopen(Urls.PvpPasswordEnterView)
end

function MainPanelPVP:_OnClickMatchBtn()
  if not PvpMatchModel.Instance:GetIsOpenDraft() and not PvpMatchModel.Instance:GetIsOpenPreBuilt() then
    Alert.ShowStr(LT.Text("PvpMatchEmptyPvpTypeTips"))
    return
  end
  if not CopyBackJumpUtils.startStackJumpFunc then
    CopyBackJumpUtils.Reset()
    local needStackJump = CopyBackJumpUtils.GetIsNeedStackJump()
    if needStackJump then
      CopyBackJumpUtils.GetStartStackJumpFunc()
    end
  end
  local targetPvpType = PvpMatchModel.Instance:GetPvpType()
  if targetPvpType == PvpType.PreBuilt or targetPvpType == PvpType.DraftAndPreBuilt then
    PvPTeamBuildDataUtils.OpenPvPTeamBuildMainPanel()
  else
    local param = {
      pvpType = targetPvpType,
      onlyHuman = not PvpMatchModel.Instance:GetIsMatchMachine(),
      speedFirst = PvpMatchModel.Instance:GetIsSpeedFirst()
    }
    PvpController.Instance:ReqOnMatch(param)
  end
end

function MainPanelPVP:OnBuildView()
  Super.OnBuildView(self)
  self:RegisterEvents()
  self:_BindCloseBtn()
  self:_BindCurrencyList()
  self:_BindRecordBtn()
  self:_CreateSeasonTaskTableViews()
  self:_BindEmojiBtn()
  self:_BindToggle()
  self:_BindPvpMatchParamSelectGroup()
  self:_BindAnim()
end

function MainPanelPVP:OnEnterView()
  Super.OnEnterView(self)
  self:_RequestWeeklyRankData()
  PvPSeasonDataUtils.RequestSeasonInfoOrUseCache()
  self:_RefreshSeasonTaskRewardArea()
  self:_BindSeason()
  PVPCollectionDataUtils.ReqServerData()
  self:_RefreshMatchBtnState()
  self:_RefreshRankLevel()
  self:_RefreshCareerLevelRedDot()
  self:_RefreshTaskProgress()
  self:_RefreshCareerLevelProgress()
  GyroscopeManager.Instance:EnableGyroscope(Urls.MainPanelPVP)
  GyroscopeManager.Instance:InitCameraPos()
end

function MainPanelPVP:_RefreshCareerLevelRedDot()
  self.binder:BindComponent(RedDotComponent(self.ui.RedDot_Precon, nil, nil, function()
    do return RedPointDataUtils.IsShowCareerLevelReward end
    return RedPointDataUtils.IsShowCareerLevelReward, CareerLevelDefine.CareerLevelType.PvpPreBuilt
  end))
  self.binder:BindComponent(RedDotComponent(self.ui.RedDot_DraftPick, nil, nil, function()
    do return RedPointDataUtils.IsShowCareerLevelReward end
    return RedPointDataUtils.IsShowCareerLevelReward, CareerLevelDefine.CareerLevelType.PvpDraft
  end))
end

function MainPanelPVP:_RefreshTaskProgress()
  local targetFormat = "<color=#E8EEF2><size=36>%s</size></color>/%s"
  local taskList = TaskDataUtils.GetTaskListByType(cd.TaskType.TaskType_PVPRewardTask, true)
  local totalCount = #taskList or 0
  local completeCount = 0
  for _, taskData in ipairs(taskList or {}) do
    if taskData.state == CommonDefine.TaskState.Done then
      completeCount = completeCount + 1
    end
  end
  self:SetText(self.ui.Text_Task_Progress, string.format(targetFormat, completeCount, totalCount))
end

function MainPanelPVP:_RefreshCareerLevelProgress()
  local targetFormat = "<color=#ffffff><size=36>%s</size></color>/%s"
  local preconLevel, preconMaxLevel = CareerLevelModel.Instance:GetCareerLevelProgress(CareerLevelDefine.CareerLevelType.PvpPreBuilt)
  self:SetText(self.ui.Text_Precon_Progress, string.format(targetFormat, preconLevel, preconMaxLevel))
  local draftPickLevel, draftPickMaxLevel = CareerLevelModel.Instance:GetCareerLevelProgress(CareerLevelDefine.CareerLevelType.PvpDraft)
  self:SetText(self.ui.Text_DraftPick_Progress, string.format(targetFormat, draftPickLevel, draftPickMaxLevel))
end

function MainPanelPVP:OnExitView()
  Super.OnExitView(self)
  self.tableViewPreBuilt = nil
  self.tableViewDraft = nil
end

function MainPanelPVP:GetTempDependenciesResources()
  local Scene_MainInterface_P = GyroscopeManager.Instance:GetGyroscopeBgByUrl(Urls.MainPanelPVP)
  return {Scene_MainInterface_P}
end

function MainPanelPVP:_RefreshMatchBtnState()
  self:SetButtonState(self.ui.Btn_Matching, self:_GetMatchBtnState())
end

function MainPanelPVP:_BindPvpMatchParamSelectGroup()
  self:SetZ1Toggle(self.ui.Toggle_Pvp, PvpMatchModel.Instance:GetIsOpenPreBuilt(), true)
  self:SetZ1Toggle(self.ui.Toggle_RotationMode, PvpMatchModel.Instance:GetIsOpenDraft(), true)
  local isSpeedFirst = PvpMatchModel.Instance:GetIsSpeedFirst()
  self:SetZ1Toggle(self.ui.Toggle_Speed, not isSpeedFirst, true)
  local isMatchMachine = PvpMatchModel.Instance:GetIsMatchMachine()
  self:SetZ1Toggle(self.ui.Toggle_Robot, isMatchMachine, true)
  self.ui.Group_RotationMode:SetActive(true)
end

function MainPanelPVP:_BindToggle()
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_Speed, System.fn(self, self._OnToggleSpeed))
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_Robot, System.fn(self, self._OnToggleRobot))
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_Pvp, System.fn(self, self._OnTogglePvpMode))
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_RotationMode, System.fn(self, self._OnToggleRotationMode))
end

function MainPanelPVP:_OnTogglePvpMode(isOn)
  PvpMatchModel.Instance:SetIsOpenPreBuilt(isOn)
  self:_RefreshMatchBtnState()
end

function MainPanelPVP:_OnToggleRotationMode(isOn)
  PvpMatchModel.Instance:SetIsOpenDraft(isOn)
  self:_RefreshMatchBtnState()
end

function MainPanelPVP:_OnToggleSpeed(isOn)
  PvpMatchModel.Instance:SetIsSpeedFirst(not isOn)
end

function MainPanelPVP:_OnToggleRobot(isOn)
  PvpMatchModel.Instance:SetIsMatchMachine(isOn)
end

function MainPanelPVP:_BindAnim()
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
end

function MainPanelPVP:_CreateSeasonTaskTableViews()
  local baseGameObj = self.ui.UI_Common_Item_WuPin_Type2
  if not baseGameObj then
    return
  end
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemCompsPreBuilt = {}
  local itemCompsDraft = {}
  
  local function createCellHandler(gameplayType, itemComps)
    return function(view, idx)
      local cell = view:DequeueCell()
      cell = cell or view:AddChild(baseGameObj)
      local gameObj = cell.gameObject
      if itemComps[gameObj] then
        itemComps[gameObj].binder:teardown()
      end
      local seasonRewardList
      if gameplayType == SeasonGameplayType.PvpPreBuilt then
        seasonRewardList = self._preBuiltRewardList
      else
        seasonRewardList = self._draftRewardList
      end
      local seasonId = SeasonRotationModel.Instance:GetSeasonId(gameplayType)
      local seasonTaskId = SeasonRotationCfgUtils.GetSeasonTaskId(seasonId, gameplayType)
      local reward = seasonRewardList[idx]
      local itemData = {
        itemTid = reward.tid,
        itemCount = reward.num,
        isolateStreamerMaterialForRectMask = true,
        clickFunc = function()
          if not TaskDataUtils.IsTaskCanReward(seasonTaskId) then
            ItemDataUtils.ShowItemDetailTips(self.binder, gameObj.transform, nil, reward.tid)
            return
          end
          self:_ReqTaskAward(seasonTaskId)
        end,
        isGotFunc = function()
          do return TaskDataUtils.TaskFinshAndGetedAward end
          return TaskDataUtils.TaskFinshAndGetedAward, seasonTaskId
        end,
        isShowRing = function()
          do return TaskDataUtils.IsTaskCanReward end
          return TaskDataUtils.IsTaskCanReward, seasonTaskId
        end
      }
      itemComps[gameObj] = self.binder:BindComponent(CommonIconItemType2(gameObj, itemData))
      return cell
    end
  end
  
  if self.ui.ScrollView_Victory_Pvp then
    self.tableViewPreBuilt = self:CreateTableview(self.ui.ScrollView_Victory_Pvp, function()
      return self._preBuiltRewardList and #self._preBuiltRewardList or 0
    end, createCellHandler(SeasonGameplayType.PvpPreBuilt, itemCompsPreBuilt), function()
      return itemW, itemH
    end, function()
      itemCompsPreBuilt = nil
    end)
  end
  if self.ui.ScrollView_Victory_RotationMode then
    self.tableViewDraft = self:CreateTableview(self.ui.ScrollView_Victory_RotationMode, function()
      return self._draftRewardList and #self._draftRewardList or 0
    end, createCellHandler(SeasonGameplayType.PvpDraft, itemCompsDraft), function()
      return itemW, itemH
    end, function()
      itemCompsDraft = nil
    end)
  end
end

function MainPanelPVP:_GetSeasonRewardLisst(gameplayType)
  local seasonId = SeasonRotationModel.Instance:GetSeasonId(gameplayType)
  local seasonRewardList = SeasonRotationCfgUtils.GetSeasonRewardList(seasonId, gameplayType)
  return seasonRewardList
end

function MainPanelPVP:_ReloadSeasonTaskTableViews()
  self._preBuiltRewardList = self:_GetSeasonRewardLisst(SeasonGameplayType.PvpPreBuilt)
  self._draftRewardList = self:_GetSeasonRewardLisst(SeasonGameplayType.PvpDraft)
  if self.tableViewPreBuilt then
    self.tableViewPreBuilt:ReloadData()
  end
  if self.tableViewDraft then
    self.tableViewDraft:ReloadData()
  end
  self:_UpdateRewardViewPosition(self.ui.ScrollView_Victory_Pvp, self._preBuiltRewardList and #self._preBuiltRewardList or 0)
  self:_UpdateRewardViewPosition(self.ui.ScrollView_Victory_RotationMode, self._draftRewardList and #self._draftRewardList or 0)
end

function MainPanelPVP:_UpdateRewardViewPosition(node, rewardsNum)
  if rewardsNum >= 3 then
    CS.Framework.TransformUtil.SetAnchoredPos(node.transform, 184, -108)
  elseif 2 == rewardsNum then
    CS.Framework.TransformUtil.SetAnchoredPos(node.transform, 226, -108)
  else
    CS.Framework.TransformUtil.SetAnchoredPos(node.transform, 268, -108)
  end
end

function MainPanelPVP:_RefreshSeasonTaskRewardArea()
  local preBuiltSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpPreBuilt)
  local draftSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpDraft)
  local preBuiltRewards = SeasonRotationCfgUtils.GetSeasonReward(preBuiltSeasonId, SeasonGameplayType.PvpPreBuilt)
  local draftRewards = SeasonRotationCfgUtils.GetSeasonReward(draftSeasonId, SeasonGameplayType.PvpDraft)
  if self.ui.ScrollView_Victory_Pvp then
    self.ui.ScrollView_Victory_Pvp:SetActive(#preBuiltRewards > 0)
  end
  if self.ui.ScrollView_Victory_RotationMode then
    self.ui.ScrollView_Victory_RotationMode:SetActive(#draftRewards > 0)
  end
  self:_ReloadSeasonTaskTableViews()
end

function MainPanelPVP:_ReqTaskAward(taskId)
  TaskDataUtils.TaskComplete(taskId, function()
    self:_ReloadSeasonTaskTableViews()
  end)
end

function MainPanelPVP:_BindCurrencyList()
  local coinList = DT.Constant.PVPCurrencies.Data
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, coinList))
end

function MainPanelPVP:_BindSeason()
  self:_SetSeasonNameAndCountdown()
  self:BindTimer(0.033, -1, function()
    self:_SetSeasonNameAndCountdown()
  end)
end

function MainPanelPVP:_SetSeasonNameAndCountdown()
  local preBuiltSeasonData = SeasonRotationModel.Instance:GetPvpPrebuildSeasonData() or {}
  local draftSeasonData = SeasonRotationModel.Instance:GetPvpDraftSeasonData() or {}
  self:SetText(self.ui.Text_Pvp_Score, preBuiltSeasonData.score or 0)
  self:SetText(self.ui.Text_RotationMode_Score, draftSeasonData.score or 0)
  local preBuiltSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpPreBuilt)
  local draftSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpDraft)
  self:SetText(self.ui.Text_Countdown_Pvp, SeasonRotationCfgUtils.GetLeftTimeTextColored(preBuiltSeasonId, SeasonGameplayType.PvpPreBuilt))
  self:SetText(self.ui.Text_Countdown_RotationMode, SeasonRotationCfgUtils.GetLeftTimeTextColored(draftSeasonId, SeasonGameplayType.PvpDraft))
  self:SetText(self.ui.Text_WinCount_Pvp, LT.Text(SeasonRotationCfgUtils.GetSeasonTaskDesc(preBuiltSeasonId, SeasonGameplayType.PvpPreBuilt)))
  self:SetText(self.ui.Text_WinCount_RotationMode, LT.Text(SeasonRotationCfgUtils.GetSeasonTaskDesc(draftSeasonId, SeasonGameplayType.PvpDraft)))
  if SeasonRotationCfgUtils.IsFarFromClose(preBuiltSeasonId, SeasonGameplayType.PvpPreBuilt) then
    self:SetImage(self.ui.Icon_CountDown_Pvp, CommonRes.HourglassIcon.Far)
  elseif SeasonRotationCfgUtils.IsInMiddleSeason(preBuiltSeasonId, SeasonGameplayType.PvpPreBuilt) then
    self:SetImage(self.ui.Icon_CountDown_Pvp, CommonRes.HourglassIcon.Middle)
  elseif SeasonRotationCfgUtils.IsNearClose(preBuiltSeasonId, SeasonGameplayType.PvpPreBuilt) then
    self:SetImage(self.ui.Icon_CountDown_Pvp, CommonRes.HourglassIcon.Near)
  end
  if SeasonRotationCfgUtils.IsFarFromClose(draftSeasonId, SeasonGameplayType.PvpDraft) then
    self:SetImage(self.ui.Icon_CountDown_RotationMode, CommonRes.HourglassIcon.Far)
  elseif SeasonRotationCfgUtils.IsInMiddleSeason(draftSeasonId, SeasonGameplayType.PvpDraft) then
    self:SetImage(self.ui.Icon_CountDown_RotationMode, CommonRes.HourglassIcon.Middle)
  elseif SeasonRotationCfgUtils.IsNearClose(draftSeasonId, SeasonGameplayType.PvpDraft) then
    self:SetImage(self.ui.Icon_CountDown_RotationMode, CommonRes.HourglassIcon.Near)
  end
end

function MainPanelPVP:_BindCloseBtn()
  local btnCloseItem = BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:Close()
  end)
  self.binder:BindComponent(btnCloseItem)
end

function MainPanelPVP:_BindRecordBtn()
  self.binder:BindToVisible(self.ui.Image_RecordRedDot, function()
    do return end
    return RedPointDataUtils.IsPVPChallengeTaskReward, nil
  end)
end

function MainPanelPVP:_BindEmojiBtn()
  self.binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Expression, CommonDefine.RedDotType.TextNew, nil, function()
    do return end
    return RedPointDataUtils.IsPVPEmojiNew, nil
  end))
end

function MainPanelPVP:_RefreshRankPositioning(rankType, gameplayType, imageNode, textNode)
  local seasonId = SeasonRotationModel.Instance:GetSeasonId(gameplayType)
  local selfRank = RankModel.Instance:GetSelfRankData(rankType, seasonId)
  selfRank = selfRank or RankModel.Instance:GetSelfRankData(rankType)
  if selfRank and selfRank:GetSeasonTid() and selfRank:GetSeasonTid() > 0 then
    seasonId = selfRank:GetSeasonTid()
  end
  local rewardRankIndex = selfRank and selfRank:GetRewardRankIndex() or 0
  if rewardRankIndex <= 0 and selfRank then
    rewardRankIndex = selfRank:GetRank() or 0
  end
  local playersNum = RankModel.Instance:GetRankLengthData(rankType, seasonId) or RankModel.Instance:GetRankLengthData(rankType) or 0
  playersNum = math.max(playersNum, 100)
  local rankData = GuideNotePermTrainingRankUi.GetRankTierDisplayData({
    rewardRankIndex = rewardRankIndex,
    seasonId = seasonId,
    gameplayType = gameplayType,
    playersNum = playersNum,
    rankType = rankType,
    rankSubTid = seasonId
  })
  local hasData = rankData and rankData.hasData == true
  imageNode:SetActive(hasData)
  if hasData then
    self:SetImage(imageNode, rankData.rankIcon)
    self:SetText(textNode, rankData.rankName)
    ColorUtils.SetRankTitleColor(self.binder, rankData.rankIcon, textNode)
  end
end

function MainPanelPVP:_RefreshRankLevel()
  self:_RefreshRankPositioning(RankDefine.RankType.SeasonRoPvpPrebuilt, SeasonGameplayType.PvpPreBuilt, self.ui.Image_Pvp_Positioning, self.ui.Text_Pvp_Positioning)
  self:_RefreshRankPositioning(RankDefine.RankType.SeasonRoPvpDraft, SeasonGameplayType.PvpDraft, self.ui.Image_Rotation_Positioning, self.ui.Text_Rotation_Positioning)
end

function MainPanelPVP:_ShowPVPShopUnlockTips()
  local shopKey = MainShopDataUtils.GetShopTypeIDByTag(CommonDefine.MainShopTypeTag.PVPShop)
  PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.Shop, shopKey)
end

function MainPanelPVP:Close()
  if CopyBackJumpUtils.startStackJumpFunc then
    CopyBackJumpUtils.startStackJumpFunc(function()
      self.binder:BindTimer(0.1, 0, nil, function()
        self:Close()
      end)
    end)
    return
  end
  Super.Close(self)
  if not CopyBackJumpUtils.needStackJump and not SceneMgr.Instance:IsInTown() then
    SceneMgr.Instance:EnterTown(true)
  end
  GyroscopeManager.Instance:EnableGyroscope(Urls.MainPanel)
end

function MainPanelPVP:_GetMatchBtnState()
  if not PvpMatchModel.Instance:GetIsOpenDraft() and not PvpMatchModel.Instance:GetIsOpenPreBuilt() then
    return BtnType.Unclickable
  end
  return BtnType.High
end

function MainPanelPVP:_RequestWeeklyRankData()
  local preBuiltSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpPreBuilt)
  local draftSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpDraft)
  RankController.Instance:QueryRankInfoBatch({
    {
      type = RankDefine.RankType.SeasonRoPvpPrebuilt,
      extraId = preBuiltSeasonId
    },
    {
      type = RankDefine.RankType.SeasonRoPvpDraft,
      extraId = draftSeasonId
    }
  })
end

return MainPanelPVP
