local item = class("cellActivityTaskReceiveAll", G_UIModuleBase)

function item.bind()
  return {
    txt_receive = L_WordsTpl:getValue("ui_cellNoviceTaskItem_05")
  }
end

function item.methods()
  return {
    onClick_receive = function(self)
      self:emit("onClick_receive", self.bind)
    end
  }
end

function item:open(...)
  self:updateTaskData()
end

function item:hide()
end

function item:refresh()
  self:updateTaskData()
end

function item:updateTaskData()
  if math.isEmpty(self.bind.curActivityId) then
    self.bind.txt_receive = L_WordsTpl:getValue("ui_cellNoviceTaskItem_05")
  end
end

return item
