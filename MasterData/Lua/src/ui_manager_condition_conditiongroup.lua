local this = class("conditionGroup", require(L_R.condition .. "conditionNode"))

function this:init(conditionBox)
  self.codQueue = {}
  self.codDic = {}
  self.condition = self.codDic
  for _, v in ipairs(conditionBox) do
    v:addBelong(self)
    self:append(v)
  end
end

function this:getCondition()
  return self.codDic
end

function this:getType()
  return L_CodConst.enum.group
end

function this:getState(isRefresh)
  if isRefresh then
    return self:search("getState")
  else
    return self.state
  end
end

function this:isComplete()
  return self:search("isComplete")
end

function this:refresh(isForce)
  local state = isForce and self:refreshState(self:isComplete()) or self:refreshState(self:getState(true))
  return state
end

function this:onDestroy()
  this.super.onDestroy(self)
end

function this:setHashKey(hashKey)
  self.hashKey = hashKey
end

function this:getHashKey()
  return self.hashKey
end

function this:search(methodName)
  local function _match(v)
    return v[methodName](v)
  end
  
  for _, v in ipairs(self.codQueue) do
    if not table.find(v, _match) then
      return false
    end
  end
  return true
end

function this:getLength()
  return #self.codQueue
end

function this:append(condition)
  local index = self:getLength()
  self:insert(index + 1, condition)
  return index
end

function this:insert(index, condition)
  if self.codQueue[index] == nil then
    self.codQueue[index] = {}
  end
  self.codQueue[index][condition] = condition
  self.codDic[condition] = index
end

function this:removeNode(node)
  local index = self.codDic[node]
  if index == nil then
    return
  end
  self.codQueue[index][node] = nil
  if not next(self.codQueue[index]) then
    self.codQueue[index] = nil
  end
  self.codDic[node] = nil
end

return this
