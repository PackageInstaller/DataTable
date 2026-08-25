local RedDotOrFlow, Super = System.NewPoolClass("RedDotOrFlow", RedDotBaseFlow)

function RedDotOrFlow:ctor(redDotId, redDotDesc)
  Super.ctor(self, redDotId, redDotDesc)
end

function RedDotOrFlow:Execute()
  for i, child in ipairs(self._children) do
    local result = child:Execute()
    if self:IsValidRedDot(result) then
      return result
    end
  end
  return false
end

return RedDotOrFlow
