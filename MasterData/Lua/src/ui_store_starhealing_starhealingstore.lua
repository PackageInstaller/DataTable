local this = class("starHealingStore", G_BaseStore)
this.event = {
  starHealingChargeRefresh = "starHealingChargeRefresh",
  playStarHealingEffect = "playStarHealingEffect",
  popModuleStartHealing = "popModuleStartHealing"
}
this:importPartialClass(require(L_R.store .. "starHealing.starHealingState"))
this:importPartialClass(require(L_R.store .. "starHealing.starHealingAction"))

function this:getCharge()
  return self.data.charge
end

function this:getChargeBefore()
  return self.data.chargeBefore
end

function this:getMaxCharge()
  local gameConstTpl = L_GameTpl:getGameConstTpl()
  local maxCharge = gameConstTpl:getData("MAX_CHARGE_SATIETY_VALUE", L_Const.GameTplType.int)
  return maxCharge
end

function this:getIsCharged()
  return self.data.isCharged
end

function this:setIsCharged(isCharged)
  if isCharged then
    self.data.chargeBefore = table.clone(self.data.charge)
    self:saveOldHeroHp()
  end
  self.data.isCharged = isCharged
end

function this:getOldHeroHp(heroId)
  return self.data.oldHeroHp[heroId] or 0
end

function this:saveOldHeroHp()
  self.data.oldHeroHp = {}
  local curModuleType = L_WorldManager:getCurModule()
  local formationType = L_FormationConst.FormationType.world
  local battleTypeModule = L_BattleStore:getCreateBattleType()
  if battleTypeModule == L_Const.createBattleType.tower then
    formationType = L_FormationConst.FormationType.tower
  else
    formationType = L_FormationConst.FormationType.world
  end
  local teamHeros = L_FormationStore:getCurTeamValidHeroes(formationType)
  for _, v in pairs(teamHeros) do
    if not math.isEmpty(v) then
      local hp_max = L_AttributeManager:getAttValueByHeroGuid(v, L_Const.battleAtt.MAXHP)
      local hero_formation = L_BattleStore:getObjBattleInfo(v)
      if hp_max <= hero_formation.hp then
        self.data.oldHeroHp[v] = 0
      end
      self.data.oldHeroHp[v] = hero_formation and hero_formation.hp / hp_max * 100 or 100
    end
  end
end

function this:triggerStarHealing()
  Timer.once(0.5, function()
    if self:getIsCharged() then
      return
    end
    if not L_StarHealingManager:checkIsCityValid() then
      return
    end
    self:call(self.event.autoStarHealing)
  end, self)
end

function this:setOldChargeValue(oldValue)
  self.data.oldValue = oldValue
end

function this:getOldChargeValue()
  return self.data.oldValue
end

function this:getSatietyStatus(satietyPer)
  local heroSatietyTpl = L_GameTpl:getChargeSatietyTpl()
  local intervalDic = heroSatietyTpl:getId2IntervalDic()
  local percent = satietyPer or self:getCharge().cur_value
  local curId = 1
  for id, interval in pairs(intervalDic) do
    if percent >= interval[1] and percent <= interval[2] then
      curId = id
      return id
    end
  end
  return curId
end

return this
