local this = class("cellBattleBossHp", G_UIModuleBase)
local enumPetBreakLinkStatus = {
  disable = 0,
  init = 1,
  ready = 2
}
local listCountToLimit = {
  [1] = {stack = 7, buff = 7},
  [2] = {stack = 7, buff = 7},
  [3] = {stack = 4, buff = 4}
}
local fxShieldPath = "UI/UIEffect/BattleHp/FX.prefab"
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    moduleBuff = {
      moduleName = "pages/battle/moduleBattleBuff_Boss"
    },
    moduleBuffInfo = {
      moduleName = "pages/battle/moduleBattleBuffInfoBox"
    },
    txt_name = "",
    txt_nameFX = "",
    txt_level = "",
    go_break = false,
    txt_break = "",
    txt_break_bg = "",
    go_breakTxt = false,
    go_noBreak = false,
    go_rage = false,
    go_rageTxt = false,
    go_infoBox = false,
    anim_break_playAnimation = "anim_battle_HP_petlink_init",
    goCatch = false,
    elementList = {
      moduleName = "pages/battle/cellBattleElement"
    },
    list_bossHpPoint = {
      moduleName = "pages/Battle/cellBossHpPoint"
    },
    active_hpShield = false,
    active_FXhpShield = false,
    active_ShieldFX = false,
    slider_hpShield = 1
  }
end

function this.methods()
  return {
    moduleBuff = {
      onEnter = function(self, buffId, elementType, layer)
        self.bind.go_infoBox = true
        self.modules.moduleBuffInfo:initModuleInfo(buffId, layer, elementType)
      end,
      onLeave = function(self)
        self.bind.go_infoBox = false
      end
    }
  }
end

function this:open()
  self.isNotShowHp = false
  self.isShowShield = false
end

function this:show()
  self.noBreakFlag = nil
  self.isRage = nil
  self.rageCounter = 0
  self.bind.go_noBreak = false
  self.bind.go_rage = false
  if self.isNotShowHp then
    self.bindComponents.bossHpTypeAnim:Play("anim_battle_bossHp_switch2Shield")
  end
end

function this:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  self.noBreakFlag = false
  self.isRage = false
  self.rageCounter = 0
  self.breakLinkStatus = enumPetBreakLinkStatus.disable
  self.preBreakPosZero = C_Vector2(0, 0)
  self.preBreakAnchorV2 = C_Vector2(0, 0.5)
  self.catchAnchorV2 = C_Vector2(0, 0.5)
  self.lastEnemyEntityId = -1
  self.coverMask = self.bindComponents.coverMask.material
  self.coverMask_1 = self.bindComponents.coverMask_1.material
  self.updateHandle = handler(self, self.updateFunc)
  L_TimerManager:newOrResetTimer(self, "cellBattleBossHP", self.updateHandle, 0.1, -1)
  L_BattleDataManager:addListener(L_BattleDataManager.event.addShield, self.onEvent_addShield, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.refreshShield, self.onEvent_refreshShield, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.removeShield, self.onEvent_removeShield, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.bossHpIndexChange, self.onEvent_bossHpIndexChange, self)
end

function this:unBind()
  self.super.unBind(self)
  L_TimerManager:clearTimer(self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.addShield, self.onEvent_addShield)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.refreshShield, self.onEvent_refreshShield, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.removeShield, self.onEvent_removeShield)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.bossHpIndexChange, self.onEvent_bossHpIndexChange, self)
  if self.cacheFx then
    C_PrefabManager:RecycleByLoader(self.cacheFx)
  end
end

function this:onEvent_addShield(args)
  if self.enemyEntityId ~= args.entityId then
    return
  end
  if not self.isShowShield then
    self.isShowShield = true
    self.bindComponents.anim_shieldBar:Stop()
    self.bindComponents.anim_shieldBar:Play("anim_shield_bar_hurt_reset")
    self.bindComponents.anim_shieldTohp:Play("anim_boss_hp2shield")
    self.bind.active_ShieldFX = true
    self.bind.active_FXhpShield = true
    self:setFxVisible(true)
    self.bind.active_hpShield = true
    self:updateShield()
  end
end

function this:onEvent_refreshShield(args)
  if self.enemyEntityId ~= args.entityId then
    return
  end
  self:updateShield()
end

function this:onEvent_removeShield(args)
  if self.enemyEntityId ~= args.entityId then
    return
  end
  if self.isShowShield then
    self.bindComponents.anim_shieldTohp:Play("anim_boss_shield2hp")
    self.bind.active_ShieldFX = false
    self:setFxVisible(false)
    self.bind.active_hpShield = false
    self.bind.active_FXhpShield = false
    self.isShowShield = false
  end
end

function this:updateShield()
  local enemy = C_EntityManager.GetAliveEntity(self.enemyEntityId)
  if not enemy then
    return
  end
  local aliveProperty = enemy.data.aliveProperty
  local maxHp = C_MyFloatUtility.GetFloat(aliveProperty.maxHp)
  if aliveProperty.luaShieldOutputCount > 0 then
    self:updateShieldDisplay(aliveProperty.luaShieldOutputHp, maxHp)
  elseif 0 < aliveProperty.luaShieldHitCount then
    self:updateShieldDisplay(aliveProperty.luaShieldHitHp, maxHp)
  end
end

function this:onEvent_bossHpIndexChange(args)
  if self.enemyEntityId ~= args.entityId then
    return
  end
  local entity = C_EntityManager.GetAliveEntity(self.enemyEntityId)
  self:initHp(entity)
  self:refreshBossHpPointList(entity)
end

function this:initBoss(enemyId, listCount)
  self.listCount = listCount
  if self.lastEnemyEntityId ~= enemyId then
    if self.listCount == 1 then
      self.bindComponents.bossHpTypeAnim:Play("anim_battle_bossHp_show")
    else
      self.bindComponents.bossHpTypeAnim:Play("anim_battle_bossHp_show_simple")
    end
    self.lastEnemyEntityId = enemyId
  end
  self.enemyEntityId = enemyId
  local entity = C_EntityManager.GetAliveEntity(enemyId)
  self.configId = entity.data.config.id
  local tpl = _enemyTpl:getTplById(self.configId)
  local isShowWeak = _enemyTpl:getHpBarWeakness(tpl)
  self.bind.go_break = isShowWeak
  local monsterName = entity.data.configName
  if entity.data.SpecialParam and entity.data.SpecialParam > 0 and entity.data.catchProperty then
    local spName = entity.data.catchProperty.catchPet:GetPetNameSp(entity.data.SpecialParam - 1)
    if spName ~= nil then
      monsterName = spName.value
    end
  end
  self.bind.txt_name = monsterName
  self.bind.txt_nameFX = monsterName
  self.bind.txt_level = tostring(entity.data.level)
  local showStackCount = self.listCount >= 3 and 5 or 7
  self.modules.moduleBuff:initBuff(entity, listCountToLimit[listCount].stack, listCountToLimit[listCount].buff, false, showStackCount)
  self.modules.moduleBuff:SetHPType(self.listCount)
  self:initHp(entity)
  self:refreshBossHpPointList(entity)
  local pet = _petTpl:getTplById(_enemyTpl:getPetId(tpl))
  self.bind.goCatch = 0 < _enemyTpl:getPetId(tpl) and _petTpl:getIsCatch(pet) == true
  local element = _enemyTpl:getElement(tpl)
  local elementListData = {}
  for _, elementId in ipairs(element) do
    local element = {elementId = elementId}
    table.insert(elementListData, element)
  end
  self.bind.elementList:clear()
  self.bind.elementList:insert_array(elementListData)
end

function this:initHp(csEntity)
  local aliveProperty = csEntity.data.aliveProperty
  local hp = C_MyFloatUtility.GetFloat(aliveProperty.hp)
  local maxHp = C_MyFloatUtility.GetFloat(aliveProperty.maxHp)
  local hpInt = math.floor(hp)
  local maxHpInt = math.floor(maxHp)
  self.bind.txt_hp = table.concat({
    tostring(hpInt),
    "/",
    tostring(maxHpInt)
  })
  self.bindComponents.hpEffectShow:InitHp(hp / maxHp)
  self.bindComponents.hpEffectShow:SetCatchIconData(csEntity.data)
  self.bindComponents.hpEffectShow:SetHpData(hp)
end

function this:refreshBossHpPointList(csEntity)
  local aliveProperty = csEntity.data.aliveProperty
  local info = {}
  for i = 1, aliveProperty.hpCount do
    table.insert(info, {
      active_point = aliveProperty.hpIndex <= i - 1,
      active_curPoint = aliveProperty.hpIndex == i - 1
    })
  end
  self.bind.list_bossHpPoint:clear()
  self.bind.list_bossHpPoint:insert_array(info)
end

function this:updateFunc()
  if self.enemyEntityId == nil then
    return
  end
  self:refreshWeak()
  local enemy = C_EntityManager.GetAliveEntity(self.enemyEntityId)
  if not enemy then
    return
  end
  local myFloatUtility = C_MyFloatUtility
  local aliveProperty = enemy.data.aliveProperty
  local hp = myFloatUtility.GetFloat(aliveProperty.hp)
  local maxHp = myFloatUtility.GetFloat(aliveProperty.maxHp)
  local hpEffectShow = self.bindComponents.hpEffectShow
  hpEffectShow:SetHp(hp / maxHp)
  hpEffectShow:SetHpData(hp)
  local preBreakThreshold = myFloatUtility.GetFloat(aliveProperty.preBreakThreshold)
  local weaknessPointMax = myFloatUtility.GetFloat(aliveProperty.weaknessPointMax)
  local weaknessPoint = myFloatUtility.GetFloat(aliveProperty.weaknessPoint)
  if preBreakThreshold <= 0 or enemy.data.controlProperty.inWeakState then
    self:changeBreakLinkStatus(enumPetBreakLinkStatus.disable)
  elseif preBreakThreshold > weaknessPoint then
    self:changeBreakLinkStatus(enumPetBreakLinkStatus.ready)
  else
    local preBreakIcon = self.bindComponents.preBreakIcon
    self.preBreakAnchorV2.x = preBreakThreshold / weaknessPointMax
    preBreakIcon.anchorMin = self.preBreakAnchorV2
    preBreakIcon.anchorMax = self.preBreakAnchorV2
    preBreakIcon.anchoredPosition = self.preBreakPosZero
    self:changeBreakLinkStatus(enumPetBreakLinkStatus.init)
  end
  self.configId = enemy.data.config.id
  local tpl = _enemyTpl:getTplById(self.configId)
  local petId = _enemyTpl:getPetId(tpl)
  if petId == 0 then
    return
  end
  local pet = _petTpl:getTplById(petId)
  if pet == nil then
    return
  end
  local catchIcon = self.bindComponents.catchIcon
  self.catchAnchorV2.x = _petTpl:getCatchHP(pet) / 10000
  catchIcon.anchorMin = self.catchAnchorV2
  catchIcon.anchorMax = self.catchAnchorV2
  catchIcon.anchoredPosition = self.preBreakPosZero
end

function this:doRage(flag, intV, f)
  if self.isRage == flag then
    return
  end
  self.isRage = flag
  self.rageCounter = intV
  if flag then
    self.bindComponents.barFuryAnim:Play("anim_BossHP_furry_open")
    self.bindComponents.barFuryTxtAnim:Play("anim_BossHP_furryword_open")
    self:newOrResetTimer("playBarFuryAnim_open", function()
      self.bindComponents.barFuryAnim:Play("anim_BossHP_furry_loop")
      self.bindComponents.barFuryTxtAnim:Play("anim_BossHP_furryword_loop")
    end, 5.74)
    self:stopTimer("playBarFuryAnim_close")
    self:stopTimer("playBarFuryTxtAnim_close")
    self.bind.go_rage = self.isRage
    self.bind.go_rageTxt = self.isRage
  else
    self:stopTimer("playBarFuryAnim_open")
    self.bindComponents.barFuryAnim:Play("anim_BossHP_furry_close")
    self.bindComponents.barFuryTxtAnim:Play("anim_BossHP_furryword_close")
    self:newOrResetTimer("playBarFuryAnim_close", function()
      self.bind.go_rage = false
    end, 2.8)
    self:newOrResetTimer("playBarFuryTxtAnim_close", function()
      self.bind.go_rageTxt = false
    end, 2.73)
  end
end

function this:doNoBreak(flag, aliveProperty)
  if self.noBreakFlag == flag then
    if not flag then
      local timer = self:getTimer("hideBreakTxt")
      if not (timer and timer.obj) or timer.obj:IsNull() then
        self.bind.go_noBreak = false
      end
    end
    return
  end
  self.noBreakFlag = flag
  printf(tostring(flag) .. ":::::::::::开始Break::::::::::::::")
  if flag then
    self:refreshBreakTxt(aliveProperty)
    self.bind.go_noBreak = flag
    self.bind.go_breakTxt = flag
    self.bindComponents.emptyWeakAnim:Stop()
    self.bindComponents.emptyWeakAnim:Play("anim_battle_bossBreak_icon_show")
    self.bindComponents.breakAnim:Stop()
    self.bindComponents.breakAnim:Play("anim_damagemult_show")
  else
    self.bindComponents.emptyWeakAnim:Stop()
    self.bindComponents.emptyWeakAnim:Play("anim_battle_bossBreak_icon_hide")
    self.bindComponents.breakAnim:Stop()
    self.bindComponents.breakAnim:Play("anim_damagemult_hide")
    self:newOrResetTimer("hideBreakTxt", function()
      self.bind.go_breakTxt = false
    end, 0.2, 1)
  end
end

function this:refreshBreakTxt(aliveProperty)
  local percent = C_MyFloatUtility.GetFloat(aliveProperty.breakDmgUp) * 100 + 100
  local breakText = table.concat({
    "x",
    tostring(percent),
    "%"
  })
  self.bind.txt_break = breakText
  self.bind.txt_break_bg = breakText
end

function this:refreshWeak()
  local enemy = C_EntityManager.GetAliveEntity(self.enemyEntityId)
  if not enemy then
    return
  end
  local aliveProperty = enemy.data.aliveProperty
  local inWeak = enemy.data.controlProperty.inWeakState
  local weakPoint = C_MyFloatUtility.GetFloat(aliveProperty.weaknessPoint)
  local weaknessPointMax = C_MyFloatUtility.GetFloat(aliveProperty.weaknessPointMax)
  if self.weakPoint and weakPoint < self.weakPoint then
    self.bindComponents.breakEffectShow:SetHp(weakPoint / weaknessPointMax)
  elseif self.weakPoint ~= weakPoint then
    self.bindComponents.breakEffectShow:InitHp(weakPoint / weaknessPointMax)
  end
  self.weakPoint = weakPoint
  self.inWeak = inWeak
  self:doNoBreak(enemy.data.controlProperty.inWeakState, aliveProperty)
  self:doRage(enemy.data.controlProperty.isRage, enemy.data.controlProperty.rageCounter, enemy.data.controlProperty.inWeakState)
end

function this:updateShieldDisplay(shieldHp, maxHp)
  if shieldHp <= maxHp then
    if not self.anchor then
      self.anchor = C_Vector2(0.5, 0.5)
    end
    if not self.bind.active_FXhpShield then
      self.bindComponents.anim_shieldBar:Stop()
      self.bindComponents.anim_shieldBar:Play("anim_shield_bar_hurt_reset")
      self.bind.active_FXhpShield = true
      self.bind.active_hpShield = true
    end
    local currentHealth = shieldHp / maxHp
    currentHealth = currentHealth * 0.905 + 0.055
    self.coverMask:SetFloat("_Intensity", 1 - currentHealth)
    self.coverMask_1:SetFloat("_Intensity", 1 - currentHealth)
    currentHealth = math.clamp(currentHealth, 0.055, 0.96)
    if not Mathf.Approximately(self.bind.slider_hpShield, currentHealth) then
      self.bindComponents.anim_shieldBar:Stop()
      self.bindComponents.anim_shieldBar:Play("anim_shield_bar_hurt")
    end
    self.anchor.x = currentHealth
    self.bind.slider_hpShield = currentHealth
    self.bindComponents.rect_hpShield.anchorMax = self.anchor
    self.bindComponents.rect_hpShield.anchorMin = self.anchor
    self.bindComponents.rect_hpShield.anchoredPosition = C_Vector2(0, 0)
  else
    self.bind.active_FXhpShield = false
    self.bind.slider_hpShield = 1
    self.coverMask:SetFloat("_Intensity", 1)
    self.coverMask_1:SetFloat("_Intensity", 1)
  end
end

function this:changeBreakLinkStatus(status)
  if self.breakLinkStatus ~= status then
    if status == enumPetBreakLinkStatus.disable then
      self.bindComponents.preBreakNode.gameObject:SetActive(false)
    elseif status == enumPetBreakLinkStatus.init then
      self.bindComponents.preBreakNode.gameObject:SetActive(true)
      self.bind.anim_break_playAnimation = "anim_battle_HP_petlink_init"
    elseif status == enumPetBreakLinkStatus.ready then
      self.bindComponents.preBreakNode.gameObject:SetActive(true)
      if self.breakLinkStatus == enumPetBreakLinkStatus.disable then
        self.bind.anim_break_playAnimation = "anim_battle_HP_petlink_ready_change"
      else
        self.bind.anim_break_playAnimation = "anim_battle_HP_petlink_ready"
      end
    end
    self.breakLinkStatus = status
  end
end

function this:close()
  self.lastEnemyEntityId = -1
end

function this:setFxVisible(isVisible)
  if not self.cacheFx then
    self.cacheFx = C_UIMgr.uiLoader:Spawn(fxShieldPath, self.bindComponents.rectBg)
    L_Vector3.setAnchored(self.cacheFx.transform, {x = 0, y = 0})
    self.cacheFx.transform:SetAsFirstSibling()
    self.cacheFx.name = "FX"
  end
  self.cacheFx.gameObject:SetActive(isVisible)
end

return this
