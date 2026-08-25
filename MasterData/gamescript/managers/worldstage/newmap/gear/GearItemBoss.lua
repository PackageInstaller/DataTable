local DOWN_STATE_PARTICLE = "Effects/CommonPrefab/E_FinalBattle_loop1.prefab"
local UP_STATE_PARTICLE = "Effects/CommonPrefab/E_FinalBattle_loop2.prefab"
local GearItemBoss, Super = System.NewClass("GearItemBoss", GearItemMonster)

function GearItemBoss:PlayUp()
  if not self:GetIsChoas() then
    self:LoadUpStateParticleGo()
  end
  if self.upStateParticleGo then
    self.upStateParticleGo:SetActive(true)
  end
  Super.PlayUp(self)
end

function GearItemBoss:PlayDown(fromTime)
  if self.upStateParticleGo then
    self.upStateParticleGo:SetActive(false)
  end
  Super.PlayDown(self, fromTime)
end

function GearItemBoss:StartBattle(data)
  Super.StartBattle(self, data)
  self._isEnteredBattle = true
  if self.upStateParticleGo then
    self.upStateParticleGo:SetActive(false)
  end
  if self.downStateParticleGo then
    self.downStateParticleGo:SetActive(false)
  end
end

function GearItemBoss:SetDismissChoas(isDismiss)
  Super.SetDismissChoas(self, isDismiss)
  if isDismiss then
    self:LoadDownStateParticleGo()
  end
end

function GearItemBoss:LoadPrefab(prefabPath)
  Super.LoadPrefab(self, prefabPath)
  if not self:GetIsChoas() then
    self:LoadDownStateParticleGo()
  end
end

function GearItemBoss:LoadDownStateParticleGo()
  if self._isEnteredBattle then
    return
  end
  if not self.downStateParticleGo then
    local prefab = ResLoadMgr.LoadAsset(DOWN_STATE_PARTICLE, self)
    self.downStateParticleGo = Instantiate(prefab, self.go.transform)
  end
end

function GearItemBoss:LoadUpStateParticleGo()
  if self._isEnteredBattle then
    return
  end
  if not self.upStateParticleGo then
    local prefab = ResLoadMgr.LoadAsset(UP_STATE_PARTICLE, self)
    self.upStateParticleGo = Instantiate(prefab, self.go.transform)
  end
end

function GearItemBoss:OnDispose()
  Super.OnDispose(self)
  self.upStateParticleGo = nil
  self.downStateParticleGo = nil
end

return GearItemBoss
