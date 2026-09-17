local this = class("conditionManager")
local _nodePath = L_R.condition .. "node.conditionNode_"
local _conditionTpl = L_GameTpl:getCommonConditionTpl()
local _wordsTpl = L_GameTpl:getWordsTpl()

function this:ctor()
  self.codDic = {}
  self.codGroupDic = {}
  self.codCls = {}
end

function this:regist(key, codNode, callback, register, obj)
  local result = self:singleIsComplete(codNode)
  if result then
    if register then
      callback(register, true)
    else
      callback(true)
    end
  end
  if not result then
    local node = self:getConditionNode(codNode, true)
    node:addListener(key, callback, register, obj)
    return node
  end
end

function this:registPermanent(key, codNode, callback, register, obj)
  local result = self:singleIsComplete(codNode)
  if result and callback then
    if register then
      callback(register, true, table.unpack(codNode))
    else
      callback(true, table.unpack(codNode))
    end
  end
  local node = self:getConditionNode(codNode, true)
  node:setIsAutoDestroy(false)
  node:addListener(key, callback, register, obj)
  return node
end

function this:unRegist(node, key)
  if node == nil then
    return
  end
  node:removeListener(key)
  if node:isListenerEmpty() then
    if node:getType() == L_CodConst.enum.group then
      self:removeConditionGroup(node)
    else
      self:removeConditionNode(node)
    end
  end
end

function this:registGroup(key, codGrop, callback, register, obj)
  local node
  local result = true
  if not table.isEmpty(codGrop) then
    local nodeBox = {}
    for _, v in ipairs(codGrop) do
      local isComplete = self:singleIsComplete(v)
      result = result and isComplete
      if isComplete then
      else
        self:hashInsert(nodeBox, self:getConditionNode(v, true))
      end
    end
    local nodeCount = #nodeBox
    if nodeCount == 1 then
      node = nodeBox[1]
    elseif 1 < nodeCount then
      node = self:getConditionGroup(nodeBox, true)
    end
  end
  if result and callback then
    if register then
      callback(register, true)
    else
      callback(true)
    end
  end
  if node then
    node:addListener(key, callback, register, obj)
    return node
  end
end

function this:clear()
  for _, v in pairs(self.codGroupDic) do
    self:removeConditionGroup(v)
  end
  for _, v in pairs(self.codDic) do
    self:removeConditionNode(v)
  end
end

function this:getCls(codType)
  local cls = self.codCls[codType]
  if cls == nil then
    cls = require(_nodePath .. codType)
    self.codCls[codType] = cls
  end
  return cls
end

function this:createConditionNode(codData)
  local node = self:getCls(codData[1]).new(codData)
  return node
end

function this:getConditionNode(codData, isCreate)
  local sourceData = self.codDic
  local length = #codData
  for i = 1, length do
    local key = codData[i]
    if sourceData[key] == nil and isCreate then
      sourceData[key] = {}
    end
    sourceData = sourceData[key]
    if sourceData == nil then
      return
    end
  end
  local node = sourceData[codData[length]]
  if node == nil and isCreate then
    node = self:getCls(codData[1]).new(codData)
    sourceData[codData[length]] = node
  end
  return node
end

function this:getConditionDic()
  return self.codDic
end

function this:getConditionGroup(nodeBox, isCreate)
  local key = self:getHashConditonGroupKey(nodeBox)
  local group = self.codGroupDic[key]
  if group == nil then
    group = require(L_R.condition .. "conditionGroup").new(nodeBox)
    group:setHashKey(key)
    self.codGroupDic[key] = group
  end
  return group
end

function this:hashInsert(tab, node)
  local hashCode = node:getHashCode()
  for i, v in ipairs(tab) do
    if hashCode <= v:getHashCode() then
      table.insert(tab, i, node)
      return
    end
  end
  table.insert(tab, node)
end

function this:getHashConditonGroupKey(nodeBox)
  local keyTab = {}
  for _, v in ipairs(nodeBox) do
    table.insert(keyTab, v:getHashCode())
  end
  return table.concat(keyTab, ",")
end

function this:reHash(group)
  local hashBox = {}
  for node, _ in pairs(group:getCondition()) do
    self:hashInsert(hashBox, node)
  end
  return next(hashBox) and self:getHashConditonGroupKey(hashBox)
end

local function _removeConditionNode(tab, condition, index)
  local key = condition[index]
  if key == nil then
    return
  end
  if index == #condition then
    tab[key] = nil
  else
    local childTab = tab[key]
    if childTab then
      local count = 0
      for _, v in pairs(childTab) do
        count = count + 1
        if 1 < count then
          break
        end
      end
      if 1 < count then
        _removeConditionNode(childTab, condition, index + 1)
      else
        tab[key] = nil
      end
    end
  end
end

function this:removeConditionNode(node)
  local condition = node:getCondition()
  _removeConditionNode(self.codDic, condition, 1)
  for _, group in pairs(node:getBelong()) do
    group:removeNode(node)
    self:removeConditionGroup(group)
    local newKey = self:reHash(group)
    if newKey then
      self.codGroupDic[newKey] = group
    end
  end
  node:onDestroy()
end

function this:removeConditionGroup(group)
  local hashKey = group:getHashKey()
  self.codGroupDic[hashKey] = nil
end

local results = {}

function this:isComplete(codGroup)
  table.clear(results)
  local isComplete = true
  local lockIndex = 1
  for i, v in ipairs(codGroup) do
    results[i] = self:singleIsComplete(v)
    if isComplete and not results[i] then
      lockIndex = i
    end
    isComplete = isComplete and results[i]
  end
  return isComplete, results, lockIndex
end

function this:singleIsComplete(codData)
  if table.isEmpty(codData) then
    return true
  end
  local cls = self:getCls(codData[1])
  if not cls then
    errorf("未实现条件类型" .. codData[1])
    return false
  end
  return cls.checkFunc(codData)
end

function this:getSingleDesc(codData)
  local cls = self:getCls(codData[1])
  if not cls then
    errorf("未实现条件类型" .. codData[1])
    return false
  end
  local cType = codData[1]
  local tpl = _conditionTpl:getTplById(cType)
  local key = _conditionTpl:getDescShowKey(tpl)
  return cls.descFunc(key, codData)
end

function this:getDescs(codGroup)
  local results = {}
  for i, v in ipairs(codGroup) do
    results[i] = self:getSingleDesc(v)
  end
  return results
end

function this:getTipDesc(codGroup)
  local descs = self:getDescs(codGroup)
  if #descs <= 0 then
    return ""
  end
  if #descs == 1 then
    return _wordsTpl:getValue("notice_common_tip_txt", {
      desc = descs[1]
    })
  elseif #descs == 2 then
    return _wordsTpl:getValue("notice_common_double_condition_tip", {
      desc = descs[1],
      desc2 = descs[2]
    })
  else
    errorf("目前没有三个条件的文本配置 words表加一下叫程序补一下")
  end
end

return this
