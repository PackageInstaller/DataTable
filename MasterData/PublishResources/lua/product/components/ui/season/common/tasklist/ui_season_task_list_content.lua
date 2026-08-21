_class("UISeasonTaskListContent", UICustomWidget)
UISeasonTaskListContent = UISeasonTaskListContent

function UISeasonTaskListContent:_GetAnimInfo(key)
  Log.exception(self._className .. "必须重写 _GetAnimInfo() 方法:", debug.traceback())
end

function UISeasonTaskListContent:_GetRewardInfo()
  Log.exception(self._className .. "必须重写 _GetRewardInfo() 方法:", debug.traceback())
end

function UISeasonTaskListContent:_GetStrIdInfo(key, ...)
  Log.exception(self._className .. "必须重写 _GetStrIdInfo() 方法:", debug.traceback())
end

function UISeasonTaskListContent:OnShow(uiParams)
  self._constBtnName = "TaskListContent_QuestFin"
  self._seasonTaskModule = GameGlobal.GameLogic():GetModule(SeasonTaskModule)
  self._nodes = {}
  self._tabIndex = 1
  self._pageIndex = 1
  self:_SetTexts("txtName", "intro_name")
  self:_SetTexts("txtJob", "intro_job")
  self:_SetTexts("txtInfo", "intro_desc")
  self:_SetTexts("txtTitleTask", "title_task")
  self:_SetTexts("txtTitleReward", "title_reward")
  self:_SetTexts("txtTitleProgress", "progress")
  self:_SetTexts("txtTitleProgressFin", "progress")
  self:_AttachEvent()
end

function UISeasonTaskListContent:OnHide()
  self:_DetachEvent()
end

function UISeasonTaskListContent:SetData(params)
  self._closeCallback = params and params.closeCallback
  self._nodes = self._seasonTaskModule:GetAllNode()
  self:_SetTabBtns()
  self:_SetTabSelect(1)
  self:_Refresh(true)
  self:_PlayAnim()
end

function UISeasonTaskListContent:_PlayAnim()
  self:_PlayAnimInSeq_TabBtn()
  self:_PlayAnim_QuestFin()
end

function UISeasonTaskListContent:_PlayAnimInSeq_TabBtn()
  local animName, duration = self:_GetAnimInfo("TabBtnIn")
  local objs = self._tabBtns
  for i, v in ipairs(objs) do
    local delay = (i - 1) * 0.07
    UIWidgetHelper.PlayAnimationInSequence(v, "_anim", "_root", animName, delay, duration)
  end
end

function UISeasonTaskListContent:_PlayAnim_QuestFin()
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
  local animName, duration = self:_GetAnimInfo("QuestFin")
  local delay = 1000
  UIWidgetHelper.PlayAnimationInSequence(self, "Fin", "Fin", animName, delay, duration, function()
    self:_PlayAnim_QuestFin()
  end)
end

function UISeasonTaskListContent:_FindFinNode()
  for i, node in ipairs(self._nodes) do
    local questId, isFin = UISeasonTaskListHelper.CheckLastQuestFin(node)
    if not questId then
      return
    end
    local lastTime = UISeasonLocalDBHelper.SeasonBtn_Get(self._constBtnName, questId)
    Log.debug("UISeasonTaskListContent:_FindFinNode() lastTime = ", lastTime)
    local isCross = HelperProxy:IsCrossDayTo(lastTime)
    if isFin and isCross then
      return i, questId
    end
  end
end

function UISeasonTaskListContent:_Refresh(isFirst)
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

function UISeasonTaskListContent:_SetTabBtns()
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
        local text = self:_GetStrIdInfo("tab_lock")
        ToastManager.ShowToast(text)
      end
    })
  end
end

function UISeasonTaskListContent:_SetTabSelect(index)
  self._tabIndex = index
  for i = 1, #self._tabBtns do
    self._tabBtns[i]:SetSelected(i == index)
  end
  self._node = self._nodes[self._tabIndex]
  local idx = UISeasonTaskListHelper.GetCurQuestIndex(self._node)
  self:_SetPageSelect(idx)
end

function UISeasonTaskListContent:_SetTabBtnState()
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

function UISeasonTaskListContent:_SetPageSelect(index)
  local questList = UISeasonTaskListHelper.GetAllQuestId(self._node)
  local curQuestIdx = UISeasonTaskListHelper.GetCurQuestIndex(self._node)
  local min, max = 1, #questList
  self._pageIndex = Mathf.Clamp(index, min, math.min(curQuestIdx, max))
  self:GetGameObject("PageLeftBtn"):SetActive(self._pageIndex ~= min)
  self:GetGameObject("PageRightBtn"):SetActive(self._pageIndex ~= max)
  local text = self:_GetStrIdInfo("page", self._pageIndex, #questList)
  UIWidgetHelper.SetLocalizationText(self, "_txtPage", text)
  if index > curQuestIdx then
    local text = self:_GetStrIdInfo("tab_lock")
    ToastManager.ShowToast(text)
  end
end

function UISeasonTaskListContent:_SetTexts(widgetName, key)
  local text = self:_GetStrIdInfo(key)
  UIWidgetHelper.SetLocalizationText(self, widgetName, text)
end

function UISeasonTaskListContent:_SetTitle(questId)
  local text = UISeasonTaskListHelper.GetQuestText(questId, "QuestName")
  UIWidgetHelper.SetLocalizationText(self, "_txtTitle", text)
end

function UISeasonTaskListContent:_SetDesc(questId)
  local text = UISeasonTaskListHelper.GetQuestText(questId, "QuestDesc")
  local obj = self:GetUIComponent("UIRichText", "_txtDesc")
  obj:SetText(text)
end

function UISeasonTaskListContent:_SetRewards(questId, isFin)
  local className, prefabName = self:_GetRewardInfo()
  local rewards = UISeasonTaskListHelper.GetQuestInfo(questId, "rewards") or {}
  local objs = UIWidgetHelper.SpawnObjects(self, "Content", className, #rewards, prefabName)
  for i, v in ipairs(objs) do
    v:Flush(rewards[i])
    v:SetFin(isFin)
  end
end

function UISeasonTaskListContent:_SetProgress(a, b)
  local text = string.format("%s/%s", a, b)
  UIWidgetHelper.SetLocalizationText(self, "_txtProgress", text)
  UIWidgetHelper.SetLocalizationText(self, "_txtProgressFin", text)
end

function UISeasonTaskListContent:_SetNodeFin(isFin)
  local state = isFin and 2 or 1
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"GoToBtn", "Progress"},
    {
      "ProgressFin"
    }
  })
  UIWidgetHelper.SetObjGroupShow(objs, state)
end

function UISeasonTaskListContent:_SetQuestFin(isFin)
  self:GetGameObject("Fin"):SetActive(isFin)
end

function UISeasonTaskListContent:GoToBtnOnClick(go)
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

function UISeasonTaskListContent:CloseBtnOnClick(go)
  if self._closeCallback then
    self._closeCallback()
  end
end

function UISeasonTaskListContent:PageLeftBtnOnClick(go)
  self:_SetPageSelect(self._pageIndex - 1)
  self:_Refresh()
end

function UISeasonTaskListContent:PageRightBtnOnClick(go)
  self:_SetPageSelect(self._pageIndex + 1)
  self:_Refresh()
end

function UISeasonTaskListContent:_AttachEvent()
  self:AttachEvent(GameEventType.OnSeasonTaskReset, self.OnSeasonTaskReset)
  self:AttachEvent(GameEventType.OnSeasonTaskRefreshed, self.OnSeasonTaskRefreshed)
  self:AttachEvent(GameEventType.ShowItemTips, self._ShowTips)
end

function UISeasonTaskListContent:_DetachEvent()
  self:DetachEvent(GameEventType.OnSeasonTaskReset, self.OnSeasonTaskReset)
  self:DetachEvent(GameEventType.OnSeasonTaskRefreshed, self.OnSeasonTaskRefreshed)
  self:DetachEvent(GameEventType.ShowItemTips, self._ShowTips)
end

function UISeasonTaskListContent:OnSeasonTaskReset()
  self:_Refresh()
end

function UISeasonTaskListContent:OnSeasonTaskRefreshed()
  self:_Refresh()
end

function UISeasonTaskListContent:_ShowTips(matid, pos)
  UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
end

function UISeasonTaskListContent:_ReverseTable(tb)
  local rtb = {}
  for i = #tb, 1, -1 do
    table.insert(rtb, tb[i])
  end
  return rtb
end
