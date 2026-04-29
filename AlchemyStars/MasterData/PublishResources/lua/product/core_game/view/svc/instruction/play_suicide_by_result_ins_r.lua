require("base_ins_r")
_class("PlaySuicideByResultInstruction", BaseInstruction)
PlaySuicideByResultInstruction = PlaySuicideByResultInstruction

function PlaySuicideByResultInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = routineComponent:GetEffectResultByArrayAll(SkillEffectType.Suicide)
  if not resultArray then
    return
  end
  local svc = world:GetService("MonsterShowRender")
  for _, result in ipairs(resultArray) do
    local targetID = result:GetTargetID()
    local e = world:GetEntityByID(targetID)
    if e then
      TaskManager:GetInstance():CoreGameStartTask(function(TT)
        svc:_DoOneMonsterDead(TT, e)
      end)
    end
  end
  local pieceService = world:GetService("Piece")
  pieceService:RefreshPieceAnim()
end
