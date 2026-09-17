local this = class("conditionNode")
local m_hashCode = 0

local function _generateNew(obj)
  m_hashCode = m_hashCode + 1
  return m_hashCode
end

function this.checkFunc(codData)
  return false
end

function this:ctor(condition)
  self.hashCode = _generateNew(self)
  self:init(condition)
  self.state = false
  self.belong = {}
  self.callBack = {}
end

function this:init(condition)
  self.condition = condition
end

function this:getCondition()
  return self.condition
end

function this:getType()
  return self.condition[2]
end

function this:getHashCode()
  return self.hashCode
end

function this:getState()
  return self.state
end

function this:getBelong()
  return self.belong
end

function this:isComplete()
  return self.checkFunc(self.condition)
end

function this.descFunc(key, codData)
  return L_Lang:get(key, {
    value = codData[2]
  })
end

function this:isAutoDestroy()
  return self.autoDestroy ~= false
end

function this:setIsAutoDestroy(autoDestroy)
  self.autoDestroy = autoDestroy
end

function this:addListener(key, func, register, obj)
  if func == nil then
    error("error condition callback")
    return
  end
  local eventNode = {
    func = func,
    register = register,
    obj = obj
  }
  self.callBack[key] = eventNode
end

function this:removeListener(key)
  self.callBack[key] = nil
end

function this:isListenerEmpty()
  return table.isEmpty(self.callBack)
end

function this:addBelong(belong)
  self.belong[belong] = belong
end

function this:refresh()
  local state = self:refreshState(self:isComplete())
  return state
end

function this:refreshState(state)
  local isChanged = state ~= self.state
  self.state = state
  if isChanged then
    for i, v in pairs(self.callBack) do
      local isDo = true
      if v.obj and v.obj:IsNull() then
        self:removeListener(i)
        isDo = false
      end
      if isDo then
        if v.register then
          v.func(v.register, self.state, table.unpack(self.condition))
        else
          v.func(self.state, table.unpack(self.condition))
        end
      end
    end
    for _, v in pairs(self.belong) do
      v:refresh()
    end
  end
  if state and (self:isAutoDestroy() or self:isListenerEmpty()) then
    L_ConditionManager:removeConditionNode(self)
  end
  return state
end

function this:onDestroy()
end

return this
