_class("BuffLogicDamageByBuffRoundLayerAndClear", BuffLogicBase)
BuffLogicDamageByBuffRoundLayerAndClear = BuffLogicDamageByBuffRoundLayerAndClear

function BuffLogicDamageByBuffRoundLayerAndClear:Constructor(buffInstance, logicParam)
  self._damageParam = logicParam
  self._basePercent = logicParam.percent
  self._layerType = logicParam.layerType
  self._removeBuffRound = logicParam.removeBuffRound or {}
  self._damageBuffRound = logicParam.damageBuffRound or {}
  self._oneLayerAddSkillFinal = logicParam.oneLayerAddSkillFinal or 0
end

function BuffLogicDamageByBuffRoundLayerAndClear:DoLogic(notify)
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local petEntity = context.casterEntity
  if not petEntity then
    return
  end
  local defender = self._entity
  local damageBuffList = {}
  local targetBuffList = {}
  local targetBuffSeq = {}
  local buffCmpt = defender:BuffComponent()
  local buffArray = buffCmpt:GetBuffArray()
  local buffCopy = table.shallowcopy(buffArray)
  for _, buffInstance in ipairs(buffCopy) do
    local buffRoundCount = buffInstance:GetBuffRoundCount()
    if not buffInstance:IsUnload() and buffInstance:GetBuffEffectType() == self._layerType then
      if table.intable(self._removeBuffRound, buffRoundCount) then
        table.insert(targetBuffList, buffInstance)
        table.insert(targetBuffSeq, buffInstance:BuffSeq())
      end
      if table.intable(self._damageBuffRound, buffRoundCount) then
        table.insert(damageBuffList, buffInstance)
      end
    end
  end
  local damageBuffCount = table.count(damageBuffList)
  if damageBuffCount == 0 then
    return
  end
  local playerElementCmpt = petEntity:Element()
  if playerElementCmpt then
    playerElementCmpt:SetUseSecondaryType(false)
  end
  local buffLogicService = self._world:GetService("BuffLogic")
  local curMarkLayer = buffLogicService:GetBuffLayer(defender, self._layerType)
  local newPercent = self._basePercent * damageBuffCount
  self._damageParam.percent = newPercent
  if self._damageParam.useSnapAttack then
    self._damageParam.simpleDamage = self._buffInstance:GetSnapCasterAttack()
  end
  self._world:GetMatchLogger():BeginBuff(defender:GetID(), self._buffInstance:BuffID())
  if self._oneLayerAddSkillFinal ~= 0 then
    local addSkillFinal = curMarkLayer * self._oneLayerAddSkillFinal
    self._buffLogicService:ChangeSkillFinalParam(petEntity, self:GetBuffSeq(), ModifySkillParamType.NormalSkill, addSkillFinal)
    self._buffLogicService:ChangeSkillFinalParam(petEntity, self:GetBuffSeq(), ModifySkillParamType.ActiveSkill, addSkillFinal)
  end
  local damageInfo = buffLogicService:DoBuffDamage(self._buffInstance:BuffID(), petEntity, defender, self._damageParam)
  self._buffLogicService:RemoveSkillFinalParam(petEntity, self:GetBuffSeq(), ModifySkillParamType.NormalSkill)
  self._buffLogicService:RemoveSkillFinalParam(petEntity, self:GetBuffSeq(), ModifySkillParamType.ActiveSkill)
  self._world:GetMatchLogger():EndBuff(defender:GetID())
  for _, buffInstance in ipairs(targetBuffList) do
    buffInstance:Unload(NTBuffUnload:New())
  end
  local buffResult = BuffResultDamageByBuffRoundLayerAndClear:New(damageInfo, targetBuffSeq)
  return buffResult
end
