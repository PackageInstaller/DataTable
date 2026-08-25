local DailyChallengeView, Super = NewClass("DailyChallengeView", BaseView)
DailyChallengeView.uiResCls = "UI/UI_Dungeous/UI_Dungeous_Prefab/UI_Dungeons_Panel_Daily_Challenge_New.prefab"
local DivingGameplayType = CommonDefine.SeasonGameplayType.ConsciousnessDiving

function DailyChallengeView:ctor()
  Super.ctor(self)
  self._seasonRewardList = {}
  self._seasonRewardTableView = nil
  self._seasonRewardItemComps = {}
end

function DailyChallengeView:OnBuildView()
  Super.OnBuildView(self)
  self:_SetUIElementsActive(false)
  local svrData = DailyChallengeController.Instance:GetSvrData()
  if svrData then
    self:_UpdateUIElementsBySvrData(svrData)
  end
  self:ReqDailyChallengeData()
end

function DailyChallengeView:RefreshOnRendered()
end

function DailyChallengeView:OnEnterView()
  Super.OnEnterView(self)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  PlayerDataUtils.OpenFirstTimeIllustrate(self.__name, nil, nil, function()
    local stageGroupId = DailyChallengeController.Instance:GetStageGroupId()
    TaskDataUtils.ShowDailyChallengeRulePanel(stageGroupId)
  end)
  AudioManager.Instance:PostSoundEvent("MAININTERFACE_MUSIC")
end

function DailyChallengeView:OnEnterViewFinished()
end

function DailyChallengeView:RegisterEvents()
  self:RegisterNotify(NotifyId.OnSeasonDataGet, self._SetRefreshTime, self)
  self:RegisterNotify(NotifyId.OnDailyChallengeLevelAwardGet, self._UpdateLevelAwardNode, self)
end

function DailyChallengeView:RegisterNotifications()
  self:BindEvent(EventMgr.Instance.ReqDailyChallengeDataEvt, System.fn(self, self.ReqDailyChallengeData))
  self:RegisterNotify(NotifyId.OnDailyChallengeDataChanged, self._OnDailyChallengeDataChanged, self)
  self:RegisterNotify(NotifyId.OnDailyChallengeAchieveAwardGet, self.RefreshRecord, self)
end

function DailyChallengeView:OnExitView()
  Super.OnExitView(self)
end

function DailyChallengeView:ReqDailyChallengeData()
  DailyChallengeController.Instance:ReqOnOpenDailyChallenge(nil, function()
    self:Close()
  end)
end

function DailyChallengeView:_UpdateUIElementsBySvrData()
  self:_SetUIElementsActive(true)
  self:_SetupUIElements()
  self:_UpdateLevelAwardNode()
end

function DailyChallengeView:_SetUIElementsActive(value)
  self.ui.Text_Week_Score:SetActive(value)
  self.ui.Group_Title:SetActive(value)
  self.ui.Btn_Rank:SetActive(value)
  self.ui.Btn_Enter:SetActive(value)
end

function DailyChallengeView:_GetProgressShowStr(leftStr, RightStr)
  return "<color=#ffffff><size=36>" .. leftStr .. "/</size></color>" .. RightStr
end

function DailyChallengeView:_UpdateLevelAwardNode()
  local careerLevelMO = CareerLevelModel.Instance:GetCareerLevelMO(DailyChallengeDataUtils.careerLevelType)
  local lv = careerLevelMO and careerLevelMO:GetLevel() or 1
  local maxLv = CareerLevelCfgUtils.GetMaxLevel(DailyChallengeDataUtils.careerLevelType)
  self:SetText(self.ui.Text_Experience_Value, self:_GetProgressShowStr(lv, maxLv))
end

function DailyChallengeView:RefreshChallengeAwardItems()
  local maxDifficultyStageId = DailyChallengeController.Instance:GetMaxDifficultyStageID()
  local stageCfg = DT.Stage[maxDifficultyStageId]
  local awardList = stageCfg and stageCfg.DailyChallengeReward or {} or {}
  local itemDatas = self.ChallengeAward_ItemDatas
  if nil == itemDatas then
    itemDatas = {}
    self.ChallengeAward_ItemDatas = itemDatas
  end
  table.clear(itemDatas)
  for index = 1, #awardList, 2 do
    table.insert(itemDatas, {
      itemTid = awardList[index],
      itemCount = awardList[index + 1]
    })
  end
end

function DailyChallengeView:_SetupUIElements()
  self:SetText(self.ui.Text_Week_Score, DailyChallengeController.Instance:GetWeekHighestScore())
  self:_SetUpTitle()
  self:AddButtonClickListener(self.ui.Btn_Question, function()
    local stageGroupId = DailyChallengeController.Instance:GetStageGroupId()
    TaskDataUtils.ShowDailyChallengeRulePanel(stageGroupId)
  end)
  self:AddButtonClickListener(self.ui.Btn_Rank, function()
    RankingBoardDataUtils.OpenDailyChallengeBoardEntryPanel()
  end)
  self:AddButtonClickListener(self.ui.Btn_Record, function()
    UIManager.Instance:Reopen(Urls.DailyWeekAchieveRewardView)
  end)
  self:AddButtonClickListener(self.ui.Btn_Reward, function()
    UIManager.Instance:Reopen(Urls.PvpHistoryLevelView, DailyChallengeDataUtils.careerLevelType)
  end)
  self:RefreshRecord()
  self:_RefreshSeasonReward()
  self:AddButtonClickListener(self.ui.Btn_Enter, function()
    UIManager.Instance:Reopen(Urls.DailyChallengeDifficultyView)
  end)
  self:SetButtonText(self.ui.Btn_Enter, LT.Text("DailyCopy_Start"))
  self.closeBtn = self:AddViewComponent(self.ui.Btn_Close, UICompBtnCloseItem, System.fn(self, self.Close))
  self:BindTimer(0.03, 0, nil, function()
    self:_SetRefreshTime()
  end)
end

function DailyChallengeView:_RefreshSeasonReward()
  if not self.ui then
    return
  end
  local seasonTid = DailyChallengeModel.Instance:GetSeasonId()
  if not seasonTid or 0 == seasonTid then
    seasonTid = SeasonRotationModel.Instance:GetSeasonId(DivingGameplayType)
  end
  if not seasonTid or 0 == seasonTid then
    if self.ui.Text_WinCount then
      self:SetText(self.ui.Text_WinCount, "")
    end
    if self.ui.ScrollView_Victor then
      self.ui.ScrollView_Victor:SetActive(false)
    end
    return
  end
  local rewardList = SeasonRotationCfgUtils.GetSeasonRewardList(seasonTid, DivingGameplayType) or {}
  self._seasonRewardList = rewardList
  if self.ui.Text_WinCount then
    self:SetText(self.ui.Text_WinCount, LT.Text(SeasonRotationCfgUtils.GetSeasonTaskDesc(seasonTid, DivingGameplayType)))
  end
  if self.ui.ScrollView_Victor then
    self.ui.ScrollView_Victor:SetActive(#rewardList > 0)
  end
  if not self._seasonRewardTableView then
    self:_CreateSeasonRewardTableView()
  end
  if self._seasonRewardTableView then
    self._seasonRewardTableView:ReloadData()
  end
  self:_UpdateRewardViewPosition(#rewardList)
end

function DailyChallengeView:_UpdateRewardViewPosition(rewardsNum)
  if rewardsNum >= 3 then
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.ScrollView_Victor.transform, 0, -288)
  elseif 2 == rewardsNum then
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.ScrollView_Victor.transform, 68, -288)
  else
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.ScrollView_Victor.transform, 136, -288)
  end
end

function DailyChallengeView:_CreateSeasonRewardTableView()
  if not self.ui.ScrollView_Victor or not self.ui.UI_Common_Item_WuPin_Type2 then
    return
  end
  local baseGameObj = self.ui.UI_Common_Item_WuPin_Type2
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  self._seasonRewardItemComps = {}
  local seasonTid = SeasonRotationModel.Instance:GetSeasonId(DivingGameplayType)
  local seasonTaskId = SeasonRotationCfgUtils.GetSeasonTaskId(seasonTid, DivingGameplayType)
  self._seasonRewardTableView = self:CreateTableview(self.ui.ScrollView_Victor, function()
    return #self._seasonRewardList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if self._seasonRewardItemComps[gameObj] then
      self._seasonRewardItemComps[gameObj].binder:teardown()
    end
    local reward = self._seasonRewardList[idx]
    if reward then
      local itemData = {
        itemTid = reward.tid,
        itemCount = reward.num,
        clickFunc = function()
          if not TaskDataUtils.IsTaskCanReward(seasonTaskId) then
            ItemDataUtils.ShowItemDetailTips(self.binder, gameObj.transform, nil, reward.tid)
            return
          end
          TaskDataUtils.TaskComplete(seasonTaskId, function()
            self:_RefreshSeasonReward()
          end)
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
      self._seasonRewardItemComps[gameObj] = self.binder:BindComponent(CommonIconItemType2(gameObj, itemData))
    end
    return cell
  end, function()
    return itemW, itemH
  end, function()
    self._seasonRewardItemComps = nil
  end)
end

function DailyChallengeView:_SetUpTitle()
  local rankID = DailyChallengeController.Instance:GetRankID()
  if rankID > 0 then
    local seasonTid = SeasonRotationModel.Instance:GetSeasonId(DivingGameplayType)
    if not seasonTid or 0 == seasonTid then
      seasonTid = DailyChallengeDataUtils.GetNowSeasonTid()
    end
    local rankRow
    if seasonTid and seasonTid > 0 then
      rankRow = SeasonRotationCfgUtils.GetSeasonRankRewardRowByRankId(seasonTid, DivingGameplayType, rankID)
    end
    local titleText = rankRow and LT.Text(rankRow.Name) or "-"
    local titleIcon = rankRow and rankRow.RankIcon or nil
    self:AddViewComponentOnce(self.ui.Group_Title, UIComDungeonsDivingTitle, {
      titleText = titleText,
      titleIcon = titleIcon,
      width = 325
    })
  else
    self:SetActive(self.ui.Group_Title, false)
  end
end

function DailyChallengeView:_SetRefreshTime()
  local seasonTid = SeasonRotationModel.Instance:GetSeasonId(DivingGameplayType)
  local seasonEndTime = SeasonRotationCfgUtils.GetEndTime(seasonTid, DivingGameplayType)
  if seasonTid and seasonEndTime then
    self:SetText(self.ui.Text_SeasonTime, SeasonRotationCfgUtils.GetLeftTimeTextColored(seasonTid, DivingGameplayType))
    if self.ui.Text_WeekTime then
      self:SetText(self.ui.Text_WeekTime, "")
    end
    if self.ui.Icon_Time then
      self:SetActive(self.ui.Icon_Time, true)
      self:SetImage(self.ui.Icon_Time, SeasonRotationCfgUtils.GetLeftTimeHourglassIcon(seasonTid, DivingGameplayType))
    end
  elseif self.ui.Icon_Time then
    self:SetActive(self.ui.Icon_Time, false)
  end
  if not self.timerID then
    self.timerID = self:BindTimer(0.5, -1, function()
      self:_SetRefreshTime()
    end)
  end
end

function DailyChallengeView:_OnDailyChallengeDataChanged()
  self:_UpdateUIElementsBySvrData()
end

function DailyChallengeView:RefreshRecord()
  self:SetText(self.ui.Text_Record_Progress, self:_GetProgressShowStr(DailyChallengeDataUtils.GetAchievementRewardProgress()))
end

return DailyChallengeView
