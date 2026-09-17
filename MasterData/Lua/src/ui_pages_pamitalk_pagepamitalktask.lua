local this = class("pagePamiTalkTask", G_UIPageBase)

function this.bind()
  return {getTaskText = "", taskTitleText = ""}
end

function this.methods()
  return {
    onClick_gotoBtn = function(self)
      L_UI:open("pageTask", {
        taskId = self.options.taskId
      })
      L_UI:close(self.pageName)
    end,
    onClick_laterBtn = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  self.options = options
  this.super.preOpen(self, options)
  self:updatePage()
end

function this:updatePage()
  local taskTpl = L_GameTpl:getTaskTpl()
  local tpl = taskTpl:getTplById(self.options.taskId)
  self.bind.taskTitleText = L_Config:provider(taskTpl:getName(tpl))
  self.bind.getTaskText = L_WordsTpl:getValue(L_PamiTalkManager.text.pami_task_tips)
end

function this:close(options)
  this.super.close(self, options)
end

return this
