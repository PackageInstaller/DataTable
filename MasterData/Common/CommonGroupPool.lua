local CommonGroupPool = {}
CommonGroupPool.__index = CommonGroupPool

function CommonGroupPool.New(NewFunc, ResetFunc)
  local self = {}
  self.__poolKeylist = {}
  self.__newFunc = NewFunc
  self.__resetFunc = ResetFunc
  setmetatable(self, CommonGroupPool)
  return self
end

function CommonGroupPool:PoolGet(key)
  local poolList = self.__poolKeylist[key]
  if poolList ~= nil and 0 < #poolList then
    return table.remove(poolList)
  end
  if self.__newFunc == nil then
    return nil
  end
  return self.__newFunc(key)
end

function CommonGroupPool:PoolPut(key, ele)
  local poolList = self.__poolKeylist[key]
  if poolList == nil then
    poolList = {}
    self.__poolKeylist[key] = poolList
  end
  if self.__resetFunc ~= nil and not self.__resetFunc(ele) then
    return
  end
  table.insert(poolList, ele)
end

function CommonGroupPool:PoolClear()
  self.__poolKeylist = {}
end

function CommonGroupPool:PoolClearKey(key)
  self.__poolKeylist[key] = nil
end

return CommonGroupPool
