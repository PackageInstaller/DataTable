local this = class("cellTaskProgressLine", G_UIModuleBase)

function this.bind()
  return {
    active_star = false,
    active_curStar = false,
    txt_num = ""
  }
end

function this.methods()
  return {}
end

function this:open()
  self.taskNum = self.bind.taskNum
  self.curProgress = self.bind.curProgress
  self.isShowEndStar = self.bind.isShowEndStar
end

function this:refresh()
  self.bind.txt_num = tostring(self.taskNum)
  self:refreshProcessStar()
end

function this:refreshProcessStar()
  if self.isShowEndStar then
    self.bind.active_curStar = true
    self.bind.active_star = false
  else
    self.bind.active_curStar = false
    self.bind.active_star = true
  end
end

return this
