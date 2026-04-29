require("base_ins_r")
_class("PlayCasterTurnToRoundBeginPlayerPosInstruction", BaseInstruction)
PlayCasterTurnToRoundBeginPlayerPosInstruction = PlayCasterTurnToRoundBeginPlayerPosInstruction

function PlayCasterTurnToRoundBeginPlayerPosInstruction:Constructor(paramList)
end

function PlayCasterTurnToRoundBeginPlayerPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local world = casterEntity:GetOwnerWorld()
  local targetPos = BattleStatHelper.GetRoundBeginPlayerPos()
  local playSkillService = world:GetService("PlaySkill")
  if not playSkillService:CheckSourceCanTurn(casterEntity) then
    Log.fatal("CasterID:", casterEntity:GetID(), "can't turn ")
    return
  end
  if casterEntity:HasTeam() then
    casterEntity = casterEntity:GetTeamLeaderPetEntity()
  end
  local castPos = casterEntity:GetRenderGridPosition()
  local dir = targetPos - castPos
  local gridDir = Vector2(dir.x, dir.y)
  casterEntity:SetDirection(gridDir)
end
