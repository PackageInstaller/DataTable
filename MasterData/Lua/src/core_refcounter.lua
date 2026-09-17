local cls = class("refCounter")

function cls:ctor(onHandler, offHandler, tag)
  self._refCount = 0
  self.onHandler = onHandler
  self.offHandler = offHandler
  self.tag = tag
end

function cls:reset()
  self._refCount = 0
  self.onHandler = nil
  self.offHandler = nil
  self.tag = nil
end

function cls:getRefCount()
  return self._refCount
end

function cls:retain()
  if self._refCount < 0 then
    errorf("[refCounter.retain] refCount < 0. Check your logic!")
    return
  end
  self._refCount = self._refCount + 1
  if self._refCount == 1 and self.onHandler then
    self.onHandler(self.tag)
  end
end

function cls:release()
  if self._refCount <= 0 then
    errorf("[refCounter.release] refCount <= 0. Check your logic!")
    return
  end
  self._refCount = self._refCount - 1
  if self._refCount == 0 and self.offHandler then
    self.offHandler(self.tag)
  end
end

return cls
