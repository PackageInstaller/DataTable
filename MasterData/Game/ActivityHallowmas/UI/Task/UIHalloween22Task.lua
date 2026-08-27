local UIHalloween22Task = class("UIHalloween22Task", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local cs_UnityEngine = CS.UnityEngine
local util = require("XLua.Common.xlua_util")
local JumpManager = require("Game.Jump.JumpManager")
local UINActivityHalloweenTask = require("Game.ActivityHallowmas.UI.Task.UINActivityHalloweenTask")

function UIHalloween22Task:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseHalloweenTask, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickTaskClose)
  self._taskItmePool = UIItemPool.New(UINActivityHalloweenTask, self.ui.item)
  self.ui.item:SetActive(false)
  self._emptyItemList = {
    self.ui.emptyItem
  }
  self.ui.emptyItem:SetActive(false)
  self.__OnExpiredCallback = BindCallback(self, self.__OnExpired)
  MsgCenter:AddListener(eMsgEventId.ActivityHallowmasExpired, self.__OnExpiredCallback)
  self.__TaskUpdateCallback = BindCallback(self, self.__TaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  self.__OnRereshTaskCallback = BindCallback(self, self.__OnRereshTask)
  self.__OnRewardTaskCallback = BindCallback(self, self.__OnRewardTask)
  self.__OnJumpTargetCallback = BindCallback(self, self.__OnJumpTarget)
  self.__DelayShowItemCallback = BindCallback(self, self.__DelayShowItem)
end

function UIHalloween22Task:InitHalloweenTask(hallowmasData)
  self._data = hallowmasData
  self:__Refresh()
end

function UIHalloween22Task:__Refresh()
  self._taskItmePool:HideAll()
  for i, v in ipairs(self._emptyItemList) do
    v:SetActive(false)
  end
  if self._delayItemCO ~= nil then
    GR.StopCoroutine(self._delayItemCO)
    self._delayItemCO = nil
  end
  self._delayItemCO = GR.StartCoroutine(util.cs_generator(self.__DelayShowItemCallback))
end

function UIHalloween22Task:__DelayShowItem()
  local taskids = self._data:GetHallowmasDailyTaskIds()
  local isCanRef = self._data:GetHallowmasTaskRefreshTimes() < self._data:GetHallowmasMainCfg().daily_task_refresh_max
  local countMax = #self.ui.posTr_array
  local existCount = #taskids
  for i, v in ipairs(taskids) do
    if i > countMax then
      break
    end
    local item = self._taskItmePool:GetOne()
    local parent = self.ui.posTr_array[i]
    item.transform:SetParent(parent)
    item.transform.localPosition = Vector3.zero
    item:InitHalloweenTask(v, self.__OnRereshTaskCallback, self.__OnRewardTaskCallback, self.__OnJumpTargetCallback)
    item:RefreshHalloweenRefBtn(isCanRef)
    item:SetHalloweenGhost(i)
    coroutine.yield(cs_UnityEngine.WaitForSeconds(0.3))
  end
  for i = existCount + 1, countMax do
    local item = self._emptyItemList[i - existCount]
    if item == nil then
      item = self.ui.emptyItem:Instantiate()
      table.insert(self._emptyItemList, item)
    end
    item:SetActive(true)
    local parent = self.ui.posTr_array[i]
    item.transform:SetParent(parent)
    item.transform.localPosition = Vector3.zero
    coroutine.yield(cs_UnityEngine.WaitForSeconds(0.3))
  end
  self._delayItemCO = nil
end

function UIHalloween22Task:__OnRereshTask(taskData, taskItem)
  local curTimes = self._data:GetHallowmasTaskRefreshTimes()
  local maxTimes = self._data:GetHallowmasMainCfg().daily_task_refresh_max
  local remainTimes = maxTimes - curTimes
  if remainTimes <= 0 then
    return
  end
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(8703, tostring(remainTimes), tostring(maxTimes)), function()
    self._data:ReqHallowmasRefreshTask(taskData.id, function(newTaskId)
      local index = taskItem:GetHalloweenGhost()
      local newItem = self._taskItmePool:GetOne()
      local parent = self.ui.posTr_array[index]
      newItem.transform:SetParent(parent)
      newItem.transform.localPosition = Vector3.zero
      newItem:InitHalloweenTask(newTaskId, self.__OnRereshTaskCallback, self.__OnRewardTaskCallback, self.__OnJumpTargetCallback)
      newItem:SetHalloweenGhost(index)
      local isCanRef = self._data:GetHallowmasTaskRefreshTimes() < self._data:GetHallowmasMainCfg().daily_task_refresh_max
      for i, v in ipairs(self._taskItmePool.listItem) do
        v:RefreshHalloweenRefBtn(isCanRef)
      end
      taskItem:HideHalloweenTween(function()
        self._taskItmePool:HideOne(taskItem)
      end)
    end)
  end, nil)
end

function UIHalloween22Task:__OnRewardTask(taskData, taskItem)
  self._data:ReqHallowmasCommitTask(taskData.id, function()
    taskItem:RefreshHalloweenTaskPicked()
  end)
end

function UIHalloween22Task:__OnJumpTarget(taskData)
  local jumpId = taskData.stcData.jump_id
  local jumpArgs = taskData.stcData.jumpArgs
  if jumpId == JumpManager.eJumpTarget.DynActivity and jumpArgs[1] == self._data:GetActFrameId() then
    local mainUI = UIManager:GetWindow(UIWindowTypeID.Halloween22Main)
    if mainUI ~= nil then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.Halloween22Main)
      mainUI:OnClickBattle()
    end
    return
  end
  if 0 < (jumpId or 0) then
    JumpManager:Jump(jumpId, function(jumpCallback)
      if jumpCallback ~= nil then
        jumpCallback()
      end
    end, nil, jumpArgs)
  end
end

function UIHalloween22Task:__TaskUpdate(taskData)
  for i, v in ipairs(self._taskItmePool.listItem) do
    if v:GetHalloweenTaskId() == taskData.id then
      v:RefreshHalloweenTask()
    end
  end
end

function UIHalloween22Task:__OnExpired(actId)
  if self._data:GetActId() == actId then
    self:__Refresh()
  end
end

function UIHalloween22Task:OnClickTaskClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHalloween22Task:OnCloseHalloweenTask()
  self:Delete()
end

function UIHalloween22Task:OnDelete()
  if self._delayItemCO ~= nil then
    GR.StopCoroutine(self._delayItemCO)
    self._delayItemCO = nil
  end
  self._taskItmePool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.ActivityHallowmasExpired, self.__OnExpiredCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  base.OnDelete(self)
end

return UIHalloween22Task
