_class("UIPetSortContext", Object)
UIPetSortContext = UIPetSortContext

function UIPetSortContext:Constructor()
  self._viceElement = false
  self._curElement = 0
end

function UIPetSortContext:CurElement()
  return self._curElement
end

function UIPetSortContext:SetElement(element)
  self._curElement = element
end

function UIPetSortContext:SetViceElement(active)
  self._viceElement = active
end

function UIPetSortContext:ShowViceElement()
  return self._viceElement
end

UIPetSortContext.Instance = nil

function UIPetSortContext.CreateInstance()
  if UIPetSortContext.Instance then
    Log.exception("不可以创建多个实例")
  end
  UIPetSortContext.Instance = UIPetSortContext:New()
end

function UIPetSortContext.ClearInstance()
  UIPetSortContext.Instance = nil
end
