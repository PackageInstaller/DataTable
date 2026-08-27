local SkillLogicTimer = class("SkillLogicTimer")

function SkillLogicTimer:ctor(delay, func, obj, is_loop, start_time)
  if delay and func then
    self:Init(delay, func, obj, is_loop, start_time)
  end
end

function SkillLogicTimer:Init(delay, func, obj, is_loop, start_time)
  assert(type(delay) == "number" and 0 <= delay)
  assert(func ~= nil)
  self.delay = delay
  self.func = func
  self.obj = obj
  self.is_loop = is_loop or 0
  self.started = false
  self.left = delay - (start_time or 0)
  self.over = false
  self.obj_not_nil = obj and true or false
end

function SkillLogicTimer:Update()
  if not self.started or self.over then
    return
  end
  self.left = self.left - 1
  local timeup = self.left <= 0
  if timeup then
    if self.is_loop == 0 then
      self.over = true
    elseif 0 < self.is_loop then
      self.left = self.delay
      self.is_loop = self.is_loop - 1
    else
      self.left = self.delay
    end
    if self.obj_not_nil then
      self.func(self.obj)
    else
      self.func()
    end
  end
end

function SkillLogicTimer:Start()
  if not self.started then
    self.started = true
  end
  return self
end

function SkillLogicTimer:Pause()
  if self.started then
    self.started = false
  end
  return self
end

function SkillLogicTimer:Stop()
  self.left = 0
  self.is_loop = 0
  self.func = nil
  self.obj = nil
  self.started = false
  self.over = true
end

function SkillLogicTimer:IsOver()
  return self.over
end

function SkillLogicTimer:InjectLuaSkill(luaSkill)
  self.luaSkill = luaSkill
  self.luaSkill:AddTimer(self)
end

function SkillLogicTimer:RecycleInLuaSkill()
  if self.luaSkill ~= nil then
    self.luaSkill:RemoveTimer(self)
  end
end

return SkillLogicTimer
