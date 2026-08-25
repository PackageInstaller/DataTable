local CURRENCY_ITEM_TID = DT.GetConstant("EnergyItemTid")
local TeamStageTipUtils = _G.TeamStageTipUtils
local DungeonSweepPanel, Super = System.NewClass("DungeonSweepPanel", UIBasePanel)
DungeonSweepPanel.uiResCls = UI_Dungeous_Popup_Swept_Tip2Resource

function DungeonSweepPanel:ctor(stageId, activityTid, limitTimes)
  Super.ctor(self)
  self.stageId = stageId
  self.activityTid = activityTid
  self.banClick = false
  self.limitTimes = limitTimes
  self.currencyTid = CURRENCY_ITEM_TID
  local extraCostItemTid = StageCfgUtils.GetExtraCostItemTid(self.stageId)
  if extraCostItemTid then
    self.currencyTid = extraCostItemTid
  end
end

function DungeonSweepPanel:OnBind(binder)
  self.binder = binder
  local model = binder:createModel(DungeonSweepPanelModel, self.stageId, self.activityTid, self.limitTimes)
  self.model = model
  binder:SetText(self.ui.Text_C_Title, LT.Text(StageCfgUtils.GetCfgField("Name", self.stageId)))
  self:OnBindButton(binder, model)
  self:OnBindSlider(binder, model)
  self:OnBindCostItems(binder, model)
  self:OnBindRewardItems(binder, model)
  self:OnBindBonusInfo(binder, model)
  local currencyTidList = {
    self.currencyTid
  }
  binder:BindComponent(CommonCurrencyGroupItem(self.ui.UI_Common_Item_Coin_Group, currencyTidList))
end

function DungeonSweepPanel:OnBindRewardItems(binder, model)
  self.rewardList = self:GetStageSweepRewardList()
  local baseGameObj = self.ui.UI_Common_Item_WuPin_Type2
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  self._rewardCellWidth = itemW
  local itemComps = {}
  self.rewardTableView = self:CreateTableview(self.ui.ScrollView_Rewars, function()
    return #(self.rewardList or {})
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local rw = self.rewardList[idx]
    local itemCount = self:GetSweepRewardCount(rw, model.sweepTimes)
    if 0 == itemCount then
      itemCount = nil
    end
    local itemData = {
      itemTid = rw.tid,
      itemCount = itemCount
    }
    if rw.isAccelerateBonus or rw.isDoubleOutputBonus then
      itemData.extraDesc = rw.activityBonusTagText
      itemData.extraDescBgType = CommonDefine.CommonIconExtraDescBgType.Default
    elseif rw.activityBonusTagText then
      itemData.extraDesc = rw.activityBonusTagText
      itemData.extraDescBgType = CommonDefine.CommonIconExtraDescBgType.Blue
    end
    itemComps[gameObj] = self.binder:BindComponent(CommonIconItemType2(gameObj, itemData))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
  self:_RefreshRewardTableView()
  binder:BindToRaw(function(_, _)
    self:_RefreshRewardTableView()
  end, function()
    return model.sweepTimes
  end)
end

function DungeonSweepPanel:_GetTeamStageTipContext()
  do return TeamStageTipUtils.GetSweepContext end
  return TeamStageTipUtils.GetSweepContext, self.model.stageCfg
end

function DungeonSweepPanel:OnBindBonusInfo(binder, _)
  binder:BindToVisible(self.ui.Group_BounsTip, function()
    do return TeamStageTipUtils.HasAnyTip, self:_GetTeamStageTipContext() end
    return TeamStageTipUtils.HasAnyTip, self:_GetTeamStageTipContext()
  end)
  TeamStageTipUtils.BindSingleTextTip(binder, self.ui.Text_Bouns, function()
    do return self._GetTeamStageTipContext end
    return self._GetTeamStageTipContext, self
  end)
  TeamStageTipUtils.BindIllustrateButton(binder, self.ui.Btn_Bouns, function()
    do return self._GetTeamStageTipContext end
    return self._GetTeamStageTipContext, self
  end)
end

function DungeonSweepPanel:_RefreshRewardTableView()
  if not self.rewardTableView then
    return
  end
  local tv = self.rewardTableView
  local oldCb = tv.reloadFinishCallback
  
  function tv.reloadFinishCallback(t)
    tv.reloadFinishCallback = oldCb
    if oldCb then
      oldCb(t)
    end
    self:_CenterRewardTableViewIfNeeded()
  end
  
  tv:ReloadData()
end

function DungeonSweepPanel:_CenterRewardTableViewIfNeeded()
  self:CenterTableviewContentIfNeeded(self.ui.ScrollView_Rewars, self.rewardTableView, #(self.rewardList or {}), self._rewardCellWidth)
end

function DungeonSweepPanel:GetSweepRewardCount(reward, sweepTimes)
  local showCount = reward.num or 0
  if reward.type == CommonDefine.ItemAwardType.Normal then
    local times = math.max(1, sweepTimes or 1)
    if reward.doubleOutputLeftCount then
      times = math.min(times, reward.doubleOutputLeftCount)
    end
    showCount = showCount * times
  end
  return showCount
end

function DungeonSweepPanel:GetStageSweepRewardList()
  local previewList = CopyDataUtils.GetStageRewardPreviewList(self.model.stageId, {firstPassGotMode = "first_draw", includeTaskNormalReward = true})
  local rewardList = previewList or {}
  local accountExpTid = DT.GetConstant("AccountExpItemTid")
  local stageGroupId = self.model.stageCfg.BelongGroup
  local isDoubleOutput = stageGroupId and ActivityManager.Instance:CheckDoubleOutputEffect(stageGroupId)
  local doubleOutputLeftCount = 0
  if isDoubleOutput then
    local activityData = ActivityManager.Instance:GetMultiDropActivity(stageGroupId)
    doubleOutputLeftCount = activityData and activityData.count or 0
  end
  local bonusByTid = {}
  local out = {}
  for _, reward in ipairs(rewardList) do
    table.insert(out, reward)
    local bonuses = {}
    if reward.tid == accountExpTid and reward.num and reward.num > 0 then
      local bonusExpNum = PlayerDataUtils.GetBonusExpNum(reward.num)
      if bonusExpNum > 0 then
        local bonusReward = table.clone(reward)
        bonusReward.num = bonusExpNum
        bonusReward.activityBonusTagText = LT.Text("RewardItemAccelerateTag")
        bonusReward.isAccelerateBonus = true
        table.insert(bonuses, bonusReward)
      end
    elseif isDoubleOutput and reward.tid ~= accountExpTid then
      local bonusReward = table.clone(reward)
      bonusReward.activityBonusTagText = LT.Text("CommonItemDoubleOutputActivity")
      bonusReward.isDoubleOutputBonus = true
      bonusReward.doubleOutputLeftCount = doubleOutputLeftCount
      table.insert(bonuses, bonusReward)
    end
    if #bonuses > 0 then
      bonusByTid[reward.tid] = bonusByTid[reward.tid] or {}
      for _, b in ipairs(bonuses) do
        table.insert(bonusByTid[reward.tid], b)
      end
    end
  end
  if table.next(bonusByTid) then
    local orderedOut = {}
    local inserted = {}
    for _, reward in ipairs(out) do
      table.insert(orderedOut, reward)
      if bonusByTid[reward.tid] and not inserted[reward.tid] then
        inserted[reward.tid] = true
        for _, bonusReward in ipairs(bonusByTid[reward.tid]) do
          table.insert(orderedOut, bonusReward)
        end
      end
    end
    out = orderedOut
  end
  do return ItemDataUtils.MovePlayerExpToEnd, TeamStageTipUtils.ApplySweepActivityBonusRewardSplit(out, self.model.stageCfg) end
  return ItemDataUtils.MovePlayerExpToEnd, TeamStageTipUtils.ApplySweepActivityBonusRewardSplit(out, self.model.stageCfg)
end

function DungeonSweepPanel:OnBindCostItems(binder, model)
  local com = binder:BindComponent(CommonCoinCostCom(self.ui.UI_Common_Group_Coin))
  binder:BindToRaw(function(_, tbl, _)
    local own = tbl[2]
    local need = tbl[1]
    com:UpdateItem(self.currencyTid)
    com:UpdateOriValue("")
    com:NowColorNormal(own >= need)
    com:UpdateNow(need)
  end, function()
    return {
      model.costItemNum,
      ItemDataUtils.GetItemNum(self.currencyTid)
    }
  end)
  binder:BindToVisible(self.ui.Group_RewardPreview, function()
    local isCanSweep = CopyDataUtils.IsCanSweepInCondition(self.model.stageId, self.activityTid)
    return isCanSweep
  end)
  binder:BindToVisible(self.ui.Group_Unlock, function()
    local isCanSweep = CopyDataUtils.IsCanSweepInCondition(self.model.stageId, self.activityTid)
    return not isCanSweep
  end)
  binder:BindToVisible(self.ui.UI_Common_Group_Coin, function()
    local isCanSweep = CopyDataUtils.IsCanSweepInCondition(self.model.stageId, self.activityTid)
    local isCostToSweep = model.costItemNum > 0
    return isCanSweep and isCostToSweep
  end)
  binder:BindToVisible(self.ui.Group_No_Money, function()
    do return self.NeedShowNoMoneyGourp end
    return self.NeedShowNoMoneyGourp, self
  end)
  binder:BindToVisible(self.ui.Group_Nor, function()
    return not self:NeedShowNoMoneyGourp()
  end)
  binder:BindToVisible(self.ui.Image_TipsBg, function()
    return false
  end)
  binder:BindToText(self.ui.Text_Tips, function()
    local _, _, tip = CopyDataUtils.IsCanSweepInCondition(self.model.stageId, self.activityTid)
    return tip
  end)
end

function DungeonSweepPanel:OnBindButton(binder, _)
  binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self.OnConfirm), function()
    return CopyDataUtils.IsSweepTypeOK(self.model.stageId, self.activityTid) and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
  end, function()
    local energyNotEnough = PlayerDataUtils.GetEnergy() < self.model.stageCfg.Cost
    if energyNotEnough then
      do return LT.Text end
      return LT.Text, "ReplenishEnergy_Title"
    end
    do return LT.Text end
    return LT.Text, "UniversalConfirmButton"
  end)
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.OnCancel), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalCancelButton"
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, function()
    UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text("SweepRuleTxt"))
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function DungeonSweepPanel:OnBindSlider(binder, model)
  binder:BindToText(self.ui.Text_Quantity, function()
    do return math.max, model.sweepTimes end
    return math.max, model.sweepTimes, 1
  end)
  binder:BindToText(self.ui.Text_Min, function()
    return model.sweepMinTime
  end)
  binder:BindToText(self.ui.Text_Max, function()
    return model.sweepMaxTime
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Sub, System.fn(self, self.OnClickSub), function()
    if model.sweepTimes == model.sweepMinTime then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.Normal
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Add, System.fn(self, self.OnClickAdd), function()
    if model.sweepTimes == model.sweepMaxTime then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.Normal
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Max, System.fn(self, self.OnClickMax), function()
    return CommonDefine.BtnType.Normal
  end)
  binder:BindToSlider(self.ui.Slider_Sweep, function(value)
    model:SetSweepTimes(value)
  end, function()
    return model.sweepMinTime
  end, function()
    return model.sweepMaxTime
  end)
  binder:BindToRaw(function(childbinder, value)
    childbinder:SetSliderCurValue(self.ui.Slider_Sweep, value)
  end, function()
    return model.sweepTimes
  end)
  binder:SetSliderCurValue(self.ui.Slider_Sweep, model.sweepMinTime)
end

function DungeonSweepPanel:OnClickAdd()
  self.model:SetSweepTimes(self.model.sweepTimes + 1)
end

function DungeonSweepPanel:OnClickSub()
  self.model:SetSweepTimes(self.model.sweepTimes - 1)
end

function DungeonSweepPanel:OnClickMax()
  self.model:SetSweepTimes(self.model.sweepMaxTime)
end

function DungeonSweepPanel:OnCancel()
  self:Close()
end

function DungeonSweepPanel:OnConfirm()
  if self.banClick then
    return
  end
  local isOk, reason, tip = CopyDataUtils.IsCanSweepInCondition(self.model.stageId, self.activityTid)
  if not isOk and tip and reason and reason ~= CommonDefine.SweepCondition.NotEnoughEnergy then
    Alert.ShowStr(tip)
    return
  end
  local stageInfo = DT.Stage[self.model.stageId]
  local stageGroupInfo = DT.StageGroup[stageInfo.BelongGroup]
  if stageGroupInfo.Type == CommonDefine.StageGroupType.TrinketCopy then
    local cnt = ItemDataUtils.GetTrinketCount()
    local limitList = DT.GetOriginalConstant("BagCapacity")
    local maxCnt = limitList[2]
    if cnt >= maxCnt then
      local function confirmFunc()
        UIManager.Instance:Reopen(Urls.AlchemyMainPanel, AlchemyDefine.AlchemyType.TrinketDecompose)
      end
      
      Alert.Show(20091, nil, confirmFunc)
      return
    end
  end
  if PlayerDataUtils.GetEnergy() < self.model.stageCfg.Cost then
    PlayerDataUtils.ShowEnergyRestorePanel()
    return
  end
  self.banClick = true
  CopyDataUtils.ReqStageSweep(self.model.stageId, self.model.sweepTimes, self.model.teamId, function()
    self.banClick = false
  end, function()
    self.banClick = false
  end)
  self:Close()
end

function DungeonSweepPanel:GetCurStar()
  local stageGroupId = DT.Stage[self.stageId].BelongGroup
  local stageDataGroup = CopyDataUtils.GetStageList(stageGroupId)
  local curStar = 0
  for _, stageData in ipairs(stageDataGroup) do
    if stageData.stageID == self.stageId then
      curStar = stageData.star
      break
    end
  end
  return curStar
end

function DungeonSweepPanel:NeedShowNoMoneyGourp()
  local isCanSweep = CopyDataUtils.IsSweepTypeOK(self.model.stageId, self.activityTid)
  local levelNotEnough = not CopyDataUtils.CheckLevelReach(self.model.stageId)
  local energyNotEnough = PlayerDataUtils.GetEnergy() < self.model.stageCfg.Cost
  if not isCanSweep or levelNotEnough or energyNotEnough or 1 == self.model.sweepMaxTime then
    return true
  end
  return false
end

return DungeonSweepPanel
