local typeof = _ENV.typeof
local UIAnimationController = CS.Z1Client.UIAnimationController
local Image = CS.UnityEngine.UI.Image
local MainCopyStageDetailPanel, Super = System.NewClass("MainCopyStageDetailPanel", UIBasePanel)
MainCopyStageDetailPanel.uiResCls = UI_Chaper_Popup_Particulars_NewResource

function MainCopyStageDetailPanel:ctor(stageTid, challengeCb, withoutOpenItem, hasSubplotActivity)
  Super.ctor(self)
  self.stageTid = stageTid
  self.monsterTids = {}
  self.recommandSchoolTids = {}
  self.showRewardList = {}
  self.showStoryRewardList = {}
  self.monsterTipItem = nil
  self.challengeCb = challengeCb
  self.withoutOpenItem = withoutOpenItem
  self.hasSubplotActivity = hasSubplotActivity
  self.isStoryReviewMode = StoryReviewModel.Instance:IsReviewingStory()
end

function MainCopyStageDetailPanel:OnBind(binder)
  self.model = binder:createModel(MainCopyStageDetailModel, self.stageTid)
  self.uiAnimController = self.ui.Group_Content:GetComponent(typeof(UIAnimationController))
  self:BindBgPrefab()
  self:BindStarsVisible()
  self:BindMonsterTip()
  self:BindCoinComp()
  self:BindAchievementRedDotComp()
  self:BindHighDifficultyUI(binder)
  self:AddEffectAudioPostCtrl(binder)
  binder:BindToText(self.ui.Text_Level_Number, System.fn(self, self._SetStageNumber))
  binder:BindToText(self.ui.Text_Level_Name, System.fn(self, self._SetStageName))
  binder:BindToText(self.ui.Text_Details, System.fn(self, self._SetStageDesc))
  binder:BindToText(self.ui.Text_Grade, System.fn(self, self._SetRecommandLevel))
  binder:BindToText(self.ui.Text_Achievement, System.fn(self, self._SetAchieveCount))
  binder:BindToText(self.ui.Text_Reward, System.fn(self, self._SetTreasureCount))
  binder:BindToText(self.ui.Text_Price, System.fn(self, self._SetCost))
  binder:BindToText(self.ui.Text_Reduce, System.fn(self, self._SetCfgCost))
  binder:BindToTextColor(self.ui.Text_Price, System.fn(self, self._GetTextPriceColorState))
  binder:BindToVisible(self.ui.Image_Overview, System.fn(self, self._IsRecommandVisible))
  binder:BindToVisible(self.ui.Image_Lv, System.fn(self, self._IsRecommandLevelVisible))
  binder:BindToVisible(self.ui.Image_Recommend, System.fn(self, self._IsRecommandSchoolVisible))
  binder:BindToVisible(self.ui.Image_Monster, System.fn(self, self._IsMonsterVisible))
  binder:BindToVisible(self.ui.Group_Star, System.fn(self, self._IsShowGroupStar))
  binder:BindToVisible(self.ui.UI_Common_Btn_Question_2, System.fn(self, self._IsShowIntroduce))
  binder:BindToVisible(self.ui.Text_Price, System.fn(self, self._IsItemCostVisible))
  binder:BindToVisible(self.ui.Text_Reduce, System.fn(self, self._HasSubplotActivity))
  binder:BindToVisible(self.ui.Group_UP, System.fn(self, self._HasPrevStage))
  binder:BindToVisible(self.ui.Group_Down, System.fn(self, self._HasNextStage))
  binder:BindToVisible(self.ui.UI_Chapter_Popup_Blame_Tip, System.fn(self, self._IsMonsterTipVisible))
  binder:BindToVisible(self.ui.Btn_Mask, System.fn(self, self._IsMonsterTipVisible))
  binder:BindToVisible(self.ui.Group_Monster, System.fn(self, self._IsBtnRelicVisible))
  binder:BindToVisible(self.ui.Group_Reward, System.fn(self, self._IsBtnTreasureVisible))
  binder:BindToVisible(self.ui.Group_Achievement, System.fn(self, self._IsBtnAchieveVisible))
  binder:BindToVisible(self.ui.Image_Introduce, System.fn(self, self._IsNormalStage))
  binder:BindToVisible(self.ui.Btn_Unlock, System.fn(self, self._IsUnlockItemVisible))
  binder:BindToVisible(self.ui.UI_Common_Melt_Disaster, System.fn(self, self._IsInitialStateTipsVisible))
  binder:BindToImage(self.ui.Image_Chapter, System.fn(self, self._SetStageBg))
  binder:BindToImage(self.ui.Image_Chapter_Rgb, System.fn(self, self._SetStageBg))
  binder:BindToImage(self.ui.Image_Icon, System.fn(self, self._SetCostIcon))
  binder:BindButtonClick(self.ui.Btn_Click_UP, System.fn(self, self._OnClickPrev))
  binder:BindButtonClick(self.ui.Btn_Click_Down, System.fn(self, self._OnClickNext))
  binder:BindButtonClick(self.ui.Btn_Monster, System.fn(self, self._OnClickRelicGroup))
  binder:BindButtonClick(self.ui.Btn_Reward, System.fn(self, self._OnClickTreasure))
  binder:BindButtonClick(self.ui.Btn_Achievement, System.fn(self, self._OnClickAchieve))
  binder:BindButtonClick(self.ui.Btn_Star, System.fn(self, self._OnClickStar))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self._OnClickMask))
  binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.Window_Mask, System.fn(self, self.Close))
  binder:BindComponent(StageInitialStateBtnItem(self.ui.UI_Common_Melt_Disaster, function()
    return self.model.stageTid
  end, System.fn(self, self._OnClickInitStateClick)))
  binder:BindToVisible(self.ui.Image_Single, System.fn(self, self._IsStoryStage))
  if self.isStoryReviewMode then
    self.ui.Image_Single:SetActive(false)
  end
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question_2, function()
    local title = LT.Text("DynamicStageRuleTitle")
    local detail = LT.Text("DynamicStageRuleDesc")
    UIManager.Instance:Reopen(Urls.CommonillustrateView, title, detail)
  end)
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.Close), function()
    return CommonDefine.BtnType.High
  end, System.fn(self, self._GetCancelBtnText))
  binder:BindZ1Button(self.ui.Btn_Determine, System.fn(self, self._OnClickChallenge), System.fn(self, self._GetChallengeBtnState), System.fn(self, self._GetChallengeBtnText))
  binder:BindZ1Button(self.ui.Btn_Unlock, System.fn(self, self._OnClickUnlock), System.fn(self, self._GetUnlockBtnState), System.fn(self, self._GetUnlockBtnText))
  binder:BindToCircularListView(self.ui.ScrollView_School, System.fn(self, self._GetRecommandSchools), System.fn(self, self._UpdateSchoolIcon))
  binder:BindToCircularListView(self.ui.ScrollView_Blame, System.fn(self, self._GetMonsterList), System.fn(self, self._UpdateMonsterIcon))
  binder:BindToCircularListView(self.ui.ScrollView_Article, System.fn(self, self._GetRewardList), System.fn(self, self._UpdateRewardItem))
  binder:BindToCircularListView(self.ui.ScrollView_Reward, System.fn(self, self._GetStoryRewardList), System.fn(self, self._UpdateStoryRewardItem))
  binder:BindToRaw(System.fn(self, self._OnMonsterChosen), function()
    return self.model.currMonsterTid
  end)
  self.ui.Image_Mask:SetActive(not self.isStoryReviewMode)
end

function MainCopyStageDetailPanel:BindBgPrefab()
  local commonPopupConfirmTipsData = {
    textTitleCN = LT.Text("MainLinesDetail"),
    sizeType = CommonDefine.PopupTipsType.L,
    clickFunc = System.fn(self, self.Close)
  }
  self.binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_L, commonPopupConfirmTipsData))
end

function MainCopyStageDetailPanel:BindCoinComp()
  self.binder:BindToRaw(function(childBinder, nowStageTid)
    if not nowStageTid then
      return
    end
    childBinder:CircularScrollTo(self.ui.ScrollView_Blame, 1)
    local itemTid = DT.GetConstant("MainCopyDetailPanelCurrencies")
    local clickCallback = PlayerDataUtils.ShowEnergyRestorePanel
    if not self.withoutOpenItem and self:_IsUnlockItemVisible() then
      clickCallback = nil
      local tid = self.model:GetUnlockItemTid(self.model.stageTid)
      if tid and 0 ~= tid then
        itemTid = tid
      end
    end
    childBinder:BindComponent(CoinInfoComponent(self.ui.Coin_1, itemTid, clickCallback))
  end, function()
    return self.model.stageTid
  end)
  self.binder:BindToVisible(self.ui.Coin_1, System.fn(self, self._IsItemCostVisible))
  self.binder:BindToImage(self.ui.Image_Icon, function()
    if not self.withoutOpenItem and self:_IsUnlockItemVisible() then
      do return self.model.GetUnlockItemIcon, self.model end
      return self.model.GetUnlockItemIcon, self.model, self.model.stageTid
    end
    local energyTid = CommonDefine.CurrencyType.Energy
    do return ItemDataUtils.GetIcon end
    return ItemDataUtils.GetIcon, energyTid
  end)
end

function MainCopyStageDetailPanel:BindMonsterTip()
  self:_UnbindMonsterItem()
  self.monsterTipItem = self.binder:BindComponent(MainCopyMonsterDetailItem(self.ui.UI_Chapter_Popup_Blame_Tip, self.stageTid, self.model.currMonsterTid))
end

function MainCopyStageDetailPanel:BindAchievementRedDotComp()
end

function MainCopyStageDetailPanel:_UnbindMonsterItem()
  if self.monsterTipItem then
    self.monsterTipItem:OnUnbind()
    self.monsterTipItem = nil
  end
end

function MainCopyStageDetailPanel:_OnMonsterChosen(_, currMonsterTid)
  if self.monsterTipItem then
    self.monsterTipItem:SetMonsterTid(currMonsterTid)
  end
end

function MainCopyStageDetailPanel:_SetStageNumber()
  local stageTid = self.model.stageTid
  do return self.model.GetStageNumber, self.model end
  return self.model.GetStageNumber, self.model, stageTid
end

function MainCopyStageDetailPanel:_SetStageName()
  local stageTid = self.model.stageTid
  do return self.model.GetStageName, self.model end
  return self.model.GetStageName, self.model, stageTid
end

function MainCopyStageDetailPanel:_SetStageDesc()
  local stageTid = self.model.stageTid
  do return self.model.GetStageDesc, self.model end
  return self.model.GetStageDesc, self.model, stageTid
end

function MainCopyStageDetailPanel:_SetRecommandLevel()
  local stageTid = self.model.stageTid
  do return self.model.GetRecommandLevel, self.model end
  return self.model.GetRecommandLevel, self.model, stageTid
end

function MainCopyStageDetailPanel:_SetAchieveCount()
  if not self.model.currStageIndex then
    return
  end
  local stageData = self.model.stageList[self.model.currStageIndex]
  if not stageData then
    return
  end
  local achieveCount = self.model:GetAchieveCount(stageData)
  local maxCount = self.model:GetMaxAchieveCount(stageData.stageID)
  do return LT.Textf, "StageAchievementButton", achieveCount end
  return LT.Textf, "StageAchievementButton", achieveCount, maxCount
end

function MainCopyStageDetailPanel:_SetTreasureCount()
  if not self.model.currStageIndex then
    return
  end
  local hideNodeList = self.model:GetHideNodeList(self.model.stageTid)
  local cfgNodeCount = #hideNodeList
  local stageData = self.model.stageList[self.model.currStageIndex]
  local currNum = stageData and 1 == stageData.hiddenAward and 1 or 0
  do return LT.Textf, "StageHideRewardsButton", currNum end
  return LT.Textf, "StageHideRewardsButton", currNum, cfgNodeCount
end

function MainCopyStageDetailPanel:_SetCost()
  if self.hasSubplotActivity then
    return 0
  end
  do return self._SetCfgCost end
  return self._SetCfgCost, self
end

function MainCopyStageDetailPanel:_SetCfgCost()
  if not self.withoutOpenItem and self:_IsUnlockItemVisible() then
    do return self.model.GetUnlockItemCost, self.model end
    return self.model.GetUnlockItemCost, self.model, self.model.stageTid
  end
  if not self.model:HasEnergyCost(self.model.stageTid) then
    return 0
  end
  local config = self.model:GetStageCfg(self.model.stageTid)
  return config.Cost
end

function MainCopyStageDetailPanel:_SetStageBg()
  local stageTid = self.model.stageTid
  do return self.model.GetStageBgImage, self.model end
  return self.model.GetStageBgImage, self.model, stageTid
end

function MainCopyStageDetailPanel:_SetCostIcon()
  if not self.withoutOpenItem and self:_IsUnlockItemVisible() then
    do return self.model.GetUnlockItemIcon, self.model end
    return self.model.GetUnlockItemIcon, self.model, self.model.stageTid
  end
  local energyTid = CommonDefine.CurrencyType.Energy
  do return ItemDataUtils.GetIcon end
  return ItemDataUtils.GetIcon, energyTid
end

function MainCopyStageDetailPanel:BindStarsVisible()
  local binder = self.binder
  for i = 1, 3 do
    local starObj = self.ui["Star_" .. i]
    if starObj then
      binder:BindToVisible(starObj, function()
        local star = self.model.currStar or 0
        return star >= i
      end)
    end
  end
end

function MainCopyStageDetailPanel:_GetRecommandSchools()
  local stageTid = self.model.stageTid
  self.recommandSchoolTids = self.model:GetRecommandSchoolTids(stageTid) or {}
  return self.recommandSchoolTids
end

function MainCopyStageDetailPanel:_UpdateSchoolIcon(itemBinder, go, index)
  local schoolTid = self.recommandSchoolTids[index]
  
  local function _SetSchoolIcon()
    do return self.model.GetSchoolIcon, self.model end
    return self.model.GetSchoolIcon, self.model, schoolTid
  end
  
  local Image_Icon = go:GetComponent(typeof(Image))
  itemBinder:BindToImage(Image_Icon, _SetSchoolIcon)
end

function MainCopyStageDetailPanel:_GetMonsterList()
  local stageTid = self.model.stageTid
  self.monsterTids = self.model:GetSortedMonsterTids(stageTid)
  return self.monsterTids
end

function MainCopyStageDetailPanel:_UpdateMonsterIcon(itemBinder, go, index)
  local stageTid = self.model.stageTid
  local monsterTid = self.monsterTids[index]
  
  local function OnMonsterItemClick()
    self.model:SetMonsterTid(monsterTid)
  end
  
  local function IsSelectFunc()
    return monsterTid == self.model.currMonsterTid
  end
  
  local monsterItem = itemBinder:BindUIBehavior(go, stageTid, monsterTid, OnMonsterItemClick)
  itemBinder:BindToVisible(monsterItem.ui.Image_Select, IsSelectFunc)
end

function MainCopyStageDetailPanel:_GetRewardList()
  local stageTid = self.model.stageTid
  local star = self.model.currStar
  if not self.model:IsHaveMap(stageTid) or self.isStoryReviewMode then
    self.showRewardList = {}
  else
    self.showRewardList = self.model:GetStageRewardList(stageTid, star)
  end
  return self.showRewardList
end

function MainCopyStageDetailPanel:_GetStoryRewardList()
  local stageTid = self.model.stageTid
  local star = self.model.currStar
  if self.model:IsHaveMap(stageTid) or self.isStoryReviewMode then
    self.showStoryRewardList = {}
  else
    self.showStoryRewardList = self.model:GetStageRewardList(stageTid, star)
  end
  return self.showStoryRewardList
end

function MainCopyStageDetailPanel:_UpdateRewardItem(itemBinder, go, index)
  local reward = self.showRewardList[index]
  local itemAwardTypeDescMap = CommonDefine.ItemAwardType2TagMap()
  local hasTag = reward.type and reward.type ~= CommonDefine.ItemAwardType.Normal
  local itemData = {
    itemTid = reward.tid,
    itemCount = reward.num,
    isGot = reward.isGot,
    extraDesc = hasTag and itemAwardTypeDescMap[reward.type] or nil,
    extraDescBgType = hasTag and CommonDefine.CommonIconExtraDescBgType.Blue or nil
  }
  itemBinder:BindComponent(CommonIconItemType2(go, itemData))
end

function MainCopyStageDetailPanel:_UpdateStoryRewardItem(itemBinder, go, index)
  local reward = self.showStoryRewardList[index]
  local itemAwardTypeDescMap = CommonDefine.ItemAwardType2TagMap()
  local hasTag = reward.type and reward.type ~= CommonDefine.ItemAwardType.Normal
  local itemData = {
    itemTid = reward.tid,
    itemCount = reward.num,
    isGot = reward.isGot,
    extraDesc = hasTag and itemAwardTypeDescMap[reward.type] or nil,
    extraDescBgType = hasTag and CommonDefine.CommonIconExtraDescBgType.Blue or nil
  }
  itemBinder:BindComponent(CommonIconItemType2(go, itemData))
end

function MainCopyStageDetailPanel:_IsBtnRelicVisible()
  if self:_IsStoryStage() then
    return false
  end
  return true
end

function MainCopyStageDetailPanel:_IsBtnAchieveVisible()
  return false
end

function MainCopyStageDetailPanel:_IsBtnTreasureVisible()
  if not self.model.currStageIndex then
    return
  end
  local stageTid = self.model.stageTid
  if self:_IsStoryStage() then
    return false
  end
  local stageData = self.model.stageList[self.model.currStageIndex]
  local currNum = stageData and 1 == stageData.hiddenAward and 1 or 0
  if 0 == currNum then
    return false
  end
  do return self.model.HasHideNode, self.model end
  return self.model.HasHideNode, self.model, stageTid
end

function MainCopyStageDetailPanel:_IsMonsterVisible()
  local stageTid = self.model.stageTid
  if not self.isStoryReviewMode and self.model:IsHaveMap(stageTid) then
    do return self.model.HasMonster, self.model end
    return self.model.HasMonster, self.model, stageTid
  end
  return false
end

function MainCopyStageDetailPanel:_IsNormalStage()
  local stageTid = self.model.stageTid
  return not self.isStoryReviewMode and self.model:IsHaveMap(stageTid)
end

function MainCopyStageDetailPanel:_IsShowGroupStar()
  local config = DT.Stage[self.stageTid]
  return config.PerfectCondition ~= nil and self:_IsNormalStage()
end

function MainCopyStageDetailPanel:_IsShowIntroduce()
  local config = DT.Stage[self.stageTid]
  return config.StageDifficulty ~= nil
end

function MainCopyStageDetailPanel:_IsRecommandSchoolVisible()
  local stageTid = self.model.stageTid
  do return self.model.HasRecommandSchool, self.model end
  return self.model.HasRecommandSchool, self.model, stageTid
end

function MainCopyStageDetailPanel:_IsRecommandLevelVisible()
  local stageTid = self.model.stageTid
  do return self.model.HasRecommandLevel, self.model end
  return self.model.HasRecommandLevel, self.model, stageTid
end

function MainCopyStageDetailPanel:_IsRecommandVisible()
  local stageTid = self.model.stageTid
  local showRecommandLevel = self.model:HasRecommandLevel(stageTid)
  local showRecommandSchool = self.model:HasRecommandSchool(stageTid)
  return showRecommandLevel or showRecommandSchool
end

function MainCopyStageDetailPanel:_IsItemCostVisible()
  return self.model:HasEnergyCost(self.model.stageTid) or self:_IsUnlockItemVisible()
end

function MainCopyStageDetailPanel:_HasSubplotActivity()
  return self.hasSubplotActivity
end

function MainCopyStageDetailPanel:_IsUnlockItemVisible()
  if self.withoutOpenItem then
    return false
  end
  return not self.model:HasUseUnlockItem(self.model.stageTid)
end

function MainCopyStageDetailPanel:_IsInitialStateTipsVisible()
  if self:_IsStoryStage() then
    return false
  end
  return StageInitialStateModel.Instance:ExistsInitialState(self.model.stageTid) and not StageInitialStateModel.Instance:IsHideStageInitState(self.model.stageTid)
end

function MainCopyStageDetailPanel:_IsMonsterTipVisible()
  return self.model.currMonsterTid ~= nil
end

function MainCopyStageDetailPanel:_IsStageLocked(stageIndex)
  if not (stageIndex and self.model.stageList) or #self.model.stageList <= 0 then
    return false
  end
  local stageData = self.model.stageList[stageIndex]
  return stageData and not stageData.unlocked
end

function MainCopyStageDetailPanel:_IsPrevStageLocked()
  if not self.model.currStageIndex then
    return
  end
  do return self._IsStageLocked, self end
  return self._IsStageLocked, self, self.model.currStageIndex - 1
end

function MainCopyStageDetailPanel:_IsNextStageLocked()
  if not self.model.currStageIndex then
    return
  end
  do return self._IsStageLocked, self end
  return self._IsStageLocked, self, self.model.currStageIndex + 1
end

function MainCopyStageDetailPanel:_IsStoryStage()
  local stageTid = self.model.stageTid
  return not self.model:IsHaveMap(stageTid) or self.isStoryReviewMode
end

function MainCopyStageDetailPanel:_HasNextStage()
  if not self.model.currStageIndex then
    return
  end
  local hasNextStage = self:_IsStageIndexValid(self.model.currStageIndex + 1)
  return hasNextStage
end

function MainCopyStageDetailPanel:_HasPrevStage()
  if not self.model.currStageIndex then
    return
  end
  local hasPrevStage = self:_IsStageIndexValid(self.model.currStageIndex - 1)
  return hasPrevStage
end

function MainCopyStageDetailPanel:_OnClickRelicGroup()
  UIManager.Instance:Reopen(Urls.MainCopyRelicGroupPanel, self.model.stageTid)
end

function MainCopyStageDetailPanel:_OnClickTreasure()
  Alert.ShowToolTips(40007, self.ui.Btn_Reward)
end

function MainCopyStageDetailPanel:_OnClickAchieve()
  local stageTid = self.model.stageTid
  local hasAchievement = self.model:HasAchievement(stageTid)
  if not hasAchievement then
    return
  end
  local cfg = self.model:GetStageCfg(stageTid)
  UIManager.Instance:Reopen(Urls.MainCopyAchievePanel, cfg.LevelAchieve, stageTid)
end

function MainCopyStageDetailPanel:_OnClickStar()
  UIManager.Instance:Reopen(Urls.MainCopyStarPanel, self.model.stageTid)
end

function MainCopyStageDetailPanel:_OnClickPrev()
  local currStageIndex = self.model.currStageIndex or 0
  if not self:_IsStageIndexValid(currStageIndex - 1) then
    return
  end
  local stageData = self.model.stageList[currStageIndex - 1]
  if not stageData then
    return
  end
  self.model:SetStageTid(stageData.stageID)
  if self.monsterTipItem then
    self.monsterTipItem:SetStageTid(stageData.stageID)
  end
  self:_SetStageStar(stageData)
  self.binder:CircularScrollTo(self.ui.ScrollView_Article, 1)
  self:_CheckRemoveNew()
  self.uiAnimController:PlayState("UI_Chaper_Popup_Particulars_New_Change")
end

function MainCopyStageDetailPanel:_OnClickNext()
  local currStageIndex = self.model.currStageIndex or 0
  if self:_IsStageLocked(currStageIndex + 1) then
    Alert.Show(10578)
    return
  end
  local stageData = self.model.stageList[currStageIndex + 1]
  if not stageData then
    return
  end
  self.model:SetStageTid(stageData.stageID)
  if self.monsterTipItem then
    self.monsterTipItem:SetStageTid(stageData.stageID)
  end
  self:_SetStageStar(stageData)
  self.binder:CircularScrollTo(self.ui.ScrollView_Article, 1)
  self:_CheckRemoveNew()
  self.uiAnimController:PlayState("UI_Chaper_Popup_Particulars_New_Change")
end

function MainCopyStageDetailPanel:_OnClickInitStateClick()
  UIManager.Instance:Reopen(Urls.StageInitialStateDetailView, self.model.stageTid)
  AvgTutorialManager.Instance:PlayTutorialAvgByKeyWord(DT.GetConstant("AbyssChallengeTutorialAvg"), CommonDefine.AVGTutorialKeyWord.AbyssChallengeRule)
end

function MainCopyStageDetailPanel:_CheckRemoveNew()
  local stageTid = self.model.stageTid
  local result = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.NewStageUnlock, {stageTid})
  if result then
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.NewStageUnlock, RedPointDataUtils.RedAttrType.IsNew, stageTid)
  end
end

function MainCopyStageDetailPanel:_SetStageStar(stageData)
  local star = stageData and stageData.star or 0
  self.model:SetCurrStar(star)
end

function MainCopyStageDetailPanel:_OnClickMask()
  self.model:ResetMonsterTid()
end

function MainCopyStageDetailPanel:_GetChallengeBtnText()
  do return LT.Text end
  return LT.Text, self.model:IsHaveMap(self.model.stageTid) and "MainLinesChallenge" or "MainLinesInvestigation", self.model, self.model.stageTid
end

function MainCopyStageDetailPanel:_GetUnlockBtnText()
  do return LT.Text end
  return LT.Text, "UniversalUnlockButton"
end

function MainCopyStageDetailPanel:_GetCancelBtnText()
  do return LT.Text end
  return LT.Text, "UniversalCancelButton"
end

function MainCopyStageDetailPanel:_GetChallengeBtnState()
  if self.model:CanChallenge(self.model.stageTid) then
    return CommonDefine.BtnType.High
  end
  return CommonDefine.BtnType.Unclickable
end

function MainCopyStageDetailPanel:_GetUnlockBtnState()
  if self.hasSubplotActivity then
    return CommonDefine.BtnType.High
  end
  if self.model:CanUnlockStage(self.model.stageTid) then
    return CommonDefine.BtnType.High
  end
  return CommonDefine.BtnType.Unclickable
end

function MainCopyStageDetailPanel:_GetTextPriceColorState()
  if self:_IsLackOfItem() then
    return CommonDefine.ColorType.Dark
  end
  return CommonDefine.ColorType.Normal
end

function MainCopyStageDetailPanel:_IsLackOfItem()
  if self.hasSubplotActivity then
    return false
  end
  if self.model:HasEnergyCost(self.model.stageTid) then
    return not self.model:IsEnergyEnough(self.model.stageTid)
  end
  if not self.withoutOpenItem and self:_IsUnlockItemVisible() then
    return not self.model:IsUnlockItemEnough(self.model.stageTid)
  end
  return true
end

function MainCopyStageDetailPanel:_OnClickChallenge()
  if StoryReviewModel.Instance:IsReviewingStory() then
    StoryReviewController.Instance:StartPlayStoryReview(self.model.stageTid)
    self:Close()
    return
  end
  if not self.model:CanChallenge(self.model.stageTid) then
    Alert.Show(10594)
    return
  end
  WorldStageManager.Instance:CheckOpen(self.model.stageTid, self.challengeCb)
end

function MainCopyStageDetailPanel:_OnClickUnlock()
  if self.hasSubplotActivity then
    Alert.Show(20103, nil, function()
      self.model:ReqUnlockStage(self.model.stageTid, true)
    end, nil, nil, nil, true)
    return
  end
  if not self:_IsUnlockItemVisible() then
    return
  end
  local itemName = self.model:GetUnlockItemName(self.model.stageTid)
  if not self.model:CanUnlockStage(self.model.stageTid) then
    local tipStr = DT.TipsType[10646].Desc
    tipStr = LT.Textf(tipStr, itemName)
    Alert.Show(10646, nil, nil, nil, tipStr)
    return
  end
  
  local function _OnConfirm()
    self.model:ReqUnlockStage(self.model.stageTid)
  end
  
  local itemNum = self.model:GetUnlockItemCost(self.model.stageTid)
  local stageName = self.model:GetStageName(self.model.stageTid)
  local costTipStr = LT.Textf(DT.TipsType[20087].Desc, itemName, itemNum, stageName)
  Alert.Show(20087, nil, _OnConfirm, nil, costTipStr)
end

function MainCopyStageDetailPanel:_IsStageIndexValid(stageIndex)
  if not (stageIndex and self.model.stageList) or #self.model.stageList <= 0 then
    return false
  end
  local stageData = self.model.stageList[stageIndex]
  if not stageData or table.next(stageData) == nil then
    return false
  end
  return stageData.unlocked and (stageData.openTime or 0) < TimeUtils.GetServerTime()
end

function MainCopyStageDetailPanel:BindHighDifficultyUI(binder)
  binder:BindToRaw(function(childBinder, nowStageTid)
    local stageCfg = DT.Stage[self.model.stageTid]
    local isHighDifficulty = false
    if stageCfg and stageCfg.StageHighDifficulty and 1 == stageCfg.StageHighDifficulty then
      isHighDifficulty = true
    end
    binder:SetActive(self.ui.Image_Chapter, not isHighDifficulty)
    binder:SetActive(self.ui.Image_Chapter_Dif, isHighDifficulty)
    binder:SetActive(self.ui.Image_Chapter_Rgb, isHighDifficulty)
  end, function()
    return self.model.stageTid
  end)
end

function MainCopyStageDetailPanel:AddEffectAudioPostCtrl()
  LuaComponentManager.Instance:AddLuaComponentOnce(self.ui.Image_Chapter_Dif)
end

function MainCopyStageDetailPanel:Close()
  self:_UnbindMonsterItem()
  Super.Close(self)
end

return MainCopyStageDetailPanel
