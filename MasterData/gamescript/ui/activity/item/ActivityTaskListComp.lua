local CommonState = CommonDefine.CommonState
local UIAnimationController = CS.Z1Client.UIAnimationController
local typeof = _ENV.typeof
local RectTransform = CS.UnityEngine.RectTransform
local Vector2 = CS.UnityEngine.Vector2
local ActivityTaskListComp, Super = System.NewClass("ActivityTaskListComp", ActivityBaseComp)

function ActivityTaskListComp:ctor(res, activityTid, model)
  Super.ctor(self)
  self:_InitUIResource(res)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.taskList = {}
  self.taskOrderSortValueTable = self:_GetTaskConfigOrderValueTable(activityTid) or {}
  self.taskStateSortValueTable = {
    [CommonState.GainPrize] = 1,
    [CommonState.Running] = 2,
    [CommonState.Finish] = 3
  }
  self.taskSortWeights = {}
end

function ActivityTaskListComp:_InitUIResource(res)
  self.ui = UI_Events_Panel_SurveyDiaryResource(res)
end

function ActivityTaskListComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:_BindActivityTimer()
  self:_OnBindEvent(binder)
  self:_OnBindActivityPlot(binder)
  self:_OnBindTaskListView(binder)
  local activityName = ActivityDataUtils.GetActivityName(self.activityTid)
  binder:SetText(self.ui.Text_Diary, activityName)
  binder:BindToImageSync(self.ui.Image_Map, System.fn(self, self._GetBgImage))
  self:_BindPortraitComp(binder)
  self:_BindGroupTip(binder)
  self:_BindSilverTectTip(binder)
end

function ActivityTaskListComp:_OnBindEvent()
end

function ActivityTaskListComp:_OnBindTaskListView(binder)
  binder:BindToCircularListView(self.ui.ScrollView, System.fn(self, self._GetTaskList), System.fn(self, self._UpdateTaskItem))
end

function ActivityTaskListComp:_OnBindActivityPlot(binder)
  local scrollViewRectTrans = self.ui.ScrollView:GetComponent(typeof(RectTransform))
  local activityCfg = DT.Activity[self.activityTid]
  if activityCfg.ActivityPlot then
    self.ui.Image_Gradient:SetActive(true)
    binder:SetText(self.ui.Text_introduce, LT.Text(activityCfg.ActivityPlot))
    scrollViewRectTrans.sizeDelta = Vector2(scrollViewRectTrans.sizeDelta.x, 534)
  else
    self.ui.Image_Gradient:SetActive(false)
    scrollViewRectTrans.sizeDelta = Vector2(scrollViewRectTrans.sizeDelta.x, 670)
  end
end

function ActivityTaskListComp:_BindSilverTectTip(binder)
  if not self.ui.Group_SilverTech then
    return
  end
  if self.activityTid ~= DT.GetOriginalConstant("LoginPlatformActivity") then
    binder:SetActive(self.ui.Group_SilverTech, false)
    return
  end
  binder:SetActive(self.ui.Group_SilverTech, true)
  binder:SetText(self.ui.Text_SilverTech, LT.Text("LoginPlatFormActivityTxt"))
end

function ActivityTaskListComp:_BindGroupTip(binder)
  local targetActivityTid = DT.GetConstant("Aniversary2ndTaskActivityTid")
  if not self.ui.Group_Tip then
    return
  end
  if self.activityTid ~= targetActivityTid then
    binder:SetActive(self.ui.Group_Tip, false)
    return
  end
  binder:SetActive(self.ui.Group_Tip, true)
  binder:SetText(self.ui.Text_Tip, LT.Text("2ndAnniversary_200DrawsText"))
end

function ActivityTaskListComp:_GetBgImage()
  do return ActivityDataUtils.GetBgImage end
  return ActivityDataUtils.GetBgImage, self.activityTid
end

function ActivityTaskListComp:_GetTaskConfigOrderValueTable(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config or not config.ActivityPara1 then
    return nil
  end
  local tb = {}
  for index, taskTid in ipairs(config.ActivityPara1) do
    tb[taskTid] = index
  end
  return tb
end

function ActivityTaskListComp:_GetTaskList()
  local taskList = ActivityDataUtils.GetTaskDataListFormActivityData(self.activityData)
  table.sort(taskList, System.fn(self, self._GetSortValue))
  self.taskList = taskList
  return self.taskList
end

function ActivityTaskListComp:_GetSortValue(a, b)
  local orderValueA = self.taskOrderSortValueTable[a.tid] or 999
  local orderValueB = self.taskOrderSortValueTable[b.tid] or 999
  local taskStateValueA = self.taskStateSortValueTable[a.state] or 999
  local taskStateValueB = self.taskStateSortValueTable[b.state] or 999
  if taskStateValueA == taskStateValueB then
    return orderValueA < orderValueB
  end
  return taskStateValueA < taskStateValueB
end

function ActivityTaskListComp:_UpdateTaskItem(childBinder, go, index)
  local taskData = self.taskList[index]
  childBinder:BindComponent(ActivityTaskItem(go, taskData, self.activityData))
end

function ActivityTaskListComp:OnUnbind()
  self:_ClearTimer()
end

function ActivityTaskListComp:OnOpenAnim(callback)
  self.binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView)
  self.uiAnimController:PlayState("UI_Events_Panel_SurveyDiary_Open", callback)
end

function ActivityTaskListComp:OnCloseAnim(callback)
  local animClip = self.uiAnimController:GetClip("UI_Events_Panel_SurveyDiary_Close").clip
  if 0 ~= animClip.length then
    self.uiAnimController:PlayState(self.activtyDefine.closeAnim, callback)
  elseif callback then
    callback()
  end
end

return ActivityTaskListComp
