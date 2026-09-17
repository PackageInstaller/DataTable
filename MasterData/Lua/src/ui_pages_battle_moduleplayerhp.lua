local this = class("modulePlayerHp", G_UIModuleBase)

function this.bind()
  return {
    txt_hp = "",
    moduleBuff = {
      moduleName = "pages/battle/moduleBattleBuff"
    },
    elementList = {
      moduleName = "pages/battle/cellBattleElement"
    },
    active_hpShield = false,
    active_FXhpShield = false,
    img_hpShield = 0
  }
end

function this.methods()
  return {}
end

function this:open()
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "modulePlayerHp.update")
  self.data = {hpState = nil}
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.initHpAndBuff, self)
  self:initHpAndBuff()
end

function this:close()
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.initHpAndBuff, self)
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
end

function this:update()
  self:refreshHP()
end

function this:initHpAndBuff()
  local mainControl = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if not mainControl then
    return
  end
  self.modules.moduleBuff:initBuff(mainControl, 9, 9, true)
  local aliveProperty = mainControl.data.aliveProperty
  local hp = aliveProperty.luaHp
  local maxHp = aliveProperty.luaMaxHp
  self.bind.txt_hp = hp .. "/" .. maxHp
  self.bindComponents.hpEffectShow:InitHp(hp / maxHp)
  self:refreshHpBarDangerEffect(hp, maxHp)
end

function this:refreshHP()
  local mainControl = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if not mainControl then
    return
  end
  local aliveProperty = mainControl.data.aliveProperty
  local hp = aliveProperty.luaHp
  local maxHp = aliveProperty.luaMaxHp
  if aliveProperty.luaShieldOutputCount > 0 then
    self:updateShieldDisplay(aliveProperty.luaShieldOutputHp, maxHp)
  elseif 0 < aliveProperty.luaShieldHitCount then
    self:updateShieldDisplay(aliveProperty.luaShieldHitHp, maxHp)
  elseif self.bind.active_hpShield then
    self.bind.active_hpShield = false
    self.bind.img_hpShield = 1
  end
  if self.curHp == hp and self.maxHp == maxHp then
    return
  end
  self.curHp = hp
  self.maxHp = maxHp
  self:refreshHpBarDangerEffect(hp, maxHp)
  self.bind.txt_hp = hp .. "/" .. maxHp
  self.bindComponents.hpEffectShow:SetHp(hp / maxHp)
end

function this:updateShieldDisplay(shieldHp, maxHp)
  if shieldHp <= maxHp then
    if not self.anchor then
      self.anchor = C_Vector2(0.5, 0.5)
    end
    self.bind.active_FXhpShield = true
    self.bind.active_hpShield = true
    local currentHealth = shieldHp / maxHp
    self.anchor.x = currentHealth
    self.bind.img_hpShield = currentHealth
    self.bindComponents.rect_hpShield.anchorMax = self.anchor
    self.bindComponents.rect_hpShield.anchorMin = self.anchor
    self.bindComponents.rect_hpShield.anchoredPosition = C_Vector2(0, 0)
  else
    self.bind.active_FXhpShield = false
    self.bind.img_hpShield = 1
  end
end

function this:refreshHpBarDangerEffect(hp, maxHp)
  local hpState = self:getHPState(hp, maxHp)
  if self.data.hpState ~= hpState then
    self.data.hpState = hpState
    if hpState == 0 then
      self.bindComponents.dangerAnim:Play("anim_battle_playerHp_danger")
    else
      self.bindComponents.dangerAnim:Play("anim_battle_playerHp_reset")
    end
  elseif hp == 0 then
    self.bindComponents.dangerAnim:Play("anim_battle_playerHp_reset")
  end
end

function this:getHPState(hp, maxHp)
  if hp >= maxHp * 0.8 then
    return 2
  elseif hp > maxHp * 0.2 then
    return 1
  else
    return 0
  end
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
