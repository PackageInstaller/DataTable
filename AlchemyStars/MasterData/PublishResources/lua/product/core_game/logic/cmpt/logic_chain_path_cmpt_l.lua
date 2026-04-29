_class("LogicChainPathComponent", Object)
LogicChainPathComponent = LogicChainPathComponent

function LogicChainPathComponent:Constructor()
  self._elementType = -1
  self._chainPath = {}
  self._cutChainPath = {}
  self._pathSuperGridCount = {}
  self._pathPoorGridCount = {}
  self._pathChainRate = {}
  self._chainPathStartPos = Vector2.zero
end

function LogicChainPathComponent:ClearLogicChainPath()
  self._elementType = -1
  self._chainPath = {}
  self._cutChainPath = {}
  self._pathSuperGridCount = {}
  self._pathPoorGridCount = {}
  self._pathChainRate = {}
  self._chainPathStartPos = Vector2.zero
end

function LogicChainPathComponent:GetLogicChainPath()
  return self._chainPath
end

function LogicChainPathComponent:GetLogicPieceType()
  return self._elementType
end

function LogicChainPathComponent:SetLogicChainPath(chainPath, elementType)
  self._chainPath = chainPath
  self._elementType = elementType
  self._chainPathStartPos = chainPath[1]
end

function LogicChainPathComponent:SetChainRateAtIndex(index, rate)
  self._pathChainRate[index] = rate
end

function LogicChainPathComponent:GetChainRateAtIndex(index)
  return self._pathChainRate[index] or 1
end

function LogicChainPathComponent:SetCutChainPath(cutChainPath)
  self._cutChainPath = cutChainPath
end

function LogicChainPathComponent:GetCutChainPath()
  return self._cutChainPath
end

function LogicChainPathComponent:SetPathSuperGridCount(t)
  self._pathSuperGridCount = t
end

function LogicChainPathComponent:GetPathSuperGridCount()
  return self._pathSuperGridCount
end

function LogicChainPathComponent:GetSuperGridCountAtPathIndex(index)
  return self._pathSuperGridCount[index]
end

function LogicChainPathComponent:SetPathPoorGridCount(t)
  self._pathPoorGridCount = t
end

function LogicChainPathComponent:GetPathPoorGridCount()
  return self._pathPoorGridCount
end

function LogicChainPathComponent:GetPoorGridCountAtPathIndex(index)
  return self._pathPoorGridCount[index]
end

function LogicChainPathComponent:SetChainAcrossMonster(chainAcrossMonster)
  self._chainAcrossMonster = chainAcrossMonster
end

function LogicChainPathComponent:GetChainAcrossMonster()
  return self._chainAcrossMonster
end

function LogicChainPathComponent:SetChainMonsterPosList(monsterPosList)
  self._monsterPosList = monsterPosList
end

function LogicChainPathComponent:GetChainMonsterPosList()
  return self._monsterPosList
end

function LogicChainPathComponent:SetChainAcrossSelectMonster(remove, entityID)
  if not self._chainAcrossMonsterIDList then
    self._chainAcrossMonsterIDList = {}
  end
  if remove then
    table.removev(self._chainAcrossMonsterIDList, entityID)
  elseif not table.icontains(self._chainAcrossMonsterIDList, entityID) then
    table.insert(self._chainAcrossMonsterIDList, entityID)
  end
end

function LogicChainPathComponent:GetChainAcrossMonsterIDList()
  return self._chainAcrossMonsterIDList
end

function LogicChainPathComponent:SetChainPathStartPos(pos)
  self._chainPathStartPos = pos
end

function LogicChainPathComponent:GetChainPathStartPos()
  return self._chainPathStartPos
end

function Entity:LogicChainPath()
  return self:GetComponent(self.WEComponentsEnum.LogicChainPath)
end

function Entity:HasLogicChainPath()
  return self:HasComponent(self.WEComponentsEnum.LogicChainPath)
end

function Entity:AddLogicChainPath()
  local index = self.WEComponentsEnum.LogicChainPath
  local component = LogicChainPathComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceLogicChainPath()
  local index = self.WEComponentsEnum.LogicChainPath
  local component = LogicChainPathComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveLogicChainPath()
  if self:HasLogicChainPath() then
    self:RemoveComponent(self.WEComponentsEnum.LogicChainPath)
  end
end
