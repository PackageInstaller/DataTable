_class("N19P5PoolData", Object)
N19P5PoolData = N19P5PoolData

function N19P5PoolData:Constructor(poolidx, petlist, monster, bigID)
  self._idx = poolidx
  self._petList = petlist
  self._monster = monster
  self._bigID = bigID
end

function N19P5PoolData:BigID()
  return self._bigID
end

function N19P5PoolData:MonsterName()
  return "n19p5_monster_name_" .. tostring(self._monster)
end

function N19P5PoolData:PetList()
  return self._petList
end

function N19P5PoolData:MonsterID()
  return self._monster
end
