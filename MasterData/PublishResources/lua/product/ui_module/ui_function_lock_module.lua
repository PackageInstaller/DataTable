_class("UIFunctionLockModule", UIModule)
local PopUIType = {FunctionLockTips = 1}
_enum("PopUIType", PopUIType)
local FunctionId = {
  Aircraft = 1,
  Shop = 2,
  BuyPhyPower = 3,
  BuyCoin = 4,
  RoleStory = 5,
  MainTask = 6,
  BranchTask = 7,
  DailyTask = 8,
  AchieveTask = 9,
  ResourceLevel = 10,
  MiJing = 11
}
_enum("FunctionId", FunctionId)

function UIFunctionLockModule:Constructor()
  self:AttachEvent(GameEventType.UIOpen, self._UIOpenHandle)
  self:AttachEvent(GameEventType.ModuleUnlocked, self._HandleFunctionUnLockMsg)
  self:AttachEvent(GameEventType.QuestAchiUpdate, self._AchieveOnGotCallback)
  self:AttachEvent(GameEventType.QuestMedalUpdate, self._MedalOnGotCallback)
  self._isShowing = false
  self._achievementOpening = false
  self._lockAchievement = false
  self._firstUnLockFunctionArr = {}
end

function UIFunctionLockModule:Dispose()
  self._achieveQueue = nil
  self._medalQueue = nil
end

function UIFunctionLockModule:_UIOpenHandle(uiName)
  if uiName == "UIExtraMissionDetailController" or uiName == "UIDiscovery" or uiName == "UIResDetailController" or uiName == "UIMazeController" then
    self:PopShowUI()
  end
  self:_UIOpenHandle_Achieve(uiName)
end

function UIFunctionLockModule:GetFirstUnLockFunctionArr(functionId)
  for _, id in pairs(self._firstUnLockFunctionArr) do
    if id == functionId then
      table.removev(self._firstUnLockFunctionArr, id)
      return true
    end
  end
  return false
end

function UIFunctionLockModule:_HandleFunctionUnLockMsg(functionId)
  if not functionId then
    return
  end
  table.insert(self._firstUnLockFunctionArr, functionId)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FunctionUnLock, functionId)
  local functionLockCfg = Cfg.cfg_module_unlock[functionId]
  if not functionLockCfg then
    return
  end
  if functionLockCfg.ShowType == 0 then
    return
  end
  local ui = {}
  ui.uiName = "UIFunctionLockTipsController"
  ui.data = functionId
  ui.uiType = PopUIType.FunctionLockTips
  ui.priority = functionLockCfg.Priority
  local curUIState = GameGlobal.UIStateManager():CurUIStateType()
  if curUIState == UIStateType.BattleLoading or curUIState == UIStateType.UIBattle then
    self:PushUI(ui)
    return
  end
  self:ShowUI(ui)
end

function UIFunctionLockModule:ShowUIComplete()
  self._isShowing = false
  self:PopShowUI()
end

function UIFunctionLockModule:PushUI(ui)
  if self._uiQueue == nil then
    self._uiQueue = {}
  end
  table.insert(self._uiQueue, ui)
  self:_SortPushUI()
end

function UIFunctionLockModule:ShowUI(ui)
  self:PushUI(ui)
  self:PopShowUI()
end

function UIFunctionLockModule:PopShowUI()
  if self._isShowing then
    return
  end
  if not self._uiQueue then
    return
  end
  if table.count(self._uiQueue) <= 0 then
    return
  end
  local ui = self._uiQueue[1]
  table.remove(self._uiQueue, 1)
  GameGlobal.UIStateManager():ShowDialog(ui.uiName, ui.data)
  self._isShowing = true
end

function UIFunctionLockModule:_SortPushUI()
  if not self._uiQueue then
    return
  end
  table.sort(self._uiQueue, function(a, b)
    if a.uiType < b.uiType then
      return true
    end
    return a.priority < b.priority
  end)
end

function UIFunctionLockModule:_UIOpenHandle_Achieve(uiName)
  if (self._medalQueue == nil or table.count(self._medalQueue) == 0) and (self._achieveQueue == nil or table.count(self._achieveQueue) == 0) then
    return
  end
  if self._lockAchievement or uiName == "UIStoryController" or GameGlobal.UIStateManager():IsShow("UIDrawCardAnimController") then
  else
    self:On_UIOpenHandle_AchieveTask()
  end
end

function UIFunctionLockModule:On_UIOpenHandle_AchieveTask()
  local achievementUnLock = GameGlobal.GetModule(RoleModule):CheckModuleUnlock(GameModuleID.MD_QuestAchieve)
  if achievementUnLock then
    self:DisPatchAchievementMsg()
  end
end

function UIFunctionLockModule:DisPatchAchievementMsg()
  while self._medalQueue and table.count(self._medalQueue) > 0 do
    local data = self._medalQueue[1]
    table.remove(self._medalQueue, 1)
    AchievementManager:GetInstance():FnishMedal(data)
  end
  while self._achieveQueue and 0 < table.count(self._achieveQueue) do
    local data = self._achieveQueue[1]
    table.remove(self._achieveQueue, 1)
    AchievementManager:GetInstance():FnishAchievement(data)
  end
end

function UIFunctionLockModule:_AchieveOnGotCallback(msgs)
  if msgs == nil or table.count(msgs) <= 0 then
    return
  end
  msgs.popType = PopType.Achieve
  self:StartTask(self.On_AchieveOnGotCallback, self, msgs)
end

function UIFunctionLockModule:_MedalOnGotCallback(id)
  if id == nil then
    return
  end
  local msg = {}
  msg.Id = id
  msg.popType = PopType.Medal
  self:StartTask(self.On_AchieveOnGotCallback, self, msg)
end

function UIFunctionLockModule:On_AchieveOnGotCallback(TT, msg)
  local achievementUnLock = GameGlobal.GetModule(RoleModule):CheckModuleUnlock(GameModuleID.MD_QuestAchieve)
  if not achievementUnLock then
    return
  end
  if msg.popType == PopType.Achieve then
    if self._achieveQueue == nil then
      self._achieveQueue = {}
    end
    table.insert(self._achieveQueue, msg)
  elseif msg.popType == PopType.Medal then
    if self._medalQueue == nil then
      self._medalQueue = {}
    end
    table.insert(self._medalQueue, msg.Id)
  end
  if not self._lockAchievement then
    local curUIState = GameGlobal.UIStateManager():CurUIStateType()
    if curUIState == UIStateType.BattleLoading or curUIState == UIStateType.UIStoryController or curUIState == UIStateType.UIDrawCardAnim or GameGlobal.UIStateManager():IsShow("UIStoryController") or curUIState == UIStateType.Invalid or curUIState == UIStateType.LoginEmpty or curUIState == UIStateType.Login then
      return
    end
    self:On_UIOpenHandle_AchieveTask()
  end
end

function UIFunctionLockModule:LockAchievementFinishPanel(lock)
  if self._lockAchievement == lock then
    return
  end
  self._lockAchievement = lock
  if not self._lockAchievement then
    if self._achieveQueue == nil then
      return
    end
    if table.count(self._achieveQueue) == 0 then
      return
    end
    local curUIState = GameGlobal.UIStateManager():CurUIStateType()
    if curUIState == UIStateType.BattleLoading or curUIState == UIStateType.UIStoryController or curUIState == UIStateType.UIDrawCardAnim or GameGlobal.UIStateManager():IsShow("UIStoryController") or curUIState == UIStateType.Invalid or curUIState == UIStateType.LoginEmpty or curUIState == UIStateType.Login then
      return
    end
    self:On_UIOpenHandle_AchieveTask()
  end
end
