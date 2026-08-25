local Vector2 = CS.UnityEngine.Vector2
local MAX_STAR_NUM = 3
local DungeonWeekBossSubPanel, Super = System.NewClass("DungeonWeekBossSubPanel", UIBasePanel)
DungeonWeekBossSubPanel.uiResCls = UI_Dungeous_Panel_BossSel1Resource

function DungeonWeekBossSubPanel:ctor(stageGroupId, featureId, stageType, page, stageId)
  Super.ctor(self)
  self.stageGroupId = stageGroupId
  self.featureId = featureId
  self.starData = Vue.reactive({star = 0})
  self.stageType = stageType
  self.page = page
  self.stageId = stageId or 0
end

function DungeonWeekBossSubPanel:OnBind(binder)
  self.binder = binder
  local model = binder:createModel(CommonStageModel, self.stageGroupId, self.featureId)
  self.model = model
  if self.stageId and self.stageId > 0 and self.model and self.model.SetSelectedStageId then
    self.model:SetSelectedStageId(self.stageId)
  end
  EventMgr.Instance.StageUIEvent:Dispatch({secondUI = true})
  binder:BindEvent(EventMgr.Instance.StageUIEvent, System.fn(self, self.OnEvent))
  self:TitleBind()
  self:StageListBind()
  self:RelicItemBind()
  self:DetailContentBind()
  self:CoinComBind()
  self:CloseBtnBind()
  self:StarBind()
  self:SpecialSkillBtnBind()
  self:RefreshTimeBind()
  self:RewardNumBind()
  self:IntroductionBind()
  self:MonsterBtnBind()
  self:OnBindMultiDrop()
  self:OnBindInitState()
  self:OnBindReplayBtn()
  self:ListViewAnimPlay()
end

function DungeonWeekBossSubPanel:TitleBind()
  self.binder:BindToText(self.ui.Text_Title, function()
    do return self.model.GetTitle end
    return self.model.GetTitle, self.model
  end)
end

function DungeonWeekBossSubPanel:StageListBind()
  local model = self.model
  local binder = self.binder
  binder:BindToCircularListView(self.ui.ScrollView_Difficulty, function()
    return self.model.stageDataList
  end, function(childBinder, item, index)
    local stateList = self.model.stageDataList
    local stageData = stateList[index]
    local stageId = stageData.stageID
    childBinder:BindComponent(CopyChapterVueComp(self.ui.UI_Common_Btn_StageChapter, stageId))
    local itemUI = UI_Dungeons_Item_Common_TierResource(item)
    childBinder:BindToVisible(itemUI.Group_Nor, function()
      return not model:ImageMaskVisible(index)
    end)
    childBinder:BindToText(itemUI.Text_Title, function()
      do return model.GetStageName, model end
      return model.GetStageName, model, stageId
    end)
    childBinder:BindButtonClick(itemUI.Btn_Click, function()
      model:SetSelectedIndex(index)
    end)
    childBinder:BindToVisible(itemUI.Image_Select, function()
      return stageId == model.selectedStageId
    end)
    childBinder:BindToVisible(itemUI.Image_Mask, function()
      do return model.ImageMaskVisible, model end
      return model.ImageMaskVisible, model, index
    end)
    childBinder:BindToText(itemUI.Text_Tip, function()
      do return model.ShowUnlockTips, model end
      return model.ShowUnlockTips, model, index
    end)
    childBinder:BindToTextColor(itemUI.Text_Tip, function()
      return model:ImageMaskVisible(index) and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
    end)
    childBinder:BindToTextColor(itemUI.Text_Title, function()
      return model:ImageMaskVisible(index) and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
    end)
    for i = 1, MAX_STAR_NUM do
      childBinder:BindToVisible(itemUI["Image_Star" .. i], function()
        return i <= stageData.star
      end)
    end
  end)
end

function DungeonWeekBossSubPanel:RelicItemBind()
  self.binder:BindToCircularListView(self.ui.ScrollView_Initial, function()
    do return CopyDataUtils.GetStageInitRelic end
    return CopyDataUtils.GetStageInitRelic, self.model.selectedStageId
  end, function(itemBinder, item, index)
    local relics = CopyDataUtils.GetStageInitRelic(self.model.selectedStageId)
    local itemData = relics[index]
    itemBinder:BindComponent(RelicIconComponent(item, itemData, nil, self.model.selectedStageId))
  end)
end

function DungeonWeekBossSubPanel:DetailContentBind()
  local model = self.model
  local binder = self.binder
  binder:BindToImage(self.ui.Image_D_Bg, function()
    return model.bgImage
  end)
  binder:BindToText(self.ui.Text_Empty_Creation, function()
    local list = CopyDataUtils.GetStageInitRelic(model.selectedStageId)
    if not list or #list <= 0 then
      do return model.GetInitCreationEmptyTips end
      return model.GetInitCreationEmptyTips, model
    end
    return ""
  end)
  binder:BindToRaw(function(childBinder, nVal, _)
    local isNeedBind = nil ~= nVal
    if not isNeedBind then
      return
    end
    childBinder:BindToText(self.ui.Text_Name, function()
      do return model.GetSelectedStageName end
      return model.GetSelectedStageName, model
    end)
    childBinder:BindToText(self.ui.Text_Introduce, function()
      do return model.GetSelectedStageDesc end
      return model.GetSelectedStageDesc, model
    end)
    childBinder:BindToText(self.ui.Text_Special_Desc, function()
      do return model.GetUniqDesignStr end
      return model.GetUniqDesignStr, model
    end)
    childBinder:BindToText(self.ui.Text_Coin_Count, function()
      do return model.GetSelectedCost end
      return model.GetSelectedCost, model
    end)
    childBinder:BindToVisible(self.ui.Text_Coin_Count, function()
      return 0 ~= model:GetSelectedCost()
    end)
    childBinder:BindToImage(self.ui.Image_Coin_Icon, function()
      do return model.GetCostIcon end
      return model.GetCostIcon, model
    end, false)
    childBinder:BindToVisible(self.ui.Image_Coin_Icon, function()
      return model:GetSelectedCost() > 0
    end, false)
    childBinder:BindToVisible(self.ui.Btn_Sweep, function()
      do return model.GetIsShowSweep end
      return model.GetIsShowSweep, model
    end)
    binder:BindZ1Button(self.ui.Btn_Challenge, function()
      if not model:CheckCanChallengeAndShowTips() then
        return
      end
      local cost = model:GetSelectedCost()
      if cost > PlayerDataUtils.GetEnergy() and self.model:GetRewardNumLeft() > 0 then
        PlayerDataUtils.ShowEnergyRestorePanel()
        return
      end
      
      local function confirmCall()
        WorldStageManager.Instance:Open(model.selectedStageId, function()
          StageExitPanelManager.Instance:PushWhenWeekBossExit(model.selectedStageId)
        end, model:GetTalents())
      end
      
      local leftCnt = self.model:GetRewardNumLeft()
      if leftCnt <= 0 then
        Alert.Show(10607, nil, confirmCall)
        return
      end
      confirmCall()
    end, function()
      do return model.GetChallengeBtnState end
      return model.GetChallengeBtnState, model
    end, function()
      do return LT.Text end
      return LT.Text, "DailyCopy_Start"
    end, nil, nil, nil)
    childBinder:BindZ1Button(self.ui.Btn_Sweep, function()
      if not model:CheckCanChallengeAndShowTips() then
        return
      end
      if self.model:GetRewardNumLeft() <= 0 then
        Alert.Show("WeekChallengeSweepTips")
        return
      end
      local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(model:GetType())
      if not showLevelLimit and model:GetIsLocked(model.selectedStageId) then
        Alert.ShowStr(model:GetStageUnlockTipsByStageId(model.selectedStageId))
        return
      end
      CopyDataUtils.OpenSweepPanel(model.selectedStageId, nil, self.model:GetRewardNumLeft())
    end, function()
      local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(model:GetType())
      if showLevelLimit then
        if not model:LevelReach(model.selectedStageId) then
          return CommonDefine.BtnType.Unclickable
        end
      elseif model:GetIsLocked(model.selectedStageId) then
        return CommonDefine.BtnType.Unclickable
      end
      if self.model:GetIsPassed(model.selectedStageId) or self.model:GetCurStar() > 0 then
        if self.model:GetRewardNumLeft() <= 0 then
          return CommonDefine.BtnType.Unclickable
        end
        return CommonDefine.BtnType.High
      end
      return CommonDefine.BtnType.Unclickable
    end, function()
      do return LT.Text end
      return LT.Text, "CopySweepBtnText"
    end, nil, nil, nil)
    childBinder:BindToCircularListView(self.ui.ScrollView_Article, function()
      return model.selectedRewards
    end, function(itemBinder, item, index)
      local itemInfo = model.selectedRewards[index]
      local itemCount
      local itemCfg = DT.Item[itemInfo.tid]
      if itemCfg.Type == "DropItem" then
        itemCount = ""
      else
        itemCount = itemInfo.num
      end
      local itemAwardTypeDescMap = CommonDefine.ItemAwardType2TagMap()
      local hasTag = itemInfo.type and itemInfo.type ~= CommonDefine.ItemAwardType.Normal
      local itemData = {
        itemTid = itemInfo.tid,
        itemCount = itemCount,
        isGot = itemInfo.isGot == true,
        extraDesc = hasTag and itemAwardTypeDescMap[itemInfo.type] or nil,
        extraDescBgType = hasTag and CommonDefine.CommonIconExtraDescBgType.Blue or nil
      }
      itemBinder:BindComponent(CommonIconItemType2(item, itemData))
    end)
    self:OnBindRecommendSchool(childBinder)
    if StageModel.Instance:IsStageCanSweepBySweepType(model.selectedStageId) then
      self.ui.Btn_Sweep.transform:SetAsLastSibling()
    else
      self.ui.Btn_Challenge.transform:SetAsLastSibling()
    end
  end, function()
    return model.selectedStageId
  end)
end

function DungeonWeekBossSubPanel:CoinComBind()
  local coinList = {}
  local type = self.model:GetType()
  if type == CommonDefine.StageGroupType.TrinketCopy then
    coinList = DT.Constant.TrinketCopyPanelCurrencies.Data
  elseif type == CommonDefine.StageGroupType.MaterialCopy then
    coinList = DT.Constant.DailyMaterialPanelCurrencies.Data
  end
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Icon, coinList))
end

function DungeonWeekBossSubPanel:CloseBtnBind()
  self.closeBtn = self.binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back2, function()
    self:Close()
  end))
end

function DungeonWeekBossSubPanel:StarBind()
  self.binder:BindComponent(StageStarComponent(self.ui.Group_Star, self.starData))
  self.binder:BindToRaw(function(_, new)
    self.starData.stageTid = new
    self.starData.star = self.model:GetCurStar()
  end, function()
    return self.model.selectedStageId
  end)
end

function DungeonWeekBossSubPanel:SpecialSkillBtnBind()
  self.binder:BindToRaw(function(cb, selectStageGroupId, _)
    if not selectStageGroupId then
      return
    end
    cb:BindComponent(AwakerSpecialSkillAdditionItem(self.ui.UI_Awaker_Button_Addition, CommonDefine.AwakerSpecialSkillType.StageDropAdd, selectStageGroupId))
  end, function()
    return self.model.stageGroupId
  end)
end

function DungeonWeekBossSubPanel:OnBindMultiDrop()
  local binder = self.binder
  binder:BindToText(self.ui.Text_NowNum, function()
    return ""
  end)
  binder:BindToText(self.ui.Text_Sum, function()
    return ""
  end)
  binder:BindToVisible(self.ui.Group_Award, function()
    return false
  end)
  binder:BindToVisible(self.ui.Text_Additional, System.fn(self, self._IsMultiDropActivityOpen))
  binder:BindToText(self.ui.Text_Additional, function()
    do return ActivityDataUtils.GetDoubleOutputProgressShowText end
    return ActivityDataUtils.GetDoubleOutputProgressShowText, self.model.stageGroupId
  end)
end

function DungeonWeekBossSubPanel:OnBindInitState()
  self.binder:BindToVisible(self.ui.UI_Common_Melt_Disaster, System.fn(self, self._IsInitialStateTipsVisible))
  self.binder:BindComponent(StageInitialStateBtnItem(self.ui.UI_Common_Melt_Disaster, function()
    return self.model.selectedStageId
  end, System.fn(self, self._OnClickInitStateClick)))
  self.binder:BindToRaw(function(_, isIsShowSweep)
    local pos = Vector2(322.7, -451.9)
    if isIsShowSweep then
      pos = Vector2(666, -382)
    end
    self.ui.UI_Common_Melt_Disaster.transform.anchoredPosition = pos
  end, function()
    do return self.model.GetIsShowSweep end
    return self.model.GetIsShowSweep, self.model
  end)
end

function DungeonWeekBossSubPanel:OnBindReplayBtn()
  self.binder:SetActive(self.ui.Btn_Replay, true)
  self.binder:SetText(self.ui.Text_C_Replay, LT.PanelText("UI_Event_Panel_Challenge_Text_C_Replay"))
  self.binder:BindButtonClick(self.ui.Btn_Replay, function()
    CopyRecordsController.Instance:OpenCopyRecordsView(self.model.selectedStageId)
  end)
end

function DungeonWeekBossSubPanel:_IsInitialStateTipsVisible()
  return StageInitialStateModel.Instance:ExistsInitialState(self.model.selectedStageId) and not StageInitialStateModel.Instance:IsHideStageInitState(self.model.selectedStageId)
end

function DungeonWeekBossSubPanel:_OnClickInitStateClick()
  UIManager.Instance:Reopen(Urls.StageInitialStateDetailView, self.model.selectedStageId)
end

function DungeonWeekBossSubPanel:_IsMultiDropActivityOpen()
  do return ActivityManager.Instance.CheckDoubleOutputEffect, ActivityManager.Instance end
  return ActivityManager.Instance.CheckDoubleOutputEffect, ActivityManager.Instance, self.model.stageGroupId
end

function DungeonWeekBossSubPanel:_OnMultiDropTipsClick()
  if not self:_IsMultiDropActivityOpen() then
    return
  end
  local activityData = ActivityManager.Instance:GetMultiDropActivity()
  FuncJumpManager.Instance:JumpToActivityMainPanel(activityData.activityTid)
end

function DungeonWeekBossSubPanel:OnBindRecommendSchool(binder)
  binder:BindToRaw(function(childBinder, recClass, _)
    self.ui.Group_Recommend:SetActive(nil ~= recClass)
    for i = 1, 4 do
      local schoolId = recClass and recClass[i]
      local icon = self.ui["Icon_Recommend_" .. i]
      icon:SetActive(nil ~= schoolId)
      local cfg = DT.SchoolConfig[schoolId]
      if cfg then
        if cfg.Icon then
          binder:SetImage(icon, cfg.Icon)
        end
        binder:SetText(self.ui["Text_School_" .. i], cfg.Name)
      end
      childBinder:BindButtonClick(icon, System.fn(self, self.OnClickRecommendSchool))
    end
  end, function()
    local stageCfg = DT.Stage[self.model.selectedStageId]
    return stageCfg.RecClass
  end)
end

function DungeonWeekBossSubPanel:OnClickRecommendSchool()
  local title = LT.Text("RecClass_Description_Title")
  local content = LT.Text("RecClass_Description_Detail")
  UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
end

function DungeonWeekBossSubPanel:OnUnbind()
  Super.OnUnbind(self)
end

function DungeonWeekBossSubPanel:Close()
  self.closeBtn:PlayCloseAnim()
  EventMgr.Instance.StageUIEvent:Dispatch({secondUI = false})
  Super.Close(self)
end

function DungeonWeekBossSubPanel:OnEvent(data)
  if data.secondUI == false then
    Super.Close(self)
  end
end

function DungeonWeekBossSubPanel:RefreshTimeBind()
  self.binder:BindToText(self.ui.Text_CountDown, function()
    do return self.model.GetWeekBossRefreshTimeDesc end
    return self.model.GetWeekBossRefreshTimeDesc, self.model
  end)
end

function DungeonWeekBossSubPanel:RewardNumBind()
  self.binder:BindToText(self.ui.Text_AwardNum2, function()
    do return self.model.GetRewardNumLeft end
    return self.model.GetRewardNumLeft, self.model
  end)
  self.binder:BindToTextColor(self.ui.Text_AwardNum2, function()
    local cnt = self.model:GetRewardNumLeft()
    return cnt > 0 and CommonDefine.ColorType.Normal or CommonDefine.ColorType.Dark
  end)
  self.binder:SetText(self.ui.Text_AwardNum, DT.GetConstant("WeeklyBossStageRewardCount"))
end

function DungeonWeekBossSubPanel:IntroductionBind()
  self.binder:BindZ1Button(self.ui.Button_Info, function()
    self.model:GotoIntroduction()
  end)
end

function DungeonWeekBossSubPanel:MonsterBtnBind()
end

function DungeonWeekBossSubPanel:_IsBtnRelicVisible()
  local stageTid = self.model.selectedStageId
  if nil ~= stageTid then
    do return self.model.IsHaveMap, self.model end
    return self.model.IsHaveMap, self.model, stageTid
  else
    return false
  end
end

function DungeonWeekBossSubPanel:_OnClickRelicGroup()
  UIManager.Instance:Reopen(Urls.MainCopyRelicGroupPanel, self.model.selectedStageId)
end

function DungeonWeekBossSubPanel:ListViewAnimPlay()
  self.binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Difficulty)
end

return DungeonWeekBossSubPanel
