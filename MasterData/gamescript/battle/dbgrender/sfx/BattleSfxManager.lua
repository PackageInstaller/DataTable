local BattleSfxManager = System.NewClass("BattleSfxManager")

function BattleSfxManager:ctor()
  self.usingSfx = {}
  self.speed = 1
end

function BattleSfxManager:SetRoot(sfxRoot)
  self.root = sfxRoot
end

function BattleSfxManager:Preload(sfxId)
  local DT = bg.DT
  local sfxConfig = DT.BattleSfxConfig[sfxId]
  assert(sfxConfig, "找不到特效id " .. sfxId)
  local sfxPath = self:GetSfxPath(sfxId, nil)
  local pool = Pool.CreateWithTag(BattleSfx, sfxPath, 2, sfxConfig, self.root)
  return pool
end

function BattleSfxManager:CreateSfx(sfxId, parent, pos, worldPositionStays, onDestroyed, abortSignal, scale, castRoleUid)
  local DT = bg.DT
  local sfxConfig = DT.BattleSfxConfig[sfxId]
  local sfxPath = self:GetSfxPath(sfxId, castRoleUid)
  if not sfxPath then
    return
  end
  local sfx = Pool.GetWithTag(BattleSfx, sfxPath, sfxConfig, self.root)
  sfx:Init(parent, pos, sfxConfig.Time, worldPositionStays, function()
    self.usingSfx[sfx] = nil
    if nil ~= onDestroyed then
      onDestroyed(sfx)
    end
  end, abortSignal, scale)
  self.usingSfx[sfx] = true
  return sfx
end

function BattleSfxManager:GetSfxPath(sfxId, casterRoleUid)
  local sfxConfig = bg.DT.BattleSfxConfig[sfxId]
  local sfxPath = sfxConfig.FileName
  if casterRoleUid then
    do return bg.battleDataCenter.ReplaceSfxPath, bg.battleDataCenter, sfxPath end
    return bg.battleDataCenter.ReplaceSfxPath, bg.battleDataCenter, sfxPath, casterRoleUid
  end
  return sfxPath
end

function BattleSfxManager:FreeSfx(sfx)
  if sfx then
    sfx.pool:Free(sfx)
  end
end

function BattleSfxManager:Tick(deltaTime)
  for sfx in pairs(self.usingSfx or {}) do
    sfx:Tick(deltaTime)
  end
end

function BattleSfxManager:Dispose()
  for sfx in pairs(self.usingSfx) do
    sfx.pool:Free(sfx)
  end
  self.usingSfx = nil
end

return BattleSfxManager
