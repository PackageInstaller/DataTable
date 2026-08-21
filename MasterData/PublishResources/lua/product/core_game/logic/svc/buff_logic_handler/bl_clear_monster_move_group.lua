_class("BuffLogicClearMonsterMoveGroup", BuffLogicBase)
BuffLogicClearMonsterMoveGroup = BuffLogicClearMonsterMoveGroup

function BuffLogicClearMonsterMoveGroup:Constructor(buffInstance, logicParam)
end

function BuffLogicClearMonsterMoveGroup:DoLogic()
  local monsterIDCmpt = self._entity:MonsterID()
  if not monsterIDCmpt then
    return
  end
  monsterIDCmpt:SetMoveGroupID(nil)
end
