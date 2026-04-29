_class("BouncePlayerData", Object)
BouncePlayerData = BouncePlayerData

function BouncePlayerData:Constructor()
  BouncePlayerData.DebugIns = self
end

BouncePlayerData.DebugIns = nil

function BouncePlayerData:Init()
  local cfg = Cfg.cfg_bounce_const[1]
  if not cfg then
    Log.error("BouncePlayerData err：can't find cfg_bounce_const id = 1")
    return
  end
  self.initPos = Vector2(cfg.BirthPos[1], cfg.BirthPos[2])
  self.gSpeed = cfg.GSpeed
  self.baseJumpSpeed = cfg.BaseJumpSpeed
  self.accDownSpeed = cfg.AccDownSpeed
  self.speedWhenAttackAtDown = cfg.SpeedWhenAttackAtDown
  self.speedWhenAttackAtAccDown = cfg.SpeedWhenAttackAtAccDown
  self.airJumpSpeed = cfg.AirJumpSpeed
  self.attckCD = cfg.AttckCD
  self.airAttackCD = cfg.AirAttackCD
  self.jumpCD = cfg.JumpCD or 0
  self.camp = BounceCamp.Player
  self.initHp = 1
  self.ap = 1
  self:Reset()
end

function BouncePlayerData:GetInitPos()
  return Vector2(self.initPos.x, self.initPos.y)
end

function BouncePlayerData:Reset()
  self.curHp = self.initHp
  self.curSpeed = 0
  self.lastAttackMs = 0
  self.lastAirAttackMs = 0
  self.lastJumpMs = 0
end

function BouncePlayerData:CheckAttackCD(duration, setAttackDuration)
  local ret = false
  if self.lastAttackMs == 0 then
    ret = true
  else
    ret = duration - self.lastAttackMs >= self.attckCD
  end
  if ret and setAttackDuration then
    self.lastAttackMs = duration
  end
  return ret
end

function BouncePlayerData:ChecAirkAttackCD(duration, setAttackDuration)
  local ret = false
  if self.lastAirAttackMs == 0 then
    ret = true
  else
    ret = duration - self.lastAirAttackMs >= self.airAttackCD
  end
  if ret and setAttackDuration then
    self.lastAirAttackMs = duration
  end
  return ret
end

function BouncePlayerData:ChecJumpCD(duration, setDuration)
  local ret = false
  if self.lastJumpMs == 0 then
    ret = true
  else
    ret = duration - self.lastJumpMs >= self.jumpCD
  end
  if ret and setDuration then
    self.lastJumpMs = duration
  end
  return ret
end
