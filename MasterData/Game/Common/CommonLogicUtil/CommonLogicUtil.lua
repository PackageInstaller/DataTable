local CommonLogicUtil = {}
local IsLegalFuncTable = {}

local function GetCommonLogicDesConfig(logicId, moduleType)
  local logicDesCfg
  local logicDesCfgDic = ConfigData.common_logic_des[logicId]
  if logicDesCfgDic ~= nil then
    if moduleType == nil or logicDesCfgDic[moduleType] == nil then
      logicDesCfg = logicDesCfgDic[0]
    else
      logicDesCfg = logicDesCfgDic[moduleType]
    end
    if logicDesCfg == nil then
      error("can't read logic cfg module ,id and module is " .. tostring(logicId) .. "," .. tostring(moduleType))
      return
    end
  else
    error("can't read logic des id is " .. tostring(logicId))
    return
  end
  return logicDesCfg
end

local GetDesFuncTable = {
  [eLogicType.ResourceLimit] = function(para1, para2, para3)
    local itemName = LanguageUtil.GetLocaleText(ConfigData.item[para1].name)
    local itemNum = para2
    return string.format(ConfigData:GetTipContent(14001), itemName, tostring(itemNum)), itemName, itemNum
  end,
  [eLogicType.ResourceOutput] = function(para1, para2, para3)
    local itemName = LanguageUtil.GetLocaleText(ConfigData.item[para1].name)
    local speed = para2 * 36 // 1000
    return string.format(ConfigData:GetTipContent(14002), itemName, tostring(speed)), itemName, speed
  end,
  [eLogicType.CampBuff] = function(para1, para2, para3)
    local campName = LanguageUtil.GetLocaleText(ConfigData.camp[para1].name)
    local attrName = LanguageUtil.GetLocaleText(ConfigData.attribute[para2].name)
    local attrValue = para3
    return string.format(ConfigData:GetTipContent(14003), campName, attrName, tostring(attrValue)), campName, attrName, attrValue
  end,
  [eLogicType.CareerBuff] = function(para1, para2, para3)
    local careerName = LanguageUtil.GetLocaleText(ConfigData.career[para1].name)
    local attrName = LanguageUtil.GetLocaleText(ConfigData.attribute[para2].name)
    local attrValue = para3
    return string.format(ConfigData:GetTipContent(14003), careerName, attrName, tostring(attrValue)), careerName, attrName, attrValue
  end,
  [eLogicType.FactoryPipelie] = function(para1, para2, para3)
    local lineNum = para1
    return string.format(ConfigData:GetTipContent(14004), tostring(lineNum)), lineNum
  end,
  [eLogicType.GlobalExpCeiling] = function(para1, para2, para3)
    local expLimt = para1
    return string.format(ConfigData:GetTipContent(14005), tostring(expLimt)), expLimt
  end,
  [eLogicType.StaminaCeiling] = function(para1, para2, para3)
    local staminaLimt = para1
    return string.format(ConfigData:GetTipContent(14006), tostring(staminaLimt)), staminaLimt
  end,
  [eLogicType.StaminaOutput] = function(para1, para2, para3)
    local speed = para1 * 0.036
    return string.format(ConfigData:GetTipContent(14007), tostring(speed)), speed
  end,
  [eLogicType.ResOutputEfficiency] = function(para1, para2, para3)
    local itemName
    if para1 == 0 then
      itemName = ConfigData:GetTipContent(14010)
    else
      local itemCfg = ConfigData.item[para1]
      itemName = LanguageUtil.GetLocaleText(itemCfg.name)
    end
    local rate = GetPreciseDecimalStr(para2 / 10, 2) .. "%"
    return string.format(ConfigData:GetTipContent(14008), itemName, rate), itemName, rate
  end,
  [eLogicType.BuildQueue] = function(para1, para2, para3)
    local placeName
    if para1 == 1 then
      local systemName = LanguageUtil.GetLocaleText(ConfigData.system_open[proto_csmsg_SystemFunctionID.SystemFunctionID_Building].name)
      placeName = systemName
    else
      local systemName = LanguageUtil.GetLocaleText(ConfigData.system_open[proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration].name)
      placeName = systemName
    end
    local listNum = para2
    return string.format(ConfigData:GetTipContent(14011), placeName, tostring(listNum)), listNum
  end,
  [eLogicType.BuildSpeed] = function(para1, para2, para3)
    theSelf.ui.tex_AttriName:SetIndex(eLogicType.BuildSpeed)
    local speed = para1
    local rate = GetPreciseDecimalStr(speed / 10, 2) .. "%"
    return string.format(ConfigData:GetTipContent(14012), rate), rate
  end,
  [eLogicType.GlobalExpRatio] = function(para1, para2, para3)
    local rate = GetPreciseDecimalStr(para1 / 10, 2) .. "%"
    return string.format(ConfigData:GetTipContent(14013), rate), rate
  end,
  [eLogicType.AllHeroBuff] = function(para1, para2, para3)
    local attrName = LanguageUtil.GetLocaleText(ConfigData.attribute[para1].name)
    local attrValue = para2
    return string.format(ConfigData:GetTipContent(14014), attrName, tostring(attrValue)), attrName, attrValue
  end,
  [eLogicType.OverClock] = function(para1, para2, para3)
    local name = LanguageUtil.GetLocaleText(ConfigData.overclock[para1][level].name)
    local level = para2
    return string.format(ConfigData:GetTipContent(14015), name, tostring(level)), name, level
  end,
  [eLogicType.OverClockFreeNum] = function(para1, para2, para3)
    return string.format(ConfigData:GetTipContent(14016), tostring(para1)), para1
  end,
  [eLogicType.FocusPointCeiling] = function(para1, para2, para3)
    return string.format(ConfigData:GetTipContent(14017), tostring(para1)), para1
  end,
  [eLogicType.BattleExpBonus] = function(para1, para2, para3)
    local rate = GetPreciseDecimalStr(para1 / 10, 2) .. "%"
    return string.format(ConfigData:GetTipContent(14018), rate), rate
  end,
  [eLogicType.DynSkillUpgrade] = function(para1, para2, para3)
    local rate = GetPreciseDecimalStr(para1 / 100, 2) .. "%"
    return string.format(ConfigData:GetTipContent(14019), rate), rate
  end,
  [eLogicType.DynChipCountMax] = function(para1, para2, para3)
    return string.format(ConfigData:GetTipContent(14020), tostring(para1)), para1
  end,
  [eLogicType.AutoRecoverItem] = function(para1, para2, para3)
    local itemName
    if para1 == 0 then
      itemName = ConfigData:GetTipContent(14010)
    else
      local itemCfg = ConfigData.item[para1]
      itemName = LanguageUtil.GetLocaleText(itemCfg.name)
    end
    local rate = GetPreciseDecimalStr(para2 / 100000 * 3600, 2)
    return string.format(ConfigData:GetTipContent(14021), itemName, rate), itemName, rate
  end,
  [eLogicType.DungeonCountAdd] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.DungeonCountAdd, moduleType)
    if logicDesCfg ~= nil then
      local longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), nil, para2)
      return longDes
    end
    local dungeonName = LanguageUtil.GetLocaleText(ConfigData.material_dungeon[para1].name)
    local describ = LanguageUtil.GetLocaleText(ConfigData.buildingBuff[eLogicType.DungeonCountAdd].buff_text_context)
    local value = LanguageUtil.GetLocaleText(ConfigData.buildingBuff[eLogicType.DungeonCountAdd].buff_value)
    local describ_text = dungeonName .. "：" .. string.format(describ, para2)
    return describ_text, para2
  end,
  [eLogicType.DungeonRewardExtraNum] = function(para1, para2, para3)
    local describ_text = string.format(ConfigData:GetTipContent(2029), para1)
    return describ_text
  end,
  [eLogicType.FriendshipBonus] = function(para1, para2, para3)
    local describ_text = string.format(ConfigData:GetTipContent(2030), para1)
    return describ_text
  end,
  [eLogicType.DailyFixedOutput] = function(para1, para2, para3)
    local para1Str = tostring(para1)
    local hourStr = string.sub(para1Str, 1, 2)
    local minuteStr = string.sub(para1Str, 3, 4)
    local itemName
    local itemCfg = ConfigData.item[para2]
    if itemCfg ~= nil then
      itemName = LanguageUtil.GetLocaleText(itemCfg.name)
    end
    local describ_text = string.format(ConfigData:GetTipContent(2031), hourStr, minuteStr, itemName, para3)
    return describ_text
  end,
  [eLogicType.Activity_PointMultRate] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_PointMultRate, moduleType)
    if logicDesCfg == nil then
      return
    end
    local longDes, shortDes, valueDes, actName
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(para1)
    if activityFrameData ~= nil then
      actName = activityFrameData.name
    else
      actName = ""
      if isGameDev then
        error("activity miss " .. tostring(para1))
      end
    end
    local pointName
    local itemCfg = ConfigData.item[para2]
    pointName = LanguageUtil.GetLocaleText(itemCfg.name)
    local addValue = GetPreciseDecimalStr(para3 / 10) .. "%"
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), actName, pointName, addValue)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), actName, pointName, addValue)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), actName, pointName, addValue)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_Stamina2PointMultRate] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_Stamina2PointMultRate, moduleType)
    if logicDesCfg == nil then
      return
    end
    local longDes, shortDes, valueDes, actName
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(para1)
    if activityFrameData then
      actName = activityFrameData.name
    else
      actName = ""
      if isGameDev then
        error("activity miss " .. tostring(para1))
      end
    end
    local pointName
    local itemCfg = ConfigData.item[para2]
    pointName = LanguageUtil.GetLocaleText(itemCfg.name)
    local addValue = GetPreciseDecimalStr(para3 / 10) .. "%"
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), actName, pointName, addValue)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), actName, pointName, addValue)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), actName, pointName, addValue)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_EffiMultRate] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_EffiMultRate, moduleType)
    if logicDesCfg == nil then
      return
    end
    local longDes, shortDes, valueDes, actName
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(para1)
    if activityFrameData ~= nil then
      actName = activityFrameData.name
    else
      actName = ""
      if isGameDev then
        error("activity miss " .. tostring(para1))
      end
    end
    local multRate
    multRate = tostring(para2 + 1)
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), actName, multRate)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), actName, multRate)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), actName, multRate)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_ChipGroupLevel] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_ChipGroupLevel, moduleType)
    if logicDesCfg == nil then
      return
    end
    local longDes, shortDes, valueDes, actName
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(para1)
    if activityFrameData ~= nil then
      actName = activityFrameData.name
    else
      actName = ""
      if isGameDev then
        error("activity miss " .. tostring(para1))
      end
    end
    local suitName
    local tagSuitCfg = ConfigData.chip_tag[para2]
    suitName = LanguageUtil.GetLocaleText(tagSuitCfg.tag_name)
    local qualityName = ConfigData:GetTipContent(ItemQualityColorName[eChipLevelToQaulity[para3]])
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), actName, suitName, qualityName)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), actName, suitName, qualityName)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), actName, suitName, qualityName)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_UnlockBuff] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_UnlockBuff, moduleType)
    if logicDesCfg == nil then
      return
    end
    local longDes, shortDes, valueDes, actName
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(para1)
    if activityFrameData ~= nil then
      actName = activityFrameData.name
    else
      actName = ""
      if isGameDev then
        error("activity miss " .. tostring(para1))
      end
    end
    local buffNmae, buffDes
    if moduleType == eLogicDesType.Warchess then
      local wcBuffCfg = ConfigData.warchess_buff[para2]
      if wcBuffCfg == nil then
        error("cant get warchess_buff cfg, buffId:" .. tostring(para2))
        return
      end
      buffNmae = LanguageUtil.GetLocaleText(wcBuffCfg.name)
      buffDes = LanguageUtil.GetLocaleText(wcBuffCfg.description)
    else
      local buffCfg = ConfigData.exploration_buff[para2]
      if buffCfg == nil then
        error("cant get exploration_buff cfg, buffId:" .. tostring(para2))
        return
      end
      buffNmae = LanguageUtil.GetLocaleText(buffCfg.name)
      buffDes = LanguageUtil.GetLocaleText(buffCfg.describe)
    end
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), actName, buffNmae, "", buffDes)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), actName, buffNmae)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), actName, buffNmae)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_DeleteBuff] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_DeleteBuff, moduleType)
    if logicDesCfg == nil then
      return
    end
    local longDes, shortDes, valueDes, actName
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(para1)
    if activityFrameData ~= nil then
      actName = activityFrameData.name
    else
      actName = ""
      if isGameDev then
        error("activity miss " .. tostring(para1))
      end
    end
    local buffNmae, buffDes
    local buffCfg = ConfigData.exploration_buff[para2]
    buffNmae = LanguageUtil.GetLocaleText(buffCfg.name)
    buffDes = LanguageUtil.GetLocaleText(buffCfg.describe)
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), actName, buffNmae, "", buffDes)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), actName, buffNmae)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), actName, buffNmae)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_PowTestChipGroupLimitAdd] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_PowTestChipGroupLimitAdd, moduleType)
    if logicDesCfg == nil then
      return
    end
    local longDes, shortDes, valueDes, actName
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(para1)
    if activityFrameData ~= nil then
      actName = activityFrameData.name
    else
      actName = ""
      if isGameDev then
        error("activity miss " .. tostring(para1))
      end
    end
    local suitName
    local tagSuitCfg = ConfigData.chip_tag[para2]
    suitName = LanguageUtil.GetLocaleText(tagSuitCfg.tag_name)
    local addCouldUseNum = tostring(para3)
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), actName, suitName, addCouldUseNum)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), actName, suitName, addCouldUseNum)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), actName, suitName, addCouldUseNum)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_ChipGroupCarryLimitAdd] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_ChipGroupCarryLimitAdd, moduleType)
    if logicDesCfg == nil then
      return
    end
    local longDes, shortDes, valueDes, actName
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(para1)
    if activityFrameData ~= nil then
      actName = activityFrameData.name
    else
      actName = ""
      if isGameDev then
        error("activity miss " .. tostring(para1))
      end
    end
    local addCouldPickNum = tostring(para2)
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), actName, addCouldPickNum)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), actName, addCouldPickNum)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), actName, addCouldPickNum)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.FormationAttriAdd] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.FormationAttriAdd, moduleType)
    if logicDesCfg == nil then
      return
    end
    local attributeCfg = ConfigData.attribute[para1]
    if attributeCfg == nil then
      return
    end
    local longDes, shortDes, valueDes, attriName, attriVal
    if 0 < (attributeCfg.merge_attribute or 0) then
      attriName = LanguageUtil.GetLocaleText(ConfigData.attribute[attributeCfg.merge_attribute].name)
    else
      attriName = LanguageUtil.GetLocaleText(attributeCfg.name)
    end
    if attributeCfg.num_type == 2 then
      attriVal = tostring(FormatNum(para2 / 10)) .. "%"
    else
      attriVal = tostring(FormatNum(para2))
    end
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), attriName, attriVal)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), attriName, attriVal)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), attriName, attriVal)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_AttriAdd] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_AttriAdd, moduleType)
    if logicDesCfg == nil then
      return
    end
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(para1)
    if activityFrameData == nil then
      return
    end
    local attributeCfg = ConfigData.attribute[para2]
    if attributeCfg == nil then
      return
    end
    local longDes, shortDes, valueDes
    local actName = activityFrameData.name
    local attriName, attriVal
    if 0 < (attributeCfg.merge_attribute or 0) then
      attriName = LanguageUtil.GetLocaleText(ConfigData.attribute[attributeCfg.merge_attribute].name)
    else
      attriName = LanguageUtil.GetLocaleText(attributeCfg.name)
    end
    if attributeCfg.num_type == 2 then
      attriVal = tostring(FormatNum(para3 / 10)) .. "%"
    else
      attriVal = tostring(FormatNum(para3))
    end
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), actName, attriName, attriVal)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), actName, attriName, attriVal)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), actName, attriName, attriVal)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_UnlockInitBuff] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_UnlockInitBuff, moduleType)
    if logicDesCfg == nil then
      return
    end
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(para1)
    if activityFrameData == nil then
      return
    end
    local buffCfg = ConfigData.exploration_buff[para2]
    if buffCfg == nil then
      return
    end
    local longDes, shortDes, valueDes
    local actName = activityFrameData.name
    local buffName = LanguageUtil.GetLocaleText(buffCfg.name)
    local buffDes = LanguageUtil.GetLocaleText(buffCfg.describe)
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), actName, buffName, buffDes)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), actName, buffName, buffDes)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), actName, buffName, buffDes)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_UnlockStoreBuff] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_UnlockStoreBuff, moduleType)
    if logicDesCfg == nil then
      return
    end
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(para1)
    if activityFrameData == nil then
      return
    end
    local buffCfg = ConfigData.exploration_buff[para2]
    if buffCfg == nil then
      return
    end
    local longDes, shortDes, valueDes
    local actName = activityFrameData.name
    local buffName = LanguageUtil.GetLocaleText(buffCfg.name)
    local buffDes = LanguageUtil.GetLocaleText(buffCfg.describe)
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), actName, buffName, buffDes)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), actName, buffName, buffDes)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), actName, buffName, buffDes)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_CommanderAttriAdd] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_CommanderAttriAdd, moduleType)
    if logicDesCfg == nil then
      return
    end
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(para1)
    if activityFrameData == nil then
      return
    end
    local attributeCfg = ConfigData.attribute[para2]
    if attributeCfg == nil then
      return
    end
    local longDes, shortDes, valueDes
    local actName = activityFrameData.name
    local attriVal
    if attributeCfg.cmd_num_type == 2 then
      attriVal = tostring(FormatNum(para3 / 10)) .. "%"
    else
      attriVal = tostring(FormatNum(para3))
    end
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), actName, attriVal)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), actName, attriVal)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), actName, attriVal)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_InitialItemAdd] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_InitialItemAdd, moduleType)
    if logicDesCfg == nil then
      return
    end
    local itemCfg = ConfigData.item[para2]
    local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
    local longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), nil, itemName, para3)
    local shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), nil, itemName, para3)
    local valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), nil, itemName, para3)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_InitialBuffAdd] = function(para1, para2, para3, moduleType)
    local wcBuffCfg = ConfigData.warchess_buff[para2]
    if wcBuffCfg == nil then
      error(string.format("cant get warchess_buff cfg, buffId:%s,logicId:%s,para1:%s,para2:%s", para2, eLogicType.Activity_InitialBuffAdd, para1, para2))
      return
    end
    local des = LanguageUtil.GetLocaleText(wcBuffCfg.description)
    local longDes = des
    return longDes
  end,
  [eLogicType.SeasonRoomAddItem] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.SeasonRoomAddItem, moduleType)
    if logicDesCfg == nil then
      return
    end
    local roomCfg = ConfigData.warchess_room_type[para1]
    if roomCfg == nil then
      error(" roomType is nil " .. tostring(para1))
      return
    end
    local roomName = LanguageUtil.GetLocaleText(roomCfg.type_name)
    local itemCfg = ConfigData.item[para2]
    local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
    local longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), roomName, itemName, para3)
    local shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), roomName, itemName, para3)
    local valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), roomName, itemName, para3)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.SeasonEnterAddItem] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.SeasonEnterAddItem, moduleType)
    if logicDesCfg == nil then
      return
    end
    local itemCfg = ConfigData.item[para2]
    local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
    local longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), nil, itemName, para3)
    local shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), nil, itemName, para3)
    local valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), nil, itemName, para3)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.Activity_Mode_UnlockBuff] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.Activity_Mode_UnlockBuff, moduleType)
    if logicDesCfg == nil then
      return
    end
    local longDes, shortDes, valueDes, actName
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(para1)
    if activityFrameData ~= nil then
      actName = activityFrameData.name
    else
      actName = ""
      if isGameDev then
        error("activity miss " .. tostring(para1))
      end
    end
    local buffNmae, buffDes
    if para2 or 0 < 0 then
      local buffCfg = ConfigData.exploration_buff[para2]
      if buffCfg == nil then
        error("cant get exploration_buff cfg, buffId:" .. tostring(para2))
        return
      end
      buffNmae = LanguageUtil.GetLocaleText(buffCfg.name)
      buffDes = LanguageUtil.GetLocaleText(buffCfg.describe)
    elseif para3 or 0 < 0 then
      local wcBuffCfg = ConfigData.warchess_buff[para2]
      if wcBuffCfg == nil then
        error("cant get warchess_buff cfg, buffId:" .. tostring(para2))
        return
      end
      buffNmae = LanguageUtil.GetLocaleText(wcBuffCfg.name)
      buffDes = LanguageUtil.GetLocaleText(wcBuffCfg.description)
    elseif isGameDev then
      error(" Activity_ChessOrEx_UnlockBuff param2 and param3 error ")
    end
    longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), actName, buffNmae, "", buffDes)
    shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), actName, buffNmae)
    valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), actName, buffNmae)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.DungeonDropNumAdd] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.DungeonDropNumAdd, moduleType)
    if logicDesCfg == nil then
      return
    end
    local longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), nil, para2)
    return longDes
  end,
  [eLogicType.DungeonRewardRateNumAdd] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.DungeonRewardRateNumAdd, moduleType)
    if logicDesCfg == nil then
      return
    end
    local longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), nil, nil, para3)
    return longDes
  end,
  [eLogicType.AllFriendshipAdd] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.AllFriendshipAdd, moduleType)
    if logicDesCfg == nil then
      return
    end
    local longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), para1)
    return longDes
  end,
  [eLogicType.ResourceGoodBuyNumAdd] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.ResourceGoodBuyNumAdd, moduleType)
    if logicDesCfg == nil then
      return
    end
    local longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), nil, nil, para3)
    return longDes
  end,
  [eLogicType.BattleBuffAdd] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.BattleBuffAdd, moduleType)
    if logicDesCfg == nil then
      return
    end
    local buffCfg = ConfigData.exploration_buff[para1]
    if buffCfg.logic ~= 9 then
      error("not support global buff type")
      return "?", "?", "?"
    end
    local buffNmae = LanguageUtil.GetLocaleText(buffCfg.name)
    local buffDes = ConfigData:GetChipDescriptionById(buffCfg.logic_num[1], para2 or 1, true)
    local longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), buffNmae, buffDes)
    local shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), buffNmae, buffDes)
    local valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), buffNmae, buffDes)
    return longDes, shortDes, valueDes
  end,
  [eLogicType.BattleAttrAdd] = function(para1, para2, para3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.BattleAttrAdd, moduleType)
    local attributeCfg = ConfigData.attribute[para1]
    if attributeCfg == nil then
      return
    end
    local attrName = LanguageUtil.GetLocaleText(attributeCfg.name)
    local attrValue = para2
    if attributeCfg.num_type == 2 then
      attrValue = tostring(FormatNum(attrValue / 10)) .. "%"
    else
      attrValue = tostring(FormatNum(attrValue))
    end
    local longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), attrName, tostring(attrValue))
    local shortDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.short_des), attrName, tostring(attrValue))
    local valueDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.value), attrName, tostring(attrValue))
    return longDes, shortDes, valueDes
  end
}
local MergeType = {
  equal = 1,
  add = 2,
  max = 3
}
local MergeInfoTable = {
  [eLogicType.ResourceLimit] = {
    [1] = MergeType.equal,
    [2] = MergeType.add
  },
  [eLogicType.ResourceOutput] = {donotMerge = true},
  [eLogicType.CampBuff] = {
    [1] = MergeType.equal,
    [2] = MergeType.equal,
    [3] = MergeType.add
  },
  [eLogicType.CareerBuff] = {
    [1] = MergeType.equal,
    [2] = MergeType.equal,
    [3] = MergeType.add
  },
  [eLogicType.FactoryPipelie] = {
    [1] = MergeType.add
  },
  [eLogicType.GlobalExpCeiling] = {
    [1] = MergeType.add
  },
  [eLogicType.StaminaCeiling] = {
    [1] = MergeType.add
  },
  [eLogicType.StaminaOutput] = {
    [1] = MergeType.add
  },
  [eLogicType.ResOutputEfficiency] = {
    [1] = MergeType.equal,
    [2] = MergeType.add
  },
  [eLogicType.BuildQueue] = {
    [1] = MergeType.equal,
    [2] = MergeType.add
  },
  [eLogicType.BuildSpeed] = {
    [1] = MergeType.add
  },
  [eLogicType.GlobalExpRatio] = {
    [1] = MergeType.add
  },
  [eLogicType.AllHeroBuff] = {
    [1] = MergeType.equal,
    [2] = MergeType.add
  },
  [eLogicType.OverClock] = {
    [1] = MergeType.equal,
    [2] = MergeType.max
  },
  [eLogicType.OverClockFreeNum] = {
    [1] = MergeType.add
  },
  [eLogicType.FocusPointCeiling] = {
    [1] = MergeType.add
  },
  [eLogicType.BattleExpBonus] = {
    [1] = MergeType.add
  },
  [eLogicType.DynSkillUpgrade] = {
    [1] = MergeType.add
  },
  [eLogicType.DynChipCountMax] = {
    [1] = MergeType.add
  },
  [eLogicType.AutoRecoverItem] = {
    [1] = MergeType.equal,
    [2] = MergeType.add
  },
  [eLogicType.DungeonCountAdd] = {
    [1] = MergeType.equal,
    [2] = MergeType.add
  },
  [eLogicType.DungeonRewardExtraNum] = {
    [1] = MergeType.add
  },
  [eLogicType.FriendshipBonus] = {
    [1] = MergeType.add
  },
  [eLogicType.DailyFixedOutput] = {
    [1] = MergeType.equal,
    [2] = MergeType.equal,
    [3] = MergeType.add
  },
  [eLogicType.Activity_PointMultRate] = {
    [1] = MergeType.equal,
    [2] = MergeType.equal,
    [3] = MergeType.add
  },
  [eLogicType.Activity_Stamina2PointMultRate] = {
    [1] = MergeType.equal,
    [2] = MergeType.equal,
    [3] = MergeType.add
  },
  [eLogicType.Activity_EffiMultRate] = {
    [1] = MergeType.equal,
    [2] = MergeType.max
  },
  [eLogicType.Activity_AttriAdd] = {
    [1] = MergeType.equal,
    [2] = MergeType.equal,
    [3] = MergeType.add
  },
  [eLogicType.Activity_InitialItemAdd] = {
    [1] = MergeType.equal,
    [2] = MergeType.equal,
    [3] = MergeType.add
  },
  [eLogicType.Activity_InitialBuffAdd] = {
    [1] = MergeType.equal,
    [2] = MergeType.equal,
    [3] = MergeType.add
  },
  [eLogicType.SeasonEnterAddItem] = {
    [1] = MergeType.equal,
    [2] = MergeType.equal,
    [3] = MergeType.add
  },
  [eLogicType.BattleBuffAdd] = {
    [1] = MergeType.equal,
    [2] = MergeType.max
  },
  [eLogicType.BattleAttrAdd] = {
    [1] = MergeType.equal,
    [2] = MergeType.add
  }
}
local GetDesAboutLvDiffFuncTable = {
  [eLogicType.FormationAttriAdd] = function(para1, para2, para3, nextPara1, nextPara2, nextPara3, moduleType)
    if para1 ~= nil and nextPara1 ~= nil and para1 ~= nextPara1 then
      error("attriId different")
      return nil, nil, nil
    end
    local buildBuffCfg = ConfigData.buildingBuff[eLogicType.FormationAttriAdd]
    local attriId = para1 ~= nil and para1 or nextPara1
    local attriCfg = ConfigData.attribute[attriId]
    if attriCfg == nil then
      error("attriId Miss")
      return nil, nil, nil
    end
    local context = LanguageUtil.GetLocaleText(buildBuffCfg.buff_text_context)
    context = string.format(context, LanguageUtil.GetLocaleText(attriCfg.name))
    local curValueStr, nextValueStr
    local curAttrVal = para2 or 0
    curValueStr = attriCfg.num_type == 2 and tostring(tostring(FormatNum(curAttrVal / 10)) .. "%") or tostring(curAttrVal)
    if nextPara2 ~= nil then
      nextValueStr = attriCfg.num_type == 2 and tostring(tostring(FormatNum(nextPara2 / 10)) .. "%") or tostring(nextPara2)
    end
    return context, curValueStr, nextValueStr
  end
}
local GetDesAboutLvUpFuncTable = {
  [eLogicType.BattleBuffAdd] = function(para1, para2, para3, nextPara1, nextPara2, nextPara3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.BattleBuffAdd, moduleType)
    if logicDesCfg == nil then
      return
    end
    local buffCfg = ConfigData.exploration_buff[para1]
    if ConfigData.dungeon_buff[para1] == nil or ConfigData.warchess_buff[para1] == nil then
    end
    if buffCfg.logic ~= 9 then
      error("not support global buff type")
      return "?"
    end
    local buffNmae = LanguageUtil.GetLocaleText(buffCfg.name)
    local buffDes = ConfigData:GetChipDescriptionById(buffCfg.logic_num[1], para2 or 1, true)
    local nextBuffCfg = ConfigData.exploration_buff[nextPara1]
    if ConfigData.dungeon_buff[para1] == nil or ConfigData.warchess_buff[para1] == nil then
    end
    if nextBuffCfg.logic ~= 9 then
      error("not support global buff type")
      return "?"
    end
    local nextBuffNmae = LanguageUtil.GetLocaleText(nextBuffCfg.name)
    local nextBuffDes = ConfigData:GetChipDescriptionById(nextBuffCfg.logic_num[1], nextPara2 or 1, true)
    local longDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), buffNmae, buffDes)
    local nextLongDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), nextBuffNmae, nextBuffDes)
    local nextLevelStr = ConfigData:GetTipContent(13500)
    local combainDes
    if buffNmae == nextBuffNmae then
      combainDes = string.format([[
%s
%s]], longDes, string.format(nextLevelStr, nextBuffDes))
    else
      combainDes = string.format([[
%s
%s]], longDes, string.format(nextLevelStr, nextLongDes))
    end
    return combainDes
  end,
  [eLogicType.BattleAttrAdd] = function(para1, para2, para3, nextPara1, nextPara2, nextPara3, moduleType)
    local logicDesCfg = GetCommonLogicDesConfig(eLogicType.BattleAttrAdd, moduleType)
    local attributeCfg = ConfigData.attribute[para1]
    if attributeCfg == nil then
      return
    end
    local attrName = LanguageUtil.GetLocaleText(attributeCfg.name)
    local attrValue = para2
    if attributeCfg.num_type == 2 then
      attrValue = tostring(FormatNum(attrValue / 10)) .. "%"
    else
      attrValue = tostring(FormatNum(attrValue))
    end
    local nextAttributeCfg = ConfigData.attribute[nextPara1]
    if nextAttributeCfg == nil then
      return
    end
    local nextAttrName = LanguageUtil.GetLocaleText(nextAttributeCfg.name)
    local nextAttrValue = nextPara2
    if nextAttributeCfg.num_type == 2 then
      nextAttrValue = tostring(FormatNum(nextAttrValue / 10)) .. "%"
    else
      nextAttrValue = tostring(FormatNum(nextAttrValue))
    end
    local nextLevelStr = ConfigData:GetTipContent(13500)
    local combainDes
    if para1 == nextPara1 then
      local combained = tostring(attrValue) .. string.format(nextLevelStr, nextAttrValue)
      combainDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), attrName, combained)
    else
      local nextLevel = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), nextAttrName, tostring(nextAttrValue))
      combainDes = GR.StringFormat(LanguageUtil.GetLocaleText(logicDesCfg.intro), attrName, tostring(attrValue)) .. string.format(nextLevelStr, nextLevel)
    end
    return combainDes
  end
}

function CommonLogicUtil.GetDesString(logic, para1, para2, para3, moduleType)
  local desFunc = GetDesFuncTable[logic]
  if desFunc == nil then
    return ""
  else
    return desFunc(para1, para2, para3, moduleType)
  end
end

function CommonLogicUtil:GetDesAboutLvDiff(logics, para1s, para2s, para3s, nextLogics, nextPara1s, nextPara2s, nextPara3s)
  if logics ~= nil and nextLogics ~= nil and #logics ~= #nextLogics then
    error("count different")
    return nil
  elseif logics == nil and nextLogics == nil then
    error("logics is NIL")
    return nil
  end
  local list = {}
  if logics == nil then
    for index, logicId in ipairs(nextLogics) do
      local func = GetDesAboutLvDiffFuncTable[logicId]
      if func == nil then
        error(" not have DesAboutLvDiffFunc ")
      else
        local des, curVal, nextVal, combainDes = func(nil, nil, nil, nextPara1s[index], nextPara2s[index], nextPara3s[index])
        table.insert(list, {
          logicId = logicId,
          currentInfo = des,
          curValue = curVal,
          nextInfoValue = nextVal
        })
      end
    end
  elseif nextLogics == nil then
    for index, logicId in ipairs(logics) do
      local func = GetDesAboutLvDiffFuncTable[logicId]
      if func == nil then
        error(" not have DesAboutLvDiffFunc ")
      else
        local des, curVal, nextVal = func(para1s[index], para2s[index], para3s[index], nil, nil, nil)
        table.insert(list, {
          logicId = logicId,
          currentInfo = des,
          curValue = curVal,
          nextInfoValue = nextVal
        })
      end
    end
  else
    for index, logicId in ipairs(logics) do
      if nextLogics[index] ~= logicId then
        error(" logicId different ")
      else
        local func = GetDesAboutLvDiffFuncTable[logicId]
        if func == nil then
          error(" not have DesAboutLvDiffFunc ")
        else
          local des, curVal, nextVal = func(para1s[index], para2s[index], para3s[index], nextPara1s[index], nextPara2s[index], nextPara3s[index])
          table.insert(list, {
            logicId = logicId,
            currentInfo = des,
            curValue = curVal,
            nextInfoValue = nextVal
          })
        end
      end
    end
  end
  return list
end

function CommonLogicUtil:GetDesAboutLvUpDes(logics, para1s, para2s, para3s, nextLogics, nextPara1s, nextPara2s, nextPara3s, moduleType)
  if logics ~= nil and nextLogics ~= nil and #logics ~= #nextLogics then
    error("count different")
    return nil
  elseif logics == nil and nextLogics == nil then
    error("logics is NIL")
    return nil
  end
  local list = {}
  for index, logicId in ipairs(logics) do
    if nextLogics[index] ~= logicId then
      error(" logicId different ")
    else
      local func = GetDesAboutLvUpFuncTable[logicId]
      if func == nil then
        error(" not have DesAboutLvDiffFunc ")
      else
        local combainDes = func(para1s[index], para2s[index], para3s[index], nextPara1s[index], nextPara2s[index], nextPara3s[index], moduleType)
        table.insert(list, combainDes)
      end
    end
  end
  return list
end

function CommonLogicUtil.CLUEnableLoopLv(level)
  CommonLogicUtil._EnableLoopLv = level
end

function CommonLogicUtil.GetLogicDesStrMultiLine(logic_list, para1_list, para2_List, para3_list, moduleType)
  local des
  for index, logic in pairs(logic_list) do
    local para1 = para1_list[index]
    local para2 = para2_List[index]
    local para3 = para3_list[index]
    if CommonLogicUtil._EnableLoopLv ~= nil then
      para1, para2, para3 = CommonLogicUtil.GetLoopLevelPara(CommonLogicUtil._EnableLoopLv, logic, para1, para2, para3)
    end
    if string.IsNullOrEmpty(des) then
      des = CommonLogicUtil.GetDesString(logic, para1, para2, para3, moduleType)
    else
      des = des .. "\n" .. CommonLogicUtil.GetDesString(logic, para1, para2, para3, moduleType)
    end
  end
  CommonLogicUtil.CLUEnableLoopLv(nil)
  return des
end

function CommonLogicUtil.MergeLogic(logicDic, logic, paras)
  local logicParaTable = logicDic[logic]
  if logicParaTable == nil then
    logicDic[logic] = {}
    for index, value in ipairs(paras) do
      logicDic[logic][index] = {}
      logicDic[logic][index][1] = value
    end
    return logicDic
  end
  local mergeInfo = MergeInfoTable[logic]
  if mergeInfo == nil or mergeInfo.donotMerge then
    for index, para in ipairs(paras) do
      if logicParaTable[index] ~= nil then
        table.insert(logicParaTable[index], para)
      end
    end
  else
    local isMerged = false
    for groupIndex, _ in ipairs(logicParaTable[1]) do
      local couldMerge = true
      local tempParas = {}
      for paraindex, type in ipairs(mergeInfo) do
        if type == MergeType.equal then
          if logicParaTable[paraindex][groupIndex] ~= paras[paraindex] then
            couldMerge = false
            break
          else
            tempParas[paraindex] = logicParaTable[paraindex][groupIndex]
          end
        elseif type == MergeType.add then
          tempParas[paraindex] = logicParaTable[paraindex][groupIndex] + paras[paraindex]
        elseif type == MergeType.max then
          tempParas[paraindex] = math.max(logicParaTable[paraindex][groupIndex], paras[paraindex])
        end
      end
      if couldMerge then
        for index, type in ipairs(mergeInfo) do
          logicParaTable[index][groupIndex] = tempParas[index]
        end
        isMerged = true
        break
      end
    end
    if not isMerged then
      for index, para in ipairs(paras) do
        table.insert(logicParaTable[index], para)
      end
    end
  end
  return logicDic
end

function CommonLogicUtil.MinLogicCfg(cfg, front_cfg)
  if front_cfg == nil then
    return cfg.logic, cfg.para1, cfg.para2, cfg.para3
  else
    local logic_out = {}
    local para1_out = {}
    local para2_out = {}
    local para3_out = {}
    for index, logic in ipairs(cfg.logic) do
      local paras = {
        cfg.para1[index],
        cfg.para2[index],
        cfg.para3[index]
      }
      local success = false
      for index, front_logic in ipairs(front_cfg.logic) do
        local tempparas = {
          front_cfg.para1[index],
          front_cfg.para2[index],
          front_cfg.para3[index]
        }
        if logic == front_logic then
          success, paras = CommonLogicUtil.MinLogic(logic, paras, front_logic, tempparas)
        else
          success = true
        end
        if not success then
          error("common logic can't min")
          return cfg.logic, cfg.para1, cfg.para2, cfg.para3
        elseif paras == nil then
          break
        end
      end
      if paras ~= nil then
        table.insert(logic_out, logic)
        table.insert(para1_out, paras[1])
        table.insert(para2_out, paras[2])
        table.insert(para3_out, paras[3])
      end
    end
    return logic_out, para1_out, para2_out, para3_out
  end
end

function CommonLogicUtil.MinLogic(logic1, argList1, logic2, argList2)
  if logic1 ~= logic2 then
    warn("use diff logic to min logic1:" .. tostring(logic1) .. " logic2:" .. tostring(logic2))
    return false
  end
  local mergeInfo = MergeInfoTable[logic1]
  if mergeInfo == nil or #mergeInfo > #argList1 then
    error("not have mergeInfo or mergeInfo error")
    return false
  end
  local argList = {}
  for index, type in ipairs(mergeInfo) do
    if type == MergeType.equal then
      if argList1[index] ~= argList2[index] then
        return true, argList1
      else
        argList[index] = argList1[index]
      end
    elseif type == MergeType.add then
      argList[index] = argList1[index] - argList2[index]
      if argList[index] == 0 then
        return true, nil
      end
    elseif type == MergeType.max then
      argList[index] = argList1[index] - argList2[index]
      if argList[index] == 0 then
        return true, nil
      end
    end
  end
  return true, argList
end

local LoopLvFunc = {
  [eLogicType.Activity_AttriAdd] = function(level, para1, para2, para3)
    return para1, para2 * level, para3
  end,
  [eLogicType.Activity_InitialItemAdd] = function(level, para1, para2, para3)
    return para1, para2, para3 * level
  end
}

function CommonLogicUtil.GetLoopLevelPara(level, logic, para1, para2, para3)
  local func = LoopLvFunc[logic]
  if func == nil then
    error("Unsupported LoopLvFunc, logic = " .. tostring(logic))
    return para1, para2, para3
  end
  return func(level, para1, para2, para3)
end

function CommonLogicUtil.GetMergeInfoTable(logic)
  return MergeInfoTable[logic], MergeType
end

return CommonLogicUtil
