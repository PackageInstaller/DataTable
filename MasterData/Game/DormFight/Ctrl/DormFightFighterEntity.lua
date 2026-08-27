local DormFightFighterEntity = class("DormFightFighterEntity")
local equipWeaponState = CS.EquipWeaponState
local CS_PvpFightHeroPropertyName_hp = CS.P3.PvpFight.Enum.PvpFightHeroPropertyName.hp
local CS_PvpFightHeroPropertyName_poise = CS.P3.PvpFight.Enum.PvpFightHeroPropertyName.poise

function DormFightFighterEntity:ctor(fighterController, dormFightCtrl, pvpFightController)
  self.fighterController = fighterController
  self.dormFightCtrl = dormFightCtrl
  self.pvpFightController = pvpFightController
  if not IsNull(fighterController) and not IsNull(fighterController.NetCharacter) then
    self.weaponController = fighterController.NetCharacter:GetComponent(typeof(CS.WeaponController))
  end
  self.__OnFighterNetSrart = BindCallback(self, self.OnFighterNetSrart)
  self.__OnLoseHp = BindCallback(self, self.OnFighterLostHp)
  fighterController.OnStart = self.__OnFighterNetSrart
  fighterController.NetCharacter.roleEntity:AddEntityAttrChangeListener(1, self.__OnLoseHp)
  self.__OnRevive = BindCallback(self, self.OnFighterRevive)
  fighterController.OnRevive = self.__OnRevive
  self.__OnHit = BindCallback(self, self.OnFighterHit)
  fighterController.OnHit = self.__OnHit
  self.__OnAttack = BindCallback(self, self.OnFighterAttack)
  fighterController.OnAttack = self.__OnAttack
end

function DormFightFighterEntity:PlayEffect(effectId)
  local fighterController = self.fighterController
  if IsNull(fighterController) then
    return
  end
  local effectCtrl = self.dormFightCtrl.effectCtrl
  if effectCtrl ~= nil then
    local skinId = self:GetSkinId()
    local skinCfg = ConfigData.skin[skinId]
    effectCtrl:AddFighterEffectByDormFightEffectId(fighterController, effectId, skinCfg.src_id_pic, skinCfg.src_id_pic)
  end
end

function DormFightFighterEntity:PlaySoundFx(audioId)
  AudioManager:PlayAudioById(audioId)
end

function DormFightFighterEntity:GetSkinId()
  local fighterController = self.fighterController
  if IsNull(fighterController) then
    return
  end
  local skinId = fighterController.NetCharacter.NetId.PrefabId
  return skinId
end

function DormFightFighterEntity:OnFighterNetSrart()
  local fighterController = self.fighterController
  if IsNull(fighterController) then
    return
  end
  local selfFighterEffectId = tonumber(ConfigData.dorm_fight_config.selfFighterEffectId)
  local enemyFighterEffectId = tonumber(ConfigData.dorm_fight_config.enemyFighterEffectId)
  local unitEffectId = fighterController.NetCharacter.IsOwnedBySelf and selfFighterEffectId or enemyFighterEffectId
  self:PlayEffect(unitEffectId)
  local bornEffectId = 4
  self:PlayEffect(bornEffectId)
  self:PlaySoundFx(ConfigData.dorm_fight_config.fighterCreateAudioId)
end

function DormFightFighterEntity:OnFighterLostHp(FighterController, oldValue, newValue)
  local fighterController = self.fighterController
  if IsNull(fighterController) then
    return
  end
  self.fighterController:NetStopRun()
  self.fighterController.FighterAnimator:SetFloat("velocity", 0)
  if self:IsNotEquipWeapon() then
    self.oldEpRecoverPerSecond = fighterController.NetCharacter.roleEntity.epRecoverPerSecond
    fighterController.NetCharacter.roleEntity.epRecoverPerSecond = self.oldEpRecoverPerSecond * ConfigData.dorm_fight_config.downRecoverPerSecond
  end
  local hitEffectId = tonumber(ConfigData.dorm_fight_config.hitEffectId)
  self:PlayEffect(hitEffectId)
  if newValue <= 0 and not self.isPlayingtDieAnimation then
    self.isPlayingtDieAnimation = true
    self.fighterController.NetCharacter.roleEntity:SetRoleProperty(CS_PvpFightHeroPropertyName_hp:GetHashCode(), 1)
    self.fighterController.NetCharacter.roleEntity:SetRoleProperty(CS_PvpFightHeroPropertyName_poise:GetHashCode(), 0)
    local deathEffectId = 5
    self:PlayEffect(deathEffectId)
    self.dormFightCtrl:CurrentFighterDie(self.fighterController)
  end
  if isGameDev then
    local name = FighterController.gameObject.name
    local damage = oldValue - newValue
    print(name .. "受到了" .. tostring(damage) .. "点伤害")
  end
end

function DormFightFighterEntity:OnFighterRevive()
  local fighterController = self.fighterController
  if IsNull(fighterController) then
    return
  end
  if self.isPlayingtDieAnimation then
    self.fighterController:NetRetired()
    return
  end
  self:PlaySoundFx(ConfigData.dorm_fight_config.fightReviveAudioId)
  if self.oldEpRecoverPerSecond ~= nil then
    fighterController.NetCharacter.roleEntity.epRecoverPerSecond = self.oldEpRecoverPerSecond
    self.oldEpRecoverPerSecond = nil
  end
  local cfg = ConfigData.dorm_fight_config
  for instanceId, netId in pairs(self.pvpFightController.InstanceNetIdDic) do
    local mainSyncItem = netId.mainSyncItem
    if mainSyncItem ~= nil and fighterController ~= mainSyncItem.FighterController then
      local selfPos = fighterController.transform.position
      local targetPos = mainSyncItem.transform.position
      local distance = Vector3.Distance(targetPos, selfPos)
      local type = mainSyncItem:GetType()
      if type == typeof(CS.P3.PvpFight.NetCharacter) then
        local targetFighterController = mainSyncItem.FighterController
        if not self.fighterController:Equals(targetFighterController) and not targetFighterController.IsDead and distance < cfg.reviveShockRangeForFighter then
          targetFighterController:HitForce(1, (selfPos + targetPos) / 2, (targetPos - selfPos) * cfg.reviveShockImpulseForFighter)
          targetFighterController:LoseHp(cfg.reviveShockDamage)
          targetFighterController:NetStopRun()
          targetFighterController:NetDie()
        end
      end
      if type == typeof(CS.NetCube) and distance < cfg.reviveShockRangeForItem then
        local netCube = mainSyncItem
        netCube:HitCube((targetPos - selfPos) * cfg.reviveShockImpulseForItem, (selfPos + targetPos) / 2, fighterController.NetCharacter.NetId.userId)
      end
    end
  end
end

function DormFightFighterEntity:OnFighterHit(fighterController)
  self.dormFightCtrl.dormFightAudioCtrl:PlayFighterOnHitAudio(fighterController)
end

function DormFightFighterEntity:OnFighterAttack(fighterController)
  self.dormFightCtrl.dormFightAudioCtrl:PlayFighterAttackAudio(fighterController)
end

function DormFightFighterEntity:IsNotEquipWeapon()
  if not IsNull(self.weaponController) then
    local weaponState = self.weaponController.weaponState
    return weaponState == equipWeaponState.NoWeapon
  end
  return true
end

function DormFightFighterEntity:OnDestroyFighter()
  local fighterController = self.fighterController
  if IsNull(fighterController) then
    return
  end
  fighterController.OnStart = nil
  fighterController.OnRevive = nil
  fighterController.NetCharacter.roleEntity:RemoveEntityAttrChangeListener(1, self.__OnHit)
end

return DormFightFighterEntity
