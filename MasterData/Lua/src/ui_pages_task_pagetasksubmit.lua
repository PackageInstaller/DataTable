local page = class("pageTaskSubmit", G_UIPageBase)

function page:bind()
  return {
    moduleSubtask = {
      moduleName = "pages/task/moduleSubtaskBox"
    },
    isTask = false
  }
end

function page:methods()
  return {
    onClickClose = function(self)
      L_UI:close(self.pageName, {
        backName = "pageMainCity"
      })
      if self.callBack then
        self.callBack()
      end
    end
  }
end

function page:preOpen(options)
  self.super.preOpen(self, options)
  self.entityId = options.entityId
  self.taskId = options.taskId
  self.nodeId = options.nodeId
  self:initModule()
end

function page:escHandle()
  L_UI:close(self.pageName)
end

function page:close()
end

function page:initModule()
  local subItemData = L_TaskManager:getNeedSubItem(self.entityId, self.taskId, self.nodeId)
  self.bind.isItems = false
  self.bind.isTask = true
  self.modules.moduleSubtask:initData(self.taskId, self.nodeId, subItemData)
end

function page:loadVirtualCamera()
  printf("大世界", "npc逻辑删除，请优化此代码逻辑")
end

function page:unloadVirtualCamera()
end

return page
