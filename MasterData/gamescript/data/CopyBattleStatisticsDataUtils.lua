local CopyBattleStatisticsDataUtils = {}
local MsgPack = require("cmsgpack")
local Lz4 = require("lz4")
local PLAYER_OWNER_TID = 1
local STAT_MAIN_BATTLE_VALUE = "battleValue"
local STAT_KEY_TO_FIELD = {
  AwakerDoDamage = "damage",
  AwakerDoHeal = "heal",
  AwakerDoBlock = "shield"
}
local FIELD_TO_MAP = {
  damage = "damageMap",
  heal = "healMap",
  shield = "shieldMap"
}

local function NewMetric()
  return {
    damage = 0,
    heal = 0,
    shield = 0
  }
end

local function AddMetric(metric, field, value)
  metric[field] = metric[field] + value
end

local function AddOwnerMetric(map, ownerId, value)
  if ownerId and 0 ~= value then
    map[ownerId] = (tonumber(map[ownerId]) or 0) + value
  end
end

local function CopyNumberMap(src)
  local dst = {}
  for ownerId, value in pairs(src) do
    if 0 ~= value then
      dst[ownerId] = (dst[ownerId] or 0) + value
    end
  end
  return dst
end

local function AddSkillAggValue(skillAgg, ownerId, bucketKey, configId, field, value)
  if not ownerId or 0 == value then
    return
  end
  local ownerRows = skillAgg[ownerId]
  if not ownerRows then
    ownerRows = {}
    skillAgg[ownerId] = ownerRows
  end
  local rowKey = tostring(bucketKey) .. ":" .. tostring(configId)
  local row = ownerRows[rowKey]
  if not row then
    row = {
      bucketKey = bucketKey,
      configId = configId,
      damage = 0,
      heal = 0,
      shield = 0
    }
    ownerRows[rowKey] = row
  end
  row[field] = row[field] + value
end

local function MergeSkillAgg(dst, src)
  for ownerId, rowsByKey in pairs(src) do
    dst[ownerId] = dst[ownerId] or {}
    for rowKey, srcRow in pairs(rowsByKey) do
      local dstRow = dst[ownerId][rowKey]
      if not dstRow then
        dstRow = {
          bucketKey = srcRow.bucketKey,
          configId = srcRow.configId,
          damage = 0,
          heal = 0,
          shield = 0
        }
        dst[ownerId][rowKey] = dstRow
      end
      dstRow.damage = dstRow.damage + srcRow.damage
      dstRow.heal = dstRow.heal + srcRow.heal
      dstRow.shield = dstRow.shield + srcRow.shield
    end
  end
end

local function DecodeBattleStatPack(packedBase64)
  if type(packedBase64) ~= "string" or "" == packedBase64 then
    return nil
  end
  if not _ejoysdk_crypt or type(_ejoysdk_crypt.base64decode) ~= "function" then
    return nil
  end
  local ok, bin = pcall(_ejoysdk_crypt.base64decode, packedBase64)
  if not ok or type(bin) ~= "string" or "" == bin then
    return nil
  end
  ok, bin = pcall(Lz4.decompress, bin)
  if not ok or type(bin) ~= "string" or "" == bin then
    return nil
  end
  local root
  ok, root = pcall(MsgPack.unpack, bin)
  if ok and type(root) == "table" then
    return root
  end
  return nil
end

local function GetDecodedRoundList(decoded)
  if not decoded or type(decoded) ~= "table" then
    return {}
  end
  if nil ~= decoded[STAT_MAIN_BATTLE_VALUE] then
    return {
      {
        roundIndex = tonumber(decoded.roundIndex) or 1,
        entry = decoded
      }
    }
  end
  local out = {}
  for roundKey, roundEntry in pairs(decoded) do
    if type(roundEntry) == "table" then
      local roundIndex = tonumber(roundEntry.roundIndex) or tonumber(roundKey)
      if roundIndex and roundIndex > 0 then
        out[#out + 1] = {roundIndex = roundIndex, entry = roundEntry}
      end
    end
  end
  table.sort(out, function(a, b)
    return a.roundIndex < b.roundIndex
  end)
  return out
end

local function CollectBattleValue(battleValue, roundRow)
  if not battleValue then
    return
  end
  for ownerKey, byBucket in pairs(battleValue) do
    local ownerId = tonumber(ownerKey)
    if ownerId then
      for bucketKey, byCfg in pairs(byBucket) do
        for configId, statTbl in pairs(byCfg) do
          for statKey, rawVal in pairs(statTbl) do
            local field = STAT_KEY_TO_FIELD[statKey]
            local value = tonumber(rawVal) or 0
            if field and 0 ~= value then
              AddMetric(roundRow, field, value)
              AddOwnerMetric(roundRow[FIELD_TO_MAP[field]], ownerId, value)
              AddSkillAggValue(roundRow.skillAgg, ownerId, bucketKey, configId, field, value)
            end
          end
        end
      end
    end
  end
end

local function BuildBattleRowFromDecodedPack(decoded, battleIndex, gearType)
  local battleRow = {
    battleIndex = battleIndex,
    gearType = tonumber(gearType) or 0,
    rounds = {}
  }
  for _, roundItem in ipairs(GetDecodedRoundList(decoded)) do
    local roundEntry = roundItem.entry
    if type(roundEntry) == "table" then
      local roundRow = {
        battleIndex = battleIndex,
        roundIndex = roundItem.roundIndex,
        damage = 0,
        heal = 0,
        shield = 0,
        damageMap = {},
        healMap = {},
        shieldMap = {},
        skillAgg = {}
      }
      CollectBattleValue(roundEntry[STAT_MAIN_BATTLE_VALUE], roundRow)
      battleRow.rounds[#battleRow.rounds + 1] = roundRow
    end
  end
  return battleRow
end

local function ResolveBattleIndex(key, exitRow, fallbackIndex)
  return tonumber(type(exitRow) == "table" and exitRow.battleIndex) or tonumber(key) or tonumber(string.match(tostring(key or ""), "(%d+)")) or fallbackIndex
end

local function BuildBattlesFromPackExitList(recordStageData)
  local battles = {}
  local exitList = type(recordStageData) == "table" and recordStageData.battleStatPackExitList or nil
  if type(exitList) ~= "table" then
    return battles
  end
  for exitKey, exitRow in pairs(exitList) do
    if type(exitRow) == "table" then
      local decoded = DecodeBattleStatPack(exitRow.battleStatPack)
      if decoded then
        local battleIndex = ResolveBattleIndex(exitKey, exitRow, #battles + 1)
        local battleRow = BuildBattleRowFromDecodedPack(decoded, battleIndex, exitRow.gearType)
        if #battleRow.rounds > 0 then
          battles[#battles + 1] = battleRow
        end
      end
    end
  end
  table.sort(battles, function(a, b)
    return (tonumber(a and a.battleIndex) or 0) < (tonumber(b and b.battleIndex) or 0)
  end)
  return battles
end

local function TryGetTeamAwakersFromRecordStage(recordStageData)
  if type(recordStageData) ~= "table" then
    return nil
  end
  local arr = recordStageData.awakers or recordStageData.teamAwakers or recordStageData.battleAwakers
  if type(arr) == "table" and #arr > 0 then
    return arr
  end
  local teamData = recordStageData.teamData
  if type(teamData) == "table" and "table" == type(teamData.awakers) and #teamData.awakers > 0 then
    return teamData.awakers
  end
  return nil
end

local function ExtractSkillSlotLevelsFromAwakerPayload(payload)
  local out = {}
  if type(payload) ~= "table" then
    return out
  end
  local skills = payload.skills or payload.slots
  if type(skills) ~= "table" then
    return out
  end
  for k, entry in pairs(skills) do
    if type(entry) == "table" then
      local slot = tonumber(entry.slot)
      if not slot and type(k) == "number" then
        slot = k
      end
      local lv = tonumber(entry.level or entry.lv)
      if slot and slot > 0 and lv then
        out[slot] = lv
      end
    end
  end
  return out
end

local function AwakerPayloadIsAssist(aw)
  if type(aw) ~= "table" then
    return false
  end
  local assistPlayerId = tonumber(aw.assistPlayerId)
  if assistPlayerId and 0 ~= assistPlayerId then
    return true
  end
  return aw.isAssist == true
end

local function ResolveIsAssist(rsAw, stAw, battleAw, slotIndex, slotAssist)
  if AwakerPayloadIsAssist(rsAw) then
    return true
  end
  if AwakerPayloadIsAssist(stAw) then
    return true
  end
  if AwakerPayloadIsAssist(battleAw) then
    return true
  end
  return false
end

local function IsHistoricalRecordStage(recordStageData)
  if type(recordStageData) ~= "table" then
    return false
  end
  local wid = recordStageData.wid
  return nil ~= wid and "" ~= wid
end

local function BuildAwakerMetaBySlot(settleAwakerDatas, recordStageData, teamAssistSlot)
  local rsTeam = TryGetTeamAwakersFromRecordStage(recordStageData)
  local slotAssist = teamAssistSlot or CommonDefine.TeamAssistPos
  local metaBySlot = {}
  for slotIndex, stAw in ipairs(settleAwakerDatas or {}) do
    local tid = tonumber(stAw and stAw.tid) or 0
    if 0 ~= tid then
      local rsAw = rsTeam and rsTeam[slotIndex]
      if type(rsAw) == "table" and tonumber(rsAw.tid) and tonumber(rsAw.tid) ~= tid then
        rsAw = nil
        for _, cand in ipairs(rsTeam or {}) do
          if type(cand) == "table" and tonumber(cand.tid) == tid then
            rsAw = cand
            break
          end
        end
      end
      local battleAw
      if not IsHistoricalRecordStage(recordStageData) then
        battleAw = CopyAwakerDataUtils.GetBattleAwakerData(tid)
      end
      local fromRs = ExtractSkillSlotLevelsFromAwakerPayload(rsAw)
      local fromSt = ExtractSkillSlotLevelsFromAwakerPayload(stAw)
      metaBySlot[slotIndex] = {
        isAssist = ResolveIsAssist(rsAw, stAw, battleAw, slotIndex, slotAssist),
        skillSlotLevels = next(fromRs) and fromRs or fromSt
      }
    end
  end
  return metaBySlot
end

local function ShallowCopyAwaker(base, isAssist)
  if not base then
    return nil
  end
  local copy = table.clone(base)
  copy.isAssist = isAssist
  return copy
end

function CopyBattleStatisticsDataUtils.ApplyRecordOwnerSnapshot(recordStageData, playerId)
  if type(recordStageData) ~= "table" then
    return recordStageData
  end
  local uid = tonumber(playerId or recordStageData.playerUid or recordStageData.playerId or recordStageData.uid)
  if uid then
    recordStageData.playerUid = uid
  end
  local facade = uid and CopyRecordsModel.Instance and CopyRecordsModel.Instance:GetRecordFacade(uid)
  if facade then
    if not recordStageData.playerName and not recordStageData.name then
      recordStageData.playerName = facade.name
    end
    if recordStageData.playerGender == nil and nil == recordStageData.gender and nil ~= facade.gender then
      recordStageData.playerGender = facade.gender
    end
  end
  return recordStageData
end

function CopyBattleStatisticsDataUtils.ResolvePlayerDisplayName(row)
  if row and row.playerName and row.playerName ~= "" then
    return row.playerName
  end
  local uid = tonumber(row and row.playerUid)
  if uid and uid ~= PlayerDataUtils.GetPlayerUid() then
    return ""
  end
  do return end
  return PlayerDataUtils.GetName
end

function CopyBattleStatisticsDataUtils.ResolvePlayerDisplayLevel(row)
  local level = tonumber(row and row.playerLevel)
  if level then
    return level
  end
  local uid = tonumber(row and row.playerUid)
  if uid and uid ~= PlayerDataUtils.GetPlayerUid() then
    return 0
  end
  do return end
  return PlayerDataUtils.GetLevel
end

function CopyBattleStatisticsDataUtils.ResolvePlayerDisplayGender(row)
  local gender = tonumber(row and row.playerGender)
  if gender and gender > 0 then
    return gender
  end
  local uid = tonumber(row and row.playerUid)
  if uid and uid == PlayerDataUtils.GetPlayerUid() then
    do return end
    return PlayerDataUtils.GetGender
  end
  return nil
end

function CopyBattleStatisticsDataUtils.IsPlayerStatisticRow(row)
  if not row then
    return false
  end
  if row.playerUid ~= nil then
    return true
  end
  return tonumber(row.ownerId) == PLAYER_OWNER_TID and (not row.awakerData or not row.awakerData.tid)
end

function CopyBattleStatisticsDataUtils.ResolvePlayerBattleHeadRes(row)
  do return GenderDataUtils.GetBattleMainHeadRes, CopyBattleStatisticsDataUtils.ResolvePlayerDisplayGender(row) end
  return GenderDataUtils.GetBattleMainHeadRes, CopyBattleStatisticsDataUtils.ResolvePlayerDisplayGender(row)
end

function CopyBattleStatisticsDataUtils.IsAssistStatisticRow(row)
  if not row then
    return false
  end
  if row.isAssist == true then
    return true
  end
  do return AwakerPayloadIsAssist end
  return AwakerPayloadIsAssist, row.awakerData
end

local function BuildPlayerSnapshot(recordStageData)
  local data = type(recordStageData) == "table" and recordStageData or {}
  local localUid = PlayerDataUtils.GetPlayerUid()
  local uid = tonumber(data.playerUid or data.uid or data.playerId)
  local isLocalPlayer = not uid or uid == localUid
  local name = data.playerName or data.name
  if not name and isLocalPlayer then
    name = PlayerDataUtils.GetName()
  end
  local level = tonumber(data.playerLevel or data.level)
  if not level and isLocalPlayer then
    level = PlayerDataUtils.GetLevel()
  end
  local gender = tonumber(data.playerGender or data.gender)
  if nil == gender and isLocalPlayer then
    gender = PlayerDataUtils.GetGender()
  end
  if not uid and isLocalPlayer then
    uid = localUid
  end
  return {
    uid = uid,
    name = name or "",
    level = level or 0,
    gender = gender
  }
end

local function BuildOwnerBaseRows(viewData, settleAwakerDatas, recordStageData, teamAssistSlot)
  local metaBySlot = BuildAwakerMetaBySlot(settleAwakerDatas, recordStageData, teamAssistSlot)
  for slotIndex, awakerData in ipairs(settleAwakerDatas or {}) do
    local tid = tonumber(awakerData and awakerData.tid)
    if tid and 0 ~= tid then
      local battleAwakerData
      if not IsHistoricalRecordStage(recordStageData) then
        battleAwakerData = CopyAwakerDataUtils.GetBattleAwakerData(tid)
      end
      local meta = metaBySlot[slotIndex] or {}
      local row = {
        ownerId = tid,
        awakerData = ShallowCopyAwaker(awakerData or battleAwakerData, meta.isAssist == true),
        playerUid = nil,
        isAssist = meta.isAssist == true,
        slotIndex = slotIndex,
        skillSlotLevels = meta.skillSlotLevels or {},
        damage = 0,
        heal = 0,
        shield = 0,
        skillRows = {}
      }
      viewData.ownerBaseRows[#viewData.ownerBaseRows + 1] = row
      viewData.ownerRowMap[tid] = row
    end
  end
  local playerSnapshot = BuildPlayerSnapshot(recordStageData)
  local playerRow = {
    ownerId = PLAYER_OWNER_TID,
    awakerData = nil,
    playerUid = playerSnapshot.uid,
    playerName = playerSnapshot.name,
    playerLevel = playerSnapshot.level,
    playerGender = playerSnapshot.gender,
    isAssist = false,
    slotIndex = nil,
    skillSlotLevels = {},
    damage = 0,
    heal = 0,
    shield = 0,
    skillRows = {}
  }
  viewData.ownerBaseRows[#viewData.ownerBaseRows + 1] = playerRow
  viewData.ownerRowMap[PLAYER_OWNER_TID] = playerRow
end

local function CloneOwnerBaseRow(row)
  local copy = table.clone(row)
  copy.damage = 0
  copy.heal = 0
  copy.shield = 0
  copy.skillRows = {}
  return copy
end

local function ForEachRoundByScope(viewData, battleIndex, roundIndex, visitor)
  local bf = tonumber(battleIndex) or 0
  local rf = tonumber(roundIndex) or 0
  for _, battleRow in ipairs(viewData and viewData.battles or {}) do
    local bIdx = tonumber(battleRow and battleRow.battleIndex) or 0
    if 0 == bf or bf == bIdx then
      for _, roundRow in ipairs(battleRow.rounds or {}) do
        local rIdx = tonumber(roundRow and roundRow.roundIndex) or 0
        if 0 == rf or rf == rIdx then
          visitor(battleRow, roundRow)
        end
      end
    end
  end
end

local function DeriveSkillStatisticLtKeyFromRawName(rawName)
  local prefix, rest = string.match(tostring(rawName or ""), "^(%a+):(.+)$")
  if prefix and string.lower(prefix) == "state" and rest and not tonumber(rest) then
    return rest
  end
  return nil
end

local function BuildSkillRowsFromAggRows(rowsByKey, ownerId)
  local rows = {}
  for _, row in pairs(rowsByKey or {}) do
    local rawName = string.format("%s:%s", tostring(row.bucketKey), tostring(row.configId))
    rows[#rows + 1] = {
      ownerAwakerTid = ownerId,
      skillNameRaw = rawName,
      skillLtKey = DeriveSkillStatisticLtKeyFromRawName(rawName),
      statisticType = row.bucketKey,
      defaultOrder = tonumber(row.configId),
      damage = row.damage,
      heal = row.heal,
      shield = row.shield
    }
  end
  table.sort(rows, function(a, b)
    local ao = tonumber(a and a.defaultOrder) or 0
    local bo = tonumber(b and b.defaultOrder) or 0
    if ao ~= bo then
      return ao < bo
    end
    return tostring(a and a.skillNameRaw or "") < tostring(b and b.skillNameRaw or "")
  end)
  return rows
end

local function BuildRawOwnerSkillRowsByScope(viewData, ownerId, battleIndex, roundIndex)
  local mergedAgg = {}
  ForEachRoundByScope(viewData, battleIndex, roundIndex, function(_, roundRow)
    MergeSkillAgg(mergedAgg, roundRow.skillAgg)
  end)
  do return BuildSkillRowsFromAggRows, mergedAgg[ownerId] end
  return BuildSkillRowsFromAggRows, mergedAgg[ownerId], ownerId, roundIndex, function(_, roundRow)
    MergeSkillAgg(mergedAgg, roundRow.skillAgg)
  end
end

local function IsUtilSkillStatisticRow(row)
  local typ = string.lower(tostring(row and row.statisticType or ""))
  typ = string.gsub(typ, "%s+", "")
  if "utilskill" == typ then
    return true
  end
  local namePrefix = string.match(tostring(row and row.skillNameRaw or ""), "^(%a+):")
  return namePrefix and string.lower(namePrefix) == "utilskill"
end

function CopyBattleStatisticsDataUtils.ResolveSkillSlotIndex(awakerTid, skillTid)
  awakerTid = tonumber(awakerTid)
  skillTid = tonumber(skillTid)
  if not (awakerTid and not (awakerTid <= 0) and skillTid) or skillTid <= 0 then
    return nil
  end
  local slot = AwakerDataUtils.GetSkillSlotBySkillId(awakerTid, skillTid)
  if slot and slot > 0 then
    return slot
  end
  if SkillCfgUtils then
    local slotKey = SkillCfgUtils.GetCfgField("Slot", skillTid)
    slot = tonumber(slotKey) or slotKey and CommonDefine.AwakerSkillSlot[slotKey]
    if slot and slot > 0 then
      return slot
    end
  end
  local battleAw = CopyAwakerDataUtils.GetBattleAwakerData(awakerTid)
  if battleAw and type(battleAw.skills) == "table" then
    for k, entry in pairs(battleAw.skills) do
      if type(entry) == "table" and tonumber(entry.tid) == skillTid then
        local s = tonumber(entry.slot)
        if not s and type(k) == "number" then
          s = k
        end
        if s and s > 0 then
          return s
        end
      end
    end
  end
  return nil
end

function CopyBattleStatisticsDataUtils.ResolveSkillRowDisplayLabel(row)
  if not row or type(row) ~= "table" then
    return ""
  end
  if IsUtilSkillStatisticRow(row) then
    local superInfo = AwakerDataUtils.GetSuperUltiSkillInfo(tonumber(row.ownerAwakerTid))
    if superInfo and superInfo.name and "" ~= superInfo.name then
      return superInfo.name
    end
  end
  if row.skillLtKey and "" ~= row.skillLtKey then
    do return LT.Text end
    return LT.Text, row.skillLtKey, tonumber(row.ownerAwakerTid)
  end
  local configId = tonumber(row.defaultOrder)
  local rawStr = tostring(row.skillNameRaw or "")
  if (not configId or configId <= 0) and "" ~= rawStr then
    configId = tonumber(string.match(rawStr, ":(%-?%d+)$"))
  end
  local typ = string.lower(tostring(row.statisticType or ""))
  typ = string.gsub(typ, "%s+", "")
  local namePrefix = string.match(rawStr, "^(%a+):")
  local namePrefixLower = namePrefix and string.lower(namePrefix) or ""
  local isStateRow = "status" == typ or "state" == typ or "state" == namePrefixLower and configId and configId > 0
  if isStateRow and configId and configId > 0 then
    local nameKey = StateCfgUtils and StateCfgUtils.GetCfgField("Name", configId)
    if nameKey and "" ~= nameKey then
      do return LT.Text end
      return LT.Text, nameKey, tostring(row.statisticType or "")
    end
    local cnId = StateCfgUtils and StateCfgUtils.GetCfgField("CnID", configId) or configId
    do return string.format, "undefine:%s" end
    return string.format, "undefine:%s", cnId
  end
  if "skill" == typ and configId and configId > 0 and SkillCfgUtils then
    local skillName = SkillCfgUtils.GetCfgField("Name", configId)
    if skillName and "" ~= skillName then
      return skillName
    end
  end
  return rawStr
end

local function GetSkillRowMergeKey(row)
  local label = CopyBattleStatisticsDataUtils.ResolveSkillRowDisplayLabel(row)
  if label and "" ~= label then
    return label
  end
  return "\000raw\000" .. tostring(row and row.skillNameRaw or "")
end

local function GetStatisticRowConfigId(row)
  if not row or type(row) ~= "table" then
    return 0
  end
  local configId = tonumber(row.defaultOrder)
  local rawStr = tostring(row.skillNameRaw or "")
  if (not configId or configId <= 0) and "" ~= rawStr then
    configId = tonumber(string.match(rawStr, ":(%-?%d+)$"))
  end
  return tonumber(configId) or 0
end

local function GetMergeRepKind(row)
  if not row or type(row) ~= "table" then
    return 0
  end
  local typ = string.lower(tostring(row.statisticType or ""))
  typ = string.gsub(typ, "%s+", "")
  if "skill" == typ or "utilskill" == typ then
    return 2
  end
  local configId = GetStatisticRowConfigId(row)
  local rawStr = tostring(row.skillNameRaw or "")
  local namePrefix = string.match(rawStr, "^(%a+):")
  local namePrefixLower = namePrefix and string.lower(namePrefix) or ""
  local isStateRow = "status" == typ or "state" == typ or "state" == namePrefixLower and configId > 0
  if isStateRow then
    return 1
  end
  return 0
end

local function MergeRepRowBetterThan(a, b)
  if not a or type(a) ~= "table" then
    return false
  end
  if not b or type(b) ~= "table" then
    return true
  end
  local ka, kb = GetMergeRepKind(a), GetMergeRepKind(b)
  if ka ~= kb then
    return ka > kb
  end
  local ta, tb = GetStatisticRowConfigId(a), GetStatisticRowConfigId(b)
  if ta ~= tb then
    return ta > tb
  end
  local sa = (tonumber(a.damage) or 0) + (tonumber(a.heal) or 0) + (tonumber(a.shield) or 0)
  local sb = (tonumber(b.damage) or 0) + (tonumber(b.heal) or 0) + (tonumber(b.shield) or 0)
  return sa > sb
end

local function MergeSkillRowsByDisplayName(rows)
  local orderKeys = {}
  local groups = {}
  for idx, row in ipairs(rows or {}) do
    local key = GetSkillRowMergeKey(row)
    local d, h, s = row.damage or 0, row.heal or 0, row.shield or 0
    local group = groups[key]
    if not group then
      orderKeys[#orderKeys + 1] = key
      groups[key] = {
        damage = d,
        heal = h,
        shield = s,
        count = 1,
        firstIndex = idx,
        rep = row
      }
    else
      group.damage = group.damage + d
      group.heal = group.heal + h
      group.shield = group.shield + s
      group.count = group.count + 1
      if MergeRepRowBetterThan(row, group.rep) then
        group.rep = row
      end
    end
  end
  local merged = {}
  local barMax = NewMetric()
  for _, key in ipairs(orderKeys) do
    local group = groups[key]
    local row = table.clone(group.rep)
    row.damage = group.damage
    row.heal = group.heal
    row.shield = group.shield
    row._originIndex = group.firstIndex
    row._mergedSourceCount = group.count
    merged[#merged + 1] = row
    barMax.damage = math.max(barMax.damage, row.damage)
    barMax.heal = math.max(barMax.heal, row.heal)
    barMax.shield = math.max(barMax.shield, row.shield)
  end
  return merged, barMax
end

local function FillFromSkillRowsIfEmpty(row)
  if row.damage > 0 or row.heal > 0 or row.shield > 0 then
    return
  end
  for _, skillRow in ipairs(row.skillRows or {}) do
    row.damage = row.damage + (tonumber(skillRow.damage) or 0)
    row.heal = row.heal + (tonumber(skillRow.heal) or 0)
    row.shield = row.shield + (tonumber(skillRow.shield) or 0)
  end
end

function CopyBattleStatisticsDataUtils.BuildViewData(settleAwakerDatas, recordStageData, teamAssistSlot)
  local viewData = {
    battles = BuildBattlesFromPackExitList(recordStageData),
    ownerBaseRows = {},
    ownerRowMap = {}
  }
  BuildOwnerBaseRows(viewData, settleAwakerDatas, recordStageData, teamAssistSlot)
  return viewData
end

function CopyBattleStatisticsDataUtils.BuildOwnerRowsByScope(viewData, battleIndex, roundIndex)
  local metricMap = {}
  ForEachRoundByScope(viewData, battleIndex, roundIndex, function(_, roundRow)
    for ownerId, value in pairs(roundRow.damageMap) do
      metricMap[ownerId] = metricMap[ownerId] or NewMetric()
      metricMap[ownerId].damage = metricMap[ownerId].damage + value
    end
    for ownerId, value in pairs(roundRow.healMap) do
      metricMap[ownerId] = metricMap[ownerId] or NewMetric()
      metricMap[ownerId].heal = metricMap[ownerId].heal + value
    end
    for ownerId, value in pairs(roundRow.shieldMap) do
      metricMap[ownerId] = metricMap[ownerId] or NewMetric()
      metricMap[ownerId].shield = metricMap[ownerId].shield + value
    end
  end)
  local rows = {}
  for _, baseRow in ipairs(viewData and viewData.ownerBaseRows or {}) do
    local row = CloneOwnerBaseRow(baseRow)
    local metric = metricMap[row.ownerId] or NewMetric()
    row.damage, row.heal, row.shield = metric.damage, metric.heal, metric.shield
    row.skillRows = BuildRawOwnerSkillRowsByScope(viewData, row.ownerId, battleIndex, roundIndex)
    FillFromSkillRowsIfEmpty(row)
    rows[#rows + 1] = row
  end
  return rows
end

function CopyBattleStatisticsDataUtils.BuildOwnerSkillRowsByScope(viewData, ownerId, battleIndex, roundIndex, extraFields)
  local rawRows = BuildRawOwnerSkillRowsByScope(viewData, ownerId, battleIndex, roundIndex)
  local copied = {}
  for idx, row in ipairs(rawRows) do
    local one = table.clone(row)
    one._originIndex = idx
    if extraFields then
      for k, v in pairs(extraFields) do
        one[k] = v
      end
    end
    copied[#copied + 1] = one
  end
  do return MergeSkillRowsByDisplayName end
  return MergeSkillRowsByDisplayName, copied, ipairs(rawRows)
end

function CopyBattleStatisticsDataUtils.BuildRoundRowsByScope(viewData, battleIndex, roundIndex)
  local rows = {}
  ForEachRoundByScope(viewData, battleIndex, roundIndex, function(_, roundRow)
    rows[#rows + 1] = {
      battleIndex = roundRow.battleIndex,
      roundIndex = roundRow.roundIndex,
      damage = roundRow.damage,
      heal = roundRow.heal,
      shield = roundRow.shield,
      damageMap = CopyNumberMap(roundRow.damageMap),
      healMap = CopyNumberMap(roundRow.healMap),
      shieldMap = CopyNumberMap(roundRow.shieldMap)
    }
  end)
  return rows
end

local function GetBattleRowMaxRoundIndex(battleRow)
  local maxRound = 0
  for _, roundRow in ipairs(battleRow and battleRow.rounds or {}) do
    local rIdx = tonumber(roundRow and roundRow.roundIndex) or 0
    if maxRound < rIdx then
      maxRound = rIdx
    end
  end
  return maxRound
end

function CopyBattleStatisticsDataUtils.GetMaxRoundIndex(viewData, battleIndex)
  local battles = viewData and viewData.battles or {}
  local bf = tonumber(battleIndex) or 0
  if bf <= 0 then
    local maxRound = 0
    for _, battleRow in ipairs(battles) do
      maxRound = math.max(maxRound, GetBattleRowMaxRoundIndex(battleRow))
    end
    return maxRound
  end
  for pos, battleRow in ipairs(battles) do
    local idx = tonumber(battleRow.battleIndex) or pos
    if idx == bf then
      return GetBattleRowMaxRoundIndex(battleRow)
    end
  end
  return 0
end

function CopyBattleStatisticsDataUtils.GetLastBossBattleIndex(viewData)
  local fallbackIndex, bossIndex = 0, 0
  for pos, battleRow in ipairs(viewData and viewData.battles or {}) do
    local battleIndex = tonumber(battleRow and battleRow.battleIndex) or pos
    fallbackIndex = battleIndex
    if tonumber(battleRow and battleRow.gearType) == CommonDefine.GearItemType.Boss then
      bossIndex = battleIndex
    end
  end
  return bossIndex > 0 and bossIndex or fallbackIndex
end

function CopyBattleStatisticsDataUtils.GetBattleOptionList(viewData)
  local list = {}
  for pos, battleRow in ipairs(viewData and viewData.battles or {}) do
    local gearType = tonumber(battleRow and battleRow.gearType) or 0
    local typeOrder = 0
    for i = 1, pos do
      local row = viewData.battles[i]
      if row and (tonumber(row.gearType) or 0) == gearType then
        typeOrder = typeOrder + 1
      end
    end
    list[#list + 1] = {
      battleIndex = tonumber(battleRow and battleRow.battleIndex) or pos,
      gearType = gearType,
      typeOrder = typeOrder
    }
  end
  
  local function categoryRank(gt)
    if gt == CommonDefine.GearItemType.Boss then
      return 1
    end
    if gt == CommonDefine.GearItemType.EliteMonster then
      return 2
    end
    return 3
  end
  
  table.sort(list, function(a, b)
    local ra, rb = categoryRank(a.gearType), categoryRank(b.gearType)
    if ra ~= rb then
      return ra < rb
    end
    local oa, ob = tonumber(a.typeOrder) or 0, tonumber(b.typeOrder) or 0
    if oa ~= ob then
      return oa < ob
    end
    return (tonumber(a.battleIndex) or 0) < (tonumber(b.battleIndex) or 0)
  end)
  return list
end

function CopyBattleStatisticsDataUtils.GetSkillRowsMetricSummary(row)
  local summary = {
    sum = NewMetric(),
    max = NewMetric()
  }
  for _, skillRow in ipairs(row and row.skillRows or {}) do
    local damage = tonumber(skillRow and skillRow.damage) or 0
    local heal = tonumber(skillRow and skillRow.heal) or 0
    local shield = tonumber(skillRow and skillRow.shield) or 0
    summary.sum.damage = summary.sum.damage + damage
    summary.sum.heal = summary.sum.heal + heal
    summary.sum.shield = summary.sum.shield + shield
    summary.max.damage = math.max(summary.max.damage, damage)
    summary.max.heal = math.max(summary.max.heal, heal)
    summary.max.shield = math.max(summary.max.shield, shield)
  end
  return summary
end

function CopyBattleStatisticsDataUtils.BarPercentCeil(value, vmax)
  if not (value and vmax) or value <= 0 or vmax <= 0 then
    return 0
  end
  do return math.min, 100, math.ceil(value / vmax * 100) end
  return math.min, 100, math.ceil(value / vmax * 100)
end

function CopyBattleStatisticsDataUtils.FormatSharePercent(value, total)
  if not (value and not (value <= 0) and total) or total <= 0 then
    return "0%"
  end
  do return string.format, "%d%%", math.ceil(value / total * 100) end
  return string.format, "%d%%", math.ceil(value / total * 100)
end

return CopyBattleStatisticsDataUtils
