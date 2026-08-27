local UINEventComebackSystemMain = class("UINEventComebackSystemMain", UIBaseNode)
local base = UIBaseNode
local UINEventComebackTaskItem = require("Game.ActivityComeback.UI.UINEventComebackTaskItem")
local JumpManager = require("Game.Jump.JumpManager")

function UINEventComebackSystemMain:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_TaskList, self, self.OnClickBtnTaskList)
end

function UINEventComebackSystemMain:RefreshComebackSystemMain(actData, moduleCfg, taskIds, resloader, refreshCallback)
  self.actData = actData
  self.resLoader = resloader
  self._refreshCallback = refreshCallback
  if not string.IsNullOrEmpty(moduleCfg.img_background) then
    local path = PathConsts:GetEventComebackPicPath(moduleCfg.img_background)
    self.resLoader:LoadABAssetAsync(path, function(texture)
      if texture == nil then
        return
      end
      self.ui.Img_Pic.texture = texture
    end)
  end
  self._taskIdList = taskIds
  self.ui.Btn_TaskList.gameObject:SetActive(#self._taskIdList > 1)
  self:RefreshSystemMainTaskItem()
  self.ui.Tex_CNTitle.text = LanguageUtil.GetLocaleText(moduleCfg.title)
  self.ui.Tex_SubTitle.text = LanguageUtil.GetLocaleText(moduleCfg.CN_subtitle)
  self.ui.Tex_ENTitle.text = LanguageUtil.GetLocaleText(moduleCfg.EN_deco)
  self.ui.Tex_Des.text = ConfigData:GetTipContent(moduleCfg.tip_des)
end

function UINEventComebackSystemMain:RefreshSystemMainTaskItem()
  table.sort(self._taskIdList, function(idA, idB)
    local a = PlayerDataCenter.allTaskData:GetTaskDataById(idA, true)
    local b = PlayerDataCenter.allTaskData:GetTaskDataById(idB, true)
    if a.isPicked ~= b.isPicked then
      return not a.isPicked
    end
    local aComplete = a:CheckComplete()
    if aComplete ~= b:CheckComplete() then
      return aComplete
    end
    return a.id < b.id
  end)
  local curShowTaskId = self._taskIdList[1]
  local curShowTaskData = PlayerDataCenter.allTaskData:GetTaskDataById(curShowTaskId, true)
  if self._taskItem == nil then
    self._taskItem = UINEventComebackTaskItem.New()
    self._taskItem:Init(self.ui.TaskItem)
  end
  self._taskItem:InitCombackTaskItem(curShowTaskData, BindCallback(self, self.OnClickTaskItem))
end

function UINEventComebackSystemMain:OnClickBtnTaskList()
  if self._taskIdList ~= nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.ActivityComebackSystemTaskWindow, function(window)
      if window == nil then
        return
      end
      window:InitComebackSystemTaskWindow(self._taskIdList, BindCallback(self, self.OnClickTaskItem))
    end)
  end
end

function UINEventComebackSystemMain:OnClickTaskItem(taskData, callback)
  if not taskData:CheckComplete() then
    local flag, jumpId, jumpArgs = taskData:GetTaskJumpArg()
    if flag then
      JumpManager:Jump(jumpId, nil, nil, jumpArgs)
    end
    return
  end
  local activityComebackCtrl = ControllerManager:GetController(ControllerTypeId.ActivityComeback)
  activityComebackCtrl:SendComebackNewSystemCommitTask(self.actData.id, taskData, function()
    local rewards, nums = taskData:GetTaskCfgRewards()
    for i = #rewards, 1, -1 do
      local itemCfg = ConfigData.item[rewards[i]]
      if itemCfg.type == eItemType.BattlePassPoint then
        table.remove(rewards, i)
        table.remove(nums, i)
      end
    end
    local CommonRewardData = require("Game.CommonUI.CommonRewardData")
    local CRData = CommonRewardData.CreateCRDataUseList(rewards, nums)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      window:AddAndTryShowReward(CRData)
    end)
    self:RefreshSystemMainTaskItem()
    if callback ~= nil then
      callback()
    end
    if self._refreshCallback ~= nil then
      self._refreshCallback()
    end
  end)
end

function UINEventComebackSystemMain:OnDelete()
  if self._taskItem ~= nil then
    self._taskItem:Delete()
  end
  base.OnDelete(self)
end

return UINEventComebackSystemMain
