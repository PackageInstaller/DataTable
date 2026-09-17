local this = class("pageGetTask", G_UIPageBase)
local _TaskTpl = L_GameTpl:getTaskTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {taskId = 0}
end

function this.bind()
  return {txt_title = "", txt_content = ""}
end

function this.methods()
  return {
    onClick_acceptTask = function(self)
      if self.data.taskId and self.data.taskId ~= 0 then
        L_UI:backToRoot()
        C_TaskStore.ReqGetTaskAcceptLua(self.data.taskId)
      end
    end,
    onClick_back = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  self.options = options
  self:setTaskInfo()
end

function this:setTaskInfo()
  local taskId = self.options.taskId
  self.data.taskId = taskId
  local tplTask = _TaskTpl:getTplById(taskId)
  if tplTask then
    self.bind.txt_title = _TaskTpl:getName(tplTask)
    self.bind.txt_content = _TaskTpl:getDesc(tplTask)
  end
end

return this
