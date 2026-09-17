local this = class("cellHeroAvator", G_UIModuleBase)
local PetRedColor = C_Color(0.94, 0.37, 0.3)
local PetGreenColor = C_Color(0.16, 0.94, 0.71)
local DeadHeroColor = C_Color(0.5, 0.5, 0.5)
local _WorldBuffTpl = L_GameTpl:getWorldBuffTpl()
local _skillSubLogicTpl = L_GameTpl:getSkillsubLogicTpl()

function this.bind()
  return {
    imgPlayer = nil,
    color_hero = C_Color.white,
    dead = false,
    fill_hp = 0,
    fill_sp = 0,
    imgPet = nil,
    color_petIcon = C_Color.white,
    fill_petHp = 0,
    color_petHp = PetRedColor,
    active_pet = false,
    active_img_bg = true,
    goPerReborn = false,
    active_img_hp_red = true,
    active_petCharge = false,
    active_petCharge_left = false,
    fillAmount_petCharge_left = 0,
    fillAmount_petCharge_left_1 = 0,
    imgAlpha_petCharge_left_1 = C_Color(1, 1, 1, 1),
    active_petCharge_right = false,
    fillAmount_petCharge_right = 0,
    fillAmount_petCharge_right_1 = 0,
    imgAlpha_petCharge_right_1 = C_Color(1, 1, 1, 1),
    indexAlpha = 1,
    joinSkillCD = 0,
    moduleHeroHeadEffect = {
      moduleName = "pages/battle/moduleCellHeroHeadEffect"
    },
    moduleBuff = {
      moduleName = "pages/battle/moduleBattleBuff"
    },
    ani_spMax = "",
    active_spMax = false,
    activt_recover = false,
    list_worldBuff = {
      moduleName = "pages/worldBuff/cellWorldBuffIcon"
    },
    go_trialHero = false,
    go_trialPet = false,
    go_heroLevelUp = false,
    txt_heroLevel = nil,
    go_heroFavorLevelUp = false,
    txt_heroFavorLevel = nil,
    go_petLevelUp = false,
    txt_petLevel = nil,
    go_petFavorLevelUp = false,
    txt_petFavorLevel = nil,
    alpha_bgHp = 1,
    pos_bgHp = C_Vector3(-80.557, -32, 0),
    alpha_bgSp = 1,
    pos_bgSp = C_Vector3(-57.057, -41, 0),
    alpha_nodeBuff = 1,
    pos_nodeBuff = C_Vector3(-51.5, -8.3, 0),
    alpha_imgHpRed = 1,
    alpha_imgPetDead = 1,
    alpha_petChargeRoot = 1,
    active_hpShield = false,
    img_hpShield = 0,
    active_FXhpShield = false,
    pre_SwitchHero_CD_down = false,
    pre_SwitchHero_CD_loop = false,
    pre_SwitchHero_CD_up = false,
    active_annoy = false,
    txt_partShortKey = "",
    img_partShortKey = ""
  }
end

function this.methods()
  return {
    onClick_head = function(self)
      self:emit("onClick", self.bind)
    end
  }
end

function this:open()
  L_BattleDataManager:addListener(L_BattleDataManager.event.onCastSwitchSkill, self.onEvent_onCastSkill, self)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.onEvent_setMainControl, self)
  L_StarHealingStore:listenCallFunc(L_StarHealingStore.event.playStarHealingEffect, self.playStarHealingEffect, self)
  L_BuffStore:listenCallFunc(L_BuffStore.event.buffRefresh, self.refreshWorldBuff, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.petResponseSpChange, self.onEvent_petResponseSpChange, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self, nil, 0)
  self:update()
  L_TimerManager:newOrResetTimer(self, "cellUpdate", handler(self, self.update), 0.1, -1)
  self.partKey = L_ShortCutManager:generateAndCheckShortKey(self.bindComponents.rTransKeyNode)
  self:playSelectAnim()
  self.petChargeRightSkillId = -1
  self.petChargeLeftSkillId = -1
  self.lastLeftProgress = 0
  self.lastRightProgress = 0
end

function this:hide()
  self.bind.activt_recover = false
  self.bindComponents.recoveryAnimation:Stop()
end

function this:close()
  L_BattleDataManager:removeListener(L_BattleDataManager.event.onCastSwitchSkill, self.onEvent_onCastSkill, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.onEvent_setMainControl, self)
  L_StarHealingStore:unListenCallFunc(L_StarHealingStore.event.playStarHealingEffect, self.playStarHealingEffect, self)
  L_BuffStore:unListenCallFunc(L_BuffStore.event.buffRefresh, self.refreshWorldBuff, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.petResponseSpChange, self.onEvent_petResponseSpChange, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet)
  L_TimerManager:clearTimer(self)
  if self.partKey then
    L_ShortCutManager:destroyShortKey(self.partKey)
    self.partKey = nil
  end
  if self.photoEntity then
    self.photoEntity:dispose()
    self.photoEntity = nil
  end
end

function this:playStarHealingEffect(heroId)
  if heroId == self.bind.heroId then
    self.bindComponents.recoveryAnimation:Play("anim_battle_hero_recovery")
  end
end

function this:playSelectAnim()
  if self.isBind ~= true then
    return
  end
  local id = self.bind.heroId
  local formationType = L_FormationManager:getCurFormationType()
  local controlId = L_FormationStore:getControl(formationType)
  self.modules.moduleHeroHeadEffect:setChoiceEffect(controlId == id, true)
  local mainHero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  local heroId = mainHero == nil and self.bind.heroId or mainHero.data.UUID
  self.bind.indexAlpha = heroId == self.bind.heroId and 0.5 or 1
  self.oldMainId = controlId
end

function this:onEvent_onCastSkill(args)
  local heroid = args.castConfigId
  local hero = L_HeroStore:getHero(self.bind.heroId)
  local selfheroId = L_HeroStore:getHeroConfigId(hero)
  local slot = args.type
  if heroid ~= selfheroId then
    return
  end
  local csHeroEntity = AzurWorld.playerMgr.myPlayerData:GetHeroEntity(self.bind.index - 1)
  if slot == L_Const.C_ESkillSlotType.EnterSkill then
    self.joinOrExitSkill = csHeroEntity.data.skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.EnterSkill)
    self:refreshSkillCd()
  else
    self.joinOrExitSkill = csHeroEntity.data.skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.ExitSkill)
    self:refreshSkillCd()
  end
end

function this:refreshSkillCd()
  self.bind.showJoinSkillCd = true
  self.bind.joinSkillCD = 0
  local coolDown = C_MyFloatUtility.GetFloat(self.joinOrExitSkill.coolDown.coolDown)
  
  local function getter()
    return self.bind.joinSkillCD
  end
  
  local function setter(r)
    self.bind.joinSkillCD = r
  end
  
  self.CdTween = DOTween.To(getter, setter, 1, coolDown):OnComplete(function()
    self.CdTween:Kill()
    self.bind.showJoinSkillCd = false
    self.CdTween = nil
  end)
end

function this:onEvent_setMainControl()
  if math.isEmpty(self.bind.heroId) or self.isBind ~= true then
    return
  end
  local mainHero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  local heroId = mainHero == nil and self.bind.heroId or mainHero.data.UUID
  if L_BattleDataManager:getIsInBattle() and L_BattleDataManager:getIsInCD() then
    if heroId == self.bind.heroId then
      self.modules.moduleHeroHeadEffect:setChoiceEffect(true)
    else
      if self.oldMainId == self.bind.heroId then
        self.modules.moduleHeroHeadEffect:setChoiceEffect(false)
      end
      self.modules.moduleHeroHeadEffect:doChangeCdAnim(true)
    end
  elseif heroId == self.bind.heroId then
    self.modules.moduleHeroHeadEffect:setChoiceEffect(true)
  elseif self.oldMainId == self.bind.heroId then
    self.modules.moduleHeroHeadEffect:setChoiceEffect(false)
  end
  self.bind.indexAlpha = heroId == self.bind.heroId and 0.5 or 1
  self.oldMainId = heroId
  self:refreshWorldBuff()
end

function this:refresh()
  self.modules.moduleHeroHeadEffect:initHeroId(self.bind.heroId)
  if math.isEmpty(self.bind.heroId) then
    return
  end
  local heroEntity = L_PlayerManager:getAllHeroCsEntity()[self.bind.heroId]
  if heroEntity ~= nil then
    self.modules.moduleBuff:initBuff(heroEntity, 5, 5, true)
  end
  local hero = L_HeroStore:getHero(self.bind.heroId)
  self.bind.imgPlayer = L_GameUtil.getAvatarTexturePath(L_HeroStore:getHeroConfigId(hero), L_Const.resourceIndexOfAvatarTextureInHeroTpl.mid)
  if not L_BattleStore:getIsInBattle() then
    local heroBattleInfo = L_BattleStore:getObjBattleInfo(self.bind.heroId) or {}
    local hp = heroBattleInfo.hp or 0
    local sp = heroBattleInfo.sp or 0
    local hpMax = L_AttributeManager:getAttValueByHeroGuid(self.bind.heroId, L_Const.battleAtt.MAXHP)
    local isDead = hp <= 0
    self.bind.fill_hp = hp / hpMax
    self.bind.fill_sp = isDead and 0 or 0.05 + 0.95 * sp / 100
    self:checkSpEffect()
    self.bind.dead = isDead
    self.modules.moduleHeroHeadEffect:refreshDead()
    self.bind.color_hero = isDead and DeadHeroColor or C_Color.white
  end
  if self.partKey then
    local index = L_FormationStore:getHeroPlaceInTeam(L_FormationManager:getCurFormationType(), nil, self.bind.heroId)
    local key = string.format("switchingRole%d", index)
    self.partKey:refreshKey(L_Const.settingType[key])
  end
  if self.bind.heroId == L_HeroStore:getDefaultHeroGuid() then
    local modName = L_PlayerStore:getAvatarTexturePath(L_Const.avatarTextureIndex.head_talk)
    if not string.isEmpty(modName) then
      if self.photoEntity == nil then
        self.photoEntity = L_PhotoManager:bindPhotoEntity(self.bindComponents.imgItem.gameObject, modName)
      else
        self.photoEntity:bindGameObject(self.bindComponents.imgItem.gameObject)
        self.photoEntity:setImgName(modName)
      end
    end
  elseif self.photoEntity then
    self.photoEntity:dispose()
    self.photoEntity = nil
  end
  self.bind.active_pet = not math.isEmpty(self.bind.petGuid)
  if not math.isEmpty(self.bind.petGuid) then
    local petItem = L_PetStore:getPetItem(self.bind.petGuid)
    if petItem then
      local tpl = L_GameTpl:getPetTpl():getTplById(petItem.id)
      local icon = L_GameTpl:getPetTpl():getPetIcon(tpl, petItem:isSpecialPet())
      self.bind.imgPet = icon
      self.bind.fill_petHp = 1
    end
  end
  self:refreshWorldBuff()
  self.hasRefreshPetChargeSkillInfo = false
  self.petChargeRightSkillId = -1
  self.petChargeLeftSkillId = -1
  self.bind.go_trialHero = L_HeroStore:getIsTrail(hero)
  self.bind.go_trialPet = not math.isEmpty(self.bind.petGuid) and L_PetStore:getPetItem(self.bind.petGuid):getIsTrial()
end

function this:doDead()
  if not self.bind.dead then
    self.bind.fill_sp = 0
    self:checkSpEffect()
    self.bind.fill_hp = 0
    self.bind.dead = true
    self.modules.moduleHeroHeadEffect:refreshDead()
    self.bind.color_hero = DeadHeroColor
  end
end

function this:update()
  if math.isEmpty(self.bind.heroId) then
    return
  end
  local hero = L_PlayerManager:getAllHeroCsEntity()[self.bind.heroId]
  if not hero then
    if L_BattleStore:getIsInBattle() then
      self:doDead()
    end
    return
  end
  local csEntity = hero
  if not csEntity then
    self:doDead()
    return
  end
  local aliveProperty = csEntity.data.aliveProperty
  local hp = aliveProperty.luaHp
  if hp <= 0 then
    self:doDead()
    self.bind.active_hpShield = false
    return
  end
  self.modules.moduleHeroHeadEffect:refreshDead()
  if self.bind.dead then
    self.bind.color_hero = C_Color.white
    self.bind.dead = false
  end
  local fill_hp = hp / aliveProperty.luaMaxHp
  if math.abs(fill_hp - self.bind.fill_hp) > 0.001 then
    self.bind.fill_hp = fill_hp
  end
  local fill_sp = 0
  if 0 < self.bind.fill_hp then
    fill_sp = 0.05 + 0.95 * aliveProperty.luaSp / aliveProperty.luaMaxSp
  end
  if 0.001 < math.abs(fill_sp - self.bind.fill_sp) then
    self.bind.fill_sp = fill_sp
  end
  if 0 < aliveProperty.luaShieldOutputCount then
    self:updateShieldDisplay(aliveProperty.luaShieldOutputHp, aliveProperty.luaMaxHp)
  elseif 0 < aliveProperty.luaShieldHitCount then
    self:updateShieldDisplay(aliveProperty.luaShieldHitHp, aliveProperty.luaMaxHp)
  elseif self.bind.active_hpShield then
    self.bind.active_hpShield = false
    self.bind.img_hpShield = 1
  end
  self:checkSpEffect()
  local petCsEntity = AzurWorld.playerMgr.myPlayerData:GetPetEntity(self.bind.index - 1)
  if petCsEntity then
    local petData = petCsEntity.data
    local aliveProperty = petData.aliveProperty
    self.petEntityId = petData.entityId
    local fill_petHp = aliveProperty.luaHp / aliveProperty.luaMaxHp
    if 0.001 < math.abs(self.bind.fill_petHp - fill_petHp) then
      self.bind.fill_petHp = fill_petHp
    end
    local petAlive = petData.aliveState == C_EEntityAliveState.Reborn
    if self.petAlive ~= petAlive then
      self.petAlive = petAlive
      if self.petAlive then
        self.bind.goPerReborn = true
        self.bind.color_petIcon = DeadHeroColor
        self.bind.color_petHp = PetGreenColor
      else
        self.bind.goPerReborn = false
        self.bind.color_petIcon = C_Color.white
        self.bind.color_petHp = PetRedColor
      end
    end
    if not self.hasRefreshPetChargeSkillInfo then
      self:refreshPetChargeSkillInfo(petData)
      self:refreshPetSkillCharge(self.bind.petGuid, petData)
      self.hasRefreshPetChargeSkillInfo = true
    end
  else
    if self.bind.active_petCharge then
      self.bind.active_petCharge = false
    end
    self.petEntityId = -1
  end
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

function this:refreshPetSkillCharge(petGuid, petData)
  if math.isEmpty(petGuid) then
    if self.bind.active_petCharge then
      self.bind.active_petCharge = false
    end
    return
  end
  if not self.hasRefreshPetChargeSkillInfo then
    self:refreshPetChargeSkillInfo(petData)
    self.hasRefreshPetChargeSkillInfo = true
  end
  if (not self.petChargeLeftSkillId or self.petChargeLeftSkillId < 0) and (not self.petChargeRightSkillId or 0 > self.petChargeRightSkillId) then
    if self.bind.active_petCharge then
      self.bind.active_petCharge = false
    end
    return
  end
  if not self.bind.active_petCharge then
    self.bind.active_petCharge = true
  end
  local bShowLeft = self.petChargeLeftSkillId and self.petChargeLeftSkillId >= 0
  if self.bind.active_petCharge_left ~= bShowLeft then
    self.bind.active_petCharge_left = bShowLeft
  end
  if bShowLeft then
    local skill = petData.skillProperty:GetSkill(self.petChargeLeftSkillId)
    local progress = skill.petResponseSp / self.petChargeLeftSkillSpMax
    self.bind.fillAmount_petCharge_left = progress
    self.bind.fillAmount_petCharge_left_1 = progress
    self.bind.imgAlpha_petCharge_left_1 = C_Color(1, 1, 1, progress)
    if 1 <= progress then
      self._playPetChargeAni = true
      if 1 > self.lastLeftProgress then
        self.bindComponents.anim_chargeLeft:Stop()
        self.bindComponents.anim_chargeLeft:Play("anim_player_charge_full")
      end
      L_TimerManager:newOrResetTimer(self, "leftChargeTimer", function()
        self._playPetChargeAni = false
        self:onEvent_petResponseSpChange({
          intArg = self.petChargeLeftSkillId
        })
      end, 0.2)
    else
      self._playPetChargeAni = false
      L_TimerManager:stopTimer(self, "leftChargeTimer")
    end
    self.lastLeftProgress = progress
  end
  local bShowRight = self.petChargeRightSkillId and 0 <= self.petChargeRightSkillId
  if self.bind.active_petCharge_right ~= bShowRight then
    self.bind.active_petCharge_right = bShowRight
  end
  if bShowRight then
    local skill = petData.skillProperty:GetSkill(self.petChargeRightSkillId)
    local progress = skill.petResponseSp / self.petChargeRightSkillSpMax
    self.bind.fillAmount_petCharge_right = progress
    self.bind.fillAmount_petCharge_right_1 = progress
    self.bind.imgAlpha_petCharge_right_1 = C_Color(1, 1, 1, progress)
    if 1 <= progress then
      self._playPetChargeAni = true
      if 1 > self.lastRightProgress then
        self.bindComponents.anim_chargeRight:Stop()
        self.bindComponents.anim_chargeRight:Play("anim_player_charge_full")
      end
      L_TimerManager:newOrResetTimer(self, "rightChargeTimer", function()
        self._playPetChargeAni = false
        self:onEvent_petResponseSpChange({
          intArg = self.petChargeRightSkillId
        })
      end, 0.2)
    else
      self._playPetChargeAni = false
      L_TimerManager:stopTimer(self, "rightChargeTimer")
    end
    self.lastRightProgress = progress
  end
end

function this:onEvent_petResponseSpChange(args)
  if args.castEntityId ~= self.petEntityId then
    return
  end
  if args.skillId ~= self.petChargeLeftSkillId and args.skillId ~= self.petChargeRightSkillId then
    return
  end
  if math.isEmpty(self.bind.heroId) then
    return
  end
  local petCsEntity = AzurWorld.playerMgr.myPlayerData:GetPetEntity(self.bind.index - 1)
  if not petCsEntity then
    return
  end
  local petData = petCsEntity.data
  self:refreshPetSkillCharge(self.bind.petGuid, petData)
end

function this:refreshPetChargeSkillInfo(petData)
  local skillProperty = petData.skillProperty
  local skillList = skillProperty.skills
  for i = 0, skillList.Count - 1 do
    local skill = skillList[i]
    local tpl = _skillSubLogicTpl:getTplById(skill.id)
    local skillLogicTag = _skillSubLogicTpl:getPetSkillLogicTag(tpl)
    if skillLogicTag then
      for _, v in ipairs(skillLogicTag) do
        if v[1] == 150 then
          if self.petChargeRightSkillId and 0 < self.petChargeRightSkillId and self.petChargeRightSkillId ~= skill.id then
            self.petChargeLeftSkillId = skill.id
            self.petChargeLeftSkillSpMax = v[2]
          else
            self.petChargeRightSkillId = skill.id
            self.petChargeRightSkillSpMax = v[2]
          end
        end
      end
    end
  end
end

function this:checkSpEffect()
  local isMax = self.bind.fill_sp >= 1
  if self._lastMax ~= isMax then
    self._lastMax = isMax
  else
    return
  end
  self.bind.active_spMax = isMax
  if isMax and not self._firstSpEffect then
    self._firstSpEffect = true
    self.bind.ani_spMax = "anim_hero_ultimate_init"
  else
    self.bind.ani_spMax = L_BattleStore:getIsInBattle() and "anim_hero_ultimate_in" or "anim_hero_ultimate_init"
  end
end

function this:isDead()
  return self.bind.dead
end

function this:refreshWorldBuff()
  self.bind.list_worldBuff:clear()
  if L_BattleStore:getIsInBattle() then
    return
  end
  if self:isDead() then
    return
  end
  local buffs = L_BuffStore:getBuffDatas()
  local datas = {}
  for _, buff in pairs(buffs) do
    local tpl = _WorldBuffTpl:getTplById(buff.buff_id)
    local icon = _WorldBuffTpl:getBuffIcon(tpl)
    if not string.isEmpty(icon) then
      table.insert(datas, {
        id = buff.buff_id
      })
    end
  end
  self.bind.list_worldBuff:insert_array(datas)
end

function this:resetAnimNodeShow(isPet)
  if isPet then
    self.bind.alpha_imgHpRed = 1
    self.bind.alpha_imgPetDead = 1
    self.bind.alpha_petChargeRoot = 1
    return
  end
  self.bind.alpha_bgHp = 1
  self.bind.pos_bgHp = C_Vector3(-80.557, -32, 0)
  self.bind.alpha_bgSp = 1
  self.bind.pos_bgSp = C_Vector3(-57.057, -41, 0)
  self.bind.alpha_nodeBuff = 1
  self.bind.pos_nodeBuff = C_Vector3(-51.5, -8.3, 0)
end

function this:playHeroLevelUpFX()
  self.bind.go_heroLevelUp = false
  self.bind.go_heroFavorLevelUp = false
  if not self.isBind then
    return
  end
  local heroLevelSettleData = L_BattleDataManager:getHeroLevelSettleData(self.bind.heroId)
  local needHeroLevel = heroLevelSettleData.levelUp
  local needHeroFavor = heroLevelSettleData.favorLevelUp
  if needHeroLevel then
    self.bind.go_heroLevelUp = true
    local level = L_HeroStore:getHeroLevel(L_HeroStore:getHero(self.bind.heroId))
    self.bind.txt_heroLevel = string.format("LV. %s", level)
    L_TimerManager:newOrResetTimer(self, "heroLevelUpVFX_show", function()
      L_AudioUtil.playSound("Play_SFX_System_Summary_CHAR_LevelUp")
      L_TimerManager:newOrResetTimer(self, "heroLevelUpVFX_hide", function()
        self.bind.go_heroLevelUp = false
        self:resetAnimNodeShow()
      end, 1)
    end, 2)
  end
  if needHeroFavor then
    local delayTime = self.bind.go_heroLevelUp and 3 or 0
    L_TimerManager:newOrResetTimer(self, "heroFavorLevelUpVFX_delay", function()
      self.bind.go_heroFavorLevelUp = true
      L_AudioUtil.playSound("Play_SFX_System_Summary_CHAR_LikelUp")
      local level = L_HeroStore:getHeroFavorAbilityLevel(L_HeroStore:getHero(self.bind.heroId))
      self.bind.txt_heroFavorLevel = string.format("LV.%s", level)
      L_TimerManager:newOrResetTimer(self, "heroFavorLevelUpVFX_show", function()
        L_TimerManager:newOrResetTimer(self, "heroFavorLevelUpVFX_hide", function()
          self.bind.go_heroFavorLevelUp = false
          self:resetAnimNodeShow()
        end, 1)
      end, 1)
    end, delayTime)
  end
  L_BattleDataManager:clearLevelSettleDataByGuid(L_Const.roleType.hero, self.bind.heroId)
end

function this:playPetLevelUpFX()
  self.bind.go_petLevelUp = false
  self.bind.go_petFavorLevelUp = false
  if not self.isBind then
    return
  end
  local petLevelSettleData = L_BattleDataManager:getPetLevelSettleData(self.bind.petGuid)
  local needPetLevel = petLevelSettleData.levelUp
  local needPetFavor = petLevelSettleData.favorLevelUp
  if needPetLevel then
    self.bind.go_petLevelUp = true
    local level = L_PetStore:getPetItem(self.bind.petGuid).lv
    self.bind.txt_petLevel = string.format("LV.%s", level)
    L_TimerManager:newOrResetTimer(self, "petLevelUpVFX_show", function()
      L_AudioUtil.playSound("Play_SFX_System_Summary_Qibo_LevelUp")
      L_TimerManager:newOrResetTimer(self, "petLevelUpVFX_hide", function()
        self.bind.go_petLevelUp = false
        self:resetAnimNodeShow(true)
      end, 1)
    end, 2)
  end
  if needPetFavor then
    local delayTime = self.bind.go_petLevelUp and 3 or 0
    L_TimerManager:newOrResetTimer(self, "petFavorLevelUpVFX_delay", function()
      local delayTime2 = self._playPetChargeAni and 1 or 0
      L_TimerManager:newOrResetTimer(self, "petFavorLevelUpVFX_delay2", function()
        self.bind.go_petFavorLevelUp = true
        self.bind.active_img_bg = false
        self.bind.active_img_hp_red = false
        L_AudioUtil.playSound("Play_SFX_System_Summary_Qibo_LikeUp")
        local level = L_PetStore:getPetItem(self.bind.petGuid).favor_lv
        self.bind.txt_petFavorLevel = string.format("LV.%s", level)
        L_TimerManager:newOrResetTimer(self, "petFavorLevelUpVFX_show", function()
          L_TimerManager:newOrResetTimer(self, "petFavorLevelUpVFX_hide", function()
            self.bind.go_petFavorLevelUp = false
            self.bind.active_img_bg = true
            self.bind.active_img_hp_red = true
            self:resetAnimNodeShow(true)
          end, 1)
        end, 1)
      end, delayTime2)
    end, delayTime)
  end
  L_BattleDataManager:clearLevelSettleDataByGuid(L_Const.roleType.pet, self.bind.petGuid)
end

function this:onEvent_refreshPet(pet)
  if self.bind.petGuid == pet.guid then
    self:refresh()
  end
end

return this
