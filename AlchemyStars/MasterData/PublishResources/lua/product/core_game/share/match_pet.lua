_class("MatchPet", Object)
MatchPet = MatchPet

function MatchPet:Constructor(data)
  if data then
    self:SetData(data)
  end
end

function MatchPet:SetData(data)
  self._data = data
  local templateID = self:GetTemplateID()
  self._cfg_pet = Cfg.cfg_pet[templateID]
  self._cfg_level = Cfg["cfg_pet_level_" .. templateID .. "_" .. self:GetPetGrade()]({
    Level = self:GetPetLevel()
  })
  if self._cfg_level ~= nil then
    self._cfg_level = self._cfg_level[1]
  elseif self:GetPetGrade() ~= 0 and self:GetPetLevel() ~= 1 then
    Log.error("[pet] SetData cfg_pet_level ", templateID, " error ", self:GetPetGrade(), self:GetPetLevel())
  end
  self._cfg_grade = Cfg.cfg_pet_grade({
    PetID = templateID,
    Grade = self:GetPetGrade()
  })
  if self._cfg_grade ~= nil then
    self._cfg_grade = self._cfg_grade[1]
  elseif self:GetPetGrade() ~= 0 and self:GetPetLevel() ~= 1 then
    Log.error("[pet] SetData cfg_pet_grade error ", templateID, self:GetPetGrade(), self:GetPetLevel())
  end
  self._cfg_awakening = Cfg.cfg_pet_awakening({
    PetID = templateID,
    Awakening = self:GetAwakeMatch()
  })
  if self._cfg_awakening ~= nil then
    self._cfg_awakening = self._cfg_awakening[1]
  elseif self:GetPetGrade() == 0 or self:GetPetLevel() ~= 1 then
  end
  self._cfg_affinity = Cfg.cfg_pet_affinity({
    PetID = templateID,
    AffinityLevel = self:GetPetAffinityLevel()
  })
  if self._cfg_affinity then
    self._cfg_affinity = self._cfg_affinity[1]
  elseif 0 < self:GetPetAffinityLevel() then
    Log.error("[pet] SetData cfg_pet_affinity error tplid:", templateID, " AffinityLevel:", self:GetPetAffinityLevel())
  end
  self._petAttrDict = {
    [PetAttributeType.Attack] = {
      str = "attack",
      GetValFunc = self.GetPetAttack
    },
    [PetAttributeType.Defence] = {
      str = "defence",
      GetValFunc = self.GetPetDefence
    },
    [PetAttributeType.HP] = {
      str = "health",
      GetValFunc = self.GetPetHealth
    }
  }
  self._petSkillDict = {
    [PetSkillType.SkillType_Active] = {
      str = "major_des",
      GetIdFunc = self.GetPetActiveSkill
    },
    [PetSkillType.SkillType_ChainSkill] = {
      str = "chain_des",
      GetIdFunc = self.GetPetChainSkills
    },
    [PetSkillType.SkillType_Passive] = {
      str = "equip_des",
      GetIdFunc = self.GetPetPassiveSkill
    }
  }
  self._SkillRes = ResourceHelper:GetInstance():GetPetSKill()
  self._EquipRes = ResourceHelper:GetInstance():GetPetEquip()
  self._EquipRefineRes = ResourceHelper:GetInstance():GetPetEquipRefine()
  self._afterDamage = data.after_damage or 0
  self._attack = data.attack and 0 < data.attack and data.attack or self:getAttr("Attack")
  self._defense = data.defense and 0 < data.defense and data.defense or self:getAttr("Defence")
  self._maxhp = data.max_hp and 0 < data.max_hp and data.max_hp or self:getAttr("Health")
  self._maxhp = math.floor(self._maxhp)
  self._power = data.pet_power or -1
  self._legendPower = data.pet_legendPower or 0
  self._alchemyPower = data.pet_alchemyPower or 0
  self._curHp = data.cur_hp and 0 < data.cur_hp and data.cur_hp or self._maxhp
  if self._power == -1 then
    local activeSkillID = self:GetPetActiveSkill()
    local cfgv = Cfg.cfg_pet_battle_skill[activeSkillID]
    if cfgv then
      self._power = cfgv.TriggerParam
    else
      Log.fatal("### can not find cfg in cfg_pet_battle_skill. activeSkillID=", activeSkillID)
    end
  end
  local petSkillCfg = Cfg.cfg_pet_skill({
    PetID = templateID,
    Grade = self:GetPetGrade(),
    Awakening = self:GetAwakeMatch()
  })
  if petSkillCfg and 0 < #petSkillCfg then
    self._featureList = petSkillCfg[1].FeatureList
  end
end

function MatchPet:CalAttr()
  self._attack = self:getAttr("Attack")
  self._defense = self:getAttr("Defence")
  self._maxhp = self:getAttr("Health")
  self._maxhp = math.floor(self._maxhp)
end

function MatchPet:RepeatGetTimes()
  return self._data.repet_get_times
end

function MatchPet:IsLike()
  return self._data.b_pet_like
end

function MatchPet:GetTeamSlot()
  return self._data.team_slot
end

function MatchPet:GetPstID()
  return self._data.pet_pstid
end

function MatchPet:GetTemplateID()
  return self._data.template_id
end

function MatchPet:GetEquipRefineLv()
  return self._data.equip_refine_lv
end

function MatchPet:GetEquipRefineMaxLv()
  local cfgs = Cfg.cfg_pet_equip_refine({
    PetID = self:GetTemplateID()
  })
  if cfgs then
    return table.count(cfgs)
  end
  return 0
end

function MatchPet:GetPetName()
  return self._cfg_pet.Name
end

function MatchPet:GetPetEnglishName()
  return self._cfg_pet.EnglishName
end

function MatchPet:GetPetNickName()
  return self._cfg_pet.NickName
end

function MatchPet:GetPetTags()
  return self._cfg_pet.Tags
end

function MatchPet:GetBinderPetID()
  return self._cfg_pet.BinderPetID
end

function MatchPet:IsMyTag(nTag)
  local l_tags = self:GetPetTags()
  for key, value in ipairs(l_tags) do
    if value == nTag then
      return true
    end
  end
  return false
end

function MatchPet:IsLegendPet()
  return self._cfg_pet.LegendPet == 1
end

function MatchPet:GetPetLevel()
  return self._data.level
end

function MatchPet:GetPetExp()
  return self._data.exp
end

function MatchPet:GetPetGrade()
  return self._data.grade
end

function MatchPet:GetPetAwakening()
  return self._data.awakening
end

function MatchPet:GetAwakeLock()
  return self._data.awake_lock
end

function MatchPet:GetAwakeMatch()
  return self:GetPetAwakening()
end

function MatchPet:GetPetAffinityLevel()
  return self._data.affinity_level
end

function MatchPet:GetPetAffinityMaxLevel()
  local affinityCfg = Cfg.cfg_pet_affinity_exp({})
  if affinityCfg == nil then
    return 0
  end
  return #affinityCfg
end

function MatchPet:GetPetAffinityExp()
  return math.floor(self._data.affinity_exp)
end

function MatchPet:GetPetAffinityMaxExp(level)
  if level == self:GetPetAffinityMaxLevel() then
    return Cfg.cfg_pet_affinity_exp[level].NeedAffintyExp - Cfg.cfg_pet_affinity_exp[level - 1].NeedAffintyExp
  end
  local exp = Cfg.cfg_pet_affinity_exp[level + 1].NeedAffintyExp - Cfg.cfg_pet_affinity_exp[level].NeedAffintyExp
  return exp
end

function MatchPet:GetPetAffinityLevelUpPercent()
  local curLevel = self:GetPetAffinityLevel()
  local maxLevel = self:GetPetAffinityMaxLevel()
  if curLevel == maxLevel then
    return 1
  end
  local deltaExp = self:GetPetAffinityMaxExp(curLevel)
  local curExp = self:GetPetAffinityExp() - Cfg.cfg_pet_affinity_exp[curLevel].NeedAffintyExp
  return curExp / deltaExp
end

function MatchPet:GetTriggeredStoryId()
  return self._data.triggered_story_id
end

function MatchPet:IsTriggeredStory()
  local airModule = GameGlobal.GetModule(AircraftModule)
  local stories = airModule:GetPetStroyEventId(self:GetPstID())
  if stories and table.count(stories) > 0 then
    return true
  end
  return false
end

function MatchPet:GetTriggeredTaskId()
  return self._data.triggered_task_id
end

function MatchPet:IsFinishedStory(nStoryEventId)
  for index, value in ipairs(self._data.story_finish_record) do
    if value == nStoryEventId then
      return true
    end
  end
  return false
end

function MatchPet:GetFinishedStoryCount()
  return table.count(self._data.story_finish_record)
end

function MatchPet:GetPetStar()
  return self._cfg_pet.Star
end

function MatchPet:GetProf()
  return self._cfg_pet.Prof
end

function MatchPet:GetJob()
  return self:GetProf()
end

function MatchPet:GetPetFirstElement()
  return self._cfg_pet.FirstElement
end

function MatchPet:GetPetSecondElement()
  if self:GetPetGrade() >= self._cfg_pet.Element2NeedGrade and self._cfg_pet.SecondElement > 0 then
    return self._cfg_pet.SecondElement
  end
end

function MatchPet:GetHPOffset()
  local realSkinId = 0
  if MatchPet.IsEffectByPetSkin(PetSkinEffectPath.MODEL_INGAME) and self._data.current_skin and self._data.current_skin > 1 then
    realSkinId = self._data.current_skin
  end
  if realSkinId == 0 then
    local petCfg = self._cfg_pet
    if not petCfg then
      Log.fatal("###[GetHPOffset] pet cfg is nil ! id --> ", tid, "| grade --> ", grade)
      return 0.15
    end
    realSkinId = petCfg.SkinId
  end
  local cfg = Cfg.cfg_pet_skin[realSkinId]
  if not cfg then
    Log.fatal("###[GetHPOffset] skin cfg is nil ! id --> ", tid, "| grade --> ", grade)
    return nil
  end
  return cfg.HeightOffset
end

function MatchPet:GetStoryTipsOffset()
  return self._cfg_pet.TipsHeightOffSet
end

function MatchPet:GetPetElements()
  return {
    self:GetPetFirstElement(),
    self:GetPetSecondElement()
  }
end

function MatchPet:GetPetChinaTag()
  return self._cfg_pet.ChinaTag
end

function MatchPet:GetPetHead(path)
  return HelperProxy:GetInstance():GetPetHead(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), path)
end

function MatchPet:GetPetVideo(path)
  return HelperProxy:GetInstance():GetPetVideo(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), path)
end

function MatchPet:GetPetItemIcon(path)
  return HelperProxy:GetInstance():GetPetItemIcon(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), path)
end

function MatchPet:GetSkinId()
  if self._data.current_skin and self._data.current_skin > 1 then
    return self._data.current_skin
  end
  local skinId = 1
  if self:GetPetGrade() == 0 then
    skinId = self._cfg_pet.SkinId
  else
    skinId = self._cfg_grade.SkinId
  end
  return skinId or 1
end

function MatchPet:GetPetBody(path)
  return HelperProxy:GetInstance():GetPetBody(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), path)
end

function MatchPet:GetBattleMes(path)
  return HelperProxy:GetInstance():GetPetBattleMes(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), path)
end

function MatchPet:GetHeadChain(path)
  return HelperProxy:GetInstance():GetPetHeadChain(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), path)
end

function MatchPet:GetPetTeamBody(path)
  return HelperProxy:GetInstance():GetPetTeamBody(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), path)
end

function MatchPet:GetPetNextGradeBodyName()
  local data = {BodyName = "", StaticBody = ""}
  local next_grade = self:GetPetGrade() + 1
  if next_grade > self:GetMaxGrade() then
    return data
  else
    local _cfg_grade_next = Cfg.cfg_pet_grade({
      PetID = self:GetTemplateID(),
      Grade = next_grade
    })
    data.BodyName = _cfg_grade_next[1].BodyName
    data.StaticBody = HelperProxy:GetInstance():GetPetStaticBody(self:GetTemplateID(), next_grade, 0, PetSkinEffectPath.NO_EFFECT)
  end
  return data
end

function MatchPet:GetPetStaticBody(path)
  return HelperProxy:GetInstance():GetPetStaticBody(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), path)
end

function MatchPet:GetPetBattleResultCG(path)
  return HelperProxy:GetInstance():GetPetSimpleCg(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), path)
end

function MatchPet:GetPetAircraftBody(path)
  return HelperProxy:GetInstance():GetPetAircraftBody(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), path)
end

function MatchPet:GetPetSpine(path)
  return HelperProxy:GetInstance():GetPetSpine(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), path)
end

function MatchPet:GetPetLogo()
  return self._cfg_pet.Logo
end

function MatchPet:GetPetDes()
  if self:GetPetGrade() == 0 then
    return ""
  else
    return self._cfg_grade.Des
  end
end

function MatchPet.IsEffectByPetSkin(path)
  if not path then
    return true
  end
  local cfg = Cfg.cfg_pet_skin_effect_filter[path]
  if cfg then
    return cfg.Effected
  end
  return true
end

function MatchPet.GetPetSkinCfg(tid, grade, skinId, path)
  local realSkinId = 0
  if MatchPet.IsEffectByPetSkin(path) and skinId and 1 < skinId then
    realSkinId = skinId
  end
  if realSkinId == 0 then
    if grade == 0 then
      local petCfg = Cfg.cfg_pet[tid]
      if not petCfg then
        Log.fatal("###[GetPetSkinCfg] pet cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
        return nil
      end
      realSkinId = petCfg.SkinId
    else
      local gradeCfg = Cfg.cfg_pet_grade({PetID = tid, Grade = grade})[1]
      if not gradeCfg then
        Log.fatal("###[GetPetSkinCfg] grade cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
        return nil
      end
      realSkinId = gradeCfg.SkinId
    end
  end
  local cfg = Cfg.cfg_pet_skin[realSkinId]
  if not cfg then
    Log.fatal("###[GetPetSkinCfg] skin cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg
end

function MatchPet:GetPetPrefab(path)
  local cfg = MatchPet.GetPetSkinCfg(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), path)
  if not cfg then
    Log.fatal("###[GetPetPrefab] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.Prefab
end

function MatchPet:GetPetShaderEffect()
  return self._cfg_pet.ShaderEffect
end

function MatchPet:GetNormalSkill()
  local petid = self:GetTemplateID()
  local grade = self:GetPetGrade()
  local awakening = self:GetAwakeMatch()
  return self._SkillRes:GetNormalSKill(petid, grade, awakening)
end

function MatchPet:GetPetActiveSkill(grade, awakening)
  local petid = self:GetTemplateID()
  local realGrade = grade or self:GetPetGrade()
  local realAwakening = awakening or self:GetAwakeMatch()
  return self._SkillRes:GetActiveSkill(petid, realGrade, realAwakening)
end

function MatchPet:GetPetExtraActiveSkill(grade, awakening)
  local equipRefineActiveSkillList = self:GetEquipRefineExtraActiveSkill()
  if equipRefineActiveSkillList then
    return equipRefineActiveSkillList
  end
  local petid = self:GetTemplateID()
  local _grade = grade or self:GetPetGrade()
  local _awakening = awakening or self:GetAwakeMatch()
  return self._SkillRes:GetExtraActiveSkill(petid, _grade, _awakening)
end

function MatchPet:GetPetVariantActiveSkill(grade, awakening)
  local equipRefineActiveSkillInfo = self:GetEquipRefineVariantActiveSkillInfo()
  if equipRefineActiveSkillInfo then
    return equipRefineActiveSkillInfo
  end
  local petid = self:GetTemplateID()
  local tmpGrade = grade or self:GetPetGrade()
  local tmpAwakening = awakening or self:GetAwakeMatch()
  return self._SkillRes:GetVariantActiveSkill(petid, tmpGrade, tmpAwakening)
end

function MatchPet:GetPetPassiveSkill(grade, awakening)
  local petid = self:GetTemplateID()
  local _grade = grade or self:GetPetGrade()
  local _awakening = awakening or self:GetAwakeMatch()
  return self._SkillRes:GetPassiveSkill(petid, _grade, _awakening)
end

function MatchPet:GetPetChainSkills(grade, awakening)
  local petid = self:GetTemplateID()
  local _grade = grade or self:GetPetGrade()
  local _awakening = awakening or self:GetAwakeMatch()
  local result = self._SkillRes:GetChainSkill(petid, _grade, _awakening)
  local equipRefineLv = self:GetEquipRefineLv()
  local cfg = self._EquipRefineRes:GetRes(petid, equipRefineLv)
  if cfg ~= nil and cfg.ExtraChainSkill ~= nil then
    table.insert(result, cfg.ExtraChainSkill[1])
  end
  return result
end

function MatchPet:GetPetIntensifyBuffList(grade, awakening)
  local petid = self:GetTemplateID()
  local _grade = grade or self:GetPetGrade()
  local _awakening = awakening or self:GetAwakeMatch()
  return self._SkillRes:GetIntensifyBuffList(petid, _grade, _awakening)
end

function MatchPet:GetChainSkillInfo(grade, awakening)
  local skills = self:GetPetChainSkills(grade, awakening)
  local ret = {}
  for i, v in ipairs(skills) do
    if 0 < v then
      ret[i] = {
        Skill = v,
        Chain = BattleSkillCfg(v).TriggerParam
      }
    end
  end
  return ret
end

function MatchPet:GetPetWorkSkills(grade, awakening)
  local petid = self:GetTemplateID()
  local _grade = grade or self:GetPetGrade()
  local _awakening = awakening or self:GetPetAwakening()
  local ss = self._SkillRes:GetWorkSkill(petid, _grade, _awakening)
  if not ss then
    return nil
  end
  local works = {}
  for i = 1, #ss do
    local wkid = ss[i]
    if self:CheckWorkSkillOpen(wkid) then
      works[#works + 1] = wkid
    end
  end
  return works
end

function MatchPet:GetDefaultSkills(petId)
  local skillinfo = self._SkillRes:GetSKill(petId, 0, 0)
  if skillinfo == nil then
    return nil
  end
  return skillinfo.ActiveSkill, skillinfo.ChainSkill1, skillinfo.PassiveSkill
end

function MatchPet:SkillRelated(room_type)
  local skills = self:GetPetWorkSkills()
  for _, skill in ipairs(skills) do
    local cfg = Cfg.cfg_work_skill({ID = skill})
    if cfg and room_type == cfg[1].RoomType then
      return true
    end
  end
  return false
end

function MatchPet:getAttr(attr)
  local value = self._cfg_level and self._cfg_level[attr] or 0
  if 0 < self:GetPetGrade() then
    value = value + self._cfg_grade[attr]
  end
  if 0 < self:GetPetAwakening() then
    local attrName = attr .. "Percent"
    value = math.floor(value + self._cfg_awakening[attr] + self._cfg_awakening[attrName] * self._cfg_level[attr] / 100)
  end
  if self:GetPetAffinityLevel() and 0 < self:GetPetAffinityLevel() then
    value = value + self._cfg_affinity[attr]
  end
  local el = self:GetEquipCfg()
  if el ~= nil then
    value = value + el[attr]
  end
  local equipRefine = self:GetEquipRefineCfg()
  if equipRefine ~= nil then
    value = value + equipRefine[attr]
  end
  return value
end

function MatchPet:GetPetAffinityAttrAdded(attr)
  local value = 0
  if self:GetPetAffinityLevel() and 0 < self:GetPetAffinityLevel() then
    value = value + self._cfg_affinity[attr]
  end
  return value
end

function MatchPet:GetPetAttack()
  return self._attack
end

function MatchPet:GetPetDefence()
  return self._defense
end

function MatchPet:GetPetHealth()
  return self._maxhp
end

function MatchPet:GetPetCurHealth()
  return self._curHp
end

function MatchPet:GetPetPower()
  return self._power
end

function MatchPet:GetPetLegendPower()
  return self._legendPower
end

function MatchPet:GetPetAlchemyPower()
  return self._alchemyPower
end

function MatchPet:GetPetCrit()
  return self:getAttr("Crit")
end

function MatchPet:GetPetCritHurt()
  return self:getAttr("CritHurt")
end

function MatchPet:GetPetDoge()
  return self:getAttr("Doge")
end

function MatchPet:GetPetHit()
  return self:getAttr("Hit")
end

function MatchPet:GetPetGradeAttr(attr)
  if self:GetPetGrade() > 0 then
    return self._cfg_grade[attr]
  end
  return 0
end

function MatchPet:GetPetAwakeningAttr(attr)
  if self:GetPetAwakening() > 0 then
    return self._cfg_awakening[attr]
  end
end

function MatchPet:GetPetAffinityAttr(attr)
  if self:GetPetAffinityLevel() > 0 then
    return self._cfg_affinity[attr]
  end
  return 0
end

function MatchPet:GetMaxLevel()
  local cfgs = Cfg["cfg_pet_level_" .. self:GetTemplateID() .. "_" .. self:GetPetGrade()]()
  local max = 1
  for _, c in pairs(cfgs) do
    if max < c.Level then
      max = c.Level
    end
  end
  return max
end

function MatchPet:GetMaxGrade()
  local cfgs = Cfg.cfg_pet_grade({
    PetID = self:GetTemplateID()
  })
  local max = 0
  for _, c in ipairs(cfgs) do
    if max < c.Grade then
      max = c.Grade
    end
  end
  return max
end

function MatchPet:GetMaxAwakening()
  local cfgs = Cfg.cfg_pet_awakening({
    PetID = self:GetTemplateID()
  })
  local max = 0
  if cfgs ~= nil then
    for _, c in ipairs(cfgs) do
      if max < c.Awakening then
        max = c.Awakening
      end
    end
  end
  return max
end

function MatchPet:GetLevelUpNeedExp()
  if self:GetPetLevel() >= self:GetMaxLevel() then
    Log.error("pet is max level")
    return nil
  end
  local cfg = self:GetLevelConfig(self:GetPetLevel() + 1)
  return cfg.NeedExp
end

function MatchPet:GetAffinityLevelUpNeedExp()
  local cfg = Cfg.cfg_pet_affinity_exp[self._data.affinity_level]
  if cfg ~= nil then
    return cfg.NeedAffintyExp
  end
end

function MatchPet:GetLevelConfig(level)
  local cfg = Cfg["cfg_pet_level_" .. self:GetTemplateID() .. "_" .. self:GetPetGrade()]({Level = level})
  if cfg ~= nil then
    return cfg[1]
  end
end

function MatchPet:GetCurrentLevelConfig()
  return self._cfg_level
end

function MatchPet:GetAwakeningConfig()
  local cfgs = Cfg.cfg_pet_awakening({
    PetID = self:GetTemplateID()
  })
  for i = #cfgs, 1, -1 do
    if cfgs[i].Awakening <= 0 then
      table.remove(cfgs, i)
    end
  end
  return cfgs
end

function MatchPet:GetSortValue(sort_type)
  if sort_type == PetSortType.Attack then
    return self:GetPetAttack()
  end
  if sort_type == PetSortType.Defence then
    return self:GetPetDefence()
  end
  if sort_type == PetSortType.Element then
    return self:GetPetFirstElement()
  end
  if sort_type == PetSortType.Star then
    return self:GetPetStar()
  end
  if sort_type == PetSortType.Health then
    return self:GetPetHealth()
  end
  if sort_type == PetSortType.Level then
    return self:GetPetLevel() + self:GetPetGrade() * 1000 + self:GetPetAwakening() * 10000
  end
  if sort_type == PetSortType.Affinity then
    return self:GetPetAffinityLevel()
  end
end

PetSkillChangeState = {
  NoChange = 0,
  Improved = 1,
  NewGain = 2
}

function MatchPet:GetChainSkillsByAwakening(awakening)
  local skills = {}
  local cfg = {}
  if awakening > self:GetMaxAwakening() then
    return nil
  end
  if awakening == 0 then
    cfg = Cfg.cfg_pet[self._data.template_id]
  else
    cfg = Cfg.cfg_pet_awakening({
      PetID = self:GetTemplateID(),
      Awakening = awakening
    })
    if not cfg then
      return nil
    end
    cfg = cfg[1]
  end
  skills = self:GetChainSkillInfo(nil, awakening)
  return skills
end

function MatchPet:GetSkillsByGrade(grade)
  local cfg = {}
  if grade == 0 then
    cfg = Cfg.cfg_pet[self._data.template_id]
  else
    cfg = Cfg.cfg_pet_grade({
      PetID = self:GetTemplateID(),
      Grade = grade
    })
    if not cfg then
      return nil
    end
    cfg = cfg[1]
  end
  local extra_skill_list = self:GetPetExtraActiveSkill(grade)
  local extra_skill_single = 0
  if extra_skill_list then
    extra_skill_single = extra_skill_list[1]
  end
  local data = {
    active_skill = self:GetPetActiveSkill(grade),
    extra_skill = extra_skill_single,
    chain_skills = self:GetPetChainSkills(grade),
    work_skills = self:GetPetWorkSkills(grade),
    passive_skills = self:GetPetPassiveSkill(grade),
    body = HelperProxy:GetInstance():GetPetStaticBody(self:GetTemplateID(), grade, 0, PetSkinEffectPath.NO_EFFECT)
  }
  return data
end

function MatchPet:GetUpgradeChangeWithSkillID()
  local grade = self:GetPetGrade()
  if grade >= self:GetMaxGrade() then
    return nil
  end
  local next_grade_skills = self:GetSkillsByGrade(grade + 1)
  local cur_grade_skills = self:GetSkillsByGrade(grade)
  local change_data = {
    active_skill_status = {},
    extra_skill_status = {},
    chain_skills_status = {},
    work_skills_status = {},
    passive_skills_status = {},
    body_status = {}
  }
  if cur_grade_skills.active_skill ~= next_grade_skills.active_skill then
    change_data.active_skill_status.state = PetSkillChangeState.Improved
    change_data.active_skill_status.from = cur_grade_skills.active_skill
    change_data.active_skill_status.to = next_grade_skills.active_skill
  else
    change_data.active_skill_status.state = PetSkillChangeState.NoChange
    change_data.active_skill_status.from = cur_grade_skills.active_skill
    change_data.active_skill_status.to = next_grade_skills.active_skill
  end
  if cur_grade_skills.extra_skill ~= next_grade_skills.extra_skill then
    if cur_grade_skills.extra_skill == 0 then
      change_data.extra_skill_status.state = PetSkillChangeState.NewGain
      change_data.extra_skill_status.from = cur_grade_skills.extra_skill
      change_data.extra_skill_status.to = next_grade_skills.extra_skill
    else
      change_data.extra_skill_status.state = PetSkillChangeState.Improved
      change_data.extra_skill_status.from = cur_grade_skills.extra_skill
      change_data.extra_skill_status.to = next_grade_skills.extra_skill
    end
  else
    change_data.extra_skill_status.state = PetSkillChangeState.NoChange
    change_data.extra_skill_status.from = cur_grade_skills.extra_skill
    change_data.extra_skill_status.to = next_grade_skills.extra_skill
  end
  if cur_grade_skills.body ~= next_grade_skills.body then
    change_data.body_status.state = PetSkillChangeState.NewGain
    change_data.body_status.from = cur_grade_skills.body
    change_data.body_status.to = next_grade_skills.body
  else
    change_data.body_status.state = PetSkillChangeState.NoChange
    change_data.body_status.from = cur_grade_skills.body
    change_data.body_status.to = next_grade_skills.body
  end
  for i = 1, #cur_grade_skills.chain_skills do
    local chain_skill = cur_grade_skills.chain_skills[i]
    local next_skill = next_grade_skills.chain_skills[i]
    if chain_skill == nil and next_skill == nil then
      break
    end
    if chain_skill ~= next_skill then
      if chain_skill == nil then
        change_data.chain_skills_status[i] = {}
        change_data.chain_skills_status[i].state = PetSkillChangeState.NewGain
        change_data.chain_skills_status[i].from = chain_skill
        change_data.chain_skills_status[i].to = next_skill
      else
        change_data.chain_skills_status[i] = {}
        change_data.chain_skills_status[i].state = PetSkillChangeState.Improved
        change_data.chain_skills_status[i].from = chain_skill
        change_data.chain_skills_status[i].to = next_skill
      end
    else
      change_data.chain_skills_status[i] = {}
      change_data.chain_skills_status[i].state = PetSkillChangeState.NoChange
      change_data.chain_skills_status[i].from = chain_skill
      change_data.chain_skills_status[i].to = next_skill
    end
  end
  for i = 1, 3 do
    local workskill = cur_grade_skills.work_skills[i]
    local next_skill = next_grade_skills.work_skills[i]
    if not (workskill or next_skill) then
      break
    end
    if workskill ~= next_skill then
      if workskill == nil then
        change_data.work_skills_status[i] = {}
        change_data.work_skills_status[i].state = PetSkillChangeState.NewGain
        change_data.work_skills_status[i].from = workskill
        change_data.work_skills_status[i].to = next_skill
      else
        change_data.work_skills_status[i] = {}
        change_data.work_skills_status[i].state = PetSkillChangeState.Improved
        change_data.work_skills_status[i].from = workskill
        change_data.work_skills_status[i].to = next_skill
      end
    else
      change_data.work_skills_status[i] = {}
      change_data.work_skills_status[i].state = PetSkillChangeState.NoChange
      change_data.work_skills_status[i].from = workskill
      change_data.work_skills_status[i].to = next_skill
    end
  end
  if cur_grade_skills.passive_skills ~= next_grade_skills.passive_skills then
    if cur_grade_skills.passive_skills == 0 then
      change_data.passive_skills_status.state = PetSkillChangeState.NewGain
      change_data.passive_skills_status.from = cur_grade_skills.passive_skills
      change_data.passive_skills_status.to = next_grade_skills.passive_skills
    else
      change_data.passive_skills_status.state = PetSkillChangeState.Improved
      change_data.passive_skills_status.from = cur_grade_skills.passive_skills
      change_data.passive_skills_status.to = next_grade_skills.passive_skills
    end
  else
    change_data.passive_skills_status.state = PetSkillChangeState.NoChange
    change_data.passive_skills_status.from = cur_grade_skills.passive_skills
    change_data.passive_skills_status.to = next_grade_skills.passive_skills
  end
  return change_data
end

function MatchPet:GetAttrStr(attrType)
  return self._petAttrDict[attrType].str or ""
end

function MatchPet:GetAttrFunc(attrType)
  return self._petAttrDict[attrType].GetValFunc or nil
end

function MatchPet:GetSkillByType(skillType)
  return self._petSkillDict[skillType] or nil
end

function MatchPet:GetWorkSkillAffinity(room_type, skill_type)
  local vv = 0
  local skills = self:GetPetWorkSkills()
  for _, skill_id in ipairs(skills) do
    local cfg = Cfg.cfg_work_skill[skill_id]
    if cfg and cfg.RoomType == room_type and cfg.WorkEffect[1] == skill_type then
      vv = vv + cfg.WorkEffect[2]
    end
  end
  return vv
end

function MatchPet:GetWorkSkillEffectVV(work_type, room_type)
  local av = 0
  local mv = 0
  local skills = self:GetPetWorkSkills()
  if skills == nil then
    return av, mv
  end
  for _, skill_id in ipairs(skills) do
    local cfg = Cfg.cfg_work_skill[skill_id]
    if cfg and cfg.RoomType == room_type and cfg.WorkEffect[1] == work_type then
      av = av + cfg.WorkEffect[2]
      mv = mv + cfg.WorkEffect[3]
    end
  end
  return av, mv
end

function MatchPet:IsEffectiveSkill(room_type)
  local skills = self:GetPetWorkSkills()
  for _, skill_id in ipairs(skills) do
    local cfg = Cfg.cfg_work_skill[skill_id]
    if cfg and cfg.RoomType == room_type then
      return true
    end
  end
  return false
end

function MatchPet:HaveType(choose_types)
  local ret = false
  for key, value in pairs(choose_types) do
    if value == AircraftEnterChooseType.MasterCtrl then
      ret = self:IsEffectiveSkill(AirRoomType.CentralRoom)
    elseif value == AircraftEnterChooseType.Power then
      ret = self:IsEffectiveSkill(AirRoomType.PowerRoom)
    elseif value == AircraftEnterChooseType.Replay then
      ret = self:IsEffectiveSkill(AirRoomType.MazeRoom)
    elseif value == AircraftEnterChooseType.Catch then
      ret = self:IsEffectiveSkill(AirRoomType.EvilRoom)
    elseif value == AircraftEnterChooseType.Puri then
      ret = self:IsEffectiveSkill(AirRoomType.PurifyRoom)
    end
    if ret then
      return ret
    end
  end
  return ret
end

function MatchPet:PetGradeNewSkill()
  local petid = self:GetTemplateID()
  local grade = self:GetMaxGrade()
  local awakening = self:GetAwakeMatch()
  local work_skill_l = 0
  local work_skill_2 = 0
  local work_skill_3 = 0
  local res = {}
  for i = 0, grade do
    local wks = self._SkillRes:GetSKill(petid, i, awakening)
    if wks.WorkSkill1 and wks.WorkSkill1 ~= 0 and work_skill_l == 0 and self:CheckWorkSkillOpen(wks.WorkSkill1) then
      work_skill_l = wks.WorkSkill1
      res[#res + 1] = {Grade = i, NewSkill = work_skill_l}
    end
    if wks.WorkSkill2 and wks.WorkSkill2 ~= 0 and work_skill_2 == 0 and self:CheckWorkSkillOpen(wks.WorkSkill2) then
      work_skill_2 = wks.WorkSkill2
      res[#res + 1] = {Grade = i, NewSkill = work_skill_2}
    end
    if wks.WorkSkill3 and wks.WorkSkill3 ~= 0 and work_skill_3 == 0 and self:CheckWorkSkillOpen(wks.WorkSkill3) then
      work_skill_3 = wks.WorkSkill3
      res[#res + 1] = {Grade = i, NewSkill = work_skill_3}
    end
    if 3 <= #res then
      break
    end
  end
  return res
end

function MatchPet:CheckWorkSkillOpen(skillID)
  local cfg_work_skill = Cfg.cfg_work_skill[skillID]
  if not cfg_work_skill then
    Log.error("###[MatchPet] cfg_work_skill is nil ! id --> ", skillID)
  end
  local roomType = cfg_work_skill.RoomType
  local airModule = GameGlobal.GetModule(AircraftModule)
  if roomType == AirRoomType.TacticRoom and not airModule:GetSwitchOpenState(16) then
    return false
  end
  return true
end

function MatchPet:GetPetCamp()
  local cfgPetTagList = self._cfg_pet.Tags
  local tcfgPetTags = Cfg.cfg_pet_tags
  for i = 1, #cfgPetTagList do
    local tagID = cfgPetTagList[i]
    if tcfgPetTags[tagID].tagType == PetTagType.Camp then
      return tagID
    end
  end
  Log.error("Pet camp tag not found: petTemplateID=", self._cfg_pet.ID)
  return nil
end

function MatchPet:HasPreEmptiveAttack()
  local petid = self:GetTemplateID()
  local grade = self:GetPetGrade()
  local awakening = self:GetAwakeMatch()
  local list = self._SkillRes:GetIntensifyBuffList(petid, grade, awakening)
  if list then
    local i = table.ikey(list, BattleConst.PreAttackBuffId)
    if i then
      return 0 < i
    else
      return false
    end
  else
    return false
  end
end

function MatchPet:GetTaskInfoVec()
  return self._data.task_info
end

function MatchPet:GetFirstTaskInfo()
  local len = #self._data.task_info
  if len <= 0 then
    return nil
  end
  return self._data.task_info[1]
end

function MatchPet:GetAfterDamage()
  return self._afterDamage
end

function MatchPet:IsWrok()
  local ss = self._data.mask_state & PetMaskState.PMS_Dispatch
  return ss <= 0
end

function MatchPet:IsDispatch()
  return true
end

function MatchPet:IsPetMaskState(maskState)
  local ss = self._data.mask_state & maskState
  return ss <= 0
end

function MatchPet:GetEquipLv()
  return self._data.equip_lv
end

function MatchPet:GetHelpPetKey()
  return self._data.m_nHelpPetKey
end

function MatchPet:IsHelpPet()
  return self:GetHelpPetKey() > 0
end

function MatchPet:OpenEquip()
  if self._data.equip_lv > 0 then
    return true
  end
  return false
end

function MatchPet:GetEquipCfg(level)
  if level == nil then
    level = self:GetEquipLv()
    if level == nil then
      return nil
    end
  end
  if level <= 0 then
    return nil
  end
  local cfgid = self:GetTemplateID()
  return self._EquipRes:GetRes(cfgid, level)
end

function MatchPet:GetEquipRefineStatus()
  local lv = self._data.equip_refine_lv
  if 0 < lv then
    return PetEquipRefineStatus.UNLOCK
  end
  local cfgs = Cfg.cfg_pet_equip_refine({
    PetID = self:GetTemplateID(),
    Level = 1
  })
  if not cfgs or #cfgs == 0 then
    return PetEquipRefineStatus.NO_OPEN
  end
  local cfg = cfgs[1]
  local strCondition = cfg.OpenCondition
  local conditions = StrToArray2:GetInstance():GetArray(strCondition, "&", ",", nil, true)
  local isOpen = true
  for k, v in pairs(conditions) do
    if not ConditionCheck:GetInstance():Check(v) then
      isOpen = false
      break
    end
  end
  if isOpen then
    return PetEquipRefineStatus.UNLOCK
  end
  return PetEquipRefineStatus.OPEN_LOCK
end

function MatchPet:GetEquipIntensifyParams()
  local res = self:GetEquipCfg()
  if res then
    return res.elementParam
  else
  end
  return nil
end

function MatchPet:GetPropertyRestraint()
  local res = self:GetEquipCfg()
  if res then
    return res.PropertyRestraint
  end
  return 0
end

function MatchPet:getAttWithoutBreak(attr)
  local value = self._cfg_level and self._cfg_level[attr] or 0
  if 0 < self:GetPetGrade() then
    value = value + self._cfg_grade[attr]
  end
  local el = self:GetEquipCfg()
  if el ~= nil then
    value = value + el[attr]
  end
  local equipRefine = self:GetEquipRefineCfg()
  if equipRefine ~= nil then
    value = value + equipRefine[attr]
  end
  return value
end

function MatchPet:NoBreak_Attack()
  return self:getAttWithoutBreak("Attack")
end

function MatchPet:NoBreak_Defence()
  return self:getAttWithoutBreak("Defence")
end

function MatchPet:NoBreak_Health()
  return self:getAttWithoutBreak("Health")
end

function MatchPet:IsBreakFull()
  return self:GetPetAwakening() >= self:GetPetStar()
end

function MatchPet:CanPetBreak()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local stage = self:GetPetAwakening()
  local matCfg = self:GetAwakeningConfig()
  local maxStage = self:GetMaxAwakening()
  self._isHightLevelPet = false
  self._firstBreak = 0
  if stage >= maxStage or #matCfg <= 3 then
    return false, 0
  end
  local curMat = matCfg[stage + 1].NeedItem
  local mats = {}
  for i = 1, #curMat do
    local value = curMat[i]
    local content = string.split(value, ",")
    local mat = {}
    mat.id = tonumber(content[1])
    mat.count = tonumber(content[2])
    mats[#mats + 1] = mat
  end
  if mats[2] and mats[2].id == 3801001 then
    return false, 0
  end
  if self:GetPetStar() >= 5 then
    self._isHightLevelPet = true
    for i = 1, #matCfg do
      local value = matCfg[i].NeedItem
      if #value == 2 then
        self._firstBreak = i
        break
      end
    end
  end
  
  local function addItemFun(tab, item)
    if not tab then
      return
    end
    for index, value in ipairs(tab) do
      if value.id == item.id then
        value.count = value.count + item.count
        return
      end
    end
    local newItem = {}
    newItem.id = item.id
    newItem.count = item.count
    table.insert(tab, newItem)
  end
  
  self._totleUseItems = {}
  if stage < self._firstBreak and self._isHightLevelPet then
    for i = stage + 1, self._firstBreak do
      local needItem = matCfg[i].NeedItem
      for i = 1, #needItem do
        local value = needItem[i]
        local content = string.split(value, ",")
        local item = {}
        item.id = tonumber(content[1])
        item.count = tonumber(content[2])
        addItemFun(self._totleUseItems, item)
      end
    end
  end
  if stage < self._firstBreak and self._isHightLevelPet then
    local needNum1 = itemModule:GetItemCount(self._totleUseItems[1].id)
    local needNum2 = itemModule:GetItemCount(self._totleUseItems[2].id)
    return needNum1 >= self._totleUseItems[1].count and needNum2 >= self._totleUseItems[2].count, needNum2
  end
  local needNum1 = itemModule:GetItemCount(mats[1].id)
  local needNum2 = itemModule:GetItemCount(mats[2].id)
  if needNum1 >= mats[1].count and needNum2 >= mats[2].count then
    return true, needNum2
  else
    return false, 0
  end
end

function MatchPet:IsShowRedPoint()
  local petID = self:GetTemplateID()
  local stage = self:GetPetAwakening()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local canBreak, needNum2 = self:CanPetBreak()
  local key = openID .. petID .. needNum2 .. stage
  if stage < self._firstBreak and self._isHightLevelPet then
    needNum2 = 1
    key = openID .. petID .. needNum2 .. self._firstBreak .. "New"
  end
  if canBreak then
    if LocalDB.GetInt(key) == 2 then
      return false
    end
    LocalDB.SetInt(key, 1)
    return true
  else
    return false
  end
end

function MatchPet:CancelRedPoint()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local petID = self:GetTemplateID()
  local stage = self:GetPetAwakening()
  local matCfg = self:GetAwakeningConfig()
  local maxStage = self:GetMaxAwakening()
  if stage >= maxStage or #matCfg <= 3 then
    return
  end
  local needNum2 = 0
  if stage < self._firstBreak and self._isHightLevelPet then
    local useNum1 = itemModule:GetItemCount(self._totleUseItems[1].id)
    local useNum2 = itemModule:GetItemCount(self._totleUseItems[2].id)
    local canRed = useNum1 >= self._totleUseItems[1].count and useNum2 >= self._totleUseItems[2].count
    if not canRed then
      return
    end
    needNum2 = 1
  else
    local curMat = matCfg[stage + 1].NeedItem
    local mats = {}
    for i = 1, #curMat do
      local value = curMat[i]
      local content = string.split(value, ",")
      local mat = {}
      mat.id = tonumber(content[1])
      mat.count = tonumber(content[2])
      mats[#mats + 1] = mat
    end
    needNum2 = itemModule:GetItemCount(mats[2].id)
  end
  local key = openID .. petID .. needNum2 .. stage
  if stage < self._firstBreak and self._isHightLevelPet then
    key = openID .. petID .. needNum2 .. self._firstBreak .. "New"
  end
  LocalDB.SetInt(key, 2)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CheckCardAwakeRedPoint)
end

function MatchPet:IsShowSkinRedPoint()
  local petModule = GameGlobal.GetModule(PetModule)
  local petId = self:GetTemplateID()
  local petSkinCfg = Cfg.cfg_pet_skin({PetId = petId})
  local skinsStateData = petModule:GetPetSkinsData(petId)
  for idx, skinCfg in ipairs(petSkinCfg) do
    local uiSkinData = DPetSkinDetailCard:New(skinCfg)
    uiSkinData:SetIsTipsDetail(true)
    local is_obtain = false
    uiSkinData:SetIsCurrentSkin(false)
    if skinsStateData then
      local obtainedSkinInfo = skinsStateData.skin_info
      if obtainedSkinInfo then
        for _, skinInfo in pairs(obtainedSkinInfo) do
          if skinInfo and skinInfo.skin_id == skinCfg.id then
            is_obtain = true
            uiSkinData:SetUnlockCg(skinInfo.unlock_CG)
            break
          end
        end
      end
    end
    uiSkinData:SetObtained(is_obtain)
    local storyId = uiSkinData.cfg.StoryId
    if is_obtain and not uiSkinData:IsUnlockCg() and storyId then
      return true
    end
  end
  return false
end

function MatchPet:GetChainMoveEffect()
  local realSkinId = 0
  if MatchPet.IsEffectByPetSkin(PetSkinEffectPath.MODEL_INGAME) and self._data.current_skin and self._data.current_skin > 1 then
    realSkinId = self._data.current_skin
  end
  if realSkinId == 0 then
    local petCfg = self._cfg_pet
    realSkinId = petCfg.SkinId
  end
  local cfg = Cfg.cfg_pet_skin[realSkinId]
  if not cfg then
    return nil
  end
  return cfg.MoveEffect
end

function MatchPet:GetFeatureList()
  return self._featureList
end

function MatchPet:IsBinderPet(petid)
  local cfg = Cfg.cfg_pet({})
  if cfg then
    if petid == self:GetTemplateID() then
      return
    end
    local cfg_a = cfg[self:GetTemplateID()]
    if not cfg_a then
      Log.error("###[MatchPet] cfg_a is nil ! id --> ", self:GetTemplateID())
      return
    end
    local binderID = cfg_a.BinderPetID
    if binderID and binderID == petid then
      return true
    end
    local cfg_b = cfg[petid]
    if not cfg_b then
      Log.error("###[MatchPet] cfg_b is nil ! id --> ", petid)
      return
    end
    local binderID = cfg_b.BinderPetID
    if binderID and binderID == self:GetTemplateID() then
      return true
    end
  end
  return false
end

function MatchPet:GetEquipRefineCfg(level)
  if level == nil then
    level = self:GetEquipRefineLv()
    if level == nil then
      return nil
    end
  end
  if level <= 0 then
    return nil
  end
  local cfgid = self:GetTemplateID()
  return self._EquipRefineRes:GetRes(cfgid, level)
end

function MatchPet:GetEquipRefineIntensifyParams()
  local res = self:GetEquipRefineCfg()
  if res then
    return res.elementParam
  else
  end
  return nil
end

function MatchPet:GetEquipRefineBuffListData()
  local res = self:GetEquipRefineCfg()
  if res then
    return res.BuffID
  end
end

function MatchPet:GetPetExtraChainSkillList()
  local res = self:GetEquipRefineCfg()
  if res then
    return res.ExtraChainSkill
  end
end

function MatchPet:GetEquipRefineExtraActiveSkill()
  local res = self:GetEquipRefineCfg()
  if res then
    return res.ExtraActiveSkill
  end
end

function MatchPet:GetEquipRefineFeatureList()
  local res = self:GetEquipRefineCfg()
  if res then
    return res.FeatureList
  end
end

function MatchPet:GetEquipRefineVariantActiveSkillInfo()
  local res = self:GetEquipRefineCfg()
  if res then
    return res.VariantActiveSkillInfo
  end
end

function MatchPet:GetPetSupplyPieceWeights()
  return self._cfg_pet.SupplyPieceWeight
end

local PetSkinEffectPath = {
  NO_EFFECT = 0,
  HEAD_ICON_INGAME = 1,
  HEAD_ICON_CHAIN_SKILL_PREVIEW = 2,
  HEAD_ICON_CHANGE_ASSIST = 3,
  HEAD_ICON_WE_CHAT = 4,
  HEAD_ICON_DISPATCH = 5,
  HEAD_ICON_AIR_STORY_TIPS = 6,
  HEAD_ICON_CHAT_FIREND = 7,
  HEAD_ICON_PLAYER_INFO_HELP = 8,
  BODY_PET_DETAIL = 9,
  BODY_LEVLE_UP = 10,
  BODY_GRADE = 11,
  BODY_AWAKE = 12,
  BODY_INTO_AIRCRAFT = 13,
  BODY_HELP = 14,
  BODY_INGAME_PREVIEW = 15,
  BODY_CHANGE_ASSIST = 16,
  BODY_FILES = 17,
  BODY_BATTLE_RESULT = 18,
  CARD_PET_LIST = 19,
  CARD_TEAM = 20,
  CARD_TEAM_SELECT = 21,
  CARD_ROLE_RELATION = 22,
  CARD_TOWER = 23,
  CARD_DISPATCH = 24,
  CARD_TEAM_MOVE_HELP_PET = 25,
  CARD_HELP_MANAGER = 26,
  CARD_HELP_SELECT = 27,
  CARD_DRAW_MULTI = 28,
  CARD_TOWER_TEAM_BODY = 29,
  CARD_CARD_WE_CHAT_ROLE = 30,
  MODEL_INGAME = 31,
  MODEL_AIRCRAFT = 32,
  BODY_AIRCRAFT_ROOM_INTERACT = 33,
  BODY_PET_INTIMACY = 34,
  BODY_INTO_AIRCRAFT_AIRBODY = 35,
  BODY_INGAME_TEAM = 36,
  HEAD_AIRCRAFT_INTERACT = 37,
  HEAD_ICON_PET_INTIMACY = 38,
  HEAD_ICON_STORY = 39,
  ITEM_ICON_PET_DETAIL = 40,
  ITEM_ICON_PET_INTIMACY = 41,
  ITEM_ICON_HELP = 42,
  MODEL_MAZE = 43
}
_enum("PetSkinEffectPath", PetSkinEffectPath)
local PetEquipRefineStatus = {
  NO_OPEN = 0,
  OPEN_LOCK = 1,
  UNLOCK = 2
}
_enum("PetEquipRefineStatus", PetEquipRefineStatus)
