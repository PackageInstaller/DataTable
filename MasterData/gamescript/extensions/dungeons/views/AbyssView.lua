local AbyssView, Super = NewClass("AbyssView", BaseView)
AbyssView.uiResCls = UI_Dungeous_Panel_Melt_Erosion_OptimizedResource
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)

function AbyssView:ctor()
  Super.ctor(self)
  self.model = AbyssExtModel.Instance
  self.controller = AbyssController.Instance
  self.isFirstEnter = true
end

function AbyssView:OnBuildView()
  AbyssController.Instance:ReqAbyssData()
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.AbyssChallenge, RedPointDataUtils.RedAttrType.IsNew)
end

function AbyssView:RefreshOnRendered()
end

function AbyssView:OnEnterView()
  Super.OnEnterView(self)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self:_RefreshView()
  self:AddViewComponentOnce(self.ui.Com_RedDot_Daily, UICompRedDot, CommonDefine.RedDotType.Dot, nil, RedPointDataUtils.IsShowAbyssScorePrize)
  AudioManager.Instance:PostSoundEvent("MAININTERFACE_MUSIC")
end

function AbyssView:OnEnterViewFinished()
end

function AbyssView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Progress_2, System.fn(self, self._OnClickProgressAward))
  self:AddButtonClickListener(self.ui.Btn_Rank, System.fn(self, self._OnClickRank))
  self:AddButtonClickListener(self.ui.Btn_Rule, System.fn(self, self._OnClickRule))
  self.closeBtn = self:AddViewComponent(self.ui.Btn_Close, UICompBtnCloseItem, System.fn(self, self.Close))
  self:_CreateStageGroupTableView()
end

function AbyssView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnAbyssDataChanged, self._OnAbyssDataChanged, self)
end

function AbyssView:_RefreshView()
  self:_RefreshTimer()
  self:_RefreshScore()
  self:_RefreshStageGroups()
  StrUtils.SetPreferedWidthFontSize(self.ui.Text_C_Hint)
end

function AbyssView:_CreateStageGroupTableView()
  local cellRT = self.ui.UI_Dungeons_Item_Level:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.stageGroupTableView = self:CreateTableview(self.ui.ScrollView, function()
    if not self.stageGroupTidList then
      return 0
    end
    return #self.stageGroupTidList
  end, function(view, index)
    do return self._StageGroupCellAtIndex, self, view end
    return self._StageGroupCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function AbyssView:_StageGroupCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_Level)
  local stageGroupTid = self.stageGroupTidList[index]
  local stageGroupData = self.model:GetStageGroupData(stageGroupTid)
  
  local function _OnClick()
    UIManager.Instance:Reopen(Urls.AbyssChallengeView, stageGroupData)
  end
  
  local function _OnClickAwakers(isExtra)
    self:_OpenCopyAbyssSettleView(stageGroupTid, isExtra)
  end
  
  local ui = UI_Dungeons_Item_LevelResource(cell.gameObject)
  local childObj = ui.UI_Dungeons_Item_Level_Content
  local childTf = childObj.transform
  if 0 == index % 2 then
    childTf:SetParent(ui.Down_Container.transform)
    childTf.anchoredPosition = CS.UnityEngine.Vector2.zero
  else
    childTf:SetParent(ui.Up_Container.transform)
    childTf.anchoredPosition = CS.UnityEngine.Vector2.zero
  end
  self:AddViewComponentOnce(childObj, UICompAbyssGroupListItem, stageGroupData, _OnClick, _OnClickAwakers)
  return cell
end

function AbyssView:_OpenCopyAbyssSettleView(stageGroupTid, isExtra)
  local activityTid = self.model:GetCurrActivityTid()
  local stageGroupDatas = self.model:GetStageGroupDatas()
  local recordList = self.model:CalcRecordDataListByServer(activityTid, stageGroupDatas)
  local playerUid = PlayerDataUtils.GetPlayerUid()
  local viewData = {
    recordList = recordList,
    playerUid = playerUid,
    firstStageGroupTid = stageGroupTid,
    isExtra = isExtra
  }
  CopyController.Instance:OnOpenCopyAbyssSettleView(viewData)
end

function AbyssView:_OnFirstEnter()
  if not self.stageGroupTidList or table.next(self.stageGroupTidList) == nil then
    self:_SetScrollViewVisible(true)
    return
  end
  
  local function _JumpToIndex()
    local firstJumpIndex = self.model:GetFirstNotPassedStageGroupIndex(self.stageGroupTidList)
    local offset = self.stageGroupTableView:GetOffsetByIndex(firstJumpIndex - 1)
    self.stageGroupTableView:SetOffset(offset, false)
    self:_SetScrollViewVisible(true)
  end
  
  if self.stageGroupTableView.isReady then
    _JumpToIndex()
  else
    function self.stageGroupTableView.reloadFinishCallback()
      self.stageGroupTableView.reloadFinishCallback = nil
      
      _JumpToIndex()
    end
  end
end

function AbyssView:_SetScrollViewVisible(visible)
  local canvasGroup = self:AddCanvasGroupOnce(self.ui.ScrollView)
  canvasGroup.alpha = visible and 1 or 0
  canvasGroup.blocksRaycasts = visible
end

function AbyssView:_RefreshStageGroups()
  self.stageGroupTidList = self.model:GetStageGroupTidList()
  self.stageGroupTableView:ReloadData()
end

function AbyssView:_RefreshScore()
  self:SetText(self.ui.Text_Train, self.model:GetScore())
  self:SetText(self.ui.Text_Premise, self.model:GetCurReachAwardNum())
  self:SetText(self.ui.Text_Foundation, "/" .. self.model:GetMaxAwardNum())
end

function AbyssView:_RefreshTimer()
  self:_ClearTimer()
  
  local function _SetTimeText()
    local now = TimeUtils.GetServerTime()
    local countdown = self.model:GetEndTime() - now
    if countdown < 0 then
      self:SetText(self.ui.Text_Time, LT.Text("AbyssChallengeEndTips"))
      self:_ClearTimer()
      return
    end
    local d, h, m, _ = TimeUtils.ConvertTime(countdown)
    local timeText
    if d > 0 then
      timeText = LT.Textf("AbyssChallengeResetTipsDateHour", d, h)
    else
      timeText = LT.Textf("AbyssChallengeResetTipsHourMinute", h, m)
    end
    self:SetText(self.ui.Text_Time, timeText)
  end
  
  self.timer = self:BindTimer(1, -1, _SetTimeText)
  _SetTimeText()
end

function AbyssView:_OnResetStageGroup()
  self:_RefreshScore()
  self:_RefreshStageGroups()
end

function AbyssView:_OnAbyssDataChanged()
  if self.isFirstEnter then
    self.isFirstEnter = false
    self:_SetScrollViewVisible(false)
    self:_RefreshView()
    self:_OnFirstEnter()
  else
    self:_RefreshView()
  end
end

function AbyssView:_OnClickProgressAward()
  UIManager.Instance:Reopen(Urls.AbyssProgressRewardView)
end

function AbyssView:_OnClickRank()
  AbyssController.Instance:ReqAbyssData(function()
    local activityTid = self.model:GetCurrActivityTid()
    AbyssController.Instance:OpenAbyssRankView(activityTid)
  end)
end

function AbyssView:_OnClickRule()
  local ruleKey = TaskDataUtils.GetTimeReplaceLanguageKey("AbyssChallengeTipsV2", false)
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("AbyssChallengeTipsTitle"), LT.Text(ruleKey))
end

function AbyssView:_ClearTimer()
  if self.timer then
    self:StopTimer(self.timer)
    self.timer = nil
  end
end

function AbyssView:OnExitView()
  Super.OnExitView(self)
end

return AbyssView
