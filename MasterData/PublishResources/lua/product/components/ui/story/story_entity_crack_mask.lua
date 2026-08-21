_class("StoryEntityCrackMask", StoryEntity)
StoryEntityCrackMask = StoryEntityCrackMask

function StoryEntityCrackMask:Constructor(ID, storyManager)
  StoryEntityCrackMask.super.Constructor(self, ID, nil, nil, storyManager)
  self._type = StoryEntityType.CrackMask
  self._allMaterial = nil
end

function StoryEntityCrackMask:_TriggerKeyframe(keyframeData)
  if keyframeData.Active ~= nil then
    if keyframeData.Start then
      self:_CollectMaterial(keyframeData)
      self:_SetMaterialStencil(true)
    end
    if keyframeData.End then
      self:_SetMaterialStencil(false)
      self._allMaterial = nil
    end
  end
end

function StoryEntityCrackMask:_CollectMaterial(keyframeData)
  self._allMaterial = {}
  if keyframeData.EntityIDs then
    local entityIDs = string.split(keyframeData.EntityIDs, ",")
    if #entityIDs <= 0 then
      return
    end
    for i = 1, #entityIDs do
      local storyEntity = self._storyManager:GetStoryEntity(tonumber(entityIDs[i]))
      if storyEntity then
        local entityType = storyEntity:GetEntityType()
        local material
        if entityType == StoryEntityType.Spine or entityType == StoryEntityType.Effect or entityType == StoryEntityType.Picture then
          material = storyEntity:GetMaterial()
        end
        if material then
          if type(material) == "table" then
            for key, value in pairs(material) do
              table.insert(self._allMaterial, value)
            end
          else
            table.insert(self._allMaterial, material)
          end
        end
      end
    end
  end
end

function StoryEntityCrackMask:_SetMaterialStencil(stencil)
  if not self._allMaterial or #self._allMaterial <= 0 then
    return
  end
  local compValue, idValue, opValue = 8, 0, 0
  if stencil then
    compValue, idValue, opValue = 3, 17, 0
  end
  for key, value in pairs(self._allMaterial) do
    if value then
      value:SetFloat("_StencilComp", compValue)
      value:SetFloat("_Stencil", idValue)
      value:SetFloat("_StencilRef", idValue)
      value:SetFloat("_StencilOp", opValue)
    end
  end
end

function StoryEntityCrackMask:Destroy()
  self:_SetMaterialStencil(false)
  self._allMaterial = nil
end
