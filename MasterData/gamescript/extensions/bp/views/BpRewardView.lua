local ONEPAGESHOWNUM = 4
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local BpRewardState = CommonDefine.BpRewardState
local SeniorBPBuyReward = DT.GetOriginalConstant("SeniorBPBuyReward", {})
local BpRewardView, Super = NewClass("BpRewardView", BaseView)
BpRewardView.uiResCls = UI_Passport_Reward_Item_NewResource

function BpRewardView:ctor()
  Super.ctor(self)
  BpRewardModel.Instance:OnInit()
end

function BpRewardView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnBpChangePreviewReward, self._InitPreviewReward, self)
  self:RegisterLocalNotify(NotifyId.OnBpRewardListToTail, self._InitPreviewReward, self)
  self:AddButtonClickListener(self.ui.Btn_Unlock, System.fn(self, self.UnlockAdvance))
  self:AddButtonClickListener(self.ui.Group_Senior, System.fn(self, self.UnlockAdvance))
  self:AddButtonClickListener(self.ui.Btn_Exclamation_Mark, System.fn(self, self.OpenBpShowPanel))
  self:AddButtonClickListener(self.ui.Btn_One_Click, System.fn(self, self.OneClickReceive))
  self:AddButtonClickListener(self.ui.Btn_Buy_Level, System.fn(self, self.OpenBpLevelPurchasePanel))
  self:_InitRewardList()
end

function BpRewardView:RegisterEvents()
  self:BindEvent(EventMgr.Instance.BpLevelChange, System.fn(self, self.RewardListJump))
  self:BindEvent(EventMgr.Instance.BpSyncData, System.fn(self, self._RefreshView))
end

function BpRewardView:OnEnterView()
  Super.OnEnterView(self)
  self:SetText(self.ui.Text_Double, LT.Text("DoubleExperience_03"))
  self:SetText(self.ui.Text_Get, SeniorBPBuyReward and SeniorBPBuyReward[2] or 0)
  self.binder:BindToScrollbarValueChange(self.ui.Scrollbar_Horizontal, function(val)
    BpRewardModel.Instance:SetIsRewardList2Tail(math.abs(1 - val) < 0.005)
  end)
  local bpTid = BattlePassDataUtils.GetTid()
  self:SetActive(self.ui.Group_Tag_Double, BattlePassCfgUtils.GetCfgField("IFDoubleEx", bpTid))
  self:AddViewComponentOnce(self.ui.uiNode, CompBpExpSliderItem, UI_Passport_Reward_Item_NewResource)
  self:_InitCompCountDown()
  self:_RefreshView()
  if self.rewardListView.isReady then
    self:RewardListJump()
  else
    function self.rewardListView.reloadFinishCallback()
      self.rewardListView.reloadFinishCallback = nil
      
      self:RewardListJump()
    end
  end
end

function BpRewardView:RefreshOnRendered()
end

function BpRewardView:_RefreshView()
  self.rewardListView:ReloadData()
  self.ui.Btn_One_Click:SetActive(self:_GetBtnOneClickVisible())
  self.ui.Btn_Unlock:SetActive(BattlePassDataUtils.GetPrivilegeLevel() < CommonDefine.BpPrivilegeLevel.Core)
  self.ui.Unlock_Get:SetActive(BattlePassDataUtils.GetPrivilegeLevel() < CommonDefine.BpPrivilegeLevel.Advanced)
  self.ui.Image_Advance_Lock:SetActive(BattlePassDataUtils.GetPrivilegeLevel() < CommonDefine.BpPrivilegeLevel.Advanced)
  self.ui.Group_Tag_Double:SetActive(BattlePassDataUtils.IsDoubleEx())
  self:SetText(self.ui.Text_Double, LT.Text("DoubleExperience_03"))
  self:_InitPreviewReward()
end

function BpRewardView:PlaySameMaxLevelAnim(startExp, startLevel, endExp, endLevel)
  if BattlePassDataUtils.GetExtraLvAwardNum() > BattlePassDataUtils.GetOldExtraLvAwardNum() then
    self:PlayLevelUpAnim(startExp, startLevel, endExp, endLevel, false)
    return
  end
  self:PlaySameLevelAnim(startExp, startLevel, endExp, endLevel)
end

function BpRewardView:_InitPreviewReward()
  local viewData = {
    level = BpRewardModel.Instance.nextLargeRewardLevel,
    isPreview = true
  }
  self:AddViewComponentOnce(self.ui.UI_Preview_Reward_Item, CompBpRewardGroupItem, viewData)
end

function BpRewardView:_InitCompCountDown()
  self:SetText(self.ui.Text_Time, LT.Textf("BPTimeFormat", BpModel.Instance:GetBpCountDown()))
  self.countDownTimer = self:BindTimer(1, -1, function()
    self:SetText(self.ui.Text_Time, LT.Textf("BPTimeFormat", BpModel.Instance:GetBpCountDown()))
  end)
end

function BpRewardView:_InitRewardList()
  local cellRT = self.ui.UI_Passport_Reward_Item:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.rewardListView = self:CreateTableview(self.ui.ScrollView_Reward_List, function()
    if not BpRewardModel.Instance.bpRwardList then
      return 0
    end
    return #BpRewardModel.Instance.bpRwardList
  end, function(view, index)
    do return self._RewardCellAtIndex, self, view end
    return self._RewardCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function BpRewardView:_RewardCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Passport_Reward_Item)
  BpRewardModel.Instance:SetCurRewardListIdx(index)
  local viewData = {level = index}
  self:AddViewComponentOnce(cell.gameObject, CompBpRewardGroupItem, viewData)
  return cell
end

function BpRewardView:OnEnterViewFinished()
end

function BpRewardView:UnlockAdvance()
  BpModel.Instance:SetCurPage(CommonDefine.BpPage.Recharge)
end

function BpRewardView:OpenBpShowPanel()
  BpModel.Instance:SetCurPage(CommonDefine.BpPage.Review)
end

function BpRewardView:OneClickReceive()
  local sendList = {}
  local endLevel = math.min(BattlePassDataUtils.GetMaxBpLevel(), BattlePassDataUtils.GetLevel())
  for level = 1, endLevel do
    for _, awardData in pairs(BpRewardModel.Instance.bpRwardList[level]) do
      local state = BattlePassDataUtils.GetRewardItemState(level, awardData.bpRewardType, awardData.tid)
      if state == BpRewardState.CanReceive then
        local bpGetRewardProtoData = {
          tid = awardData.tid,
          privType = awardData.bpRewardType,
          level = level
        }
        table.insert(sendList, bpGetRewardProtoData)
      end
    end
  end
  
  local function CheckEnergyOver()
    local energyItemId = DT.GetConstant("EnergyItemTid")
    local energyItemNum = 0
    local curEndLevel = math.min(BattlePassDataUtils.GetMaxBpLevel(), BattlePassDataUtils.GetLevel())
    for level = 1, curEndLevel do
      for _, awardData in pairs(BpRewardModel.Instance.bpRwardList[level]) do
        local state = BattlePassDataUtils.GetRewardItemState(level, awardData.bpRewardType, awardData.tid)
        if state == BpRewardState.CanReceive then
          local itemId = awardData.tid
          if itemId == energyItemId then
            energyItemNum = energyItemNum + awardData.num
          end
        end
      end
    end
    if energyItemNum > 0 then
      do return GetEnergyCheckUtils.EnergyIsOverMax end
      return GetEnergyCheckUtils.EnergyIsOverMax, energyItemNum, 1, BattlePassDataUtils.GetLevel()
    else
      return false
    end
  end
  
  local function ReqReceiveRewardAll()
    BattlePassDataUtils.ReceiveRewardAll(sendList)
  end
  
  if CheckEnergyOver() then
    GetEnergyCheckUtils.TipsShow(ReqReceiveRewardAll)
  else
    ReqReceiveRewardAll()
  end
end

function BpRewardView:_GetBtnOneClickVisible()
  local rst = false
  for _, data in pairs(BattlePassDataUtils.GetRewardList()) do
    local rewardState = BattlePassDataUtils.GetRewardItemState(data.unlockLevel, data.bpRewardType, data.tid)
    if rewardState == BpRewardState.CanReceive and 0 ~= data.unlockLevel then
      rst = true
      break
    end
  end
  return rst
end

function BpRewardView:RewardListJump()
  local jumpIdx = self:_GetRewardListJumpIdx()
  local offset = self.rewardListView:GetOffsetByIndex(jumpIdx - 1)
  self.rewardListView:SetOffset(offset, false)
end

function BpRewardView:_GetRewardListJumpIdx()
  local bpLevel = BattlePassDataUtils.GetLevel()
  local maxLevel = BattlePassDataUtils.GetMaxBpLevel()
  if bpLevel <= 1 then
    return 1
  elseif bpLevel >= maxLevel then
    return maxLevel
  end
  local canReceiveNum = BattlePassDataUtils.GetAwardLevelNum()
  local showNum = ONEPAGESHOWNUM
  do return math.max, bpLevel - math.min(canReceiveNum, showNum - 1) end
  return math.max, bpLevel - math.min(canReceiveNum, showNum - 1), 1, showNum - 1
end

function BpRewardView:OpenBpLevelPurchasePanel()
end

function BpRewardView:OnExitView()
  if self.countDownTimer then
    self:StopTimer(self.countDownTimer)
    self.countDownTimer = nil
  end
  Super.OnExitView(self)
end

return BpRewardView
