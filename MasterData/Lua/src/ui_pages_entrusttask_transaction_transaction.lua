local this = class("transaction")

function this:ctor(onSuccessCallback, onFailureCallback)
  self.tasks = {}
  self.onSuccessCallback = onSuccessCallback
  self.onFailureCallback = onFailureCallback
  self.isFired = false
  self.isDeclared = false
  return self
end

function this:Declare(keys)
  if self.isDeclared then
    print("错误: Declare 方法只能调用一次。")
    return
  end
  if type(keys) ~= "table" or #keys == 0 then
    print("警告: Declare 接受一个非空数组。如果无需等待任何任务，将立即成功。")
    return
  end
  for _, key in pairs(keys) do
    self.tasks[key] = {completed = false}
  end
  self.isDeclared = true
end

function this:GetCallback(key)
  if not self.isDeclared then
    print("错误: 在获取回调之前，必须先调用 Declare 方法。")
    self.isFired = true
    if self.onSuccessCallback then
      self.onSuccessCallback()
    end
    return function()
    end
  end
  if not self.tasks[key] then
    print("错误: key '" .. tostring(key) .. "' 未在 Declare 中声明。")
    return function()
    end
  end
  return function(...)
    self:_completeTask(key, ...)
  end
end

function this:_completeTask(key, ...)
  if self.isFired then
    return
  end
  if not self.tasks then
    return
  end
  local taskState = self.tasks[key]
  if not taskState then
    return
  end
  if taskState.completed then
    print("警告: 任务 '" .. tostring(key) .. "' 被重复触发完成。")
    return
  end
  taskState.completed = true
  if self:_checkAllCompleted() then
    self.isFired = true
    if self.onSuccessCallback then
      self.onSuccessCallback(...)
    end
  end
end

function this:_checkAllCompleted()
  for _, taskState in pairs(self.tasks) do
    if not taskState.completed then
      return false
    end
  end
  return true
end

function this:Fail(...)
  if self.isFired then
    return
  end
  self.isFired = true
  if self.onFailureCallback then
    self.onFailureCallback(...)
  end
end

function this:dispose()
  self.onSuccessCallback = nil
  self.onFailureCallback = nil
  self.tasks = nil
end

return this
