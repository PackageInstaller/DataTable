local DynBattleRole = require("Game.Exploration.Data.DynBattleRole")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynHero = class("DynHero", DynBattleRole)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function DynHero:ctor(heroData, uid, rolType)
  self.onBench = false
  self:InitDynHeroData(heroData, uid, rolType)
end

function DynHero:InitDynHeroData(heroData, uid, rolType)
  local skinId = PlayerDataCenter.skinData:DealNotSelfHaveHeroSkinOverraid(heroData.skinId, heroData.dataId)
  heroData:UpdateSkin(skinId)
  self.heroData = heroData
  self.heroCfg = heroData.heroCfg
  self.dataId = self.heroCfg.id
  self.rolType = rolType or proto_object_EplBattleRoleType.BattleRoleNormal
  self.cat = heroData.cat
  self.rank = heroData.star
  self.modelSpecSign = heroData.modelSpecSign or heroData:GetHeroIsNotHaveLegalSkin()
  self.isTowerAbandonMove = self.cat == BattleUtil.battleRoleCat.waitToCasterHero
  self.uid = uid or self.dataId
  self.resCfg = ConfigData.resource_model[self.heroCfg.src_id]
  if self.resCfg == nil then
    error("resource model cfg is null,id:" .. tostring(self.heroCfg.src_id))
    return
  end
  self.totalDamage = 0
  self.belong = eBattleRoleBelong.player
  self.attackRange = self.heroCfg.range
  self.moveSpeed = self.heroCfg.move_spd
  self.intensity = self.heroCfg.intensity
  self.hpPer = ExplorationEnum.eHeroHpPercent
  self.baseAttr = {}
  self.ratioAttr = {}
  self.extraAttr = {}
  self.isContainAction = true
  self.death_frames = self.resCfg.death_frames
  self.priority = 1
  self.vowName = heroData.vowName
  self:InitTowerHeroData()
end

function DynHero:InitTowerHeroData()
  if self.cat == BattleUtil.battleRoleCat.waitToCasterHero then
    local towerCfg = ConfigData.tower_hero_data[self.dataId]
    if towerCfg == nil then
      error("找不到指定id的塔防角色:" .. self.dataId)
      return
    end
    self.towerCostFormula = towerCfg.coin_cost_formula
    self.towerCdFormula = towerCfg.cd_formula
    self.towerOnSaleFormula = towerCfg.sell_formula
  end
end

function DynHero:UpdateBaseHeroData(attrDic, baseSkillDic, athSkillGroup, additionSkillGroup, rawAttr)
  if self.heroData == nil then
    return
  end
  self.originAttr = {}
  for i = 2, eHeroAttr.max_property_count + 1 do
    self.originAttr[i - 1] = attrDic[i]
  end
  local inTd = BattleUtil.IsInTDBattle()
  self.originSkillList = {}
  self.showSkillDic = {}
  for skillId, skillLevel in pairs(baseSkillDic) do
    local heroSkill = self.heroData.skillDic[skillId]
    if heroSkill == nil then
      warn(string.format("Cant get client heroSkill, skill id = %s, heroId = %s", skillId, self.heroData.dataId))
    else
      if skillLevel ~= heroSkill.level then
        warn(string.format("Client heroSkill level is different, skill id = %s, heroId = %s, clientLevel = %s, serverLevel = %s", skillId, self.heroData.dataId, heroSkill.level, skillLevel))
      end
      if inTd then
        local battleSkill = self:__GetTdBattleAdapterSkill(skillId, skillLevel, heroSkill)
        if battleSkill ~= nil then
          table.insert(self.originSkillList, battleSkill)
          self.showSkillDic[skillId] = battleSkill
      end
      else
        local battleSkill = DynBattleSkill.New(skillId, skillLevel, eBattleSkillLogicType.Original, heroSkill:IsSkillUnlockAdvance())
        battleSkill:SetIsFullLevel(heroSkill:IsFullLevel())
        table.insert(self.originSkillList, battleSkill)
        self.showSkillDic[skillId] = battleSkill
      end
    end
  end
  for skillId, heroSkill in pairs(self.heroData.skillDic) do
    if self.showSkillDic[skillId] == nil then
      local skillLevel = heroSkill.level
      if inTd then
        local battleSkill = self:__GetTdBattleAdapterSkill(skillId, skillLevel, heroSkill)
        if battleSkill ~= nil then
          self.showSkillDic[skillId] = battleSkill
      end
      else
        local battleSkill = DynBattleSkill.New(skillId, skillLevel, eBattleSkillLogicType.Original, heroSkill:IsSkillUnlockAdvance())
        battleSkill:SetIsFullLevel(heroSkill:IsFullLevel())
        self.showSkillDic[skillId] = battleSkill
      end
    end
  end
  self:RemoveItemSkillTypeDic(eBattleSkillLogicFreshRemove)
  if athSkillGroup ~= nil then
    for athSkillId, _ in pairs(athSkillGroup) do
      local skillLevel = 1
      local skillData = DynBattleSkill.New(athSkillId, skillLevel, eBattleSkillLogicType.AthSuit)
      self:AddItemSkill(skillData)
    end
  end
  if additionSkillGroup ~= nil then
    for athSkillId, _ in pairs(additionSkillGroup) do
      local skillLevel = 1
      local skillData = DynBattleSkill.New(athSkillId, skillLevel, eBattleSkillLogicType.ExtraAdd)
      self:AddItemSkill(skillData)
    end
  end
  self.rawAttr = rawAttr
end

function DynHero:AddBindItemSkillData(skillData)
  if self.__bindItemSkillDataDic == nil then
    self.__bindItemSkillDataDic = {}
  end
  self.__bindItemSkillDataDic[skillData] = true
end

function DynHero:__GetTdBattleAdapterSkill(skillId, skillLevel, heroSkill)
  local tdSkillCfg = ConfigData.skill_adapter[ExplorationEnum.SpecGameTypeAdapter.TD]
  local skillAdapterCfg
  if tdSkillCfg ~= nil then
    skillAdapterCfg = tdSkillCfg[skillId]
  end
  if skillAdapterCfg ~= nil and skillAdapterCfg.lock_type > 0 then
    local realSkillId = skillAdapterCfg.skill_id_new
    local battleSkill = DynBattleSkill.New(realSkillId, skillLevel, eBattleSkillLogicType.Original, heroSkill:IsSkillUnlockAdvance())
    battleSkill:SetIsFullLevel(heroSkill:IsFullLevel())
    battleSkill:SetSkillAdapterType(skillAdapterCfg.lock_type)
    return battleSkill
  end
  return nil
end

function DynHero:GetClientOriginAttr(attrId)
  if self.heroData == nil then
    return 0
  end
  if ConfigData.attribute[attrId] == nil or ConfigData.attribute[attrId + 100] == nil or ConfigData.attribute[attrId + 200] == nil then
    return 0
  end
  return self.heroData:GetAttr(attrId)
end

function DynHero:GetName()
  if not string.IsNullOrEmpty(self.vowName) then
    return self.vowName
  end
  if self.heroData ~= nil then
    return self.heroData:GetHeroName(true)
  end
  return LanguageUtil.GetLocaleText(self.heroCfg.name)
end

function DynHero:GetCareer()
  return self.heroCfg.career
end

function DynHero:GetCamp()
  return self.heroCfg.camp
end

function DynHero:GetResPicName()
  return self.heroData:GetResPicName()
end

function DynHero:GetResModelName(isDefault)
  return self.heroData:GetResModelName(isDefault)
end

function DynHero:GetExtendResName()
  return self.heroData:GetExtendResName()
end

function DynHero:GetResSrcId()
  return self.heroCfg.src_id
end

function DynHero:GetSkinId()
  return self.heroData.skinId or 0
end

function DynHero:GetLevel()
  return self.heroData.level
end

function DynHero:GetCurExp()
  return self.heroData.curExp
end

function DynHero:GetTotalExp()
  return self.heroData:GetLevelTotalExp()
end

function DynHero:GetStar()
  return self.heroData.star
end

function DynHero:UpdateTotalDamage(totalDamage)
  self.totalDamage = totalDamage
end

function DynHero:GetID()
  return self.dataId
end

function DynHero:IsBench()
  if self._battleOnBench ~= nil then
    return self._battleOnBench
  end
  return self.onBench
end

function DynHero:IsSupport()
  return self.rolType == proto_object_EplBattleRoleType.BattleRoleAssist
end

function DynHero:IsFriendSupport()
  return self.rolType == proto_object_EplBattleRoleType.BattleRoleFriendAssist
end

function DynHero:SetDynHeroFmtIdx(fmtInx)
  self.fmtInx = fmtInx
end

function DynHero:GetDynHeroFmtIdx()
  return self.fmtInx
end

function DynHero:SetDynHeroTalentLevel(talentLevel)
  self._talentLevel = talentLevel
end

function DynHero:GetDynHeroTalentLevel()
  return self._talentLevel
end

function DynHero:InitDynHeroBenchByFmtIdx(maxStageNum)
  self.onBench = maxStageNum < self.fmtInx
end

function DynHero:GetTowerCastCostFormula()
  return self.towerCostFormula
end

function DynHero:GetTowerCastCdFormula()
  return self.towerCdFormula
end

function DynHero:GetTowerLoadOffFormula()
  return self.towerOnSaleFormula
end

function DynHero:SetGuideResName(resName)
  self.heroData:SetGuideResName(resName)
end

function DynHero:IsHasGuideResName()
  return self.heroData:GetGuideResName() ~= nil
end

return DynHero
