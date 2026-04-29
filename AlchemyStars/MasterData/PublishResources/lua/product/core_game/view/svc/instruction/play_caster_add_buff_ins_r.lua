require("base_ins_r")
_class("PlayCasterAddBuffInstruction", BaseInstruction)
PlayCasterAddBuffInstruction = PlayCasterAddBuffInstruction

function PlayCasterAddBuffInstruction:Constructor(paramList)
  self._buffID = tonumber(paramList.buffID)
  self._buffEffectType = tonumber(paramList.buffEffectType) or 0
  self._isRemove = false
  if paramList.remove then
    self._isRemove = true
  end
end

function PlayCasterAddBuffInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playBuffService = world:GetService("PlayBuff")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local buffResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBuff)
  if buffResultArray == nil then
    Log.fatal("add buff instruction ,buff result is nil")
    return
  end
  local utilDataSvc = world:GetService("UtilData")
  self._buffID = utilDataSvc:GetReplacedBuffIdForPlayIns(casterEntity, self._buffID)
  self._buffEffectType = utilDataSvc:GetReplacedBuffEffectTypeForPlayIns(casterEntity, self._buffEffectType)
  for _, v in pairs(buffResultArray) do
    local buffArray = v:GetAddBuffResult()
    local eid = v:GetEntityID()
    if casterEntity:GetID() == eid and buffArray then
      for _, seq in pairs(buffArray) do
        local vinst = casterEntity:BuffView():GetBuffViewInstance(seq)
        if vinst then
          local buffID = vinst:BuffID()
          local buffEffectType = vinst:GetBuffEffectType()
          local buffMatch = self._buffID and self._buffID == buffID or self._buffEffectType == buffEffectType
          if buffMatch then
            if self._isRemove then
              playBuffService:PlayRemoveBuff(TT, vinst, NTBuffUnload:New())
            else
              playBuffService:PlayAddBuff(TT, vinst, eid)
            end
          end
        end
      end
    end
  end
end
