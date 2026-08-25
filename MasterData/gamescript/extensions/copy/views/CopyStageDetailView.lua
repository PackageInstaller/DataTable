local CopyStageDetailView, Super = NewClass("CopyStageDetailView", BaseView)
CopyStageDetailView.uiResCls = UI_Chaper_Popup_Particulars_ViewResource

function CopyStageDetailView:ctor(stageTid, challengeCb, withoutOpenItem, isSubplotInActivity)
  Super.ctor(self)
  self.stageId = stageTid
  self.challengeCb = challengeCb
  self.withoutOpenItem = withoutOpenItem
  self.isSubplotInActivity = isSubplotInActivity
  CopyStageDetailModel.Instance:SetStageGroupId(self.stageId)
  CopyStageDetailModel.Instance:SetStageGroupData()
end

function CopyStageDetailView:RegisterNotifications()
end

function CopyStageDetailView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Window_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Question_2, System.fn(self, self._OnClickQuestion))
  self:AddButtonClickListener(self.ui.Btn_Determine, System.fn(self, self._OnClickChallenge))
  self:AddButtonClickListener(self.ui.Btn_Unlock, System.fn(self, self._OnClickUnlock))
  self:AddButtonClickListener(self.ui.Btn_Click_UP, System.fn(self, self._OnClickPreStage))
  self:AddButtonClickListener(self.ui.Btn_Click_Down, System.fn(self, self._OnClickNextStage))
  self:AddButtonClickListener(self.ui.Btn_Monster, System.fn(self, self._OnClickRelic))
  self:AddButtonClickListener(self.ui.Btn_Reward, System.fn(self, self._OnClickHideReward))
  self:AddButtonClickListener(self.ui.Btn_Achievement, System.fn(self, self._OnClickAchievement))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self._OnClickCloseBlameTip))
  self:AddButtonClickListener(self.ui.Btn_Replay, System.fn(self, self._OnClickBtnReplay))
end

function CopyStageDetailView:OnEnterView()
  Super.OnEnterView(self)
  self:LoadAllLangFont(self.ui.Text_Level_Name)
  self.curMonsterTid = nil
  self.starLevel = 0
  self.monsterList = {}
  self.battleRewardList = {}
  self.plotRewardList = {}
  self.uiAnimController = self.ui.Group_Content:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self:_SetPopUpTipData()
  self:_InitTableView()
  self:_RefreshInfo()
  self:_AddEffectAudioPostCtrl()
end

function CopyStageDetailView:OnExitView()
  Super.OnExitView(self)
end

function CopyStageDetailView:_SetPopUpTipData()
  local commonPopupConfirmTipsData = {
    textTitleCN = LT.Text("MainLinesDetail"),
    sizeType = CommonDefine.PopupTipsType.L,
    clickFunc = System.fn(self, self.Close)
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_L, CompPublicPopupTips, commonPopupConfirmTipsData)
end

function CopyStageDetailView:_RefreshInfo()
  self:_RefreshData()
  self:_RefrshStarLevel()
  self:_RefreshCoinGroup()
  self:_RefreshUI()
  self:AddViewComponentOnce(self.ui.UI_Common_Btn_StageChapter, CopyChapterMvcItem, self.stageId)
end

function CopyStageDetailView:_RefreshData()
  CopyStageDetailModel.Instance:SetWithoutOpenItem(self.withoutOpenItem)
  self.isStoryReviewMode = StoryReviewModel.Instance:IsReviewingStory()
  self.stageGroupId = CopyStageDetailModel.Instance:GetStageGroupId()
  self.starLevel = CopyStageDetailModel.Instance:GetStarLevel(self.stageId)
  self.hasUseUnlockItem = CopyStageDetailController.Instance:HasUseUnlockItem(self.stageId)
  self.monsterList = CopyStageDetailModel.Instance:GetMonsterList(self.stageId)
  self.battleRewardList = CopyStageDetailController.Instance:GetRewardList(self.stageId, self.starLevel, false)
  self.plotRewardList = CopyStageDetailController.Instance:GetRewardList(self.stageId, self.starLevel, true)
  self.isEnergyEnough = CopyStageDetailModel.Instance:IsEnergyEnough(self.stageId)
  self.stageIndex = CopyStageDetailModel.Instance:GetStageIndex(self.stageId)
  self.costItemTid, self.costCount = CopyStageDetailModel.Instance:GetOpenItem(self.stageId)
  self.achievementTotalCount, self.achievementCount = CopyStageDetailController.Instance:GetAchiveCount(self.stageId)
end

function CopyStageDetailView:_RefreshCoinGroup()
  local coinId = DT.GetConstant("MainCopyDetailPanelCurrencies")
  local clickCallback = PlayerDataUtils.ShowEnergyRestorePanel
  if not self.withoutOpenItem and not self.hasUseUnlockItem then
    clickCallback = nil
    if 0 ~= self.costItemTid then
      coinId = self.costItemTid
    end
  end
  self:AddViewComponentOnce(self.ui.Coin_1, UICoinInfoComponent, coinId, clickCallback)
end

function CopyStageDetailView:_InitTableView()
  self.monsterView = self:CreateTableview(self.ui.ScrollView_Blame, function()
    if not self.monsterList then
      return 0
    end
    return #self.monsterList
  end, function(view, index)
    do return self._MonsterCellAtIndex, self, view end
    return self._MonsterCellAtIndex, self, view, index
  end)
  self.battleRewardView = self:CreateTableview(self.ui.ScrollView_Article, function()
    if not self.battleRewardList then
      return 0
    end
    return #self.battleRewardList
  end, function(view, index)
    do return self._RewardCellAtIndex, self, view, index end
    return self._RewardCellAtIndex, self, view, index, self.battleRewardList
  end)
  self.plotRewardView = self:CreateTableview(self.ui.ScrollView_Reward, function()
    if not self.plotRewardList then
      return 0
    end
    return #self.plotRewardList
  end, function(view, index)
    do return self._RewardCellAtIndex, self, view, index end
    return self._RewardCellAtIndex, self, view, index, self.plotRewardList
  end)
end

function CopyStageDetailView:_MonsterCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Chapter_Item_Monster)
  local monsterTid = self.monsterList[index]
  
  local function OnMonsterItemClick()
    self:_OnSelectMonsterChanged(monsterTid)
  end
  
  local monsterData = {
    stageTid = self.stageId,
    monsterTid = self.monsterList[index],
    isSelect = monsterTid == self.curMonsterTid,
    onClickFunc = OnMonsterItemClick
  }
  self:AddViewComponentOnce(cell.gameObject, UICompMonsterItem, monsterData)
  return cell
end

function CopyStageDetailView:_RewardCellAtIndex(view, index, rewardList)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.item_Article)
  local reward = rewardList[index]
  local itemAwardTypeDescMap = CommonDefine.ItemAwardType2TagMap()
  local hasTag = reward.type and reward.type ~= CommonDefine.ItemAwardType.Normal
  local itemData = {
    itemTid = reward.tid,
    itemCount = reward.num,
    isGot = reward.isGot,
    extraDesc = hasTag and itemAwardTypeDescMap[reward.type] or nil,
    extraDescBgType = hasTag and CommonDefine.CommonIconExtraDescBgType.Blue or nil
  }
  self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, itemData)
  return cell
end

function CopyStageDetailView:_RefrshStarLevel()
  local starData = {
    stageTid = self.stageId,
    star = self.starLevel,
    clickFunc = function()
      if self.stageId and self.stageId > 0 then
        UIManager.Instance:Reopen(Urls.MainCopyStarPanel, self.stageId)
      end
    end
  }
  self:AddViewComponentOnce(self.ui.Group_Star, CompStageStar, starData)
end

function CopyStageDetailView:_RefreshUI()
  self.stageCfg = CopyStageDetailModel.Instance:GetStageCfg(self.stageId)
  if not self.stageCfg then
    return
  end
  local commandLevel = CopyStageDetailModel.Instance:GetCommandLevel(self.stageId)
  local commandSchool = CopyStageDetailModel.Instance:GetCommandSchool(self.stageId)
  local isHaveMap = CopyStageDetailModel.Instance:IsHaveMap(self.stageId)
  local isHaveMonster = CopyStageDetailModel.Instance:IsHaveMonster(self.stageId)
  local isNormalStage = CopyStageDetailModel.Instance:IsNormalStage(self.stageId)
  local isDifficulty = CopyStageDetailModel.Instance:IsDifficulty(self.stageId)
  local isShowStar = CopyStageDetailModel.Instance:IsShowStar(self.stageId)
  local isStoryStage = CopyStageDetailModel.Instance:IsStoryStage(self.stageId)
  local hideNodeCount, curHideNodeCount = CopyStageDetailController.Instance:GetHideNode(self.stageId)
  local isShowReward = CopyStageDetailController.Instance:IsShowReward(self.stageId)
  local isMeltDisaster = CopyStageDetailModel.Instance:IsMeltDisaster(self.stageId)
  local isHighDiffculty = CopyStageDetailModel.Instance:IsHighDiffculty(self.stageId)
  local _, costCount, oriCostCount = CopyStageDetailController.Instance:GetCostInfo(self.stageId)
  local isCanChallenge = CopyStageDetailModel.Instance:IsCanChanllenge(self.stageId)
  self.ui.Image_Lv:SetActive(commandLevel)
  self.ui.Group_Star:SetActive(isShowStar)
  self.ui.Group_Achievement:SetActive(false)
  self.ui.Group_Reward:SetActive(isShowReward)
  self.ui.Image_Monster:SetActive(isHaveMonster)
  self.ui.Coin_1:SetActive(0 ~= self.costItemTid)
  self.ui.Image_Introduce:SetActive(isNormalStage)
  self.ui.Text_Price:SetActive(self:_IsShowPrice())
  self.ui.Group_Monster:SetActive(false)
  self.ui.Btn_Unlock:SetActive(self:_IsShowUnlock())
  self.ui.Image_Chapter_Dif:SetActive(isHighDiffculty)
  self.ui.Image_Chapter_Rgb:SetActive(isHighDiffculty)
  self.ui.Image_Chapter:SetActive(not isHighDiffculty)
  self.ui.Image_Recommend:SetActive(#commandSchool > 0)
  self.ui.Text_Reduce:SetActive(self.isSubplotInActivity)
  self.ui.Image_Mask:SetActive(not self.isStoryReviewMode)
  self.ui.UI_Common_Btn_Question_2:SetActive(isDifficulty)
  self.ui.UI_Common_Melt_Disaster:SetActive(isMeltDisaster and not self.isStoryReviewMode)
  self.ui.Image_Overview:SetActive(commandLevel or #commandSchool > 0)
  self.ui.Image_Single:SetActive(isStoryStage and not self.isStoryReviewMode)
  self.ui.Group_UP:SetActive(CopyStageDetailController.Instance:IsStageValid(self.stageIndex - 1))
  self.ui.Group_Down:SetActive(CopyStageDetailController.Instance:IsStageValid(self.stageIndex + 1))
  self:SetText(self.ui.Text_Grade, commandLevel)
  self:SetText(self.ui.Text_Price, LT.Text(costCount))
  self:SetText(self.ui.Text_Reduce, LT.Text(oriCostCount))
  self:SetText(self.ui.Text_Details, LT.Text(self.stageCfg.Desc))
  self:SetText(self.ui.Text_Level_Number, self.stageCfg.NameNumber)
  self:SetText(self.ui.Text_Level_Name, StageCfgUtils.GetStageName(self.stageId, self.ui.Text_Level_Name))
  self:SetTextColorType(self.ui.Text_Price, System.fn(self, self._GetTextPriceColorState))
  self:SetText(self.ui.Text_Reward, LT.Textf("StageHideRewardsButton", hideNodeCount, curHideNodeCount))
  self:SetText(self.ui.Text_Achievement, LT.Textf("StageAchievementButton", self.achievementTotalCount, self.achievementCount))
  self:SetButtonState(self.ui.Btn_Unlock, self:_GetUnlockBtnState())
  self:SetButtonText(self.ui.Btn_Unlock, LT.Text("UniversalUnlockButton"))
  self:SetButtonText(self.ui.Btn_Cancel, LT.Text("UniversalCancelButton"))
  self:SetButtonText(self.ui.Btn_Determine, LT.Text(isHaveMap and "MainLinesChallenge" or "MainLinesInvestigation"))
  self:SetButtonState(self.ui.Btn_Determine, isCanChallenge and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
  local oriStageCfg = CopyStageDetailModel.Instance:GetOriStageCfg(self.stageId)
  if oriStageCfg.Backgrand then
    self:SetImage(self.ui.Image_Chapter, oriStageCfg.Backgrand)
    self:SetImage(self.ui.Image_Chapter_Rgb, oriStageCfg.Backgrand)
  end
  if 0 ~= self.costItemTid then
    self:SetImage(self.ui.Image_Icon, ItemDataUtils.GetItemIcon(self.costItemTid))
  end
  
  local function clickFunc()
    AvgTutorialManager.Instance:PlayTutorialAvgByKeyWord(DT.GetConstant("AbyssChallengeTutorialAvg"), CommonDefine.AVGTutorialKeyWord.AbyssChallengeRule)
  end
  
  if not self.isStoryReviewMode then
    self:AddViewComponentOnce(self.ui.UI_Common_Melt_Disaster, UICompStageInitialStateBtn, self.stageId, clickFunc)
  end
  self.monsterView:ReloadData()
  self.battleRewardView:ReloadData()
  self.plotRewardView:ReloadData()
  self:_RefreshReplayBtnStatus(isStoryStage)
end

function CopyStageDetailView:_RefreshReplayBtnStatus(isStoryStage)
  if self.isStoryReviewMode or isStoryStage then
    self.ui.Btn_Replay:SetActive(false)
    return
  end
  self.ui.Btn_Replay:SetActive(true)
end

function CopyStageDetailView:_OnSelectMonsterChanged(monsterTid)
  self.curMonsterTid = monsterTid
  local isValidMonsterTid = CopyStageDetailController.Instance:IsMonsterValid(monsterTid)
  if isValidMonsterTid then
    local monsterDetailTipsData = {
      stageId = self.stageId,
      monsterTid = self.curMonsterTid
    }
    self:AddViewComponentOnce(self.ui.UI_Chapter_Popup_Blame_Tip_Optimized, CompPublicMonsterDetailTips, monsterDetailTipsData)
  end
  self.ui.Btn_Mask:SetActive(isValidMonsterTid)
  self.ui.UI_Chapter_Popup_Blame_Tip_Optimized:SetActive(isValidMonsterTid)
  self.monsterView:ReloadData()
end

function CopyStageDetailView:_AddEffectAudioPostCtrl()
  LuaComponentManager.Instance:AddLuaComponentOnce(self.ui.Image_Chapter_Dif)
end

function CopyStageDetailView:_GetTextPriceColorState()
  if self._IsLackOfItem() then
    return CommonDefine.ColorType.Dark
  end
  return CommonDefine.ColorType.Normal
end

function CopyStageDetailView:_IsLackOfItem()
  if self.isSubplotInActivity then
    return false
  end
  if self.costCount > 0 then
    return not self.isEnergyEnough
  end
  if not self.withoutOpenItem and not self.hasUseUnlockItem then
    return not self.isEnergyEnough
  end
  return true
end

function CopyStageDetailView:_GetUnlockBtnState()
  if self.isSubplotInActivity then
    return CommonDefine.BtnType.High
  end
  if self.isEnergyEnough then
    return CommonDefine.BtnType.High
  end
  return CommonDefine.BtnType.Unclickable
end

function CopyStageDetailView:_OnClickQuestion()
  local title = LT.Text("DynamicStageRuleTitle")
  local detail = LT.Text("DynamicStageRuleDesc")
  UIManager.Instance:Reopen(Urls.CommonillustrateView, title, detail)
end

function CopyStageDetailView:_IsShowPrice()
  if 0 ~= self.costItemTid then
    return true
  end
  do return self._IsShowUnlock end
  return self._IsShowUnlock, self
end

function CopyStageDetailView:_IsShowUnlock()
  if self.withoutOpenItem then
    return false
  end
  return not self.hasUseUnlockItem
end

function CopyStageDetailView:_OnClickChallenge()
  if self.isStoryReviewMode then
    StoryReviewController.Instance:StartPlayStoryReview(self.stageId)
    self:Close()
    return
  end
  if not CopyStageDetailModel.Instance:IsCanChanllenge(self.stageId) then
    Alert.Show(10594)
    return
  end
  WorldStageManager.Instance:CheckOpenMainChapter(self.stageId, System.fn(self, self._OnChallenge))
end

function CopyStageDetailView:_OnChallenge()
  if self.challengeCb then
    self.challengeCb()
  end
end

function CopyStageDetailView:_OnClickUnlock()
  if self.isSubplotInActivity then
    Alert.Show(20103, nil, function()
      CopyStageDetailController.Instance:ReqUnlockStageByItem(self.stageId, true)
    end, nil, nil, nil, true)
    return
  end
  if not self.withoutOpenItem or not self.hasUseUnlockItem then
    return
  end
  local itemTid, itemNum = CopyStageDetailModel.Instance:GetOpenItem(self.stageId)
  local itemName = ItemDataUtils.GetItemName(itemTid) or ""
  if not self.hasUseUnlockItem then
    local tipStr = DT.TipsType[10646].Desc
    tipStr = LT.Textf(tipStr, itemName)
    Alert.Show(10646, nil, nil, nil, tipStr)
    return
  end
  
  local function _OnConfirm()
    CopyStageDetailController.Instance:ReqUnlockStageByItem(self.stageId)
  end
  
  local stageName = self.stageCfg.Name
  local costTipStr = LT.Textf(DT.TipsType[20087].Desc, itemName, itemNum, stageName)
  Alert.Show(20087, nil, _OnConfirm, nil, costTipStr)
end

function CopyStageDetailView:_OnClickPreStage()
  if not CopyStageDetailController.Instance:IsStageValid(self.stageIndex - 1) then
    return
  end
  local preStageData = CopyStageDetailModel.Instance:GetStageDataByIndex(self.stageIndex - 1)
  if not preStageData then
    return
  end
  self.stageId = preStageData.stageID
  self:_RefreshInfo()
  self.uiAnimController:PlayState("UI_Chaper_Popup_Particulars_New_Change")
end

function CopyStageDetailView:_OnClickNextStage()
  local nextStageData = CopyStageDetailModel.Instance:GetStageDataByIndex(self.stageIndex + 1)
  if not nextStageData then
    return
  end
  if not nextStageData.unlocked then
    Alert.Show(10578)
    return
  end
  self.stageId = nextStageData.stageID
  self:_RefreshInfo()
  self.uiAnimController:PlayState("UI_Chaper_Popup_Particulars_New_Change")
end

function CopyStageDetailView:_OnClickRelic()
  UIManager.Instance:Reopen(Urls.MainCopyRelicGroupPanel, self.stageId)
end

function CopyStageDetailView:_OnClickHideReward()
  Alert.ShowToolTips(40007, self.ui.Btn_Reward)
end

function CopyStageDetailView:_OnClickAchievement()
  if self.achievementTotalCount <= 0 then
    return
  end
  UIManager.Instance:Reopen(Urls.MainCopyAchievePanel, self.stageCfg.LevelAchieve, self.stageId)
end

function CopyStageDetailView:_OnClickCloseBlameTip()
  self:_OnSelectMonsterChanged(nil)
end

function CopyStageDetailView:_OnClickBtnReplay()
  CopyRecordsController.Instance:OpenCopyRecordsView(self.stageId)
end

return CopyStageDetailView
