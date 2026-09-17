local this = {}
local m_battleCutInPath = "UI/Pages/BattlePage/module_effectCutin.prefab"

function this:initBattleFlyEffect()
end

function this:showBattleCutInEffect()
  if self._battleCutInGo then
    self.pool:despawn(self._battleCutInGo)
  end
  
  local function _end(go)
    local trans = go.transform
    trans:SetParent(self.root)
    trans.localScale = Unity.Vector3.one
    self._battleCutInGo = go
    self._battleCutInGo:ActiveTrans(false)
    self._battleCutInGo:ActiveTrans(true)
    L_TimerManager:newOrResetTimer(self, "battleCutInTimer", function()
      self.pool:despawn(self._battleCutInGo)
      self._battleCutInGo = nil
    end, 2.5)
  end
  
  self.pool:asyncSpawn(m_battleCutInPath, _end, nil, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_FlyMsg))
end

function this:disposeBattleFlyEffect()
  L_TimerManager:clearTimer(self)
  if self._battleCutInGo then
    self.pool:despawn(self._battleCutInGo)
  end
  self._battleCutInGo = nil
end

return this
