local UINWhiteDayTaskItem = class("UINWhiteDayTaskItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")

function UINWhiteDayTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self.__OnClickJump)
  UIUtil.AddButtonListener(self.ui.btn_Complete, self, self.__OnClickComplete)
end

function UINWhiteDayTaskItem:InitWDTaskItem(AWDCtrl, taskId, isMult, multRateText, multRate, isEndless, completeTask)
  self.AWDCtrl = AWDCtrl
  local taskData = PlayerDataCenter.allTaskData.taskDatas[taskId]
  local taskCfg = ConfigData.task[taskId]
  if taskCfg == nil then
    return
  end
  self.taskId = taskId
  self.isMult = isMult
  self.multRate = multRate
  self.taskData = taskData
  self.taskCfg = taskCfg
  self.isEndless = isEndless
  self.completeTask = completeTask
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(taskCfg.name)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(taskCfg.task_intro)
  local rewardId, rewardNum
  for index, itemId in pairs(taskCfg.rewardIds) do
    rewardId = itemId
    rewardNum = taskCfg.rewardNums[index]
    break
  end
  self.ui.tex_Count:SetIndex(0, tostring(rewardNum))
  self.ui.img_Icon.sprite = CRH:GetSpriteByItemId(rewardId)
  if taskData == nil then
    self.ui.slider_progress.value = 1
    self.ui.img_Completed:SetActive(true)
    self.ui.btn_Jump.gameObject:SetActive(false)
    self.ui.btn_Complete.gameObject:SetActive(false)
    self.ui.tex_ProgressBar.gameObject:SetActive(false)
    self.ui.tex_Complete:SetActive(true)
  else
    local isComplete = taskData:CheckComplete()
    self.ui.img_Completed:SetActive(false)
    self.ui.btn_Jump.gameObject:SetActive(not isComplete)
    self.ui.btn_Complete.gameObject:SetActive(isComplete)
    self.ui.tex_ProgressBar.gameObject:SetActive(not isComplete)
    self.ui.tex_Complete:SetActive(isComplete)
    if isComplete then
      self.ui.slider_progress.value = 1
    else
      local schedule, aim = taskData:GetTaskProcess()
      self.ui.tex_ProgressBar:SetIndex(0, tostring(schedule), tostring(aim))
      self.ui.slider_progress.value = schedule / aim
    end
  end
  self.ui.obj_MultLabel:SetActive(isMult)
  if isMult then
    self.ui.tex_MultLabel.text = multRateText
  end
end

function UINWhiteDayTaskItem:__OnClickJump()
  if self.taskCfg == nil then
    return
  end
  
  local function Jump()
    local jumpId = self.taskCfg.jump_id
    local jumpArgs = self.taskCfg.jumpArgs
    if jumpId ~= nil and 0 < jumpId then
      JumpManager:Jump(jumpId, function(jumpCallback)
        UIUtil.OnClickBackByUiTab(self)
        if jumpCallback ~= nil then
          jumpCallback()
        end
      end, nil, jumpArgs)
    end
  end
  
  local game2048Ctrl = self.AWDCtrl:GetWD2048GameCtrl()
  if game2048Ctrl ~= nil and game2048Ctrl:IsGame2048Started() then
    CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(7200), function()
      Jump()
    end, nil)
    return
  end
  Jump()
end

function UINWhiteDayTaskItem:__OnClickComplete()
  if self.completeTask ~= nil then
    self.completeTask(self)
  end
end

function UINWhiteDayTaskItem:OnDelete()
  base.OnDelete(self)
end

return UINWhiteDayTaskItem
