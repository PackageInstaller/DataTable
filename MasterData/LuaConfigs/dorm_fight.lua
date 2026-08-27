local dorm_fight = {
  [0] = {}
}
local __default_values = {
  AcceleratedVelocity = 1.01,
  AttackAutoAdjustSqrDistance = 1.01,
  AttackShieldInterval = 1.01,
  AttackVitalityResumeRate = 50000,
  AttackedVitalityLoss = -150000,
  HitForceStrength = 100,
  HitShieldTime = 1.01,
  HitVitalityResumeRate = 0,
  HitWallVitalityLoss = -200000,
  IdleVitalityResumeRate = 300000,
  InitialVitality = 1000000,
  KnockOutBasicRatio = 0.25,
  KnockOutForceStrength = 400,
  KnockOutGetUpInterval = 0.5,
  KnockOutLieDownInterval = 2.01,
  KnockOutVitalityRate = 0.2,
  KnockOutVitalityResumeRate = 600000,
  MaxVitality = 1000000,
  MoveSpeed = 1.01,
  NegativeAcceleratedVelocity = -2.5,
  RatioUpRate = 2,
  RotateRatio = 0.5,
  RunSpeed = 2.5,
  RunVitalityResumeRate = -100000,
  WalkVitalityResumeRate = 150000,
  id = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(dorm_fight) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_fight, {__index = __rawdata})
return dorm_fight
