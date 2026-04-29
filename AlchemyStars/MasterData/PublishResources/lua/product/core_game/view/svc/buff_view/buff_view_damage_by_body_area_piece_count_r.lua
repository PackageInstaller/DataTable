_class("BuffViewDamageByBodyAreaPieceCount", BuffViewBase)
BuffViewDamageByBodyAreaPieceCount = BuffViewDamageByBodyAreaPieceCount

function BuffViewDamageByBodyAreaPieceCount:PlayView(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayDamageBuff(TT, self)
end

function BuffViewDamageByBodyAreaPieceCount:IsNotifyMatch(notify)
  local result = self._buffResult
  local entity = self._entity
  if notify:GetNotifyType() == NotifyType.BuffLoad then
    return entity:GetID() == notify:GetNotifyEntity():GetID()
  end
  return true
end
