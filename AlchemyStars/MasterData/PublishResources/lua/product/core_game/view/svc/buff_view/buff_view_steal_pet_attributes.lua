_class("BuffViewStealPetAttributes", BuffViewBase)
BuffViewStealPetAttributes = BuffViewStealPetAttributes

function BuffViewStealPetAttributes:PlayView(TT)
  local result = self:GetBuffResult()
  local playDamageService = self._world:GetService("PlayDamage")
  local hp = result:GetHp()
  local hpMax = result:GetHpMax()
  if hp then
    local entity = self._entity
    entity:ReplaceRedAndMaxHP(hp, hpMax)
    playDamageService:_RefreshTeamHP(TT, entity)
  end
  local hpCaster = result:GetHpCaster()
  local hpMaxCaster = result:GetHpMaxCaster()
  if hpCaster then
    local casterEntity = self._viewInstance:GetBuffViewContext() and self._viewInstance:GetBuffViewContext().casterEntity or nil
    casterEntity:ReplaceRedAndMaxHP(hpCaster, hpMaxCaster)
    playDamageService:_RefreshTeamHP(TT, casterEntity)
  end
end

_class("BuffViewResetStealPetAttributes", BuffViewBase)
BuffViewResetStealPetAttributes = BuffViewResetStealPetAttributes

function BuffViewResetStealPetAttributes:PlayView(TT)
  local result = self:GetBuffResult()
  local playDamageService = self._world:GetService("PlayDamage")
  local hp = result:GetHp()
  local hpMax = result:GetHpMax()
  if hp then
    local entity = self._entity
    entity:ReplaceRedAndMaxHP(hp, hpMax)
    playDamageService:_RefreshTeamHP(TT, entity)
  end
  local hpCaster = result:GetHpCaster()
  local hpMaxCaster = result:GetHpMaxCaster()
  if hpCaster then
    local casterEntity = self._viewInstance:GetBuffViewContext() and self._viewInstance:GetBuffViewContext().casterEntity or nil
    casterEntity:ReplaceRedAndMaxHP(hpCaster, hpMaxCaster)
    playDamageService:_RefreshTeamHP(TT, casterEntity)
  end
end
