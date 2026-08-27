local HeroTalentNodeData = class("HeroTalentNodeData")

function HeroTalentNodeData:ctor(heroId, cfg, talentData)
  self._heroId = heroId
  self._nodeCfg = cfg
  self._parent = talentData
  self._treeId = self._nodeCfg.tree_id
  self._effectCfg = ConfigData.hero_talent_effect[self._nodeCfg.effect_id]
  self._level = 0
  self._normalConditionUnlock = false
  self._isUnlock = false
  self._branchSelectId = 0
end

function HeroTalentNodeData:UpdateHeroTalentNodeLevel(level)
  if level > self:GetHeroTalentNodeMaxLevel() then
    error("talent level error")
    level = self:GetHeroTalentNodeMaxLevel()
  end
  self._level = level
  local flag, _ = self:GetHeroTalentNodeBranchId()
  if flag and self._branchSelectId == 0 then
    self._branchSelectId = 1
  end
end

function HeroTalentNodeData:UpdateHeroTalentNodeBranch(branchId)
  local curEffect = self:GetHeroTalentNodeCurLevelEffect()
  if curEffect == nil or curEffect.branch == nil or branchId > #curEffect.branch then
    branchId = 0
  end
  self._branchSelectId = branchId
end

function HeroTalentNodeData:GetHeroTalentNodeCurLevelEffect()
  return self._effectCfg[self._level]
end

function HeroTalentNodeData:GetHeroTalentNodeNexLevelEffect()
  if self._level == self._nodeCfg.max_level then
    return nil
  end
  return self._effectCfg[self._level + 1]
end

function HeroTalentNodeData:IsHeroTalentNodeMaxLevel()
  return self._level >= self._nodeCfg.max_level
end

function HeroTalentNodeData:GetHeroTalentNodeMaxLevel()
  return self._nodeCfg.max_level
end

function HeroTalentNodeData:GetHeroTalentNodeCurLevel()
  return self._level
end

function HeroTalentNodeData:GetHeroTalentNodeHeroId()
  return self._heroId
end

function HeroTalentNodeData:IsHeroTalentNodeUnlock()
  if self._isUnlock then
    return self._isUnlock
  end
  if not self._normalConditionUnlock then
    if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Talent) then
      return false
    end
    if not CheckCondition.CheckLua(self._nodeCfg.pre_condition, self._nodeCfg.pre_para1, self._nodeCfg.pre_para2) then
      return false
    end
  end
  self._normalConditionUnlock = true
  local prePointDic = self:GetHeroTalentNodePreIdLvDic()
  if table.count(prePointDic) == 0 then
    self._isUnlock = true
    return self._isUnlock
  end
  local isParallel = self:IsPrePointParallel()
  local preUnlock = false
  for prePointId, preLeve in pairs(prePointDic) do
    local node = self._parent:GetHeroTalentNodeById(prePointId)
    if node == nil then
      error("prePoint is nil, heroId is " .. tostring(self._heroId) .. " nodeId is " .. tostring(self:GetHeroTalentNodeId()) .. " prePoint is " .. tostring(prePointId))
    else
      local isUnlock = preLeve <= node:GetHeroTalentNodeCurLevel()
      if not isUnlock and not isParallel then
        return false
      elseif isUnlock then
        preUnlock = true
        if isParallel then
          break
        end
      end
    end
  end
  if not preUnlock then
    return false
  end
  self._isUnlock = true
  return self._isUnlock
end

function HeroTalentNodeData:GetHeroTalentNodeLockDesList()
  local list = {}
  local preLvDic = self:GetHeroTalentNodePreIdLvDic()
  for id, lv in pairs(preLvDic) do
    local prePoint = self._parent:GetHeroTalentNodeById(id)
    if prePoint ~= nil then
      local des = LanguageUtil.GetLocaleText(prePoint:GetHeroTalentNodeCfg().name)
      if lv <= 1 then
        des = string.format(ConfigData:GetTipContent(5071), des)
      else
        des = string.format(ConfigData:GetTipContent(5072), des, tostring(lv))
      end
      local unlock = lv <= prePoint:GetHeroTalentNodeCurLevel()
      table.insert(list, {lockReason = des, unlock = unlock})
    end
  end
  local norConditionList = CheckCondition.GetUnlockAndInfoList(self._nodeCfg.pre_condition, self._nodeCfg.pre_para1, self._nodeCfg.pre_para2)
  for i, conditionInfo in ipairs(norConditionList) do
    table.insert(list, {
      lockReason = conditionInfo.lockReason,
      unlock = conditionInfo.unlock
    })
  end
  return list
end

function HeroTalentNodeData:GetHeroTalentNodeLevelupCost()
  if self._nodeCfg.cost_dic == nil then
    return nil, nil
  end
  local cost = self._nodeCfg.cost_dic[self._level + 1]
  if cost == nil then
    return nil, nil
  end
  return cost.itemIds, cost.itemNums
end

function HeroTalentNodeData:GetHeroTalentNodeLevelupReward()
  local cfg = self:GetHeroTalentNodeNexLevelEffect()
  if cfg == nil then
    return nil
  end
  return cfg.rewardIds, cfg.rewardNums
end

function HeroTalentNodeData:IsHeroTalentNodeCanLeveUp()
  if self:IsHeroTalentNodeMaxLevel() or not self:IsHeroTalentNodeUnlock() then
    return false
  end
  local items, nums = self:GetHeroTalentNodeLevelupCost()
  if items ~= nil then
    for i, itemId in ipairs(items) do
      if PlayerDataCenter:GetItemCount(itemId) < nums[i] then
        return false
      end
    end
  end
  return true
end

function HeroTalentNodeData:GetHeroTalentNodeType()
  return self._nodeCfg.nodeType
end

function HeroTalentNodeData:GetHeroTalentNodeId()
  return self._nodeCfg.serial_num
end

function HeroTalentNodeData:IsPrePointParallel()
  return self._nodeCfg.condition_talent_relation
end

function HeroTalentNodeData:GetHeroTalentNodePreIdLvDic()
  return self._nodeCfg.pre_condition_talent
end

function HeroTalentNodeData:GetHeroTalentNodeCfg()
  return self._nodeCfg
end

function HeroTalentNodeData:GetTalentTreeInfo()
  return self._parent
end

function HeroTalentNodeData:GetTalentNextLvAttriDescrib()
  local curEffect = self:GetHeroTalentNodeCurLevelEffect()
  local nextEffect = self:GetHeroTalentNodeNexLevelEffect()
  local curAttris = curEffect ~= nil and curEffect.attribute or nil
  local nextEffect = nextEffect ~= nil and nextEffect.attribute or nil
  return self:__GetAttriAttriDescrib(curAttris, nextEffect)
end

function HeroTalentNodeData:GetHeroTalentNodeBranchId()
  local curEffect = self:GetHeroTalentNodeCurLevelEffect()
  return curEffect ~= nil and curEffect.branch ~= nil, self._branchSelectId
end

function HeroTalentNodeData:GetHeroTalentNodeBranchAttrDic()
  local curEffect = self:GetHeroTalentNodeCurLevelEffect()
  if curEffect.branch == nil then
    return nil
  end
  return curEffect.branch[self._branchSelectId]
end

function HeroTalentNodeData:GetTalentNextLvBranchAttriDescrib()
  local curEffect = self:GetHeroTalentNodeCurLevelEffect()
  local nextEffect = self:GetHeroTalentNodeNexLevelEffect()
  local curBranch = curEffect ~= nil and curEffect.branch or nil
  local nextBranch = nextEffect ~= nil and nextEffect.branch or nil
  local branchCount = math.max(curBranch ~= nil and #curBranch or 0, nextBranch ~= nil and #nextBranch or 0)
  if branchCount == 0 then
    return nil
  end
  local res = {}
  for i = 1, branchCount do
    local curBranchSingle = curBranch ~= nil and curBranch[i] or nil
    local nextBranchSingle = nextBranch ~= nil and nextBranch[i] or nil
    table.insert(res, self:__GetAttriAttriDescrib(curBranchSingle, nextBranchSingle))
  end
  return res
end

function HeroTalentNodeData:__GetAttriAttriDescrib(curAtrris, nextAttris)
  if curAtrris == nil and nextAttris == nil then
    return nil
  end
  local res = {}
  if nextAttris == nil then
    if table.count(curAtrris) == 0 then
      return nil
    end
    for attrId, val in pairs(curAtrris) do
      res[attrId] = {cur = val}
    end
  elseif curAtrris == nil then
    if table.count(nextAttris) == 0 then
      return nil
    end
    for attrId, val in pairs(nextAttris) do
      res[attrId] = {cur = 0, next = val}
    end
  else
    if table.count(nextAttris) == 0 then
      return nil
    end
    for attrId, val in pairs(curAtrris) do
      res[attrId] = {
        cur = curAtrris[attrId] or 0,
        next = val
      }
    end
  end
  return res
end

return HeroTalentNodeData
