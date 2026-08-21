require("buff_logic_base")
_class("BuffLogicAddBuffMaxRoundCount", BuffLogicBase)
BuffLogicAddBuffMaxRoundCount = BuffLogicAddBuffMaxRoundCount

function BuffLogicAddBuffMaxRoundCount:Constructor(buffInstance, logicParam)
  self._addVal = tonumber(logicParam.addVal)
end

function BuffLogicAddBuffMaxRoundCount:DoLogic(notify)
  local entity = notify:GetDefenderEntity()
  local buffID = notify:GetBuffID()
  local seqID = notify:GetBuffSeqID()
  if not buffID or not seqID then
    return
  end
  local cBuff = entity:BuffComponent()
  local instance = cBuff:GetBuffBySeq(seqID)
  if not instance then
    return
  end
  local before = instance:GetMaxRoundCount()
  instance:AddMaxRoundCount(self._addVal)
  local after = instance:GetMaxRoundCount()
  return {
    entityID = entity:GetID(),
    buffID = buffID,
    seqID = seqID,
    beforeRound = before,
    afterRound = after
  }
end
