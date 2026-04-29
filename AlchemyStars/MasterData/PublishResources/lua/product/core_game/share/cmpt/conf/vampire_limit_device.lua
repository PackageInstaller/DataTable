_class("VampireLimitDevice", Object)
VampireLimitDevice = VampireLimitDevice

function VampireLimitDevice:Constructor()
  self._limitMaxHP = 0.01
  self._baseHP = 0
  self._switch = false
  self._fromSkill = true
end

function VampireLimitDevice:ConsumeLimit(consumeValue)
  if not self._switch then
    return nil
  end
  if self._limitMaxHP <= 0.01 then
    return 0.01
  end
  local ret = 0.01
  if self._limitMaxHP >= consumeValue + self._baseHP then
    ret = consumeValue + self._baseHP
    self._limitMaxHP = self._limitMaxHP - ret
  else
    ret = self._limitMaxHP
    self._limitMaxHP = 0.01
  end
  self._baseHP = 0
  return ret
end

function VampireLimitDevice:SetLimit(baseVampireHP, maxVampireHP, fromSkill)
  if self._switch then
    Log.fatal("当真要重复设置吸血参数？")
  end
  self._switch = true
  self._baseHP = baseVampireHP
  if maxVampireHP <= 0 then
    self._limitMaxHP = 999999999
  else
    self._limitMaxHP = maxVampireHP
  end
  self._fromSkill = fromSkill
end

function VampireLimitDevice:Status()
  return self._switch, self._fromSkill
end
