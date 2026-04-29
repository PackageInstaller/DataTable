_class("FlagValue", Object)
FlagValue = FlagValue

function FlagValue:Constructor(n)
  self._flags = n or 0
end

function FlagValue:SetFlag(flag)
  if flag < 0 or 63 < flag then
    error("flag value set flag 0-63 overflow")
    return
  end
  self._flags = self._flags | 1 << flag
end

function FlagValue:ResetFlag(flag)
  if flag < 0 or 63 < flag then
    error("flag value set flag 0-63 overflow")
    return
  end
  self._flags = self._flags & ~(1 << flag)
end

function FlagValue:CheckFlag(flag)
  if flag < 0 or 63 < flag then
    Log.error("flag value set flag 0-63 overflow")
    return false
  end
  return 0 < self._flags & 1 << flag
end

function FlagValue:Clear()
  self._flags = 0
end

function FlagValue:Get()
  return self._flags
end
