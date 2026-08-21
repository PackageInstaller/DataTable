_class("BuffViewSuperForceRefreshUnlockHP", BuffViewBase)
BuffViewSuperForceRefreshUnlockHP = BuffViewSuperForceRefreshUnlockHP

function BuffViewSuperForceRefreshUnlockHP:PlayView(TT)
  local buffView = self._entity:BuffView()
  local index = buffView:GetHPLockIndex()
  local hpComponent = self._entity:HP()
  if hpComponent:IsShowHPSlider() then
    local sepPoolWidget = hpComponent:GetSepPoolWidget()
    if sepPoolWidget then
      local sepPool = sepPoolWidget:GetAllSpawnList()
      if sepPool and table.count(sepPool) > 0 then
        for i = 1, table.count(sepPool) do
          sepPool[i]:GetGameObject():SetActive(false)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeBossHPLock, i, false)
        end
      end
    end
  end
  local hp = self._entity:HP()
  hp:SetHPLockSepList({})
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTBreakHPLock:New(self._entity))
  buffView:ResetHPLockState()
end

function BuffViewSuperForceRefreshUnlockHP:IsNotifyMatch(notify)
  return true
end
