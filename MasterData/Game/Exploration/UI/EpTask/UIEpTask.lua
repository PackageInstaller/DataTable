local UIEpTask = class("UIEpTask", UIBaseWindow)
local base = UIBaseWindow
local UINEpTaskItemDetail = require("Game.Exploration.UI.EpTask.UINEpTaskItemDetail")
local TaskData = require("Game.Task.Data.TaskData")

function UIEpTask:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.OnClickExit)
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.OnClickMap)
  self.ui.uINEpTaskItemDetail:SetActive(false)
  self.itemPool = UIItemPool.New(UINEpTaskItemDetail, self.ui.uINEpTaskItemDetail)
  self.__OnClickItemGet = BindCallback(self, self.OnClickItemGet)
  for id, count in pairs(ConfigData.game_config.epTaskGiveUpReward) do
    self.ui.priceText.text = tostring(count)
    break
  end
  self.ui.tex_MapBtnName:SetIndex(0)
end

function UIEpTask:InitEpTask(epCtrl, taskIdDic)
  self.ui.btn_Map.gameObject:SetActive(ExplorationManager:HasRoomSceneInEp())
  self.epCtrl = epCtrl
  self.itemPool:HideAll()
  if taskIdDic == nil or table.count(taskIdDic) == 0 then
    error("taskDic is empty")
    return
  end
  for id, _ in pairs(taskIdDic) do
    local taskData = PlayerDataCenter.allTaskData.taskDatas[id]
    if taskData == nil then
      local stcData = ConfigData.task[id]
      if stcData ~= nil then
        taskData = TaskData.CreatePickedTaskData(stcData)
      end
    end
    if taskData ~= nil then
      local item = self.itemPool:GetOne()
      item:InitTaskItem(taskData, self.__OnClickItemGet, 0)
    end
  end
end

function UIEpTask:OnClickMap()
  self.ui.frameNode:SetActive(not self.ui.frameNode.activeInHierarchy)
  self:RefreshBtnState()
end

function UIEpTask:OnClickExit()
  self.epCtrl:SendGiveUpTask()
end

function UIEpTask:OnClickItemGet(taskId)
  self.epCtrl:SendGetTask(taskId)
end

function UIEpTask:RefreshBtnState()
  local inRoom = self.ui.frameNode.activeInHierarchy
  self.ui.tex_MapBtnName:SetIndex(inRoom and 0 or 1)
end

function UIEpTask:GetDefaultSelectTaskId()
  if #self.itemPool.listItem > 0 then
    return self.itemPool.listItem[1].taskId
  end
  return 0
end

return UIEpTask
