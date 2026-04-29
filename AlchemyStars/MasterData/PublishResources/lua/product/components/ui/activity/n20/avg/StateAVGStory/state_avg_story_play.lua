_class("StateAVGStoryPlay", StateAVGStoryBase)
StateAVGStoryPlay = StateAVGStoryPlay

function StateAVGStoryPlay:OnEnter(TT, ...)
  self:Init()
end

function StateAVGStoryPlay:OnExit(TT)
end

function StateAVGStoryPlay:OnUpdate(deltaTimeMS)
  self:UpdateDriveByState(deltaTimeMS)
end
