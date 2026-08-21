function N25Data:GetComponentId()
  return ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER
end

function N25Data:GetComponentCfgId()
  local c = self:GetComponentVampire()
  return c:GetComponentCfgId()
end

function N25Data:GetComponentVampire()
  local c = self.activityCampaign:GetComponent(self:GetComponentId())
  return c
end

function N25Data:GetComponentInfoVampire()
  local cInfo = self.activityCampaign:GetComponentInfo(self:GetComponentId())
  return cInfo
end

function N25Data:GetTalentTreeInfo()
  local cInfo = self:GetComponentInfoVampire()
  return cInfo.talent_info
end

function N25Data:GetCfgComponentBloodsuckerTalentSkill()
  local cfgs = Cfg.cfg_component_bloodsucker_talent_skill({
    ComponentID = self:GetComponentCfgId()
  })
  return cfgs
end

function N25Data:GetCfgComponentBloodsuckerTalentLevel()
  local cfgs = Cfg.cfg_component_bloodsucker_talent_level({
    ComponentID = self:GetComponentCfgId()
  })
  return cfgs
end

function N25Data.CheckCode(res)
  local result = res:GetResult()
  if result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    return true
  end
  ToastManager.ShowToast(StringTable.Get("str_activity_error_" .. result))
  if result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED or result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  elseif result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIActivityN25MainController)
  end
  return false
end

function N25Data:InitVampire()
  self:InitVampirePets()
  self:InitVampireTiers()
end

function N25Data:InitVampirePets()
  self.pets = {}
  local petIds = UIN25VampireUtil.GetTryPetList(self:GetComponentCfgId()) or {}
  for index, petId in ipairs(petIds) do
    local pet = VampirePet:New(petId)
    table.insert(self.pets, pet)
  end
end

function N25Data:InitVampireTiers()
  self.tiers = {}
  local talentTreeInfo = self:GetTalentTreeInfo()
  local leftTalent = self:GetTalentLeft()
  local cfgs = self:GetCfgComponentBloodsuckerTalentSkill()
  local prevTier
  for key, cfgv in pairs(cfgs) do
    local tier = VampireTalentTier:New()
    tier.id = cfgv.ID
    tier.row = cfgv.Row
    tier.unlockTalent = cfgv.NeedTalentPoint or 0
    local info = talentTreeInfo.infos[cfgv.Row]
    tier.skills = {}
    for i, cfgvSkill in ipairs(cfgv.Skill) do
      local skill = VampireTalentSkill:New()
      skill.skillType = cfgvSkill[1] == 0 and VampireTalentSkillType.Talent or VampireTalentSkillType.Role
      local skillId = cfgvSkill[2]
      skill.skillId = skillId
      skill.index = i - 1
      if info then
        local skillNode = info.skill_nodes[skill.index]
        if skillNode then
          skill.level = skillNode.level
        end
      end
      skill.maxLevel = cfgvSkill[3]
      tier.prev = prevTier
      prevTier = tier
      table.insert(tier.skills, skill)
    end
    if cfgv.RelicId then
      tier.relic = VampireTalentRelic:New(cfgv.RelicId)
    end
    table.insert(self.tiers, tier)
  end
end

function N25Data:GetPetByTplId(tplId)
  for index, pet in ipairs(self.pets) do
    if pet:TplId() == tplId then
      return pet
    end
  end
end

function N25Data:GetVimpireEndTime()
  local cInfo = self:GetComponentInfoVampire()
  return cInfo.m_close_time
end

function N25Data:GetTalentLevelExp()
  local talentTreeInfo = self:GetTalentTreeInfo()
  local talent_level = talentTreeInfo.talent_level
  local upgradeExp = 0
  local cfg = self:GetCfgComponentBloodsuckerTalentLevel()
  if cfg then
    for key, cfgv in pairs(cfg) do
      if cfgv.Level == talent_level then
        upgradeExp = cfgv.Exp
        break
      end
    end
  end
  return talent_level, talentTreeInfo.cur_exp, upgradeExp
end

function N25Data:GetTierById(id)
  for index, tier in ipairs(self.tiers) do
    if tier.id == id then
      return tier
    end
  end
end

function N25Data:GetTierBySkillId(skillId)
  for _, tier in ipairs(self.tiers) do
    for _, skill in ipairs(tier.skills) do
      if skill.skillId == skillId then
        return tier
      end
    end
  end
end

function N25Data:GetTierByRow(row)
  for index, tier in ipairs(self.tiers) do
    if tier.row == row then
      return tier
    end
  end
end

function N25Data:GetSkillBySkillId(skillId)
  for index, tier in ipairs(self.tiers) do
    for index, skill in ipairs(tier.skills) do
      if skill.skillId == skillId then
        return skill
      end
    end
  end
end

function N25Data:GetRoleSkills()
  local t = {}
  for index, tier in ipairs(self.tiers) do
    for index, skill in ipairs(tier.skills) do
      if skill.skillType == VampireTalentSkillType.Role then
        table.insert(t, skill)
      end
    end
  end
  return t
end

function N25Data:GetFstRoleSkill()
  for index, tier in ipairs(self.tiers) do
    for index, skill in ipairs(tier.skills) do
      if skill.skillType == VampireTalentSkillType.Role then
        return skill
      end
    end
  end
end

function N25Data:GetCurRoleSkill()
  local talentTreeInfo = self:GetTalentTreeInfo()
  local row = talentTreeInfo.select_row
  local index = talentTreeInfo.select_index
  for _, tier in ipairs(self.tiers) do
    if row == tier.row then
      for _, skill in ipairs(tier.skills) do
        if index == skill.index then
          return skill
        end
      end
    end
  end
end

function N25Data:IsRoleSkillActive()
  for index, tier in ipairs(self.tiers) do
    if tier:IsLock() then
      break
    end
    for index, skill in ipairs(tier.skills) do
      if skill.skillType == VampireTalentSkillType.Role and skill.level > 0 then
        return true
      end
    end
  end
  return false
end

function N25Data:GetSkillRowIndexBySkillId(skillId)
  for _, tier in ipairs(self.tiers) do
    for _, skill in ipairs(tier.skills) do
      if skill.skillId == skillId then
        return tier.row, skill.index
      end
    end
  end
end

function N25Data:GetTalentUsed()
  local used = 0
  for _, tier in ipairs(self.tiers) do
    for _, skill in ipairs(tier.skills) do
      used = used + skill.level
    end
  end
  return used
end

function N25Data:GetTalentLeft()
  local talentTreeInfo = self:GetTalentTreeInfo()
  return talentTreeInfo.cur_talent_point
end

function N25Data:CheckRedTalentTree()
  local talent = self:GetTalentLeft()
  return 0 < talent
end

_class("VampireTalentTier", Object)
VampireTalentTier = VampireTalentTier

function VampireTalentTier:Constructor()
  local mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = mCampaign:GetN25Data()
end

function VampireTalentTier:IsLock()
  if self.row == 1 then
    return false
  end
  local isUnlock = false
  local tiers = self.data.tiers
  local prevCost = 0
  for i, tier in ipairs(tiers) do
    if tier.row >= self.row then
      break
    end
    local tierCostPoint = tier:GetTotalSkillLevel()
    prevCost = prevCost + tierCostPoint
  end
  local costGECur = prevCost >= self.unlockTalent
  if self:IsPrevTierExistSkills(self.row) then
    if costGECur and 0 < self:GetPrevTierCost(self.row) then
      isUnlock = true
    end
  elseif costGECur then
    isUnlock = true
  end
  return not isUnlock
end

function VampireTalentTier:GetTotalSkillLevel()
  local level = 0
  for index, skill in ipairs(self.skills) do
    level = level + skill.level
  end
  return level
end

function VampireTalentTier:GetPrevTier(row)
  if row <= 1 then
    return nil
  end
  local tier = self.data:GetTierByRow(row - 1)
  return tier
end

function VampireTalentTier:IsPrevTierExistSkills(row)
  local tier = self:GetPrevTier(row)
  if tier and tier.skills and table.count(tier.skills) > 0 then
    return true
  end
  return false
end

function VampireTalentTier:GetPrevTierCost(row)
  local tier = self:GetPrevTier(row)
  if tier then
    return tier:GetTotalSkillLevel()
  end
  return 0
end

_class("VampireTalentSkill", Object)
VampireTalentSkill = VampireTalentSkill

function VampireTalentSkill:Constructor()
  self.level = 0
end

function VampireTalentSkill:IconNameDesc()
  local cfgv = Cfg.cfg_mini_maze_talent[self.skillId]
  if not cfgv then
    Log.fatal("### no data in cfg_mini_maze_talent.", self.skillId)
    return
  end
  return cfgv.Icon, StringTable.Get(cfgv.Name), StringTable.Get(cfgv.Desc)
end

function VampireTalentSkill:CurMaxLevel()
  return self.level, self.maxLevel
end

function VampireTalentSkill:IsActive()
  return self.level > 0
end

function VampireTalentSkill:IsLevelMax()
  return self.level >= self.maxLevel
end

_enum("VampireTalentSkillType", {Talent = 0, Role = 1})
VampireTalentSkillType = VampireTalentSkillType
_class("VampireTalentRelic", Object)
VampireTalentRelic = VampireTalentRelic

function VampireTalentRelic:Constructor(itemId)
  self.itemId = itemId
end

function VampireTalentRelic:GetItemCfg()
  local cfgv = Cfg.cfg_item[self.itemId]
  if not cfgv then
    Log.fatal("### no data in cfg_item", self.itemId)
    return
  end
  return cfgv
end

function VampireTalentRelic:IconNameDesc()
  local cfg = self:GetItemCfg()
  if cfg then
    return cfg.Icon, StringTable.Get(cfg.Name), StringTable.Get(cfg.Intro)
  end
end

_class("VampirePet", Object)
VampirePet = VampirePet

function VampirePet:Constructor(tplId)
  self.tplId = tplId
end

function VampirePet:TplId()
  return self.tplId
end

function VampirePet:CfgPet()
  local cfgv = Cfg.cfg_pet[self.tplId]
  if not cfgv then
    Log.fatal("### no data in cfg_pet", self.tplId)
  end
  return cfgv
end

function VampirePet:Icon()
  local cfgv = self:CfgPet()
  local icon = HelperProxy:GetInstance():GetPetTeamBody(self:TplId())
  return icon
end
