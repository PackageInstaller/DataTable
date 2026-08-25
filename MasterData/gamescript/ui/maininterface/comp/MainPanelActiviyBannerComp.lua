local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local TIMER_DURATION = DT.GetConstant("ActivityBannerShowTime")
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local MainPanelActiviyBannerComp, Super = System.NewComponent("MainPanelActiviyBannerComp")

function MainPanelActiviyBannerComp:ctor(uiNode, mainPanel)
  Super.ctor(self)
  self.ui = UI_Main_Panel_1Resource(uiNode)
  self.mainPanel = mainPanel
  self.dotObjList = {}
end

function MainPanelActiviyBannerComp:InitViewData()
  self.oriBannerList = self:_GetOriBannerList()
  self.curBannerIdx = 1
end

function MainPanelActiviyBannerComp:Get_curBannerIdx(numVal)
  return self.curBannerIdx
end

function MainPanelActiviyBannerComp:Set_curBannerIdx(numVal)
  if self.curBannerIdx == numVal then
    return
  end
  self.curBannerIdx = numVal
  self:_RefreshView()
end

function MainPanelActiviyBannerComp:_InitBannerGroupGroupView()
  local cellRT = self.ui.UI_Main_Banner_Item:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.bannerGroupView = self:CreateTableview(self.ui.ScrollView_Advertise, function()
    if not self.oriBannerList then
      return 0
    end
    return #self.oriBannerList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Main_Banner_Item)
    self:_AddBannerItemComp(cell.gameObject, index)
    return cell
  end, function()
    return width, height
  end)
  self.bannerGroupView.alignedOnStopMoving = true
  
  function self.bannerGroupView.onScrollValueChanged()
    local curIndex = self.bannerGroupView:GetCurrentIndex()
    self:Set_curBannerIdx(curIndex + 1)
  end
  
  local scrollRect = self.ui.ScrollView_Advertise:GetComponent(T_ScrollRect)
  scrollRect.horizontal = #self.oriBannerList > 1
  local haveBanner = #self.oriBannerList > 0
  self.ui.Image_Activity_Bg:SetActive(not haveBanner)
  self.ui.Image_Activity_Icon:SetActive(not haveBanner)
  self.ui.Text_C_Activity:SetActive(not haveBanner)
  self.ui.Content_Roll_Advertise.transform.anchoredPosition = CS.UnityEngine.Vector2(0, self.ui.Content_Roll_Advertise.transform.anchoredPosition.y)
end

function MainPanelActiviyBannerComp:_AddBannerItemComp(item, index)
  local itemObj = UI_Main_Banner_ItemResource(item)
  local activityTid = self.oriBannerList[index]
  if not activityTid or not DT.Activity[activityTid] then
    return
  end
  local activityCfg = DT.Activity[activityTid]
  self.binder:UpdateLocalizedTextAndResouce(itemObj.uiNode)
  self.binder:SetImage(itemObj.uiNode, self:GetBannerPic(activityTid))
  self.binder:SetText(itemObj.Text_Activity_Name, LT.Text(activityCfg.ActivityName or ""))
  self.binder:SetText(itemObj.Text_Activity_Desc, LT.Text(activityCfg.BannerText or ""))
  self.binder:BindButtonClick(itemObj.Btn_Click, function()
    ActivityDataUtils.OpenActivityMainPanel(activityTid)
    RedPointDataUtils.ReqRemoveData(RedTypeDefine.RedType.ActivityServer, RedPointDataUtils.RedAttrType.IsNew, 0)
  end)
  local nameTxtComp = AutoAdaptionText.StartAutoAdaptionText(itemObj.Text_Activity_Name, nil, nil, nil, TIMER_DURATION * 5)
  local descTxtComp = AutoAdaptionText.StartAutoAdaptionText(itemObj.Text_Activity_Desc, nil, nil, nil, TIMER_DURATION * 5)
  if nameTxtComp then
    nameTxtComp:SetBtn(itemObj.Btn_Click)
  end
  if descTxtComp then
    descTxtComp:SetBtn(itemObj.Btn_Click)
  end
end

function MainPanelActiviyBannerComp:GetBannerPic(activityTid)
  local activityCfg = DT.Activity[activityTid]
  local bannerPic = activityCfg.BannerPic
  if bannerPic and string.contains(bannerPic, ";") then
    local picList = string.split(bannerPic, ";")
    if PlayerDataUtils.IsMale() then
      return picList[1]
    end
    return picList[2]
  end
  return bannerPic
end

function MainPanelActiviyBannerComp:OnBind(binder)
  self.binder = binder
  GlobalDispatcher:AddListener(NotifyId.OnActivityFinished, self._OnActivityFinished, self)
  self:OnEnterComp()
end

function MainPanelActiviyBannerComp:OnUnbind()
  Super.OnUnbind(self)
  UIBasePanel.ClearTableviews(self)
end

function MainPanelActiviyBannerComp:OnEnterComp()
  self:InitViewData()
  self:_InitTimer()
  self:_InitEvent()
  self:_InitBannerGroupGroupView()
  self:_RefreshView()
  self:_PlayActivityMainViewAvg()
end

function MainPanelActiviyBannerComp:_InitEvent()
  self.binder:BindEvent(EventMgr.Instance.TouchBeginEvent, System.fn(self, self.OnTouchBegin))
  self.binder:BindEvent(EventMgr.Instance.TouchEndEvent, System.fn(self, self.OnTouchEnd))
end

function MainPanelActiviyBannerComp:_IsRaidActivityBannerOpened(activityData, activityCfg)
  local now = TimeUtils.GetServerTime()
  local hideTs = activityData.base and activityData.base.hideTs or activityData.hideTs or 0
  if hideTs > 0 and now > hideTs then
    return false
  end
  local startTime = activityData.startTime or activityCfg.ActivityStartTime or 0
  if now < startTime then
    return false
  end
  local endTime = activityData.endTime or 0
  return endTime <= 0 or now < endTime
end

function MainPanelActiviyBannerComp:_IsActivityBannerOpened(activityData)
  local activityCfg = ActivityDataUtils.GetConfig(activityData.activityTid)
  if activityCfg and activityCfg.ActivityType == ActivityDefine.ActivityType.TwoAndAHalfAnniversaryRAIDActiviity then
    do return self._IsRaidActivityBannerOpened, self, activityData end
    return self._IsRaidActivityBannerOpened, self, activityData, activityCfg
  end
  do return ActivityManager.Instance.IsActivityBannerOpenedAboutTimeType, ActivityManager.Instance end
  return ActivityManager.Instance.IsActivityBannerOpenedAboutTimeType, ActivityManager.Instance, activityData, activityCfg
end

function MainPanelActiviyBannerComp:_RefreshOriBannerListIfNeeded()
  if not self.oriBannerList or 0 == #self.oriBannerList then
    return
  end
  local newList = {}
  for _, activityTid in ipairs(self.oriBannerList) do
    local activityData = ActivityManager.Instance:GetActivityData(activityTid)
    if activityData and not activityData.hasFinish and self:_IsActivityBannerOpened(activityData) then
      table.insert(newList, activityTid)
    end
  end
  local oldLen = #self.oriBannerList
  local newLen = #newList
  local changed = oldLen ~= newLen
  if not changed then
    for i = 1, oldLen do
      if self.oriBannerList[i] ~= newList[i] then
        changed = true
        break
      end
    end
  end
  if changed then
    self.oriBannerList = newList
    self.curBannerIdx = 1
    self:_RefreshView()
  end
end

function MainPanelActiviyBannerComp:_InitTimer()
  if self.timer then
    return
  end
  self.timer = self.binder:BindTimer(TIMER_DURATION, -1, System.fn(self, self._OnBannerTimerTick), nil)
end

function MainPanelActiviyBannerComp:_OnBannerTimerTick()
  if self._isTouch then
    return
  end
  self:_RefreshOriBannerListIfNeeded()
  self:RollBanner(self:Get_curBannerIdx() + 1)
end

function MainPanelActiviyBannerComp:OnTouchBegin()
  self._isTouch = true
end

function MainPanelActiviyBannerComp:OnTouchEnd()
  self._isTouch = false
end

function MainPanelActiviyBannerComp:_RefreshView()
  local haveBanner = #self.oriBannerList > 0
  self.ui.Image_Activity_Bg:SetActive(not haveBanner)
  self.ui.Image_Activity_Icon:SetActive(not haveBanner)
  self.ui.Text_C_Activity:SetActive(not haveBanner)
  if not haveBanner then
    self.ui.Group_Banner:SetActive(false)
    return
  end
  self.ui.Group_Banner:SetActive(true)
  self.bannerGroupView:ReloadData()
  self:_RefreshDotGroup()
end

function MainPanelActiviyBannerComp:_RefreshDotGroup()
  local bannerNum = 0
  for idx, activityTid in ipairs(self.oriBannerList) do
    bannerNum = bannerNum + 1
    local dotObj = self.dotObjList[idx]
    if not dotObj or IsNil(dotObj) then
      dotObj = GameObject.Instantiate(self.ui.Dark, self.ui.Group_Dot.transform)
      self.dotObjList[idx] = dotObj
    end
    dotObj:SetActive(#self.oriBannerList > 1)
    local brightGo = CS.Framework.GameObjectUtil.FindChildByPath(dotObj, "Bright")
    brightGo:SetActive(self:Get_curBannerIdx() == idx)
  end
  if bannerNum < #self.dotObjList then
    for idx = bannerNum + 1, #self.dotObjList do
      local dotObj = self.dotObjList[idx]
      dotObj:SetActive(false)
    end
  end
end

function MainPanelActiviyBannerComp:_GetOriBannerList()
  do return end
  return ActivityDataUtils.GetMainPanelBannerActivityTidList
end

function MainPanelActiviyBannerComp:RollBanner(idx)
  if not GuidePanelUtils.IsViewAtTop(Urls.MainPanel) then
    return
  end
  if 0 == #self.oriBannerList then
    return
  end
  if self.mainPanel and not self.mainPanel:IsRendering() then
    return
  end
  local moveWithSpring = true
  if 1 == idx or idx > #self.oriBannerList then
    idx = 1
    moveWithSpring = false
  end
  self:JumpBanner(idx, moveWithSpring)
  self:Set_curBannerIdx(idx)
end

function MainPanelActiviyBannerComp:JumpBanner(targetIdx, moveWithSpring)
  local offset = 0
  if targetIdx > 0 then
    offset = self.bannerGroupView:GetOffsetByIndex(targetIdx - 1)
  end
  self.bannerGroupView:SetOffset(offset, moveWithSpring)
end

function MainPanelActiviyBannerComp:OnUnbind()
  GlobalDispatcher:RemoveListener(NotifyId.OnActivityFinished, self._OnActivityFinished, self)
  Super.OnUnbind(self)
  self:ClearRes()
end

function MainPanelActiviyBannerComp:ClearRes()
  for _, obj in pairs(self.dotObjList) do
    GameObject.Destroy(obj)
  end
  self.dotObjList = {}
end

function MainPanelActiviyBannerComp:_OnActivityFinished(activityTid)
  local isHited = false
  if self.oriBannerList then
    for i = 1, #self.oriBannerList do
      if self.oriBannerList[i] == activityTid then
        table.remove(self.oriBannerList, i)
        self.curBannerIdx = 1
        isHited = true
        break
      end
    end
  end
  if isHited then
    self:_RefreshView()
  end
end

function MainPanelActiviyBannerComp:_PlayActivityMainViewAvg()
  ActivityKarenUtils.AddFirstOpenPopupQue()
  ActivityKarenUtils.AddPassAnyStageTaskAvg()
end

return MainPanelActiviyBannerComp
