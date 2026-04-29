_class("UIS2TaskListContent", UICustomWidget)
UIS2TaskListContent = UIS2TaskListContent

function UIS2TaskListContent:OnShow(uiParams)
  self._constBtnName = "TaskListContent_QuestFin"
  self._seasonTaskModule = GameGlobal.GameLogic():GetModule(SeasonTaskModule)
  self._nodes = {}
  self._tabIndex = 1
  self._pageIndex = 1
  self:_AttachEvent()
end

function UIS2TaskListContent:OnHide()
  self:_DetachEvent()
end

function UIS2TaskListContent:SetData(params)
  self._closeCallback = params and params.closeCallback
  self._nodes = self._seasonTaskModule:GetAllNode()
  self:_SetTabBtns()
  self:_SetTabSelect(1)
  self:_Refresh(true)
  self:_PlayAnim()
end

function UIS2TaskListContent:_PlayAnim()
  self:_PlayAnimInSeq_TabBtn()
  self:_PlayAnim_QuestFin()
end

function UIS2TaskListContent:_PlayAnimInSeq_TabBtn()
  local animName, duration = "uieffanim_UIS2TaskListContent_TabBtn_in", 500
  local objs = self._tabBtns
  for i, v in ipairs(objs) do
    local delay = (i - 1) * 0.07
    UIWidgetHelper.PlayAnimationInSequence(v, "_anim", "_root", animName, delay, duration)
  end
end

function UIS2TaskListContent:_PlayAnim_QuestFin()
  local idx, questId = self:_FindFinNode()
  if not idx then
    idx = idx or self._seasonTaskModule:GetCurNodeIndex()
    self:_SetTabSelect(idx)
    self:_Refresh()
    return
  end
  self:_SetTabSelect(idx)
  self:_Refresh(true)
  local now = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  UISeasonLocalDBHelper.SeasonBtn_Set(self._constBtnName, questId, now)
  self:_SetQuestFin(true)
  local animName, duration = "uieffanim_UIS2TaskListContent_fin", 333
  local delay = 1000
  UIWidgetHelper.PlayAnimationInSequence(self, "Fin", "Fin", animName, delay, duration, function()
    self:_PlayAnim_QuestFin()
  end)
end

function UIS2TaskListContent:_FindFinNode()
  for i, node in ipairs(self._nodes) do
    local questId, isFin = UISeasonTaskListHelper.CheckLastQuestFin(node)
    local lastTime = UISeasonLocalDBHelper.SeasonBtn_Get(self._constBtnName, questId)
    Log.debug("UIS2TaskListContent:_FindFinNode() lastTime = ", lastTime)
    local isCross = HelperProxy:IsCrossDayTo(lastTime)
    if isFin and isCross then
      return i, questId
    end
  end
end

function UIS2TaskListContent:_Refresh(isFirst)
  if not self.view then
    return
  end
  self:_SetTabBtnState()
  local node = self._node
  local questList = UISeasonTaskListHelper.GetAllQuestId(self._node)
  local a, b = UISeasonTaskListHelper.GetNodeProgress(node)
  self:_SetProgress(a, b)
  local lastQuest, isNodeFin = UISeasonTaskListHelper.CheckLastQuestFin(node)
  self:_SetRewards(lastQuest, isNodeFin)
  self:_SetNodeFin(isNodeFin)
  local questId = questList[self._pageIndex]
  local isQuestFin = UISeasonTaskListHelper.CheckQuestFin(questId)
  self:_SetTitle(questId)
  self:_SetDesc(questId)
  self:_SetQuestFin(not isFirst and isQuestFin)
end

function UIS2TaskListContent:_SetTabBtns()
  local nodes = self:_ReverseTable(self._nodes)
  local title = UISeasonTaskListHelper.GetNodeTitle(nodes)
  local objs = UIWidgetHelper.SpawnObjects(self, "_tabBtns", "UIActivityCommonTextTabBtn", #title)
  self._tabBtns = self:_ReverseTable(objs)
  for i, v in ipairs(self._tabBtns) do
    v:SetData(i, {
      indexWidgets = {},
      onoffWidgets = {
        {
          "OnBtn",
          "_space_on",
          "bg_on"
        },
        {
          "OffBtn",
          "_space_off",
          "bg_off"
        }
      },
      lockWidgets = {},
      titleWidgets = {"txt_off", "txt_on"},
      titleText = title[i],
      callback = function(index, isOffBtnClick)
        if isOffBtnClick then
          self:_SetTabSelect(index)
          self:_Refresh()
        end
      end,
      lockCallback = function()
        ToastManager.ShowToast(StringTable.Get("str_season_s2_task_list_tab_lock"))
      end
    })
  end
end

function UIS2TaskListContent:_SetTabSelect(index)
  self._tabIndex = index
  for i = 1, #self._tabBtns do
    self._tabBtns[i]:SetSelected(i == index)
  end
  self._node = self._nodes[self._tabIndex]
  local idx = UISeasonTaskListHelper.GetCurQuestIndex(self._node)
  self:_SetPageSelect(idx)
end

function UIS2TaskListContent:_SetTabBtnState()
  local widgetGroup = {
    fin = {"bg_mask", "bg_fin"},
    lock = {"bg_mask", "bg_lock"},
    normal = {}
  }
  local tbLock = self._seasonTaskModule:GetAllNodeLock()
  for i, v in ipairs(self._tabBtns) do
    local node = self._nodes[i] or {}
    local state = "normal"
    state = node.is_finish and "fin" or state
    state = tbLock[i] and "lock" or state
    local obj = UIWidgetHelper.GetObjGroupByWidgetName(v, widgetGroup)
    UIWidgetHelper.SetObjGroupShow(obj, state)
    v:SetLock(state == "lock")
  end
end

function UIS2TaskListContent:_SetPageSelect(index)
  local questList = UISeasonTaskListHelper.GetAllQuestId(self._node)
  local curQuestIdx = UISeasonTaskListHelper.GetCurQuestIndex(self._node)
  local min, max = 1, #questList
  self._pageIndex = Mathf.Clamp(index, min, math.min(curQuestIdx, max))
  self:GetGameObject("PageLeftBtn"):SetActive(self._pageIndex ~= min)
  self:GetGameObject("PageRightBtn"):SetActive(self._pageIndex ~= max)
  local text = StringTable.Get("str_season_s2_task_list_page", self._pageIndex, #questList)
  UIWidgetHelper.SetLocalizationText(self, "_txtPage", text)
  if index > curQuestIdx then
    ToastManager.ShowToast(StringTable.Get("str_season_s2_task_list_tab_lock"))
  end
end

function UIS2TaskListContent:_SetTitle(questId)
  local text = UISeasonTaskListHelper.GetQuestText(questId, "QuestName")
  UIWidgetHelper.SetLocalizationText(self, "_txtTitle", text)
end

function UIS2TaskListContent:_SetDesc(questId)
  local text = UISeasonTaskListHelper.GetQuestText(questId, "QuestDesc")
  local obj = self:GetUIComponent("UIRichText", "_txtDesc")
  obj:SetText(text)
end

function UIS2TaskListContent:_SetRewards(questId, isFin)
  local rewards = UISeasonTaskListHelper.GetQuestInfo(questId, "rewards") or {}
  local objs = UIWidgetHelper.SpawnObjects(self, "Content", "UISeasonItemS2", #rewards, "UISeasonItemS2.prefab")
  for i, v in ipairs(objs) do
    v:Flush(rewards[i])
    v:SetFin(isFin)
  end
end

function UIS2TaskListContent:_SetProgress(a, b)
  local text = string.format("%s/%s", a, b)
  UIWidgetHelper.SetLocalizationText(self, "_txtProgress", text)
  UIWidgetHelper.SetLocalizationText(self, "_txtProgressFin", text)
end

function UIS2TaskListContent:_SetNodeFin(isFin)
  local state = isFin and 2 or 1
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"GoToBtn", "Progress"},
    {
      "ProgressFin"
    }
  })
  UIWidgetHelper.SetObjGroupShow(objs, state)
end

function UIS2TaskListContent:_SetQuestFin(isFin)
  self:GetGameObject("Fin"):SetActive(isFin)
end

function UIS2TaskListContent:GoToBtnOnClick(go)
  UISeasonTaskListHelper.CheckModeTravel(function()
    self:GetGameObject("Root"):SetActive(false)
    self:GetGameObject("ModeConfirm"):SetActive(true)
    local obj = UIWidgetHelper.SpawnObject(self, "ModeConfirm", "UISeasonTaskListContentModeConfirm")
    obj:SetData(function()
      UISeasonTaskListHelper.SwitchModeTravel(self._closeCallback)
    end, function()
      self:CloseBtnOnClick()
    end)
  end, self._closeCallback)
end

function UIS2TaskListContent:CloseBtnOnClick(go)
  if self._closeCallback then
    self._closeCallback()
  end
end

function UIS2TaskListContent:PageLeftBtnOnClick(go)
  self:_SetPageSelect(self._pageIndex - 1)
  self:_Refresh()
end

function UIS2TaskListContent:PageRightBtnOnClick(go)
  self:_SetPageSelect(self._pageIndex + 1)
  self:_Refresh()
end

function UIS2TaskListContent:_AttachEvent()
  self:AttachEvent(GameEventType.OnSeasonTaskReset, self.OnSeasonTaskReset)
  self:AttachEvent(GameEventType.OnSeasonTaskRefreshed, self.OnSeasonTaskRefreshed)
  self:AttachEvent(GameEventType.ShowItemTips, self._ShowTips)
end

function UIS2TaskListContent:_DetachEvent()
  self:DetachEvent(GameEventType.OnSeasonTaskReset, self.OnSeasonTaskReset)
  self:DetachEvent(GameEventType.OnSeasonTaskRefreshed, self.OnSeasonTaskRefreshed)
  self:DetachEvent(GameEventType.ShowItemTips, self._ShowTips)
end

function UIS2TaskListContent:OnSeasonTaskReset()
  self:_Refresh()
end

function UIS2TaskListContent:OnSeasonTaskRefreshed()
  self:_Refresh()
end

function UIS2TaskListContent:_ShowTips(matid, pos)
  UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
end

function UIS2TaskListContent:_ReverseTable(tb)
  local rtb = {}
  for i = #tb, 1, -1 do
    table.insert(rtb, tb[i])
  end
  return rtb
end
