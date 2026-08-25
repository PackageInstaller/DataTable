local AWAKER_FAVOR_ITEM_TID = DT.GetConstant("AwakerFavorItemTid")
local ASSIST_FAVOR_IMPROVE = DT.GetConstant("AwakerFavorabilityImprove")
local BASE_MULTI_NUM = 1
local TextMeshProUGUI = CS.TMPro.TextMeshProUGUI
local UICompAwakerFavor, Super = System.NewComponent("UICompAwakerFavor")

function UICompAwakerFavor:ctor(uiNode, favorData, isPvp, extraParam)
  Super.ctor(self)
  self.ui = UI_Common_Awaker_FavorResource(uiNode)
  self.favorData = favorData
  self.isPvp = isPvp
  self.favorScore = not isPvp and favorData or nil
  if extraParam then
    self.isShowDetailBtn = extraParam.isShowDetailBtn
    self.stageTid = extraParam.stageTid
    self.isFristFinish = extraParam.isFristFinish
  end
  self.contentTmpComp = self.ui.Text_Name:GetComponent(typeof(TextMeshProUGUI))
end

function UICompAwakerFavor:OnBind(binder)
  self.binder = binder
  self.ui.Text_Awaker_Favor:SetActive(false)
  self.ui.Image_Promote:SetActive(false)
  local favorScore = self.favorScore
  local settleData = not self.isPvp and DataCenter.copiesData and DataCenter.copiesData.copiesSettleData or nil
  local hasData
  if self.isPvp then
    hasData = self.favorData ~= nil and nil ~= table.next(self.favorData)
  else
    hasData = nil ~= favorScore and nil ~= table.next(favorScore)
  end
  self.ui.uiNode:SetActive(hasData)
  if hasData and PvPSettleDataUtils.GetSettleReason() ~= CommonDefine.PvpSettleReason.GiveUpPrepare then
    local awakerList
    if self.isPvp then
      awakerList = PvPSettleDataUtils.GetStatsData()[DataCenter.playerData.DRole.uid].awakerList
      table.reverse(awakerList)
    else
      awakerList = CopyAwakerDataUtils.GetBattleAwakerTidList(true)
      if settleData and settleData.myAwakers and #settleData.myAwakers > 0 then
        awakerList = settleData.myAwakers
      end
    end
    self.binder:BindToCircularListView(self.ui.ScrollView_Awaker, function()
      return awakerList
    end, function(_, go, index)
      local itemUi = UI_Common_Item_WuPin_Type2Resource(go)
      local awakerTid
      if self.isPvp then
        local statsData = awakerList[index]
        awakerTid = PvpCollectCfgUtils.GetAwakerTidByCollectTid(statsData.awakers.tid)
      else
        awakerTid = awakerList[index]
      end
      local icon = AwakerDataUtils.GetLittleIcon(awakerTid)
      self.binder:SetImage(itemUi.Icon_Common, icon)
      self.uiTweenList = {}
      self:_OnBindAwakerLike(itemUi, awakerTid, index)
    end)
  end
  self.ui.Btn_Favor_Detail:SetActive(nil ~= favorScore and nil ~= table.next(favorScore))
  if favorScore and table.next(favorScore) then
    local awakerTids = self:_GetAwakerTidsInOrder()
    binder:BindButtonClick(self.ui.Btn_Favor_Detail, function()
      UIManager.Instance:Reopen(Urls.AwakerFavorSourceShowView, {
        favorScore = favorScore,
        awakerTids = awakerTids,
        lockNode = self.ui.Node_Detail_Tips
      })
    end)
  end
end

function UICompAwakerFavor:_GetAwakerTidsInOrder()
  local tids = {}
  local settleData = DataCenter.copiesData and DataCenter.copiesData.copiesSettleData
  local awakerList = CopyAwakerDataUtils.GetBattleAwakerTidList(true)
  if settleData and settleData.myAwakers and #settleData.myAwakers > 0 then
    awakerList = settleData.myAwakers
  end
  for _, tid in ipairs(awakerList or {}) do
    if self.favorScore and self.favorScore[tid] then
      table.insert(tids, tid)
    end
  end
  return tids
end

function UICompAwakerFavor:_GetMaxLikeLevelAwakerTidList()
  local rst = {}
  for i = 1, 4 do
    local awakerData = CopySettleModel.Instance:Get_SettleAwakerDatasByIndex(i)
    if awakerData and AwakerDataUtils.IsMaxLikeLevel(awakerData.tid) then
      table.insert(rst, awakerData.tid)
    end
  end
  return rst
end

function UICompAwakerFavor:_AddAwakerProperties(showDatas, index)
  local awakerData = CopySettleModel.Instance:Get_SettleAwakerDatasByIndex(index)
  if awakerData then
    local property = CopySettleModel.Instance:GetAwakerPropertyByType(awakerData.tid, bc.RoleProperty.gain_like_level_fix_per)
    if property > 0 then
      table.insert(showDatas, {
        title = LT.Textf("LikeBounusTips", AwakerDataUtils.GetAwakerName(awakerData.tid)),
        desc = math.floor(property) .. "%"
      })
    end
  end
end

function UICompAwakerFavor:_AddShowProperties(showDatas, title, multiNum, onlyNum)
  if multiNum <= BASE_MULTI_NUM then
    return showDatas
  end
  table.insert(showDatas, {
    title = title,
    desc = onlyNum and multiNum or "*" .. multiNum
  })
  return showDatas
end

function UICompAwakerFavor:_GetFirstMulti(stageCfg)
  return self.isFristFinish and stageCfg.FirstTimeNormalRewardMultiple or BASE_MULTI_NUM
end

function UICompAwakerFavor:_GetAssistMulti()
  local rst = BASE_MULTI_NUM
  if not self.isPvp then
    local awakerMap = CopyAwakerDataUtils.Get_battleAwakerMap()
    for _, awaker in pairs(awakerMap) do
      if awaker.isAssist then
        rst = rst + ASSIST_FAVOR_IMPROVE
        break
      end
    end
  end
  return rst
end

function UICompAwakerFavor:_GetActivityMulti()
  local rst = BASE_MULTI_NUM
  local activityType = ActivityDefine.ActivityType.HomologyDoubleActivity
  local activityTid = ActivityDataUtils.GetAtitivtyTidByType(activityType)
  if not activityTid then
    return rst
  end
  local activityCfg = DT.Activity[activityTid]
  if activityCfg and ActivityManager.Instance:IsActivityOpenByType(activityType) then
    local improveVal = activityCfg.ActivityPara1 and activityCfg.ActivityPara1[1] or 0
    rst = rst + improveVal
  end
  return rst
end

function UICompAwakerFavor:_GetResonanceMulti(stageCfg)
  local rst = BASE_MULTI_NUM
  local stageGroupId = stageCfg.BelongGroup
  local resonanceId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(stageGroupId)
  if not resonanceId then
    return rst
  end
  local resonanceCfg = DT.Resonance[resonanceId]
  if not resonanceCfg then
    return rst
  end
  local resonanceLv = ResonanceDataUtils.GetResonanceLevel(resonanceId)
  local resonanceDataList = resonanceCfg.data_list or {}
  for i = 1, resonanceLv do
    local cfg = resonanceDataList[i]
    if not cfg then
    else
      for itemTid, improveVal in pairs(cfg.ItemDropAddition or {}) do
        if itemTid == AWAKER_FAVOR_ITEM_TID then
          rst = rst + improveVal
          break
        end
      end
    end
  end
  return rst
end

function UICompAwakerFavor:_OnBindAwakerLike(itemUi, awakerTid, index)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData then
    self.binder:SetActive(itemUi.Group_Homology, false)
    return
  end
  self.binder:SetActive(itemUi.Group_Homology, true)
  self.binder:SetText(itemUi.Text_Homology_Lv, LT.Text(awakerData.likeLevel))
  local imgProgress = itemUi.Image_Homology:GetComponent(typeof(CS.UnityEngine.UI.Image))
  local isMaxLikeLevel = AwakerFavorabilityCfgUtils.IsMaxAwakerLikeLevel(awakerData.tid, awakerData.likeLevel)
  if isMaxLikeLevel then
    self.binder:SetText(itemUi.Text_Article_Number, string.format("+%s", 0))
    imgProgress.fillAmount = 1
  elseif self.isPvp then
    local favorNum = self:_GetPVPPrizeNum()
    local likeDelta = math.max(favorNum, 0)
    self.binder:SetText(itemUi.Text_Article_Number, string.format("+%s", likeDelta))
    local expLimit = AwakerDataUtils.GetAwakerLikeExpRequire(awakerData.tid)
    imgProgress.fillAmount = awakerData.like / expLimit
  else
    local scoreData = self.favorScore and self.favorScore[awakerTid]
    local likeDelta = scoreData and scoreData.actualLike or 0
    likeDelta = math.max(likeDelta, 0)
    self.binder:SetText(itemUi.Text_Article_Number, string.format("+%s", likeDelta))
    local expLimit = AwakerDataUtils.GetAwakerLikeExpRequire(awakerData.tid)
    imgProgress.fillAmount = awakerData.like / expLimit
  end
  if itemUi.Image_AwakerFavor_Max then
    local showFavor = FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(awakerTid, awakerData)
    self.binder:SetActive(itemUi.Image_AwakerFavor_Max, showFavor)
  end
end

function UICompAwakerFavor:_GetPVPPrizeNum()
  local num = 0
  for _, likeItem in pairs(self.favorData or {}) do
    num = num + (likeItem.num or 0)
  end
  return num
end

function UICompAwakerFavor:OnUnbind()
  if self.uiTweenList then
    for _, uiTween in pairs(self.uiTweenList) do
      if uiTween then
        uiTween:Kill(true)
        uiTween = nil
      end
    end
    self.uiTweenList = nil
  end
end

return UICompAwakerFavor
