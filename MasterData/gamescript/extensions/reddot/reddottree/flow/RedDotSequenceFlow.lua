local RedDotType_Red = RedDotDefine.RedDotType.Red
local RedDotSequenceFlow, Super = System.NewPoolClass("RedDotSequenceFlow", RedDotBaseFlow)

function RedDotSequenceFlow:ctor(redDotId, redDotDesc)
  Super.ctor(self, redDotId, redDotDesc)
end

function RedDotSequenceFlow:Execute()
  local rstDict = {}
  for _, child in ipairs(self._children) do
    local rst = child:Execute()
    if self:IsValidRedDot(rst) then
      if type(rst) == "boolean" then
        rstDict[RedDotType_Red] = true
      else
        if rst == RedDotDefine.RedDotType.New then
          return rst
        end
        rstDict[rst] = true
      end
    end
  end
  for _, dotType in ipairs(RedDotDefine.RedDotPriority) do
    if rstDict[dotType] then
      return dotType
    end
  end
  return false
end

return RedDotSequenceFlow
