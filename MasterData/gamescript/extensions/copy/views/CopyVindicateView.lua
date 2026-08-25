local CopyVindicateView, Super = NewClass("CopyVindicateView", BaseView)
CopyVindicateView.uiResCls = UI_Chapter_Vindicate_ViewResource
local Vector2 = CS.UnityEngine.Vector2
local UIAnimationController = CS.Z1Client.UIAnimationController
local Z1ButtonState = CommonDefine.Z1ButtonState
local featureId = cd.FeatureId.ConfessionEvent

function CopyVindicateView:ctor()
  Super.ctor(self)
  self.awakerTableView = nil
  self.awakerItemUIMap = {}
  self.awakerItemStageTidMap = {}
end

function CopyVindicateView:IsUnlocked()
  local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(featureId, 0)
  if isUnlock then
    return true
  end
  local actType = ActivityDefine.ActivityType.ConfessionEventDiscountActivity
  local activityData = ActivityManager.Instance:GetOpeningActivityByType(actType)
  if activityData then
    return true
  end
end

function CopyVindicateView:OnEnterView()
  Super.OnEnterView(self)
  local isUnlock = self:IsUnlocked()
  self.ui.Group_Null_White:SetActive(not isUnlock)
  self.ui.Content:SetActive(isUnlock)
  if not isUnlock then
    local lockTip = PlayerDataUtils.GetFeatureLogicUnlockTips(featureId, 0)
    self:SetText(self.ui.Text_Time, lockTip)
    return
  end
  CopyVindicateModel.Instance:ResetData()
  self:InitAwakerTableView()
  self:SetAwakerDetail()
  self:SetLockedState()
  self.awakerTableView:ReloadData()
  self:AddViewComponent(self.ui.Group_Coin, UICompCommonCurrencyGroupItem, DT.Constant.VindicateCurrencies.Data)
  RedPointDataUtils.ClearFeatureFirstOpen(cd.FeatureId.ConfessionEvent)
end

function CopyVindicateView:OnExitView()
  Super.OnExitView(self)
  self.awakerTableView = nil
  self.awakerItemUIMap = nil
  self.awakerItemStageTidMap = nil
end

function CopyVindicateView:SetRendered(isRendered)
  Super.SetRendered(self, isRendered)
  local isUnlock = self:IsUnlocked()
  if not isUnlock then
    return
  end
  if isRendered and not self._isPlayingOpenAnim then
    local uiAnimCtr = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
    self._isPlayingOpenAnim = true
    uiAnimCtr:PlayState("UI_Chapter_Vindicate_View_Open", function()
      self._isPlayingOpenAnim = false
      AvgTutorialManager.Instance:PlayTutorialAvgByFeatureId(CommonDefine.FeatureId.ConfessionEvent)
    end)
  end
end

function CopyVindicateView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnVindicateStageSelected, System.fn(self, self.OnStageSelected))
  self:RegisterNotify(NotifyId.OnStageUnlocked, System.fn(self, self.OnStageUnlocked))
  self:RegisterNotify(NotifyId.OnStageDataChanged, System.fn(self, self.OnStageDataChange))
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, System.fn(self, self.OnItemDataChange))
end

function CopyVindicateView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self.OnBtnClick))
  self:AddButtonClickListener(self.ui.Btn_Reward, System.fn(self, self.OnBtnReward))
end

function CopyVindicateView:InitAwakerTableView()
  local sizeDelta = self.ui.UI_Chapter_Item_Vindicate.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self.awakerTableView = self:CreateTableview(self.ui.ScrollView_Awaker, function()
    return #CopyVindicateModel.Instance.stageList
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.UI_Chapter_Item_Vindicate)
    self:SetAwakerItem(cell.gameObject, CopyVindicateModel.Instance.stageList[index])
    return cell
  end, function()
    return w, h
  end)
  
  function self.awakerTableView.reloadFinishCallback()
    self:PlayEnterAnim()
  end
  
  self.awakerTableView.contentSizeAdjustment = Vector2(0, 46)
end

function CopyVindicateView:RefreshOnRendered()
  self:PlayEnterAnim()
end

function CopyVindicateView:PlayEnterAnim()
end

function CopyVindicateView:SetAwakerItem(gameObject, stageTid)
  local awakerTid = FreeTrialController.Instance:GetAwakerByStageId(stageTid)
  if not awakerTid then
    return
  end
  local stageCfg = CopyDataUtils.GetStageCfg(stageTid)
  local itemUI = self.awakerItemUIMap[gameObject]
  if not itemUI then
    itemUI = UI_Chapter_Item_VindicateResource(gameObject)
    self.awakerItemUIMap[gameObject] = itemUI
  end
  self.awakerItemStageTidMap[gameObject] = stageTid
  local isUnlock = CopyVindicateModel.Instance:IsStageUnlock(stageTid)
  itemUI.Image_Lock:SetActive(not isUnlock)
  self:SetText(itemUI.Text_Localization, LT.Text("Localized"))
  self:SetActive(itemUI.Group_Localization, SettingManager.Instance:IsTranslationProgressEnabled({stageTid = stageTid}))
  itemUI.Image_FirstPass:SetActive(CopyVindicateModel.Instance:IsStageFirstRewarded(stageTid))
  if CopyVindicateModel.Instance:IsStageFirstRewarded(stageTid) then
    self:SetImageSync(itemUI.Image_Awaker_Icon, PortraitUtils.GetAwakerTidMiniHead(awakerTid, stageCfg.FacialExpression))
  else
    self:SetImageSync(itemUI.Image_Awaker_Icon, PortraitUtils.GetAwakerTidMiniHead(awakerTid))
  end
  itemUI.Image_Select:SetActive(stageTid == CopyVindicateModel.Instance.selectStageTid)
  self:AddButtonClickListener(itemUI.Btn_Click, function()
    CopyVindicateModel.Instance:SetSelectStageTid(stageTid)
  end)
end

function CopyVindicateView:OnStageSelected(stageTid)
  for gameObj, tid in pairs(self.awakerItemStageTidMap) do
    local itemUI = self.awakerItemUIMap[gameObj]
    if itemUI then
      itemUI.Image_Select:SetActive(tid == stageTid)
    end
  end
  self:SetAwakerDetail()
  self:SetLockedState()
end

function CopyVindicateView:OnStageUnlocked(stageTid)
end

function CopyVindicateView:OnStageDataChange(stageTid)
  CopyVindicateModel.Instance:ResetStageList()
  if not self.awakerTableView then
    return
  end
  self.awakerTableView:ReloadData()
  self:SetLockedState()
  self:SetAwakerDetail()
end

function CopyVindicateView:OnItemDataChange()
  self:SetLockedState()
end

function CopyVindicateView:OnTaskData()
  if self.awakerTableView then
    self.awakerTableView:ReloadData()
  end
end

function CopyVindicateView:SetAwakerDetail()
  local stageTid = CopyVindicateModel.Instance.selectStageTid
  local stageCfg = CopyDataUtils.GetStageCfg(stageTid)
  local awakerTid = CopyVindicateModel.Instance:GetAwakerTidByStage(stageTid)
  if not self.awakerPortraitComp then
    local portraitAlign = CommonDefine.PortraitAlign.Center
    self.awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.Image_Awaker, awakerTid, nil, nil, portraitAlign))
  else
    self.awakerPortraitComp:ChangeAwakerTid(awakerTid)
  end
  local face = stageCfg.FacialExpression
  if face and CopyVindicateModel.Instance:IsStageFirstRewarded(stageTid) then
    self.awakerPortraitComp:ChangeFace(face)
  end
  self:SetImage(self.ui.Image_Career, AwakerDataUtils.GetAwakerSchoolIcon(awakerTid))
  local awakerCfg = AwakerDataUtils.GetAwakerConfig(awakerTid)
  self:SetText(self.ui.Text_AwakerName, LT.Text(awakerCfg.Name))
end

function CopyVindicateView:SetLockedState()
  local stageTid = CopyVindicateModel.Instance.selectStageTid
  local stageCfg = CopyDataUtils.GetStageCfg(stageTid)
  if not stageCfg then
    return
  end
  self:SetText(self.ui.Text_Stage_Title, LT.Text(stageCfg.Name))
  local isUnlocked = CopyVindicateModel.Instance:IsStageUnlock(stageTid)
  local isLocked = not isUnlocked
  local isActivityDiscount, itemTid, itemNum, origNum = CopyVindicateModel.Instance:GetUnlockInfo(stageTid)
  self.ui.Image_CostTip:SetActive(isActivityDiscount)
  self:SetImage(self.ui.Image_CostItem, ItemDataUtils.GetItemIcon(itemTid))
  self.ui.ScrollView_Desc:SetActive(isUnlocked)
  self.ui.Group_Cost:SetActive(not isUnlocked)
  self.ui.Image_Got:SetActive(CopyVindicateModel.Instance:IsStageFirstRewarded(stageTid))
  self:SetText(self.ui.Text_LockTip, self:GetLockedDesc(isActivityDiscount))
  local isConditionOk = CopyVindicateModel.Instance:IsStageConditionOk(stageTid)
  local isCanUnlock = isConditionOk or isActivityDiscount
  self.ui.Btn_Click:SetActive(isCanUnlock or not isLocked)
  self.ui.Group_Locked:SetActive(isLocked and not isCanUnlock)
  if isUnlocked then
    self:SetText(self.ui.Text_Desc, "")
    self:SetButtonText(self.ui.Btn_Click, LT.Text("Text_Enter_Plot"))
    self:SetButtonState(self.ui.Btn_Click, Z1ButtonState.Normal)
  else
    self:SetButtonState(self.ui.Btn_Click, isActivityDiscount and Z1ButtonState.High or Z1ButtonState.Normal)
    local ownNum = ItemDataUtils.GetItemNum(itemTid)
    self:SetText(self.ui.Text_CostCout, ItemNumUtils.GetStr(itemNum))
    self:SetTextColorType(self.ui.Text_CostCout, itemNum <= ownNum and CommonDefine.ColorType.Normal or CommonDefine.ColorType.Dark)
    self:SetText(self.ui.Text_OrigCost, ItemNumUtils.GetStr(origNum))
    self:SetButtonText(self.ui.Btn_Click, isActivityDiscount and LT.Text("Text_Discount_Unlock") or LT.Text("Text_Unlock"))
    self.ui.Text_OrigCost:SetActive(itemNum < origNum)
  end
end

function CopyVindicateView:GetLockedDesc(isDiscount)
  local stageTid = CopyVindicateModel.Instance.selectStageTid
  local isConditionOk = CopyVindicateModel.Instance:IsStageConditionOk(stageTid)
  local awakerTid = CopyVindicateModel.Instance:GetAwakerTidByStage(stageTid)
  local awakerName = AwakerDataUtils.GetAwakerName(awakerTid)
  local condPara = CopyVindicateModel.Instance:GetStageConditionParams(stageTid)
  if isDiscount then
    local str1 = LT.Textf("FavorabilityUnlockCondition_2", awakerName, condPara)
    local str2 = LT.Text("UnlockConditionExemption")
    return str1 .. str2
  end
  if not isConditionOk then
    local str1 = LT.Textf("FavorabilityUnlockCondition_1", awakerName, condPara)
    local str2 = LT.Textf("CurrentLevelFavorability_1", AwakerAffectDataUtils.GetAwakerLikeLv(awakerTid))
    return str1 .. str2
  else
    local str1 = LT.Textf("FavorabilityUnlockCondition_1", awakerName, condPara)
    local str2 = LT.Textf("CurrentLevelFavorability_2", AwakerAffectDataUtils.GetAwakerLikeLv(awakerTid))
    return str1 .. str2
  end
end

function CopyVindicateView:OnBtnClick()
  local stageTid = CopyVindicateModel.Instance.selectStageTid
  local isUnlocked = CopyVindicateModel.Instance:IsStageUnlock(stageTid)
  if not isUnlocked then
    local isActivityDiscount, _, itemNum, origNum = CopyVindicateModel.Instance:GetUnlockInfo(stageTid)
    local tipsId = isActivityDiscount and 20156 or 20157
    local tipsCfg = DT.TipsType[tipsId]
    local desc = tipsCfg.Desc
    if isActivityDiscount then
      desc = LT.Textf(desc, origNum, itemNum, itemNum)
    else
      desc = LT.Textf(desc, itemNum)
    end
    Alert.Show(tipsId, nil, function()
      self._unlockTime = TimerManager.totalTime
      CopyController.Instance:ReqUnlockStage(CopyVindicateModel.Instance.selectStageTid)
    end, nil, desc, nil, true)
  else
    WorldStageManager.Instance:CheckOpen(stageTid, function()
      StageExitPanelManager.Instance:PushWhenVindicateExit(stageTid)
    end)
  end
end

function CopyVindicateView:OnBtnReward()
  local stageTid = CopyVindicateModel.Instance.selectStageTid
  local rewardList = CopyVindicateModel.Instance:GetStageFirstReward(stageTid)
  if rewardList and #rewardList > 0 then
    UIManager.Instance:Reopen(Urls.CopyVindicateRewardView, rewardList)
  end
end

return CopyVindicateView
