local BattleUtil = {}
local cs_ColorUtility = CS.UnityEngine.ColorUtility
local cs_BattleStatistics = CS.BattleStatistics.Instance
local cs_BattleManager = CS.BattleManager
BattleUtil.mvpParaType = {
  damage = 1,
  injury = 2,
  selfHeal = 3,
  otherHeal = 4
}
BattleUtil.mvpType = {
  heal = 0,
  damagem = 1,
  injury = 2,
  default = 3
}
BattleUtil.battleRoleCat = {
  normalHero = 0,
  monster = 1,
  neutral = 2,
  pDungeonRole = 3,
  waitToCasterMonster = 4,
  waitToCasterHero = 5
}

function BattleUtil.Pos2XYCoord(pos)
  local x = pos >> 16
  local y = pos & CommonUtil.UInt16Max
  return x, y
end

function BattleUtil.XYCoord2Pos(x, y)
  local pos = x << 16 | y
  return pos
end

function BattleUtil.PosOnBench(pos)
  local x = pos >> 16
  return x == ConfigData.buildinConfig.BenchX
end

function BattleUtil.BattleHexDistance(ax, ay, bx, by)
  local dx = bx - ax
  local dy = by - ay
  local adx = math.abs(dx)
  local ady = math.abs(dy)
  local lukey = 0 < dx and ay & 1 ~= 0
  local xOffset = lukey and (ady + 1) // 2 or ady // 2
  local step = adx <= xOffset and ady or ady + adx - xOffset
  return step
end

function BattleUtil.GetChipAttrUpgradeInfo(attrIds, initValues, increaseValues, count, newcount)
  if #attrIds == 1 then
    return BattleUtil._GetChipAttrUpgrade(attrIds[1], initValues[1], increaseValues[1], count, newcount)
  end
  local result = ""
  for i = 1, #attrIds do
    if 1 < i then
      result = result .. ConfigData:GetTipContent(206)
    end
    result = result .. BattleUtil._GetChipAttrUpgrade(attrIds[i], initValues[i], increaseValues[i], count, newcount)
  end
  return result
end

function BattleUtil._GetChipAttrUpgrade(attrId, initValue, increaseValue, count, newcount)
  local attibuteCfg = ConfigData.attribute[attrId]
  if attibuteCfg == nil then
    error("Can't find attibuteCfg, id = " .. tostring(attrId))
    return ""
  end
  count = count or 1
  local atrName = LanguageUtil.GetLocaleText(attibuteCfg.name)
  local isRatio = attibuteCfg.num_type == 2
  local value = initValue + (increaseValue or 0) * (count - 1)
  local valueStr = isRatio and tostring(FormatNum(value / 10)) .. "%" or tostring(value)
  local sign
  if value < 0 then
    sign = ""
  else
    sign = "+"
  end
  if newcount == nil then
    local content = atrName .. sign .. valueStr
    return content
  end
  local newValue = initValue + (increaseValue or 0) * (newcount - 1)
  local newSign
  if newValue < 0 then
    newSign = ""
  else
    newSign = "+"
  end
  local newValueStr = isRatio and tostring(FormatNum(newValue / 10)) .. "%" or tostring(newValue)
  local content = string.format("%s<color=#%s>%s</color>%s<color=#%s>%s</color>", atrName, cs_ColorUtility.ToHtmlStringRGB(ConfigData:GetChipQualityColor(count)), sign .. valueStr, ConfigData.buildinConfig.ChipLevelUpSign, cs_ColorUtility.ToHtmlStringRGB(ConfigData:GetChipQualityColor(newcount)), newSign .. newValueStr)
  return content
end

function BattleUtil.GetChipAttrInfo(attrIds, initValues, increaseValues, count, newcount)
  if #attrIds == 1 then
    return BattleUtil._GetChipAttr(attrIds[1], initValues[1], increaseValues[1], count, newcount)
  end
  local result = ""
  for i = 1, #attrIds do
    if 1 < i then
      result = result .. ConfigData:GetTipContent(206)
    end
    result = result .. BattleUtil._GetChipAttr(attrIds[i], initValues[i], increaseValues[i], count, newcount)
  end
  return result
end

function BattleUtil._GetChipAttr(attrId, initValue, increaseValue, count, maxcount)
  local attibuteCfg = ConfigData.attribute[attrId]
  if attibuteCfg == nil then
    error("Can't find attibuteCfg, id = " .. tostring(attrId))
    return ""
  end
  count = count or 1
  local atrName = LanguageUtil.GetLocaleText(attibuteCfg.name)
  local isRatio = attibuteCfg.num_type == 2
  if maxcount == nil or maxcount <= count then
    local value = initValue + (increaseValue or 0) * (count - 1)
    local valueStr = isRatio and tostring(FormatNum(value / 10)) .. "%" or tostring(value)
    local sign
    if value < 0 then
      sign = ""
    else
      sign = "+"
    end
    local content = atrName .. sign .. valueStr
    return content
  end
  local content = atrName .. "<color=#" .. ConfigData.buildinConfig.ChipLevelDarkColor .. ">(<color=#" .. ConfigData.buildinConfig.ChipLevelLightColor .. ">"
  for level = count, maxcount do
    local value = initValue + (increaseValue or 0) * (level - 1)
    local valueStr = isRatio and tostring(FormatNum(value / 10)) .. "%" or tostring(value)
    local sign
    if value < 0 then
      sign = ""
    else
      sign = "+"
    end
    if level == count then
      content = content .. sign .. valueStr .. "</color>"
    else
      content = content .. "/" .. sign .. valueStr
    end
  end
  content = content .. ")</color>"
  return content
end

function BattleUtil.GenMvp(playerRoleList)
  local heroGradeList = {}
  local typeTotalValue = {}
  local bestDamageID, bestInjuryID, bestHealID
  local bestDamageNum = 0
  local bestInjuryNum = 0
  local bestHealNum = 0
  for i = 0, playerRoleList.Count - 1 do
    local role = playerRoleList[i]
    if not role.character.onBench then
      local heroCfg = ConfigData.hero_data[role.roleDataId]
      if heroCfg == nil then
        error("Can't find heroCfg by id, id = " .. tostring(role.roleDataId))
      else
        local MVPNum = 0
        local ok, damageDetail = CS.BattleStatistics.Instance.playerDamage:TryGetValue(role)
        if ok then
          MVPNum = MVPNum + damageDetail.damage * heroCfg.mvp_para[BattleUtil.mvpParaType.damage]
          if bestDamageNum < damageDetail.damage then
            bestDamageNum = damageDetail.damage
            bestDamageID = role.roleDataId
          end
        end
        local ok, takeDamageDetail = CS.BattleStatistics.Instance.playerTakeDamage:TryGetValue(role)
        if ok then
          MVPNum = MVPNum + takeDamageDetail.damage * heroCfg.mvp_para[BattleUtil.mvpParaType.injury]
          if bestInjuryNum < takeDamageDetail.damage then
            bestInjuryNum = takeDamageDetail.damage
            bestInjuryID = role.roleDataId
          end
        end
        local ok, healDetail = CS.BattleStatistics.Instance.playerHeal:TryGetValue(role)
        if ok then
          MVPNum = MVPNum + healDetail.selfHeal * heroCfg.mvp_para[BattleUtil.mvpParaType.selfHeal]
          MVPNum = MVPNum + healDetail.otherHeal * heroCfg.mvp_para[BattleUtil.mvpParaType.otherHeal]
          if bestHealNum < healDetail.heal then
            bestHealNum = healDetail.heal
            bestHealID = role.roleDataId
          end
        end
        local gradeTab = {role = role, MVPNum = MVPNum}
        table.insert(heroGradeList, gradeTab)
      end
    end
  end
  if #heroGradeList <= 0 then
    return nil
  end
  table.sort(heroGradeList, function(role1, role2)
    if role1.MVPNum ~= role2.MVPNum then
      return role1.MVPNum > role2.MVPNum
    else
      return role1.role.roleDataId < role2.role.roleDataId
    end
  end)
  local mvp = heroGradeList[1]
  local MvpFitNum = 0
  if mvp.role.roleDataId == bestDamageID then
    mvp.MvpType = BattleUtil.mvpType.damagem
    MvpFitNum = MvpFitNum + 1
  end
  if mvp.role.roleDataId == bestInjuryID then
    mvp.MvpType = BattleUtil.mvpType.injury
    MvpFitNum = MvpFitNum + 1
  end
  if mvp.role.roleDataId == bestHealID then
    mvp.MvpType = BattleUtil.mvpType.heal
    MvpFitNum = MvpFitNum + 1
  end
  if MvpFitNum == 0 or 1 < MvpFitNum then
    mvp.MvpType = BattleUtil.mvpType.default
  end
  return mvp
end

function BattleUtil.CalculateBloodGrid(maxBlood, minBlood)
  local bloodGridDivisor = ConfigData.game_config.bloodGridDivisor
  local booldBossRatio = ConfigData.game_config.booldBossRatio
  maxBlood = maxBlood or 0
  minBlood = minBlood or 0
  bloodGridDivisor = 0 < bloodGridDivisor and bloodGridDivisor or 1
  local unitBlood = (maxBlood + minBlood) / bloodGridDivisor
  booldBossRatio = 0 < booldBossRatio and booldBossRatio or 1
  local bossUnitBlood = unitBlood * booldBossRatio
  return math.floor(unitBlood), math.floor(bossUnitBlood), ConfigData.game_config.bloodGridMax
end

function BattleUtil.CalculateBloodDensity(bloodPre)
  local ratio = bloodPre * 100
  local res = 0
  local beforBloodRatio
  for i, bloodRatio in ipairs(ConfigData.game_config.bloodDensitySortList) do
    if ratio >= bloodRatio[2] then
      res = bloodRatio[1]
    else
      local beforBloodShow = beforBloodRatio ~= nil and beforBloodRatio[1] or 0
      local beforBloodReal = beforBloodRatio ~= nil and beforBloodRatio[2] or 0
      local diffUnit = (bloodRatio[1] - beforBloodShow) / (bloodRatio[2] - beforBloodShow)
      res = res + diffUnit * (ratio - beforBloodReal)
      break
    end
    beforBloodRatio = bloodRatio
  end
  return res / 100
end

function BattleUtil.TryGetCurBattleDungeonType()
  local dungeonCtrl = BattleDungeonManager:GetDungeonCtrl()
  if dungeonCtrl ~= nil then
    return dungeonCtrl.dungeonCfg.dungeon_type
  end
  if ExplorationManager.epCtrl ~= nil then
    local curRoomData = ExplorationManager.epCtrl:GetCurrentRoomData()
    return curRoomData.dungeonType
  end
  return -1
end

function BattleUtil.IsInTDBattle()
  if BattleEditorManager ~= nil then
    return BattleEditorManager.isInTdMode
  end
  return BattleDungeonManager:IsInTDDungeon() or ExplorationManager:IsInTDExp()
end

function BattleUtil.IsInBrotatBattle()
  if BattleEditorManager ~= nil then
    return BattleEditorManager.isInBrotatoMode
  end
  return BattleDungeonManager:IsInBrotatoDungeon() or ExplorationManager:IsInBrotatoExp()
end

function BattleUtil.IsInGuardBattle()
  if BattleEditorManager ~= nil then
    return BattleEditorManager.isInGuardMode
  end
  return BattleDungeonManager:IsInGuardDungeon() or ExplorationManager:IsInGuardExp() or WarChessManager:IsWCInGuardBattle()
end

function BattleUtil.IsSpecialTDMode()
  if not ExplorationManager:IsInExploration() then
    return false
  end
  local isTDBattle = false
  if ExplorationManager.floorId ~= nil then
    local expCfg = ConfigData.exploration[ExplorationManager.floorId]
    if expCfg ~= nil and ExplorationManager:CheckTDModeByMapLogic(expCfg.map_logic) then
      isTDBattle = true
    end
  end
  if not isTDBattle then
    return false
  end
  for _, v in pairs(ConfigData.buildinConfig.SpecialDungeon) do
    if v == ExplorationManager.dungeonId then
      return true
    end
  end
  return false
end

function BattleUtil.IsInCardSetDungeon()
  local dungeonType = BattleUtil.TryGetCurBattleDungeonType()
  return dungeonType == proto_csmsg_DungeonType.DungeonType_ActivityCard
end

function BattleUtil.IsInDailyDungeon()
  local dungeonType = BattleUtil.TryGetCurBattleDungeonType()
  return dungeonType == proto_csmsg_DungeonType.DungeonType_Daily
end

function BattleUtil.IsInWinterChallengeDungeon()
  local dungeonType = BattleUtil.TryGetCurBattleDungeonType()
  return dungeonType == proto_csmsg_DungeonType.DungeonType_WinterHard
end

function BattleUtil.IsInHGV3NormalDungeon(isNeedFree)
  local dungeonType = BattleUtil.TryGetCurBattleDungeonType()
  return dungeonType == proto_csmsg_DungeonType.DungeonType_HeroLite and not isNeedFree or dungeonType == proto_csmsg_DungeonType.DungeonType_HeroLiteFree
end

function BattleUtil.IsBattleEnableFormation()
  return BattleUtil.IsInDailyDungeon() or BattleUtil.IsInWinterChallengeDungeon() or BattleUtil.IsInHGV3NormalDungeon(true)
end

function BattleUtil.GetGuidTipId()
  if ExplorationManager:IsInExploration() then
    local dungeonId = ExplorationManager:GetEpDungeonId()
    local cfg = ConfigData.sector_stage[dungeonId]
    if cfg ~= nil then
      return cfg.guide_id
    end
  end
  if WarChessManager:GetIsInWarChess() then
    if WarChessManager:IsWCInBattle() then
      return false
    end
    local cfg = WarChessManager:GetWCSectorStageCfg()
    if cfg ~= nil then
      return cfg.guide_id
    end
  end
  return 0
end

function BattleUtil.IsSupportInterruptPlay()
  local isUnlockInterruptEp = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_InterruptEp)
  if not isUnlockInterruptEp then
    return false
  end
  if ExplorationManager:IsInExploration() then
    if ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
      local dungeonId = ExplorationManager:GetEpDungeonId()
      local cfg = ConfigData.sector_stage[dungeonId]
      if cfg ~= nil then
        return not cfg.destroy
      end
    end
    return true
  end
  if WarChessManager:GetIsInWarChess() then
    if WarChessManager:IsWCInBattle() then
      return false
    end
    local cfg = WarChessManager:GetWCSectorStageCfg()
    if cfg ~= nil then
      return not cfg.destroy
    end
    return true
  end
  return false
end

BattleUtil.LogicFrameCount = 15
BattleUtil.CheatFrame = 4294967295

function BattleUtil.FrameToTime(frame)
  frame = frame or 0
  return frame // BattleUtil.LogicFrameCount
end

function BattleUtil.SecondToFrame(second)
  if second == nil then
    return 0
  end
  return second * BattleUtil.LogicFrameCount
end

function BattleUtil.FrameToTimeString(frame, needMs)
  frame = frame or 0
  if frame >= BattleUtil.CheatFrame then
    return ConfigData:GetTipContent(1020)
  end
  local t = frame // BattleUtil.LogicFrameCount
  local s = math.floor(t % 60)
  local m = math.floor(t / 60 % 60)
  local h = math.floor(t / 3600)
  local content
  if needMs then
    local ms = math.floor((frame / BattleUtil.LogicFrameCount - t) * 1000)
    if 0 < h then
      content = string.format("%02d:%02d:%02d.%03d", h, m, s, ms)
    else
      content = string.format("%02d:%02d.%03d", m, s, ms)
    end
  elseif 0 < h then
    content = string.format("%02d:%02d:%02d", h, m, s)
  else
    content = string.format("%02d:%02d", m, s)
  end
  return content
end

function BattleUtil.TryGetCurBattleBloodGridCfg()
  local dungeonCtrl = BattleDungeonManager:GetDungeonCtrl()
  if dungeonCtrl ~= nil then
    return true, dungeonCtrl.unitBlood, dungeonCtrl.bossUnitBlood, dungeonCtrl.bloodGridMax
  end
  if ExplorationManager.epCtrl ~= nil then
    local epCtrl = ExplorationManager.epCtrl
    return true, epCtrl.unitBlood, epCtrl.bossUnitBlood, epCtrl.bloodGridMax
  end
  return false
end

function BattleUtil.GetCurDynPlayer(withouWarning)
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if wcCtrl ~= nil then
    return wcCtrl.battleCtrl.curDynPlayer
  end
  local dungeonCtrl = BattleDungeonManager:GetDungeonCtrl()
  if dungeonCtrl ~= nil then
    return dungeonCtrl.dynPlayer
  end
  if ExplorationManager.epCtrl ~= nil then
    return ExplorationManager.epCtrl.dynPlayer
  end
  if not withouWarning then
    warn("Cant get cur DynPlayerl")
  end
end

function BattleUtil.GetCurSceneCtrl()
  local dungeonCtrl = BattleDungeonManager:GetDungeonCtrl()
  if dungeonCtrl ~= nil then
    return dungeonCtrl.sceneCtrl
  end
  if ExplorationManager.epCtrl ~= nil then
    return ExplorationManager.epCtrl.sceneCtrl
  end
  warn("Cant get scene ctrl")
end

function BattleUtil.GetCurSceneBattleFieldSize()
  local dungeonCtrl = BattleDungeonManager:GetDungeonCtrl()
  if dungeonCtrl ~= nil then
    local dungeonCfg = dungeonCtrl.dungeonCfg
    return dungeonCfg.size_row, dungeonCfg.size_col, dungeonCfg.deploy_rows, dungeonCfg.grid_scale_factor
  end
  if ExplorationManager.epCtrl ~= nil then
    return ExplorationManager:GetEpSceneBattleFieldSize()
  end
  warn("Cant get cur scene battle field size")
end

function BattleUtil.IsAllowCstChangeShowMoudle(battleType)
  if BattleEditorManager ~= nil then
    return false
  end
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill) then
    return false
  end
  if BattleUtil.IsInBrotatBattle() then
    return false
  end
  if BattleUtil.IsInGuardBattle() and BattleUtil.TryGetFixedCstSkills() ~= nil then
    return false
  end
  if BattleDungeonManager:InBattleDungeon() then
    if BattleDungeonManager:IsInTDDungeon() then
      return false
    end
    local allow = not BattleDungeonManager.dungeonCtrl.dungeonCfg.close_cmdskill
    return allow
  end
  if battleType == nil and ExplorationManager:IsInExploration() then
    if ExplorationManager:IsInTDExp() then
      return false
    end
    battleType = ExplorationManager:GetEpModuleTypeCfgId()
  end
  if battleType == nil then
    return false
  end
  local explorationTypeCfg = ConfigData.exploration_type[battleType]
  if explorationTypeCfg == nil then
    return false
  end
  return explorationTypeCfg.refresh_command_skill_tree
end

function BattleUtil.TryGetFixedCstSkills()
  if ExplorationManager:IsInExploration() then
    local stageId = ExplorationManager:GetEpDungeonId()
    return ConfigData:GetFixedCstSkillsExp(stageId)
  end
  if BattleDungeonManager:InBattleDungeon() then
    return BattleDungeonManager:GetFixedCSTInfo()
  end
  return false
end

function BattleUtil.GetConsumeChipLimit()
  if ExplorationManager:IsInExploration() then
    local value = ExplorationManager:GetSectorStageCfg().active_alg_limit
    if 0 < value then
      return value
    end
  end
  return ConfigData.game_config.activeAlgNumMax
end

function BattleUtil.ShowBattleResultSkada(csbattleController, closeFunc)
  UIManager:ShowWindowAsync(UIWindowTypeID.ResultSkada, function(window)
    if window == nil then
      return
    end
    window:InitBattleSkada(cs_BattleStatistics, csbattleController.PlayerTeamController.battleOriginRoleList, csbattleController.EnemyTeamController.battleOriginRoleList)
    window:SetSkadaCloseCallback(closeFunc)
  end)
end

function BattleUtil.BattleAbleSelectChipSuit()
  if BattleDungeonManager:InBattleDungeon() and BattleDungeonManager.dunInterfaceData ~= nil then
    return BattleDungeonManager.dunInterfaceData:GetAbleSelectChipSuit()
  end
  return false
end

function BattleUtil.TryGetDungeonLvTowerLvInfo()
  if BattleDungeonManager:InBattleDungeon() and BattleDungeonManager.dunInterfaceData ~= nil then
    return BattleDungeonManager.dunInterfaceData:TryGetDungeonTowerLvInfo()
  end
  return nil, 0
end

function BattleUtil.TryRunAfterClickBattleCallback(callback)
  if BattleDungeonManager:InBattleDungeon() and BattleDungeonManager.dunInterfaceData ~= nil then
    local afterClickBattleFunc = BattleDungeonManager.dunInterfaceData:GetAfterClickBattleFunc()
    if afterClickBattleFunc ~= nil then
      afterClickBattleFunc(callback)
      return
    end
  end
  if callback ~= nil then
    callback()
  end
end

function BattleUtil.IsBattleInPause()
  local battleCtrl = cs_BattleManager.Instance.CurBattleController
  return battleCtrl ~= nil and battleCtrl:BattleIsPause() or false
end

function BattleUtil.GetCustoMoveCtrl()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if wcCtrl ~= nil then
    return nil
  end
  local dungeonCtrl = BattleDungeonManager:GetDungeonCtrl()
  if dungeonCtrl ~= nil then
    return dungeonCtrl.CustomMoveCtrl
  end
  if ExplorationManager.epCtrl ~= nil then
    return ExplorationManager.epCtrl.battleCtrl.CustomMoveCtrl
  end
end

return BattleUtil
