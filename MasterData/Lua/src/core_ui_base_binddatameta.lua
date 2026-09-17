local commonUtil = require("ui.util.commonUtil")
local _requireModuleNameCache = {}

local function requireModule(moduleRelativePath)
  local p = _requireModuleNameCache[moduleRelativePath]
  if not p then
    p = "ui/" .. moduleRelativePath
    _requireModuleNameCache[moduleRelativePath] = p
  end
  return require(p)
end

local bindDataMeta = class("core.ui.bindDataMeta")
local valueBase = class("core.ui.bindDataMeta.valueBase")

function valueBase:ctor(owner, key, meth)
  self._bindDataMeta = owner
  self._bindKey = key
  self._bindMeth = meth
  self._uiInst = self._bindDataMeta._uiInst
  self._modules = self._bindDataMeta._uiInst.modules
  self._uiBinding = self._bindDataMeta._uiBinding
  self._setupBindings = {}
  self:initSetupBindings()
end

function valueBase:initSetupBindings()
  L_ProfilerUtil.BeginSample("valueBase:initSetupBindings")
  local length = self._uiBinding.labels.Length
  local key, bindConfig
  local bindConfigs = self._uiBinding.bindConfigs
  local labels = self._uiBinding.labels
  local setupBindings = self._setupBindings
  for i = 0, length - 1 do
    bindConfig = bindConfigs[i]
    if bindConfig ~= nil then
      key = labels[i]
      setupBindings[key] = {
        idx = i,
        attributeType = bindDataMeta:countNumber(bindConfig.attributeType)
      }
    end
  end
  L_ProfilerUtil.EndSample()
end

local valueToggleModule = class("core.ui.bindDataMeta.valueToggleModule", valueBase)

function valueToggleModule:itemBind(oldK, newK, uiExp)
  local mds = self._modules[self._bindKey] or {}
  if mds[oldK] ~= nil then
    mds[oldK]:unBind()
  end
  if mds[newK] ~= nil then
    mds[newK]:toBind(uiExp)
  end
end

function valueToggleModule:unBind(moduleK)
  local mds = self._modules[self._bindKey] or {}
  if mds[moduleK] ~= nil then
    mds[moduleK]:unBind()
  end
end

function valueToggleModule:itemAssetName(k)
  return self[k].assetName
end

local valueDynamicModule = class("core.ui.bindDataMeta.valueDynamicModule", valueBase)

function valueDynamicModule:setModuleConfig(cfg)
  local id = bindDataMeta:getIdByKey_uiInst(self._bindKey, self._setupBindings)
  if id ~= nil then
    self._uiBinding:LinkerSetSystemObject(id, cfg)
  end
end

function valueDynamicModule:itemBind(oldK, newCfg, uiExp)
  local newK = newCfg.moduleKey
  local newModuleName = newCfg.moduleName
  local m
  if newModuleName == nil then
    m = require("core/ui/base/emptyModule").new()
  else
    m = requireModule(newModuleName).new(G_UIModuleBase.ModuleType.Dynamic)
  end
  if m.created then
    m:created(newCfg, self._bindMeth, self._uiInst)
  end
  local mds = self._modules[self._bindKey] or {}
  if mds[oldK] ~= nil then
    mds[oldK]:unBind()
  end
  mds[newK] = m
  m:toBind(uiExp)
end

function valueDynamicModule:unBind(moduleK)
  local mds = self._modules[self._bindKey] or {}
  if mds[moduleK] ~= nil then
    mds[moduleK]:unBind()
  end
end

local valueArray = class("core.ui.bindDataMeta.valueArray", valueBase)

function valueArray:ctor(owner, key, meth)
  valueArray.super.ctor(self, owner, key, meth)
  self._filterMap = {}
  self._bindingMap = {}
end

function valueArray:getIdentify(id)
  if #self <= 0 then
    return ""
  end
  if id > #self then
    return nil
  end
  local i = self[id].identify
  if i then
    return i
  else
    return nil
  end
end

function valueArray:getIdentifyByMapId(id)
  if #self <= 0 then
    return ""
  end
  if id then
    local realId = id
    local newId = self._filterMap[realId]
    if newId then
      realId = newId
    end
    return self[realId].identify
  else
    return nil
  end
end

function valueArray:getItemCls(id)
  local mds = self._modules[self._bindKey] or {}
  if id then
    return mds[id]
  else
    return mds
  end
end

function valueArray:getItemClsByMapId(id)
  local mds = self._modules[self._bindKey] or {}
  if id then
    local realId = id
    local newId = self._filterMap[realId]
    if newId then
      realId = newId
    end
    return mds[realId]
  else
    return mds
  end
end

function valueArray:toBind(id, uiBinding)
  L_ProfilerUtil.BeginSample("luaBindDataMeta:toBind")
  local cls = self:getItemClsByMapId(id)
  if cls then
    if cls.toBindToArray then
      local meta = self._bindingMap[uiBinding]
      if meta then
        meta._uiInst = cls
      end
      if self.parent then
        cls.parent = self.parent._uiInst
      end
      cls:toBindToArray(uiBinding, meta)
      self._bindingMap[uiBinding] = nil
    elseif cls.toBind then
      cls:toBind(uiBinding)
    end
  end
  L_ProfilerUtil.EndSample()
end

function valueArray:unBind(id, uiBinding)
  L_ProfilerUtil.BeginSample("luaBindDataMeta:unBind")
  local cls = self:getItemClsByMapId(id)
  if cls then
    if cls.unBindFromArray then
      local meta = cls:unBindFromArray()
      if meta then
        meta._uiInst = nil
        self._bindingMap[meta._uiBinding] = meta
      end
    elseif cls.unBind then
      cls:unBind()
    end
    cls.parent = nil
  end
  L_ProfilerUtil.EndSample()
end

function valueArray:getCellSize(id)
  if #self <= 0 then
    return 0
  end
  local v = self[id]
  if v == nil then
    return 0
  end
  if v.size ~= nil then
    if type(v.size) == "number" then
      return v.size
    else
      return 0
    end
  else
    return 0
  end
end

function valueArray:getLength()
  return #self
end

function valueArray:getMapLength()
  return #self._filterMap
end

function valueArray:getValueByMapId(id)
  return self[self._filterMap[id]]
end

function valueArray:createModule(moduleName, value, meth, parent)
  local m
  if moduleName == nil then
    m = require("core/ui/base/emptyModule").new()
  else
    m = requireModule(moduleName).new(G_UIModuleBase.ModuleType.TableItem)
  end
  if m.created then
    m:created(value, meth, parent)
  end
  return m
end

function valueArray:insert(index, v)
  if type(index) ~= "number" then
    v = index
    index = #self + 1
  end
  local mds = self._modules[self._bindKey] or {}
  local moduleName = v.moduleName or self.moduleName
  local m = self:createModule(moduleName, v, self._bindMeth, self._uiInst)
  table.insert(self, index, v)
  local currentMd = mds[index]
  mds[index] = m
  for i = index + 1, #self do
    local tmp = mds[i]
    mds[i] = currentMd
    currentMd = tmp
  end
  self._modules[self._bindKey] = mds
  self:filter(nil, false)
  self:sort(nil, false)
  local id = bindDataMeta:getIdByKey_uiInst(self._bindKey, self._setupBindings)
  if id ~= nil then
    self._uiBinding:LinkerSetSystemObject(id, self)
  end
  return m
end

function valueArray:insert_withoutRefresh(index, v)
  if type(index) ~= "number" then
    v = index
    index = #self + 1
  end
  local mds = self._modules[self._bindKey] or {}
  local moduleName = v.moduleName or self.moduleName
  local m = self:createModule(moduleName, v, self._bindMeth, self._uiInst)
  table.insert(self, index, v)
  local currentMd = mds[index]
  mds[index] = m
  for i = index + 1, #self do
    local tmp = mds[i]
    mds[i] = currentMd
    currentMd = tmp
  end
  self._modules[self._bindKey] = mds
  self:filter(nil, false)
  self:sort(nil, false)
  local id = bindDataMeta:getIdByKey_uiInst(self._bindKey, self._setupBindings)
  if id ~= nil then
    self._uiBinding:LinkerSetSystemObject(id, self, true)
  end
  return m
end

function valueArray:insert_array(v, filter, sort)
  L_ProfilerUtil.BeginSample("luaBindDataMeta:insert_array")
  local mds = self._modules[self._bindKey] or {}
  local arrayLength = #self
  local moduleName = self.moduleName
  for i = 1, #v do
    if v[i].moduleName then
      moduleName = v[i].moduleName
    end
    local m = self:createModule(moduleName, v[i], self._bindMeth, self._uiInst)
    table.insert(self, v[i])
    mds[arrayLength + i] = m
  end
  self._modules[self._bindKey] = mds
  self:filter(filter, false)
  self:sort(sort, false)
  local id = bindDataMeta:getIdByKey_uiInst(self._bindKey, self._setupBindings)
  if id ~= nil then
    self._uiBinding:LinkerSetSystemObject(id, self)
  end
  L_ProfilerUtil.EndSample()
end

function valueArray:refresh_array(dataList, filter, sort)
  self:clear()
  self:insert_array(dataList, filter, sort)
  local count = self:getLength()
  for i = 1, count do
    local module = self:getItemCls(i)
    module:onSetData(dataList[i])
  end
end

function valueArray:remove(index)
  local mds = self._modules[self._bindKey]
  if mds == nil or mds[index] == nil then
    return
  end
  local removeItem = mds[index]
  table.remove(mds, index)
  table.remove(self, index)
  removeItem:_ensureUnbind()
  removeItem:_dispose()
  self._modules[self._bindKey] = mds
  self:filter(nil, false)
  self:sort(nil, false)
  local id = bindDataMeta:getIdByKey_uiInst(self._bindKey, self._setupBindings)
  if id ~= nil then
    self._uiBinding:LinkerSetSystemObject(id, self)
  end
end

function valueArray:change(index, value)
  if self[index] == nil then
    return
  end
  local mds = self._modules[self._bindKey] or {}
  if mds[index] == nil then
    return
  end
  for i, v in pairs(value) do
    self[index][i] = v
  end
  if mds[index].refresh and mds[index].isBind then
    mds[index]:refresh()
  end
end

function valueArray:changeValue(index, key, value)
  if self[index] == nil then
    return
  end
  local mds = self._modules[self._bindKey] or {}
  if mds[index] == nil then
    return
  end
  self[index][key] = value
  if mds[index].refresh and mds[index].isBind then
    mds[index]:refresh()
  end
end

function valueArray:freshAll(v)
  local mds = self._modules[self._bindKey] or {}
  local arrayLength = #self
  local lastCount = arrayLength
  local freshCount = #v
  local moduleName = self.moduleName
  for i = 1, freshCount do
    local m = mds[i]
    if not m then
      m = self:createModule(moduleName, v[i], self._bindMeth, self._uiInst)
      arrayLength = arrayLength + 1
      self[arrayLength] = v[i]
      mds[arrayLength] = m
    else
      self:change(i, v[i])
    end
  end
  for i = freshCount + 1, arrayLength do
    self[i] = nil
  end
  self._modules[self._bindKey] = mds
  self:filter(nil, false)
  local id = bindDataMeta:getIdByKey_uiInst(self._bindKey, self._setupBindings)
  if (lastCount == 0 or lastCount ~= freshCount) and id ~= nil then
    self._uiBinding:LinkerSetSystemObject(id, self)
  end
  for i = #v + 1, arrayLength do
    mds[i]:_ensureUnbind()
    mds[i]:_dispose()
    mds[i] = nil
  end
end

function valueArray:clear(linker)
  local mds = self._modules[self._bindKey] or {}
  local num = #self
  for i = num, 1, -1 do
    table.remove(self, i)
  end
  if linker == nil then
    linker = true
  end
  table.clear(self._filterMap)
  if linker == true then
    local id = bindDataMeta:getIdByKey_uiInst(self._bindKey, self._setupBindings)
    if id ~= nil then
      self._uiBinding:LinkerSetSystemObject(id, self)
    end
  end
  for i = num, 1, -1 do
    mds[i]:_ensureUnbind()
    mds[i]:_dispose()
    mds[i] = nil
  end
end

function valueArray:getValue(index, theKey)
  if self[index] == nil then
    return nil
  end
  if not theKey then
    return self[index]
  end
  return self[index][theKey]
end

function valueArray:_compare(val1, val2)
  local ruler = self.ruler
  for k = 1, #ruler do
    local rule = ruler[k]
    local key = rule.key
    local v1, v2 = val1[key], val2[key]
    if v1 ~= v2 then
      if ruler[k].order == "DESC" then
        return v1 < v2
      else
        return v1 > v2
      end
    end
  end
  return false
end

function valueArray:sort(ruler, linker)
  self.ruler = ruler or self.ruler or {}
  local isSort = not table.isEmpty(self.ruler)
  if not isSort then
    return
  end
  if linker == nil then
    linker = true
  end
  if linker then
    self:filter(nil, false)
  end
  local filterMap = self._filterMap
  local n = #filterMap
  local mds = self._modules[self._bindKey] or {}
  for i = 1, n do
    local m = mds[i]
    if m then
      m:_ensureUnbind()
    end
  end
  local arr = self
  local compare = self._compare
  table.sort(filterMap, function(a, b)
    return compare(arr, arr[a], arr[b])
  end)
  if linker then
    local id = bindDataMeta:getIdByKey_uiInst(self._bindKey, self._setupBindings)
    if id ~= nil then
      self._uiBinding:LinkerSetSystemObject(id, self)
    end
  end
end

function valueArray:filter(condition, linker)
  if linker == nil then
    linker = true
  end
  if condition ~= nil then
    self.condition = condition
  end
  local cond = self.condition
  local filterMap = self._filterMap or {}
  local mds = self._modules[self._bindKey] or {}
  local count = 0
  for i = 1, #self do
    if cond == nil or cond(self, self[i]) then
      count = count + 1
      filterMap[count] = i
    else
      local cls = mds[i]
      if cls.unBindFromArray then
        local uiBinding = cls.uiBinding
        local meta = cls:unBindFromArray()
        if meta then
          meta._uiInst = nil
        end
        self._bindingMap[uiBinding] = meta
      elseif cls.unBind then
        cls:unBind()
      end
      cls.parent = nil
    end
  end
  for i = count + 1, #filterMap do
    filterMap[i] = nil
  end
  self._filterMap = filterMap
  if linker then
    self:sort(nil, false)
    local id = bindDataMeta:getIdByKey_uiInst(self._bindKey, self._setupBindings)
    if id ~= nil then
      self._uiBinding:LinkerSetSystemObject(id, self)
    end
  end
end

function valueArray:dispose()
  for uibinding, meta in pairs(self._bindingMap) do
    if L_CommonUtil.isValid(uibinding) then
      uibinding:RemoveAllBindings()
    end
    if meta and meta.dispose then
      meta:dispose()
    end
  end
  table.clear(self._bindingMap)
end

bindDataMeta.cls_valueToggleModule = valueToggleModule
bindDataMeta.cls_valueDynamicModule = valueDynamicModule
bindDataMeta.cls_valueArray = valueArray
local TYPE_BIND = {
  none = 0,
  value = 1,
  object = 2,
  module = 3,
  method = 4
}

function bindDataMeta:ctor(uiInst)
  self._values = {}
  self._methods = {}
  self._removeMethods = {}
  self._bindType = {}
  self._objectHandlers = {}
  self._setupBindings = {}
  self._setupBindingList = {}
  self._uiInst = uiInst
  self._uiBinding = self._uiInst.uiBinding
  self._childModules = self._uiInst.modules
  self._values.insert = self._values_insert
  self._values.remove = self._values_remove
  self._values.clear = self._values_clear
  self.__index = self._index
  self.__newindex = self._newindex
  self:initSetupBindings()
end

function bindDataMeta:initSetupBindings()
  L_ProfilerUtil.BeginSample("bindDataMeta:initSetupBindings")
  local length = self._uiBinding.labels.Length
  local key, bindConfig
  local bindConfigs = self._uiBinding.bindConfigs
  local labels = self._uiBinding.labels
  local countNumber = self.countNumber
  for i = 0, length - 1 do
    bindConfig = bindConfigs[i]
    if bindConfig ~= nil then
      key = labels[i]
      self._setupBindings[key] = {
        idx = i,
        attributeType = countNumber(self, bindConfig.attributeType)
      }
      table.insert(self._setupBindingList, key)
    end
  end
  L_ProfilerUtil.EndSample()
end

function bindDataMeta:setupValues()
  if not self._bindDefaultValue then
    return
  end
  L_ProfilerUtil.BeginSample("bindDataMeta:setupValues")
  local setValue = self._setValue
  for key, dataValue in pairs(self._bindDefaultValue) do
    if self._values[key] == nil then
      local dataType = type(dataValue)
      if dataType == "function" then
        setValue(self, key, dataValue())
      else
        setValue(self, key, dataValue)
      end
    end
  end
  self._bindDefaultValue = nil
  L_ProfilerUtil.EndSample()
end

function bindDataMeta:setupBindings()
  L_ProfilerUtil.BeginSample("bindDataMeta:setupBindings")
  self._bindDefaultValue = {}
  local setupBindings = self._setupBindings
  local uiBind = self._uiInst.bind
  local uiMethods = self._uiInst.methods
  local tempSplit = {}
  local setObjectValue = self._setObjectValue
  local setModules = self._setModules
  local setMethods = self._setMethods
  for k, v in pairs(self._setupBindingList) do
    local key = v
    local attributeType = setupBindings[key].attributeType
    if attributeType ~= nil then
      local t = attributeType
      local bindValue = uiBind[key]
      if t == 11 then
        setObjectValue(self, key, bindValue, self._uiInst.methods[key])
        self._bindType[key] = TYPE_BIND.object
      elseif t < 100 then
        self._bindDefaultValue[key] = bindValue
        self._bindType[key] = TYPE_BIND.value
      elseif t == 200 then
        local count = 0
        for s in string.gmatch(key, "[^#]+") do
          count = count + 1
          tempSplit[count] = s
          if count == 2 then
            break
          end
        end
        local dataKey = key
        local objIdx = 0
        if 1 < count then
          dataKey = tempSplit[1]
          objIdx = tonumber(tempSplit[2])
        end
        tempSplit[1], tempSplit[2] = nil, nil
        setModules(self, key, dataKey, uiBind[dataKey], uiMethods[dataKey], objIdx)
        self._bindType[key] = TYPE_BIND.module
      else
        setMethods(self, key, t, uiMethods[key])
        self._bindType[key] = TYPE_BIND.method
      end
      if bindValue ~= nil then
        uiBind[key] = nil
      end
    else
      print("dont support multi key " .. key)
    end
  end
  L_ProfilerUtil.EndSample()
end

function bindDataMeta:_setObjectValue(key, value, meth)
  if value == nil then
    return
  end
  local uiInst = self._uiInst
  local uiBinding = self._uiBinding
  local setupBindings = self._setupBindings
  local val = {bindData = value}
  for k, v in pairs(value) do
    val[k] = v
  end
  local valType = value.type or "array"
  val.parent = nil
  if valType == "array" then
    local valSuper = self.cls_valueArray.new(self, key, meth)
    setmetatable(val, {__index = valSuper})
    if self._childModules[key] == nil then
      local mds = {}
      for i = 1, #value do
        local v = value[i]
        local moduleName = v.moduleName or value.moduleName
        mds[i] = value:createModule(moduleName, v, meth, uiInst)
      end
      self._childModules[key] = mds
    end
    self._values[key] = val
    val.parent = self
    local id = self:getIdByKey_uiInst(key, setupBindings)
    if id ~= nil then
      uiBinding:LinkerSetSystemObject(id, val)
    end
  elseif valType == "toggleModule" then
    local mds = {}
    local dynamic = G_UIModuleBase.ModuleType.Dynamic
    for k, v in pairs(value) do
      local m
      if type(v) == "table" and v.assetName ~= nil then
        if v.moduleName == nil then
          m = require("core/ui/base/emptyModule").new()
        else
          m = requireModule(v.moduleName).new(dynamic)
        end
        if m.created then
          m:created(v, meth and meth[k] or {}, uiInst)
        end
        mds[k] = m
      end
    end
    self._childModules[key] = mds
    local valSuper = self.cls_valueToggleModule.new(self, key, meth)
    setmetatable(val, {__index = valSuper})
    local id = self:getIdByKey_uiInst(key, setupBindings)
    if id ~= nil then
      uiBinding:LinkerSetSystemObject(id, val)
    end
    self._values[key] = val
    val.parent = self
  elseif valType == "dynamicModule" then
    local mds = {}
    self._childModules[key] = mds
    local valSuper = self.cls_valueDynamicModule.new(self, key, meth)
    setmetatable(val, {__index = valSuper})
    local id = self:getIdByKey_uiInst(key, setupBindings)
    if id ~= nil then
      uiBinding:LinkerSetSystemObject(id, val)
    end
    self._values[key] = val
    val.parent = self
  else
    errorf("dont support this type in key:" .. key .. "  " .. valType)
  end
end

function bindDataMeta:_setValue(key, val)
  if val == nil then
    return
  end
  local index = self._setupBindings[key].idx
  if index == nil then
    errorf("failed to find bindConfig: " .. key)
    return
  end
  local id = self:getIdByKey_uiInst(key, self._setupBindings)
  if not id then
    return
  end
  local attrType = self._setupBindings[key].attributeType
  if attrType == 0 then
    self._uiBinding:LinkerSetVector2(id, val)
  elseif attrType == 1 then
    self._uiBinding:LinkerSetVector3(id, val)
  elseif attrType == 2 then
    self._uiBinding:LinkerSetQuaternion(id, val)
  elseif attrType == 3 then
    if type(val) ~= "boolean" then
      errorf("data value must boolean:" .. key .. "  val: " .. table.tostring(val))
    end
    self._uiBinding:LinkerSetBoolean(id, val)
  elseif attrType == 4 then
    if type(val) ~= "number" then
      errorf("data value must number:" .. key .. " val: " .. table.tostring(val))
    end
    self._uiBinding:LinkerSetInt32(id, val)
  elseif attrType == 5 then
    local t = type(val)
    if t == "string" then
      self._uiBinding:LinkerSetString(id, val)
    elseif t == "table" and val.group and val.langKey then
      self._uiBinding:LinkerSetLangString(id, val)
    else
      errorf("data value must string:  " .. key .. "  val: " .. table.tostring(val))
    end
  elseif attrType == 6 then
    if type(val) ~= "number" then
      errorf("data value must number:" .. key .. "  val: " .. table.tostring(val))
    end
    self._uiBinding:LinkerSetSingle(id, val)
  elseif attrType == 7 then
    self._uiBinding:LinkerSetColor(id, val)
  elseif attrType == 8 then
    self._uiBinding:LinkerSetSprite(id, val)
  elseif attrType == 9 then
    self._uiBinding:LinkerSetChar(id, val)
  elseif attrType == 10 then
    self._uiBinding:LinkerSetRect(id, val)
  elseif attrType == 12 then
    self._uiBinding:LinkerSetSystemObject(id, val)
  else
    errorf("setValue dont has this type >" .. attrType)
    return
  end
  self._values[key] = val
end

function bindDataMeta:_toRmMethod(key)
  if self._removeMethods[key] then
    self._uiBinding:RemoveAction(key)
    self._removeMethods[key] = nil
    self._methods[key] = nil
  end
end

function bindDataMeta:_setMethods(key, t, val)
  if val == nil then
    return
  end
  if self._methods[key] then
    error([[
dont support multi bind methods
 method only support bind once:  ]] .. key)
    return
  end
  if type(val) ~= "function" then
    error("methods must a function: " .. key)
    return
  end
  
  local function actionWrap(arg)
    if self._uiInst and self._uiInst.isBind then
      val(self._uiInst, arg)
    end
  end
  
  if t == 100 then
    local id = self:getIdByKey_uiInst(key, self._setupBindings)
    if id ~= nil then
      self._uiBinding:LinkerSetAction(id, actionWrap)
    end
  elseif t == 101 then
    local id = self:getIdByKey_uiInst(key, self._setupBindings)
    if id ~= nil then
      self._uiBinding:LinkerSetActionBoolean(id, actionWrap)
    end
  elseif t == 102 then
    local id = self:getIdByKey_uiInst(key, self._setupBindings)
    if id ~= nil then
      self._uiBinding:LinkerSetActionSingle(id, actionWrap)
    end
  elseif t == 103 then
    local id = self:getIdByKey_uiInst(key, self._setupBindings)
    if id ~= nil then
      self._uiBinding:LinkerSetActionInt32(id, actionWrap)
    end
  elseif t == 104 then
    local id = self:getIdByKey_uiInst(key, self._setupBindings)
    if id ~= nil then
      self._uiBinding:LinkerSetActionString(id, actionWrap)
    end
  elseif t == 105 then
    local id = self:getIdByKey_uiInst(key, self._setupBindings)
    if id ~= nil then
      self._uiBinding:LinkerSetActionVector2(id, actionWrap)
    end
  else
    errorf("dont has this type:" .. t)
  end
  self._methods[key] = val
end

function bindDataMeta._setModules_setUIBinding(this, uib)
  local mdl = this.module
  if mdl ~= nil then
    mdl:setUIBinding(uib)
  end
end

function bindDataMeta:_setModules(bindKey, dataKey, value, mths, objIdx)
  if value == nil then
    return
  end
  L_ProfilerUtil.BeginSample("bindDataMeta:_setModules")
  local val = {bindData = value}
  for k, v in pairs(value) do
    val[k] = v
  end
  local ms
  if mths ~= nil and type(mths) == "table" then
    ms = mths
  end
  local isArray = val.count and val.count > 0
  local realVal
  if isArray then
    if val.childModules == nil then
      val.childModules = {}
    end
    realVal = {index = objIdx}
    val.childModules[objIdx] = realVal
  else
    realVal = val
  end
  realVal.setUIBinding = self._setModules_setUIBinding
  local mdl
  if val.moduleName == nil then
    mdl = require("core/ui/base/emptyModule").new()
  else
    mdl = requireModule(val.moduleName).new(G_UIModuleBase.ModuleType.Static)
  end
  if isArray then
    if self._childModules[dataKey] == nil then
      self._childModules[dataKey] = {}
    end
    self._childModules[dataKey][objIdx] = mdl
  else
    self._childModules[dataKey] = mdl
  end
  realVal.module = mdl
  local id = self:getIdByKey_uiInst(bindKey, self._setupBindings)
  if id ~= nil then
    self._uiBinding:LinkerSetSystemObject(id, realVal)
  end
  if mdl.created then
    mdl:created(realVal, ms, self._uiInst)
  end
  self._values[dataKey] = val
  L_ProfilerUtil.EndSample()
end

function bindDataMeta._values_insert(t, k, v)
  local self = getmetatable(t)
  table.insert(self._values[k], v)
  local id = self:getIdByKey_uiInst(k, self._setupBindings)
  if id ~= nil then
    self._uiBinding:LinkerSetSystemObject(id, self._values[k])
  end
end

function bindDataMeta._values_remove(t, k, v)
  local self = getmetatable(t)
  if v > #self._values[k] then
    return
  end
  table.remove(self._values[k], v)
  local id = self:getIdByKey_uiInst(k, self._setupBindings)
  if id ~= nil then
    self._uiBinding:LinkerSetSystemObject(id, self._values[k])
  end
end

function bindDataMeta._values_clear(t, k, linker)
  local self = getmetatable(t)
  if linker == nil then
    linker = true
  end
  local v = self._values[k]
  if v then
    for i, x in ipairs(v) do
      v[i] = nil
    end
  end
  if linker == true then
    local id = self:getIdByKey_uiInst(k, self._setupBindings)
    if id ~= nil then
      self._uiBinding:LinkerSetSystemObject(id, self._values[k])
    end
  end
end

function bindDataMeta._index(t, k)
  local self = getmetatable(t)
  if self == nil then
    return nil
  end
  local val = self._values[k]
  if val ~= nil then
    return val
  end
  if self._bindDefaultValue then
    return self._bindDefaultValue[k]
  end
  return nil
end

function bindDataMeta._newindex(t, k, v)
  local self = getmetatable(t)
  if self == nil then
    return
  end
  if L_CommonUtil.isValid(self._uiBinding) == false then
    return
  end
  local type = self._bindType[k]
  if type == TYPE_BIND.value then
    self:_setValue(k, v)
  elseif not type then
    rawset(t, k, v)
  end
end

function bindDataMeta:dispose()
  if self._values then
    for _, value in pairs(self._values) do
      if type(value) == "table" and value.dispose then
        value:dispose()
      end
    end
  end
  if self._childModules then
    for _, module in pairs(self._childModules) do
      if type(module) == "table" then
        if module._dispose then
          module:_dispose()
        else
          for _, md in pairs(module) do
            if type(md) == "table" and md._dispose then
              md:_dispose()
            end
          end
        end
      end
    end
  end
  if L_CommonUtil.isValid(self._uiBinding) then
    self._uiBinding:RemoveAllBindings()
  end
  self._uiBinding = nil
  self._uiInst = nil
  self._values = nil
  self._childModules = nil
end

function bindDataMeta:countNumber(attributeType)
  if attributeType == nil then
    return nil
  end
  local result = attributeType - math.floor(attributeType / 10000) * 10000
  if result == 201 then
    result = 11
  end
  return result
end

function bindDataMeta:getIdByKey_uiInst(key, uiInst)
  if uiInst == nil or uiInst[key] == nil then
    return nil
  end
  return uiInst[key].idx
end

function bindDataMeta:copyFromBind(bind)
  self._bindDefaultValue = {}
  for k, v in pairs(bind) do
    local type = self._bindType[k]
    if type == nil then
      self._bindDefaultValue[k] = v
    elseif type == TYPE_BIND.value then
      bind[k] = nil
      self._values[k] = nil
      self._bindDefaultValue[k] = v
    else
      bind[k] = nil
    end
  end
end

function bindDataMeta:cloneToBind(bind)
  for k, v in pairs(self._values) do
    local type = self._bindType[k]
    if type == TYPE_BIND.value then
      bind[k] = v
    elseif type == TYPE_BIND.object then
      bind[k] = v.bindData
    elseif type == TYPE_BIND.module then
      bind[k] = v.bindData
    end
  end
end

return bindDataMeta
