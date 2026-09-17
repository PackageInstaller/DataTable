local this = class("cellBattleHero", G_UIModuleBase)
local PetRedColor = C_Color(0.94, 0.37, 0.3)
local PetGreenColor = C_Color(0.16, 0.94, 0.71)
local DeadHeroColor = C_Color(0.5, 0.5, 0.5)

function this.bind()
  return {
    imgPlayer = nil,
    color_hero = C_Color.white,
    sliderHp = 0,
    sliderSp = 0,
    goDead = false,
    goPet = false,
    slider_petHp = 0,
    img_pet = "",
    color_petIcon = C_Color.white,
    color_petColor = PetRedColor,
    goPerReborn = false,
    moduleHeroHeadEffect = {
      moduleName = "pages/battle/moduleCellHeroHeadEffect"
    },
    moduleBuff = {
      moduleName = "pages/battle/moduleBattleBuff"
    },
    ani_spMax = "",
    active_spMax = false,
    joinSkillCD = 0,
    showJoinSkillCd = false
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
  self.timer = Timer.repeated(0.1, self.update, self)
  self.bind.goDead = false
  self.modules.moduleHeroHeadEffect:initChoice()
  self:refresh()
  self:playSelectAnim()
  L_BattleDataManager:addListener(L_BattleDataManager.event.onCastSwitchSkill, self.onEvent_onCastSkill, self)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.onEvent_setMainControl, self)
end

function this:close()
  L_BattleDataManager:removeListener(L_BattleDataManager.event.onCastSwitchSkill, self.onEvent_onCastSkill, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.onEvent_setMainControl, self)
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  if self.CdTween ~= nil then
    self.CdTween:Kill()
    self.CdTween = nil
  end
  self.oldMainId = nil
end

function this:playSelectAnim()
  local id = self.bind.heroId
  local controlId = L_BattleTeamStore:getControlId()
  self.modules.moduleHeroHeadEffect:setChoiceEffect(controlId == id, true)
  self.oldMainId = controlId
end

function this:onEvent_setMainControl()
  if math.isEmpty(self.bind.heroId) then
    return
  end
  local mainHero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if L_BattleDataManager:getIsInBattle() and L_BattleDataManager:getIsInCD() then
    if mainHero.data.UUID == self.bind.heroId then
      self.modules.moduleHeroHeadEffect:setChoiceEffect(true)
    else
      if self.oldMainId == self.bind.heroId then
        self.modules.moduleHeroHeadEffect:setChoiceEffect(false)
      end
      self.modules.moduleHeroHeadEffect:doChangeCdAnim(true)
    end
  elseif mainHero.data.UUID == self.bind.heroId then
    self.modules.moduleHeroHeadEffect:setChoiceEffect(true)
  elseif self.oldMainId == self.bind.heroId then
    self.modules.moduleHeroHeadEffect:setChoiceEffect(false)
  end
  self.oldMainId = mainHero.data.UUID
end

function this:refresh()
  self.modules.moduleHeroHeadEffect:initHeroId(self.bind.heroId)
  if AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false) == nil then
    return
  end
  if math.isEmpty(self.bind.heroId) then
    return
  end
  local id = self.bind.heroId
  local hero = L_ItemManager:parseHeroItem(L_GameUtil.getConfigIdByGuid(self.bind.heroId))
  self.bind.imgPlayer = hero.iconHalf
  local hero = L_PlayerManager:getAllHeroCsEntity()[self.bind.heroId]
  if hero ~= nil then
    self.modules.moduleBuff:initBuff(hero, 5, 5, true)
  else
    self.bind.goDead = true
    self.modules.moduleHeroHeadEffect:refreshDead()
    self.bind.color_hero = DeadHeroColor
  end
  local petId = self.bind.petId
  if not math.isEmpty(petId) then
    self.bind.goPet = true
    local tpl = L_GameTpl:getPetTpl():getTplById(petId)
    local icon = L_GameTpl:getPetTpl():getPetIcon(tpl)
    self.bind.img_pet = icon
  else
    self.bind.goPet = false
  end
end

function this:update()
  if math.isEmpty(self.bind.heroId) then
    return
  end
  local csHeroEntity = AzurWorld.playerMgr.myPlayerData:GetHeroEntity(self.bind.index - 1)
  if csHeroEntity == nil then
    self.bind.sliderSp = 0
    self.bind.sliderHp = 0
    self.bind.goDead = true
    self.modules.moduleHeroHeadEffect:refreshDead()
    self.bind.color_hero = DeadHeroColor
    self:checkSpEffect()
    return
  end
  self.modules.moduleHeroHeadEffect:refreshDead()
  self.bind.goDead = false
  if 0 < C_MyFloatUtility.GetFloat(csHeroEntity.data.aliveProperty.hp) then
    self.bind.color_hero = C_Color.white
  else
    self.bind.color_hero = DeadHeroColor
  end
  self.bind.sliderSp = 0.05 + 0.95 * C_MyFloatUtility.GetFloat(csHeroEntity.data.aliveProperty.sp) / C_MyFloatUtility.GetFloat(csHeroEntity.data.aliveProperty.maxSp)
  self:checkSpEffect()
  self.bind.sliderHp = C_MyFloatUtility.GetFloat(csHeroEntity.data.aliveProperty.hp) / C_MyFloatUtility.GetFloat(csHeroEntity.data.aliveProperty.maxHp)
  local petCsEntity = AzurWorld.playerMgr.myPlayerData:GetPetEntity(self.bind.index - 1)
  if petCsEntity then
    local aliveProperty = petCsEntity.data.aliveProperty
    self.bind.slider_petHp = C_MyFloatUtility.GetFloat(aliveProperty.hp) / C_MyFloatUtility.GetFloat(aliveProperty.maxHp)
    if petCsEntity.data.aliveState == CS.Lens.Gameplay.Modules.BigWorld.EEntityAliveState.Reborn then
      self.bind.goPerReborn = true
      self.bind.color_petIcon = DeadHeroColor
      self.bind.color_petColor = PetGreenColor
    else
      self.bind.goPerReborn = false
      self.bind.color_petIcon = C_Color.white
      self.bind.color_petColor = PetRedColor
    end
  end
end

function this:isDead()
  return self.bind.goDead
end

function this:checkSpEffect()
  local isMax = self.bind.sliderSp >= 1
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
    self.bind.ani_spMax = "anim_hero_ultimate_in"
  end
end

function this:onEvent_onCastSkill(args)
  local heroid = args.castConfigId
  local slot = args.type
  if heroid ~= self.bind.heroId then
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

return this
