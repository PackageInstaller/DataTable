require("base_ins_r")
_class("PlayCasterControlOutLineInstruction", BaseInstruction)
PlayCasterControlOutLineInstruction = PlayCasterControlOutLineInstruction

function PlayCasterControlOutLineInstruction:Constructor(paramList)
  self._enable = tonumber(paramList.enable)
end

function PlayCasterControlOutLineInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if casterEntity:MonsterID() then
    local world = casterEntity:GetOwnerWorld()
    local monsterIDCmpt = casterEntity:MonsterID()
    monsterIDCmpt:SetNeedOutLineEnable(self._enable == 1)
    local renderEntityService = world:GetService("RenderEntity")
    if self._enable == 1 then
      renderEntityService:DestroyMonsterAreaOutLineEntity(casterEntity)
      renderEntityService:CreateMonsterAreaOutlineEntity(casterEntity)
    else
      renderEntityService:DestroyMonsterAreaOutLineEntity(casterEntity)
    end
  end
end
