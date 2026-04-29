_class("BuffViewPlayEffect", BuffViewBase)
BuffViewPlayEffect = BuffViewPlayEffect

function BuffViewPlayEffect:PlayView(TT)
  local buffResult = self._buffResult
  local playerEntity = self._world:Player():GetCurrentTeamEntity()
  local effectID = buffResult:GetEffectID()
  if effectID then
    local effectService = self._world:GetService("Effect")
    local effectEntity = effectService:CreateEffect(effectID, playerEntity)
  end
end
