local _SetWidth = CS.Framework.TransformUtil.SetWidth
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local T_HorizontalLayoutGroup = typeof(CS.UnityEngine.UI.HorizontalLayoutGroup)
local ActivityStageGroupPanel, Super = System.NewClass("ActivityStageGroupPanel", UIBasePanel)
ActivityStageGroupPanel.uiResCls = UI_Events_Panel_Lake_CityResource
local ActivityType = ActivityDefine.ActivityType

function ActivityStageGroupPanel:ctor(viewData)
  Super.ctor(self)
  self._viewData = viewData or {}
  self.activityTid = viewData.activityTid
  self.gotoStageGroupId = viewData.gotoStageGroupId
  self.title = viewData.title
  self.leftTime = viewData.leftTime
  self.desc = viewData.desc
  self.resonanceGroupId = viewData.resonanceGroupId
  self.activityType = ActivityDataUtils.GetType(self.activityTid)
  self.stageGroupList = viewData.stageGroupList or ActivityCfgUtils.GetStageGroupList(self.activityTid)
  self.featureId = ""
  self.levelGoList = {}
  if not ActivityDefine.StageGroupDefine[self.activityType] then
    self.activityType = ActivityType.Thais
  end
end

function ActivityStageGroupPanel:_GetUIResCls()
  if self.activityType and ActivityDefine.StageGroupDefine[self.activityType] then
    self.uiResCls = ActivityDefine.StageGroupDefine[self.activityType].PanelResCls
  end
  return self.uiResCls
end

function ActivityStageGroupPanel:OnBind(binder)
  self.binder = binder
  local uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  uiAnimController:PlayState("UI_Event_Panel_Activity_TwentyFour_Open", function()
    local featureId = ActivityDataUtils.GetActivityFeatureByType(self.activityType)
    AvgTutorialManager.Instance:PlayTutorialAvgByFeatureId(featureId)
  end)
  self:BindCoinList()
  self:BindStageGroupList(self.stageGroupList)
  self:_BindActivityTimer()
  self.binder:BindTimer(0.01, 0, nil, function()
    self:MoveScrollToOpeningStageGroup()
  end)
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:Close()
  end))
  if self.ui.Btn_Resonance then
    binder:BindToVisible(self.ui.Btn_Resonance, function()
      return self.resonanceGroupId ~= nil
    end)
  end
  if self.resonanceGroupId then
    self:BindResonanceGroup(self.resonanceGroupId)
  end
  if self.title then
    binder:SetText(self.ui.Text_C_Title, self.title)
  end
  if self.desc then
    binder:SetText(self.ui.Text_C_Describe, self.desc)
  end
end

function ActivityStageGroupPanel:OnUnbind()
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
end

function ActivityStageGroupPanel:_BindActivityTimer()
  if not (self.activityTid and self.binder and self.ui) or not self.ui.Text_Time then
    self.ui.Text_Time:SetActive(false)
    return
  end
  local timeType = ActivityDataUtils.GetTimeType(self.activityTid)
  if timeType == ActivityDefine.ActivityTimeType.Permanent then
    self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimePermanent"))
    return
  end
  self:_ClearTimer()
  self:_TimerFixedUpdate(self._viewData.finishTime, self._viewData.endTime)
  local now = TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime())
  if not self._viewData.endTime or now > self._viewData.endTime then
    self.ui.Text_Time:SetActive(false)
    return
  end
  self.activityTimer = self.binder:BindTimer(1, -1, System.bind(self._TimerFixedUpdate, self, self._viewData.finishTime, self._viewData.endTime))
end

function ActivityStageGroupPanel:_TimerFixedUpdate(finishTime, endTime)
  local now = TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime())
  local finishTimeCountdown = (finishTime or 0) - now
  local timeText = ""
  if finishTimeCountdown > 0 then
    timeText = TimeUtils.ActivityCountDownFormat(finishTimeCountdown)
  else
    local endTimeCountdown = (endTime or 0) - now
    if endTimeCountdown >= 0 then
      if finishTime and finishTime > 0 then
        timeText = TimeUtils.ActivityExchangeCountDownFormat(endTimeCountdown)
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

function ActivityStageGroupPanel:_ClearTimer()
  if self.activityTimer then
    TimerManager.Instance:StopTimer(self.activityTimer)
    self.activityTimer = nil
  end
end

function ActivityStageGroupPanel:BindCoinList()
  if not self.ui.Group_Coin then
    return
  end
  self.ui.Group_Coin:SetActive(true)
  local currencyListKey = string.format("ChallengeCurrencies_%s", self.activityType)
  local coinList = DT.GetOriginalConstant(currencyListKey)
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, coinList))
end

function ActivityStageGroupPanel:BindStageGroupList(stageGroupList)
  local UIResCfg = ActivityDefine.StageGroupDefine[self.activityType]
  local doubleGroupList = {}
  for i = 1, #stageGroupList, UIResCfg.StageGroupDiffPosNum do
    local childGroupList = {}
    for child_idx = i, i + UIResCfg.StageGroupDiffPosNum - 1 do
      table.insert(childGroupList, stageGroupList[child_idx])
    end
    table.insert(doubleGroupList, childGroupList)
  end
  local scroll_transform = self.ui.ScrollView.transform
  local ctx_transform = self.ui.Content.transform
  local cellObj = self.ui[UIResCfg.StageGroupCellObjName]
  local itemGoList = {}
  local itemGo
  for index = 1, #doubleGroupList do
    if 1 == index then
      itemGo = cellObj
      itemGo.transform.parent = ctx_transform
      itemGo:SetActive(true)
    else
      itemGo = Instantiate(cellObj, ctx_transform)
    end
    itemGoList[index] = itemGo
  end
  for index = 1, #doubleGroupList do
    itemGo = itemGoList[index]
    self:BindGroupsItem(self.binder, itemGo, index, doubleGroupList[index], UIResCfg)
    if self.activityType == ActivityType.MagicStoryActivityReproduce then
      for i = 1, UIResCfg.StageGroupDiffPosNum do
        local groupTid = doubleGroupList[index][i]
        local tf = itemGo.transform:GetChild(i - 1)
        local obj = tf.gameObject
        if obj then
          obj:SetActive(false)
          if groupTid then
            table.insert(self.levelGoList, obj)
          end
        end
      end
    end
  end
  local layoutGroup = self.ui.Content:GetComponent(T_HorizontalLayoutGroup)
  local scrollViewSize = scroll_transform.sizeDelta
  local cellSize = cellObj.transform.sizeDelta
  local width = cellSize.x
  local contentWidth = width * #doubleGroupList + layoutGroup.padding.left + layoutGroup.padding.right * 2
  _SetWidth(ctx_transform, contentWidth)
  Logger.Debug("[ac] scrollViewSize=%s, contentWidth=%s, judge=%s", scrollViewSize.x, contentWidth, contentWidth > scrollViewSize.x)
  if contentWidth > scrollViewSize.x then
    local scrollRect = scroll_transform:GetComponent(T_ScrollRect)
    scrollRect.horizontal = true
  end
  if self.activityType == ActivityType.MagicStoryActivityReproduce then
    local playAnimIdx = 1
    self.timer = self.binder:BindTimer(0.05, #self.levelGoList, function()
      local levelGo = self.levelGoList[playAnimIdx]
      if levelGo then
        local uiAnimController = levelGo:GetComponent(typeof(CS.Z1Client.UIAnimationController))
        levelGo.gameObject:SetActive(true)
        uiAnimController:PlayState("UI_Events_Item_Lily_Open")
        playAnimIdx = playAnimIdx + 1
      end
    end, function()
      if self.timer then
        self.binder:StopTimer(self.timer)
        self.timer = nil
      end
    end)
  end
end

function ActivityStageGroupPanel:MoveScrollToOpeningStageGroup()
  local define = ActivityDefine.StageGroupDefine[self.activityType]
  if not define or not define.ScrollToOpeningStageGroup then
    return
  end
  if not self._firstOpenedStageItem or not self._firstOpenedStageItem.ui.uiNode then
    return
  end
  local centerObj = self._firstOpenedStageItem.ui.uiNode
  local centerObjPos = centerObj.transform:TransformPoint(CS.UnityEngine.Vector3.zero)
  local centerObjPos2Content = self.ui.Content.transform:InverseTransformPoint(centerObjPos)
  local scrollRect = self.ui.ScrollView:GetComponent(T_ScrollRect)
  local scrollViewWidth = scrollRect.viewport.rect.width
  local contentWidth = self.ui.Content.transform.rect.width
  local targetPosX = centerObjPos2Content.x - scrollViewWidth / 2
  local limitPosX = contentWidth - scrollViewWidth
  self.ui.Content.transform.anchoredPosition = CS.UnityEngine.Vector2(-math.min(targetPosX, limitPosX), 0)
end

function ActivityStageGroupPanel:BindGroupsItem(cBinder, itemGo, index, childGroupList, uiResCfg)
  local groupUiNodeName = uiResCfg.StageGroupChildUINodeName
  local ui = uiResCfg.StageGroupUIResCls(itemGo)
  for idx, groupTid in ipairs(childGroupList) do
    local obj = ui[groupUiNodeName .. idx]
    if obj and groupTid then
      local stageNum = index * 2 + (idx - 2)
      local groupItem = cBinder:BindComponent(ActivityStageGroupItem(obj, uiResCfg.StageGroupChildUIResCls, stageNum, groupTid, self.activityTid, ActivityDefine.StageGroupDefine[self.activityType], function(stageGroupId)
        self:OpenStageGroup(stageGroupId)
      end))
      if groupItem and groupItem.IsStageGroupOpen and groupItem:IsStageGroupOpen() and not self._firstOpenedStageItem then
        self._firstOpenedStageItem = groupItem
      end
    end
  end
  for i = #childGroupList + 1, uiResCfg.StageGroupDiffPosNum do
    local obj = ui[groupUiNodeName .. i]
    obj:SetActive(false)
  end
end

function ActivityStageGroupPanel:OpenStageGroup(stageGroupId)
  local activityCfg = ActivityDefine.StageGroupDefine[self.activityType]
  CopyDataUtils.PrepareActivityChallengeStageData(stageGroupId, function()
    UIManager.Instance:Reopen(Urls.ActivityChallengePanel, stageGroupId, self.activityTid, nil, activityCfg)
  end)
end

function ActivityStageGroupPanel:BindResonanceGroup(resonanceGroupId)
  if not resonanceGroupId then
    return
  end
  self.binder:BindComponent(ResonanceGroupComp(resonanceGroupId, self.ui.Btn_Resonance, self.ui.Text_Progress, nil, self.ui.Red_Resonance, self.activityTid, self, true))
end

return ActivityStageGroupPanel
