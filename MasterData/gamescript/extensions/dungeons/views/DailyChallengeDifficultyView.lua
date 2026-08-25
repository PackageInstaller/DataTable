local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local DailyChallengeDifficultyView, Super = NewClass("DailyChallengeDifficultyView", BaseView)
DailyChallengeDifficultyView.uiResCls = UI_Dungeous_Panel_Difficulty_OptimizedResource

function DailyChallengeDifficultyView:ctor()
  Super.ctor(self)
  self.curSelectIndex = DailyChallengeModel.Instance:Get_selectedLevelIdx()
end

function DailyChallengeDifficultyView:OnBuildView()
  Super.OnBuildView(self)
end

function DailyChallengeDifficultyView:RequestGainPrize(index, _, callback)
  DailyChallengeController.Instance:RequestGainAchievePrize(index, callback)
end

function DailyChallengeDifficultyView:UpdateSelectIndex(idx)
  self.curSelectIndex = idx
  self.monsterIDs = DailyChallengeController.Instance:GetSelectedLevelMonsterIDs()
  self.stageTid = DailyChallengeController.Instance:GetSelectedLevelID(self.curSelectIndex)
  self.levelInfos = DailyChallengeController.Instance:BoxLevelInfoItemData(self.curSelectIndex)
  self:UpdateScrollView_Rewards()
end

function DailyChallengeDifficultyView:RefreshAllScroll()
  self:UpdateScrollView_Rewards()
  self:UpdateScrollView_StrongAwaker()
  self:UpdateScrollView_MonsterDetails()
  self:UpdateScrollView_Initial()
  self:UpdateScrollView_Difficulty()
end

function DailyChallengeDifficultyView:UpdateScrollView_Rewards()
  local awardBonus = DailyChallengeDataUtils.GetStageAwardBonus(self.stageTid)
  if awardBonus <= 0 then
    self:SetActive(self.ui.Group_Award, false)
    return
  end
  self:SetActive(self.ui.Group_Award, true)
  self:SetActive(self.ui.Btn_AwardDesc, awardBonus > DailyChallengeDataUtils.GetDailyChallengeExpReward(self.stageTid))
  if self.ScrollView_Rewards_View == nil then
    local rewards
    local cellRT = self.ui.UI_Common_Item_WuPin_Type2:GetComponent(TYPEOF_RectTransform)
    local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
    self.ScrollView_Rewards_View = self:CreateTableview(self.ui.ScrollView_Rewards, function()
      rewards = DailyChallengeController.Instance:GetSelectedLevelPassRewards(self.curSelectIndex)
      return #rewards
    end, function(view, index)
      local cellAwardBonus = DailyChallengeDataUtils.GetStageAwardBonus(self.stageTid)
      local havePass = DailyChallengeController.Instance:GetLevelPassIndex() >= self.curSelectIndex
      local cell = view:DequeueCell()
      cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type2)
      local reward = rewards[index]
      if reward.tid == DT.GetConstant("DailyChallengeExperienceRewardItem") then
        reward.count = cellAwardBonus
      end
      local itemAwardTypeDescMap = CommonDefine.ItemAwardType2TagMap()
      local isFirst = reward.itemAwardType and reward.itemAwardType ~= CommonDefine.ItemAwardType.Normal
      local itemData = {
        itemTid = reward.tid,
        itemCount = reward.count,
        extraDesc = isFirst and itemAwardTypeDescMap[reward.itemAwardType] or nil,
        extraDescBgType = isFirst and CommonDefine.CommonIconExtraDescBgType.Blue or nil,
        isShowDarkMask = havePass and reward.itemAwardType == CommonDefine.ItemAwardType.First,
        clickFunc = function()
          ItemDataUtils.ShowItemDetailTips(self.binder, cell.gameObject, nil, reward.tid)
        end
      }
      self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, itemData)
      return cell
    end, function()
      return width, height
    end)
    self.ScrollView_Rewards_View:ReloadData()
  else
    self.ScrollView_Rewards_View:ReloadData()
  end
end

function DailyChallengeDifficultyView:UpdateScrollView_StrongAwaker()
  if self.strongAwakers_TableView == nil then
    local cellRT = self.ui.UI_Common_Awaker_WuPin_Type2:GetComponent(TYPEOF_RectTransform)
    local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
    self.strongAwakers_TableView = self:CreateTableview(self.ui.ScrollView_StrongAwakers, function()
      return #self._strongAwakersTidList or 0
    end, function(view, index)
      local cell = view:DequeueCell()
      cell = cell or view:AddChild(self.ui.UI_Common_Awaker_WuPin_Type2)
      local awakerTid = self._strongAwakersTidList[index]
      
      local function clickFunc()
        local item = self.binder:BindNewComponent(CS.UnityEngine.GameObject.Find("UIRoot/SafeArea/TipPopRoot"), UIComStrongAwakerDesc, UI_Common_Popup_Tips_AwakerResource, nil, awakerTid)
        local tipsPos = CS.UnityEngine.Vector3(174, -120, 0)
        local worldPos = self.ui.uiNode.transform:TransformPoint(tipsPos)
        item:SetItemPos2(worldPos)
      end
      
      local awakerItemData = {
        awakerId = awakerTid,
        curSkin = cd.DefaultSkinTid,
        clickFunc = clickFunc,
        isHideQuality = true,
        icon = AwakerDataUtils.GetLittleIcon(awakerTid, true, CommonDefine.DefaultSkinTid)
      }
      self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, awakerItemData)
      return cell
    end, function()
      return width, height
    end)
    self.strongAwakers_TableView:ReloadData()
  else
    self.strongAwakers_TableView:ReloadData()
  end
end

function DailyChallengeDifficultyView:UpdateScrollView_MonsterDetails()
  local bossId = self.monsterIDs[1]
  if not bossId then
    self:SetActive(self.ui.UI_Chapter_Item_Monster, false)
  else
    self:SetActive(self.ui.UI_Chapter_Item_Monster, true)
    local bossUI = UI_Chapter_Item_MonsterResource(self.ui.UI_Chapter_Item_Monster.gameObject)
    self:SetImage(bossUI.Image_Monster, DT.GetConstant("DailyChallengeRandomMonsterIcon"))
    local monsterLevel = CopyDataUtils.GetMonsterLevel(self.stageTid, bossId)
    self:SetText(bossUI.Text_Level, "Lv." .. monsterLevel)
    local monsterTypeName = CopyDataUtils.GetMonsterTypeName(bossId)
    bossUI.Image_Boss:SetActive(monsterTypeName)
    self:SetText(bossUI.Text_TypeName, monsterTypeName or "")
  end
end

function DailyChallengeDifficultyView:UpdateScrollView_Initial()
  if self.ScrollView_Initial_View == nil then
    local relicInfos = {}
    local weekRelicInfo = DailyChallengeController.Instance:GetWeekRelicInfo()
    local dayRelicInfo = DailyChallengeController.Instance:GetDayRelicInfo()
    if weekRelicInfo and weekRelicInfo.id and 0 ~= weekRelicInfo.id then
      table.insert(relicInfos, weekRelicInfo)
    end
    if dayRelicInfo and dayRelicInfo.id and 0 ~= dayRelicInfo.id then
      table.insert(relicInfos, dayRelicInfo)
    end
    local cellRT = self.ui.UI_Dungeons_Item_Award_Creation:GetComponent(TYPEOF_RectTransform)
    local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
    self.ScrollView_Initial_View = self:CreateTableview(self.ui.ScrollView_Initial, function()
      return #relicInfos
    end, function(view, index)
      local cell = view:DequeueCell()
      cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_Award_Creation)
      local info = relicInfos[index]
      self:AddViewComponentOnce(cell.gameObject, UIComRelicIconComponentWithSuperscript, info.id, info.superscript, self.curSelectIndex)
      return cell
    end, function()
      return width, height
    end)
    self.ScrollView_Initial_View:ReloadData()
  else
    self.ScrollView_Initial_View:Refresh()
  end
end

function DailyChallengeDifficultyView:UpdateScrollView_Difficulty()
  if self.ScrollView_Difficulty_View == nil then
    local selectCB = System.fn(self, self.RefreshView)
    local cellRT = self.ui.UI_Dungeons_Item_Common_Element:GetComponent(TYPEOF_RectTransform)
    local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
    self.ScrollView_Difficulty_View = self:CreateTableview(self.ui.ScrollView_Difficulty, function()
      return #self.levelInfos
    end, function(view, index)
      local cell = view:DequeueCell()
      cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_Common_Element)
      local info = self.levelInfos[index]
      self:AddViewComponentOnce(cell.gameObject, UIComDailyChallengeDifficultyItem, index, info, selectCB)
      return cell
    end, function()
      return width, height
    end)
    self.ScrollView_Difficulty_View:ReloadData()
  else
    self.ScrollView_Difficulty_View:Refresh()
  end
end

function DailyChallengeDifficultyView:OnEnterView()
  Super.OnEnterView(self)
  if self.ui.UI_Common_Btn_Back2 ~= nil then
    self:AddViewComponentOnce(self.ui.UI_Common_Btn_Back2, UICompBtnCloseItem, function()
      self:Close()
    end)
  end
  self:RefreshView(self.curSelectIndex)
  self:UpdateScrollPos()
  self:AddViewComponentOnce(self.ui.UI_Common_Btn_StageChapter, CopyChapterMvcItem, self.stageTid)
  self:SetText(self.ui.Text_RewardShow, LT.Text("DailyChallengeAwardPreviewTitle"))
end

function DailyChallengeDifficultyView:RefreshView(idx)
  self:UpdateSelectIndex(idx)
  self:RefreshAllScroll()
  self._strongAwakersTidList = DailyChallengeDataUtils.GetStrongAwakers()
  self:SetText(self.ui.Text_Title, DailyChallengeController.Instance:GetStageGroupName())
  self:SetText(self.ui.Text_Positioning, DailyChallengeController.Instance:GetDayHighestScoreLevelName())
  self:SetText(self.ui.Text_Total, DailyChallengeController.Instance:GetWeekHighestScore())
  self:SetText(self.ui.Text_Name, DailyChallengeController.Instance:GetSelectedLevelName(self.curSelectIndex))
  self:SetText(self.ui.Text_Introduce, DailyChallengeController.Instance:GetSelectedLevelDesc(self.curSelectIndex))
  self:SetImage(self.ui.Image_D_Bg, DailyChallengeController.Instance:GetSelectedLevelBackground(self.curSelectIndex))
  local info = DailyChallengeController.Instance:GetRecommendedSchoolInfo()
  if info then
    self.ui.RootRecommendSchool:SetActive(true)
    self:SetText(self.ui.Text_Recommend_School, info.name)
    self:SetImage(self.ui.Icon_Recommend_School, info.icon)
  else
    self.ui.RootRecommendSchool:SetActive(false)
  end
  self:_OnDailyDiffChange()
  self:SetButtonText(self.ui.Btn_Challenge, LT.Text("DailyChallengeEnterButton"))
  self.ui.Btn_Mask:SetActive(false)
  self:AddViewComponentOnce(self.ui.UI_Common_Melt_Disaster, UICompStageInitialStateBtn, self.stageTid)
end

function DailyChallengeDifficultyView:_OnClickMask()
  self.ui.Btn_Mask:SetActive(false)
end

function DailyChallengeDifficultyView:_OnDailyDiffChange()
  DailyChallengeModel.Instance:SetDifficulty(self.stageTid)
  local baseScore = DailyChallengeModel.Instance:GetStageScoreBase(self.stageTid)
  self:SetText(self.ui.Text_ScoreMultiple, LT.Textf("DailyChallengeScoreBase", baseScore))
end

function DailyChallengeDifficultyView:_IsInitialStateTipsVisible()
  local stageTid = self.stageTid
  do return StageInitialStateModel.Instance.ExistsInitialState, StageInitialStateModel.Instance end
  return StageInitialStateModel.Instance.ExistsInitialState, StageInitialStateModel.Instance, stageTid
end

function DailyChallengeDifficultyView:_OnClickInitStateClick()
  UIManager.Instance:Reopen(Urls.StageInitialStateDetailView, self.stageTid)
end

function DailyChallengeDifficultyView:Close()
  Super.Close(self)
  DailyChallengeModel.Instance:SetDifficulty(0)
end

function DailyChallengeDifficultyView:UpdateScrollPos()
  local function _JumpToIndex()
    local offset = self.ScrollView_Difficulty_View:GetOffsetByIndex(self.curSelectIndex - 1)
    
    self.ScrollView_Difficulty_View:SetOffset(offset, false)
    self:PlayTableViewFadeInAnim(self.ui.ScrollView_Difficulty)
  end
  
  if self.ScrollView_Difficulty_View.isReady then
    _JumpToIndex()
  else
    function self.ScrollView_Difficulty_View.reloadFinishCallback()
      self.ScrollView_Difficulty_View.reloadFinishCallback = nil
      
      _JumpToIndex()
    end
  end
end

function DailyChallengeDifficultyView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Relics, function()
    local relicGroupList = DailyChallengeController.Instance:GetRelicGroupList()
    UIManager.Instance:Reopen(Urls.MainCopyRelicGroupPanel, self.stageTid, relicGroupList)
  end)
  self:AddButtonClickListener(self.ui.Btn_AwardDesc, function()
    UIManager.Instance:Reopen(Urls.CommonillustrateView, nil, LT.Text("DailyChallengeExpRewardCoefficientLevelTips"))
  end)
  self:AddButtonClickListener(self.ui.Btn_Challenge, function()
    local levelIdx = self.curSelectIndex
    if not self.levelInfos[levelIdx].unlocked then
      Alert.Show(10614)
      return
    end
    WorldStageManager.Instance:Open(self.stageTid, function()
      StageExitPanelManager.Instance:PushWhenDailyChallengeExit(self.stageTid)
    end)
  end)
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self._OnClickMask))
end

function DailyChallengeDifficultyView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnDailyDiffChange, self._OnDailyDiffChange, self)
end

function DailyChallengeDifficultyView:OnExitView()
  Super.OnExitView(self)
end

return DailyChallengeDifficultyView
