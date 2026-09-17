local this = class("moduleSubmitBase", G_UIModuleBase)

function this:initData(taskId, nodeId, subData)
  self.taskId = taskId
  self.nodeId = nodeId
  self.subData = subData
  self.subType = subData.showType
  self:initUI()
end

function this:initUI()
end

return this
