require("base_ins_r")
_class("PlaySwitch2GridTrapInstruction", BaseInstruction)
PlaySwitch2GridTrapInstruction = PlaySwitch2GridTrapInstruction

function PlaySwitch2GridTrapInstruction:Constructor(paramList)
end

function PlaySwitch2GridTrapInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playBuffService = world:GetService("PlayBuff")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Switch2GridTrap)
  if resultArray == nil then
    Log.fatal("add buff instruction ,buff result is nil")
    return
  end
  local trapServiceRender = world:GetService("TrapRender")
  local pieceService = world:GetService("Piece")
  local utilDataSvc = world:GetService("UtilData")
  for _, v in pairs(resultArray) do
    local data = v:GetData()
    for i, v in ipairs(data) do
      local targetEntity = world:GetEntityByID(v.targetID)
      targetEntity:SetPosition(v.posNew)
    end
    local scopeRange = v:GetScopeRange()
    for _, pos in ipairs(scopeRange) do
      pieceService:ResetPieceEffectRender(pos)
    end
  end
end
