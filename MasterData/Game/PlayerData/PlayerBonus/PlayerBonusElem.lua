local PlayerBonusElem = class("PlayerBonusElem")

local function InitFunc1Para(self)
  self.totalData = 0
end

local function InitFunc2Para(self)
  self.totalData = table.GetDefaulValueTable(0)
end

local function InitFunc3Para(self)
  self.totalData = {}
end

local InitFuncDic = {
  [eLogicType.ResourceLimit] = function(self)
    InitFunc2Para(self)
  end,
  [eLogicType.FactoryPipelie] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.GlobalExpCeiling] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.ResOutputEfficiency] = function(self)
    InitFunc2Para(self)
  end,
  [eLogicType.BuildQueue] = function(self)
    InitFunc2Para(self)
  end,
  [eLogicType.BuildSpeed] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.GlobalExpRatio] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.OverClock] = function(self)
    InitFunc2Para(self)
  end,
  [eLogicType.OverClockFreeNum] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.FocusPointCeiling] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.BattleExpBonus] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.DynSkillUpgrade] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.DynPlayerAttrBuff] = function(self)
    InitFunc2Para(self)
  end,
  [eLogicType.DungeonRewardRate] = function(self)
    self.totalData = {}
    self.dungeonActivityIdDic = {}
  end,
  [eLogicType.HeroLevelCeiling] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.AutoRecoverItem] = function(self)
    InitFunc2Para(self)
  end,
  [eLogicType.DungeonCountAdd] = function(self)
    InitFunc2Para(self)
  end,
  [eLogicType.FactoryEfficiency] = function(self)
    InitFunc2Para(self)
  end,
  [eLogicType.ResOutputCeiling] = function(self)
    InitFunc2Para(self)
  end,
  [eLogicType.ChipCeilingCostReduce] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.EpInitItemAddtion] = function(self)
    InitFunc2Para(self)
  end,
  [eLogicType.EpBattleRoomGetExr] = function(self)
    InitFunc2Para(self)
  end,
  [eLogicType.SupportCountAddtion] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.HpRecoverInRecoveryRoom] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.OverClockCountAddtion] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.Activity_PointMultRate] = InitFunc3Para,
  [eLogicType.Activity_Stamina2PointMultRate] = InitFunc3Para,
  [eLogicType.Activity_EffiMultRate] = InitFunc2Para,
  [eLogicType.Activity_ChipGroupLevel] = InitFunc3Para,
  [eLogicType.Activity_UnlockBuff] = function(self)
    InitFunc3Para(self)
  end,
  [eLogicType.Activity_DeleteBuff] = function(self)
    InitFunc3Para(self)
  end,
  [eLogicType.Activity_PowTestChipGroupLimitAdd] = InitFunc3Para,
  [eLogicType.Activity_ChipGroupCarryLimitAdd] = InitFunc2Para,
  [eLogicType.DungeonShareRewardRate] = function(self, uid, para1, para2, para3)
    self.totalData = {}
    self.dungeonActivityIdDic = {}
  end,
  [eLogicType.DungeonDropNumAdd] = function(self)
    InitFunc2Para(self)
  end,
  [eLogicType.DungeonRewardRateNumAdd] = function(self)
    InitFunc3Para(self)
  end,
  [eLogicType.AllFriendshipAdd] = function(self)
    InitFunc1Para(self)
  end,
  [eLogicType.ResourceGoodBuyNumAdd] = function(self)
    InitFunc3Para(self)
  end
}

local function InstallFunc1Para(self, uid, para1, para2, para3)
  local ori = self.categoryDataDic[uid]
  self.categoryDataDic[uid] = para1
  if ori ~= nil then
    self.totalData = self.totalData - ori
  end
  self.totalData = self.totalData + para1
end

local function InstallFunc2Para(self, uid, para1, para2, para3)
  local data = self.categoryDataDic[uid]
  if data == nil then
    data = {}
    self.categoryDataDic[uid] = data
  end
  local ori = data[para1] or 0
  data[para1] = para2
  if para2 >= ori then
    self.totalData[para1] = self.totalData[para1] + para2 - ori
  else
    local diff = ori - para2
    if diff < self.totalData[para1] then
      self.totalData[para1] = self.totalData[para1] - diff
    else
      self.totalData[para1] = nil
    end
  end
end

local function InstallFunc2ParaMaxValue(self, uid, para1, para2, para3)
  local data = self.categoryDataDic[uid]
  if data == nil then
    data = {}
    self.categoryDataDic[uid] = data
  end
  data[para1] = para2
  self.totalData[para1] = math.max(self.totalData[para1], para2)
end

local function InstallFunc3Para(self, uid, para1, para2, para3)
  local data = self.categoryDataDic[uid]
  if data == nil then
    data = {}
    self.categoryDataDic[uid] = data
  end
  if data[para1] == nil then
    data[para1] = {}
  end
  local ori = data[para1][para2] or 0
  data[para1][para2] = para3
  if self.totalData[para1] == nil then
    self.totalData[para1] = {}
  end
  local oriTotal = self.totalData[para1][para2] or 0
  if para3 >= ori then
    self.totalData[para1][para2] = oriTotal + para3 - ori
  else
    local diff = ori - para3
    if oriTotal > diff then
      self.totalData[para1][para2] = oriTotal - diff
    else
      self.totalData[para1][para2] = nil
    end
  end
end

local function InstallFunc3ParaMaxValue(self, uid, para1, para2, para3)
  local data = self.categoryDataDic[uid]
  if data == nil then
    data = {}
    self.categoryDataDic[uid] = data
  end
  if data[para1] == nil then
    data[para1] = {}
  end
  local ori = data[para1][para2] or 0
  data[para1][para2] = para3
  if para3 >= ori then
    if self.totalData[para1] == nil then
      self.totalData[para1] = {}
    end
    self.totalData[para1][para2] = para3
  end
end

local InstallFuncDic = {
  [eLogicType.ResourceLimit] = function(self, uid, para1, para2, para3)
    InstallFunc2Para(self, uid, para1, para2, para3)
    PlayerDataCenter.playerBonus:AddPlayerBonusBroadcast("warehouse")
  end,
  [eLogicType.CampBuff] = function(self, uid, para1, para2, para3)
    local data = self.categoryDataDic[uid]
    if data == nil then
      data = {}
      self.categoryDataDic[uid] = data
    end
    if data[para1] == nil then
      data[para1] = {}
    end
    if data[para1][para2] ~= nil then
      PlayerDataCenter.attributeBonus:RemoveCampBonus(para1, para2, data[para1][para2])
    end
    data[para1][para2] = para3
    PlayerDataCenter.attributeBonus:AddCampBonus(para1, para2, para3)
  end,
  [eLogicType.CareerBuff] = function(self, uid, para1, para2, para3)
    local data = self.categoryDataDic[uid]
    if data == nil then
      data = {}
      self.categoryDataDic[uid] = data
    end
    if data[para1] == nil then
      data[para1] = {}
    end
    if data[para1][para2] ~= nil then
      PlayerDataCenter.attributeBonus:RemoveCareerBonus(para1, para2, data[para1][para2])
    end
    data[para1][para2] = para3
    PlayerDataCenter.attributeBonus:AddCareerBonus(para1, para2, para3)
  end,
  [eLogicType.FactoryPipelie] = function(self, uid, para1, para2, para3)
    InstallFunc1Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.GlobalExpCeiling] = function(self, uid, para1, para2, para3)
    InstallFunc1Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.ResOutputEfficiency] = function(self, uid, para1, para2, para3)
    InstallFunc2Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.BuildQueue] = function(self, uid, para1, para2, para3)
    InstallFunc2Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.BuildSpeed] = function(self, uid, para1, para2, para3)
    InstallFunc1Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.GlobalExpRatio] = function(self, uid, para1, para2, para3)
    InstallFunc1Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.AllHeroBuff] = function(self, uid, para1, para2, para3)
    local data = self.categoryDataDic[uid]
    if data == nil then
      data = {}
      self.categoryDataDic[uid] = data
    end
    if data[para1] ~= nil then
      PlayerDataCenter.attributeBonus:RemoveAllBonus(para1, data[para1])
    end
    data[para1] = para2
    PlayerDataCenter.attributeBonus:AddAllBonus(para1, para2)
  end,
  [eLogicType.OverClock] = function(self, uid, para1, para2, para3)
    local data = self.categoryDataDic[uid]
    if data == nil then
      data = {}
      self.categoryDataDic[uid] = data
    end
    local ori = data[para1] or 0
    data[para1] = math.max(ori, para2)
    self.totalData[para1] = math.max(para2, self.totalData[para1] or 0)
  end,
  [eLogicType.OverClockFreeNum] = function(self, uid, para1, para2, para3)
    InstallFunc1Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.FocusPointCeiling] = function(self, uid, para1, para2, para3)
    InstallFunc1Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.BattleExpBonus] = function(self, uid, para1, para2, para3)
    InstallFunc1Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.DynSkillUpgrade] = function(self, uid, para1, para2, para3)
    InstallFunc1Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.DynPlayerAttrBuff] = function(self, uid, para1, para2, para3)
    InstallFunc2Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.DungeonRewardRate] = function(self, uid, para1, para2, para3)
    local data = self.categoryDataDic[uid]
    if data == nil then
      data = {}
      self.categoryDataDic[uid] = data
    end
    if data[para1] == nil then
      data[para1] = {}
    end
    data[para1][para2] = math.max(data[para1][para2] or 0, para3)
    if self.totalData[para1] == nil then
      self.totalData[para1] = {}
    end
    self.totalData[para1][para2] = math.max(para3, self.totalData[para1][para2] or 0)
    local moduelId = uid >> 32
    if moduelId == proto_csmsg_SystemFunctionID.SystemFunctionID_Double_Active then
      local activitiId = uid & CommonUtil.UInt32Max
      self.dungeonActivityIdDic[para1] = self.dungeonActivityIdDic[para1] or {}
      self.dungeonActivityIdDic[para1][activitiId] = self.dungeonActivityIdDic[para1][activitiId] or {}
      self.dungeonActivityIdDic[para1][activitiId] = true
    end
  end,
  [eLogicType.HeroLevelCeiling] = function(self, uid, para1, para2, para3)
    InstallFunc1Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.AutoRecoverItem] = function(self, uid, para1, para2, para3)
    InstallFunc2Para(self, uid, para1, para2, para3)
    PlayerDataCenter.playerBonus:AddPlayerBonusBroadcast("AutoRecoverItem")
  end,
  [eLogicType.DungeonCountAdd] = function(self, uid, para1, para2, para3)
    InstallFunc2Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.FactoryEfficiency] = function(self, uid, para1, para2, para3)
    InstallFunc2Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.ResOutputCeiling] = function(self, uid, para1, para2, para3)
    InstallFunc2Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.ChipCeilingCostReduce] = function(self, uid, para1, para2, para3)
    InstallFunc1Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.EpInitItemAddtion] = function(self, uid, para1, para2, para3)
    InstallFunc2Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.EpBattleRoomGetExr] = function(self, uid, para1, para2, para3)
    InstallFunc2Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.SupportCountAddtion] = function(self, uid, para1, para2, para3)
    InstallFunc1Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.HpRecoverInRecoveryRoom] = function(self, uid, para1, para2, para3)
    InstallFunc1Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.OverClockCountAddtion] = function(self, uid, para1, para2, para3)
    InstallFunc1Para(self, uid, para1, para2, para3)
  end,
  [eLogicType.Activity_PointMultRate] = InstallFunc3Para,
  [eLogicType.Activity_Stamina2PointMultRate] = InstallFunc3ParaMaxValue,
  [eLogicType.Activity_EffiMultRate] = InstallFunc2ParaMaxValue,
  [eLogicType.Activity_ChipGroupLevel] = InstallFunc3ParaMaxValue,
  [eLogicType.Activity_UnlockBuff] = function(self, uid, para1, para2, para3)
    local data = self.categoryDataDic[uid]
    if data == nil then
      data = {}
      self.categoryDataDic[uid] = data
    end
    local ori = data[para1] or 0
    data[para1] = para2
    if self.totalData[para1] == nil then
      self.totalData[para1] = {}
    end
    self.totalData[para1][para2] = true
  end,
  [eLogicType.Activity_DeleteBuff] = function(self, uid, para1, para2, para3)
    local data = self.categoryDataDic[uid]
    if data == nil then
      data = {}
      self.categoryDataDic[uid] = data
    end
    local ori = data[para1] or 0
    data[para1] = para2
    if self.totalData[para1] == nil then
      self.totalData[para1] = {}
    end
    self.totalData[para1][para2] = true
  end,
  [eLogicType.Activity_PowTestChipGroupLimitAdd] = InstallFunc3ParaMaxValue,
  [eLogicType.Activity_ChipGroupCarryLimitAdd] = InstallFunc2ParaMaxValue,
  [eLogicType.DungeonShareRewardRate] = function(self, uid, para1, para2, para3)
    InstallFunc3ParaMaxValue(self, uid, para1, para2, para3)
    local moduelId = uid >> 32
    if moduelId == proto_csmsg_SystemFunctionID.SystemFunctionID_Double_Active then
      local activitiId = uid & CommonUtil.UInt32Max
      self.dungeonActivityIdDic[para1] = self.dungeonActivityIdDic[para1] or {}
      self.dungeonActivityIdDic[para1][activitiId] = self.dungeonActivityIdDic[para1][activitiId] or {}
      self.dungeonActivityIdDic[para1][activitiId] = true
    end
  end,
  [eLogicType.DungeonDropNumAdd] = InstallFunc2Para,
  [eLogicType.DungeonRewardRateNumAdd] = InstallFunc3Para,
  [eLogicType.AllFriendshipAdd] = InstallFunc1Para,
  [eLogicType.ResourceGoodBuyNumAdd] = InstallFunc3Para
}

local function uninstallFunc1Para(self, uid)
  local data = self.categoryDataDic[uid]
  if data == nil then
    error(string.format("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
    return
  end
  self.categoryDataDic[uid] = nil
  self.totalData = math.max(0, self.totalData - data)
end

local function uninstallFunc2Para(self, uid)
  local data = self.categoryDataDic[uid]
  if data == nil then
    error(string.format("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
    return
  end
  self.categoryDataDic[uid] = nil
  for k, v in pairs(data) do
    if v < self.totalData[k] then
      self.totalData[k] = self.totalData[k] - v
    else
      self.totalData[k] = nil
    end
  end
end

local function uninstallFunc2ParaMaxValue(self, uid)
  local data = self.categoryDataDic[uid]
  if data == nil then
    error(string.format("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
    return
  end
  self.categoryDataDic[uid] = nil
  for para1, para2 in pairs(data) do
    local maxValue
    for uid, catData in pairs(self.categoryDataDic) do
      if catData[para1] ~= nil then
        maxValue = math.max(maxValue or 0, catData[para1])
      end
    end
    self.totalData[para1] = maxValue
  end
end

local function uninstallFunc3Para(self, uid)
  local data = self.categoryDataDic[uid]
  if data == nil then
    error(string.format("No categoryData, uid = %s, logic = %s, module = %s, id = %s", uid, self.logic, uid >> 32, uid & CommonUtil.UInt32Max))
    return
  end
  self.categoryDataDic[uid] = nil
  for para1, para2Table in pairs(data) do
    for para2, para3 in pairs(para2Table) do
      local totalV = self.totalData[para1][para2] or 0
      if para3 < totalV then
        self.totalData[para1][para2] = totalV - para3
      else
        self.totalData[para1][para2] = nil
      end
    end
  end
end

local function uninstallFunc3ParaMaxValue(self, uid)
  local data = self.categoryDataDic[uid]
  if data == nil then
    error(string.format("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
    return
  end
  self.categoryDataDic[uid] = nil
  for para1, para2Table in pairs(data) do
    for para2, para3 in pairs(para2Table) do
      local maxValue
      for uid, catData in pairs(self.categoryDataDic) do
        if catData[para1][para2] ~= nil then
          maxValue = math.max(maxValue or 0, catData[para1][para2])
        end
      end
      self.totalData[para1][para2] = maxValue
    end
  end
end

local UninstallFuncDic = {
  [eLogicType.ResourceLimit] = function(self, uid)
    uninstallFunc2Para(self, uid)
    PlayerDataCenter.playerBonus:AddPlayerBonusBroadcast("warehouse")
  end,
  [eLogicType.CampBuff] = function(self, uid)
    local data = self.categoryDataDic[uid]
    if data == nil then
      error(string.format("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
      return
    end
    self.categoryDataDic[uid] = nil
    for para1, v in pairs(data) do
      for para2, para3 in pairs(v) do
        PlayerDataCenter.attributeBonus:RemoveCampBonus(para1, para2, para3)
      end
    end
  end,
  [eLogicType.CareerBuff] = function(self, uid)
    local data = self.categoryDataDic[uid]
    if data == nil then
      error(string.format("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
      return
    end
    self.categoryDataDic[uid] = nil
    for para1, v in pairs(data) do
      for para2, para3 in pairs(v) do
        PlayerDataCenter.attributeBonus:RemoveCareerBonus(para1, para2, para3)
      end
    end
  end,
  [eLogicType.FactoryPipelie] = function(self, uid)
    uninstallFunc1Para(self, uid)
  end,
  [eLogicType.GlobalExpCeiling] = function(self, uid)
    uninstallFunc1Para(self, uid)
  end,
  [eLogicType.ResOutputEfficiency] = function(self, uid)
    uninstallFunc2Para(self, uid)
  end,
  [eLogicType.BuildQueue] = function(self, uid)
    uninstallFunc2Para(self, uid)
  end,
  [eLogicType.BuildSpeed] = function(self, uid)
    uninstallFunc1Para(self, uid)
  end,
  [eLogicType.GlobalExpRatio] = function(self, uid)
    uninstallFunc1Para(self, uid)
  end,
  [eLogicType.AllHeroBuff] = function(self, uid)
    local data = self.categoryDataDic[uid]
    if data == nil then
      error(string.format("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
      return
    end
    self.categoryDataDic[uid] = nil
    for para1, para2 in pairs(data) do
      PlayerDataCenter.attributeBonus:RemoveAllBonus(para1, para2)
    end
  end,
  [eLogicType.OverClock] = function(self, uid)
    local data = self.categoryDataDic[uid]
    if data == nil then
      error(string.format("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
      return
    end
    self.categoryDataDic[uid] = nil
    for para1, oldPara2 in pairs(data) do
      self.totalData[para1] = 0
      for uid, data in pairs(self.categoryDataDic) do
        if data[para1] ~= nil then
          self.totalData[para1] = math.max(data[para1], self.totalData[para1] or 0)
        end
      end
    end
  end,
  [eLogicType.OverClockFreeNum] = function(self, uid)
    uninstallFunc1Para(self, uid)
  end,
  [eLogicType.FocusPointCeiling] = function(self, uid)
    uninstallFunc1Para(self, uid)
  end,
  [eLogicType.BattleExpBonus] = function(self, uid)
    uninstallFunc1Para(self, uid)
  end,
  [eLogicType.DynSkillUpgrade] = function(self, uid)
    uninstallFunc1Para(self, uid)
  end,
  [eLogicType.DynPlayerAttrBuff] = function(self, uid)
    uninstallFunc2Para(self, uid)
  end,
  [eLogicType.DungeonRewardRate] = function(self, uid)
    local data = self.categoryDataDic[uid]
    if data == nil then
      error(string.format("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
      return
    end
    self.categoryDataDic[uid] = nil
    for para1, weekNumDic in pairs(data) do
      for para2, _ in pairs(weekNumDic) do
        self.totalData[para1][para2] = 0
      end
    end
    for uid, para1Dic in pairs(self.categoryDataDic) do
      for para1, para2Dic in pairs(para1Dic) do
        for para2, para3 in pairs(para2Dic) do
          self.totalData[para1][para2] = math.max(para3, self.totalData[para1][para2] or 0)
        end
      end
    end
    local moduelId = uid >> 32
    if moduelId == proto_csmsg_SystemFunctionID.SystemFunctionID_Double_Active then
      local activitiId = uid & CommonUtil.UInt32Max
      for para1, v in pairs(data) do
        if self.dungeonActivityIdDic[para1] ~= nil then
          self.dungeonActivityIdDic[para1][activitiId] = nil
        end
        if table.IsEmptyTable(self.dungeonActivityIdDic[para1]) then
          self.dungeonActivityIdDic[para1] = nil
        end
      end
    end
  end,
  [eLogicType.HeroLevelCeiling] = function(self, uid)
    uninstallFunc1Para(self, uid)
  end,
  [eLogicType.AutoRecoverItem] = function(self, uid)
    uninstallFunc2Para(self, uid)
    PlayerDataCenter.playerBonus:AddPlayerBonusBroadcast("AutoRecoverItem")
  end,
  [eLogicType.DungeonCountAdd] = function(self, uid)
    uninstallFunc2Para(self, uid)
  end,
  [eLogicType.FactoryEfficiency] = function(self, uid)
    uninstallFunc2Para(self, uid)
  end,
  [eLogicType.ResOutputCeiling] = function(self, uid)
    uninstallFunc2Para(self, uid)
  end,
  [eLogicType.ChipCeilingCostReduce] = function(self, uid)
    uninstallFunc1Para(self, uid)
  end,
  [eLogicType.EpInitItemAddtion] = function(self, uid)
    uninstallFunc2Para(self, uid)
  end,
  [eLogicType.EpBattleRoomGetExr] = function(self, uid)
    uninstallFunc2Para(self, uid)
  end,
  [eLogicType.SupportCountAddtion] = function(self, uid)
    uninstallFunc1Para(self, uid)
  end,
  [eLogicType.HpRecoverInRecoveryRoom] = function(self, uid)
    uninstallFunc1Para(self, uid)
  end,
  [eLogicType.OverClockCountAddtion] = function(self, uid)
    uninstallFunc1Para(self, uid)
  end,
  [eLogicType.Activity_PointMultRate] = uninstallFunc3Para,
  [eLogicType.Activity_Stamina2PointMultRate] = uninstallFunc3ParaMaxValue,
  [eLogicType.Activity_EffiMultRate] = uninstallFunc2ParaMaxValue,
  [eLogicType.Activity_ChipGroupLevel] = uninstallFunc3ParaMaxValue,
  [eLogicType.Activity_UnlockBuff] = function(self, uid)
    local data = self.categoryDataDic[uid]
    if data == nil then
      error(string.format("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
      return
    end
    for para1, para2 in pairs(data) do
      self.totalData[para1][para2] = nil
    end
    self.categoryDataDic[uid] = nil
  end,
  [eLogicType.Activity_DeleteBuff] = function(self, uid)
    local data = self.categoryDataDic[uid]
    if data == nil then
      error(string.format("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
      return
    end
    for para1, para2Table in pairs(data) do
      for para2, _ in pairs(para2Table) do
        self.totalData[para1][para2] = nil
      end
    end
    self.categoryDataDic[uid] = nil
  end,
  [eLogicType.Activity_PowTestChipGroupLimitAdd] = uninstallFunc3ParaMaxValue,
  [eLogicType.Activity_ChipGroupCarryLimitAdd] = uninstallFunc2ParaMaxValue,
  [eLogicType.DungeonShareRewardRate] = function(self, uid)
    local data = self.categoryDataDic[uid]
    if data == nil then
      error(string.format("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
      return
    end
    uninstallFunc3ParaMaxValue(self, uid)
    local moduelId = uid >> 32
    if moduelId == proto_csmsg_SystemFunctionID.SystemFunctionID_Double_Active then
      local activitiId = uid & CommonUtil.UInt32Max
      for para1, v in pairs(data) do
        if self.dungeonActivityIdDic[para1] ~= nil then
          self.dungeonActivityIdDic[para1][activitiId] = nil
        end
        if table.IsEmptyTable(self.dungeonActivityIdDic[para1]) then
          self.dungeonActivityIdDic[para1] = nil
        end
      end
    end
  end,
  [eLogicType.DungeonDropNumAdd] = uninstallFunc2Para,
  [eLogicType.DungeonRewardRateNumAdd] = uninstallFunc3Para,
  [eLogicType.AllFriendshipAdd] = uninstallFunc1Para,
  [eLogicType.ResourceGoodBuyNumAdd] = uninstallFunc3Para
}

function PlayerBonusElem:ctor()
  self.categoryDataDic = {}
  self.totalData = nil
end

function PlayerBonusElem:InitPlayerBonusElem(logic)
  self.logic = logic
  local initFunc = InitFuncDic[logic]
  if initFunc == nil then
    return
  end
  initFunc(self)
end

function PlayerBonusElem:InstallBonus(uid, para1, para2, para3)
  local installFunc = InstallFuncDic[self.logic]
  if installFunc == nil then
    return
  end
  installFunc(self, uid, para1, para2, para3)
end

function PlayerBonusElem:UninstallBonus(uid)
  local uninstallFunc = UninstallFuncDic[self.logic]
  if uninstallFunc == nil then
    return
  end
  uninstallFunc(self, uid)
end

return PlayerBonusElem
