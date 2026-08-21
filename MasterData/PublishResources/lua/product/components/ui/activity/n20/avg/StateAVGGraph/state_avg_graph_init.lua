_class("StateAVGGraphInit", StateAVGGraphBase)
StateAVGGraphInit = StateAVGGraphInit

function StateAVGGraphInit:OnEnter(TT, ...)
  self:Init()
end

function StateAVGGraphInit:OnExit(TT)
end
