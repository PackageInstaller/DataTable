require("base_ins_r")
_class("PlayCasterSuicideInstruction", BaseInstruction)
PlayCasterSuicideInstruction = PlayCasterSuicideInstruction

function PlayCasterSuicideInstruction:Constructor(paramList)
end

function PlayCasterSuicideInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    casterEntity = cSuperEntity:GetSuperEntity()
  end
  if casterEntity:HasMonsterID() and casterEntity:HasDeadMark() then
    local svc = world:GetService("MonsterShowRender")
    TaskManager:GetInstance():CoreGameStartTask(function(TT)
      svc:_DoOneMonsterDead(TT, casterEntity)
    end)
    local pieceService = world:GetService("Piece")
    pieceService:RefreshPieceAnim()
  end
end
