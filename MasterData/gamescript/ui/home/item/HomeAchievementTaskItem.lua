local UI_Research_Panel_Challenge_ItemResource = require("UI.UIPackages.UI_Research_Panel_Challenge_ItemResource")
local System = require("System.System")
local LT = require("System.LangTable")
local DT = require("System.DataTable")
local TaskDataUtils = require("Data.TaskDataUtils")
local CommonDefine = require("World.Enums.CommonDefine")
local RedPointDataUtils = require("Data.RedPointDataUtils")
local AchievementTrophyType = CommonDefine.AchievementTrophyType
local AchievementHistoryDataType = CommonDefine.AchievementHistoryDataType
local TaskState = CommonDefine.TaskState
local TimeUtils = require("Utils.TimeUtils")
local MAX_REWARD_NUM = 3
local HomeAchievementTaskItem, Super = System.NewComponent("HomeAchievementTaskItem")

function HomeAchievementTaskItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Research_Panel_Challenge_ItemResource(uiNode)
  self.taskTid = data.taskTid
  self.taskUid = data.taskUid
  self.taskState = data.taskState
  self.model = data.model
  self.isReplaceText = data.isReplaceText
  self.taskCfg = DT.Task[self.taskTid]
  self.achieveHistoryDataFuncMap = {
    [AchievementHistoryDataType.AchieveCommemorativeData_Time] = self.ConvertTimeStamp,
    [AchievementHistoryDataType.AchieveCommemorativeData_Dmg] = self.ShowDirectly
  }
end

function HomeAchievementTaskItem:OnBind(binder)
  self:BindLeftDescPart(binder)
  self:BindMiddleRewardPart(binder)
  self:BindRightStatePart(binder)
end

function HomeAchievementTaskItem:BindLeftDescPart(binder)
  local trophyMap = {
    [AchievementTrophyType.Gold] = self.ui.Image_IconGold,
    [AchievementTrophyType.Silver] = self.ui.Image_IconSilver,
    [AchievementTrophyType.Bronze] = self.ui.Image_IconCopper
  }
  for type, obj in pairs(trophyMap) do
    binder:BindToVisible(obj, function()
      return type == self.taskCfg.AchieveQuality
    end)
  end
  binder:BindToText(self.ui.Text_Desc1, function()
    local rst = self.taskCfg.Name
    if self.taskCfg.ReplaceCondition and self.isReplaceText then
      rst = self.taskCfg.Name2
    end
    return rst
  end)
  binder:BindToText(self.ui.Text_Desc2, function()
    local rst = self.taskCfg.Desc
    if self.taskCfg.ReplaceCondition and self.isReplaceText then
      rst = self.taskCfg.Desc2
    end
    return rst
  end)
  binder:BindToTextColor(self.ui.Text_Desc2, function()
    if self.taskState == TaskState.Done then
      return CommonDefine.ColorType.Light
    end
    return CommonDefine.ColorType.Dark
  end)
  binder:BindToText(self.ui.Text_Count, function()
    local taskData = TaskDataUtils.GetTaskData(self.taskUid)
    local totalProgress = TaskDataUtils.GetTaskProgressLimit(taskData.tid)
    do return LT.Text, string.format("%s/%s", math.min(taskData.count, totalProgress), totalProgress) end
    return LT.Text, string.format("%s/%s", math.min(taskData.count, totalProgress), totalProgress)
  end)
end

function HomeAchievementTaskItem:BindMiddleRewardPart(binder)
  local rewardGroup = TaskDataUtils.GetTaskCompleteAward(self.taskTid)
  for i = 1, MAX_REWARD_NUM do
    local obj = self.ui["Article_" .. i]
    obj:SetActive(i <= #rewardGroup)
    if i <= #rewardGroup then
      local data = rewardGroup[i]
      local itemData = {
        itemTid = data.tid,
        itemCount = data.num,
        isGotFunc = function()
          return self.taskState == TaskState.Done
        end
      }
      binder:BindComponent(require("UI.Public.Item.CommonIconItemType2")(obj, itemData))
    end
  end
end

function HomeAchievementTaskItem:BindRightStatePart(binder)
  binder:BindToVisible(self.ui.Group_Nor, function()
    return self.taskState == TaskState.Receive or self.taskState == TaskState.Doing
  end)
  binder:BindToVisible(self.ui.Group_Over, function()
    return self.taskState == TaskState.Done
  end)
  binder:BindToVisible(self.ui.Btn_Get, function()
    return self.taskState == TaskState.Receive
  end)
  binder:BindZ1Button(self.ui.Btn_Get, System.fn(self, self.OnTaskReceive), nil, function()
    do return LT.Text end
    return LT.Text, "TaskModule_btn_reward"
  end, function()
    return RedPointDataUtils.RedAttrType.Red
  end)
  binder:BindToText(self.ui.Text_Accomplish, function()
    local showVal = ""
    if self.taskCfg.AchieveCommemorativeData then
      showVal = DT.CommonID[self.taskCfg.AchieveCommemorativeData].Desc
    end
    do return LT.Text end
    return LT.Text, showVal
  end)
  binder:BindToText(self.ui.Text_Num, function()
    local taskData = TaskDataUtils.GetTaskData(self.taskUid)
    local historyData = taskData.historyData
    local handleFunc = self.achieveHistoryDataFuncMap[self.taskCfg.AchieveCommemorativeData]
    local showVal = ""
    if handleFunc then
      showVal = handleFunc(historyData)
    end
    do return LT.Text end
    return LT.Text, showVal
  end)
end

function HomeAchievementTaskItem:OnTaskReceive()
  TaskDataUtils.TaskComplete(self.taskUid)
end

function HomeAchievementTaskItem.ConvertTimeStamp(historyData)
  local y, m, d = TimeUtils.GetTimestampYmdHMS(tonumber(historyData))
  do return string.format, "%s-%s-%s", y, m end
  return string.format, "%s-%s-%s", y, m, d
end

function HomeAchievementTaskItem.ShowDirectly(historyData)
  return historyData
end

return HomeAchievementTaskItem
