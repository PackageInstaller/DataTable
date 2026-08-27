local SmashingPenguinsCtrlBase = class("SmashingPenguinsCtrlBase")

function SmashingPenguinsCtrlBase:ctor(owner)
  self.owner = owner
  table.insert(owner.ctrls, self)
  self:OnInit()
end

function SmashingPenguinsCtrlBase:OnInit()
end

function SmashingPenguinsCtrlBase:OnGamePrepare()
end

function SmashingPenguinsCtrlBase:OnGameStart()
end

function SmashingPenguinsCtrlBase:OnGameEnd()
end

return SmashingPenguinsCtrlBase
