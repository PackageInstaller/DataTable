require("base_ins_r")
_class("PlayPetTrapMoveInstruction", BaseInstruction)
PlayPetTrapMoveInstruction = PlayPetTrapMoveInstruction

function PlayPetTrapMoveInstruction:Constructor(paramList)
end

function PlayPetTrapMoveInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.PetTrapMove)
  if not resultArray or table.count(resultArray) == 0 then
    return
  end
  local trapServiceRender = world:GetService("TrapRender")
  local playBuffService = world:GetService("PlayBuff")
  local sPlaySkillInstruction = world:GetService("PlaySkillInstruction")
  for _, result in ipairs(resultArray) do
    local posOld = result:GetPosOld()
    local posNew = result:GetPosNew()
    local dirNew = result:GetDirNew()
    casterEntity:SetAnimatorControllerBools({Move = true})
    casterEntity:AddGridMove(BattleConst.MoveSpeed, posNew, posOld)
    casterEntity:SetDirection(dirNew)
    while casterEntity:HasGridMove() do
      YIELD(TT)
    end
    casterEntity:SetAnimatorControllerBools({Move = false})
    casterEntity:SetLocation(posNew, dirNew)
    local trapIDList = result:GetTriggerTrapIDList()
    local trapEntityList = {}
    for _, trapID in ipairs(trapIDList) do
      local trapEntity = world:GetEntityByID(trapID)
      trapEntityList[#trapEntityList + 1] = trapEntity
    end
    sPlaySkillInstruction:PlayTrapTrigger(TT, casterEntity, trapEntityList)
    playBuffService:PlayBuffView(TT, NTTeleport:New(casterEntity, posOld, posNew))
  end
end
