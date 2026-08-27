local ExclusiveWeaponEffectUtil = {}
local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
ExclusiveWeaponEffectUtil.EEwEffectType = {Battle = 1, Formation = 2}

function ExclusiveWeaponEffectUtil:BattleRoleEntityPlayEWEffect(BattleRoleEntity)
  if IsNull(BattleRoleEntity) then
    return
  end
  local heroData = BattleRoleEntity.character.heroData
  local heroObj = BattleRoleEntity.lsObject.gameObject
  if IsNull(heroObj) then
    return
  end
  self:PlayEWEffectByHeroData(heroData, heroObj, ExclusiveWeaponEffectUtil.EEwEffectType.Battle)
end

function ExclusiveWeaponEffectUtil:PlayEWEffectByHeroData(heroData, heroObj, ewEffectType, layer, needForcePlay)
  if heroData == nil then
    return
  end
  local heroId = heroData.dataId
  if needForcePlay ~= true then
    local isActivateEW = heroData:IsActivateSpecWeapon()
    if isActivateEW == false then
      return
    end
  end
  CS_AnimationEffectController_Ins:KillRoleEffect(heroObj)
  CS_AnimationEffectController_Ins:RecycleRoleEffect(heroObj)
  local resModelCfg = ConfigData.resource_model[heroId]
  if resModelCfg == nil then
    return
  end
  local effectIdList
  if ewEffectType == ExclusiveWeaponEffectUtil.EEwEffectType.Battle then
    effectIdList = resModelCfg.spec_effect_id
  elseif ewEffectType == ExclusiveWeaponEffectUtil.EEwEffectType.Formation then
    effectIdList = resModelCfg.spec_idle_effect_id
  else
    effectIdList = resModelCfg.spec_effect_id
  end
  if effectIdList == nil then
    return
  end
  local resName = heroData:GetResModelName(true)
  for _, effectId in ipairs(effectIdList) do
    local effect = CS_AnimationEffectController_Ins:AddAnimationEffectByBattleEffectId(effectId, heroObj, resName)
    effect.effectCfg.Layer = layer
    effect:Play()
  end
end

return ExclusiveWeaponEffectUtil
