_class("BuffLogicSetAutoBeadSkillExtraRate", BuffLogicBase)
BuffLogicSetAutoBeadSkillExtraRate = BuffLogicSetAutoBeadSkillExtraRate

function BuffLogicSetAutoBeadSkillExtraRate:Constructor(buffInstance, logicParam)
  self._autoBeadTagList = logicParam.autoBeadTagList
  self._rate = logicParam.rate
end

function BuffLogicSetAutoBeadSkillExtraRate:DoLogic(notify)
  local holderEntity = self._entity
  if self._entity:HasTeam() then
    local teamEntity = self._entity
    local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
    holderEntity = autoBeadServiceLogic:GetAutoBeadSkillHolder(teamEntity)
  end
  if not holderEntity then
    return
  end
  local tagList = self._autoBeadTagList
  local rate = self._rate
  local autoBeadCmpt = holderEntity:LogicAutoBead()
  if autoBeadCmpt then
    autoBeadCmpt:SetExtraRateByTag(tagList, rate)
  end
end
