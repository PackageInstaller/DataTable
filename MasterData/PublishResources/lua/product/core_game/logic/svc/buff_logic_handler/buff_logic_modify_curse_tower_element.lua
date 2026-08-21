_class("BuffLogicModifyCurseTowerElement", BuffLogicBase)
BuffLogicModifyCurseTowerElement = BuffLogicModifyCurseTowerElement

function BuffLogicModifyCurseTowerElement:Constructor(buffInstance, logicParam)
end

function BuffLogicModifyCurseTowerElement:DoLogic()
  local e = self._buffInstance:Entity()
  local gridLocCmpt = e:GridLocation()
  local curGridPos = gridLocCmpt:GetGridPos()
  local curseTowerCmpt = e:CurseTower()
  if not curseTowerCmpt then
    return
  end
  local towerIndex = self:CalcTowerIndex(curGridPos)
  curseTowerCmpt:SetTowerIndex(towerIndex)
  local targetElement = self:CalcCurseTowerElement(towerIndex)
  e:ReplaceElement(targetElement)
  return true
end

function BuffLogicModifyCurseTowerElement:CalcTowerIndex(towerPos)
  local xEqualOne = towerPos.x - 1 < 0.99
  local xEqualEight = 0.99 > towerPos.x - 8
  local yEqualOne = 0.99 > towerPos.y - 1
  local yEqualEight = 0.99 > towerPos.y - 8
  if xEqualOne and yEqualOne then
    return 4
  end
  if xEqualEight and yEqualOne then
    return 3
  end
  if xEqualEight and yEqualEight then
    return 2
  end
  return 1
end

function BuffLogicModifyCurseTowerElement:CalcCurseTowerElement(towerIndex)
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamOrder = teamEntity:Team():GetTeamOrder()
  local teamCount = #teamOrder
  local petPstID = -1
  if towerIndex <= teamCount then
    petPstID = teamOrder[towerIndex]
  else
    petPstID = teamOrder[teamCount]
  end
  local petEntity = teamEntity:Team():GetPetEntityByPetPstID(petPstID)
  if petEntity == nil then
    return ElementType.ElementType_None
  end
  local elementCmpt = petEntity:Element()
  return elementCmpt:GetPrimaryType()
end
