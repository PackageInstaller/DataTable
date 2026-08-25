local ActivityTurntableComp, Super = System.NewClass("ActivityTurntableComp", ActivityMagicStoryComp)
local UIAnimationController = CS.Z1Client.UIAnimationController

function ActivityTurntableComp:ctor(res, activityTid, model, params)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.activtyDefine = ActivityDefine.ActivityCompClsInfo[self.activityConfig.ActivityType]
  self.ui = UI_Events_Panel_ClotherLotteryResource(res)
  self.hasFinishedActivity = ActivityManager.Instance:IsActivityFinishedByTid(self.activityTid)
  self.audioPlay = true
  if params then
    self.audioPlay = params.audioPlay
  end
  self.prizeInfoList = {}
  self.currentTurntableTid = self:GetTurntableTid()
end

function ActivityTurntableComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:ReqTurntableData()
  self:_BindBgImage()
  self:_BindActivityTimer()
  self:_BindPortraitComp()
  self:_SetActivityPlot()
  self:BindCoin()
  self:BindFirstPrize()
  self:BindOtherPrize()
  self:BindLotteryBtn()
  self:BindJumpBtn()
  self.binder:BindButtonClick(self.ui.Button_Rate, System.fn(self, self.OnClickRate))
end

function ActivityTurntableComp:ReqTurntableData()
  TurntableDataUtils.ReqServerData(self:GetTurntableTid())
end

function ActivityTurntableComp:OnClickLottery()
  local costId = self:GetCostId()
  local ownNum = ItemDataUtils.GetItemNum(costId)
  if ownNum < self:GetCostPrice() then
    Alert.ShowWithParams(20400, {
      ItemDataUtils.GetItemName(costId)
    }, nil, function()
      TurntableDataUtils.ShowSkinTicketBuyPanel()
    end)
    return
  end
  print("OnClickLottery")
  local turableTid = self:GetTurntableTid()
  UIManager.Instance:Reopen(Urls.SummonSkinResultPanel, function()
    TurntableDataUtils.ReqDrawReward(turableTid)
  end)
end

function ActivityTurntableComp:OnClickRate()
  print("OnClickRate")
  TurntableDataUtils.ShowRatePanel(self.currentTurntableTid)
end

function ActivityTurntableComp:OnPreviewSkin()
  print("OnPreviewSkin")
  self:OnClickSkin()
end

function ActivityTurntableComp:OnClickSkin()
  local previewSkinTid = AwakerSkinUtils.UnifyToSkinTid(self:GetSkinTid())
  UIManager.Instance:Reopen(Urls.AwakerPaintingView, nil, nil, previewSkinTid)
end

function ActivityTurntableComp:BindLotteryBtn(index)
  self.binder:BindButtonClick(self.ui.Btn_Lottery, System.fn(self, self.OnClickLottery))
  self.binder:SetText(self.ui.Text_C_Lottery, LT.Text("DrawOneStr"))
  self.binder:SetImage(self.ui.Image_Cost_Icon, ItemDataUtils.GetIcon(self:GetCostId()))
  self.binder:SetText(self.ui.Text_Lottery_Null, LT.Text("DrawEmptyStr"))
  self.binder:BindToText(self.ui.Text_ItemCount, function()
    local costId = self:GetCostId()
    local ownNum = ItemDataUtils.GetItemNum(costId)
    if ownNum < self:GetCostPrice() then
      do return string.color, (ItemNumUtils.GetStr(self:GetCostPrice())) end
      return string.color, ItemNumUtils.GetStr(self:GetCostPrice()), "#9D0006", self:GetCostPrice()
    else
      do return ItemNumUtils.GetStr, self:GetCostPrice() end
      return ItemNumUtils.GetStr, self:GetCostPrice()
    end
  end)
  self.binder:BindToVisible(self.ui.Group_Cost, function()
    return self:GetCostPrice() > 0
  end)
  self.binder:BindToVisible(self.ui.Text_Free, function()
    return self:GetCostPrice() < 1
  end)
  self.binder:BindToVisible(self.ui.Btn_Lottery, function()
    return not TurntableDataUtils.IsPoolEmpty(self.currentTurntableTid)
  end)
  self.binder:BindToVisible(self.ui.Btn_Lottery_Null, function()
    do return TurntableDataUtils.IsPoolEmpty end
    return TurntableDataUtils.IsPoolEmpty, self.currentTurntableTid
  end)
end

function ActivityTurntableComp:_BindPortraitComp()
  if not (self.activityTid and self.binder and self.ui) or not self.ui.Image_Awaker then
    return
  end
  local skinTid = self:GetSkinTid()
  local config = ActivityDataUtils.GetConfig(self.activityTid)
  local awakerTid = config and config.ShowAwaker
  if not skinTid and not awakerTid then
    return
  end
  if not self.awakerPortraitComp then
    local portraitAlign = CommonDefine.PortraitAlign.Center
    if skinTid then
      local skinResNum = AwakerSkinUtils.GetSkinResNum(skinTid)
      local isDynamicSkin = AwakerSkinUtils.IsDynamicSkinRes(skinResNum)
      local extParams
      local awakerNode = self.ui.Image_Awaker
      if isDynamicSkin then
        extParams = {animationMode = true}
        awakerNode = self.ui.Image_AnimAwaker
      end
      self.awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(awakerNode, nil, skinResNum, nil, portraitAlign, extParams))
    else
      self.awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.Image_Awaker, awakerTid, nil, nil, portraitAlign))
    end
  else
    self.awakerPortraitComp:ChangeAwakerTid(awakerTid)
  end
  self.binder:BindEvent(EventMgr.Instance.OnBeforeCloseActivityPanel, System.fn(self, self.OnBeforeCloseActivity))
end

function ActivityTurntableComp:OnBeforeCloseActivity()
  if self.awakerPortraitComp and self.awakerPortraitComp.binder then
    self.awakerPortraitComp.binder:teardown()
    self.awakerPortraitComp = nil
  end
end

function ActivityTurntableComp:BindJumpBtn()
  self.binder:BindButtonClick(self.ui.UI_Summon_Btn_Jump, System.fn(self, self.OnPreviewSkin))
  local jumpBtnUI = UI_Summon_Btn_JumpResource(self.ui.UI_Summon_Btn_Jump)
  self.binder:SetText(jumpBtnUI.Text_Name, AwakerSkinUtils.GetSkinName(self:GetSkinTid()))
end

function ActivityTurntableComp:BindCoin()
  local showMoneyGroup = {}
  local costId = self:GetCostId()
  table.insert(showMoneyGroup, costId)
  CurrencyDefine.AddBuyFunc(costId, TurntableDataUtils.ShowSkinTicketBuyPanel)
  table.insert(showMoneyGroup, cd.CurrencyType.PayMoney)
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.UI_Common_Item_Coin_Group, showMoneyGroup))
end

function ActivityTurntableComp:BindFirstPrize()
  local skinTid, dropItemId = self:GetSkinTid()
  self.binder:BindComponent(ActivitySkinItem(self.ui.UI_Awaker_Item_Skin, skinTid))
  self.binder:BindToVisible(self.ui.Group_Get, function()
    do return TurntableDataUtils.IsGot, self.currentTurntableTid end
    return TurntableDataUtils.IsGot, self.currentTurntableTid, dropItemId
  end)
  self.binder:BindToText(self.ui.Text_FirstPrizeInfo, function()
    do return LT.Text end
    return LT.Text, "PrizeNum1"
  end)
  self.binder:BindToText(self.ui.Text_C_Tip, function()
    local isGot = TurntableDataUtils.IsGot(self.currentTurntableTid, dropItemId)
    if isGot then
      do return LT.Text end
      return LT.Text, "SkinTurntableActivityDesc3", nil, nil, nil, nil, nil, nil, nil, nil
    end
    local data = TurntableDataUtils.GetTurntableData(self.currentTurntableTid)
    local turnNum = data.turnNum or 0
    local dropCfg = TurntableDataUtils.GetDropCfgItems(self.currentTurntableTid, dropItemId)
    local startDropAfter = dropCfg.StartDropAfter or 0
    if turnNum < startDropAfter - 1 then
      do return LT.Textf, "SkinTurntableActivityDesc1" end
      return LT.Textf, "SkinTurntableActivityDesc1", startDropAfter - turnNum - 1, nil, nil, nil
    end
    local curRate = TurntableDataUtils.GetDropItemCurRate(self.currentTurntableTid, dropItemId)
    do return LT.Textf, "SkinTurntableActivityDesc2", string.format("%.2f%%", curRate * 100) end
    return LT.Textf, "SkinTurntableActivityDesc2", string.format("%.2f%%", curRate * 100)
  end)
  self.binder:BindToVisible(self.ui.Text_C_Tip, function()
    local isGot = TurntableDataUtils.IsGot(self.currentTurntableTid, dropItemId)
    if isGot then
      return true
    end
    local data = TurntableDataUtils.GetTurntableData(self.currentTurntableTid)
    local turnNum = data.turnNum or 0
    local dropCfg = TurntableDataUtils.GetDropCfgItems(self.currentTurntableTid, dropItemId)
    local startDropAfter = dropCfg.StartDropAfter or 0
    if turnNum < startDropAfter - 1 then
      return true
    end
    local curRate = TurntableDataUtils.GetDropItemCurRate(self.currentTurntableTid, dropItemId)
    return curRate >= 0.5
  end)
end

function ActivityTurntableComp:BindOtherPrize()
  self:InitPrizeInfo()
  self:CreatePrizeTableView()
  self.binder:BindToRaw(function()
    self.tableView:ReloadData()
  end, function()
    return #self.prizeInfoList
  end)
end

function ActivityTurntableComp:InitPrizeInfo()
  if table.next(self.prizeInfoList) then
    return
  end
  local turableTid = self:GetTurntableTid()
  local turntableCfg = DT.Turntable[turableTid]
  local dropMap = self:GetDropMap()
  for i = 2, 20 do
    local itemRare = turntableCfg["ItemRare" .. i]
    if not itemRare then
      break
    end
    local rewardList = {}
    for _, dropSubId in ipairs(itemRare or {}) do
      local dropCfg = dropMap[dropSubId]
      table.insert(rewardList, dropCfg)
    end
    table.insert(self.prizeInfoList, rewardList)
  end
end

function ActivityTurntableComp:CreatePrizeTableView()
  if self.tableView then
    return
  end
  local baseGameObj = self.ui.UI_Events_Item_ClotherLotteryGroup
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW = sizeDelta.x
  local itemComps = {}
  self.tableView = UIBasePanel.CreateTableview(self, self.ui.PrizeView, function()
    return #self.prizeInfoList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local itemData = self.prizeInfoList[idx]
    itemComps[gameObj] = self.binder:BindComponent(ActivityTurntableItem(gameObj, self.currentTurntableTid, idx, itemData))
    return cell
  end, function(_, index)
    local itemInfo = self.prizeInfoList[index]
    local itemCount = #itemInfo
    local row = math.ceil(itemCount / 3)
    return itemW, 46 + row * 96 + (row - 1) * 12
  end, function()
    itemComps = nil
  end)
end

function ActivityTurntableComp:_BindBgImage()
  local bgCfg = ActivityDataUtils.GetBgImage(self.activityTid)
  if not string.isempty(bgCfg) then
    self.binder:SetImage(self.ui.Image_Bg, bgCfg)
  end
end

function ActivityTurntableComp:GetTurntableTid()
  assert(self.activityConfig.ActivityPara1[1] and DT.Turntable[self.activityConfig.ActivityPara1[1]], string.format("活动%s转盘id ActivityPara1 = %s配置错误:", self.activityTid, self.activityConfig.ActivityPara1[1]))
  return self.activityConfig.ActivityPara1[1]
end

function ActivityTurntableComp:GetSkinTid()
  local turableTid = self:GetTurntableTid()
  local dropId = DT.Turntable[turableTid].DropIds[1]
  local dropCfg = DT.Drop[dropId]
  local firstDropInfo = dropCfg.data_list[1]
  local skinTid = firstDropInfo.DropItem
  assert(skinTid, string.format("活动%s转盘id %s没有配置皮肤奖励:", self.activityTid, turableTid or "nil"))
  return skinTid, firstDropInfo.DropItemId
end

function ActivityTurntableComp:GetDropMap()
  do return TurntableDataUtils.GetDropMap end
  return TurntableDataUtils.GetDropMap, self.currentTurntableTid
end

function ActivityTurntableComp:GetCostId()
  do return TurntableDataUtils.GetCostId end
  return TurntableDataUtils.GetCostId, self.currentTurntableTid
end

function ActivityTurntableComp:GetCostPrice()
  do return TurntableDataUtils.GetCostPrice end
  return TurntableDataUtils.GetCostPrice, self.currentTurntableTid
end

function ActivityTurntableComp:IsLotteryEmpty()
  return false
end

function ActivityTurntableComp:_TimerFixedUpdate()
  local finishTime = self.activityData.finishTime
  local endTime = self.activityData.endTime
  local now = TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime())
  local finishTimeCountdown = (finishTime or 0) - now
  local timeText = ""
  if finishTimeCountdown > 0 then
    timeText = TimeUtils.ActivityCountDownFormat(finishTimeCountdown)
  else
    local endTimeCountdown = (endTime or 0) - now
    if endTimeCountdown >= 0 then
      if finishTime and finishTime > 0 then
        timeText = TimeUtils.ActivityCountDownFormat(endTimeCountdown)
      else
        timeText = TimeUtils.ActivityCountDownFormat(endTimeCountdown)
      end
    else
      timeText = LT.Text("ActivityTimeExpired")
      self:_ClearTimer()
    end
  end
  self.binder:SetText(self.ui.Text_Time, timeText)
end

function ActivityTurntableComp:OnOpenAnim(callback)
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(self.audioPlay)
  if not self.audioPlay then
    self.audioPlay = true
  end
  if self.activtyDefine.openAnim then
    self.uiAnimController:PlayState(self.activtyDefine.openAnim, callback)
  elseif self.activtyDefine.openTimeline then
    self.ui.uiNode:SetActive(true)
    self:PlayTimeline(self.activtyDefine.openTimeline)
  else
    self.ui.uiNode:SetActive(true)
    if callback then
      callback()
    end
  end
end

function ActivityTurntableComp:OnCloseAnim(callback)
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(false)
  if self.activtyDefine.closeAnim then
    self.uiAnimController:PlayState(self.activtyDefine.closeAnim, callback)
  elseif self.activtyDefine.endTimeline then
    self:PlayTimeline(self.activtyDefine.endTimeline)
  else
    self.ui.uiNode:SetActive(false)
    if callback then
      callback()
    end
  end
end

function ActivityTurntableComp:PlayTimeline(timelinePath)
  self:ClearTimeline()
  self.player = self.ui.uiNode
  self.timelinePlayer = PortraitTimelinePlayer(self.player)
  local timelineConfig = TimelineConfig()
  timelineConfig.assetPath = timelinePath
  self.timelinePlayer:Play(timelineConfig)
end

function ActivityTurntableComp:ClearTimeline()
  if self.timelinePlayer then
    self.timelinePlayer:Stop()
    self.timelinePlayer:Dispose()
    self.timelinePlayer = nil
  end
end

function ActivityTurntableComp:OnUnbind()
  Super.OnUnbind(self)
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(false)
  self:ClearTimeline()
end

return ActivityTurntableComp
