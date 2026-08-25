local AbyssChallengeView, Super = NewClass("AbyssChallengeView", BaseView)
AbyssChallengeView.uiResCls = UI_Dungeous_Panel_Molten_OptimizedResource
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)

function AbyssChallengeView:ctor(data)
  Super.ctor(self)
  self.data = data
  self.model = AbyssExtChallengeModel.Instance
end

function AbyssChallengeView:OnBuildView()
  self:SetButtonText(self.ui.Btn_Challenge, LT.Text("DailyCopyChallengeBtnText"))
  self:SetActive(self.ui.Btn_Replay, true)
end

function AbyssChallengeView:OnEnterView()
  Super.OnEnterView(self)
  self.model:UpdateData(self.data)
  self:_RefreshStageList()
  local firstSelectStageTid = self:_GetFirstSelectStageTid()
  self.model:SetCurSelectStageTid(firstSelectStageTid)
  self:AddViewComponentOnce(self.ui.UI_Common_Btn_StageChapter, CopyChapterMvcItem, firstSelectStageTid)
end

function AbyssChallengeView:RegisterEvents()
  self:_InitCompCloseBtn()
  self:AddButtonClickListener(self.ui.Btn_Challenge, System.fn(self, self._OnClickChallenge))
  self:AddButtonClickListener(self.ui.Btn_Creation, System.fn(self, self._OnClickCreation))
  self:AddButtonClickListener(self.ui.Btn_Receive_Small, System.bind(self._OnClickReset, self, false))
  self:AddButtonClickListener(self.ui.Btn_Reset_Extra, System.bind(self._OnClickReset, self, true))
  self:AddButtonClickListener(self.ui.Btn_Replay, System.bind(self._OnClickReplay, self))
  self:_CreateStageTableView()
  self:_CreateRelicTableView()
  self:_CreateMonsterTableView()
  self:_CreatePassedAwakerTableView()
end

function AbyssChallengeView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnSelectAbyssStage, self._OnSelectStageChanged, self)
  self:RegisterLocalNotify(NotifyId.OnChooseMonster, self._OnSelectMonsterChanged, self)
  self:RegisterNotify(NotifyId.OnAbyssDataChanged, self._OnAbyssDataChanged, self)
end

function AbyssChallengeView:_InitCompCloseBtn()
  self.compCloseBtn = self:AddViewComponentOnce(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.OnClickClose))
end

function AbyssChallengeView:_RefreshView()
  self:_RefreshStageList()
  self:_RefreshStageDetailUI()
end

function AbyssChallengeView:_RefreshStageDetailUI()
  local curStageTid = self.model:GetCurSelectStageTid()
  if 0 == curStageTid or nil == curStageTid then
    return
  end
  local stageConfig = CopyDataUtils.GetStageConfig(curStageTid)
  if stageConfig then
    self:SetText(self.ui.Text_Name, LT.Text(stageConfig.Name))
    self:SetText(self.ui.Text_Introduce, LT.Text(stageConfig.Desc))
    local isPassed = self.model:IsPassedStage(curStageTid)
    local showScore = isPassed and self.data.score or AbyssExtChallengeModel.Instance:GetChallengeTotalScore(curStageTid)
    self:SetText(self.ui.Text_Cost_Num, showScore)
    self:SetText(self.ui.Text_Title, CopyDataUtils.GetStageGroupName(self.data.stageGroupTid))
    self:SetImage(self.ui.Image_D_Bg, stageConfig.Backgrand)
  end
  self:AddViewComponentOnce(self.ui.UI_Common_Melt_Disaster, UICompStageInitialStateBtn, curStageTid)
  self:_SetEmptyTeamShow()
  self:_RefreshRelicList()
  self:_RefreshMonsterList()
  self:_RefreshPassedAwakerList()
  self:_RefreshResetBtnShow()
  self:_RefreshExtraInfo()
  self:_RefreshRevivalMark()
end

function AbyssChallengeView:_RefreshExtraInfo()
  local curStageTid = self.model:GetCurSelectStageTid()
  local isPassedNormal = self.model:IsPassNormalChallenge(curStageTid)
  local isPassedExtra = self.model:IsPassExtraChallenge(curStageTid)
  local isHaveExtra = self.model:IsHaveExtraChallenge(curStageTid)
  self:SetActive(self.ui.Group_Extra, isPassedNormal and isHaveExtra)
  self:SetActive(self.ui.Btn_Reset_Extra, isPassedExtra)
  if not isPassedExtra and not isPassedNormal then
    self:SetText(self.ui.Text_C_Integral, LT.Text("AbyssClearanceChallengeScore"))
    self:SetText(self.ui.Text_Cost_Num, AbyssExtChallengeModel.Instance:GetChallengeScore(curStageTid))
    self:SetActive(self.ui.Text_Extra_None, true)
  else
    self:_RefreshExtraAwakerList()
    if isPassedExtra then
      self:SetText(self.ui.Text_C_Integral, LT.Text("AbyssAllClearanceChallengeScore"))
      local actualTotalScore = self.data.score or AbyssExtChallengeModel.Instance:GetChallengeTotalScore(curStageTid)
      self:SetText(self.ui.Text_Cost_Num, string.color(actualTotalScore, "#5EF2FF"))
      self:SetActive(self.ui.Text_Extra_None, false)
    else
      self:SetText(self.ui.Text_C_Integral, LT.Text("AbyssExtraClearanceChallengeScore"))
      self:SetText(self.ui.Text_Cost_Num, string.color(AbyssExtChallengeModel.Instance:GetChallengeExtraScore(curStageTid), "#5EF2FF"))
      self:SetActive(self.ui.Text_Extra_None, true)
    end
  end
end

function AbyssChallengeView:_RefreshRevivalMark()
  local normalNode = self.ui.Image_Item_Normal or self:FindChildRecursively(self.ui.uiNode, "Image_Item_Normal")
  local extraNode = self.ui.Image_Item_Extra or self:FindChildRecursively(self.ui.uiNode, "Image_Item_Extra")
  if not AbyssExtModel.Instance:IsAbyssRevivalFeatureEnabled() then
    if normalNode then
      self:SetActive(normalNode, false)
    end
    if extraNode then
      self:SetActive(extraNode, false)
    end
    return
  end
  local curStageTid = self.model:GetCurSelectStageTid()
  local testForce = AbyssExtModel.TestForceRevivalMark
  local useRevivalNormal = false
  local useRevivalExtra = false
  local team = self.model.team
  local teamExtra = self.model.teamExtra
  if testForce then
    useRevivalNormal = true
    useRevivalExtra = true
  else
    if self.model:IsPassNormalChallenge(curStageTid) then
      useRevivalNormal = team and team.isScoreValid == false or false == self.data.isValid or self.data.useRevivalNormal or false
    end
    if self.model:IsPassExtraChallenge(curStageTid) then
      useRevivalExtra = teamExtra and teamExtra.isScoreValid == false or false == self.data.isValidExtra or self.data.useRevivalExtra or false
    end
  end
  if normalNode then
    self:SetActive(normalNode, useRevivalNormal)
  end
  if extraNode then
    self:SetActive(extraNode, useRevivalExtra)
  end
end

function AbyssChallengeView:_SetEmptyTeamShow()
  local curStageTid = self.model:GetCurSelectStageTid()
  local notPassStage = not self.model:IsPassedStage(curStageTid)
  self.ui.Text_C_None:SetActive(notPassStage)
end

function AbyssChallengeView:SetMonsterTipShow(show)
  self.ui.UI_Chapter_Popup_Blame_Tip_Optimized:SetActive(show)
end

function AbyssChallengeView:_CreateRelicTableView()
  local cellRT = self.ui.UI_Dungeons_Item_Award_Creation:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.relicTableView = self:CreateTableview(self.ui.ScrollView_Initial, function()
    if not self.initRelicList then
      return 0
    end
    return #self.initRelicList
  end, function(view, index)
    do return self._RelicCellAtIndex, self, view end
    return self._RelicCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function AbyssChallengeView:_RelicCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_Award_Creation)
  local viewData = {
    relicTid = self.initRelicList[index],
    hideName = true
  }
  self:AddViewComponentOnce(cell.gameObject, UICompRelicIconItem, viewData)
  return cell
end

function AbyssChallengeView:_RefreshRelicList()
  self.initRelicList = self.model:GetInitRelicList(self.model:GetCurSelectStageTid())
  self.relicTableView:ReloadData()
end

function AbyssChallengeView:_CreateMonsterTableView()
  local cellRT = self.ui.MonsterIconEmpty:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.monsterTableView = self:CreateTableview(self.ui.ScrollView_MonsterDetails, function()
    if not self.monsterTidList then
      return 0
    end
    return #self.monsterTidList
  end, function(view, index)
    do return self._MonsterCellAtIndex, self, view end
    return self._MonsterCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function AbyssChallengeView:_MonsterCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.MonsterIconEmpty)
  local monsterTid = self.monsterTidList[index]
  local curSelectStageTid = self.model:GetCurSelectStageTid()
  
  local function OnMonsterItemClick()
    self.model:SetSelectMonsterTid(monsterTid)
  end
  
  local function IsChoosedFunc(tid)
    return tid == self.model.curSelectMonsterTid
  end
  
  local monsterIconData = {
    stageId = curSelectStageTid,
    tid = monsterTid,
    onClick = OnMonsterItemClick,
    isChoosed = IsChoosedFunc
  }
  self:SetIcon(MaterialIconType.CommonMonster, cell.gameObject, monsterIconData)
  return cell
end

function AbyssChallengeView:_RefreshMonsterList()
  self.monsterTidList = self.model:GetMonsterTidList(self.model:GetCurSelectStageTid())
  self.monsterTableView:ReloadData()
end

function AbyssChallengeView:_CreatePassedAwakerTableView()
  local cellRT = self.ui.UI_Common_Item_WuPin_Type2:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.passedAwakerTableView = self:CreateTableview(self.ui.ScrollView_Reward, function()
    if not self.passedAwakerDataList then
      return 0
    end
    return #self.passedAwakerDataList
  end, function(view, index)
    do return self._AwakerCellAtIndex, self, view, index end
    return self._AwakerCellAtIndex, self, view, index, false
  end, function()
    return width, height
  end)
end

function AbyssChallengeView:_CreateExtraAwakerTableView()
  local cellRT = self.ui.UI_Common_Item_WuPin_Type2:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.extraAwakerTableView = self:CreateTableview(self.ui.ScrollView_Team_Extra, function()
    if not self.extraAwakerDataList then
      return 0
    end
    return #self.extraAwakerDataList
  end, function(view, index)
    do return self._AwakerCellAtIndex, self, view, index end
    return self._AwakerCellAtIndex, self, view, index, true
  end, function()
    return width, height
  end)
end

function AbyssChallengeView:_AwakerCellAtIndex(view, index, isExtra)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type2)
  local awakerData = self.passedAwakerDataList[index]
  if isExtra then
    awakerData = self.extraAwakerDataList[index]
  end
  
  local function _OpenCopyAbyssSettleView(isExtraParam)
    self:_OpenCopyAbyssSettleView(isExtraParam)
  end
  
  local function _OnClickAwakers()
    _OpenCopyAbyssSettleView(isExtra)
  end
  
  local awakerItemData = {
    awakerId = awakerData.tid,
    itemCount = LT.Textf("Team_AwakerLevel", awakerData.level),
    clickFunc = _OnClickAwakers
  }
  self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, awakerItemData)
  return cell
end

function AbyssChallengeView:_RefreshPassedAwakerList()
  self.passedAwakerDataList = self.model:GetPassedAwakerDataList()
  self.passedAwakerTableView:ReloadData()
end

function AbyssChallengeView:_RefreshExtraAwakerList()
  if not self.extraAwakerTableView then
    self:_CreateExtraAwakerTableView()
  end
  local curSelectStageTid = self.model:GetCurSelectStageTid()
  if 0 == curSelectStageTid or nil == curSelectStageTid then
    return
  end
  self.extraAwakerDataList = self.model:GetPassedExtraAwakerDataList(curSelectStageTid)
  if self.extraAwakerDataList and #self.extraAwakerDataList > 0 then
    self.ui.Text_Extra_None:SetActive(false)
  else
    self.ui.Text_Extra_None:SetActive(true)
  end
  self.extraAwakerTableView:ReloadData()
end

function AbyssChallengeView:_RefreshPassedTeam()
end

function AbyssChallengeView:_CreateStageTableView()
  local cellRT = self.ui.UI_Dungeons_Item_Common_Tier2:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.stageTableView = self:CreateTableview(self.ui.ScrollView_Difficulty, function()
    if not self.stageList then
      return 0
    end
    return #self.stageList
  end, function(view, index)
    do return self._StageCellAtIndex, self, view end
    return self._StageCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function AbyssChallengeView:_StageCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_Common_Tier2)
  local stageData = self.stageList[index]
  
  local function OnClickStage()
    local curSelectStageTid = self.model:GetCurSelectStageTid()
    if curSelectStageTid == stageData.tid then
      return
    end
    self.model:SetCurSelectStageTid(stageData.tid)
  end
  
  local function IsChoosedFunc(tid)
    return tid == self.model:GetCurSelectStageTid()
  end
  
  local function IsPassedStage(tid)
    return tid == self.model:GetPassedStageTid()
  end
  
  self:AddViewComponentOnce(cell.gameObject, UICompAbyssStageListItem, stageData, OnClickStage, IsChoosedFunc, IsPassedStage)
  return cell
end

function AbyssChallengeView:_RefreshStageList()
  self.stageList = self.model:GetAbyssStageDataList(self.data.stageGroupTid)
  self.stageTableView:ReloadData()
end

function AbyssChallengeView:_GetFirstSelectStageTid()
  local passedStageTid = self.model:GetPassedStageTid()
  if passedStageTid and passedStageTid > 0 then
    return passedStageTid
  end
  return self.stageList and self.stageList[1] and self.stageList[1].tid or 0
end

function AbyssChallengeView:_OnSelectStageChanged()
  self:_RefreshStageList()
  self:_RefreshStageDetailUI()
end

function AbyssChallengeView:_OnSelectMonsterChanged(curSelectMonsterTid)
  self:RemoveUICustomInputlistener(self.ui.UI_Chapter_Popup_Blame_Tip_Optimized)
  local isValidMonsterTid = self.model:IsSelectMonsterValid(curSelectMonsterTid)
  if isValidMonsterTid then
    local monsterDetailTipsData = {
      stageId = self.model:GetCurSelectStageTid(),
      monsterTid = curSelectMonsterTid
    }
    self:AddViewComponentOnce(self.ui.UI_Chapter_Popup_Blame_Tip_Optimized, CompPublicMonsterDetailTips, monsterDetailTipsData)
    self:AddUICustomInputlistener(self.ui.UI_Chapter_Popup_Blame_Tip_Optimized, function(hover)
      if not hover then
        self.model:SetSelectMonsterTid(nil)
      end
    end)
  end
  self:SetMonsterTipShow(isValidMonsterTid)
end

function AbyssChallengeView:_OnAbyssDataChanged()
  local stageGroupData = AbyssExtModel.Instance:GetStageGroupData(self.data.stageGroupTid)
  self.model:UpdateData(stageGroupData)
  self:_RefreshView()
  local firstSelectStageTid = self:_GetFirstSelectStageTid()
  self.model:SetCurSelectStageTid(firstSelectStageTid)
end

function AbyssChallengeView:_OnResetStage()
  self.model:SetPassedStageTid(0)
  self:_SetEmptyTeamShow()
  self:_RefreshStageList()
  self:_RefreshPassedAwakerList()
  self:_RefreshResetBtnShow()
end

function AbyssChallengeView:_RefreshResetBtnShow()
  local isSelectPassedStage = self.model:IsPassedStage(self.model:GetCurSelectStageTid())
  self.ui.Btn_Receive_Small:SetActive(isSelectPassedStage)
end

function AbyssChallengeView:_OpenCopyAbyssSettleView(isExtra)
  local activityTid = AbyssExtModel.Instance:GetCurrActivityTid()
  local stageGroupDatas = AbyssExtModel.Instance:GetStageGroupDatas()
  local recordList = AbyssExtModel.Instance:CalcRecordDataListByServer(activityTid, stageGroupDatas)
  local playerUid = PlayerDataUtils.GetPlayerUid()
  local viewData = {
    recordList = recordList,
    playerUid = playerUid,
    firstStageGroupTid = self.data.stageGroupTid,
    isExtra = isExtra
  }
  CopyController.Instance:OnOpenCopyAbyssSettleView(viewData)
end

function AbyssChallengeView:_OnClickChallenge()
  local curSelectStageTid = self.model:GetCurSelectStageTid()
  
  local function _OnChallengeFinished()
    StageExitPanelManager.Instance:PushWhenAbyssChallengeExit(curSelectStageTid)
  end
  
  local function _Challenge()
    local extraData = AbyssExtModel.Instance:GetAbyssData() or {}
    WorldStageManager.Instance:CheckOpen(curSelectStageTid, _OnChallengeFinished, nil, nil, extraData)
  end
  
  local isHaveExtra = self.model:IsHaveExtraChallenge(curSelectStageTid)
  local isPassNormal = self.model:IsPassNormalChallenge(curSelectStageTid)
  local isPassExtra = self.model:IsPassExtraChallenge(curSelectStageTid)
  if isHaveExtra and isPassNormal and not isPassExtra then
    local passStageTid = self.model:GetPassedStageTid()
    local config = CopyDataUtils.GetStageConfig(passStageTid)
    local extraScore = AbyssExtChallengeModel.Instance:GetChallengeExtraScore(curSelectStageTid)
    Alert.ShowWithParams(20225, {
      LT.Text(config.Name),
      extraScore
    }, nil, _Challenge)
    return
  end
  local passStageTid = self.model:GetPassedStageTid()
  if passStageTid and passStageTid > 0 then
    local config = CopyDataUtils.GetStageConfig(passStageTid)
    
    local function _ResetStageGroup()
      AbyssController.Instance:ReqResetAbyssChallenge(self.data.stageGroupTid, nil, function()
        Alert.ShowWithParams(10754, {
          LT.Text(config.Name)
        })
        _Challenge()
      end)
    end
    
    local tipText = LT.Textf(DT.TipsType[20128].Desc, LT.Text(config.Name))
    Alert.Show(20128, nil, _ResetStageGroup, nil, tipText)
    return
  end
  _Challenge()
end

function AbyssChallengeView:OnClickClose()
  self:Close()
end

function AbyssChallengeView:_OnClickCreation()
  UIManager.Instance:Reopen(Urls.MainCopyRelicGroupPanel, self.model:GetCurSelectStageTid())
end

function AbyssChallengeView:_OnClickStageInitialState()
  UIManager.Instance:Reopen(Urls.StageInitialStateDetailView, self.model:GetCurSelectStageTid())
end

function AbyssChallengeView:_OnClickReplay()
  CopyRecordsController.Instance:OpenCopyRecordsView(self.model:GetCurSelectStageTid())
end

function AbyssChallengeView:_OnClickReset(isExtra)
  local curSelectStageTid = self.model:GetCurSelectStageTid()
  local isSelectPassedStage = self.model:IsPassedStage(curSelectStageTid)
  if not isSelectPassedStage then
    return
  end
  local config = CopyDataUtils.GetStageConfig(curSelectStageTid)
  
  local function _OnReset()
    AbyssController.Instance:ReqResetAbyssChallenge(self.data.stageGroupTid, isExtra, function()
      Alert.ShowWithParams(10754, {
        LT.Text(config.Name)
      })
    end)
  end
  
  local tipsId = 20124
  if isExtra then
    tipsId = 20226
  elseif AbyssExtChallengeModel.Instance:IsPassExtraChallenge(curSelectStageTid) then
    tipsId = 20227
  end
  Alert.Show(tipsId, nil, _OnReset)
end

function AbyssChallengeView:OnExitView()
  Super.OnExitView(self)
  self.model:ResetViewSelectData()
end

return AbyssChallengeView
