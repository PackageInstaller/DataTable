local RedDotBaseFlow, Super = System.NewPoolClass("RedDotBaseFlow")

function RedDotBaseFlow:ctor(redDotId, redDotDesc)
  self._children = {}
  self.parent = nil
  self.redDotId = redDotId
  self.redDotDesc = redDotDesc
end

function RedDotBaseFlow:Execute()
  return false
end

function RedDotBaseFlow:Release()
  if self._children then
    for i, c in ipairs(self._children) do
      c:Release()
    end
  end
  Super.Release(self)
end

function RedDotBaseFlow:AddChild(child)
  if child then
    table.insert(self._children, child)
    child.parent = self
  end
end

function RedDotBaseFlow:RemoveChild(child)
  for i, c in ipairs(self._children) do
    if c == child then
      table.remove(self._children, i)
      child.parent = nil
      child:Release()
      break
    end
  end
end

function RedDotBaseFlow:GetChildren()
  return self._children
end

function RedDotBaseFlow:ClearChildren()
  for _, child in ipairs(self._children) do
    child.parent = nil
    child:Release()
  end
  self._children = {}
end

function RedDotBaseFlow:IsValidRedDot(result)
  if type(result) == "boolean" and result then
    return true
  end
  do return table.contains, RedDotDefine.RedDotType end
  return table.contains, RedDotDefine.RedDotType, result
end

function RedDotBaseFlow:GetServerRedStatus(svrRedType, args)
  local rst = RedPointDataUtils.GetRedPointState(svrRedType, args)
  if rst then
    if type(rst) == "boolean" then
      return rst
    end
    return RedDotDefine.OldRedAttrType2RedDotTypeDict[rst]
  end
end

return RedDotBaseFlow
