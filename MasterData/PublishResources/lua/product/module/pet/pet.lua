require("match_pet")
_class("Pet", MatchPet)
Pet = Pet

function Pet:Constructor(data)
  Pet.super.Constructor(self, data)
end

function Pet:GetPetAirRoom()
  local airMD = GameGlobal.GetModule(AircraftModule)
  local room = airMD:GetPetAirRoom(self)
  return room
end

function Pet:GetPetAttack()
  return self:getAttr("Attack")
end

function Pet:GetPetDefence()
  return self:getAttr("Defence")
end

function Pet:GetPetHealth()
  return self:getAttr("Health")
end

function Pet:GetSkinId()
  if self._data.current_skin then
    return self._data.current_skin
  end
  local skinId = 0
  local petModule = GameGlobal.GetModule(PetModule)
  if petModule then
    skinId = petModule:GetCurrentSkinId(self:GetTemplateID())
  end
  if 1 < skinId then
    return skinId
  end
  if self:GetPetGrade() == 0 then
    skinId = self._cfg_pet.SkinId
  else
    skinId = self._cfg_grade.SkinId
  end
  return skinId or 1
end

function Pet:GetUpgradeChangeWithSkillIDNew()
  local grade = self:GetPetGrade()
  if grade >= self:GetMaxGrade() then
    return nil
  end
  local next_grade_skills = self:GetSkillsByGrade(grade + 1)
  local cur_grade_skills = self:GetSkillsByGrade(grade)
  local change_data = {
    active = {},
    extra = {},
    chain = {},
    work = {},
    passive = {},
    body = {}
  }
  local activeChangeData
  if cur_grade_skills.active_skill ~= next_grade_skills.active_skill then
    local from = {
      cur_grade_skills.active_skill
    }
    local to = {
      next_grade_skills.active_skill
    }
    activeChangeData = UIFightSkillChangeData:New("active", PetSkillChangeState.Improved, from, to)
  else
    local from = {
      cur_grade_skills.active_skill
    }
    local to = {
      next_grade_skills.active_skill
    }
    local awaken = self:GetPetAwakening()
    local lastCfg = self:GetPetVariantActiveSkill(grade, awaken)
    local nextCfg = self:GetPetVariantActiveSkill(grade + 1, awaken)
    if not lastCfg and not nextCfg then
      activeChangeData = UIFightSkillChangeData:New("active", PetSkillChangeState.NoChange, from, to)
    elseif not lastCfg and nextCfg then
      activeChangeData = UIFightSkillChangeData:New("active", PetSkillChangeState.Improved, from, to, {}, nextCfg)
    elseif lastCfg and nextCfg then
      local var_last = lastCfg[cur_grade_skills.active_skill]
      local var_next = nextCfg[next_grade_skills.active_skill]
      local diff = table.getTableDiffIndex(var_last, var_next)
      if diff then
        activeChangeData = UIFightSkillChangeData:New("active", PetSkillChangeState.Improved, from, to, lastCfg, nextCfg)
      else
        activeChangeData = UIFightSkillChangeData:New("active", PetSkillChangeState.NoChange, from, to)
      end
    else
      activeChangeData = UIFightSkillChangeData:New("active", PetSkillChangeState.NoChange, from, to)
    end
  end
  change_data.active = activeChangeData
  local extraChangeData
  if cur_grade_skills.extra_skill ~= next_grade_skills.extra_skill then
    if cur_grade_skills.extra_skill == 0 then
      extraChangeData = UIFightSkillChangeData:New("extra", PetSkillChangeState.NewGain, {
        cur_grade_skills.extra_skill
      }, {
        next_grade_skills.extra_skill
      })
    else
      extraChangeData = UIFightSkillChangeData:New("extra", PetSkillChangeState.Improved, {
        cur_grade_skills.extra_skill
      }, {
        next_grade_skills.extra_skill
      })
    end
  else
    extraChangeData = UIFightSkillChangeData:New("extra", PetSkillChangeState.NoChange, {
      cur_grade_skills.extra_skill
    }, {
      next_grade_skills.extra_skill
    })
  end
  change_data.extra = extraChangeData
  local bodyChangeData
  if cur_grade_skills.body ~= next_grade_skills.body then
    bodyChangeData = UIFightSkillChangeData:New("body", PetSkillChangeState.NewGain, {
      cur_grade_skills.body
    }, {
      next_grade_skills.body
    })
  else
    bodyChangeData = UIFightSkillChangeData:New("body", PetSkillChangeState.NoChange, {
      cur_grade_skills.body
    }, {
      next_grade_skills.body
    })
  end
  change_data.body = bodyChangeData
  local chainChangeData
  if #cur_grade_skills.chain_skills ~= #next_grade_skills.chain_skills then
    chainChangeData = UIFightSkillChangeData:New("chain", PetSkillChangeState.NewGain, cur_grade_skills.chain_skills, next_grade_skills.chain_skills)
  else
    local same = true
    for i = 1, #cur_grade_skills.chain_skills do
      local val_a = cur_grade_skills.chain_skills[i]
      local val_b = next_grade_skills.chain_skills[i]
      if val_a ~= val_b then
        same = false
        break
      end
    end
    if same then
      chainChangeData = UIFightSkillChangeData:New("chain", PetSkillChangeState.NoChange, cur_grade_skills.chain_skills, next_grade_skills.chain_skills)
    else
      chainChangeData = UIFightSkillChangeData:New("chain", PetSkillChangeState.Improved, cur_grade_skills.chain_skills, next_grade_skills.chain_skills)
    end
  end
  change_data.chain = chainChangeData
  local workChangeData
  if #cur_grade_skills.work_skills ~= #next_grade_skills.work_skills then
    workChangeData = UIFightSkillChangeData:New("work", PetSkillChangeState.NewGain, cur_grade_skills.work_skills, next_grade_skills.work_skills)
  else
    local same = true
    for i = 1, #cur_grade_skills.work_skills do
      local val_a = cur_grade_skills.work_skills[i]
      local val_b = next_grade_skills.work_skills[i]
      if val_a ~= val_b then
        same = false
        break
      end
    end
    if same then
      workChangeData = UIFightSkillChangeData:New("work", PetSkillChangeState.NoChange, cur_grade_skills.work_skills, next_grade_skills.work_skills)
    else
      workChangeData = UIFightSkillChangeData:New("work", PetSkillChangeState.Improved, cur_grade_skills.work_skills, next_grade_skills.work_skills)
    end
  end
  change_data.work = workChangeData
  local passiveChangeData
  if cur_grade_skills.passive_skills ~= next_grade_skills.passive_skills then
    if cur_grade_skills.passive_skills == 0 then
      passiveChangeData = UIFightSkillChangeData:New("passive", PetSkillChangeState.NewGain, {
        cur_grade_skills.passive_skills
      }, {
        next_grade_skills.passive_skills
      })
    else
      passiveChangeData = UIFightSkillChangeData:New("passive", PetSkillChangeState.Improved, {
        cur_grade_skills.passive_skills
      }, {
        next_grade_skills.passive_skills
      })
    end
  else
    passiveChangeData = UIFightSkillChangeData:New("passive", PetSkillChangeState.NoChange, {
      cur_grade_skills.passive_skills
    }, {
      next_grade_skills.passive_skills
    })
  end
  change_data.passive = passiveChangeData
  return change_data
end

function Pet:FastTeamMemID()
  return self._fastTeamMemID
end

function Pet:SetFastTeamMemID(memId)
  self._fastTeamMemID = memId
end

function Pet:GetAwakeMatch()
  return self._data.awake_lock > 0 and self._data.awake_lock or self._data.awakening
end

_class("UIFightSkillChangeData", Object)
UIFightSkillChangeData = UIFightSkillChangeData

function UIFightSkillChangeData:Constructor(type, changeType, from, to, fParam, tParam)
  self.type = type
  self.changeType = changeType
  self.from = from
  self.to = to
  self.fromParam = fParam
  self.toParam = tParam
end
