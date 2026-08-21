_class("TrapSelfDestroyParam", Object)
TrapSelfDestroyParam = TrapSelfDestroyParam

function TrapSelfDestroyParam:Constructor(num)
  self._num = num
end

function TrapSelfDestroyParam:GetNum()
  return self._num
end

function TrapSelfDestroyParam:NextNum()
  self._num = self._num - 1
end

function TrapSelfDestroyParam:AddNum(value)
  value = value or 1
  self._num = self._num + value
end
