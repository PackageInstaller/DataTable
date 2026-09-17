local this = class("petHomeTalentTpl")

function this:init(config)
  self.data = config
  self._actionParams = {}
  self._recommendList = {}
  self._petId2LaborConfigInfoList = {}
  for _, conf in pairs(config) do
    self._actionParams[conf.id] = {}
    for _, param in ipairs(conf.croplandTalentRadius) do
      local paramData = {
        yOffset = param[2],
        xOffset = param[3],
        length = param[4],
        width = param[5]
      }
      self._actionParams[conf.id][param[1]] = paramData
    end
    if conf.isRecommend then
      table.insert(self._recommendList, conf)
    end
    self._petId2LaborConfigInfoList[conf.id] = self._petId2LaborConfigInfoList[conf.id] or {}
    for _, rawLaborConfigInfo in ipairs(conf.laborType) do
      local laborConfigInfo = {laborId = rawLaborConfigInfo}
      table.insert(self._petId2LaborConfigInfoList[conf.id], laborConfigInfo)
    end
  end
  table.sort(self._recommendList, function(a, b)
    return a.id < b.id
  end)
end

function this:getActionEffectParams(id, action)
  return self._actionParams[id] and self._actionParams[id][action]
end

function this:getTplById(id)
  if not self.data[id] then
    errorf("pet_home_talent缺少配置" .. tostring(id))
  end
  return self.data[id]
end

function this:getSizeType(tpl)
  return tpl.sizeType
end

function this:getCroplandTalentRadius(tpl)
  return tpl.croplandTalentRadius
end

function this:getName(tpl)
  return tpl.name
end

function this:getId(tpl)
  return tpl.id
end

function this:getHomeSkillList(tpl)
  return tpl.homeSkillList
end

function this:getHomeNormalSkillList(tpl)
  return tpl.homeNormalSkillList
end

function this:getFarmProducts(tpl)
  return tpl.farmProducts
end

function this:getFeedConsume(tpl)
  return tpl.feedConsume
end

function this:getFeedRestore(tpl)
  return tpl.feedRestore
end

function this:getFeedSpeed(tpl)
  return tpl.feedSpeed
end

function this:getSatietyScore(tpl)
  return tpl.satietyScore
end

function this:getTalentGroupId(tpl)
  return tpl.talentGroupId
end

function this:getMoveSpeed(tpl)
  return tpl.moveSpeed
end

function this:getRecommendList(capacityIdNeed, sizeNeed, laborTypeNeed)
  local maxCount = L_GameConstTpl:getData("HOME_PET_RECOMMEND_MAX", L_Const.GameTplType.int)
  local insertCount = 0
  local res = {}
  for i, v in ipairs(self._recommendList) do
    if maxCount <= insertCount then
      break
    end
    if capacityIdNeed == L_HomeConst.homeLaborType.RANCH_PRODUCT then
      table.insert(res, {tpl = v})
      insertCount = insertCount + 1
    else
      local size = v.sizeType
      local node, index = table.ipairsFind(sizeNeed, function(value)
        return value == size
      end)
      if index then
        if laborTypeNeed then
          local petId = v.id
          local laborConfigInfoList = self:getPetLaborConfigInfoListByPetId(petId)
          for _, laborConfigInfo in pairs(laborConfigInfoList) do
            local laborId = laborConfigInfo.laborId
            if type(laborTypeNeed) == "table" then
              for _, needType in ipairs(laborTypeNeed) do
                if needType == laborId then
                  table.insert(res, {tpl = v})
                  insertCount = insertCount + 1
                end
              end
            elseif laborTypeNeed == laborId then
              table.insert(res, {tpl = v})
              insertCount = insertCount + 1
            end
          end
        else
          do
            local talent = v.talentGroupId or {}
            local node1, index1 = table.ipairsFind(talent, function(value)
              local capacityId = math.floor(value[1] / 100)
              return capacityId == capacityIdNeed
            end)
            if index1 then
              table.insert(res, {tpl = v})
              insertCount = insertCount + 1
            end
          end
        end
      end
    end
  end
  return res
end

function this:getPetLaborConfigInfoListByPetId(petId)
  return self._petId2LaborConfigInfoList[petId] or {}
end

function this:checkPetMatchLaborType(petId, laborType)
  local laborConfigInfoList = self:getPetLaborConfigInfoListByPetId(petId)
  for _, laborConfigInfo in pairs(laborConfigInfoList) do
    local laborId = laborConfigInfo.laborId
    if laborType == laborId then
      return true
    end
  end
  return false
end

return this
