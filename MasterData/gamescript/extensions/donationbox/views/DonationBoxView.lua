local DonationBoxView, Super = NewClass("DonationBoxView", BaseView)
DonationBoxView.uiResCls = UI_Event_Activity_DonationBoxResource
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)

function DonationBoxView:_GetUIResCls()
  local produceConfig = DonationBoxModel.Instance:GetProductConfig(self.produceTid)
  if produceConfig and produceConfig.UIResCls then
    local clsPath = string.format("UI.UIPackages.%s", produceConfig.UIResCls)
    local tempResCls = require(clsPath)
    if tempResCls then
      self.uiResCls = tempResCls
    end
  end
  return self.uiResCls
end

function DonationBoxView:ctor(produceTid)
  Super.ctor(self)
  self.produceTid = produceTid
  self.model = DonationBoxModel.Instance
  self.timers = {}
end

function DonationBoxView:OnBuildView()
end

function DonationBoxView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnActivityDonationProduceUpdate, self._OnRefreshView, self)
end

function DonationBoxView:RegisterEvents()
  self:_CreateRewardTableView()
  self:AddButtonClickListener(self.ui.Btn_Recieve, System.fn(self, self._OnClickReceiveBtn))
  self:_InitBtnReceiveRed()
end

function DonationBoxView:OnEnterView()
  Super.OnEnterView(self)
  self:SetButtonText(self.ui.Btn_Recieve, LT.Text("CommonReceive"))
  self:SetText(self.ui.Text_Describe, self.model:GetBoxWorldviewText(self.produceTid))
  StrUtils.SetPreferredHeight(self.ui.Text_Describe)
  self:_OnBindBgComp()
  self:_SetProductionSpeedShow()
  self:_OnRefreshView()
end

function DonationBoxView:OnEnterViewFinished()
end

function DonationBoxView:_CreateRewardTableView()
  local cellRT = self.ui.UI_Common_Item_WuPin_Type2:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.rewardTableView = self:CreateTableview(self.ui.ScrollView_Reward, function()
    if not self.rewardList then
      return 0
    end
    return #self.rewardList
  end, function(view, index)
    do return self._ProgressCellAtIndex, self, view end
    return self._ProgressCellAtIndex, self, view, index
  end)
end

function DonationBoxView:_OnBindBgComp()
  local viewData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    clickFunc = System.fn(self, self.Close),
    textTitleCN = self.model:GetBoxName(self.produceTid)
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_S, CompPublicPopupTips, viewData)
end

function DonationBoxView:_SetProductionSpeedShow()
  local isDonationBoxActive = self.model:IsBoxActive(self.produceTid)
  self.ui.Group_Speed:SetActive(isDonationBoxActive)
  if not isDonationBoxActive then
    return
  end
  local produceSpeeds = self.model:GetProductionSpeeds(self.produceTid)
  self:SetText(self.ui.Text_SpeedRate, LT.Textf("CollectionBoxProduceSpeed", produceSpeeds.normal))
  local rewardTids = self.model:GetProductRewardTids(self.produceTid)
  local normalRewardTid = rewardTids and rewardTids.normal
  local icon = normalRewardTid and ItemDataUtils.GetItemIcon(normalRewardTid)
  if icon then
    self:SetImage(self.ui.item_Icon_1, icon)
  end
  local hasExtraDrop = self.model:HasExtraProduceReward(self.produceTid)
  self.ui.Text_SpeedRate_1:SetActive(hasExtraDrop)
  if hasExtraDrop then
    self:SetText(self.ui.Text_SpeedRate_1, LT.Textf("CollectionBoxProduceSpeed", produceSpeeds.extra))
    local extraRewardTid = rewardTids and rewardTids.extra
    local icon = extraRewardTid and ItemDataUtils.GetItemIcon(extraRewardTid)
    if icon then
      self:SetImage(self.ui.item_Icon_2, icon)
    end
  end
end

function DonationBoxView:_RefreshMaxTips()
  local isReachMaxReward = self.model:IsReachMaxReward(self.produceTid)
  local isDonationBoxActive = self.model:IsBoxActive(self.produceTid)
  self.ui.Text_C_Full:SetActive(isReachMaxReward and isDonationBoxActive)
end

function DonationBoxView:_RefreshEmptyTips()
  local isRewardEmpty = self.model:IsRewardEmpty(self.produceTid)
  self.ui.Text_None:SetActive(isRewardEmpty)
end

function DonationBoxView:_RefreshFinishTips()
  local isBoxFinished = self.model:IsBoxFinish(self.produceTid)
  self.ui.Text_C_Finish:SetActive(isBoxFinished)
  self.ui.Text_Time:SetActive(not isBoxFinished)
end

function DonationBoxView:_RefreshTimer()
  self:_ClearAllTimer()
  
  local function SetTimeText(textObj, countdown, showTextKey)
    if countdown <= 0 then
      self:SetText(textObj, "")
      local timer = self.timers[textObj]
      if timer then
        self:StopTimer(timer)
        self.timers[textObj] = nil
      end
      return
    end
    local showText = LT.Textf(showTextKey, self.model:GetCountdownTimeFormatText(countdown))
    self:SetText(textObj, showText)
  end
  
  if self.model:IsBoxFinish(self.produceTid) then
    self:SetText(self.ui.Text_Time, "")
    return
  end
  self.timers[self.ui.Text_Time] = self:BindTimer(1, -1, function()
    local countdown = self.model:GetFullGainLeftTime(self.produceTid)
    SetTimeText(self.ui.Text_Time, countdown, "CollectionBoxFillUpCountdown")
  end, function()
    if self.timers[self.ui.Text_Time] then
      self:StopTimer(self.timers[self.ui.Text_Time])
      self.timers[self.ui.Text_Time] = nil
    end
  end)
  local fullGainCd = self.model:GetFullGainLeftTime(self.produceTid)
  SetTimeText(self.ui.Text_Time, fullGainCd, "CollectionBoxFillUpCountdown")
  local isRewardEmpty = self.model:IsRewardEmpty(self.produceTid)
  if isRewardEmpty then
    self.timers[self.ui.Text_None] = self:BindTimer(1, -1, function()
      local countdown = self.model:GetNextGainRewardLeftTime(self.produceTid)
      SetTimeText(self.ui.Text_None, countdown, "CollectionBoxCollectCountdown")
    end, function()
      if self.timers[self.ui.Text_None] then
        self:StopTimer(self.timers[self.ui.Text_None])
        self.timers[self.ui.Text_None] = nil
      end
    end)
    local nextRewardCd = self.model:GetNextGainRewardLeftTime(self.produceTid)
    SetTimeText(self.ui.Text_None, nextRewardCd, "CollectionBoxCollectCountdown")
  end
end

function DonationBoxView:_OnRefreshView()
  self:_RefreshProduceRewards()
  self:_RefreshGainAwardBtnState()
  self:_RefreshTimer()
  self:_RefreshMaxTips()
  self:_RefreshEmptyTips()
  self:_RefreshFinishTips()
  self:_RefreshBoxState()
end

function DonationBoxView:_InitBtnReceiveRed()
  self:SetButtonRedPoint(self.ui.Btn_Recieve, function()
    do return RedPointDataUtils.GetRedPointState, RedTypeDefine.RedType.DonationBox end
    return RedPointDataUtils.GetRedPointState, RedTypeDefine.RedType.DonationBox, {
      self.produceTid
    }, self.produceTid
  end)
end

function DonationBoxView:_RefreshGainAwardBtnState()
  local enableGainReward = self.model:EnableGainReward(self.produceTid)
  local btnState = enableGainReward and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
  self:SetButtonState(self.ui.Btn_Recieve, btnState)
end

function DonationBoxView:_RefreshProduceRewards()
  self.rewardList = self.model:GetRewardListBySvrData(self.produceTid)
  self.rewardTableView:ReloadData()
end

function DonationBoxView:_ProgressCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type2)
  local rewardInfo = self.rewardList[index]
  local viewData = {
    itemTid = rewardInfo and rewardInfo.tid,
    itemCount = rewardInfo and rewardInfo.num or 0
  }
  self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, viewData)
  return cell
end

function DonationBoxView:_OnClickReceiveBtn()
  if not self.model:EnableGainReward(self.produceTid) then
    if self.model:IsBoxFinish(self.produceTid) then
      Alert.Show(10822)
      return
    end
    Alert.Show(10821)
    return
  end
  DonationBoxController.Instance:ReqGainBoxReward(self.produceTid)
end

function DonationBoxView:_RefreshBoxState()
end

function DonationBoxView:_ClearAllTimer()
  if self.timers then
    for k, _ in pairs(self.timers) do
      if self.timers[k] then
        self:StopTimer(self.timers[k])
        self.timers[k] = nil
      end
    end
  end
end

function DonationBoxView:OnExitView()
  Super.OnExitView(self)
end

return DonationBoxView
