require("state")
_class("N28StateAVGGraphBase", State)
N28StateAVGGraphBase = N28StateAVGGraphBase

function N28StateAVGGraphBase:Init()
  self.fsm = self:GetFsm()
  self.ui = self.fsm:GetData()
  self.data = self.ui.data
end

function N28StateAVGGraphBase:Destroy()
  N28StateAVGGraphBase.super.Destroy(self)
  self.ui = nil
end

function N28StateAVGGraphBase:GetScrollView()
  return self.ui.rtSV
end

function N28StateAVGGraphBase:GetContent()
  return self.ui.rtContent
end
