_class("ActiveSkillMutilSelectGridComponent", Object)
ActiveSkillMutilSelectGridComponent = ActiveSkillMutilSelectGridComponent

function ActiveSkillMutilSelectGridComponent:Constructor(gridposArray, directGridPosArray)
  self._gridPosArray = gridposArray
  self._directGridPosArray = directGridPosArray
end

function ActiveSkillMutilSelectGridComponent:Clear()
  self._gridPosArray = {}
  self._directGridPosArray = {}
end

function ActiveSkillMutilSelectGridComponent:GetGridPosArray()
  return self._gridPosArray
end

function ActiveSkillMutilSelectGridComponent:GetDirectGridPosArray()
  return self._directGridPosArray
end

function ActiveSkillMutilSelectGridComponent:WEC_PostInitialize(owner)
end

function ActiveSkillMutilSelectGridComponent:WEC_PostRemoved()
end

function Entity:ActiveSkillMutilSelectGridComponent()
  return self:GetComponent(self.WEComponentsEnum.ActiveSkillMutilSelectGrid)
end

function Entity:HasActiveSkillMutilSelectGridComponent()
  return self:HasComponent(self.WEComponentsEnum.ActiveSkillMutilSelectGrid)
end

function Entity:AddActiveSkillMutilSelectGridComponent(gridposArray, directGridPosArray)
  local index = self.WEComponentsEnum.ActiveSkillMutilSelectGrid
  local component = ActiveSkillMutilSelectGridComponent:New(gridposArray, directGridPosArray)
  self:AddComponent(index, component)
end

function Entity:ReplaceActiveSkillSelectGrid(gridposArray, directGridPosArray)
  local index = self.WEComponentsEnum.ActiveSkillMutilSelectGrid
  local component = ActiveSkillMutilSelectGridComponent:New(gridposArray, directGridPosArray)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveActiveSkillSelectGrid()
  if self:HasActiveSkillMutilSelectGridComponent() then
    self:RemoveComponent(self.WEComponentsEnum.ActiveSkillMutilSelectGrid)
  end
end
