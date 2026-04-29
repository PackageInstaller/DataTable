require("component_base")
_class("TalentTreeComponent", ICampaignComponent)
TalentTreeComponent = TalentTreeComponent

function TalentTreeComponent:Constructor()
  self.m_component_info = TalentTreeComponentInfo:New()
end

function TalentTreeComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = TalentTreeComponentInfo:New()
  end
  return self.m_component_info
end

function TalentTreeComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function TalentTreeComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_TALENT_TREE
end

function TalentTreeComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function TalentTreeComponent:HandleOperateTalentTreeSkill(TT, asyncRes, operate_type, skill_type_id, skill_solt_id)
  local request = OperateTalentTreeSkillReq:New()
  request.operate_type = operate_type
  request.skill_type_id = skill_type_id
  request.skill_solt_id = skill_solt_id
  local response = OperateTalentTreeSkillRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][TalentTreeComponent] HandleOperateTalentTreeSkill ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.m_talent_info = response.m_talent_info
  return response.ret
end

function TalentTreeComponent:HaveRedPoint()
  if not self:ComponentIsOpen() then
    return false
  end
  if self.m_component_info then
    local comCfgID = self:GetComponentCfgId()
    local cfgs = Cfg.cfg_component_talent_tree_skill({
      ComponentID = comCfgID,
      Type = 1,
      Level = 1
    })
    self._passiveList = {}
    for i = 1, #cfgs do
      table.insert(self._passiveList, cfgs[i])
    end
    table.sort(self._passiveList, function(a, b)
      return a.OrderId < b.OrderId
    end)
    for i = 1, #self._passiveList do
      local passid = self._passiveList[i].SkillTypeID
      local succ_p = self:CheckSkillCanUpLv(passid)
      if succ_p then
        return true
      end
      local childList = self._passiveList[i].ChildSkill
      for j = 1, #childList do
        local childid = childList[j]
        local succ = self:CheckSkillCanUpLv(childid)
        if succ then
          return true
        end
      end
    end
  end
  return false
end

function TalentTreeComponent:CheckSkillCanUpLv(rootid)
  local info = self.m_component_info.m_talent_info
  local skillInfo = info.m_skill_list
  if skillInfo[rootid] then
    local level = skillInfo[rootid]
    local maxLv = self:GetSkillMaxLv(rootid)
    if level >= maxLv then
      return false
    else
      local enough = self:CheckUpLvEnough(rootid, level)
      if enough then
        return true
      else
        return false
      end
    end
  else
    local unlock = self:CheckRootUnLock(rootid)
    if unlock then
      local cfg = self:GetRootIDCfg(rootid)
      local buyCost = cfg.Price[2]
      local haveCount = self:GetItemHaveCount(cfg.Price[1])
      return buyCost <= haveCount
    else
      return false
    end
  end
end

function TalentTreeComponent:CheckRootUnLock(rootid)
  local type = self:GetRootIDType(rootid)
  if type == 1 then
    local preid = self:GetPreParentID(rootid)
    if preid then
      local preLv = self:GetRoorIDLv(preid)
      if preLv and 0 < preLv then
        local needCost = self:GetRootIDNeedCost(rootid)
        local preCost = self:GetPreCost(rootid)
        return needCost <= preCost
      else
        return false
      end
    else
      return true
    end
  else
    local parentid = self:GetParentRootID(rootid)
    local lv = self:GetRoorIDLv(parentid)
    if lv and 0 < lv then
      return true
    end
    return false
  end
end

function TalentTreeComponent:GetPreCost(rootid)
  local preCost = 0
  for index, value in ipairs(self._passiveList) do
    if value.SkillTypeID == rootid then
      return preCost
    else
      local t_pre_cost = self:GetRootIDCost(value.SkillTypeID)
      preCost = preCost + t_pre_cost
    end
  end
  return preCost
end

function TalentTreeComponent:GetRootIDCost(rootid)
  local info = self.m_component_info.m_talent_info
  local costInfo = info.m_skill_cost
  return costInfo[rootid] or 0
end

function TalentTreeComponent:GetPreParentID(rootid)
  local preid
  for index, value in ipairs(self._passiveList) do
    if value.SkillTypeID == rootid then
      return preid
    else
      preid = value.SkillTypeID
    end
  end
  return preid
end

function TalentTreeComponent:GetRootIDNeedCost(rootid)
  local cfg = self:GetRootIDCfg(rootid)
  return cfg.NeedCost
end

function TalentTreeComponent:GetRoorIDLv(rootid)
  local info = self.m_component_info.m_talent_info
  local skillInfo = info.m_skill_list
  if skillInfo[rootid] then
    return skillInfo[rootid]
  end
  return nil
end

function TalentTreeComponent:GetSkillMaxLv(rootid)
  local comCfgID = self:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_talent_tree_skill({ComponentID = comCfgID, SkillTypeID = rootid})
  return #cfgs
end

function TalentTreeComponent:CheckUpLvEnough(rootid, currLv)
  local comCfgID = self:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = comCfgID,
    SkillTypeID = rootid,
    Level = currLv + 1
  })
  local cfg = cfgs[1]
  local cost = cfg.UpgradeCost
  local haveCount = self:GetItemHaveCount(cfg.CostItemId)
  return cost <= haveCount
end

function TalentTreeComponent:GetItemHaveCount(costid)
  local haveCount = GameGlobal.GetModule(ItemModule):GetItemCount(costid)
  return haveCount
end

function TalentTreeComponent:GetRootIDType(rootid)
  local comCfgID = self:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = comCfgID,
    SkillTypeID = rootid,
    Level = 1
  })
  return cfgs[1].Type
end

function TalentTreeComponent:GetRootIDCfg(rootid)
  local comCfgID = self:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = comCfgID,
    SkillTypeID = rootid,
    Level = 1
  })
  return cfgs[1]
end

function TalentTreeComponent:GetParentRootID(rootid)
  for index, value in ipairs(self._passiveList) do
    local childList = value.ChildSkill
    for idx, val in ipairs(childList) do
      if val == rootid then
        return value.SkillTypeID
      end
    end
  end
  return nil
end

function TalentTreeComponent:GetAllCanCostLevelItemCount()
  local allCanCostList = {}
  if self.m_component_info then
    local comCfgID = self:GetComponentCfgId()
    local cfgs = Cfg.cfg_component_talent_tree_skill({
      ComponentID = comCfgID,
      Type = 1,
      Level = 1
    })
    self._passiveList = {}
    for i = 1, #cfgs do
      table.insert(self._passiveList, cfgs[i])
    end
    table.sort(self._passiveList, function(a, b)
      return a.OrderId < b.OrderId
    end)
    for i = 1, #self._passiveList do
      local passid = self._passiveList[i].SkillTypeID
      local succ_p, costInfo = self:CheckSkillIsUpLv(passid)
      if succ_p then
        if allCanCostList[costInfo[1]] == nil then
          allCanCostList[costInfo[1]] = {}
        end
        table.insert(allCanCostList[costInfo[1]], costInfo)
      end
      local childList = self._passiveList[i].ChildSkill
      for j = 1, #childList do
        local childid = childList[j]
        local succ, costInfo = self:CheckSkillIsUpLv(childid)
        if succ then
          if allCanCostList[costInfo[1]] == nil then
            allCanCostList[costInfo[1]] = {}
          end
          table.insert(allCanCostList[costInfo[1]], costInfo)
        end
      end
    end
  end
  return allCanCostList
end

function TalentTreeComponent:CheckSkillIsUpLv(rootId)
  local info = self.m_component_info.m_talent_info
  local skillInfo = info.m_skill_list
  if skillInfo[rootId] then
    local level = skillInfo[rootId]
    local maxLv = self:GetSkillMaxLv(rootId)
    local comCfgID = self:GetComponentCfgId()
    if level < maxLv then
      local cfgs = Cfg.cfg_component_talent_tree_skill({
        ComponentID = comCfgID,
        SkillTypeID = rootId,
        Level = level + 1
      })
      local cfg = cfgs[1]
      return level < maxLv, {
        cfg.CostItemId,
        cfg.UpgradeCost
      }
    else
      return level < maxLv, {}
    end
  else
    local unlock = self:CheckRootUnLock(rootId)
    if unlock then
      local cfg = self:GetRootIDCfg(rootId)
      local buyCost = cfg.Price[2]
      local haveCount = self:GetItemHaveCount(cfg.Price[1])
      return buyCost <= haveCount, {
        cfg.Price[1],
        cfg.Price[2]
      }
    else
      return false, {}
    end
  end
end
