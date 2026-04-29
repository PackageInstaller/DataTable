require("entity_ability")
_autoEnum("EntityAbilitysLookup_Test", {
  "GroundMotion"
})
for key, value in pairs(EntityAbilitysLookup_Test) do
  EntityAbilitysLookup[key] = value
end
_class("SimpleMotionAbility", EntityAbility)

function SimpleMotionAbility:Constructor()
  self.m_abilityType = EntityAbilitysLookup.GroundMotion
end

function SimpleMotionAbility:OnDisable()
  self.m_owner:RemoveMovement()
end

function SimpleMotionAbility:HandleCommand(cmd)
  Log.debug("SimpleMotionAbility:HandleCommand.." .. cmd.CommandType)
  if cmd.CommandType == "AxisOperation" then
    Log.debug("Operation x = " .. cmd.AxleX .. " ,  y = " .. cmd.AxleY)
    local e = self.m_owner
    if cmd.AxleX == 0 and cmd.AxleY == 0 then
      e:RemoveMovement()
    else
      local velocityXZ = e:Attributes():GetAttribute("Speed")
      Log.debug("velocityXZ  = " .. velocityXZ)
      e:ReplaceMovement(MovementByDirection:New(Vector3(cmd.AxleX, 0, cmd.AxleY), velocityXZ))
    end
  end
end
