local item = class("cellKiBoTaskItem", G_UIModuleBase)
local bg_KiBoStatus = {
  [1] = "UI/Atlas/ActivitySevenDaySign/tex_activity_kibo_icon02.png",
  [2] = "UI/Atlas/ActivitySevenDaySign/tex_activity_kibo_icon03.png",
  [3] = "UI/Atlas/ActivitySevenDaySign/tex_activity_kibo_icon04.png"
}

function item.bind()
  return {
    taskTitle = "",
    taskDescribe = "",
    totalCount = "",
    maxCount = "",
    img_KiBoStatus = "",
    rewardList = {
      moduleName = "pages/ActivityTask/cellStatusRewardItem"
    },
    show_receiveBtn = false,
    show_goto = false,
    show_received = false,
    show_progressing = false,
    text_goto = L_Lang:get(L_WordsTpl:getValue("ui_novice_task_goto")),
    text_inProgress = L_Lang:get(L_WordsTpl:getValue("ui_novice_task_inprogress")),
    text_receive = L_Lang:get(L_WordsTpl:getValue("ui_novice_task_receive")),
    text_finish = L_Lang:get(L_WordsTpl:getValue("ui_novice_task_complete")),
    active_content = true
  }
end

function item.methods()
  return {
    onClick_receive = function(self)
      self:emit("onClick_receiveNoviceTaskReward", self)
    end,
    onClick_goto = function(self)
      self:emit("onClick_goto", self.bind)
    end
  }
end

function item:open(...)
  self:refreshView()
  L_NoviceTaskStore:listenCallFunc(L_NoviceTaskStore.event.refreshNoviceTask, self.onEvent_refreshNoviceTask, self)
end

function item:close(...)
  L_NoviceTaskStore:unListenCallFunc(L_NoviceTaskStore.event.refreshNoviceTask, self.onEvent_refreshNoviceTask, self)
  L_TimerManager:clearTimer(self)
end

function item:hide()
end

function item:refresh()
  self:refreshView()
end

function item:refreshView()
  local taskInfosDic = L_NoviceTaskStore:getTaskInfosDic() or {}
  local taskTplDataDic = L_NoviceTaskStore:getTaskTplDataDic() or {}
  local taskInfos = taskInfosDic[self.bind.currentTaskGroupId] or {}
  local taskInfo = table.ipairsFind(taskInfos, function(value)
    return value.task_id == self.bind.taskId
  end)
  taskInfo = taskInfo or {}
  local taskTplData = taskTplDataDic[self.bind.taskId] or {}
  self.bind.taskTitle = taskTplData.title
  self.bind.taskDescribe = taskTplData.desc
  self.bind.count = taskInfo.task_value or 0
  self.bind.targetCount = taskTplData.maxProgress
  self.bind.itemReward = taskTplData.reward
  self.bind.finishState = taskInfo.task_status
  self.bind.systemJump = taskTplData.systemJump
  self:updateTaskData()
end

function item:updateTaskData()
  if self.bind.finishState == 2 then
    self.bindComponents.img_bgStatus:LoadSprite("UI/Texture/Activity/tex_activity_kibo_bg05.png", false)
    self.bind.img_KiBoStatus = bg_KiBoStatus[3]
    self.bind.show_received = true
    self.bind.show_receiveBtn = false
    self.bind.show_progressing = false
    self.bind.show_goto = false
  elseif self.bind.finishState == 0 then
    self.bindComponents.img_bgStatus:LoadSprite("UI/Texture/Activity/tex_activity_kibo_bg06.png", false)
    self.bind.img_KiBoStatus = bg_KiBoStatus[2]
    self.bind.show_received = false
    self.bind.show_receiveBtn = false
    self:checkSystemJump()
  elseif self.bind.finishState == 1 then
    self.bindComponents.img_bgStatus:LoadSprite("UI/Texture/Activity/tex_activity_kibo_bg07.png", false)
    self.bind.img_KiBoStatus = bg_KiBoStatus[1]
    self.bind.show_receiveBtn = true
    self.bind.show_received = false
    self.bind.show_progressing = false
    self.bind.show_goto = false
  end
  if self.bind.itemReward then
    local base_data = {}
    self.bind.rewardList:clear()
    for i, v in ipairs(self.bind.itemReward) do
      table.insert(base_data, {
        itemId = v[2],
        itemType = v[1],
        itemNum = v[3]
      })
    end
    self.bind.rewardList:insert_array(base_data)
  end
  self.bind.totalCount = string.format(self.bind.count <= self.bind.targetCount and self.bind.count or self.bind.targetCount)
  self.bind.maxCount = string.format(self.bind.targetCount)
end

function item:checkSystemJump()
  if math.isEmpty(self.bind.systemJump) then
    self.bind.show_goto = false
    self.bind.txt_progress = L_WordsTpl:getValue("ui_cellNoviceTaskItem_01")
    self.bind.show_progressing = true
  elseif L_JumpMgr:checkJumpFuncOpen(self.bind.systemJump) then
    self.bind.show_progressing = false
    self.bind.show_goto = true
  else
    self.bind.show_goto = false
    self.bind.txt_progress = L_WordsTpl:getValue("ui_cellNoviceTaskItem_02")
    self.bind.show_progressing = true
  end
end

function item:onClick()
  if not self.isBind then
    return
  end
  self.bind.show_received = true
  self.bindComponents.finish:Stop()
  self.bindComponents.finish:Play("anim_KT_cell_get")
  self.bind.show_receiveBtn = false
  self.bind.show_progressing = false
  self.bind.show_goto = false
end

function item:playCellOutVFX()
  if not self.isBind then
    return
  end
  self.bind.active_content = false
  L_TimerManager:stopTimer(self, "delayCallback")
end

function item:playCellInVFX(callback)
  if not self.isBind then
    L_TimerManager:stopTimer(self, "delayCallback")
    if callback then
      callback()
    end
    return
  end
  self.bind.active_content = true
  if L_DeviceTpl:getIsPc() then
    self.bindComponents.cellAni:Play("anim_KT_cell_in")
  else
    self.bindComponents.cellAni:Play("anim_KT_cell_in_mobile")
  end
  L_TimerManager:newOrResetTimer(self, "delayCallback", callback, 0.933)
end

function item:getTaskId()
  return self.bind.taskId
end

function item:onEvent_refreshNoviceTask()
  self:refreshView()
end

return item
