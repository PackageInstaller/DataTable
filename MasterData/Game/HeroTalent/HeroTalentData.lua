local HeroTalentData = class("HeroTalentData")
local HeroTalentNodeData = require("Game.HeroTalent.HeroTalentNodeData")

function HeroTalentData.CreateWithMaxLevel(talentCfg)
  local data = HeroTalentData.New(talentCfg)
  data._curTotalLevel = ConfigData.hero_talent_tree.totalLevelDic[data._treeId]
  for k, node in pairs(data._dic) do
    node:UpdateHeroTalentNodeLevel(node:GetHeroTalentNodeMaxLevel())
    local effect = node:GetHeroTalentNodeCurLevelEffect()
    for attrId, val in pairs(effect.attribute) do
      local count = data._attributeAddDic[attrId] or 0
      data._attributeAddDic[attrId] = count + val
    end
    data._fixedComat = data._fixedComat + effect.skill_comat
  end
  return data
end

function HeroTalentData:ctor(talentCfg)
  self._dic = {}
  self._attributeAddDic = {}
  self._algorithmSpace = {}
  self._fixedComat = 0
  self._heroId = talentCfg.hero_id
  self._modelId = talentCfg.mould_id
  self._treeId = talentCfg.talent_id
  self._curTotalLevel = 0
  local treeCfg = ConfigData.hero_talent_tree[self._treeId]
  for pointId, cfg in pairs(treeCfg) do
    local data = HeroTalentNodeData.New(self._heroId, cfg, self)
    self._dic[pointId] = data
  end
end

function HeroTalentData:UpdateHeroTalent(msg)
  for nodeId, elem in pairs(msg.nodes) do
    local node = self._dic[nodeId]
    if node == nil then
      error("talent node is nil, heroId is " .. tostring(self._heroId) .. " nodeId is" .. tostring(nodeId))
    else
      self._curTotalLevel = self._curTotalLevel - node:GetHeroTalentNodeCurLevel()
      self:__ChangeNormalAddtion(node, false)
      self:__ChangeBranchAddtion(node, false)
      node:UpdateHeroTalentNodeLevel(elem.lv)
      local flag = node:GetHeroTalentNodeBranchId()
      if flag then
        node:UpdateHeroTalentNodeBranch(elem.idx + 1)
      end
      self._curTotalLevel = self._curTotalLevel + node:GetHeroTalentNodeCurLevel()
      self:__ChangeNormalAddtion(node, true)
      self:__ChangeBranchAddtion(node, true)
    end
  end
end

function HeroTalentData:SetHeroTalentBranchInData(nodeId, branchId)
  local node = self._dic[nodeId]
  if node == nil then
    return
  end
  self:__ChangeBranchAddtion(node, false)
  node:UpdateHeroTalentNodeBranch(branchId)
  self:__ChangeBranchAddtion(node, true)
end

function HeroTalentData:__ChangeNormalAddtion(node, flag)
  if node == nil or node:GetHeroTalentNodeCurLevel() < 1 then
    return
  end
  local mul = flag and 1 or -1
  local effect = node:GetHeroTalentNodeCurLevelEffect()
  for attrId, val in pairs(effect.attribute) do
    local count = self._attributeAddDic[attrId] or 0
    self._attributeAddDic[attrId] = count + val * mul
  end
  for i, val in ipairs(effect.algorithm_space) do
    local count = self._algorithmSpace[i] or 0
    self._algorithmSpace[i] = count + val * mul
  end
  self._fixedComat = self._fixedComat + effect.skill_comat * mul
end

function HeroTalentData:__ChangeBranchAddtion(node, flag)
  if node == nil or node:GetHeroTalentNodeCurLevel() < 1 then
    return
  end
  local mul = flag and 1 or -1
  local branchAttri = node:GetHeroTalentNodeBranchAttrDic()
  if branchAttri ~= nil then
    for attrId, val in pairs(branchAttri) do
      local count = self._attributeAddDic[attrId] or 0
      count = count + val * mul
      if count <= 0 then
        self._attributeAddDic[attrId] = nil
      else
        self._attributeAddDic[attrId] = count
      end
    end
  end
end

function HeroTalentData:GetHeroTalentHeroId()
  return self._heroId
end

function HeroTalentData:GetHeroTalentTreeId()
  return self._treeId
end

function HeroTalentData:GetHeroTalentModelId()
  return self._modelId
end

function HeroTalentData:GetHeroTalentNodeDic()
  return self._dic
end

function HeroTalentData:GetHeroTalentNodeById(pointId)
  return self._dic[pointId]
end

function HeroTalentData:GetHeroTalentTotalLevel()
  return self._curTotalLevel, ConfigData.hero_talent_tree.totalLevelDic[self._treeId]
end

function HeroTalentData:ExistHeroTalentCanLevelUp()
  for _, node in pairs(self._dic) do
    if node:IsHeroTalentNodeCanLeveUp() then
      return true
    end
  end
  return false
end

function HeroTalentData:SetSingleAttrBouns(attrId, attrVal)
  local count = self._attributeAddDic[attrId] or 0
  count = count + attrVal
  self._attributeAddDic[attrId] = count
end

function HeroTalentData:GetAttributeAddtion(attrId)
  local attrVal = self._attributeAddDic[attrId] or 0
  return attrVal
end

function HeroTalentData:GetAttributeAddtionAll()
  return self._attributeAddDic
end

function HeroTalentData:GetAlgorithmSpace()
  return self._algorithmSpace
end

function HeroTalentData:GetHeroTalentFixedComat()
  return self._fixedComat
end

return HeroTalentData
