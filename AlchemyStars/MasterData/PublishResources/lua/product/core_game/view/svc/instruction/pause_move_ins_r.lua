require("base_ins_r")
_class("PauseMoveInstruction", BaseInstruction)
PauseMoveInstruction = PauseMoveInstruction

function PauseMoveInstruction:Constructor(paramList)
  self._matchers = nil
  local strParam = paramList.matchers
  if strParam then
    local len = string.len(strParam)
    self._matchers = string.split(strParam, "|")
  end
  local moveAnim = paramList.moveAnim or 0
  self._moveAnim = moveAnim == 1
end

function PauseMoveInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  if self._matchers then
    for i, match in ipairs(self._matchers) do
      local g = world:GetGroup(world.BW_WEMatchers[match])
      for i, e in ipairs(g:GetEntities()) do
        self:PauseEntity(e)
      end
    end
  else
    local targetEntity = world:GetEntityByID(phaseContext:GetCurTargetEntityID())
    self:PauseEntity(targetEntity)
  end
end

function PauseMoveInstruction:PauseEntity(e)
  e:AddPauseFlag(0)
  if self._moveAnim then
    e:SetAnimatorControllerBools({Move = false})
  end
end
