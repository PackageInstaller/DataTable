local T_UIExport = typeof(CS.FrameWork.UIExport)
local ActivityPermanentsPanel, Super = System.NewClass("ActivityPermanentsPanel", UIBasePanel)
ActivityPermanentsPanel.uiResCls = UI_Events_Panel_MainResource

function ActivityPermanentsPanel:ctor(viewData)
  Super.ctor(self)
  self._viewData = type(viewData) == "table" and viewData or {}
  self._compMap = {}
  self._selectActivityTid = nil
  self.ActivityType2RuleLangDict = {
    [ActivityDefine.ActivityType.RailWayActivity] = {
      title = "RailWayRulesTitle",
      content = TaskDataUtils.GetTimeReplaceLanguageKey("RailWayRulesContentV2"),
      resPath = UI_Events_Panel_RailWayResource,
      compcls = ActivityPermanentRailWayComp,
      tabCls = ActivityPermanentRailWayTabItem
    }
  }
end

function ActivityPermanentsPanel:OnBind(binder)
  self.binder = binder
  self.binder:SetActive(self.ui.Btn_PermanentRule, false)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  binder:SetText(self.ui.Text_Title, LT.Text("PermanentActivityTitle"))
  binder:SetText(self.ui.Text_C_illustrate, LT.Text("HowToPlayTxt"))
  self:_OnBindEvent(binder)
  self:_OnBindListView(binder)
  self:_SetSelectActivityTid(self:_GetActivityTidList()[1])
end

function ActivityPermanentsPanel:_OnBindEvent(binder)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, System.fn(self, self._OnClickIntro))
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, System.fn(self, self.OnBtnClose)))
  binder:BindEvent(EventMgr.Instance.OnPermanentActivitySelectChanged, System.fn(self, self._OnPermanentActivitySelectChanged))
end

function ActivityPermanentsPanel:_OnClickIntro()
  local activityType = ActivityCfgUtils.GetCfgField("ActivityType", self._selectActivityTid)
  local ruleLangDict = self.ActivityType2RuleLangDict[activityType]
  if not ruleLangDict then
    return
  end
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text(ruleLangDict.title), LT.Text(ruleLangDict.content))
end

function ActivityPermanentsPanel:_OnClickPermanentRule()
  local title = LT.Text("PermanentActivityRuleTitle")
  local content = LT.Text("PermanentActivityRuleContent")
  UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
end

function ActivityPermanentsPanel:OnBtnClose()
  self.binder:BindTimer(0.01, 0, nil, System.fn(self, self.Close))
  self:_ClearCompMap()
  self:_ClearTimer()
end

function ActivityPermanentsPanel:_OnPermanentActivitySelectChanged(activityTid, prevActivityTid)
  if not activityTid then
    return
  end
  local comp = self:_GetComp(activityTid)
  if not comp then
    comp = self:_BindActivityCompFunc(activityTid)
    if not comp then
      return
    end
    self._compMap[activityTid] = comp
  end
  comp:Show()
  comp:OnOpenAnim()
  if prevActivityTid and activityTid ~= prevActivityTid then
    local preComp = self:_GetComp(prevActivityTid)
    if preComp then
      local closingActivityTid = prevActivityTid
      preComp:OnCloseAnim(function()
        if self._selectActivityTid == closingActivityTid then
          return
        end
        preComp:Hide()
      end)
    end
  end
  self:_ClearTimer()
  if self.uiAnimController then
    self.uiAnimController:StopPlayableGraph()
    local activityClsInfo = ActivityDataUtils.GetActivityCompInfoByTid(activityTid)
    self.binder:SetCanvasGroup(self.ui.Group_Line_Right, 0)
    self.binder:SetCanvasGroup(self.ui.Image_Description, 0)
    if not activityClsInfo.openAnim and not activityClsInfo.openTimeline and not activityClsInfo.fadeTime then
      self.uiAnimController:PlayState("UI_Events_Panel_Main_Change")
    elseif activityClsInfo.openAnim or activityClsInfo.openTimeline or activityClsInfo.fadeTime then
      local fadeTime = activityClsInfo.fadeTime or 0.5
      self.timer = self.binder:BindTimer(fadeTime, 0, nil, function()
        self.uiAnimController:PlayState("UI_Events_Panel_Main_Change")
      end)
    end
  end
end

function ActivityPermanentsPanel:_BindActivityCompFunc(activityTid)
  if not activityTid then
    return
  end
  local activityType = ActivityCfgUtils.GetCfgField("ActivityType", activityTid)
  local pageInfo = self.ActivityType2RuleLangDict[activityType]
  if not pageInfo then
    return
  end
  local compcls = pageInfo.compcls
  local resPath = pageInfo.resPath
  local comp = self.binder:BindNewComponent(self.ui.Comp_Root, compcls, resPath, activityTid)
  local compNode = comp.ui.uiNode
  local uiExport = compNode:GetComponent(T_UIExport)
  if uiExport then
    uiExport.isAutoPlayAnim = false
  end
  self:_BindCompLoopVideoAdapter(comp)
  return comp
end

function ActivityPermanentsPanel:_BindCompLoopVideoAdapter(comp)
  if not (comp and comp.TryPlayConfigLoopVideo) or comp._hasLoopVideoAdapter then
    return
  end
  comp._hasLoopVideoAdapter = true
  local originOpenAnim = comp.OnOpenAnim
  local originCloseAnim = comp.OnCloseAnim
  
  function comp.OnOpenAnim(cself, callback)
    local activityTid = cself.activityTid or cself._activityTid
    local activityClsInfo = ActivityDataUtils.GetActivityCompInfoByTid(activityTid)
    local hasVideoCfg = activityClsInfo and not string.isempty(activityClsInfo.openVideoPath)
    if hasVideoCfg then
      cself:TryPlayConfigLoopVideo()
    end
    if originOpenAnim then
      originOpenAnim(cself, callback)
      return
    end
    if callback then
      callback()
    end
  end
  
  function comp.OnCloseAnim(cself, callback)
    if cself.StopConfigLoopVideo then
      cself:StopConfigLoopVideo()
    end
    local activityTid = cself.activityTid or cself._activityTid
    local activityClsInfo = ActivityDataUtils.GetActivityCompInfoByTid(activityTid)
    local closeAnim = activityClsInfo and activityClsInfo.closeAnim
    if cself.uiAnimController and closeAnim then
      local clip = cself.uiAnimController:GetClip(closeAnim)
      local animClip = clip and clip.clip
      if animClip and 0 ~= animClip.length then
        cself.uiAnimController:PlayState(closeAnim, callback)
        return
      end
    end
    if originCloseAnim then
      originCloseAnim(cself, callback)
      return
    end
    if callback then
      callback()
    end
  end
end

function ActivityPermanentsPanel:_GetActivityTidList()
  local rst = ActivityDataUtils.GetShowingPermanentActivityTidList() or {}
  if not self._viewData.sortByLeftTimeAsc then
    return rst
  end
  local now = TimeUtils.GetServerTime()
  table.sort(rst, function(a, b)
    local leftA = self:_GetActivityLeftTimeForSort(a, now)
    local leftB = self:_GetActivityLeftTimeForSort(b, now)
    if leftA == leftB then
      return (a or 0) < (b or 0)
    end
    return leftA < leftB
  end)
  return rst
end

function ActivityPermanentsPanel:_GetActivityLeftTimeForSort(activityTid, now)
  local activityData = ActivityDataUtils.GetActivityData(activityTid)
  local left = ActivityDataUtils.GetLeftTime(activityData)
  if left and left > 0 then
    return left
  end
  local cfg = ActivityDataUtils.GetConfig(activityTid)
  if cfg and cfg.ActivityEndTime and cfg.ActivityEndTime > 0 then
    do return math.max, 0 end
    return math.max, 0, cfg.ActivityEndTime - now
  end
  return math.maxinteger
end

function ActivityPermanentsPanel:_GetComp(activityTid)
  return self._compMap[activityTid]
end

function ActivityPermanentsPanel:_SetSelectActivityTid(activityTid)
  if activityTid == self._selectActivityTid then
    return
  end
  self._preActivityTid = self._selectActivityTid
  self._selectActivityTid = activityTid
  EventMgr.Instance.OnPermanentActivitySelectChanged:Dispatch(activityTid, self._preActivityTid)
end

function ActivityPermanentsPanel:_OnBindListView(binder)
  binder:BindToCircularListView(self.ui.ScrollView, function()
    do return self._GetActivityTidList end
    return self._GetActivityTidList, self
  end, System.fn(self, self._FillGameTabItem))
end

function ActivityPermanentsPanel:_FillGameTabItem(childBinder, go, index)
  local activityTid = self:_GetActivityTidList()[index]
  local activityType = ActivityCfgUtils.GetCfgField("ActivityType", activityTid)
  local viewData = {
    clickCb = function()
      self:_SetSelectActivityTid(activityTid)
    end,
    activityTid = activityTid
  }
  local tabCls = self.ActivityType2RuleLangDict[activityType].tabCls
  childBinder:BindComponent(tabCls(go, viewData))
end

function ActivityPermanentsPanel:_ClearCompMap()
  if self._compMap and table.next(self._compMap) ~= nil then
    for k, comp in pairs(self._compMap) do
      if comp then
        if comp.StopConfigLoopVideo then
          comp:StopConfigLoopVideo()
        end
        self._compMap[k] = nil
      end
    end
  end
  self.compMap = nil
end

function ActivityPermanentsPanel:_ClearTimer()
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
end

return ActivityPermanentsPanel
