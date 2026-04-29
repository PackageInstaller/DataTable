require("base_ins_r")
_class("PlayAddBuffViewInstruction", BaseInstruction)
PlayAddBuffViewInstruction = PlayAddBuffViewInstruction

function PlayAddBuffViewInstruction:Constructor(paramList)
  self._buffID = tonumber(paramList.buffID) or 0
  self._buffEffectType = tonumber(paramList.buffEffectType) or 0
end

function PlayAddBuffViewInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playBuffService = world:GetService("PlayBuff")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local buffResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBuff)
  local utilDataSvc = world:GetService("UtilData")
  self._buffID = utilDataSvc:GetReplacedBuffIdForPlayIns(casterEntity, self._buffID)
  self._buffEffectType = utilDataSvc:GetReplacedBuffEffectTypeForPlayIns(casterEntity, self._buffEffectType)
  for _, v in pairs(buffResultArray) do
    local eid = v:GetEntityID()
    local buffArray = v:GetAddBuffResult()
    if targetEntityID == eid and next(buffArray) then
      local e = world:GetEntityByID(eid)
      if e and e:BuffView() then
        for _, seq in pairs(buffArray) do
          local buffViewInstance = e:BuffView():GetBuffViewInstance(seq)
          if buffViewInstance then
            local buffID = buffViewInstance:BuffID()
            local buffEffectType = buffViewInstance:GetBuffEffectType()
            if self._buffID == buffID or self._buffEffectType == buffEffectType then
              playBuffService:PlayAddBuff(TT, buffViewInstance, casterEntity:GetID())
            end
          end
        end
      end
    end
  end
end
