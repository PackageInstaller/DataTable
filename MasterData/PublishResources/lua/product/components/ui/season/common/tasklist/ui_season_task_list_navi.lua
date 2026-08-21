_class("UISeasonTaskListNavi", UICustomWidget)
UISeasonTaskListNavi = UISeasonTaskListNavi

function UISeasonTaskListNavi:_GetAnimInfo(key)
  Log.exception(self._className .. "必须重写 _GetAnimInfo() 方法:", debug.traceback())
end

function UISeasonTaskListNavi:OnShow(uiParams)
  self._seasonTaskModule = GameGlobal.GameLogic():GetModule(SeasonTaskModule)
  self:_Refresh()
  self:_AttachEvent()
  local obj = self:GetGameObject("Desc")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(obj), UIEvent.Click, function(go)
    self:_BrowseTask()
  end)
end

function UISeasonTaskListNavi:OnHide()
  self:_DetachEvent()
end

function UISeasonTaskListNavi:_Refresh()
  if not self.view then
    return
  end
  local node = self._seasonTaskModule:GetCurNode()
  local questId = UISeasonTaskListHelper.GetCurQuestId(node)
  self:_CheckShow(questId)
  self:_SetTitle(questId)
  self:_SetDesc(questId)
end

function UISeasonTaskListNavi:_CheckShow(questId)
  local mode = GameGlobal.GetUIModule(SeasonModule):SeasonManager():SeasonMapManager():Mode()
  local isTravel = mode == SeasonMapMode.Mode2
  local isHaveQuest = questId ~= 0
  local isFin = UISeasonTaskListHelper.CheckQuestFin(questId)
  local isShow = isTravel and isHaveQuest and not isFin
  Log.info("UISeasonTaskListNavi:_CheckShow(), questId =", questId, "isTravel =", isTravel, "isHaveQuest =", isHaveQuest, "isFin =", isFin)
  self:_SetShow(isShow)
end

function UISeasonTaskListNavi:_SetShow(isShow)
  if isShow == self._isShow then
    return
  end
  self._isShow = isShow
  local change = self._isShow ~= nil
  local play = change or isShow
  if play then
    local name = isShow and "in" or "out"
    
    local function func()
      if isShow ~= self._isShow then
        Log.info("UISeasonTaskListNavi:_SetShow(), isShow was Change !!!")
      end
      Log.info("UISeasonTaskListNavi:_SetShow(), play stop, self._isShow =", self._isShow)
      self:_SetActive(self._isShow)
    end
    
    local animName, duration = self:_GetAnimInfo(name)
    if not string.isnullorempty(animName) then
      self:_SetActive(true)
      Log.info("UISeasonTaskListNavi:_SetShow(), play start, true")
      UIWidgetHelper.PlayAnimation(self, "_anim", animName, duration, func)
    else
      func()
    end
  else
    Log.info("UISeasonTaskListNavi:_SetShow(), play false isShow =", isShow)
    self:_SetActive(isShow)
  end
end

function UISeasonTaskListNavi:_SetActive(isShow)
  self:GetGameObject():SetActive(isShow)
end

function UISeasonTaskListNavi:_SetTitle(questId)
  local text = UISeasonTaskListHelper.GetQuestText(questId, "QuestName")
  UIWidgetHelper.SetLocalizationText(self, "_txtTitle", text)
end

function UISeasonTaskListNavi:_SetDesc(questId)
  local text = UISeasonTaskListHelper.GetQuestText(questId, "QuestDesc")
  local obj = self:GetUIComponent("UIRichText", "_txtDesc")
  obj:SetText(text)
end

function UISeasonTaskListNavi:_BrowseTask()
  UISeasonTaskListHelper.GoToTask()
end

function UISeasonTaskListNavi:BtnOnClick(go)
  self:_BrowseTask()
end

function UISeasonTaskListNavi:_AttachEvent()
  self:AttachEvent(GameEventType.OnSeasonTaskReset, self.OnSeasonTaskReset)
  self:AttachEvent(GameEventType.OnSeasonTaskRefreshed, self.OnSeasonTaskRefreshed)
  self:AttachEvent(GameEventType.OnSeasonModeChanged, self.OnSeasonModeChanged)
end

function UISeasonTaskListNavi:_DetachEvent()
  self:DetachEvent(GameEventType.OnSeasonTaskReset, self.OnSeasonTaskReset)
  self:DetachEvent(GameEventType.OnSeasonTaskRefreshed, self.OnSeasonTaskRefreshed)
  self:DetachEvent(GameEventType.OnSeasonModeChanged, self.OnSeasonModeChanged)
end

function UISeasonTaskListNavi:OnSeasonTaskReset()
  self:_Refresh()
end

function UISeasonTaskListNavi:OnSeasonTaskRefreshed()
  self:_Refresh()
end

function UISeasonTaskListNavi:OnSeasonModeChanged()
  self:_Refresh()
end

function UISeasonTaskListNavi:OnAfterUIRootActive(flag, uiName)
end
