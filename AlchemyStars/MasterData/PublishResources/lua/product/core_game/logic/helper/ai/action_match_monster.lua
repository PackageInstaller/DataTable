require("action_move_base")
_class("ActionMatchMonster", AINewNode)
ActionMatchMonster = ActionMatchMonster

function ActionMatchMonster:Constructor()
end

function ActionMatchMonster:Reset()
  ActionMatchMonster.super.Reset(self)
end

function ActionMatchMonster:OnUpdate(dt)
  local monsterID = self.m_entityOwn:MonsterID():GetMonsterID()
  local monsterClassID = Cfg.cfg_monster[monsterID].ClassID
  local targetMonsterClassID = self:GetLogicData(-1)
  if monsterClassID == targetMonsterClassID then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end
