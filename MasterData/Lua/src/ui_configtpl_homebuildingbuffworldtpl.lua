local this = class("homeBuildingBuffWorldTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(config) do
    if not self.groupData[v.groupId] then
      self.groupData[v.groupId] = {}
    end
    self.groupData[v.groupId][v.level] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getBuffCondition(tpl)
  return tpl.buffCondition
end

function this:getBuffConditionLogic(tpl)
  return tpl.buffConditionLogic
end

function this:getBuffParams(tpl)
  return tpl.buffParams
end

function this:getBuffId(tpl)
  return tpl.buffId
end

function this:getUpgradeDesc(tpl)
  local res = {}
  for _, key in ipairs(tpl.upgradeDesc) do
    table.insert(res, L_Config:provider(key))
  end
  return res
end

function this:getUpgradeDescContent(tpl)
  local descList = self:getUpgradeDesc(tpl)
  local content = ""
  for _, str in ipairs(descList) do
    content = content .. tostring(L_Lang:get(str)) .. "\n"
  end
  return content
end

function this:getCurBuffList(tpl)
  local list = {}
  local buffIdList = self:getBuffId(tpl)
  local buffParamList = self:getBuffParams(tpl)
  local buffConditionList = self:getBuffCondition(tpl)
  local descList = self:getUpgradeDesc(tpl)
  for index, buffId in ipairs(buffIdList) do
    local buffParam = buffParamList[index] or {}
    local buffCondition = buffConditionList[index] or {}
    local desc = descList[index] or ""
    local item = {
      buffId = buffId,
      buffParam = buffParam,
      buffCondition = buffCondition,
      desc = desc
    }
    table.insert(list, item)
  end
  return list
end

function this:getCurBuffContent(tpl)
  local list = self:getCurBuffList(tpl)
  local content = ""
  for key, item in ipairs(list) do
    local buffId = item.buffId
    local buffValue = item.buffParam[1] or 0
    local buffTpl = L_GameTpl:getHomeBuffTpl():getTplById(buffId)
    local valueType = L_GameTpl:getHomeBuffTpl():getType(buffTpl)
    if valueType == L_HomeConst.buffValueType.PERCENT then
      buffValue = buffValue / 100
    end
    buffValue = math.modf(buffValue)
    local strBuff = L_Config:providerLua(item.desc, buffValue)
    content = content .. (1 < key and "\n" or "") .. strBuff
  end
  return content
end

function this:getPetEggHatchTimePercent(petEggId, conditions, params)
  local buffData = L_HomeBuffManager:getBuff(L_HomeConst.buffId.PETEGG_HATCHTIME_DECREASE_PERCENT, conditions, params)
  return buffData.buffValue
end

function this:getUpgradeCondition(tpl)
  return tpl.upgradeCondition
end

function this:getMaterial(tpl)
  return tpl.material
end

function this:getTplByCollectionId(collectionId)
  local homeCollectionWorldTpl = L_GameTpl:getHomeCollectionWorldTpl()
  local tpl_collection = homeCollectionWorldTpl:getTplById(collectionId)
  local groupId = homeCollectionWorldTpl:getGroupId(tpl_collection)
  return self.groupData[groupId]
end

return this
