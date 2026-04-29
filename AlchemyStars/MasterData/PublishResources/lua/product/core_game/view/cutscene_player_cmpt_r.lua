_class("CutscenePlayerComponent", Object)
CutscenePlayerComponent = CutscenePlayerComponent

function CutscenePlayerComponent:Constructor()
end

function CutscenePlayerComponent:WEC_PostInitialize(owner)
end

function CutscenePlayerComponent:WEC_PostRemoved()
end

function Entity:CutscenePlayer()
  return self:GetComponent(self.WEComponentsEnum.CutscenePlayer)
end

function Entity:HasCutscenePlayer()
  return self:HasComponent(self.WEComponentsEnum.CutscenePlayer)
end

function Entity:AddCutscenePlayer()
  local index = self.WEComponentsEnum.CutscenePlayer
  local component = CutscenePlayerComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceCutscenePlayer()
  local index = self.WEComponentsEnum.CutscenePlayer
  local component = CutscenePlayerComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveCutscenePlayer()
  if self:HasCutscenePlayer() then
    self:RemoveComponent(self.WEComponentsEnum.CutscenePlayer)
  end
end
