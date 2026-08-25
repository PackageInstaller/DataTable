local typeof = _ENV.typeof
local Image = CS.UnityEngine.UI.Image
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UIAnimationController = CS.Z1Client.UIAnimationController
local StageGroupType = CommonDefine.StageGroupType
local DBGMainCopyOutPanel, Super = System.NewClass("DBGMainCopyOutPanel", UIBasePanel)
DBGMainCopyOutPanel.uiResCls = UI_Dungeons_Panel_OutResource

function DBGMainCopyOutPanel:ctor(params)
  Super.ctor(self)
  self.params = params
  self.id = DataCenter.copiesData.CopiesId
  self.showAwakerTids = Vue.ref({})
  self.banClick = false
  self.allAwardTis = {}
  self.vxPrefabsList = nil
  self.isShowEffect = true
end

function DBGMainCopyOutPanel:OnBind(binder)
  Logger.Debug("DBGMainCopyOutPanel:OnBind(), 创建 UI")
  self.binder = binder
  AudioManager.Instance:PostSoundEvent("Stop_All_Avg_Sound")
  self:InitAnimation()
  local isInCopy = SceneMgr.Instance:IsInCopies()
  local settleData = DataCenter.copiesData.copiesSettleData or {}
  self.settleData = settleData
  self.isSuccess = settleData.isFinish or false
  local rewardList = self:GetShowAwardList()
  local allAwardTis, _ = ItemDataUtils.KickoutAwakerFavorItem(rewardList)
  self.allAwardTis = allAwardTis
  if self.isSuccess then
    if CopyDataUtils.IsHaveStarCondition(settleData.stageId) then
      self:PlayAnim("Panel_Dungeons_Out_2_New_VictoryOpen")
    else
      self:PlayAnim("Panel_Dungeons_Out_2_New_VictoryOpen_NoStar")
    end
  else
    self:PlayAnim("Panel_Dungeons_Out_2_New_FailOpen")
    if not ClientDataUtils.GetData(cd.ClientDataMainKey.Client, cd.ClientSubKey.EverFailed) then
      ClientDataUtils.SetData(cd.ClientDataMainKey.Client, cd.ClientSubKey.EverFailed, 1)
      self.binder:BindTimer(0.5, 0, nil, function()
        Alert.SetMaskClickClose(true)
        UIManager.Instance:Reopen(Urls.FirstBattleFailUI)
      end)
    end
  end
  local favorScore = settleData.favorScore
  local showFavor = favorScore and table.next(favorScore) ~= nil
  self.binder:SetActive(self.ui.Group_Awaker_Favor, showFavor)
  if showFavor then
    binder:BindComponent(UICompAwakerFavor(self.ui.Group_Awaker_Favor, settleData.favorScore, nil, {
      isShowDetailBtn = true,
      stageTid = settleData.stageId,
      isFristFinish = self.isFristFinish
    }))
  end
  binder:BindToText(self.ui.Text_Btn_Next, function()
    local returnText = ""
    if self.isSuccess then
      returnText = LT.Text("ResearchComplete")
    elseif not self.isSuccess then
      returnText = LT.Text("FailureConfirm")
    end
    return returnText
  end)
  binder:BindToImage(self.ui.Image_Title, function()
    if self.isSuccess then
      return "UIResources/UIBigImages/UI_Large/UI_Finish_Txt_Success.png"
    else
      return "UIResources/UIBigImages/UI_Large/UI_Finish_Txt_Fail.png"
    end
  end)
  binder:BindToText(self.ui.Text_Finish, function()
    local langKey = self.isSuccess and "Investigation_Successful" or "Investigation_Failed"
    do return LT.Text end
    return LT.Text, langKey
  end)
  binder:BindToText(self.ui.Text_Appraise, function()
    do return LT.Text end
    return LT.Text, "MainLinesInvestigationResult"
  end)
  self.ui.Text_Left_Double_Count:SetActive(true)
  binder:BindToText(self.ui.Text_Left_Double_Count, function()
    local stageCfg = DT.Stage[settleData.stageId]
    local stageGroup = stageCfg.BelongGroup
    local groupCfg = DT.StageGroup[stageGroup]
    if groupCfg.Type == CommonDefine.StageGroupType.WeekBoss then
      if not self.isSuccess then
        return ""
      end
      local leftTime = CopyDataUtils.GetWeekBossRewardCnt()
      local totalTime = DT.GetConstant("WeeklyBossStageRewardCount")
      local colorVal = 0 == leftTime and "#B7544A" or "#2B8BA0"
      do return LT.Textf, "WeeklyBossRemainTimes", colorVal, leftTime end
      return LT.Textf, "WeeklyBossRemainTimes", colorVal, leftTime, totalTime
    end
    return ""
  end)
  binder:BindToText(self.ui.Text_Level_Title, function()
    local stageCfg = DT.Stage[settleData.stageId]
    local NameNumber = LT.Text(stageCfg.NameNumber) or ""
    local Name = LT.Text(stageCfg.Name) or ""
    return NameNumber .. "<space=0.2em>" .. Name
  end)
  binder:BindToText(self.ui.Text_Exp_Value, function()
    return "+" .. settleData.expPrize
  end)
  binder:BindToText(self.ui.Text_Huodewuzi, function()
    do return LT.Text end
    return LT.Text, "MainLines_Investigation_Reward"
  end)
  binder:BindToText(self.ui.Text_Suggest, function()
    do return LT.Text end
    return LT.Text, "FailureHint"
  end)
  binder:BindToText(self.ui.Text_Suggest_Daily, function()
    do return LT.Text end
    return LT.Text, "FailureHint"
  end)
  binder:BindToText(self.ui.Text_Achievement, function()
    do return LT.Text end
    return LT.Text, "AchievementGet"
  end)
  binder:BindToText(self.ui.Text_Suggest_Title, function()
    do return LT.Text end
    return LT.Text, "PromoteMethod"
  end)
  binder:BindToText(self.ui.Text_Suggest_Detail, function()
    do return LT.Text end
    return LT.Text, "LevelFailureGuide"
  end)
  binder:BindToText(self.ui.Text_Exe_Title, function()
    do return LT.Text end
    return LT.Text, "KPLevel"
  end)
  binder:BindToText(self.ui.Text_Title, function()
    local title = LT.Text("CopiesAccount_13")
    if not isInCopy or settleData.isFinish then
      title = LT.Text("CopiesAccount_14")
    end
    return title
  end)
  binder:SetActive(self.ui.Text_Title, true)
  local coinIconPath = ItemDataUtils.GetIcon(CommonDefine.CurrencyType.JuniorMoney)
  binder:SetImage(self.ui.Image_Coin, coinIconPath)
  local curLevel = DataCenter.playerData.DRole.level
  local ImageCurrent = self.ui.Circle_Current:GetComponent(typeof(Image))
  local ImageAdd = self.ui.Circle_Add:GetComponent(typeof(Image))
  if curLevel >= PlayerDataUtils.GetMaxAccountLevelCfg().Level then
    ImageCurrent.fillAmount = 0
    ImageAdd.fillAmount = 0
  else
    local newFillAmount = DataCenter.playerData.DRole.exp / PlayerDataUtils.GetAccountUpgradeExp(curLevel)
    if 1 ~= settleData.upLevel then
      ImageCurrent.fillAmount = 0
      ImageAdd.fillAmount = 0
      binder:BindTimer(1.5, 1, function()
        ImageCurrent:DOFillAmount(newFillAmount, 1)
        ImageAdd:DOFillAmount(newFillAmount, 1)
      end)
    else
      ImageCurrent.fillAmount = newFillAmount
      ImageAdd.fillAmount = newFillAmount
    end
  end
  binder:BindToRaw(function(childBinder, awakerTid)
    if awakerTid then
      local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(awakerTid) or AwakerDataUtils.GetAwakerData(awakerTid) or {}
      local skinResNum
      if awakerData.curSkin then
        skinResNum = AwakerSkinUtils.GetSkinResNum(awakerData.curSkin)
      end
      local com = childBinder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker, awakerTid, skinResNum, nil, nil, {allowFaceChange = true}))
      com:ChangeMaterialMask(CommonRes.UIPortraitMask.commonMask)
    end
  end, function()
    return settleData.showAwakerTid
  end)
  binder:BindToVisible(self.ui.Group_Suggest, function()
    return not self.isSuccess and self.params.stageType ~= CommonDefine.StageGroupType.DailyChallenge and self.params.stageType ~= CommonDefine.StageGroupType.RailWay
  end)
  binder:BindToVisible(self.ui.Group_Daypick, function()
    return not self.isSuccess and self.params.stageType == CommonDefine.StageGroupType.DailyChallenge
  end)
  binder:BindComponent(DBGFailSettleProgress(self.ui.uiNode, self.isSuccess, self.params.stageType == CommonDefine.StageGroupType.DailyChallenge))
  binder:BindToVisible(self.ui.Group_None, function()
    return false
  end)
  binder:BindToVisible(self.ui.Image_Appraise, function()
    local StarCondTidList = DT.Stage[settleData.stageId].PerfectCondition
    return self.isSuccess and nil ~= StarCondTidList
  end)
  binder:SetActive(self.ui.UI_Dungeons_Vx_TitleGlow, self.isSuccess)
  binder:BindButtonClick(self.ui.Btn_Next, function()
    self:Close()
  end)
  local star = settleData.star or 0
  local StarCondTidList = DT.Stage[settleData.stageId].PerfectCondition
  if StarCondTidList then
    for i = 1, 3 do
      local bGetStar = i <= star
      binder:SetActive(self.ui["Star_" .. i], bGetStar)
      binder:SetActive(self.ui["Effect_Star_" .. i], bGetStar)
      local obj = Item_Dungeons_Out_Introduce_AppraiseResource(self.ui["Appraise" .. i])
      binder:SetActive(obj.Image_Open, bGetStar)
      binder:SetActive(obj.Effect_Star_1, bGetStar)
      local taskCfg = StarCondTidList[i] and DT.Task[StarCondTidList[i]] or nil
      local starCondDesc = taskCfg and taskCfg.Desc or ""
      binder:SetText(obj.Text_Detail, starCondDesc)
    end
  elseif self.isSuccess then
    AudioManager.Instance:PostSoundEvent("Play_Anim_Sum_Open_NoneFt")
  end
  binder:BindToText(self.ui.Text_Star_Number, function()
    do return LT.Text end
    return LT.Text, star
  end)
  binder:BindToVisible(self.ui.Group_Star, function()
  end)
  binder:BindToVisible(self.ui.Text_Huodewuzi, function()
    return #self.allAwardTis > 0
  end)
  binder:BindToVisible(self.ui.ScrollView_Dungeons_Out_Awaker_Data, function()
    return false
  end)
  binder:BindToVisible(self.ui.ScrollView_Achievement, function()
    return false
  end)
  binder:BindToVisible(self.ui.Group_Limit, function()
    return DataCenter.copiesData.copiesSettleData.isTrinketOver
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Achievement, function()
    return self.settleData.finishAchivement or {}
  end, function(itemBinder, item, index)
    local obj = Item_Dungeons_Out_Introduce_InfoResource(item)
    local taskId = self.settleData.finishAchivement[index]
    local desc = DT.Task[taskId].Desc
    itemBinder:BindToText(obj.Text_Info, function()
      return desc
    end)
    itemBinder:BindToVisible(obj.Image_Not, function()
      return false
    end)
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Dungeons_Out_Awaker_Data, function()
    return self.showAwakerTids.value
  end, function(itemBinder, obj, index)
    local tid = self.showAwakerTids.value[index]
    local stageCfg = DT.Stage[settleData.stageId]
    local data = {
      configId = tid,
      damageNum = 0,
      damagePrecent = 0,
      healNum = 0,
      healPrecent = 0,
      showAnim = stageCfg.AwakerReward ~= nil
    }
    itemBinder:BindComponent(DBGDungeonsOutAwakerItem(obj, data))
  end)
  binder:BindToText(self.ui.Text_Coin_Count, function()
    return "+" .. self:GetPrizeNum(3)
  end)
  binder:BindToText(self.ui.Text_Limit, function()
    do return LT.Text end
    return LT.Text, "MainCopyOutPanelTrinketMaxTips"
  end)
  binder:SetActive(self.ui.Group_Settlement_Get, false)
  self:_SetExitJumpStageGroupTid()
  local StageType2ItemTidMap = {
    [CommonDefine.StageGroupType.DailyChallenge] = DT.GetConstant("DailyChallengeExperienceRewardItem"),
    [CommonDefine.StageGroupType.RailWay] = DT.GetConstant("RailWayRewardItem")
  }
  local stageSpecialItemTid = StageType2ItemTidMap[self.params.stageType or 0]
  local stageCfg = CopyDataUtils.GetStageCfg(self.settleData.stageId) or {}
  local awardList = stageCfg.NormalReward or {}
  for i = 1, #awardList, 2 do
    if awardList[i] == DT.GetConstant("DailyChallengeExperienceRewardItem") then
      self.divingAward = awardList[i + 1]
      break
    end
  end
  binder:SetActive(self.ui.Btn_Award_Detail, false)
  local isShowAwardDetail = stageSpecialItemTid and self.isSuccess
  if self.params.stageType == CommonDefine.StageGroupType.RailWay then
    isShowAwardDetail = nil ~= stageSpecialItemTid
  end
  if isShowAwardDetail then
    local isHaveStageSpecialItem
    for _, awardData in pairs(self.allAwardTis) do
      if awardData.tid == stageSpecialItemTid then
        isHaveStageSpecialItem = true
        break
      end
    end
    if not isHaveStageSpecialItem then
      table.insert(self.allAwardTis, {
        tid = stageSpecialItemTid,
        itemCount = 0,
        awardType = CommonDefine.ItemAwardType.Normal
      })
    end
    binder:SetActive(self.ui.Btn_Award_Detail, isHaveStageSpecialItem and self.params.stageType == CommonDefine.StageGroupType.DailyChallenge)
    if self.params.stageType == CommonDefine.StageGroupType.RailWay then
      binder:SetActive(self.ui.Btn_Award_Detail, true)
    end
  end
  if stageSpecialItemTid then
    binder:SetActive(self.ui.Group_Award, false)
    local isHaveReward = false
    for _, data in pairs(self.allAwardTis) do
      if (self:GetPrizeNum(data.tid, data.awardType, data.extraOrigin) or 0) > 0 then
        isHaveReward = true
        break
      end
    end
    binder:SetActive(self.ui.Group_Settlement_Get, isHaveReward)
    binder:BindToCircularListView(self.ui.ScrollView_Article_Award_New, function()
      return self.allAwardTis
    end, function(itemBinder, obj, index)
      local data = self.allAwardTis[index]
      if data.tid == DT.GetConstant("DailyChallengeExperienceRewardItem") then
        self.actualDivingAward = self:GetPrizeNum(data.tid, data.awardType, data.extraOrigin) or 0
      end
      local itemData = {
        itemTid = data.tid,
        itemCount = self:GetPrizeNum(data.tid, data.awardType, data.extraOrigin),
        itemAwardType = data.awardType,
        extraOrigin = data.extraOrigin
      }
      itemBinder:BindComponent(SettleAwardItemNew(obj, itemData))
    end)
  else
    binder:SetActive(self.ui.Group_Award, true)
    binder:SetActive(self.ui.Group_Settlement_Get, false)
    local stageCfg = DT.Stage[settleData.stageId]
    local stageGroup = stageCfg.BelongGroup
    local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(stageGroup)
    local _itemTypeTagDesc
    if stageGroupConfig.BonusTips and stageGroupConfig.BonusTips[4] then
      _itemTypeTagDesc = LT.Text(stageGroupConfig.BonusTips[4])
    end
    binder:BindToCircularListView(self.ui.ScrollView_Article_Award, function()
      return self.allAwardTis
    end, function(itemBinder, obj, index)
      local data = self.allAwardTis[index]
      
      local function OnClick()
        ItemDataUtils.ShowItemDetailTips(itemBinder, obj, data.uid, data.tid)
      end
      
      local itemAwardTypeDescMap = CommonDefine.ItemAwardType2TagMap()
      local isBonusCard = data.awardType == cd.ItemAwardType.BonusCard
      local isExpBonus = data.awardType == cd.ItemAwardType.ExpBonus
      local hasTag = data.awardType and data.awardType ~= cd.ItemAwardType.Normal and not isBonusCard and not isExpBonus
      local hasAnyTag = data.awardType and data.awardType ~= cd.ItemAwardType.Normal
      local itemData = {
        itemTid = data.tid,
        itemCount = self:GetPrizeNum(data.tid, data.awardType, data.extraOrigin),
        clickFunc = OnClick,
        extraOrigin = data.extraOrigin,
        extraDesc = isBonusCard and _itemTypeTagDesc or hasAnyTag and itemAwardTypeDescMap[data.awardType] or nil,
        extraDescBgType = (isBonusCard or hasTag) and CommonDefine.CommonIconExtraDescBgType.Blue or isExpBonus and CommonDefine.CommonIconExtraDescBgType.Default or nil
      }
      itemBinder:BindComponent(CommonIconItemType2(obj, itemData))
      local config = DT.Item[data.tid]
      if config and self.isShowEffect then
        local quality = config.Quality
        local vxPrefabAsset = itemBinder:LoadAsset(CommonRes.WupingQualityEffect[quality])
        if vxPrefabAsset then
          if not self.vxPrefabsList then
            self.vxPrefabsList = {}
          end
          local vxPrefab = binder:Instantiate(vxPrefabAsset, obj.transform)
          UIUtils.RemoveCloneName(vxPrefab)
          self.vxPrefabsList[index] = vxPrefab
        end
      end
    end)
  end
  if self.vxPrefabsList then
    self.rewardVxTimer = binder:BindTimer(3, 0, nil, function()
      self.isShowEffect = false
      for index, vxPrefab in pairs(self.vxPrefabsList) do
        if vxPrefab then
          CS.UnityEngine.GameObject.Destroy(vxPrefab)
          self.vxPrefabsList[index] = nil
        end
      end
      binder:StopTimer(self.rewardVxTimer)
    end)
  end
  if self.isSuccess and self.settleData.expPrize and 0 ~= self.settleData.expPrize and DataCenter.playerData.DRole.level ~= DT.AcountLevelConfig[#DT.AcountLevelConfig].Level then
    self:PlaySliderAnim()
  else
    binder:SetText(self.ui.Text_Level, LT.Textf("Lv.%s", DataCenter.playerData.DRole.level))
    binder:SetImageFillAmount(self.ui.Image_Progress, DataCenter.playerData.DRole.exp / PlayerDataUtils.GetAccountUpgradeExp(DataCenter.playerData.DRole.level))
  end
  self:InitAwakerVoice()
  if self.params.stageType == CommonDefine.StageGroupType.DailyChallenge then
    self:_ShowDailyChallengeScores(binder, settleData)
  else
    self:_HideDailyChallengeScores()
  end
  self:_OnBindRailWayShow(binder)
  self:_OnBindAbyssSettleShow(binder)
  self:_OnBindSettleBtn(binder)
  if bg.battleScene then
    bg.battleScene:HideSceneEffects()
  end
  StrUtils.SetPreferedWidthFontSize(self.ui.Text_C_Sync)
  local awardDecrease = self:GetDecreaseInfos()
  binder:BindButtonClick(self.ui.Btn_Award_Detail, function()
    if not awardDecrease then
      return
    end
    PublicUIController.Instance:OnOpenPropertiesTipsView({
      showDatas = awardDecrease,
      lockNode = self.ui.Node_Award_Detail
    })
  end)
end

function DBGMainCopyOutPanel:GetDecreaseInfos()
  if self.params.stageType == CommonDefine.StageGroupType.DailyChallenge then
    do return self.GetDailyChallengeAwardOutDecrease end
    return self.GetDailyChallengeAwardOutDecrease, self
  elseif self.params.stageType == CommonDefine.StageGroupType.RailWay then
    do return self.GetRailWayAwardOutDecrease end
    return self.GetRailWayAwardOutDecrease, self
  end
end

function DBGMainCopyOutPanel:_OnBindSettleBtn(binder)
  binder:BindZ1Button(self.ui.Btn_BattleData, function()
    CopyController.Instance:OnOpenCopySettleBaseView()
  end)
  binder:BindToVisible(self.ui.Btn_BattleData, function()
    local stageCfg = DT.Stage[self.settleData.stageId]
    local showStatics = stageCfg.DataStatistics or 1
    return 1 == showStatics
  end)
end

function DBGMainCopyOutPanel:_ShowDailyChallengeScores(binder, settleData)
  if not self.isSuccess then
    self.ui.ScrollView_Adapt:SetActive(false)
    return
  end
  self.ui.Total_Score:SetActive(true)
  self.ui.Image_High_Score:SetActive(settleData.newHighScore)
  binder:SetText(self.ui.Text_Total_Score, settleData.dailyChallengeTotalScore)
  binder:SetText(self.ui.Text_ScoreMultiple, LT.Textf("ScoreSumDesc"))
  local scoreNum = #settleData.dailyChallengeScores
  local parentTransform = self.ui.Content_ScoreList.transform
  local cnt = self:ReserveChildren(parentTransform, scoreNum)
  for i = 1, scoreNum do
    local go = parentTransform:GetChild(i - 1).gameObject
    go:SetActive(true)
    local info = settleData.dailyChallengeScores[i]
    binder:BindComponent(DBGDailyChallengeScore(go, info))
  end
end

function DBGMainCopyOutPanel:_HideDailyChallengeScores()
  self.ui.Total_Score:SetActive(false)
end

function DBGMainCopyOutPanel:IsWeekChallenge()
  return self.params.stageType == CommonDefine.StageGroupType.WeeklyCopy or self.params.stageType == CommonDefine.StageGroupType.WeeklyCopy2
end

function DBGMainCopyOutPanel:_OnBindRailWayShow(binder)
  local isRailWay = self.params.stageType == CommonDefine.StageGroupType.RailWay
  binder:SetActive(self.ui.Total_RailWayScore, isRailWay)
  if not isRailWay then
    return
  end
  local railWayData = self.settleData.railWayData
  local historyMaxScore = railWayData and railWayData.maxScore or 0
  binder:SetActive(self.ui.Image_RailWay_High_Score, historyMaxScore < self.settleData.score)
  binder:SetText(self.ui.Text_RailWay_HighScore, LT.Text("RailWayOutBreakRecordTips"))
  binder:SetText(self.ui.Text_RailWay_Score, LT.Textf("RailWayOutMaxExp", self.settleData.score))
end

function DBGMainCopyOutPanel:ShowObjectTip(data)
end

function DBGMainCopyOutPanel:GetPrizeNum(tid, awardType, extraOrigin)
  local basePrize = DataCenter.copiesData.copiesSettleData.basePrize
  local num = 0
  for index = 1, #basePrize do
    local data = basePrize[index]
    if data.configId == tid and not awardType then
      num = data.num + num
    end
    if data.configId == tid and awardType and data.awardType == awardType and data.extraOrigin == extraOrigin then
      num = data.num
    end
  end
  return num
end

local SpecialItemRewardGroup = {
  CommonDefine.ItemAwardType.BonusCard,
  CommonDefine.ItemAwardType.ExpBonus
}

function DBGMainCopyOutPanel:GetShowAwardList()
  local basePrize = DataCenter.copiesData.copiesSettleData.basePrize
  local isFirstAward = false
  for _, data in pairs(basePrize) do
    if data.awardType == CommonDefine.ItemAwardType.First then
      self.isFristFinish = true
      isFirstAward = true
      break
    end
  end
  local stageCfg = DT.Stage[DataCenter.copiesData.copiesSettleData.stageId]
  local tid2index = {}
  for tid, _, index in table.iteraDouble(stageCfg.FirstTimeReward or {}) do
    tid2index[tid] = index
  end
  for tid, _, index in table.iteraDouble(stageCfg.NormalReward or {}) do
    tid2index[tid] = index
  end
  for tid, _, index in table.iteraDouble(stageCfg.PerfectReward or {}) do
    tid2index[tid] = index
  end
  local list = {}
  for index = 1, #basePrize do
    local data = basePrize[index]
    if not KeeperSkillUtils.IsKeeperSkillItem(data.configId) then
      table.insert(list, {
        tid = data.configId,
        uid = data.uid,
        index = tid2index[data.configId],
        sort = 0,
        awardType = data.awardType,
        multiNum = isFirstAward and stageCfg.FirstTimeNormalRewardMultiple or nil,
        extraOrigin = data.extraOrigin
      })
    end
  end
  
  local function GetItemSortWeight(item)
    local weight = 9999
    local gap = 100
    local type = item.awardType
    if type == CommonDefine.ItemAwardType.First3Star then
      return weight - (item.index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.First then
      return weight - (item.index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.FirstMult then
      return weight - (item.index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.DoubleOutput then
      return weight - (item.index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.Normal then
      return weight - (item.index or 0)
    end
    return weight
  end
  
  table.sort(list, function(a, b)
    if a.tid == b.tid then
      local aType = table.contains(SpecialItemRewardGroup, a.awardType) and 0 or 1
      local bType = table.contains(SpecialItemRewardGroup, b.awardType) and 0 or 1
      if aType ~= bType then
        return aType > bType
      end
    end
    local sortWeightA = GetItemSortWeight(a)
    local sortWeightB = GetItemSortWeight(b)
    if sortWeightA == sortWeightB then
      local itemA = DT.Item[a.tid]
      local itemB = DT.Item[b.tid]
      return itemA.BaseSortID < itemB.BaseSortID
    end
    return sortWeightA > sortWeightB
  end)
  return list
end

function DBGMainCopyOutPanel:GetStatsDamageNum(tid)
  local stats = DataCenter.copiesData.copiesSettleData.battleDamageStatsSum.damageData
  local max = 0
  local damageNum = 0
  for key, value in pairs(stats) do
    if DT.AwakerConfig[tonumber(key)] and value > max then
      max = value
    end
    if tid == tonumber(key) then
      damageNum = damageNum + value
    end
  end
  return {
    damageNum = damageNum,
    damagePrecent = max > 0 and damageNum / max or 0
  }
end

function DBGMainCopyOutPanel:GetStatsHealNum(tid)
  local healData = DataCenter.copiesData.copiesSettleData.battleDamageStatsSum.healData
  local blockData = DataCenter.copiesData.copiesSettleData.battleDamageStatsSum.blockData
  local max = 0
  local list = {}
  local healNum = 0
  for key, value in pairs(healData) do
    local keyNum = tonumber(key)
    if DT.AwakerConfig[keyNum] then
      if not list[keyNum] then
        list[keyNum] = 0
      end
      list[keyNum] = list[keyNum] + value
    end
    if tid == keyNum then
      healNum = healNum + value
    end
  end
  for key, value in pairs(blockData) do
    local keyNum = tonumber(key)
    if DT.AwakerConfig[keyNum] then
      if not list[keyNum] then
        list[keyNum] = 0
      end
      list[keyNum] = list[keyNum] + value
    end
    if tid == keyNum then
      healNum = healNum + value
    end
  end
  for key, value in pairs(list) do
    if value > max then
      max = value
    end
  end
  return {
    healNum = healNum,
    healPrecent = max > 0 and healNum / max or 0
  }
end

function DBGMainCopyOutPanel:InitAwakerVoice()
  local triggerType = self.isSuccess and CommonDefine.AwakerVoiceTrigger.StageVictory or CommonDefine.AwakerVoiceTrigger.StageFail
  local awakerTid = DataCenter.copiesData.copiesSettleData.showAwakerTid
  local copyAwaker = CopyAwakerDataUtils.GetBattleAwakerData(awakerTid)
  self:PlayAwakerVoice(AwakerAudioManager.Instance:GetAwakerVoiceIdFromBattle(triggerType, awakerTid, copyAwaker and copyAwaker.curSkin or nil))
end

function DBGMainCopyOutPanel:PlayAwakerVoice(voiceId)
  if 0 == voiceId then
    return
  end
  local voiceConfig = DT.Voice[voiceId]
  local soundEventName = AwakerDataUtils.GetAwakerVoiceSound(voiceId)
  local duration = AudioManager.Instance:GetEventLength(soundEventName)
  if self.voiceCloseTimer then
    self.binder:StopTimer(self.voiceCloseTimer)
    self.voiceCloseTimer = nil
  end
  self.voiceCloseTimer = self.binder:BindTimer(duration, 0, nil, function()
    AwakerFaceManager.Instance:StopSwitchFace()
    self.voiceCloseTimer = nil
  end)
  self.binder:SetText(self.ui.Text_Dialog, voiceConfig.AwakerVoiceContent)
  AudioManager.Instance:PostSoundEvent(soundEventName)
  AwakerFaceManager.Instance:SwitchFace(voiceConfig.AwakerID, voiceConfig.FacialExpressionSwitch)
end

function DBGMainCopyOutPanel:PlaySliderAnim()
  local upgradeExp = self.settleData.expPrize
  local endExp = self.settleData.endExp
  local startLevel = self.settleData.startLevel
  local endLevel = self.settleData.endLevel
  local upgradeLevel = endLevel - startLevel
  local startExp = 0
  if 0 == upgradeLevel then
    startExp = endExp - upgradeExp
  else
    local tempExp = upgradeExp - endExp
    for i = startLevel, endLevel do
      local curLevelExp = PlayerDataUtils.GetAccountUpgradeExp(i)
      if tempExp > curLevelExp then
        tempExp = tempExp - curLevelExp
      else
        startExp = curLevelExp - tempExp
        break
      end
    end
  end
  if startLevel == endLevel and startExp == endExp then
    self.binder:SetText(self.ui.Text_Level, LT.Textf("Lv.%s", endLevel))
    self.binder:SetImageFillAmount(self.ui.Image_Progress, endExp / PlayerDataUtils.GetAccountUpgradeExp(endLevel))
    return
  end
  self.binder:SetText(self.ui.Text_Level, LT.Textf("Lv.%s", startLevel))
  local duration = 0.5
  local playTime = duration
  local imageProgress = self.ui.Image_Progress:GetComponent(typeof(Image))
  if upgradeLevel and upgradeLevel > 0 then
    local startMaxExp = PlayerDataUtils.GetAccountUpgradeExp(startLevel)
    local startPercent = startExp / startMaxExp
    local endMaxExp = PlayerDataUtils.GetAccountUpgradeExp(endLevel)
    local endPercent = endExp / endMaxExp
    for level = startLevel, endLevel do
      if level == startLevel then
        local function playFunc()
          self.binder:SetImageFillAmount(self.ui.Image_Progress, startPercent)
          
          imageProgress:DOFillAmount(1, duration)
        end
        
        if startExp == startMaxExp then
          playTime = playTime - duration + 0.001
        else
          playFunc()
        end
      elseif level == endLevel then
        local function playFunc()
          self.binder:SetImageFillAmount(self.ui.Image_Progress, 0)
          
          imageProgress:DOFillAmount(endPercent, duration)
          self.binder:SetText(self.ui.Text_Level, LT.Textf("Lv.%s", level))
        end
        
        self.binder:BindTimer(playTime, 1, nil, playFunc)
      else
        local function playFunc()
          self.binder:SetImageFillAmount(self.ui.Image_Progress, 0)
          
          imageProgress:DOFillAmount(1, duration)
          self.binder:SetText(self.ui.Text_Level, LT.Textf("Lv.%s", level))
        end
        
        self.binder:BindTimer(playTime, 1, nil, playFunc)
        playTime = playTime + duration
      end
    end
    return playTime
  else
    local startMaxExp = PlayerDataUtils.GetAccountUpgradeExp(startLevel)
    local startPercent = startExp / startMaxExp
    local endPercent = endExp / startMaxExp
    self.binder:SetImageFillAmount(self.ui.Image_Progress, startPercent)
    imageProgress:DOFillAmount(endPercent, duration)
    return playTime
  end
end

function DBGMainCopyOutPanel:InitAnimation()
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
end

function DBGMainCopyOutPanel:PlayAnim(clipsString, func)
  local clipsToPlay = ""
  Logger.Debug("DBGTeamBuildMainPanel PlayAnim: ", clipsString)
  self.uiAnimController:PlayMultiState(AddClipToPlay(clipsToPlay, clipsString), func)
end

function DBGMainCopyOutPanel:Close()
  if self.banClick then
    return
  end
  AudioManager.Instance:PostSoundEvent("Stop_VO_Chr_All")
  if self.isSuccess then
    self:PlayAnim("Panel_Dungeons_Out_2_New_Close", function()
      Super.Close(self)
    end)
  else
    self.binder:BindTimer(1.5, 0, nil, function()
      Super.Close(self)
    end)
  end
  if self.params.callback then
    self.params.callback()
  else
    Super.Close(self)
  end
  self.banClick = true
end

function DBGMainCopyOutPanel:_OnBindAbyssSettleShow(binder)
  local showAbyssSettleInfo = self.isSuccess and self.params.stageType == CommonDefine.StageGroupType.AbyssChallenge
  binder:SetActive(self.ui.Total_Integral, showAbyssSettleInfo)
  local scoreText = ""
  local scoreTipText = ""
  if showAbyssSettleInfo then
    scoreText = self.settleData.score or 0
    scoreTipText = LT.Text("AbyssChallengeObtainScore")
  end
  binder:SetText(self.ui.Text_Number, scoreTipText)
  binder:SetText(self.ui.Text_Total_Score_2, scoreText)
end

function DBGMainCopyOutPanel:_CheckShowRewardConvertion()
  if not self.allAwardTis or #self.allAwardTis <= 0 then
    return
  end
  local hasConvertion = false
  local list = {}
  for _, data in ipairs(self.allAwardTis) do
    if data.overflow and table.next(data.overflow) ~= nil then
      hasConvertion = hasConvertion or true
      table.insert(list, {})
    end
  end
  if not hasConvertion then
    return
  end
end

function DBGMainCopyOutPanel:OnUnbind()
  Super.OnUnbind(self)
  if self.uiTweenList then
    for _, uiTween in pairs(self.uiTweenList) do
      if uiTween then
        uiTween:Kill(true)
        uiTween = nil
      end
    end
    self.uiTweenList = nil
  end
  if self.vxPrefabsList and table.next(self.vxPrefabsList) then
    for _, vxPrefab in pairs(self.vxPrefabsList) do
      if vxPrefab then
        CS.UnityEngine.GameObject.Destroy(vxPrefab)
      end
    end
    self.vxPrefabsList = nil
  end
  if self.rewardVxTimer then
    self.binder:StopTimer(self.rewardVxTimer)
  end
  CopiesDataUtils.ClearCopiesSettleData()
end

function DBGMainCopyOutPanel:DestroyUI()
  Super.DestroyUI(self)
  if self.voiceCloseTimer then
    self.binder:StopTimer(self.voiceCloseTimer)
    self.voiceCloseTimer = nil
  end
  if AwakerFaceManager.Instance then
    AwakerFaceManager.Instance:StopSwitchFace()
  end
end

function DBGMainCopyOutPanel:GetDailyChallengeAwardOutDecrease()
  local ret
  if not self.isSuccess then
    return nil
  end
  if self.divingAward then
    ret = {}
    table.insert(ret, {
      title = LT.Text("DailyChallengeExpRewardTask1"),
      desc = "+" .. self.divingAward
    })
  end
  if self.divingAward and self.actualDivingAward and self.actualDivingAward > self.divingAward then
    table.insert(ret, {
      title = LT.Text("DailyChallengeExpRewardTask2"),
      desc = "+" .. MathUtils.Round((self.actualDivingAward or 0) - self.divingAward)
    })
  end
  return ret
end

function DBGMainCopyOutPanel:GetRailWayAwardOutDecrease()
  local ret = {}
  local railWayData = self.settleData and self.settleData.railWayData
  if not railWayData then
    return nil
  end
  local scoreItemCountOri = railWayData.scoreItemCountOri or 0
  if scoreItemCountOri <= 0 then
    return nil
  end
  table.insert(ret, {
    title = LT.Text("RailWaySettlementDetails1"),
    desc = "+" .. scoreItemCountOri
  })
  local scoreItemCount = railWayData.scoreItemCount or 0
  local lostScoreItemCount = scoreItemCount - scoreItemCountOri
  if lostScoreItemCount < 0 then
    table.insert(ret, {
      title = LT.Text("RailWaySettlementDetails2"),
      desc = lostScoreItemCount
    })
  end
  return ret
end

function DBGMainCopyOutPanel:_SetExitJumpStageGroupTid()
  local curStageType = self.params.stageType
  if curStageType ~= StageGroupType.MainCopy and curStageType ~= StageGroupType.MainCopyHard and curStageType ~= StageGroupType.MainCopyCrazy then
    return
  end
  local stageCfg = DT.Stage[self.settleData.stageId]
  local stageGroup = stageCfg.BelongGroup
  local nextStageGroupId = stageGroup
  if self.isSuccess then
    local curStageGroupCfg = DT.StageGroup[stageGroup]
    local preBaseSortID = -1
    local groupData = DataCenter.MainCopyData.allPlots[stageGroup]
    local stageList = groupData.stageList
    local endStageId = stageList[#stageList].stageID
    if self.settleData.stageId == endStageId then
      local curTime = math.floor(TimeUtils.GetServerTime())
      for stageGroupID, info in pairs(DataCenter.MainCopyData.allPlots) do
        local stageGroupCfg = DT.StageGroup[stageGroupID]
        if info.open and stageGroupCfg then
          local canShow = stageGroupCfg and (not stageGroupCfg.StageDisplayDate or curTime >= stageGroupCfg.StageDisplayDate)
          if canShow and stageGroupCfg.Type == curStageType and stageGroupCfg.BaseSortID > curStageGroupCfg.BaseSortID then
            if preBaseSortID < 0 then
              preBaseSortID = stageGroupCfg.BaseSortID
              nextStageGroupId = stageGroupID
            elseif preBaseSortID > stageGroupCfg.BaseSortID and preBaseSortID > curStageGroupCfg.BaseSortID then
              preBaseSortID = stageGroupCfg.BaseSortID
              nextStageGroupId = stageGroupID
            end
          end
        end
      end
    end
  end
  CopyMainModel.Instance:SetExitBattleGroupTid(nextStageGroupId)
end

return DBGMainCopyOutPanel
