local CallFunc = class("CallFunc")

function CallFunc:ctor(params)
  self.callback = params.callback
end

function CallFunc:step(dt)
  self.callback()
end

function CallFunc:isDone()
  return true
end

return CallFunc
