local this = class("moduleBattleCombo", G_UIModuleBase)

function this.bind()
  return {
    goCombo = true,
    txt_combo = "",
    txt_combo_bg = "",
    txt_damage = "",
    txt_damage_bg = "",
    txt_showCombo = "",
    txt_showCombo_bg = "",
    txt_combo30 = "",
    txt_combo30_bg = "",
    txt_combo30_bg_2 = "",
    txt_comboMask30 = "",
    txt_comboMask30_bg = "",
    txt_comboMask = "",
    txt_comboMask_bg = "",
    txt_combo100 = "",
    txt_combo100_bg = "",
    fx1_obj = false
  }
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  L_BattleDataManager:addListener(L_BattleDataManager.event.refreshCombo, self.onEvent_refreshCombo, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.comboDisappear, self.onEvent_comboDisappear, self)
  self.bind.goCombo = false
  self.isHide = true
  self:initCombo()
end

function this:show()
  if self.isHide then
    self.bind.goCombo = false
    return
  end
  self.bindComponents.showAnim:Stop()
  self.bindComponents.showAnim:Play("anim_battle_combo_show")
end

function this:initCombo()
  local comboCount = AzurWorld.UIBattleDataMgr:GetComboCount()
  if comboCount <= 0 then
    return
  end
  local totalDamange = AzurWorld.UIBattleDataMgr:GetComboTotalDamange()
  self:onEvent_refreshCombo({comboCount = comboCount, totalDamange = totalDamange})
end

function this:close()
  L_BattleDataManager:removeListener(L_BattleDataManager.event.refreshCombo, self.onEvent_refreshCombo)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.comboDisappear, self.onEvent_comboDisappear)
end

function this:onEvent_refreshCombo(args)
  self.bind.goCombo = true
  if self.isHide then
    self.bindComponents.showAnim:Stop()
    self.bindComponents.showAnim:Play("anim_battle_combo_show")
    self.isHide = false
  end
  local combosStr = tostring(args.comboCount > 999 and "999+" or args.comboCount)
  self.bind.txt_showCombo = combosStr
  self.bind.txt_showCombo_bg = combosStr
  self.bind.txt_comboMask = combosStr
  self.bind.txt_comboMask_bg = combosStr
  self.bind.txt_combo100 = combosStr
  self.bind.txt_combo100_bg = combosStr
  self.bind.txt_combo = combosStr
  self.bind.txt_combo_bg = combosStr
  self.bind.txt_combo30 = combosStr
  self.bind.txt_combo30_bg = combosStr
  self.bind.txt_combo30_bg_2 = combosStr
  self.bind.txt_comboMask30 = combosStr
  self.bind.txt_comboMask30_bg = combosStr
  self.bindComponents.comboDmgEffect:SetNum(math.floor(args.totalDamange))
  if self.oldCombo == args.comboCount then
    return
  end
  self.bindComponents.numAnim:Stop()
  self.oldCombo = args.comboCount
  self.bindComponents.par_glow:Simulate(0)
  self.bindComponents.par_glow:Play()
  if args.comboCount < 30 then
    self.bind.fx1_obj = false
    self.bindComponents.numAnim:Play("anim_battle_combo_numjump_less30")
  elseif args.comboCount < 100 then
    self.bind.fx1_obj = false
    self.bindComponents.numAnim:Play("anim_battle_combo_numjump_less100")
  else
    self.bind.fx1_obj = true
    self.bindComponents.numAnim:Play("anim_battle_combo_numjump")
  end
end

function this:onEvent_comboDisappear()
  self.oldCombo = nil
  self.isHide = true
  self.bindComponents.showAnim:Play("anim_battle_combo_stopAndHide")
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
