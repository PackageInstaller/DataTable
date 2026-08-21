_class("BuffViewShowEffectWhenTeamInSkillScope", BuffViewBase)
BuffViewShowEffectWhenTeamInSkillScope = BuffViewShowEffectWhenTeamInSkillScope

function BuffViewShowEffectWhenTeamInSkillScope:PlayView(TT)
  local buffResult = self._buffResult
  local match = buffResult:GetMatch()
  local effectId = buffResult:GetEffectId()
  local resultBuffId = buffResult:GetBuffID()
  local resultBuffSeq = buffResult:GetBuffSeq()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamEntityLeader = teamEntity:GetTeamLeaderPetEntity()
  local effectHolderCmpt = teamEntityLeader:EffectHolder()
  if not effectHolderCmpt then
    teamEntityLeader:AddEffectHolder()
    effectHolderCmpt = teamEntityLeader:EffectHolder()
  end
  local idDic = effectHolderCmpt:GetEffectIDEntityDic()
  local effectList = idDic[effectId]
  if match then
    local hasCreate = false
    if effectList then
      hasCreate = true
    end
    if not hasCreate then
      local effectService = self._world:GetService("Effect")
      local effEntity = effectService:CreateEffect(effectId, teamEntityLeader)
    end
  else
    local petList = teamEntity:Team():GetTeamPetEntities()
    for i, entity in ipairs(petList) do
      self:_ClearEffect(entity, effectId)
    end
  end
  local playBuffService = self._world:GetService("PlayBuff")
  local buffViewComponent = teamEntity:BuffView()
  if buffViewComponent then
    local viewIns = buffViewComponent:GetBuffViewInstanceArray()
    for _, inst in ipairs(viewIns) do
      local nuffSeq = inst:BuffSeq()
      local buffID = inst:BuffID()
      local buffEffectType = inst:GetBuffEffectType()
      if table.intable(resultBuffSeq, nuffSeq) then
        if match then
          playBuffService:PlayAddBuff(TT, inst, teamEntity:GetID())
        else
          playBuffService:PlayRemoveBuff(TT, inst, NTBuffUnload:New())
        end
      end
    end
  end
end

function BuffViewShowEffectWhenTeamInSkillScope:IsNotifyMatch(notify)
  if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveStart or notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    local movePos = self._buffResult:GetMovePos()
    return movePos == notify:GetPos()
  else
    return true
  end
end

function BuffViewShowEffectWhenTeamInSkillScope:_ClearEffect(entity, effectId)
  local effectHolderCmpt = entity:EffectHolder()
  if not effectHolderCmpt then
    entity:AddEffectHolder()
    effectHolderCmpt = entity:EffectHolder()
  end
  local idDic = effectHolderCmpt:GetEffectIDEntityDic()
  local effectList = idDic[effectId]
  if effectList then
    for k, entityID in pairs(effectList) do
      if entityID then
        local entity = self._world:GetEntityByID(entityID)
        if entity then
          self._world:DestroyEntity(entity)
        end
      end
    end
    idDic[effectId] = nil
  end
end
