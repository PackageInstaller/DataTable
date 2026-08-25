local RedType = RedTypeDefine.RedType
local RedAttrType = RedPointDataUtils.RedAttrType
local NewRedComBase, Super = System.NewComponent("NewRedComBase")

function NewRedComBase:ctor(redDotGo, newTagGo, updateRedFunc)
  Super.ctor(self)
  self.redDotGo = redDotGo
  self.newTagGo = newTagGo
  self.updateRedFunc = updateRedFunc or function(_, _)
  end
  self.funcCount = Vue.ref(0)
  self.redDotFuncMap = {}
  self.newTagGoFuncMap = {}
  self.validFuncMap = {}
  self.redAttrTypeFuncMap = {}
  self.clearRedFunc = {}
end

function NewRedComBase:OnBind(binder)
  self.binder = binder
  if self.redDotGo then
    self.redDotGo:SetActive(false)
  end
  if self.newTagGo then
    self.newTagGo:SetActive(false)
  end
  binder:BindToRaw(function(childBinder, isShowNewTag)
    if self.newTagGo then
      self.newTagGo:SetActive(isShowNewTag)
    end
    childBinder:BindToRaw(function(_, isShowRed)
      self.updateRedFunc(isShowRed, isShowNewTag)
      if isShowNewTag and self.newTagGo then
        return
      end
      if self.redDotGo then
        self.redDotGo:SetActive(isShowRed or isShowNewTag)
      end
    end, function()
      local _ = self.funcCount.value
      local isShowRed = self:_IsShowRedDot()
      local isValid = self:_IsValid()
      return isShowRed and isValid
    end)
  end, function()
    local _ = self.funcCount.value
    local isValid = self:_IsValid()
    return self:_IsShowNewTag() and isValid
  end)
end

function NewRedComBase:EnableTimeUpdate()
  if self._timeUpdateTick then
    return
  end
  self._timeUpdateTick = self.binder:BindTimer(5, -1, function()
    self.funcCount.value = self.funcCount.value + 1
  end)
end

function NewRedComBase:UpdateRed()
  self.funcCount.value = self.funcCount.value + 1
end

function NewRedComBase:_IsValid()
  local isValid = true
  for funcTag, func in pairs(self.validFuncMap) do
    local curRet = func()
    isValid = isValid and curRet
  end
  return isValid
end

function NewRedComBase:_IsShowNewTag()
  local isShowNewTag = self:_GetFuncMapResult(self.newTagGoFuncMap)
  local redType = self:_GetFuncMapResult(self.redAttrTypeFuncMap)
  return isShowNewTag or redType == RedAttrType.IsNew
end

function NewRedComBase:_IsShowRedDot()
  local isShowRedDot = self:_GetFuncMapResult(self.redDotFuncMap)
  local redType = self:_GetFuncMapResult(self.redAttrTypeFuncMap)
  return isShowRedDot or redType == RedAttrType.Red
end

function NewRedComBase:_InsertRedFunc(isNewTag, funcTag, showFunc, clearFunc)
  if isNewTag then
    self.newTagGoFuncMap[funcTag] = showFunc
  else
    self.redDotFuncMap[funcTag] = showFunc
  end
  if clearFunc then
    self.clearRedFunc[funcTag] = clearFunc
  end
  self.funcCount.value = self.funcCount.value + 1
end

function NewRedComBase:_InsertRedAttrTypeFunc(funcTag, redTypeFunc, clearFunc)
  self.redAttrTypeFuncMap[funcTag] = redTypeFunc
  if clearFunc then
    self.clearRedFunc[funcTag] = clearFunc
  end
  self.funcCount.value = self.funcCount.value + 1
end

function NewRedComBase:_InsertValidFunc(funcTag, validFunc)
  self.validFuncMap[funcTag] = validFunc
  self.funcCount.value = self.funcCount.value + 1
end

function NewRedComBase:_GetFuncMapResult(funcMap)
  local ret = false
  for funcTag, func in pairs(funcMap) do
    local curRet = func()
    ret = ret or curRet
  end
  return ret
end

return NewRedComBase
