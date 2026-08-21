_class("BuffLogicChangeAutoBeadAttr", BuffLogicBase)
BuffLogicChangeAutoBeadAttr = BuffLogicChangeAutoBeadAttr

function BuffLogicChangeAutoBeadAttr:Constructor(buffInstance, logicParam)
  self._autoBeadTagList = logicParam.autoBeadTagList
  self._addMap = logicParam.addMap
end

function BuffLogicChangeAutoBeadAttr:DoLogic(notify)
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
  local addMap = self._addMap
  local autoBeadCmpt = holderEntity:LogicAutoBead()
  if autoBeadCmpt then
    for attrKey, addVal in pairs(addMap) do
      autoBeadCmpt:AddAttrByTag(tagList, attrKey, addVal)
    end
  end
end
