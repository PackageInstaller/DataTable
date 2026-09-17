local this = L_BevTree:registClass("guide.forceEnableGamepadUIInput", L_BevTree.action)

function this:param()
  self.inputMapNames = ""
end

function this:parse()
  self.inputMapNames = self:getParam("inputMapNames")
end

function this:execute()
  if not string.isEmpty(self.inputMapNames) then
    local tab = string.split(self.inputMapNames, "|")
    for _, v in pairs(tab) do
      C_InputManager.SetGamepadUIInputMap(v, true)
    end
  end
  return L_BevTree.taskResult.Success
end

return this
