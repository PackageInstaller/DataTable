local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local MAX_STAR_NUM = 3
local SchoolTowerDetailView, Super = NewClass("SchoolTowerDetailView", BaseView)
SchoolTowerDetailView.uiResCls = UI_Dungeous_Panel_Realms_NewResource

function SchoolTowerDetailView:ctor(stageGroupTid, stageId)
  Super.ctor(self)
  self.model = SchoolTowerModel.Instance
  self.model:RefreshDetailViewData(stageGroupTid, stageId)
end

function SchoolTowerDetailView:RegisterNotifications()
  self:_InitStageListView()
  self:_InitRelicListView()
  self:_InitMonsterListView()
  self:_InitRewardListView()
  self:RegisterLocalNotify(NotifyId.OnSchoolTowerDetailSelectStageChanged, self._RefreshView, self)
  self:RegisterLocalNotify(NotifyId.OnSchoolTowerDetailSelectMonsterChanged, self._RefreshMonsterListView, self)
  self:AddButtonClickListener(self.ui.Btn_Mask, function()
    self.model:Set_curMonsterTid(nil)
  end)
  self:AddButtonClickListener(self.ui.Btn_Replay, System.fn(self, self.OnBtnReplay))
  self:AddButtonClickListener(self.ui.Btn_Relics, function()
    UIManager.Instance:Reopen(Urls.MainCopyRelicGroupPanel, self.model.selectStageTid)
  end)
  self:AddButtonClickListener(self.ui.Btn_Star, function()
    local starProgress = SchoolTowerDataUtils.GetTowerStageStar(self.model.selectStageGroupTid, self.model.selectStageTid)
    UIManager.Instance:Reopen(Urls.DungeonSchoolTowerStarPanel, self.model.selectStageTid, starProgress)
  end)
  self:AddButtonClickListener(self.ui.Btn_Challenge, function()
    if not self:_CheckCanChallengeAndShowTips() then
      return
    end
    WorldStageManager.Instance:CheckOpen(self.model.selectStageTid, function()
      StageExitPanelManager.Instance:PushWhenDisposableSchoolTowerExit(self.model.selectStageTid)
    end, {})
  end)
end

function SchoolTowerDetailView:_InitRewardListView()
  local cellRT = self.ui.UI_Common_Item_WuPin_Type2:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.rewardListView = self:CreateTableview(self.ui.ScrollView_Rewards, function()
    if not self.model.rewardDataList then
      return 0
    end
    return #self.model.rewardDataList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type2)
    local reward = self.model.rewardDataList[index]
    local viewData = {
      itemTid = reward.tid,
      itemCount = reward.count,
      clickFunc = function()
        ItemDataUtils.ShowItemDetailTips(self.binder, cell.gameObject, nil, reward.tid)
      end
    }
    self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, viewData)
    return cell
  end, function()
    return width, height
  end)
end

function SchoolTowerDetailView:_InitStageListView()
  local cellRT = self.ui.UI_Dungeons_Item_Common_Tier2:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.stageListView = self:CreateTableview(self.ui.ScrollView_Difficulty, function()
    if not self.model.stageDataList then
      return 0
    end
    return #self.model.stageDataList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_Common_Tier2)
    local stageData = self.model.stageDataList[index]
    self:AddViewComponentOnce(cell.gameObject, UICompSchoolTowerStageListItem, stageData)
    return cell
  end, function()
    return width, height
  end)
  self.isLoadedStageListView = false
  
  function self.stageListView.reloadFinishCallback()
    if self.isLoadedStageListView then
      return
    end
    self.isLoadedStageListView = true
    local stageDataList = self.model.stageDataList or {}
    for i = 1, #stageDataList do
      if stageDataList[i].stageID == self.model.selectStageTid then
        self.stageListView:MoveCellInView(i - 1)
        break
      end
    end
  end
end

function SchoolTowerDetailView:_InitRelicListView()
  local cellRT = self.ui.UI_Dungeons_Item_Award_Creation:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.relicListView = self:CreateTableview(self.ui.ScrollView_Initial, function()
    if not self.model.relicDataList then
      return 0
    end
    return #self.model.relicDataList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_Award_Creation)
    local viewData = {
      relicTid = self.model.relicDataList[index],
      hideName = true
    }
    self:AddViewComponentOnce(cell.gameObject, UICompRelicIconItem, viewData)
    return cell
  end, function()
    return width, height
  end)
end

function SchoolTowerDetailView:_InitMonsterListView()
  local cellRT = self.ui.UI_Chapter_Item_Monster:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.monsterListView = self:CreateTableview(self.ui.ScrollView_MonsterDetails, function()
    if not self.model.monsterDataList then
      return 0
    end
    return #self.model.monsterDataList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Chapter_Item_Monster)
    local monsterTid = self.model.monsterDataList[index]
    local viewData = {
      stageTid = self.model.selectStageTid,
      monsterTid = monsterTid,
      isSelect = self.model.curMonsterTid == monsterTid,
      onClickFunc = function()
        self.model:Set_curMonsterTid(monsterTid)
      end
    }
    self:AddViewComponentOnce(cell.gameObject, UICompMonsterItem, viewData)
    return cell
  end, function()
    return width, height
  end)
end

function SchoolTowerDetailView:RegisterEvents()
end

function SchoolTowerDetailView:OnEnterView()
  Super.OnEnterView(self)
  self.compCloseBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back2, UICompBtnCloseItem, System.fn(self, self.Close))
  self:SetActive(self.ui.Btn_Replay, true)
  self:_RefreshView()
  self:_ListViewAnimPlay()
end

function SchoolTowerDetailView:_RefreshView()
  self:_RefreshStageListView()
  self:_RefreshRelicListView()
  self:_RefreshMonsterListView()
  self:_RefreshRewardListView()
  self:_RefreshStarGroup()
  self:_RefreshChallengeBtn()
  self:SetText(self.ui.Text_Cost_Num, self:_GetLimitSchoolNum())
  self:SetText(self.ui.Text_Title, self:_GetTitle())
  self:SetText(self.ui.Text_Name, LT.Text(self.model:GetCurStageCfgField("Name")))
  self:SetText(self.ui.Text_Introduce, LT.Text(self.model:GetCurStageCfgField("Desc")))
  self:SetImage(self.ui.Image_Realms, self:_GetLimitSchoolImage())
  self:SetImage(self.ui.Image_D_Bg, self.model:GetCurStageGroupCfgField("Backgrand"))
  self.ui.RootRecommendSchool:SetActive(false)
  self.ui.Image_Bg_Dif:SetActive(self.model:GetCurStageGroupCfgField("Type") == CommonDefine.StageGroupType.AlternationSchoolTower)
  self:AddViewComponentOnce(self.ui.UI_Common_Btn_StageChapter, CopyChapterMvcItem, self.model.selectStageTid)
end

function SchoolTowerDetailView:_RefreshChallengeBtn()
  self:SetButtonState(self.ui.Btn_Challenge, self:_GetChallengeBtnState())
  self:SetButtonText(self.ui.Btn_Challenge, LT.Text("DailyCopy_Start"))
end

function SchoolTowerDetailView:_IsMonsterTipVisible()
  return self.model.curMonsterTid ~= nil
end

function SchoolTowerDetailView:_GetLimitSchoolImage()
  local rst = CopyDataUtils.GetAwakerRequirementMap(self.model.selectStageTid)
  for schoolId, _ in pairs(rst) do
    return DT.SchoolConfig[schoolId].Icon
  end
  return ""
end

function SchoolTowerDetailView:_GetTitle()
  if 0 == self.model.selectStageGroupTid then
    return ""
  end
  do return LT.Text end
  return LT.Text, DT.StageGroup[self.model.selectStageGroupTid].Name, self.model.selectStageGroupTid
end

function SchoolTowerDetailView:_GetLimitSchoolNum()
  local rst = CopyDataUtils.GetAwakerRequirementMap(self.model.selectStageTid)
  for _, num in pairs(rst) do
    return ItemNumUtils.GetStr(num)
  end
  return ""
end

function SchoolTowerDetailView:_RefreshStarGroup()
  local stageGroupTid = self.model.selectStageGroupTid
  self:AddViewComponentOnce(self.ui.Com_RedDot_Star, UICompRedDot, CommonDefine.RedDotType.Dot, nil, function()
    local result = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.MainStageGetAward, {stageGroupTid})
    return result
  end)
  self:SetText(self.ui.Text_Progress_3, SchoolTowerDataUtils.GetTowerProgressStars(stageGroupTid))
  self:SetText(self.ui.Text_Progress_4, SchoolTowerDataUtils.GetTowerLimitStars(stageGroupTid))
  self:AddButtonClickListener(self.ui.Btn_Progress, function()
    SchoolTowerController.Instance:OpenProgressFirstRewardView(stageGroupTid)
  end)
  for i = 1, MAX_STAR_NUM do
    local starObj = self.ui["Star_" .. i]
    if starObj then
      local star = SchoolTowerDataUtils.GetTowerStageStar(self.model.selectStageGroupTid, self.model.selectStageTid)
      starObj:SetActive(i <= star)
    end
    local descObj = self.ui["Text_Star" .. i]
    if descObj then
      local stageCfg = DT.Stage[self.model.selectStageTid]
      local taskId = stageCfg.PerfectCondition[i]
      local taskDesc = DT.Task[taskId].Desc
      self:SetText(descObj, taskDesc)
    end
  end
end

function SchoolTowerDetailView:OnBtnReplay()
  CopyRecordsController.Instance:OpenCopyRecordsView(self.model.selectStageTid)
end

function SchoolTowerDetailView:_RefreshRewardListView()
  self.rewardListView:ReloadData()
end

function SchoolTowerDetailView:_RefreshStageListView()
  self.stageListView:ReloadData()
end

function SchoolTowerDetailView:_RefreshRelicListView()
  self.relicListView:ReloadData()
end

function SchoolTowerDetailView:_RefreshMonsterListView()
  self.monsterListView:ReloadData()
  local viewData = {
    stageId = self.model.selectStageTid,
    monsterTid = self.model.curMonsterTid
  }
  self:AddViewComponentOnce(self.ui.UI_Chapter_Popup_Blame_Tip_New, UICompMonsterDetailItem, viewData)
  self.ui.Btn_Mask:SetActive(self:_IsMonsterTipVisible())
  self.ui.UI_Chapter_Popup_Blame_Tip_New:SetActive(self:_IsMonsterTipVisible())
end

function SchoolTowerDetailView:_GetChallengeBtnState()
  local btnState = CommonDefine.BtnType.High
  local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(self.model:GetCurStageGroupCfgField("Type"))
  if showLevelLimit then
    if not CopyDataUtils.CheckLevelReach(self.model.selectStageTid) then
      btnState = CommonDefine.BtnType.Unclickable
    end
  elseif CopyDataUtils.GetIsLocked(self.model.selectStageTid, self.model.stageDataList) then
    btnState = CommonDefine.BtnType.Unclickable
  end
  return btnState
end

function SchoolTowerDetailView:_CheckCanChallengeAndShowTips()
  local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(self.model:GetCurStageGroupCfgField("Type"))
  if showLevelLimit then
    if not CopyDataUtils.CheckLevelReach(self.model.selectStageTid) then
      Alert.ShowStr(LT.Text("SchoolTowerChallengeNotReachLevelTips"))
      return false
    end
  elseif CopyDataUtils.GetIsLocked(self.model.selectStageTid, self.model.stageDataList) then
    Alert.ShowStr(LT.Text("SchoolTowerChallengeLockTips"))
    return false
  end
  return true
end

function SchoolTowerDetailView:_ListViewAnimPlay()
  self:PlayTableViewFadeInAnim(self.ui.ScrollView_Difficulty)
end

function SchoolTowerDetailView:RefreshOnRendered()
end

function SchoolTowerDetailView:OnEnterViewFinished()
end

function SchoolTowerDetailView:OnExitView()
  self.compCloseBtn:PlayCloseAnim()
  Super.OnExitView(self)
end

return SchoolTowerDetailView
