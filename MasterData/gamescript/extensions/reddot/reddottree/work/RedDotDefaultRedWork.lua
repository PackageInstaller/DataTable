local RedDotDefaultRedWork, Super = System.NewClass("RedDotDefaultRedWork", RedDotSingleFlow)

function RedDotDefaultRedWork:ctor(func)
  Super.ctor(self, "默认红点")
  self.func = func
end

function RedDotDefaultRedWork:Execute()
  if not self.func or type(self.func) ~= "function" then
    return false
  end
  if self.func() then
    return RedDotDefine.RedDotType.Red
  end
  return false
end

return RedDotDefaultRedWork
