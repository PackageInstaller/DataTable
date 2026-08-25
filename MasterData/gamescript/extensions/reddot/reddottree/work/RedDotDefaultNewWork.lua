local RedDotDefaultNewWork, Super = System.NewClass("RedDotDefaultNewWork", RedDotSingleFlow)

function RedDotDefaultNewWork:ctor(func)
  Super.ctor(self, "默认新红点")
  self.func = func
end

function RedDotDefaultNewWork:Execute()
  if not self.func or type(self.func) ~= "function" then
    return false
  end
  if self.func() then
    return RedDotDefine.RedDotType.New
  end
  return false
end

return RedDotDefaultNewWork
