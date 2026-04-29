_class("CN20N49Tree_Skill", Object)
CN20N49Tree_Skill = CN20N49Tree_Skill

function CN20N49Tree_Skill:Constructor(rootid, type, lock, canBuy, level, using, costCount, comCfgId)
  self.rootid = rootid
  self.type = type
  self.lock = lock
  self.canBuy = canBuy
  self.level = level
  self.using = using
  self.costCount = costCount
  self.comCfgId = comCfgId
end

function CN20N49Tree_Skill:GetSkillType()
  return self.type
end

function CN20N49Tree_Skill:GetCfg(lv)
  local tempLv
  if lv then
    tempLv = lv
  else
    tempLv = self.level
  end
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = self.comCfgId,
    SkillTypeID = self.rootid,
    Level = tempLv
  })
  return cfgs[1]
end

function CN20N49Tree_Skill:GetLevelMax()
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = self.comCfgId,
    SkillTypeID = self.rootid
  })
  return #cfgs
end

function CN20N49Tree_Skill:Enough()
  if self:LvMax() then
    return nil
  end
  local cfg = self:GetCfg(self.level + 1)
  local costNumber
  if self.level > 0 then
    local costid = cfg.CostItemId
    local haveCount = GameGlobal.GetModule(ItemModule):GetItemCount(costid)
    costNumber = self:GetCfg(self.level + 1).UpgradeCost
    return haveCount >= costNumber
  else
    local priceId = cfg.Price[1]
    local priceCount = GameGlobal.GetModule(ItemModule):GetItemCount(priceId)
    costNumber = self:GetCfg(1).Price[2]
    return priceCount >= costNumber
  end
end

function CN20N49Tree_Skill:LvMax()
  local lvMax = self:GetLevelMax()
  return lvMax <= self.level
end

_class("CN20N49Tree_SkillCfg", Object)
CN20N49Tree_SkillCfg = CN20N49Tree_SkillCfg

function CN20N49Tree_SkillCfg:Constructor(com)
  self.talentTreeCom = com
  self._comCfgId = self.talentTreeCom:GetComponentCfgId()
  self.talentTreeComInfo = self.talentTreeCom:GetComponentInfo()
  self._passiveCfgList = {}
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = self._comCfgId,
    Type = SeasonTalentSkillType.Passive,
    Level = 1
  })
  for key, value in pairs(cfgs) do
    table.insert(self._passiveCfgList, value)
  end
  table.sort(self._passiveCfgList, function(a, b)
    return a.OrderId < b.OrderId
  end)
  self._skillDataMap = {}
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = self._comCfgId,
    Level = 1
  })
  for key, value in pairs(cfgs) do
    local rootid = value.SkillTypeID
    local type = self:GetRootIDType(rootid)
    local using = self:GetSkillUsing(rootid)
    local level = self:GetSkillLevel(rootid)
    local costCount = self:GetSkillCostCount(rootid, type)
    local lock = self:GetSkillLock(rootid, type, level, costCount)
    local canBuy = self:GetSkillCanBuy(rootid, lock, type, level)
    local obj = CN20N49Tree_Skill:New(rootid, type, lock, canBuy, level, using, costCount, self._comCfgId)
    self._skillDataMap[rootid] = obj
  end
end

function CN20N49Tree_SkillCfg:PassiveCfgList()
  return self._passiveCfgList
end

function CN20N49Tree_SkillCfg:RootIDMap()
  return self._skillDataMap
end

function CN20N49Tree_SkillCfg:ComCfgID()
  return self._comCfgId
end

function CN20N49Tree_SkillCfg:GetSkillLock(rootid, type, level, costCount)
  local lock = false
  local idx, pre = self:GetSkillIdxAndPreSkill(rootid)
  if type == SeasonTalentSkillType.Passive then
    if idx == 1 then
      lock = false
    else
      local preRoot = pre[#pre]
      local level = self:GetSkillLevel(preRoot)
      if 0 < level then
        lock = false
      else
        lock = true
      end
    end
  else
    local level = self:GetSkillLevel(pre)
    if 0 < level then
      lock = false
    else
      lock = true
    end
  end
  return lock
end

function CN20N49Tree_SkillCfg:GetSkillLevel(rootid)
  local info = self.talentTreeComInfo.m_talent_info
  local level = 0
  if info.m_skill_list[rootid] then
    level = info.m_skill_list[rootid]
  end
  return level
end

function CN20N49Tree_SkillCfg:GetSkillUsing(rootid)
  local info = self.talentTreeComInfo.m_talent_info
  if info.m_skill_solt then
    for key, value in pairs(info.m_skill_solt) do
      if value == rootid then
        return true
      end
    end
  end
  return false
end

function CN20N49Tree_SkillCfg:GetSkillCostCount(rootid, type)
  local costCount
  if type == SeasonTalentSkillType.Passive then
    local info = self.talentTreeComInfo.m_talent_info
    if info.m_skill_cost[rootid] then
      costCount = info.m_skill_cost[rootid]
    else
      costCount = 0
    end
  end
  return costCount
end

function CN20N49Tree_SkillCfg:GetSkillCanBuy(rootid, lock, type, level)
  local maxLv = self:GetRootIDMaxLv(rootid)
  if maxLv and level >= maxLv then
    return false
  end
  if type == SeasonTalentSkillType.Passive then
    local idx, pre = self:GetSkillIdxAndPreSkill(rootid)
    if idx == 1 then
      if self:CheckCostEnough(rootid, level) then
        return true
      else
        return false
      end
    elseif self._skillDataMap[pre[#pre]].level > 0 then
      local allCost = 0
      for index, preRoot in ipairs(pre) do
        local tempCost = self:GetSkillCostCount(preRoot, SeasonTalentSkillType.Passive)
        allCost = allCost + tempCost
      end
      local needCost = self:GetBuyNeedCost(rootid)
      if allCost >= needCost then
        if self:CheckCostEnough(rootid, level) then
          return true
        else
          return false
        end
      else
        return false
      end
    else
      return false
    end
  elseif lock then
    return false
  elseif self:CheckCostEnough(rootid, level) then
    return true
  else
    return false
  end
end

function CN20N49Tree_SkillCfg:CheckCostEnough(rootid, level)
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = self._comCfgId,
    SkillTypeID = rootid,
    Level = level + 1
  })
  local cfg = cfgs[1]
  local costCount
  if level == 0 then
    local priceId = cfg.Price[1]
    local priceCount = GameGlobal.GetModule(ItemModule):GetItemCount(priceId)
    costCount = cfg.Price[2]
    return priceCount >= costCount
  else
    local costid = cfg.CostItemId
    local haveCount = GameGlobal.GetModule(ItemModule):GetItemCount(costid)
    costCount = cfg.UpgradeCost
    return haveCount >= costCount
  end
end

function CN20N49Tree_SkillCfg:GetRootIDType(rootid)
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = self._comCfgId,
    SkillTypeID = rootid,
    Level = 1
  })
  local cfg = cfgs[1]
  return cfg.Type
end

function CN20N49Tree_SkillCfg:GetRootIDMaxLv(rootid)
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = self._comCfgId,
    SkillTypeID = rootid
  })
  return #cfgs
end

function CN20N49Tree_SkillCfg:GetSkillIdxAndPreSkill(rootid)
  local type = self:GetRootIDType(rootid)
  if type == SeasonTalentSkillType.Passive then
    local preList = {}
    for index, value in ipairs(self._passiveCfgList) do
      if value.SkillTypeID ~= rootid then
        table.insert(preList, value.SkillTypeID)
      else
        return index, preList
      end
    end
  else
    for index, value in ipairs(self._passiveCfgList) do
      for index2, childid in ipairs(value.ChildSkill) do
        if childid == rootid then
          return 1, value.SkillTypeID
        end
      end
    end
  end
end

function CN20N49Tree_SkillCfg:GetBuyNeedCost(rootid)
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = self._comCfgId,
    SkillTypeID = rootid,
    Level = 1
  })
  local cfg = cfgs[1]
  return cfg.NeedCost
end
