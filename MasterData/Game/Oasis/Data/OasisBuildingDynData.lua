local OasisBuildingDynData = class("OasisBuildingDynData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function OasisBuildingDynData:Initialize(stcData)
  self.stcData = stcData
  self.id = stcData.build_id
  self.levelConfig = ConfigData.buildingLevel[self.id]
  if self.levelConfig == nil then
    error("Can't find buildingLevel, build_id : " .. tostring(self.id))
  end
  self.maxLevel = ConfigData.buildingLevel.maxLevelDic[self.id]
  self.name = LanguageUtil.GetLocaleText(stcData.name)
  self.nameEn = LanguageUtil.GetLocaleText(stcData.name_en)
  self.area = 1
  self.icon_res = stcData.icon_res
  self.position = Vector2.New()
  if #stcData.coord_base == 3 then
    self.area = stcData.coord_base[1]
    self.position.x = stcData.coord_base[2]
    self.position.y = stcData.coord_base[3]
  end
  self.size = stcData.size
  self.height = stcData.height
  if self.height == nil then
    error("Oasis building" .. stcData.name .. ":没有配置 height")
  end
  self.belong = BuildingBelong.CheckBelong(stcData.type)
  if self.belong == BuildingBelong.Sector then
    self.sectorId = nil
    for _, id in ipairs(ConfigData.sector.id_sort_list) do
      local sectorCfg = ConfigData.sector[id]
      for _, builtId in ipairs(sectorCfg.building) do
        if builtId == stcData.build_id then
          self.sectorId = id
          break
        end
      end
    end
  end
end

function OasisBuildingDynData:IsSectorBuilding()
  return self.belong == BuildingBelong.Sector
end

function OasisBuildingDynData:UpdateLockAndBuild()
  self.unlock = self:Unlock()
  if not self.unlock then
    local level1Cfg = self.levelConfig[1]
    local preCondition, prePara1, prePara2
    for i = 1, #level1Cfg.pre_condition do
      preCondition = {
        level1Cfg.pre_condition[i]
      }
      prePara1 = {
        level1Cfg.pre_para1[i]
      }
      prePara2 = {
        level1Cfg.pre_para2[i]
      }
      if not CheckCondition.CheckLua(preCondition, prePara1, prePara2) then
        self.lockReason = CheckCondition.GetUnlockInfoLua(preCondition, prePara1, prePara2)
        break
      end
    end
  end
  self.canbuild = self:CanBuild()
end

function OasisBuildingDynData:Unlock()
  local level1Cfg = self.levelConfig[1]
  if not CheckCondition.CheckLua(level1Cfg.pre_condition, level1Cfg.pre_para1, level1Cfg.pre_para2) then
    return false
  end
  return true
end

function OasisBuildingDynData:CanBuild()
  if PlayerDataCenter.AllBuildingData:FullBuildQue(self.belong) then
    return false
  end
  local level1Cfg = self.levelConfig[1]
  if not CheckCondition.CheckLua(level1Cfg.pre_condition, level1Cfg.pre_para1, level1Cfg.pre_para2) then
    return false
  end
  for k, v in ipairs(level1Cfg.consumeIds) do
    local resId = v
    local count = PlayerDataCenter:GetItemCount(resId)
    local cost = level1Cfg.consumeNums[k]
    if count < cost then
      return false
    end
  end
  return true
end

function OasisBuildingDynData:GetLevelCostItem(lvl)
  local nextLvlCfg = self.levelConfig[lvl]
  if nextLvlCfg == nil then
    return
  end
  local resNeedItems = {}
  for i = 1, #nextLvlCfg.consumeIds do
    local resId = nextLvlCfg.consumeIds[i]
    local resCount = nextLvlCfg.consumeNums[i]
    local count = PlayerDataCenter:GetItemCount(resId)
    local name = LanguageUtil.GetLocaleText(ConfigData.item[resId].name)
    resNeedItems[i] = {}
    resNeedItems[i].name = name
    resNeedItems[i].count = count
    resNeedItems[i].resCount = resCount
    resNeedItems[i].resId = resId
  end
  table.sort(resNeedItems, function(a, b)
    return a.resId < b.resId
  end)
  return resNeedItems
end

function OasisBuildingDynData:GetPreBuildingLvlInfo(targetLvl)
  local tarLvlCfg = self.levelConfig[targetLvl]
  local preConditionList = CheckCondition.GetUnlockAndInfoList(tarLvlCfg.pre_condition, tarLvlCfg.pre_para1, tarLvlCfg.pre_para2)
  return preConditionList
end

function OasisBuildingDynData:GetPreBuildingId(targetLvl)
  local preBuildIds = {}
  local tarLvlCfg = self.levelConfig[targetLvl]
  for i = 1, #tarLvlCfg.pre_condition do
    if tarLvlCfg.pre_condition[i] == CheckerTypeId.BuildingLevel then
      local buildingId = tarLvlCfg.pre_para1[i]
      table.insert(preBuildIds, buildingId)
    end
  end
  return preBuildIds
end

function OasisBuildingDynData:GetPreBuildUnlockLevel(targetLvl)
  local preBuildDic = {}
  local tarLvlCfg = self.levelConfig[targetLvl]
  for i = 1, #tarLvlCfg.pre_condition do
    if tarLvlCfg.pre_condition[i] == CheckerTypeId.BuildingLevel then
      local buildingId = tarLvlCfg.pre_para1[i]
      preBuildDic[buildingId] = tarLvlCfg.pre_para2[i]
    end
  end
  return preBuildDic
end

function OasisBuildingDynData:GetTargetLevelNeedTime(tarlvl)
  local levelCfg = self.levelConfig[tarlvl]
  if levelCfg == nil then
    return
  end
  return math.ceil(levelCfg.time / (1 + PlayerDataCenter.playerBonus:GetBuildSpeed() / 1000))
end

function OasisBuildingDynData:GetBuffItems(level, getNext, includeZero)
  local levelCfg = self.levelConfig[level]
  if levelCfg == nil then
    return
  end
  local buffList = {}
  local nextlvlCfg
  if getNext and level < self.maxLevel then
    nextlvlCfg = self.levelConfig[level + 1]
  end
  
  local function ignoreZeroFcuc(index, paraId)
    local para = "para" .. tostring(paraId)
    return not includeZero and levelCfg[para][index] == 0 and (nextlvlCfg == nil or nextlvlCfg[para][index] == 0)
  end
  
  for i = 1, #levelCfg.logic do
    local currentInfo, curValue, nextInfoValue
    local logic = levelCfg.logic[i]
    local buildingBuffCfg = ConfigData.buildingBuff[logic]
    local describ, valueFormat
    if buildingBuffCfg ~= nil then
      describ = LanguageUtil.GetLocaleText(ConfigData.buildingBuff[logic].buff_text_context)
      valueFormat = LanguageUtil.GetLocaleText(ConfigData.buildingBuff[logic].buff_value)
    end
    if logic == eLogicType.ResourceOutput then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      local itemCfg = ConfigData.item[levelCfg.para1[i]]
      local speed = levelCfg.para2[i]
      speed = speed * 36 / 1000
      speed = FormatNum(speed - speed % 0.1)
      local describ_text = string.format(describ, LanguageUtil.GetLocaleText(itemCfg.name))
      currentInfo = describ_text
      curValue = string.format(valueFormat, speed)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.ResourceOutput then
        local nextItemCfg = ConfigData.item[nextlvlCfg.para1[i]]
        local speed = nextlvlCfg.para2[i] * 36 / 1000
        speed = FormatNum(speed - speed % 0.1)
        nextInfoValue = string.format(valueFormat, speed)
      end
    elseif logic == eLogicType.FactoryPipelie then
      if ignoreZeroFcuc(i, 1) then
        goto lbl_1574
      end
      currentInfo = describ
      curValue = string.format(valueFormat, levelCfg.para1[i])
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.FactoryPipelie then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i])
      end
    elseif logic == eLogicType.ResourceLimit then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      local itemCfg = ConfigData.item[levelCfg.para1[i]]
      local describ_text = string.format(describ, LanguageUtil.GetLocaleText(itemCfg.name))
      currentInfo = describ_text
      curValue = string.format(valueFormat, levelCfg.para2[i])
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.ResourceLimit then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para2[i])
      end
    elseif logic == eLogicType.GlobalExpCeiling then
      if ignoreZeroFcuc(i, 1) then
        goto lbl_1574
      end
      currentInfo = describ
      curValue = string.format(valueFormat, levelCfg.para1[i])
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.GlobalExpCeiling then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i])
      end
    elseif logic == eLogicType.StaminaCeiling then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      currentInfo = describ
      curValue = string.format(valueFormat, levelCfg.para1[i])
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.StaminaCeiling then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i])
      end
    elseif logic == eLogicType.StaminaOutput then
      if ignoreZeroFcuc(i, 1) then
        goto lbl_1574
      end
      local speed = levelCfg.para1[i] * 6.0E-4
      currentInfo = describ
      curValue = string.format(valueFormat, speed)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.StaminaOutput then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i] * 6.0E-4)
      end
    elseif logic == eLogicType.ResOutputEfficiency then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      local itemCfg = ConfigData.item[levelCfg.para1[i]]
      local efficiency = levelCfg.para2[i] * 0.1
      local describ_text
      if levelCfg.para1[i] == 0 then
        describ_text = string.format(describ, ConfigData:GetTipContent(14010))
      else
        describ_text = string.format(describ, LanguageUtil.GetLocaleText(itemCfg.name))
      end
      currentInfo = describ_text
      curValue = string.format(valueFormat, efficiency)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.ResOutputEfficiency then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para2[i] * 0.1)
      end
    elseif logic == eLogicType.BuildQueue then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      local buildingBelongText
      if levelCfg.para1[i] == eBuildQueueType.Oasis then
        local systemName = LanguageUtil.GetLocaleText(ConfigData.system_open[proto_csmsg_SystemFunctionID.SystemFunctionID_Building].name)
        buildingBelongText = systemName
      else
        local systemName = LanguageUtil.GetLocaleText(ConfigData.system_open[proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration].name)
        buildingBelongText = systemName
      end
      local describ_text = string.format(describ, buildingBelongText)
      currentInfo = describ_text
      curValue = string.format(valueFormat, levelCfg.para2[i])
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.BuildQueue then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para2[i])
      end
    elseif logic == eLogicType.BuildSpeed then
      if ignoreZeroFcuc(i, 1) then
        goto lbl_1574
      end
      local speed = levelCfg.para1[i] * 0.1
      currentInfo = describ
      curValue = string.format(valueFormat, speed)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.BuildSpeed then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i] * 0.1)
      end
    elseif logic == eLogicType.GlobalExpRatio then
      if ignoreZeroFcuc(i, 1) then
        goto lbl_1574
      end
      local ratio = levelCfg.para1[i] * 0.1
      currentInfo = describ
      curValue = string.format(valueFormat, ratio)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.GlobalExpRatio then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i] * 0.1)
      end
    elseif logic == eLogicType.AllHeroBuff then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      local attrId = levelCfg.para1[i]
      local value = levelCfg.para2[i]
      local attrDes, valueDes = ConfigData:GetAttribute(attrId, value)
      local describ_text = string.format(describ, attrDes)
      currentInfo = describ_text
      curValue = string.format(valueFormat, valueDes)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.AllHeroBuff then
        local nextValue = nextlvlCfg.para2[i]
        local nextAttrDes, nextValueDes = ConfigData:GetAttribute(attrId, nextValue)
        nextInfoValue = string.format(valueFormat, nextValueDes)
      end
    elseif logic == eLogicType.OverClock then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      local id = levelCfg.para1[i]
      local level = levelCfg.para2[i]
      local name = LanguageUtil.GetLocaleText(ConfigData.overclock[id][level].name)
      currentInfo = string.format(describ, name)
      curValue = string.format(valueFormat, level)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.OverClock then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para2[i])
      end
    elseif logic == eLogicType.OverClockFreeNum then
      if ignoreZeroFcuc(i, 1) then
        goto lbl_1574
      end
      local freeNum = levelCfg.para1[i]
      currentInfo = describ
      curValue = string.format(valueFormat, freeNum)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.OverClockFreeNum then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i])
      end
    elseif logic == eLogicType.DynSkillUpgrade then
      if ignoreZeroFcuc(i, 1) then
        goto lbl_1574
      end
      local skillUpgradeSpeed = levelCfg.para1[i] * 0.01
      currentInfo = describ
      curValue = string.format(valueFormat, skillUpgradeSpeed)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.DynSkillUpgrade then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i] * 0.01)
      end
    elseif logic == eLogicType.DynChipCountMax then
      if ignoreZeroFcuc(i, 1) then
        goto lbl_1574
      end
      local chipCount = levelCfg.para1[i]
      currentInfo = describ
      curValue = string.format(valueFormat, chipCount)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.DynChipCountMax then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i])
      end
    elseif logic == eLogicType.CareerBuff then
      if ignoreZeroFcuc(i, 3) then
        goto lbl_1574
      end
      local careerId = levelCfg.para1[i]
      local attrId = levelCfg.para2[i]
      local attibuteCfg = self:_GetAttributeCfg(attrId)
      if attibuteCfg == nil then
        goto lbl_1574
      end
      local attrName = LanguageUtil.GetLocaleText(attibuteCfg.name)
      local isRatio = attibuteCfg.num_type == 2
      local careerCfg = ConfigData.career[careerId]
      if careerCfg == nil then
        error("can't find career, id=" .. tostring(careerId))
        goto lbl_1574
      end
      local count = levelCfg.para3[i]
      local valueStr
      if isRatio then
        valueStr = tostring(FormatNum(count / 10)) .. "%"
      else
        valueStr = tostring(count)
      end
      currentInfo = string.format(describ, LanguageUtil.GetLocaleText(careerCfg.name), attrName)
      curValue = string.format(valueFormat, valueStr)
      if getNext ~= nil and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.CareerBuff then
        local nextCount = nextlvlCfg.para3[i]
        if isRatio then
          valueStr = tostring(FormatNum(nextCount / 10)) .. "%"
        else
          valueStr = tostring(nextCount)
        end
        nextInfoValue = string.format(valueFormat, valueStr)
      end
    elseif logic == eLogicType.CampBuff then
      if ignoreZeroFcuc(i, 3) then
        goto lbl_1574
      end
      local campId = levelCfg.para1[i]
      local attrId = levelCfg.para2[i]
      local attibuteCfg = self:_GetAttributeCfg(attrId)
      if attibuteCfg == nil then
        goto lbl_1574
      end
      local attrName = LanguageUtil.GetLocaleText(attibuteCfg.name)
      local isRatio = attibuteCfg.num_type == 2
      local campCfg = ConfigData.career[campId]
      if campCfg == nil then
        error("can't find career, id=" .. tostring(campId))
        return
      end
      local count = levelCfg.para3[i]
      local valueStr
      if isRatio then
        valueStr = tostring(FormatNum(count / 10)) .. "%"
      else
        valueStr = tostring(count)
      end
      currentInfo = string.format(describ, LanguageUtil.GetLocaleText(campCfg.name), attrName)
      curValue = string.format(valueFormat, valueStr)
      if getNext ~= nil and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.CampBuff then
        local nextCount = nextlvlCfg.para3[i]
        if isRatio then
          valueStr = tostring(FormatNum(nextCount / 10)) .. "%"
        else
          valueStr = tostring(nextCount)
        end
        nextInfoValue = string.format(valueFormat, valueStr)
      end
    elseif logic == eLogicType.DynPlayerAttrBuff then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      local dynAttrId = levelCfg.para1[i]
      local value = levelCfg.para2[i]
      local attibuteCfg = self:_GetAttributeCfg(dynAttrId)
      if attibuteCfg == nil then
        goto lbl_1574
      end
      if attibuteCfg.cmd_num_type == eAttributeNumType.Ratio then
        value = FormatNum(value / 10)
      elseif attibuteCfg.cmd_num_type == eAttributeNumType.Frame then
        value = BattleUtil.FrameToTime(value)
      end
      local buffDesIndex = logic * 100 + dynAttrId
      if ConfigData.buildingBuff[buffDesIndex] == nil then
        error("Cant get buildingBuff, id = " .. tostring(buffDesIndex))
        goto lbl_1574
      end
      describ = LanguageUtil.GetLocaleText(ConfigData.buildingBuff[buffDesIndex].buff_text_context)
      valueFormat = LanguageUtil.GetLocaleText(ConfigData.buildingBuff[buffDesIndex].buff_value)
      currentInfo = describ
      curValue = string.format(valueFormat, value)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.DynPlayerAttrBuff then
        local nextValue = nextlvlCfg.para2[i]
        if attibuteCfg.cmd_num_type == eAttributeNumType.Ratio then
          nextValue = FormatNum(nextValue / 10)
        elseif attibuteCfg.cmd_num_type == eAttributeNumType.Frame then
          nextValue = BattleUtil.FrameToTime(nextValue)
        end
        nextInfoValue = string.format(valueFormat, nextValue)
      end
    elseif logic == eLogicType.HeroLevelCeiling then
      if ignoreZeroFcuc(i, 1) then
        goto lbl_1574
      end
      local value = levelCfg.para1[i]
      currentInfo = describ
      curValue = string.format(valueFormat, value)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.HeroLevelCeiling then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i])
      end
    elseif logic == eLogicType.AutoRecoverItem then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      local itemCfg = ConfigData.item[levelCfg.para1[i]]
      local speed = levelCfg.para2[i]
      speed = speed * 36 / 1000
      speed = FormatNum(speed - speed % 0.1)
      currentInfo = string.format(describ, LanguageUtil.GetLocaleText(itemCfg.name))
      curValue = string.format(valueFormat, speed)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.AutoRecoverItem then
        local speed = nextlvlCfg.para2[i] * 36 / 1000
        speed = FormatNum(speed - speed % 0.1)
        nextInfoValue = string.format(valueFormat, speed)
      end
    elseif logic == eLogicType.FactoryEfficiency then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      currentInfo = string.format(describ, orderName)
      curValue = string.format(valueFormat, levelCfg.para2[i] * 0.1)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.FactoryEfficiency then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para2[i] * 0.1)
      end
    elseif logic == eLogicType.ResOutputCeiling then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      local buildingCfg = ConfigData.building[levelCfg.para1[i]]
      local describ_text = string.format(describ, LanguageUtil.GetLocaleText(buildingCfg.name))
      currentInfo = describ_text
      curValue = string.format(valueFormat, levelCfg.para2[i])
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.ResOutputCeiling then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para2[i])
      end
    elseif logic == eLogicType.ChipCeilingCostReduce then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      currentInfo = describ
      curValue = string.format(valueFormat, levelCfg.para1[i])
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.ChipCeilingCostReduce then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i])
      end
    elseif logic == eLogicType.EpInitItemAddtion then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      currentInfo = describ
      local itemId = levelCfg.para1[i]
      local itemCfg = ConfigData.item[itemId]
      local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
      local itemDescribe = LanguageUtil.GetLocaleText(itemCfg.describe)
      currentInfo = string.format(describ, itemName, itemDescribe)
      curValue = string.format(valueFormat, levelCfg.para2[i])
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.EpInitItemAddtion then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para2[i])
      end
    elseif logic == eLogicType.EpBattleRoomGetExr then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      currentInfo = describ
      curValue = string.format(valueFormat, levelCfg.para2[i])
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.EpBattleRoomGetExr then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para2[i])
      end
    elseif logic == eLogicType.SupportCountAddtion then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      currentInfo = describ
      curValue = string.format(valueFormat, levelCfg.para1[i])
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.SupportCountAddtion then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i])
      end
    elseif logic == eLogicType.HpRecoverInRecoveryRoom then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      currentInfo = describ
      curValue = string.format(valueFormat, levelCfg.para1[i])
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.HpRecoverInRecoveryRoom then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i])
      end
    elseif logic == eLogicType.OverClockCountAddtion then
      if ignoreZeroFcuc(i, 2) then
        goto lbl_1574
      end
      currentInfo = describ
      curValue = string.format(valueFormat, levelCfg.para1[i])
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.OverClockCountAddtion then
        nextInfoValue = string.format(valueFormat, nextlvlCfg.para1[i])
      end
    elseif logic == eLogicType.BattleBuffAdd then
      local buffId = levelCfg.para1[i]
      local buffCfg = ConfigData.oasis_building_tech_buff[buffId]
      if buffCfg == nil then
        error("cant get oasis_building_tech_buff cfg, id:" .. tostring(buffId))
        goto lbl_1574
      end
      currentInfo = LanguageUtil.GetLocaleText(buffCfg.describe1)
      curValue = LanguageUtil.GetLocaleText(buffCfg.describe2)
      if getNext and nextlvlCfg ~= nil and nextlvlCfg.logic[i] == eLogicType.OverClockCountAddtion then
        local buffCfgNext = ConfigData.oasis_building_tech_buff[nextlvlCfg.para1[i]]
        nextInfoValue = buffCfgNext and LanguageUtil.GetLocaleText(buffCfgNext.describe2)
      end
    end
    if not string.IsNullOrEmpty(currentInfo) then
      table.insert(buffList, {
        logicId = logic,
        currentInfo = currentInfo,
        curValue = curValue,
        nextInfoValue = nextInfoValue
      })
    end
    ::lbl_1574::
  end
  return buffList
end

function OasisBuildingDynData:_GetAttributeCfg(attrId)
  local attibuteCfg = ConfigData.attribute[attrId]
  if attibuteCfg == nil then
    error("Can't find attibuteCfg, id = " .. tostring(attrId))
    return
  end
  return attibuteCfg
end

return OasisBuildingDynData
