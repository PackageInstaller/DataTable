_class("ChainPreviewMonsterBehaviorComponent", Object)
ChainPreviewMonsterBehaviorComponent = ChainPreviewMonsterBehaviorComponent

function ChainPreviewMonsterBehaviorComponent:Constructor()
  self._previewMonsterRange = {}
  self._outlineEntityList = {}
end

function ChainPreviewMonsterBehaviorComponent:SetPreviewMonsterRange(entityID, skillID)
  self._previewMonsterRange[entityID] = skillID
end

function ChainPreviewMonsterBehaviorComponent:GetPreviewMonsterRange()
  return self._previewMonsterRange
end

function ChainPreviewMonsterBehaviorComponent:SetChainPath(chainPath)
  self._chainPath = chainPath
  self._needRefresh = true
end

function ChainPreviewMonsterBehaviorComponent:GetChainPath()
  return self._chainPath or {}
end

function ChainPreviewMonsterBehaviorComponent:SetNeedRefresh(needRefresh)
  self._needRefresh = needRefresh
end

function ChainPreviewMonsterBehaviorComponent:GetNeedRefresh()
  return self._needRefresh
end

function ChainPreviewMonsterBehaviorComponent:SetOutlineEntityList(entityID, outlineEntityList)
  self._outlineEntityList[entityID] = outlineEntityList
end

function ChainPreviewMonsterBehaviorComponent:GetOutlineEntityList(entityID)
  return self._outlineEntityList[entityID]
end

function Entity:ChainPreviewMonsterBehavior()
  return self:GetComponent(self.WEComponentsEnum.ChainPreviewMonsterBehavior)
end

function Entity:HasChainPreviewMonsterBehavior()
  return self:HasComponent(self.WEComponentsEnum.ChainPreviewMonsterBehavior)
end

function Entity:AddChainPreviewMonsterBehavior()
  local index = self.WEComponentsEnum.ChainPreviewMonsterBehavior
  local component = ChainPreviewMonsterBehaviorComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceChainPreviewMonsterBehavior()
  local index = self.WEComponentsEnum.ChainPreviewMonsterBehavior
  local component = ChainPreviewMonsterBehaviorComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveChainPreviewMonsterBehavior()
  if self:HasChainPreviewMonsterBehavior() then
    self:RemoveComponent(self.WEComponentsEnum.ChainPreviewMonsterBehavior)
  end
end

local ChainPreviewMonsterBehaviorType = {
  None = 0,
  TeamInRange = 1,
  MAX = 99
}
_enum("ChainPreviewMonsterBehaviorType", ChainPreviewMonsterBehaviorType)
