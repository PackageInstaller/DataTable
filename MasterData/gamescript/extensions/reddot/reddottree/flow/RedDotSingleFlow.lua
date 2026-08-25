local RedDotSingleFlow, Super = System.NewPoolClass("RedDotSingleFlow", RedDotBaseFlow)

function RedDotSingleFlow:ctor(redDotDesc)
  Super.ctor(self, nil, redDotDesc)
end

function RedDotSingleFlow:AddChild(child)
  if child then
    if self._children[1] then
      self._children[1].parent = nil
      self._children[1]:Release()
    end
    self._children[1] = child
    child.parent = self
  end
end

function RedDotSingleFlow:RemoveChild(child)
  if self._children[1] == child then
    self._children[1] = nil
    child.parent = nil
    child:Release()
  end
end

return RedDotSingleFlow
