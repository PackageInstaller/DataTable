_class("BuffLogicShowEffectWhenTeamInSkillScope", BuffLogicBase)
BuffLogicShowEffectWhenTeamInSkillScope = BuffLogicShowEffectWhenTeamInSkillScope

function BuffLogicShowEffectWhenTeamInSkillScope:Constructor(buffInstance, logicParam)
  self._effectID = logicParam.effectID
  self._skillID = logicParam.skillID
  self._buffID = logicParam.buffID
  self._buffEffect = logicParam.buffEffect
end

function BuffLogicShowEffectWhenTeamInSkillScope:DoLogic(notify)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local posTeam = teamEntity:GridLocation().Position
  local curMovePos = posTeam
  if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveStart or notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    curMovePos = notify:GetPos()
  elseif notify:GetNotifyType() == NotifyType.Teleport then
    local entity = notify:GetNotifyEntity()
    if not entity:HasTeam() and not entity:HasPetPstID() then
      return
    end
    curMovePos = notify:GetPosNew()
  elseif notify:GetNotifyType() == NotifyType.HitBackEnd then
    if notify:GetDefenderId() ~= teamEntity:GetID() then
      return
    end
    curMovePos = notify:GetPosEnd()
  elseif notify:GetNotifyType() == NotifyType.TransportEachMoveEnd then
    if notify:GetNotifyEntity():GetID() ~= teamEntity:GetID() then
      return
    end
    curMovePos = notify:GetPosNew()
  end
  local ownerEntity = self._buffInstance:Entity()
  local bodyArea = ownerEntity:BodyArea():GetArea()
  local posSelf = ownerEntity:GridLocation().Position
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(self._skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local skillResult = skillCalculater:CalcSkillScope(skillConfigData, posSelf, Vector2(0, 1), bodyArea)
  local match = table.icontains(skillResult:GetAttackRange(), curMovePos)
  local buffResult = BuffResultShowEffectWhenTeamInSkillScope:New(match, self._effectID)
  buffResult:SetMovePos(curMovePos)
  local buffSvc = self._world:GetService("BuffLogic")
  if match then
    local buffInstance = buffSvc:AddBuff(self._buffID, teamEntity, {casterEntity = teamEntity})
    if buffInstance then
      buffResult:SetBuffSeq({
        buffInstance:BuffSeq()
      })
    end
  else
    local buffCmpt = teamEntity:BuffComponent()
    local tSeqID = buffCmpt:RemoveBuffByEffectType(self._buffEffect, NTBuffUnload:New())
    buffResult:SetBuffSeq(tSeqID)
  end
  buffResult:SetBuffID(self._buffID)
  return buffResult
end
