WeakEdgeType = {
  WeakUp = 1,
  WeakDown = 2,
  WeakRight = 3,
  WeakLeft = 4,
  WeakUp_1 = 11,
  WeakDown_1 = 12,
  WeakRight_1 = 13,
  WeakLeft_1 = 14,
  WeakUp_2 = 21,
  WeakDown_2 = 22,
  WeakRight_2 = 23,
  WeakLeft_2 = 24,
  Max = 99
}
_enum("WeakEdgeType", WeakEdgeType)
_class("MonsterWeakComponent", Object)
MonsterWeakComponent = MonsterWeakComponent

function MonsterWeakComponent:Constructor()
  self._monsterWeakDataList = {}
end

function MonsterWeakComponent:GetMonsterWeakDataByKey(key)
  return self._monsterWeakDataList[key]
end

function MonsterWeakComponent:GetMonsterWeakDataByKeyAndBodyPos(key, bodyAreaPos)
  for _, v in pairs(self._monsterWeakDataList) do
    local monsterWeakData = v
    local bodyPosList = monsterWeakData:GetBodyPosList()
    if string.find(tostring(monsterWeakData:GetKey()), tostring(key)) and table.icontains(bodyPosList, bodyAreaPos) then
      return monsterWeakData
    end
  end
  return nil
end

function MonsterWeakComponent:GetMonsterWeakDataList()
  return self._monsterWeakDataList
end

function MonsterWeakComponent:GetMonsterWeakCount()
  return table.count(self:GetMonsterWeakDataList())
end

function MonsterWeakComponent:SetMonsterWeakData(key, monsterWeakData)
  self._monsterWeakDataList[key] = monsterWeakData
end

function MonsterWeakComponent:RemoveMonsterWeakData(key)
  self._monsterWeakDataList[key] = nil
end

_class("MonsterWeakData", Object)
MonsterWeakData = MonsterWeakData

function MonsterWeakData:Constructor(key, edgePosList, bodyPosList, entityID)
  self._key = key
  self._edgePosList = edgePosList
  self._bodyPosList = bodyPosList
  self._length = 0
  if edgePosList then
    self._length = table.count(edgePosList)
  end
  self._active = true
  self._entityID = entityID
end

function MonsterWeakData:GetKey()
  return self._key
end

function MonsterWeakData:GetEdgePosList()
  return self._edgePosList
end

function MonsterWeakData:GetBodyPosList()
  return self._bodyPosList
end

function MonsterWeakData:GetLength()
  return self._length
end

function MonsterWeakData:GetEntityID()
  return self._entityID
end

function Entity:MonsterWeak()
  return self:GetComponent(self.WEComponentsEnum.MonsterWeak)
end

function Entity:HasMonsterWeak()
  return self:HasComponent(self.WEComponentsEnum.MonsterWeak)
end

function Entity:AddMonsterWeak()
  local index = self.WEComponentsEnum.MonsterWeak
  local component = MonsterWeakComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceMonsterWeak(MonsterWeak)
  local index = self.WEComponentsEnum.MonsterWeak
  local component = MonsterWeakComponent:New(MonsterWeak)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveMonsterWeak()
  if self:HasMonsterWeak() then
    self:RemoveComponent(self.WEComponentsEnum.MonsterWeak)
  end
end
