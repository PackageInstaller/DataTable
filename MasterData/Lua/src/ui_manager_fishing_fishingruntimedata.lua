local this = class("fishingRuntimeData")

function this:ctor(pointId)
  self.fishPointId = pointId
  self.rodId = nil
  self.rodObj = nil
  self.fishWireNode = nil
  self.fishWireObj = nil
  self.fishWireLineRender = nil
  self.pondEffectRoot = nil
  self.pondEffectMap = {}
  self.fishShadowObj = nil
  self.isFishingLoop = false
  self.startTimeLineObj = nil
  self.timeLineObj = nil
  self.fishWireUpdateHandler = nil
  self.floatAnimator = nil
  self.fishDirection = L_FishingConst.FishMoveDir.Center
  self.fishDirectionPoint = {}
  self.curFishStartPoint = nil
  self.fishMoveTimeFrame = 0
  self.loopAudio = nil
end

return this
