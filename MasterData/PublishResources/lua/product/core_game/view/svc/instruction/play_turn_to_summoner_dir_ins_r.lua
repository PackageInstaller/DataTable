require("base_ins_r")
_class("PlayTurnToSummonerDirInstruction", BaseInstruction)
PlayTurnToSummonerDirInstruction = PlayTurnToSummonerDirInstruction

function PlayTurnToSummonerDirInstruction:Constructor(paramList)
end

function PlayTurnToSummonerDirInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local ownerSummonerEntity = casterEntity:GetSummonerEntity()
  if not ownerSummonerEntity then
    return
  end
  local dir = ownerSummonerEntity:GetGridDirection():Clone()
  casterEntity:SetDirection(dir)
end
