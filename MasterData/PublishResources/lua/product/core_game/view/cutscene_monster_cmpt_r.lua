_class("CutsceneMonsterComponent", Object)
CutsceneMonsterComponent = CutsceneMonsterComponent

function CutsceneMonsterComponent:Constructor()
  self._name = "none"
  self._hadPlayDead = false
end

function CutsceneMonsterComponent:SetCutsceneMonsterName(name)
  self._name = name
end

function CutsceneMonsterComponent:GetCutsceneMonsterName()
  return self._name
end

function CutsceneMonsterComponent:SetLastMovePos(lastMovePos)
  self._lastMovePos = lastMovePos
end

function CutsceneMonsterComponent:GetLastMovePos()
  return self._lastMovePos
end

function CutsceneMonsterComponent:SetHadPlayDead(hadPlayDead)
  self._hadPlayDead = hadPlayDead
end

function CutsceneMonsterComponent:GetHadPlayDead()
  return self._hadPlayDead
end

function CutsceneMonsterComponent:WEC_PostInitialize(owner)
end

function CutsceneMonsterComponent:WEC_PostRemoved()
end

function Entity:CutsceneMonster()
  return self:GetComponent(self.WEComponentsEnum.CutsceneMonster)
end

function Entity:HasCutsceneMonster()
  return self:HasComponent(self.WEComponentsEnum.CutsceneMonster)
end

function Entity:AddCutsceneMonster()
  local index = self.WEComponentsEnum.CutsceneMonster
  local component = CutsceneMonsterComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceCutsceneMonster()
  local index = self.WEComponentsEnum.CutsceneMonster
  local component = CutsceneMonsterComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveCutsceneMonster()
  if self:HasCutsceneMonster() then
    self:RemoveComponent(self.WEComponentsEnum.CutsceneMonster)
  end
end
