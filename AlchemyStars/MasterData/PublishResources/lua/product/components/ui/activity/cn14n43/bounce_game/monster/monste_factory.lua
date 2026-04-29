_class("MonsterFactory", Object)
MonsterFactory = MonsterFactory
MonsterFactory.AutoAppendPstID = 1

function MonsterFactory.Init()
  MonsterFactory.pools = {}
  MonsterFactory.MonsterBehaviourRegister()
end

function MonsterFactory.Acquire(monsterId)
  if MonsterFactory.pools == nil then
    return nil
  end
  local pool = MonsterFactory.pools[monsterId]
  if pool == nil or #pool <= 0 then
    local monster = MonsterFactory.CreateMonster(monsterId)
    return monster
  end
  local monster = pool[#pool]
  table.remove(pool, #pool)
  return monster
end

function MonsterFactory.Recycle(monster)
  if monster == nil then
    return
  end
  MonsterFactory.DestroyMonster(monster)
end

function MonsterFactory.Destroy()
  if MonsterFactory.pools == nil then
    return
  end
  for k, pool in pairs(MonsterFactory.pools) do
    for i = 1, #pool do
      MonsterFactory.DestroyMonster(pool[i])
    end
  end
  MonsterFactory.pools = nil
  MonsterFactory.Behaviour = nil
end

function MonsterFactory.CreateMonster(monsterId)
  local monsterCfg = Cfg.cfg_bounce_monster[monsterId]
  if not monsterCfg then
    return nil
  end
  local monster = Monster:New(monsterId)
  if monsterCfg.Behaviours then
    for id, param in pairs(monsterCfg.Behaviours) do
      local behaviorType = MonsterFactory.Behaviour[id]
      local behaviour = behaviorType:New()
      behaviour:Init(param)
      monster:AddBehavior(behaviour)
    end
  end
  return monster
end

function MonsterFactory.DestroyMonster(monster)
  if monster == nil then
    return
  end
  monster:Destroy()
end

function MonsterFactory.MonsterBehaviourRegister()
  MonsterFactory.Behaviour = {}
  MonsterFactory.Behaviour[BehaviourId.Position] = MonsterBeHaviorPosition
  MonsterFactory.Behaviour[BehaviourId.Move] = MonsterBeHaviorMove
  MonsterFactory.Behaviour[BehaviourId.Animation] = MonsterBeHaviorAnimation
  MonsterFactory.Behaviour[BehaviourId.View] = MonsterBeHaviorView
  MonsterFactory.Behaviour[BehaviourId.Attack] = MonsterBeHaviorAttack
  MonsterFactory.Behaviour[BehaviourId.DestroyAfterAttack] = MonsterBeHaviorDestroyAfterAttack
  MonsterFactory.Behaviour[BehaviourId.Hurt] = MonsterBeHaviorHurt
  MonsterFactory.Behaviour[BehaviourId.ChangeCampWhenAttacked] = MonsterBeHaviorChgCampWhenAttacked
  MonsterFactory.Behaviour[BehaviourId.ChangeDirectionWhenAttacked] = MonsterBeHaviorChgDirectionWhenAttacked
  MonsterFactory.Behaviour[BehaviourId.Generator] = MonsterBeHaviorGenerator
  MonsterFactory.Behaviour[BehaviourId.ShowHpProgress] = MonsterBeHaviorShowHpProgress
  MonsterFactory.Behaviour[BehaviourId.TransformationWithHp] = MonsterBeHaviorTransformationWithHp
end
