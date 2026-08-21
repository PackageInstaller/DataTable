require("base_ins_r")
_class("PlayCasterRefreshBuffViewInstruction", BaseInstruction)
PlayCasterRefreshBuffViewInstruction = PlayCasterRefreshBuffViewInstruction

function PlayCasterRefreshBuffViewInstruction:Constructor(paramList)
  self._buffID = tonumber(paramList.buffID) or 0
  self._buffEffectType = tonumber(paramList.buffEffectType) or 0
end

function PlayCasterRefreshBuffViewInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playBuffService = world:GetService("PlayBuff")
  local utilDataSvc = world:GetService("UtilData")
  self._buffID = utilDataSvc:GetReplacedBuffIdForPlayIns(casterEntity, self._buffID)
  self._buffEffectType = utilDataSvc:GetReplacedBuffEffectTypeForPlayIns(casterEntity, self._buffEffectType)
  local buffViewComponent = casterEntity:BuffView()
  if buffViewComponent then
    local viewIns = buffViewComponent:GetBuffViewInstanceArray()
    for _, inst in ipairs(viewIns) do
      local buffID = inst:BuffID()
      local buffEffectType = inst:GetBuffEffectType()
      if self._buffID == buffID or self._buffEffectType == buffEffectType then
        playBuffService:PlayAddBuff(TT, inst, casterEntity:GetID())
      end
    end
  end
end
