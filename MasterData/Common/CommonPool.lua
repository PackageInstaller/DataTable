local CommonPool = {}
CommonPool.__index = CommonPool

function CommonPool.New(NewFunc, ResetFunc)
  local self = {}
  self.__poollist = {}
  self.__newFunc = NewFunc
  self.__resetFunc = ResetFunc
  assert(self.__newFunc ~= nil, "new func must not be nil")
  setmetatable(self, CommonPool)
  return self
end

function CommonPool:PoolGet()
  if #self.__poollist > 0 then
    return table.remove(self.__poollist)
  end
  return self.__newFunc()
end

function CommonPool:PoolPut(ele)
  if self.__resetFunc ~= nil and not self.__resetFunc(ele) then
    return
  end
  table.insert(self.__poollist, ele)
end

function CommonPool:PoolClear()
  if #self.__poollist > 10 then
    self.__poollist = {}
    return
  end
  while #self.__poollist > 0 do
    table.remove(self.__poollist)
  end
end

return CommonPool
