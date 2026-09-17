local this = class("foodTpl")
local _productsMultiQualityTpl = L_GameTpl:getProductsMultiQualityTpl()
local _WorldBuffTpl = L_GameTpl:getWorldBuffTpl()

function this:init(config)
  self.data = config
end

function this:getTplsByGroup(groupId)
  self.foodGroupId2TplList = self.foodGroupId2TplList or {}
  if not self.foodGroupId2TplList[groupId] or table.isEmpty(self.foodGroupId2TplList[groupId]) then
    self.foodGroupId2TplList[groupId] = {}
    local foodIdList = _productsMultiQualityTpl:getItemIdListByFoodGroupId(groupId)
    table.sort(foodIdList, function(a, b)
      local rarityA = _productsMultiQualityTpl:getProductRarityByConfigId(a)
      local rarityB = _productsMultiQualityTpl:getProductRarityByConfigId(b)
      return rarityA < rarityB
    end)
    local tplList = {}
    for _, foodId in ipairs(foodIdList) do
      local foodTpl = self:getTplById(foodId)
      table.insert(tplList, foodTpl)
    end
    self.foodGroupId2TplList[groupId] = tplList
  end
  return self.foodGroupId2TplList[groupId]
end

function this:getNeedMaterial(tpl)
  local foodId = tpl.id
  return _productsMultiQualityTpl:getNeedMaterialByConfigId(foodId)
end

function this:getCanDoTpl(groupId, rarityList)
  local tpls = self:getTplsByGroup(groupId)
  for i = #tpls, 1, -1 do
    local tpl = tpls[i]
    local materials = self:getNeedMaterial(tpl)
    local res = true
    for i = 1, #materials do
      res = res and rarityList[i] >= materials[i][3]
    end
    if res then
      return tpl
    end
  end
  errorf("有问题，做不出饭 " .. groupId .. "  " .. rarityList[1] .. " " .. rarityList[2] .. " " .. rarityList[3] .. " " .. rarityList[4])
end

function this:getCanDoMaxNum(foodId, rarityList)
  local targetTpl = self:getTplById(foodId)
  local targetFoodId = targetTpl.id
  local materials = _productsMultiQualityTpl:getNeedMaterialByConfigId(targetFoodId)
  local _foodMaterialTpl = L_GameTpl:getFoodMaterialGroupTpl()
  local canNum = L_Const.maxInt
  for i = 1, 4 do
    local material = materials[i]
    if material then
      local itemId = _foodMaterialTpl:getItemId(material[1], rarityList[i])
      local oneNum = material[2]
      local haveNum = C_BagMgr:getItemNumByItemId(itemId)
      canNum = math.min(canNum, math.floor(haveNum / oneNum))
    end
  end
  return canNum
end

function this:getTplById(id)
  if not self.data[id] then
    errorf("缺少食物food配置" .. id)
  end
  return self.data[id]
end

function this:getFoodEffect(tpl)
  return L_Config:provider(tpl.foodEffect)
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getId(tpl)
  return tpl.id
end

function this:getFunctionDesc(tpl)
  return L_Config:provider(tpl.functionDesc)
end

function this:getTag(tpl)
  return tpl.tag
end

function this:getFoodQua(tpl)
  return tpl.foodQua
end

function this:getFoodType(tpl)
  return tpl.foodType
end

function this:getFoodName(tpl)
  return L_Config:provider(tpl.foodName)
end

function this:getProficiency(tpl)
  return tpl.proficiency
end

function this:getFoodCharge(tpl)
  return tpl.foodCharge
end

function this:getCharge(tpl)
  return tpl.charge
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getValueIndex(tpl)
  return tpl.valueIndex
end

function this:getFoodDescByFood(subId)
  local food = self:getTplById(subId)
  local desc = L_Config:provider(food.desc)
  if food.foodType == L_Const.foodType.heal then
    return desc
  elseif food.buffTimes ~= 0 and not table.isEmpty(food.baseAttribute) then
    local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
    local str1 = ""
    local str2 = ""
    for k, v in pairs(food.baseAttribute) do
      if string.isEmpty(str1) then
        str1 = battleInfoTpl:getShowTxt(k, v)
      else
        str2 = battleInfoTpl:getShowTxt(k, v)
      end
    end
    return string.format(desc, str1, str2, food.buffTimes)
  elseif not table.isEmpty(food.foodCharge) then
    for i, v in ipairs(food.foodCharge) do
      return desc
    end
  elseif food.endurance ~= 0 then
    return string.format(desc, food.endurance)
  end
end

function this:getSatietyScore(tpl)
  return tpl.satietyScore
end

function this:getProductId(tpl)
  return tpl.productId
end

function this:getFoodIdByProductId(productId)
  return self._productId2FoodId[productId]
end

function this:getBuffId(tpl)
  return tpl.buffId
end

function this:getBuffDuration(id)
  local tpl = self:getTplById(id)
  if not tpl then
    return
  end
  local buffId = self:getBuffId(tpl)
  if not buffId then
    return
  end
  local buffTpl = _WorldBuffTpl:getTplById(buffId)
  if not buffTpl then
    return
  end
  local _, duration = _WorldBuffTpl:getDurationInfo(buffTpl)
  return duration
end

function this:getBuffElementId(id)
  local tpl = self:getTplById(id)
  if not tpl then
    return
  end
  local buffId = self:getBuffId(tpl)
  if not buffId then
    return
  end
  local buffTpl = _WorldBuffTpl:getTplById(buffId)
  if not buffTpl then
    return
  end
  return _WorldBuffTpl:getBuffElementId(buffTpl)
end

return this
