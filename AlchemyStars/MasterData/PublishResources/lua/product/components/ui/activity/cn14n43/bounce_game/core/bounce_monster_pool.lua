_class("BounceMonsterPool", Object)
BounceMonsterPool = BounceMonsterPool

function BounceMonsterPool:Constructor()
end

function BounceMonsterPool:PrepareInit()
end

function BounceMonsterPool:Get(monsterId)
  return MonsterFactory.Acquire(monsterId)
end

function BounceMonsterPool:Recyle(monster)
  MonsterFactory.Recycle(monster)
end

function BounceMonsterPool:ClearPool()
  MonsterFactory.Destroy()
end
