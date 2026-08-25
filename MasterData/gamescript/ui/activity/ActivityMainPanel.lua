local PermanentActivityTid = DT.GetOriginalConstant("PermanentActivity")
local T_UIExport = typeof(CS.FrameWork.UIExport)
local ActivityMainPanel, Super = System.NewClass("ActivityMainPanel", UIBasePanel)
ActivityMainPanel.uiResCls = UI_Events_Panel_MainResource

function ActivityMainPanel:ctor(data)
  Super.ctor(self)
  if data then
    self.targetActivityTid = data.targetActivityTid
    self.enterParams = data.params
    self.isTrialInto = data.isTrialInto
  end
  ActivityManager.Instance:CheckHideActivity()
  self.model = ActivityManager.Instance.model
  self.model:SortActivityList()
  self.currActivityTid = Vue.ref(self:_InitShowActivityId())
  self.compMap = {}
end

function ActivityMainPanel:_InitShowActivityId()
  if self.model:IsTrialActivityTid(self.targetActivityTid) then
    return self.model.trialTidList[1]
  end
  if self.targetActivityTid and self.model:IsDisplayActivityTid(self.targetActivityTid) then
    return self.targetActivityTid
  end
  local firstActivityTid = self.model:GetFirstDisplayActivityTid()
  return firstActivityTid or ActivityDefine.ActivityNone
end

function ActivityMainPanel:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self:_OnBindEvent(binder)
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, System.fn(self, self.OnBtnClose)))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, System.fn(self, self._OnClickIntro))
  binder:BindToVisible(self.ui.UI_Common_Btn_Question, System.fn(self, self._IsIntroVisible))
  binder:BindToCircularListView(self.ui.ScrollView, System.fn(self, self._GetShowActivity), System.fn(self, self._UpdateTabItem))
  binder:BindToRaw(System.fn(self, self._OnChangeActivityShow), function()
    return self.currActivityTid.value
  end)
  binder:BindToRaw(System.fn(self, self._OnActivityChanged), function()
    return DataCenter.activityData.activityDatas
  end)
  self:_RemoveChosenActivityRed()
  binder:BindToRaw(function(_, n)
    if not n then
      return
    end
    if n > 0 and self.currActivityTid.value == ActivityDefine.ActivityNone then
      self.currActivityTid.value = self:_InitShowActivityId()
      self:_RemoveChosenActivityRed()
    end
  end, function()
    return #self.model.sortedTidList
  end)
  binder:BindToRaw(function()
    ActivityAvgUtils.PlayActAvg(self.currActivityTid.value)
  end, function()
    return self.currActivityTid.value
  end)
  if self.targetActivityTid then
    local index = self:_GetCurrActivityTabIndex()
    if index >= 7 then
      binder:CircularScrollTo(self.ui.ScrollView, index - 1)
    end
  end
  if not self.isTrialInto then
    binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView)
  end
end

function ActivityMainPanel:_OnBindEvent(binder)
  binder:BindEvent(EventMgr.Instance.TaskInfoUpdated, System.fn(self, self._OnTaskInfoUpdated))
end

function ActivityMainPanel:_OnTaskInfoUpdated(taskData)
  local taskType = TaskCfgUtils.GetCfgField("TaskType", taskData.tid)
  if taskType ~= cd.TaskType.TaskType_RailWay then
    return
  end
end

function ActivityMainPanel:_NormalizeActivityTidForCompKey(activityTid)
  if not activityTid or activityTid == ActivityDefine.ActivityNone then
    return activityTid
  end
  if self.model and self.model.trialTidList and table.contains(self.model.trialTidList, activityTid) then
    return self.model.trialTidList[1]
  end
  return activityTid
end

function ActivityMainPanel:_GetCurrActivityTabIndex()
  local activityTid = self.currActivityTid.value
  for index, tid in ipairs(self.model.sortedTidList) do
    if tid == activityTid then
      return index
    end
  end
  return 0
end

function ActivityMainPanel:_RemoveChosenActivityRed()
  local activityTid = self.currActivityTid.value
  if ActivityRedUtils.IsActivityNew({activityTid}) then
    RedPointDataUtils.ReqRemoveData(RedTypeDefine.RedType.ActivityServer, RedPointDataUtils.RedAttrType.IsNew, activityTid)
  end
  local trialTidList = self.model.trialTidList
  if trialTidList and table.contains(trialTidList, activityTid) then
    for _, tid in ipairs(trialTidList) do
      if ActivityRedUtils.IsActivityNew({tid}) then
        RedPointDataUtils.ReqRemoveData(RedTypeDefine.RedType.ActivityServer, RedPointDataUtils.RedAttrType.IsNew, tid)
      end
    end
  end
end

function ActivityMainPanel:_OnActivityChanged(_, nActivityData, oActivityData, activityTid)
  print("nActivityData, oActivityData, activityTid:", table.tostring(nActivityData), table.tostring(oActivityData), activityTid)
  if oActivityData and nil == nActivityData and self.compMap[activityTid] then
    if self.compMap[activityTid].StopConfigLoopVideo then
      self.compMap[activityTid]:StopConfigLoopVideo()
    end
    self.compMap[activityTid]:teardown()
    self.compMap[activityTid] = nil
  end
end

function ActivityMainPanel:_OnChangeActivityShow(_, activityTid, prevActivityTid)
  if not (self.compMap and activityTid) or activityTid == ActivityDefine.ActivityNone then
    return
  end
  self.binder:SetActive(self.ui.Btn_PermanentRule, table.contains(PermanentActivityTid, activityTid))
  if table.contains(self.model.trialTidList, activityTid) then
    activityTid = self.model.trialTidList[1]
  end
  if activityTid == self.model.trialTidList[1] and self.compMap[activityTid] then
    self.compMap[activityTid] = nil
  end
  local comp = self.compMap[activityTid]
  if not comp then
    comp = self:_BindActivityCompFunc(self.binder, activityTid)
    if not comp then
      return
    end
    self.compMap[activityTid] = comp
  end
  if prevActivityTid and activityTid ~= prevActivityTid then
    local preCompKey = self:_NormalizeActivityTidForCompKey(prevActivityTid)
    local preComp = preCompKey and self.compMap[preCompKey]
    if preComp then
      self:_SyncReleaseActivityMedia(preComp)
    end
  end
  comp:Show()
  comp:OnOpenAnim(function()
    local config = ActivityDataUtils.GetConfig(activityTid)
    EventMgr.Instance.OnActivityCompOpened:Dispatch(config.ActivityType)
  end)
  local activityDefine = ActivityDataUtils.GetActivityDefine(activityTid)
  if activityDefine then
    EventMgr.Instance.CGActivityPlayed:Dispatch(activityDefine.resPath)
  end
  if prevActivityTid and activityTid ~= prevActivityTid then
    local preCompKey = self:_NormalizeActivityTidForCompKey(prevActivityTid)
    local preComp = preCompKey and self.compMap[preCompKey]
    if preComp then
      local closingTidNorm = preCompKey
      preComp:OnCloseAnim(function()
        local curNorm = self:_NormalizeActivityTidForCompKey(self.currActivityTid.value)
        if curNorm == closingTidNorm then
          return
        end
        preComp:Hide()
      end)
    end
  end
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
  if self.uiAnimController then
    self.uiAnimController:StopPlayableGraph()
    local activityClsInfo = ActivityDataUtils.GetActivityCompInfoByTid(activityTid)
    self.binder:SetCanvasGroup(self.ui.Group_Line_Right, 0)
    self.binder:SetCanvasGroup(self.ui.Image_Description, 0)
    self.binder:SetCanvasGroup(self.ui.Btn_PermanentRule, 0)
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

function ActivityMainPanel:_SyncReleaseActivityMedia(comp)
  if not comp then
    return
  end
  if comp.StopConfigLoopVideo then
    comp:StopConfigLoopVideo()
  end
  if comp.ClearTimeline then
    comp:ClearTimeline()
  end
end

function ActivityMainPanel:_BindActivityCompFunc(binder, activityTid)
  if not binder or not activityTid then
    Logger.Error("参数错误, 请检查活动数据:", binder, activityTid)
    return
  end
  local compPath, resPath = ActivityDefine.GetActivityCompResPath(activityTid)
  local comp = binder:BindNewComponent(self.ui.Comp_Root, compPath, resPath, activityTid, self.model, self.enterParams)
  local compNode = comp.ui.uiNode
  local uiExport = compNode:GetComponent(T_UIExport)
  if uiExport then
    uiExport.isAutoPlayAnim = false
  end
  self:_BindCompLoopVideoAdapter(comp)
  return comp
end

function ActivityMainPanel:_BindCompLoopVideoAdapter(comp)
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

function ActivityMainPanel:_GetShowActivity()
  return self.model.sortedTidList
end

function ActivityMainPanel:_UpdateTabItem(childBinder, go, index)
  local activityTid = self.model.sortedTidList[index]
  if not activityTid then
    return
  end
  
  local function _OnSelectTab()
    if activityTid == self.currActivityTid.value then
      return true
    end
    if self.model:IsTrialActivityTid(activityTid) then
      return self.currActivityTid.value == self.model.trialTidList[1]
    end
  end
  
  local function _OnTabClick()
    if _OnSelectTab() then
      return
    end
    self.currActivityTid.value = activityTid
    self:_RemoveChosenActivityRed()
  end
  
  local function _OnFinished()
    do return ActivityTrialUIUtils.GetActivityHasFinish end
    return ActivityTrialUIUtils.GetActivityHasFinish, activityTid
  end
  
  local activityTabUI = childBinder:BindComponent(ActivityTabListItem(go, activityTid, _OnTabClick, _OnSelectTab, self.currActivityTid, _OnFinished, self.model))
  if activityTid == ActivityTrialUIUtils.nowTrial then
    ActivityTrialUIUtils.InitTrialTab(activityTabUI, self.model.trialTidList)
  end
end

function ActivityMainPanel:_IsIntroVisible()
  if self.currActivityTid.value == ActivityDefine.ActivityNone then
    return
  end
  local content = ActivityDataUtils.GetRuleContent(self.currActivityTid.value)
  return nil ~= content
end

function ActivityMainPanel:_OnClickIntro()
  if self.currActivityTid.value == ActivityDefine.ActivityNone then
    return
  end
  local curTid = self.currActivityTid.value
  if self.currActivityTid.value == self.model.trialTidList[1] then
    curTid = self.model.selectedTrialTid or self.model.trialTidList[1]
  end
  local title = ActivityDataUtils.GetRuleTitle(curTid)
  local content = ActivityDataUtils.GetRuleContent(curTid)
  if not content then
    return
  end
  UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
end

function ActivityMainPanel:OnBtnClose()
  self.binder:BindTimer(0.01, 0, nil, function()
    self:Close()
  end)
  if self.compMap and table.next(self.compMap) ~= nil then
    for k, comp in pairs(self.compMap) do
      if comp then
        comp:OnCloseAnim()
        self.compMap[k] = nil
      end
    end
    self.compMap = nil
  end
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
  EventMgr.Instance.OnBeforeCloseActivityPanel:Dispatch()
end

function ActivityMainPanel:Close()
  if self.currActivityTid.value == self.model.trialTidList[1] then
    ActivityTrialUIUtils.nowTrial = self.model.trialTidList[1]
    ActivityTrialUIUtils.RefreshTrialLeftTab(self.model.trialTidList[1])
  end
  Super.Close(self)
  if not SceneMgr.Instance:IsInTown() then
    SceneMgr.Instance:EnterTown()
  end
end

return ActivityMainPanel
