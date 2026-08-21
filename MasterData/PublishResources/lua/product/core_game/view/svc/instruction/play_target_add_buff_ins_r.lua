require("base_ins_r")
_class("PlayTargetAddBuffInstruction", BaseInstruction)
PlayTargetAddBuffInstruction = PlayTargetAddBuffInstruction

function PlayTargetAddBuffInstruction:Constructor(paramList)
  self._buffID = tonumber(paramList.buffID)
  self._buffEffectType = tonumber(paramList.buffEffectType)
  if paramList.animName then
    self._animName = paramList.animName
  end
  if paramList.effectId then
    self._effectId = tonumber(paramList.effectId)
  end
  if paramList.stageIndex then
    self._stageIndex = tonumber(paramList.stageIndex)
  end
  self._isRemove = false
  if paramList.remove then
    self._isRemove = true
  end
  self._checkUnload = false
  if paramList.checkUnload then
    self._checkUnload = true
  end
end

function PlayTargetAddBuffInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playBuffService = world:GetService("PlayBuff")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local buffResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBuff, self._stageIndex)
  if not buffResultArray then
    return
  end
  local targetEntity = world:GetEntityByID(targetEntityID)
  if targetEntity == nil then
    return
  end
  local utilDataSvc = world:GetService("UtilData")
  self._buffID = utilDataSvc:GetReplacedBuffIdForPlayIns(targetEntity, self._buffID)
  self._buffEffectType = utilDataSvc:GetReplacedBuffEffectTypeForPlayIns(targetEntity, self._buffEffectType)
  for _, v in pairs(buffResultArray) do
    local eid = v:GetEntityID()
    local buffArray = v:GetAddBuffResult()
    if targetEntityID == eid and buffArray then
      for _, seq in pairs(buffArray) do
        Log.debug("PlayTargetAddBuff entityid=", eid, " buffseq=", seq, " isRemove=", self._isRemove)
        local buffViewInst = targetEntity:BuffView():GetBuffViewInstance(seq)
        if buffViewInst then
          local buffID = buffViewInst:BuffID()
          local buffEffectType = buffViewInst:GetBuffEffectType()
          local buffMatch = self._buffID and self._buffID == buffID or self._buffEffectType == buffEffectType
          if buffMatch then
            if self._animName then
              targetEntity:SetAnimatorControllerTriggers({
                self._animName
              })
            end
            if self._effectId then
              local effect = world:GetService("Effect"):CreateEffect(self._effectId, targetEntity)
            end
            if self._isRemove then
              local checkOk = false
              if self._checkUnload then
                if buffViewInst:IsUnload() then
                  checkOk = true
                end
              else
                checkOk = true
              end
              if checkOk then
                playBuffService:PlayRemoveBuff(TT, buffViewInst, NTBuffUnload:New())
              end
            else
              local checkOk = false
              if self._checkUnload then
                if not buffViewInst:IsUnload() then
                  checkOk = true
                end
              else
                checkOk = true
              end
              if checkOk then
                if v:GetBuffInitLayer() then
                  targetEntity:BuffView():SetBuffValue(buffViewInst._buffLayerName, v:GetBuffInitLayer())
                end
                playBuffService:PlayAddBuff(TT, buffViewInst, casterEntity:GetID())
              end
            end
          end
        end
      end
    end
  end
end

function PlayTargetAddBuffInstruction:GetCacheResource()
  local t = {}
  if self._effectId and self._effectId > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectId].ResPath,
      1
    })
  end
  return t
end
