local DataModel = require("UISquads/UISquadsDataModel")
local View = require("UISquads/UISquadsView")
local SquadController = require("UISquads/Controller_Squad")

function GetRoleInfoByData(roleData, isHelpRole)
  local roleInfo = {}
  local roleId = roleData.id
  roleInfo.unitId = roleId
  local unitViewId = roleData.current_skin[1]
  if roleData.skin_list[unitViewId] and roleData.skin_list[unitViewId].span and roleData.skin_list[unitViewId].span ~= "" then
    unitViewId = roleData.skin_list[unitViewId].span
  end
  roleInfo.unitViewId = unitViewId
  roleInfo.lv = roleData.lv
  roleInfo.breakthroughLv = 0
  local awakeLv = roleData.awake_lv or 1
  roleInfo.awakeLv = awakeLv
  local resonanceLv = roleData.resonance_lv or 1
  roleInfo.resonanceLv = resonanceLv
  roleInfo.resonanceStage = 0
  if roleData.trust_lv == nil then
    roleInfo.trustLv = 0
  else
    roleInfo.trustLv = roleData.trust_lv
  end
  local equipConfig = PlayerData:GetFactoryData(99900027)
  local equipData = {}
  if roleData.equips[1] then
    if type(roleData.equips[1]) == "table" then
      equipData = roleData.equips[1]
    elseif roleData.equips[1] ~= "" then
      equipData = PlayerData:GetEquipById(roleData.equips[1]) or {}
    end
  end
  roleInfo.equip1Id = equipData.id or -1
  roleInfo.equip1Lv = equipData.lv or 1
  roleInfo.e1s1Id = equipData.random_affix and equipData.random_affix["0"] and equipData.random_affix["0"].id or -1
  roleInfo.e1s1NumSN = equipData.random_affix and equipData.random_affix["0"] and -1 < equipData.random_affix["0"].value and equipData.random_affix["0"].value * 10000 or 0
  roleInfo.e1s2Id = equipData.random_affix and equipData.random_affix["1"] and equipData.random_affix["1"].id or -1
  roleInfo.e1s2NumSN = equipData.random_affix and equipData.random_affix["1"] and -1 < equipData.random_affix["1"].value and equipData.random_affix["1"].value * 10000 or 0
  roleInfo.e1s3Id = equipData.random_affix and equipData.random_affix["2"] and equipData.random_affix["2"].id or -1
  roleInfo.e1s3NumSN = equipData.random_affix and equipData.random_affix["2"] and -1 < equipData.random_affix["2"].value and equipData.random_affix["2"].value * 10000 or 0
  roleInfo.e1s4Id = equipData.random_affix and equipData.random_affix["3"] and equipData.random_affix["3"].id or -1
  roleInfo.e1s4NumSN = equipData.random_affix and equipData.random_affix["3"] and -1 < equipData.random_affix["3"].value and equipData.random_affix["3"].value * 10000 or 0
  roleInfo.e1s5Id = equipData.random_affix and equipData.random_affix["4"] and equipData.random_affix["4"].id or -1
  roleInfo.e1s5NumSN = equipData.random_affix and equipData.random_affix["4"] and -1 < equipData.random_affix["4"].value and equipData.random_affix["4"].value * 10000 or 0
  roleInfo.e1s6Id = equipData.random_affix and equipData.random_affix["5"] and equipData.random_affix["5"].id or -1
  roleInfo.e1s6NumSN = equipData.random_affix and equipData.random_affix["5"] and -1 < equipData.random_affix["5"].value and equipData.random_affix["5"].value * 10000 or 0
  local attrStr1 = ""
  if equipData.random_affix then
    for i = 4, 10 do
      if equipData.random_affix[tostring(i)] and equipData.random_affix[tostring(i)].id then
        if attrStr1 ~= "" then
          attrStr1 = attrStr1 .. "|"
        end
        attrStr1 = attrStr1 .. equipData.random_affix[tostring(i)].id
        if -1 < equipData.random_affix[tostring(i)].value then
          attrStr1 = attrStr1 .. string.format(",A,%s", equipData.random_affix[tostring(i)].value)
        end
      end
    end
  end
  if equipData.id then
    local equipCA = PlayerData:GetFactoryData(equipData.id)
    local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(equipCA, equipData.lv, 0, equipData.bk_lv)
    local attrNum = curNum - lastNum
    if 0 < attrNum then
      if attrStr1 ~= "" then
        attrStr1 = attrStr1 .. "|"
      end
      attrStr1 = attrStr1 .. string.format("%s,A,%s", equipConfig.EquipAttrBreakAtk, attrNum)
    end
    if mainSkillUp then
      local skillId = equipCA.skillListPlus[1].skillId
      roleInfo.e1s1Id = skillId or roleInfo.e1s1Id
    end
  end
  equipData = {}
  if roleData.equips[2] then
    if type(roleData.equips[2]) == "table" then
      equipData = roleData.equips[2]
    elseif roleData.equips[2] ~= "" then
      equipData = PlayerData:GetEquipById(roleData.equips[2]) or {}
    end
  end
  roleInfo.equip2Id = equipData.id or -1
  roleInfo.equip2Lv = equipData.lv or 1
  roleInfo.e2s1Id = equipData.random_affix and equipData.random_affix["0"] and equipData.random_affix["0"].id or -1
  roleInfo.e2s1NumSN = equipData.random_affix and equipData.random_affix["0"] and -1 < equipData.random_affix["0"].value and equipData.random_affix["0"].value * 10000 or 0
  roleInfo.e2s2Id = equipData.random_affix and equipData.random_affix["1"] and equipData.random_affix["1"].id or -1
  roleInfo.e2s2NumSN = equipData.random_affix and equipData.random_affix["1"] and -1 < equipData.random_affix["1"].value and equipData.random_affix["1"].value * 10000 or 0
  roleInfo.e2s3Id = equipData.random_affix and equipData.random_affix["2"] and equipData.random_affix["2"].id or -1
  roleInfo.e2s3NumSN = equipData.random_affix and equipData.random_affix["2"] and -1 < equipData.random_affix["2"].value and equipData.random_affix["2"].value * 10000 or 0
  roleInfo.e2s4Id = equipData.random_affix and equipData.random_affix["3"] and equipData.random_affix["3"].id or -1
  roleInfo.e2s4NumSN = equipData.random_affix and equipData.random_affix["3"] and -1 < equipData.random_affix["3"].value and equipData.random_affix["3"].value * 10000 or 0
  roleInfo.e2s5Id = equipData.random_affix and equipData.random_affix["4"] and equipData.random_affix["4"].id or -1
  roleInfo.e2s5NumSN = equipData.random_affix and equipData.random_affix["4"] and -1 < equipData.random_affix["4"].value and equipData.random_affix["4"].value * 10000 or 0
  roleInfo.e2s6Id = equipData.random_affix and equipData.random_affix["5"] and equipData.random_affix["5"].id or -1
  roleInfo.e2s6NumSN = equipData.random_affix and equipData.random_affix["5"] and -1 < equipData.random_affix["5"].value and equipData.random_affix["5"].value * 10000 or 0
  local attrStr2 = ""
  if equipData.random_affix then
    for i = 5, 10 do
      if equipData.random_affix[tostring(i)] and equipData.random_affix[tostring(i)].id then
        if attrStr2 ~= "" then
          attrStr2 = attrStr2 .. "|"
        end
        attrStr2 = attrStr2 .. equipData.random_affix[tostring(i)].id
        if -1 < equipData.random_affix[tostring(i)].value then
          attrStr2 = attrStr2 .. string.format(",A,%s", equipData.random_affix[tostring(i)].value)
        end
      end
    end
  end
  if equipData.id then
    local equipCA = PlayerData:GetFactoryData(equipData.id)
    local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(equipCA, equipData.lv, 0, equipData.bk_lv)
    local attrNum = curNum - lastNum
    if 0 < attrNum then
      if attrStr2 ~= "" then
        attrStr2 = attrStr2 .. "|"
      end
      attrStr2 = attrStr2 .. string.format("%s,A,%s", equipConfig.EquipAttrBreakDef, attrNum)
    end
    if mainSkillUp then
      local skillId = equipCA.skillListPlus[1].skillId
      roleInfo.e2s1Id = skillId or roleInfo.e2s1Id
    end
  end
  equipData = {}
  if roleData.equips[3] then
    if type(roleData.equips[3]) == "table" then
      equipData = roleData.equips[3]
    elseif roleData.equips[3] ~= "" then
      equipData = PlayerData:GetEquipById(roleData.equips[3]) or {}
    end
  end
  roleInfo.equip3Id = equipData.id or -1
  roleInfo.equip3Lv = equipData.lv or 1
  roleInfo.e3s1Id = equipData.random_affix and equipData.random_affix["0"] and equipData.random_affix["0"].id or -1
  roleInfo.e3s1NumSN = equipData.random_affix and equipData.random_affix["0"] and -1 < equipData.random_affix["0"].value and equipData.random_affix["0"].value * 10000 or 0
  roleInfo.e3s2Id = equipData.random_affix and equipData.random_affix["1"] and equipData.random_affix["1"].id or -1
  roleInfo.e3s2NumSN = equipData.random_affix and equipData.random_affix["1"] and -1 < equipData.random_affix["1"].value and equipData.random_affix["1"].value * 10000 or 0
  roleInfo.e3s3Id = equipData.random_affix and equipData.random_affix["2"] and equipData.random_affix["2"].id or -1
  roleInfo.e3s3NumSN = equipData.random_affix and equipData.random_affix["2"] and -1 < equipData.random_affix["2"].value and equipData.random_affix["2"].value * 10000 or 0
  roleInfo.e3s4Id = equipData.random_affix and equipData.random_affix["3"] and equipData.random_affix["3"].id or -1
  roleInfo.e3s4NumSN = equipData.random_affix and equipData.random_affix["3"] and -1 < equipData.random_affix["3"].value and equipData.random_affix["3"].value * 10000 or 0
  roleInfo.e3s5Id = equipData.random_affix and equipData.random_affix["4"] and equipData.random_affix["4"].id or -1
  roleInfo.e3s5NumSN = equipData.random_affix and equipData.random_affix["4"] and -1 < equipData.random_affix["4"].value and equipData.random_affix["4"].value * 10000 or 0
  roleInfo.e3s6Id = equipData.random_affix and equipData.random_affix["5"] and equipData.random_affix["5"].id or -1
  roleInfo.e3s6NumSN = equipData.random_affix and equipData.random_affix["5"] and -1 < equipData.random_affix["5"].value and equipData.random_affix["5"].value * 10000 or 0
  local attrStr3 = ""
  if equipData.random_affix then
    for i = 6, 10 do
      if equipData.random_affix[tostring(i)] and equipData.random_affix[tostring(i)].id then
        if attrStr3 ~= "" then
          attrStr3 = attrStr3 .. "|"
        end
        attrStr3 = attrStr3 .. equipData.random_affix[tostring(i)].id
        if -1 < equipData.random_affix[tostring(i)].value then
          attrStr3 = attrStr3 .. string.format(",A,%s", equipData.random_affix[tostring(i)].value)
        end
      end
    end
  end
  if equipData.id then
    local equipCA = PlayerData:GetFactoryData(equipData.id)
    local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(equipCA, equipData.lv, 0, equipData.bk_lv)
    local attrNum = curNum - lastNum
    if 0 < attrNum then
      if attrStr3 ~= "" then
        attrStr3 = attrStr3 .. "|"
      end
      attrStr3 = attrStr3 .. string.format("%s,A,%s", equipConfig.EquipAttrBreakHp, attrNum)
    end
    if mainSkillUp then
      local skillId = equipCA.skillListPlus[1].skillId
      roleInfo.e3s1Id = skillId or roleInfo.e3s1Id
    end
  end
  roleInfo.cardNum1 = roleData.cardNum1 == nil and -1 or roleData.cardNum1
  roleInfo.cardNum2 = roleData.cardNum2 == nil and -1 or roleData.cardNum2
  if isHelpRole then
    local skillLevel = PlayerData:GetRoleSkillLevel(roleData)
    local roleCA = PlayerData:GetFactoryData(roleId)
    local skillList = roleCA.skillList or {}
    local skills = {}
    for i = 1, #skillList do
      local skillId = skillList[i].skillId
      skills[i] = skillLevel[tostring(skillId)]
    end
    roleInfo.skill1Lv = skills[1] or 1
    roleInfo.skill2Lv = skills[2] or 1
    roleInfo.skill3Lv = skills[3] or 1
    roleInfo.extraSkills = PlayerData:GetRoleResonanceExSkillStr(roleData)
  end
  roleInfo.attrStr1 = attrStr1
  roleInfo.attrStr2 = attrStr2
  roleInfo.attrStr3 = attrStr3
  return roleInfo
end

function GetPlayerRoleData(roleId)
  if roleId == nil or roleId == "" then
    return {}
  end
  local roleData = PlayerData:GetRoleById(roleId)
  if next(roleData) == nil then
    return {}
  end
  local roleInfo = GetRoleInfoByData(roleData)
  local roleCA = PlayerData:GetFactoryData(roleId)
  local awakeLv = roleData.awake_lv or 1
  if awakeLv == #roleCA.breakthroughList - 1 and PlayerData:IsRoleAwakeLock(roleId) then
    awakeLv = awakeLv - 1
  end
  roleInfo.awakeLv = awakeLv
  local resonanceLv = roleData.resonance_lv or 1
  if resonanceLv == #roleCA.talentList and PlayerData:IsRoleResonanceLock(roleId) then
    resonanceLv = resonanceLv - 1
  end
  roleInfo.resonanceLv = resonanceLv
  roleInfo.resonanceStage = 0
  if roleData.trust_lv == nil then
    roleInfo.trustLv = 0
  else
    roleInfo.trustLv = roleData.trust_lv
  end
  local skillLevel = PlayerData:GetRoleSkillLevel(roleId)
  local skillList = roleCA.skillList or {}
  local skills = {}
  for i = 1, #skillList do
    local skillId = skillList[i].skillId
    skills[i] = skillLevel[tostring(skillId)]
  end
  roleInfo.skill1Lv = skills[1] or 1
  roleInfo.skill2Lv = skills[2] or 1
  roleInfo.skill3Lv = skills[3] or 1
  local extraSkill = PlayerData:GetRoleResonanceExSkillStr(roleId)
  if roleInfo.extraSkills == nil then
    roleInfo.extraSkills = ""
  end
  if roleInfo.extraSkills ~= "" then
    if extraSkill ~= "" then
      extraSkill = "|" .. extraSkill
    end
    roleInfo.extraSkills = roleInfo.extraSkills .. extraSkill
  else
    roleInfo.extraSkills = roleInfo.extraSkills .. extraSkill
  end
  return roleInfo
end

local module = {
  Serialize = function(self)
    local status = DataModel.InitParams
    status.levelChainId = DataModel.levelChainId
    status.curSquadIndex = DataModel.curSquadIndex
    status.curDetailIndex = DataModel.curDetailIndex
    status.curSelectIndex = DataModel.curSelectIndex
    status.difficulty = DataModel.difficulty
    status.enemy_ids = DataModel.enemy_ids
    status.enemyLevelOffset = DataModel.enemyLevelOffset
    status.secondWeatherList = DataModel.secondWeatherList
    status.trainWeaponSkill = DataModel.trainWeaponSkill
    status.headerExtraSkill = DataModel.headerExtraSkill
    status.isLockDiff = DataModel.isLockDiff
    status.serverIdx = DataModel.serverIdx
    return status
  end,
  Deserialize = function(self, status)
    if status == nil then
      return nil
    end
    DataModel.Current = status.Current
    DataModel.RoleData = nil
    DataModel.curLevelId = nil
    DataModel.isHighChallenge = nil
    if status.Current ~= "MainUI" then
      DataModel.curLevelId = PlayerData.BattleInfo.battleStageId
    end
    DataModel.curDetailIndex = status.curDetailIndex or 1
    DataModel.curSquadIndex = status.curSquadIndex or 1
    if status.squadIndex ~= nil then
      DataModel.curSquadIndex = status.squadIndex
    end
    if DataModel.curSquadIndex == 0 then
      DataModel.curSquadIndex = 1
    end
    if status.hasOpenThreeView ~= nil then
      DataModel.hasOpenThreeView = status.hasOpenThreeView
    end
    DataModel.eventId = status.eventId
    DataModel.level_key = status.level_key
    DataModel.minEnemyLevel = status.minEnemyLevel or 1
    DataModel.difficulty = status.difficulty or 1
    DataModel.bgId = status.bgId
    DataModel.enemyLevel = status.enemyLevel
    DataModel.enemyRn = status.enemyRn
    DataModel.lineWeatherIdList = status.lineWeatherIdList
    DataModel.lineWeatherRateSN = status.lineWeatherRateSN
    DataModel.areaId = status.areaId
    DataModel.enemy_ids = status.enemy_ids
    DataModel.enemyLevelOffset = status.enemyLevelOffset
    DataModel.secondWeatherList = status.secondWeatherList
    DataModel.trainWeaponSkill = status.trainWeaponSkill
    DataModel.headerExtraSkill = status.headerExtraSkill
    DataModel.ttbSid = status.ttbSid
    DataModel.ttbIndex = status.ttbIndex
    DataModel.ttbId = status.ttbId
    DataModel.isLockDiff = status.isLockDiff
    DataModel.serverIdx = status.serverIdx
  end
}

function module:ClickGridTab(index)
  if DataModel.curSquadIndex and index and DataModel.curSquadIndex == index then
    return
  end
  local old_element = View.Group_Tab.ScrollGrid_Tab.grid.self:GetElementByIndex(DataModel.curSquadIndex - 1)
  old_element.Btn_Tab.Group_On:SetActive(false)
  old_element.Btn_Tab.Group_On.Btn_Change:SetActive(false)
  local element = View.Group_Tab.ScrollGrid_Tab.grid.self:GetElementByIndex(index - 1)
  element.Btn_Tab.Group_On:SetActive(true)
  element.Btn_Tab.Group_On.Btn_Change:SetActive(DataModel.Current ~= DataModel.Enum.College)
end

function module:RefreshAll(isFirst)
  local levelData
  DataModel.isUseLevelRole = false
  if DataModel.curLevelId == nil then
    levelData = nil
  else
    levelData = PlayerData:GetFactoryData(DataModel.curLevelId, "LevelFactory")
  end
  if self:CheckLevel(levelData) == true then
    DataModel.hasLevelRole = true
    PlayerData.currentSquad = {}
    self:SetSquad(PlayerData.currentSquad, #View.StaticGrid_List.grid)
  elseif PlayerData.helpSquadIndex ~= nil and PlayerData.helpSquadIndex == DataModel.curSquadIndex then
    PlayerData.currentSquad = {}
    self:SetHelpRoleList()
  else
    if DataModel.curSquadIndex <= 0 or DataModel.curSquadIndex > #PlayerData.ServerData.squad then
      DataModel.curSquadIndex = 1
    end
    PlayerData.currentSquad = {}
    local curRoleList = PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list
    for i = 1, 5 do
      local temp = {}
      temp = curRoleList[i]
      if temp and temp.id == "" then
        temp.id = nil
      end
      table.insert(PlayerData.currentSquad, temp)
    end
    DataModel.hasLevelRole = false
    self:SetSquad(PlayerData.currentSquad, #View.StaticGrid_List.grid)
  end
  if DataModel.levelChainId == nil then
    View.Group_Tab.self:SetActive(true)
  end
  if DataModel.hasLevelRole == true then
    View.Group_Tab:SetActive(false)
    View.Btn_Clear:SetActive(false)
    View.Btn_QuickFormation:SetActive(false)
    if levelData and 5 > levelData.roleNumOffSet then
      View.Btn_QuickFormation:SetActive(true)
    end
    UIManager:LoadSplitPrefab(View, "UI/Squads/Squads", "Group_LockMode")
    View.Group_LockMode:SetActive(true)
    View.Group_LockMode.Group_.Txt_:SetText(GetText(80600944))
  else
    if isFirst then
      DataModel.TopColumn = math.ceil(DataModel.curSquadIndex / 4)
    end
    SquadController.RefreshTab(DataModel.TopColumn)
    View.Group_Tab:SetActive(true)
    View.Btn_Clear:SetActive(true)
    View.Btn_QuickFormation:SetActive(true)
    View.Group_LockMode:SetActive(false)
  end
  if View.Group_Detail ~= nil then
    View.Group_Detail.self:SetActive(false)
  end
  DataModel:RefreshUrEquip()
  SquadController.SetStartActive(DataModel.Current)
  SquadController.ShowDetail(DataModel.curSquadIndex)
  SquadController.RefreshRoles()
end

function module:CheckLevel(levelData)
  if levelData == nil then
    return false
  end
  if DataModel.Current == DataModel.Enum.College then
    return true
  end
  if #levelData.levelRoleList > 0 then
    return true
  end
  return false
end

function module:SetSquad(currentSquad, squadCount, isAddLevelRole)
  DataModel.curSquad = {}
  DataModel.curSquad = {}
  local curSquad = self:GetRoleDataList(currentSquad)
  local levelRoleList
  local blockedSlotCount = 0
  local levelData
  if DataModel.curLevelId ~= nil then
    levelData = PlayerData:GetFactoryData(DataModel.curLevelId, "LevelFactory")
    if levelData.isUseLevelRole then
      DataModel.isUseLevelRole = true
    end
    levelRoleList = levelData.levelRoleList
    blockedSlotCount = levelData.roleNumOffSet
  end
  DataModel.levelRoleMap = {}
  if DataModel.isUseLevelRole then
    DataModel.isHighChallenge = true
    DataModel.curSquad = {}
    for i = 1, #levelRoleList do
      if 0 < levelRoleList[i].id then
        local roleData = PlayerData:GetFactoryData(levelRoleList[i].id, "LevelRoleFactory")
        if roleData.usePlayerRoleData == true then
          local player_role = GetPlayerRoleData(roleData.unitId)
          if player_role ~= nil then
            roleData = player_role
          end
        end
        roleData.isLevelRole = true
        roleData.trustLv = 0
        DataModel.curSquad[i] = roleData
        DataModel.levelRoleMap[roleData.unitId] = roleData
      end
    end
    if not isAddLevelRole then
      local replaceRoleStr = PlayerData:GetAbyssTeam("ReplaceLevelRoleList" .. DataModel.curLevelId)
      if replaceRoleStr ~= nil and replaceRoleStr ~= "" then
        local roleList = string.split(replaceRoleStr, ",")
        for i = 1, #roleList do
          local strList = string.split(roleList[i], "_")
          local str = strList[1]
          if tonumber(str) ~= nil and tonumber(str) ~= -1 then
            if #strList <= 1 and next(PlayerData:GetRoleById(str)) ~= nil and blockedSlotCount < i then
              DataModel.curSquad[i] = GetPlayerRoleData(str)
            elseif DataModel.levelRoleMap[tonumber(str)] and blockedSlotCount < i then
              DataModel.curSquad[i] = DataModel.levelRoleMap[tonumber(str)]
            elseif blockedSlotCount < i then
              DataModel.curSquad[i] = {}
            end
          end
        end
      end
      local roleStr = PlayerData:GetAbyssTeam("LevelRoleList" .. DataModel.curLevelId)
      if roleStr ~= nil and roleStr ~= "" then
        local roleList = string.split(roleStr, ",")
        for i = 1, #roleList do
          local strList = string.split(roleList[i], "_")
          local str = strList[1]
          if tonumber(str) ~= nil and tonumber(str) ~= -1 then
            if #strList <= 1 and next(PlayerData:GetRoleById(str)) ~= nil and blockedSlotCount < #DataModel.curSquad + 1 then
              DataModel.curSquad[#DataModel.curSquad + 1] = GetPlayerRoleData(str)
            elseif DataModel.levelRoleMap[tonumber(str)] and blockedSlotCount < #DataModel.curSquad + 1 then
              DataModel.curSquad[#DataModel.curSquad + 1] = DataModel.levelRoleMap[tonumber(str)]
            elseif blockedSlotCount < #DataModel.curSquad + 1 then
              DataModel.curSquad[#DataModel.curSquad + 1] = {}
            end
          end
        end
      end
    end
  else
    DataModel.curSquad = curSquad
  end
  if isAddLevelRole then
    local roleStr = ""
    local replaceRoleStr = ""
    local curSquadNum = #DataModel.curSquad
    for i = 1, #curSquad do
      if i > curSquadNum and blockedSlotCount < i then
        if curSquad[i].unitId ~= nil then
          DataModel.curSquad[i] = curSquad[i]
          if roleStr ~= "" then
            roleStr = roleStr .. ","
          end
          roleStr = roleStr .. curSquad[i].unitId
          if curSquad[i].isLevelRole == true then
            roleStr = roleStr .. "_t"
          end
        else
          DataModel.curSquad[i] = {}
        end
      elseif blockedSlotCount < i then
        if curSquad[i].isLevelRole ~= true then
          if curSquad[i].unitId ~= nil then
            if replaceRoleStr ~= "" then
              replaceRoleStr = replaceRoleStr .. ","
            end
            replaceRoleStr = replaceRoleStr .. curSquad[i].unitId
          else
            if replaceRoleStr ~= "" then
              replaceRoleStr = replaceRoleStr .. ","
            end
            replaceRoleStr = replaceRoleStr .. 0
          end
          DataModel.curSquad[i] = curSquad[i]
        elseif curSquad[i].unitId ~= DataModel.curSquad[i].unitId then
          if curSquad[i].unitId ~= nil then
            if replaceRoleStr ~= "" then
              replaceRoleStr = replaceRoleStr .. ","
            end
            replaceRoleStr = replaceRoleStr .. curSquad[i].unitId
            replaceRoleStr = replaceRoleStr .. "_t"
          else
            if replaceRoleStr ~= "" then
              replaceRoleStr = replaceRoleStr .. ","
            end
            replaceRoleStr = replaceRoleStr .. 0
          end
          DataModel.curSquad[i] = curSquad[i]
        else
          if replaceRoleStr ~= "" then
            replaceRoleStr = replaceRoleStr .. ","
          end
          replaceRoleStr = replaceRoleStr .. -1
          if curSquad[i].unitId == nil then
            DataModel.curSquad[i] = {}
          end
        end
      end
    end
    PlayerData:SaveAbyssTeam("LevelRoleList" .. DataModel.curLevelId, roleStr)
    PlayerData:SaveAbyssTeam("ReplaceLevelRoleList" .. DataModel.curLevelId, replaceRoleStr)
  end
  for i = 1, #DataModel.curSquad do
    PlayerData.currentSquad[i] = {}
    if DataModel.curSquad[i].unitId ~= nil then
      PlayerData.currentSquad[i].id = tonumber(DataModel.curSquad[i].unitId)
      PlayerData.currentSquad[i].isLevelRole = DataModel.curSquad[i].isLevelRole
      PlayerData.currentSquad[i].skill_list = {
        [1] = "",
        [2] = "",
        [3] = ""
      }
    end
  end
  local len = squadCount - blockedSlotCount
  for i = #DataModel.curSquad + 1, 5 do
    table.insert(DataModel.curSquad, {})
  end
  for i = 1, blockedSlotCount do
    if DataModel.curSquad[i] == nil then
      DataModel.curSquad[i] = {}
    end
    if DataModel.levelChainId == nil then
      DataModel.curSquad[i].isBlocked = true
    end
  end
  local roleList = {}
  for i = 1, #DataModel.curSquad do
    if DataModel.curSquad[i].unitId ~= nil then
      roleList[#roleList + 1] = tonumber(DataModel.curSquad[i].unitId)
    else
      roleList[#roleList + 1] = -1
    end
  end
  local teamKey = DataModel:GetTeamKey()
  local header = DataModel:GetNowCaptain()
  if DataModel.curLevelId ~= nil then
    PlayerData:SaveLevelRoleCaptain(DataModel.curLevelId, header)
  end
  local autoBattle = require("UIAutoBattle/UIAutoBattleViewFunction")
  if DataModel.hasLevelRole and levelData ~= nil and 0 < levelData.defaultAutoCode then
    local autoKey = "CardAIData" .. teamKey
    local str = PlayerData:GetPlayerPrefs("string", autoKey, true)
    if str == nil or 1 > string.getLength(str) then
      PlayerData:SetPlayerPrefs("string", autoKey, autoBattle.DeCompressData(GetText(levelData.defaultAutoCode)), true)
    end
  end
  autoBattle.SetTeamData(teamKey, roleList, tonumber(header))
end

function module:RoleSort(sortList)
  local function CompFunc(roleA, roleB)
    local a = PlayerData:GetFactoryData(roleA.unitId)
    
    local b = PlayerData:GetFactoryData(roleB.unitId)
    if a.line < b.line then
      return true
    elseif a.line > b.line then
      return false
    elseif a.id == b.id then
      return false
    elseif a.id > b.id then
      return false
    else
      return true
    end
  end
  
  table.sort(sortList, CompFunc)
end

function module:SetSquadIndex(index)
  DataModel.curSquadIndex = index
end

function module:ClearSquad()
  local function Callback()
    local autoBattle = require("UIAutoBattle/UIAutoBattleDataModel")
    
    local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
    for i = 1, #PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list do
      local id = PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list[i].id
      autoBattle:RemoveCardsByUnitId(autoBattle.CurrentData, tonumber(id))
    end
    autoBattleVF.SaveData(true)
    PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list = {}
    PlayerData.ServerData.squad[DataModel.curSquadIndex].header = ""
    DataModel:RefreshSquadsInit()
    self:ClearGridProperty(View.StaticGrid_List.grid)
    self:RefreshAll()
  end
  
  if DataModel.Current == DataModel.Enum.College or DataModel.hasLevelRole == true then
    PlayerData.currentSquad = {}
    self:ClearGridProperty(View.StaticGrid_List.grid)
    self:RefreshAll()
    return
  end
  Net:SendProto("deck.set_deck", function(json)
    Callback()
  end, DataModel.curSquadIndex - 1, "")
end

function module:GenSendServerRoleList(list)
  local roleListSendServer = {}
  for i = 1, #list do
    if type(list[i]) == "number" then
      table.insert(roleListSendServer, list[i])
    elseif list[i].isLevelRole ~= true and list[i].unitId ~= nil then
      table.insert(roleListSendServer, list[i].unitId)
    end
  end
  return roleListSendServer
end

function module:GenRoleIdList(roleList)
  local playerDataRoleIdList = {}
  for i = 1, #roleList do
    if roleList[i].isLevelRole ~= true and roleList[i].isBlocked ~= true and next(roleList[i]) ~= nil then
      local temp = {}
      temp.id = roleList[i].unitId
      table.insert(playerDataRoleIdList, temp)
    end
  end
  return playerDataRoleIdList
end

function module:ClearGridProperty(StaticGridList)
  for k, v in pairs(StaticGridList) do
    if v ~= nil and v ~= StaticGridList.self and v.Btn_Character then
      v.Btn_Character.current = nil
    end
  end
end

function module:GetRoleDataList(roleIdList)
  local roleDataList = {}
  for i = 1, #roleIdList do
    local squad_role = roleIdList[i]
    if squad_role.id == nil then
      table.insert(roleDataList, {})
    else
      local roleInfo = GetPlayerRoleData(roleIdList[i].id)
      if roleIdList[i].isLevelRole then
        roleInfo = DataModel.levelRoleMap[tonumber(roleIdList[i].id)]
      end
      roleInfo.isLevelRole = roleIdList[i].isLevelRole
      table.insert(roleDataList, roleInfo)
    end
  end
  return roleDataList
end

function module:GetMechanismNum(index)
  local list = {
    [1] = "\226\133\160",
    [2] = "\226\133\161",
    [3] = "\226\133\162",
    [4] = "\226\133\163",
    [5] = "\226\133\164",
    [6] = "\226\133\165",
    [7] = "\226\133\166",
    [8] = "\226\133\167",
    [9] = "\226\133\168\226\128\140",
    [10] = "\226\133\169\226\128\140"
  }
  local txt = list[index] == nil and list[#list] or list[index]
  return txt
end

function module:InitChallengeInfo()
  local configFactory = DataModel.ConfigFactory
  local levelList = configFactory.challengeLevelList
  DataModel.ChallengeInfo = {}
  for i, v in pairs(levelList) do
    local levelId = tonumber(v.levelId)
    if LevelCheck.CheckPreLevel(levelId) == true then
      local t = {}
      t.levelId = levelId
      local unitId = tonumber(v.unitId)
      local unitData = PlayerData:GetFactoryData(unitId, "unitFactory")
      local unitViewData = PlayerData:GetFactoryData(tonumber(unitData.viewId), "UnitViewFactory")
      local isUnlock = LevelCheck.CheckMonsterManualUnlock(levelId)
      t.unitId = unitId
      t.faceRes = unitViewData.face
      t.isUnlock = isUnlock
      t.name = unitData.name
      t.viewId = unitData.viewId
      t.isBoss = unitData.isBoss
      t.spineUrl = unitViewData.resDir
      t.lineDes = unitData.lineDes
      t.iconPath = unitViewData.face
      t.armorDes = unitData.armorDes
      t.riskDes = unitData.riskDes
      t.normalDes = unitData.normalDes
      t.battleDes = unitData.battleDes
      t.spineX = unitViewData.spineX
      t.spineY = unitViewData.spineY
      t.spineScale = unitViewData.spineScale
      t.resUrl = unitViewData.resUrl
      t.offsetX = unitViewData.offsetX
      t.offsetY = unitViewData.offsetY
      t.serialNumber = self:GetMechanismNum(v.serialNumber)
      print_r(v)
      print_r("\231\189\151\233\169\172\230\149\176\229\173\151")
      local levelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
      t.firstPassAward = Clone(levelCA.firstPassAward)
      table.insert(DataModel.ChallengeInfo, t)
    end
  end
end

function module:ShowChallengeDetail(idx)
  local info = DataModel.ChallengeInfo[idx]
  if info == nil then
    return
  end
  if not info.isUnlock then
    CommonTips.OpenTips(80600208)
    return
  end
  if DataModel.curShowIdx == idx then
    return
  end
  DataModel.curShowIdx = idx
  local panel = View.Group_ProvingGround.Group_EnemyDetail
  panel.Group_Details.Txt_Name:SetText(info.name)
  local transform = panel.Group_Anim.Img_Character.transform
  local pos = DataModel.curShowImgDefaultInfo
  local posX = pos.x + info.offsetX * pos.scale
  local posY = pos.y + info.offsetY * pos.scale
  transform.localPosition = Vector3(posX, posY, 0)
  panel.Group_Anim.Img_Character:SetActive(true)
  panel.Group_Anim.Img_Character:SetSprite(info.resUrl)
  panel.Group_Details.Group_Des.Txt_battleDes:SetText(info.battleDes)
  View.Group_ProvingGround.Group_EnemyDetail.Group_Blank.self:SetActive(false)
  local complete = PlayerData:GetLevelPass(info.levelId)
  View.Group_ProvingGround.Group_Challenge.Img_Received:SetSprite(GetResPath(88300001))
  View.Group_ProvingGround.Group_Challenge.Img_Received:SetActive(complete)
  View.Group_ProvingGround.Group_Challenge.Group_Reward.StaticGrid_Reward.grid.self:RefreshAllElement()
  panel.self:SetActive(true)
end

function module:SetHelpRoleList()
  if DataModel.curSquadIndex ~= PlayerData.helpSquadIndex then
    return
  end
  DataModel.curSquad = PlayerData.helpRoleList or {
    {},
    {},
    {},
    {},
    {}
  }
  for i = 1, #DataModel.curSquad do
    PlayerData.currentSquad[i] = {}
    if DataModel.curSquad[i].unitId ~= nil then
      PlayerData.currentSquad[i].id = tonumber(DataModel.curSquad[i].unitId)
      PlayerData.currentSquad[i].isHelpRole = DataModel.curSquad[i].isHelpRole
      PlayerData.currentSquad[i].skill_list = {
        [1] = "",
        [2] = "",
        [3] = ""
      }
    end
  end
  local str = PlayerData:GetPlayerPrefs("string", "CardAIDataHelpRole", true)
  if str == nil or 1 > string.getLength(str) then
    local autoKey = "CardAIData" .. DataModel.curSquadIndex
    str = PlayerData:GetPlayerPrefs("string", autoKey, true)
    PlayerData:SetPlayerPrefs("string", "CardAIDataHelpRole", str, true)
    local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
    autoBattleVF:SaveCloudData("CardAIDataHelpRole", str)
    DataModel.header = PlayerData.ServerData.squad[DataModel.curSquadIndex].header
  end
  local roleList = {}
  local header = DataModel:GetNowCaptain()
  local isHeaderChange = true
  for i = 1, #DataModel.curSquad do
    if DataModel.curSquad[i].unitId ~= nil then
      roleList[#roleList + 1] = tonumber(DataModel.curSquad[i].unitId)
    else
      roleList[#roleList + 1] = -1
    end
    if DataModel.curSquad[i].unitId == header then
      isHeaderChange = false
    end
  end
  if isHeaderChange then
    header = PlayerData.curSelectedHelpRole.id
  end
  local autoBattle = require("UIAutoBattle/UIAutoBattleViewFunction")
  autoBattle.SetTeamData("HelpRole", roleList, tonumber(header))
end

return module
