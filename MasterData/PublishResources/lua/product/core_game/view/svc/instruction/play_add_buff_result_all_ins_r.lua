require("base_ins_r")
_class("PlayAddBuffResultAllInstruction", BaseInstruction)
PlayAddBuffResultAllInstruction = PlayAddBuffResultAllInstruction

function PlayAddBuffResultAllInstruction:Constructor(paramList)
  if paramList.stageIndex then
    self._stageIndex = tonumber(paramList.stageIndex)
  end
  self._checkUnload = false
  if paramList.checkUnload then
    self._checkUnload = true
  end
end

function PlayAddBuffResultAllInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playBuffService = world:GetService("PlayBuff")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local buffResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBuff, self._stageIndex)
  if not buffResultArray or table.count(buffResultArray) == 0 then
    return
  end
  for _, v in pairs(buffResultArray) do
    local eid = v:GetEntityID()
    local targetEntity = world:GetEntityByID(eid)
    local buffArray = v:GetAddBuffResult()
    local isRemove = v:GetIsRemove()
    if targetEntity and buffArray then
      for _, seq in pairs(buffArray) do
        Log.debug("PlayTargetAddBuff entityid=", eid, " buffseq=", seq, " isRemove=", isRemove)
        local buffViewInst = targetEntity:BuffView():GetBuffViewInstance(seq)
        if buffViewInst then
          local buffID = buffViewInst:BuffID()
          local buffEffectType = buffViewInst:GetBuffEffectType()
          if isRemove then
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
