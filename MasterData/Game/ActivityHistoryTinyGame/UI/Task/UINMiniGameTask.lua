local UINMiniGameTask = class("UINMiniGameTask", UIBaseNode)
local base = UIBaseNode
local UINMiniGameTag = require("Game.ActivityHistoryTinyGame.UI.Task.UINMiniGameTag")
local UINMiniGameTaskDaily = require("Game.ActivityHistoryTinyGame.UI.Task.UINMiniGameTaskDaily")
local UINMiniGameTaskActive = require("Game.ActivityHistoryTinyGame.UI.Task.UINMiniGameTaskActive")
local ActivityHTGEnum = require("Game.ActivityHistoryTinyGame.ActivityHTGEnum")
local tagCount = 2

function UINMiniGameTask:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._tagPool = UIItemPool.New(UINMiniGameTag, self.ui.pageItem)
  self.ui.pageItem:SetActive(false)
  self.__ListenTaskExpiredCallback = BindCallback(self, self.__ListenTaskExpired)
  self.__ListenActiveCallback = BindCallback(self, self.__ListenActive)
  self.__ListenTaskUpdateCallback = BindCallback(self, self.__ListenTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.ActivityTinyGameTaskExpired, self.__ListenTaskExpiredCallback)
  MsgCenter:AddListener(eMsgEventId.ActivityTinyGameActive, self.__ListenActiveCallback)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__ListenTaskUpdateCallback)
  self.__OnClickTagCallback = BindCallback(self, self.__OnClickTag)
  self.ui.taskNode:SetActive(false)
  self.ui.cupNode:SetActive(false)
  self.__RefreshActivityDotCallback = BindCallback(self, self.__RefreshActivityDot)
end

function UINMiniGameTask:InitMiniGameTask(actTinyData)
  self._actTinyData = actTinyData
  for i = 1, 2 do
    local item = self._tagPool:GetOne()
    item:InitMiniGameTag(i, self.__OnClickTagCallback)
  end
  self:__RefreshActive()
  self:__OnClickTag(1)
  if self._reddot == nil then
    self._reddot = self._actTinyData:GetActivityReddot()
    RedDotController:AddListener(self._reddot.nodePath, self.__RefreshActivityDotCallback)
    self:__RefreshActivityDot()
  end
end

function UINMiniGameTask:__OnClickTag(index)
  for i, v in ipairs(self._tagPool.listItem) do
    v:RefreshTagState(index)
  end
  if index == 1 then
    self:__OpenDailyTask()
  elseif index == 2 then
    self:__OpenActiveTask()
  end
end

function UINMiniGameTask:__OpenDailyTask()
  if self._taskActiveNode ~= nil then
    self._taskActiveNode:Hide()
  end
  if self._taskDailyNode == nil then
    self.ui.taskNode:SetActive(true)
    self._taskDailyNode = UINMiniGameTaskDaily.New()
    self._taskDailyNode:Init(self.ui.taskNode)
    self._taskDailyNode:InitMiniGameTaskDaily(self._actTinyData)
  else
    self._taskDailyNode:Show()
    self._taskDailyNode:RefreshMiniGameTaskDaily()
  end
end

function UINMiniGameTask:__OpenActiveTask()
  if self._taskDailyNode ~= nil then
    self._taskDailyNode:Hide()
  end
  if self._taskActiveNode == nil then
    self.ui.cupNode:SetActive(true)
    self._taskActiveNode = UINMiniGameTaskActive.New()
    self._taskActiveNode:Init(self.ui.cupNode)
    self._taskActiveNode:InitMiniGameTaskActive(self._actTinyData)
  else
    self._taskActiveNode:Show()
    self._taskActiveNode:RefreshMiniGameTaskActive()
  end
end

function UINMiniGameTask:__RefreshActive()
  local level = self._actTinyData:GetActiveLevel()
  local needPoint, hasPoint
  local curlevelCfg = self._actTinyData:GetTGActiveCfg()[level + 1]
  if curlevelCfg ~= nil then
    needPoint = curlevelCfg.need_point
    hasPoint = self._actTinyData:GetTinyGameActive()
  else
    needPoint = self._actTinyData:GetTGMaxActive()
    hasPoint = needPoint
  end
  hasPoint = math.min(hasPoint, needPoint)
  needPoint = math.max(1, needPoint)
  self.ui.tex_Lvl:SetIndex(0, tostring(level))
  self.ui.slider.value = hasPoint / needPoint
  self.ui.tex_Progress:SetIndex(0, tostring(hasPoint), tostring(needPoint))
end

function UINMiniGameTask:__ListenActive()
  self:__RefreshActive()
  if self._taskActiveNode ~= nil and self._taskActiveNode.active then
    self._taskActiveNode:RefreshMiniGameTaskActive()
  end
end

function UINMiniGameTask:__ListenTaskExpired()
  if self._taskDailyNode ~= nil and self._taskDailyNode.active then
    self._taskDailyNode:RefreshMiniGameTaskDaily()
  end
end

function UINMiniGameTask:__ListenTaskUpdate()
  if self._taskDailyNode ~= nil and self._taskDailyNode.active then
    self._taskDailyNode:RefreshMiniGameTaskDaily()
  end
end

function UINMiniGameTask:__RefreshActivityDot()
  local taskReddot = self._reddot:GetChild(ActivityHTGEnum.eActivityReddot.Task)
  local activeReddot = self._reddot:GetChild(ActivityHTGEnum.eActivityReddot.Active)
  self._tagPool.listItem[1]:SetHTGTaskTagDot(taskReddot ~= nil and taskReddot:GetRedDotCount() > 0)
  self._tagPool.listItem[2]:SetHTGTaskTagDot(activeReddot ~= nil and activeReddot:GetRedDotCount() > 0)
end

function UINMiniGameTask:OnDelete()
  base.OnDelete(self)
  MsgCenter:RemoveListener(eMsgEventId.ActivityTinyGameTaskExpired, self.__ListenTaskExpiredCallback)
  MsgCenter:RemoveListener(eMsgEventId.ActivityTinyGameActive, self.__ListenActiveCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__ListenTaskUpdateCallback)
  if self._reddot ~= nil then
    RedDotController:RemoveListener(self._reddot.nodePath, self.__RefreshActivityDotCallback)
  end
end

return UINMiniGameTask
