_class("StateAVGGraphBase", State)
StateAVGGraphBase = StateAVGGraphBase

function StateAVGGraphBase:Init()
  self.fsm = self:GetFsm()
  self.ui = self.fsm:GetData()
  self.data = self.ui.data
end

function StateAVGGraphBase:Destroy()
  StateAVGGraphBase.super.Destroy(self)
  self.ui = nil
end

function StateAVGGraphBase:GetScrollView()
  return self.ui.rtSV
end

function StateAVGGraphBase:GetContent()
  return self.ui.rtContent
end
