local this = class("moduleBattleAttackBtn", G_UIModuleBase)
local constAttackBtnStatus = {init = 1, boostDo = 2}

function this.bind()
  return {}
end

function this.methods()
  return {
    onDown_attack = function(self)
      L_PlayerManager:fireAttackDown()
      C_WorldEvent.instance:Dispatch(C_EWorldEvent.ETriggerMobileShowSkill)
    end,
    onUp_attack = function(self)
      L_PlayerManager:fireAttackUp()
    end
  }
end

function this:open(...)
  this.super.open(self, ...)
  self.data = {
    attackBtnState = constAttackBtnStatus.init
  }
  L_BattleDataManager:addListener(L_BattleDataManager.event.refreshAttackStatus, self.onEvent_refreshAttackStatus, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.onCastSkill, self.onEvent_onCastSkill, self)
  L_PlayerManager:addListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
end

function this:onPlayerOutMount()
  self.bind.goContent = true
  self:resetEffect()
end

function this:show()
  self:resetEffect()
end

function this:resetEffect()
  self.data.attackBtnState = constAttackBtnStatus.init
end

function this:close(...)
  this.super.close(self, ...)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.refreshAttackStatus, self.onEvent_refreshAttackStatus, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.onCastSkill, self.onEvent_onCastSkill, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
end

function this:onEvent_onCastSkill(args)
  local skillId = args.intArg
  local mainHero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if mainHero == nil then
    return
  end
  local skill = mainHero.data.skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.EvadeBoostAttack)
  if skill and skill.id == skillId then
    self.playAnim(self.bindComponents.attackAnim, "anim_battle_attack_fightback_cost")
    self.data.attackBtnState = constAttackBtnStatus.boostDo
  end
end

function this:onEvent_refreshAttackStatus(args)
  if args.intArg == L_Const.C_ESkillSlotType.EvadeBoostAttack then
    self.playAnim(self.bindComponents.attackAnim, "anim_battle_attack_fightback_ready")
  elseif self.data.attackBtnState == constAttackBtnStatus.init then
    self.playAnim(self.bindComponents.attackAnim, "anim_battle_attack_fightback_fade")
  else
    self.data.attackBtnState = constAttackBtnStatus.init
  end
end

function this:playAnim(anim, animName)
  if not anim.gameObject or not anim.gameObject.activeSelf then
    return
  end
  anim:Play(animName, 1)
end

return this
