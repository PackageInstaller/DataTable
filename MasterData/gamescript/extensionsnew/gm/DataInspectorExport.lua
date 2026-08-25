local DataInspectorExport = {}
DataInspectorExport.DefaultDepth = 2
DataInspectorExport.PageSize = 200
DataInspectorExport.MaxDisplayLen = 200
DataInspectorExport.SearchNodeLimit = 200000
local registry = {}
local registrySeq = 0
local currentDomain = "client"

local function ResetRegistry(domain)
  currentDomain = domain or "client"
  for id, entry in pairs(registry) do
    if entry.domain == currentDomain then
      registry[id] = nil
    end
  end
end

local function RegisterTable(value, path)
  registrySeq = registrySeq + 1
  local id = tostring(registrySeq)
  registry[id] = {
    value = value,
    path = path,
    domain = currentDomain
  }
  return id
end

local NAME_FIELDS = {
  "Name",
  "CnID",
  "MonsterName",
  "Title",
  "NameEn"
}
local KEY_TABLE_HINTS = {
  itemTid = "Item",
  itemID = "Item",
  itemId = "Item",
  trinketTid = "Item",
  awakerTid = "AwakerConfig",
  awakerID = "AwakerConfig",
  awakerId = "AwakerConfig",
  skillTid = "Skill",
  skillID = "Skill",
  skillId = "Skill",
  skillConfigId = "Skill",
  schoolId = "SchoolConfig",
  schoolTid = "SchoolConfig",
  schoolConfigId = "SchoolConfig",
  monsterTid = "MonsterConfig",
  monsterId = "MonsterConfig",
  summonTid = "Summon",
  summonId = "Summon",
  lotteryTid = "Lottery",
  lotteryId = "Lottery",
  dropTid = "Drop",
  dropId = "Drop",
  featureTid = "FeatureUnlock",
  featureId = "FeatureUnlock",
  talentTid = "AwakerTalent",
  talentId = "AwakerTalent",
  mapNodeId = "MapNode",
  nodeTid = "MapNode",
  collectionTid = "CollectionHall",
  resonanceTid = "Resonance",
  relicTid = "RelicConfig",
  enchantTid = "EnchantConfig",
  seasonTid = "PVPSeason",
  seasonId = "PVPSeason",
  activityTid = "Activity",
  activityId = "Activity",
  activityID = "Activity",
  taskTid = "Task",
  taskId = "Task",
  taskID = "Task",
  shopTid = "Shop",
  shopId = "Shop",
  shopItemTid = "Shop",
  goodsTid = "Shop",
  goodsId = "Shop",
  stageGroupID = "StageGroup",
  stageGroupId = "StageGroup",
  stageGroupTid = "StageGroup"
}
local PATH_TABLE_HINTS = {
  {
    "awaker",
    "AwakerConfig"
  },
  {"trinket", "Item"},
  {"itembag", "Item"},
  {"itemdata", "Item"},
  {
    "bagitemdata",
    "Item"
  },
  {
    "talent",
    "AwakerTalent"
  },
  {"skill", "Skill"},
  {"mainshop", "Shop"},
  {"shop", "Shop"},
  {"summon", "Summon"},
  {"task", "Task"},
  {"activity", "Activity"},
  {"battlepass", "BattlePass"},
  {
    "relic",
    "RelicConfig"
  },
  {"resonance", "Resonance"},
  {"barrier", "Stage"},
  {"stage", "Stage"},
  {
    "collection",
    "CollectionHall"
  },
  {
    "monster",
    "MonsterConfig"
  },
  {
    "feature",
    "FeatureUnlock"
  },
  {
    "school",
    "SchoolConfig"
  },
  {"lottery", "Lottery"},
  {
    "battleruntime",
    "Skill"
  },
  {
    "awakers",
    "AwakerConfig"
  },
  {"states", "State"}
}
local SECTION_HINTS = {
  playerData = "玩家基础（角色/货币/功能解锁/统计）",
  itemData = "背包（道具/装备/饰品/货币）",
  taskData = "任务",
  activityData = "活动",
  redPointData = "红点",
  mainShopData = "主界面商城/礼包",
  shopData = "副本内商店",
  copiesData = "副本",
  MainCopyData = "主线进度",
  dbgMainCopyData = "DBG 主线进度",
  copyData = "当前副本",
  barrierData = "关卡",
  worldStageDataList = "关卡组",
  awakerData = "唤醒体",
  summonData = "召唤/抽卡",
  teamData = "编队",
  dbgTeamData = "DBG 编队",
  pvpTeamBuildData = "PvP 编队",
  battleData = "战斗（DataCenter 占位，几乎为空；实时数据见 BattleRuntime）",
  cardData = "卡牌",
  relicData = "遗物",
  mailData = "邮件",
  battlePassData = "通行证",
  tutorialData = "教程",
  guideData = "指引",
  introductionData = "新手介绍",
  dailyDungeonData = "每日副本",
  dailyCopyData = "日常挑战本",
  dailyChallengeData = "幻梦深浅",
  schoolTowerData = "界域塔",
  rpgArenaData = "Rpg 竞技场",
  socialData = "社交",
  communicateData = "聊天/交流",
  friendMatchData = "友谊赛",
  pvpMatchData = "PvP 匹配",
  pvpSettleData = "PvP 结算",
  pvpSeasonData = "PvP 赛季",
  pvpCollectionData = "PvP 收藏",
  rankData = "通用排行榜",
  rankingBoardData = "日常挑战排行榜",
  resonanceData = "共鸣",
  alchemyData = "炼金",
  backTrackData = "时间回溯",
  loginData = "登录（服务器/UID）",
  gameData = "游戏全局（版本/GM 开关）",
  clientData = "客户端存服数据",
  BattleRuntime = "战斗中实时（角色/回合/手牌/Buff）",
  townData = "主城",
  mapData = "地图",
  stateData = "副本内状态",
  mainInterfaceData = "主交互界面",
  moveJoyData = "摇杆",
  popTipsData = "通用提示"
}
DataInspectorExport.SECTION_HINTS = SECTION_HINTS
local RED_POINT_CN = {
  awaker = "唤醒体",
  AwakerPotency = "唤醒体潜能",
  AwakerLevel = "唤醒体等级",
  AwakerBreakthrough = "唤醒体突破",
  AwakerSkill = "唤醒体技能",
  AwakerTrinket = "唤醒体饰品",
  AwakerNew = "唤醒体新获得",
  AwakerSpecialSkill = "唤醒体专属技能",
  AwakerFreeTrial = "唤醒体试用",
  red_moneycollect = "金币本可收取",
  red_open_moneylevel = "金币本新解锁",
  red_drawcard_one = "普通池单抽",
  red_new_drawcard_up = "UP 池新开",
  NewLotteryOpen = "抽奖池开启",
  DrawCardChooseCareer = "界域选择",
  red_arenacollect = "竞技场可收取",
  red_open_arena = "竞技场新解锁",
  red_open_rescopy = "资源本新解锁",
  red_open_trinketcopy = "饰品本新解锁",
  red_open_trinketcopy_stage = "饰品本关卡",
  MainShop = "主商城（isNew）",
  Shop = "商店（red）",
  task = "任务",
  red_technology = "科技",
  red_build_prize = "建筑奖励",
  Item = "道具",
  DailyCopyNew = "日常本新开",
  red_weekchallenge_new = "周挑战新开",
  red_mail = "邮件",
  red_collect_mail = "藏品邮件",
  ComposeNew = "合成新开",
  DecomposeNew = "分解新开",
  RecastNew = "重铸新开",
  ExchangeNew = "兑换新开",
  red_stage_group_star = "关卡组星级奖励",
  AchivementCanGain = "成就可领取",
  new_stage_unlock = "新关卡解锁",
  new_stage_group_unlock = "新关卡组解锁",
  NewVoice = "新语音",
  NewStory = "新剧情",
  red_resonance_upgrade = "共鸣可升级",
  BattlePass = "通行证",
  ItemConversion = "道具转换",
  WeekBossChallenge = "周 Boss 挑战",
  red_daily_challenge_week_prize = "幻梦周奖励",
  red_daily_challenge_exp_prize = "幻梦经验奖励",
  MonthCardExpire = "月卡到期",
  EnergyCardExpire = "体力卡到期",
  PvpRankReward = "PvP 段位奖励",
  Tutorial = "教程",
  AlternationSchoolTower = "界域塔",
  MockCopy = "模拟战",
  AbyssChallengeScorePrize = "深渊积分奖励",
  AbyssChallenge = "深渊新解锁",
  EmojiNew = "新表情",
  Collection = "藏品",
  InvitationCode = "邀请码",
  red_activity = "活动服务器红点",
  Activity = "活动",
  Announcement = "公告",
  AnnouncementEnter = "公告入口",
  Social = "社交",
  BackTrack = "时间回溯",
  BackTrackOnce = "时间回溯一次性",
  DonationBox = "募捐箱",
  ProduceBox = "生产箱"
}
local redPointNames

local function RedPointName(key)
  if not redPointNames then
    redPointNames = {}
    local ok = pcall(function()
      for constName, value in pairs(RedPointDataUtils.RedType) do
        if type(value) == "string" then
          redPointNames[value] = RED_POINT_CN[value] or constName
        end
      end
    end)
    if not ok then
      redPointNames = {}
    end
    for value, cn in pairs(RED_POINT_CN) do
      if not redPointNames[value] then
        redPointNames[value] = cn
      end
    end
  end
  return redPointNames[key]
end

local SPECIAL_NAMES = {
  Activity = function(cfg)
    return cfg.ActivityName
  end,
  Task = function(cfg)
    return cfg.Desc
  end,
  Shop = function(cfg)
    local itemTid = cfg.Item and cfg.Item[1]
    if not itemTid then
      return nil
    end
    local name = ItemDataUtils and ItemDataUtils.GetItemName and ItemDataUtils.GetItemName(itemTid)
    if name and "" ~= name then
      return name
    end
    return nil
  end
}

local function CfgName(tableName, id)
  local ok, name = pcall(function()
    local tbl = DT and DT[tableName]
    local cfg = tbl and tbl[id]
    if not cfg then
      return nil
    end
    local special = SPECIAL_NAMES[tableName]
    if special then
      local raw = special(cfg)
      if raw and "" ~= raw then
        local text = LT.Text(raw)
        if text and "" ~= text then
          return text
        end
        return raw
      end
    end
    for _, field in ipairs(NAME_FIELDS) do
      local raw = cfg[field]
      if raw and "" ~= raw then
        local text = LT.Text(raw)
        if text and "" ~= text then
          return text
        end
      end
    end
    return nil
  end)
  if ok then
    return name
  end
  return nil
end

DataInspectorExport._CfgName = CfgName

function DataInspectorExport.ResolveHint(path, key, value)
  local keyStr = tostring(key)
  local pathStr = tostring(path or "")
  if "uid" == keyStr or "UID" == keyStr or "playerId" == keyStr then
    return nil
  end
  if pathStr == "DataCenter." .. keyStr and SECTION_HINTS[keyStr] then
    return SECTION_HINTS[keyStr]
  end
  if pathStr == "ClientMemory." .. keyStr and SECTION_HINTS[keyStr] then
    return SECTION_HINTS[keyStr]
  end
  if pathStr == "ClientMemory.BattleRuntime." .. keyStr then
    local battleHints = {
      summary = "战斗摘要",
      bout = "回合/阶段",
      roles = "战场角色（含唤醒体/怪物）",
      states = "Buff/状态",
      cards = "卡牌（按牌堆）",
      relic = "当前激活遗物"
    }
    return battleHints[keyStr]
  end
  local isRedPointPath = pathStr:find("edPointData") ~= nil or nil ~= pathStr:find("edpoint")
  if isRedPointPath then
    local rp = RedPointName(keyStr)
    if rp then
      return rp
    end
  end
  local numValue = type(value) == "number" and value > 0 and value or nil
  local numKey = type(key) == "number" and key > 0 and key or nil
  if numValue then
    local hint = DataInspectorExport._HintByValue(pathStr, keyStr, numValue)
    if hint then
      return hint
    end
  end
  if numKey then
    if isRedPointPath and numKey > 1000 and StageCfgUtils and StageCfgUtils.GetStageName then
      local name = StageCfgUtils.GetStageName(numKey)
      if name and "" ~= name then
        return name
      end
    end
    local lower = pathStr:lower()
    for _, pair in ipairs(PATH_TABLE_HINTS) do
      if lower:find(pair[1], 1, true) then
        local name = CfgName(pair[2], numKey)
        if name then
          return name
        end
      end
    end
  end
  return nil
end

local function NonEmpty(text)
  if text and "" ~= text then
    return text
  end
  return nil
end

function DataInspectorExport._HintByValue(pathStr, keyStr, value)
  if "stageID" == keyStr or "stageTid" == keyStr or "stageId" == keyStr then
    if StageCfgUtils and StageCfgUtils.GetStageName then
      local name = NonEmpty(StageCfgUtils.GetStageName(value))
      if name then
        return name
      end
    end
    local cfg = DT and DT.Stage and DT.Stage[value]
    if cfg and cfg.NameNumber then
      return tostring(cfg.NameNumber) .. " " .. LT.Text(cfg.Name)
    end
  end
  if (pathStr:find("awakerMap") or "awakerTid" == keyStr or "awakerID" == keyStr) and AwakerDataUtils and AwakerDataUtils.GetAwakerName then
    local name = NonEmpty(AwakerDataUtils.GetAwakerName(value))
    if name then
      return name
    end
  end
  if (pathStr:find("BagItemData") or "itemTid" == keyStr or "tid" == keyStr) and ItemDataUtils and ItemDataUtils.GetItemName then
    local name = NonEmpty(ItemDataUtils.GetItemName(value))
    if name then
      return name
    end
  end
  if "tid" == keyStr or "id" == keyStr or "ID" == keyStr then
    local lower = pathStr:lower()
    for _, pair in ipairs(PATH_TABLE_HINTS) do
      if lower:find(pair[1], 1, true) then
        local name = CfgName(pair[2], value)
        if name then
          return name
        end
      end
    end
  end
  local guess = KEY_TABLE_HINTS[keyStr]
  if guess then
    local name = CfgName(guess, value)
    if name then
      return name
    end
  end
  local base = keyStr:match("^(%a+)T?[iI][dD]$")
  if base then
    local upper = base:sub(1, 1):upper() .. base:sub(2)
    local name = CfgName(upper, value) or CfgName(upper .. "Config", value)
    if name then
      return name
    end
  end
  if "stageGroupID" == keyStr or "stageGroupId" == keyStr or "stageGroupTid" == keyStr then
    do return NonEmpty, CfgName("StageGroup", value) end
    return NonEmpty, CfgName("StageGroup", value)
  end
  if "taskTid" == keyStr or "taskID" == keyStr or "taskId" == keyStr then
    do return NonEmpty, CfgName("Task", value) end
    return NonEmpty, CfgName("Task", value)
  end
  if "activityTid" == keyStr or "activityID" == keyStr then
    do return NonEmpty, CfgName("Activity", value) end
    return NonEmpty, CfgName("Activity", value)
  end
  if "shopTid" == keyStr or "shopID" == keyStr then
    do return NonEmpty, CfgName("Shop", value) end
    return NonEmpty, CfgName("Shop", value)
  end
  return nil
end

local function AppendJsonEscapedByte(parts, b)
  parts[#parts + 1] = string.format("\\u%04x", b)
end

local function JsonEscape(str)
  str = tostring(str or "")
  local parts = {}
  local i, len = 1, #str
  while i <= len do
    local b = string.byte(str, i)
    if 92 == b then
      parts[#parts + 1] = "\\\\"
      i = i + 1
    elseif 34 == b then
      parts[#parts + 1] = "\\\""
      i = i + 1
    elseif b < 32 then
      AppendJsonEscapedByte(parts, b)
      i = i + 1
    elseif b < 128 then
      parts[#parts + 1] = string.char(b)
      i = i + 1
    elseif b >= 194 and b <= 223 then
      if len >= i + 1 then
        local b2 = string.byte(str, i + 1)
        if b2 >= 128 and b2 <= 191 then
          parts[#parts + 1] = str:sub(i, i + 1)
          i = i + 2
        else
          AppendJsonEscapedByte(parts, b)
          i = i + 1
        end
      else
        AppendJsonEscapedByte(parts, b)
        i = i + 1
      end
    elseif b >= 224 and b <= 239 then
      if len >= i + 2 then
        local b2, b3 = string.byte(str, i + 1), string.byte(str, i + 2)
        if b2 >= 128 and b2 <= 191 and b3 >= 128 and b3 <= 191 and (224 ~= b or not (b2 < 160)) and (237 ~= b or not (b2 > 159)) then
          parts[#parts + 1] = str:sub(i, i + 2)
          i = i + 3
        else
          AppendJsonEscapedByte(parts, b)
          i = i + 1
        end
      else
        AppendJsonEscapedByte(parts, b)
        i = i + 1
      end
    elseif b >= 240 and b <= 244 then
      if len >= i + 3 then
        local b2, b3, b4 = string.byte(str, i + 1), string.byte(str, i + 2), string.byte(str, i + 3)
        if b2 >= 128 and b2 <= 191 and b3 >= 128 and b3 <= 191 and b4 >= 128 and b4 <= 191 and (240 ~= b or not (b2 < 144)) and (244 ~= b or not (b2 > 143)) then
          parts[#parts + 1] = str:sub(i, i + 3)
          i = i + 4
        else
          AppendJsonEscapedByte(parts, b)
          i = i + 1
        end
      else
        AppendJsonEscapedByte(parts, b)
        i = i + 1
      end
    else
      AppendJsonEscapedByte(parts, b)
      i = i + 1
    end
  end
  do return table.concat end
  return table.concat, parts, parts, b, AppendJsonEscapedByte, parts, b, i, i + 3
end

DataInspectorExport._JsonEscape = JsonEscape

local function SortedKeys(t)
  local arrayLen = #t
  local keys = {}
  for i = 1, arrayLen do
    keys[#keys + 1] = i
  end
  local others = {}
  for k in pairs(t) do
    if type(k) ~= "number" or k < 1 or k > arrayLen or 0 ~= k % 1 then
      others[#others + 1] = k
    end
  end
  table.sort(others, function(a, b)
    local ta, tb = type(a), type(b)
    if "number" == ta and "number" == tb then
      return a < b
    end
    if ta ~= tb then
      return "number" == ta
    end
    return tostring(a) < tostring(b)
  end)
  for _, k in ipairs(others) do
    keys[#keys + 1] = k
  end
  return keys, arrayLen
end

local function ChildPath(parentPath, key, isArrayIndex)
  if isArrayIndex then
    return parentPath .. "[" .. tostring(key) .. "]"
  end
  return parentPath .. "." .. tostring(key)
end

local BuildNode, NodeToJson, SerializeValueJson

function SerializeValueJson(value, depth, seen)
  seen = seen or {}
  local kind = type(value)
  if "nil" == kind then
    return "null"
  end
  if "boolean" == kind then
    return value and "true" or "false"
  end
  if "number" == kind then
    if value ~= value or value == math.huge or value == -math.huge then
      return "null"
    end
    do return string.format, "%.14g" end
    return string.format, "%.14g", value, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  if "string" == kind then
    return "\"" .. JsonEscape(value) .. "\""
  end
  if "table" ~= kind then
    return "\"" .. JsonEscape(tostring(value)) .. "\""
  end
  if seen[value] then
    return "\"<cycle>\""
  end
  seen[value] = true
  if depth <= 0 then
    return "\"<max_depth>\""
  end
  local keys, arrayLen = SortedKeys(value)
  local parts = {}
  local isPureArray = arrayLen > 0
  if isPureArray then
    for i = 1, arrayLen do
      parts[#parts + 1] = SerializeValueJson(value[i], depth - 1, seen)
    end
    return "[" .. table.concat(parts, ",") .. "]"
  end
  for _, k in ipairs(keys) do
    local keyStr
    if type(k) == "string" then
      keyStr = "\"" .. JsonEscape(k) .. "\""
    else
      keyStr = "\"" .. JsonEscape(tostring(k)) .. "\""
    end
    parts[#parts + 1] = keyStr .. ":" .. SerializeValueJson(value[k], depth - 1, seen)
  end
  return "{" .. table.concat(parts, ",") .. "}"
end

function BuildNode(name, path, value, depth)
  local kind = type(value)
  local hint = DataInspectorExport.ResolveHint(path, name, value)
  if "table" ~= kind then
    local full = tostring(value)
    local shown = full
    if #shown > DataInspectorExport.MaxDisplayLen then
      shown = shown:sub(1, DataInspectorExport.MaxDisplayLen) .. " …"
    end
    local display = tostring(name) .. " = " .. shown
    if hint then
      display = display .. "  (" .. hint .. ")"
    end
    return {
      name = tostring(name),
      path = path,
      type = kind,
      display = display,
      hint = hint,
      leafValue = full,
      nodeId = nil,
      childCount = 0,
      children = {}
    }
  end
  local okKeys, keys, arrayLen = pcall(SortedKeys, value)
  if not okKeys then
    return {
      name = tostring(name),
      path = path,
      type = "error",
      display = tostring(name) .. " <遍历失败: " .. tostring(keys) .. ">",
      hint = nil,
      leafValue = tostring(keys),
      nodeId = nil,
      childCount = 0,
      children = {}
    }
  end
  local id = RegisterTable(value, path)
  local childCount = #keys
  local display = tostring(name) .. " {" .. tostring(childCount) .. "}"
  local wrapped = rawget(value, "value")
  if nil ~= wrapped and type(wrapped) ~= "table" then
    display = display .. " = " .. tostring(wrapped)
  end
  if hint then
    display = display .. "  [" .. hint .. "]"
  end
  local children = {}
  if depth > 0 then
    local limit = math.min(childCount, DataInspectorExport.PageSize)
    for i = 1, limit do
      local k = keys[i]
      local isIdx = type(k) == "number" and k >= 1 and arrayLen >= k
      children[#children + 1] = BuildNode(tostring(k), ChildPath(path, k, isIdx), value[k], depth - 1)
    end
  end
  return {
    name = tostring(name),
    path = path,
    type = "table",
    display = display,
    hint = hint,
    leafValue = nil,
    nodeId = id,
    childCount = childCount,
    children = children
  }
end

function NodeToJson(node)
  if not node then
    return "null"
  end
  local parts = {}
  parts[#parts + 1] = "\"name\":\"" .. JsonEscape(node.name) .. "\""
  parts[#parts + 1] = "\"path\":\"" .. JsonEscape(node.path) .. "\""
  parts[#parts + 1] = "\"type\":\"" .. JsonEscape(node.type) .. "\""
  parts[#parts + 1] = "\"display\":\"" .. JsonEscape(node.display) .. "\""
  if node.hint then
    parts[#parts + 1] = "\"hint\":\"" .. JsonEscape(node.hint) .. "\""
  else
    parts[#parts + 1] = "\"hint\":null"
  end
  if node.leafValue ~= nil then
    parts[#parts + 1] = "\"leafValue\":\"" .. JsonEscape(node.leafValue) .. "\""
  else
    parts[#parts + 1] = "\"leafValue\":null"
  end
  if node.nodeId then
    parts[#parts + 1] = "\"nodeId\":\"" .. JsonEscape(node.nodeId) .. "\""
  else
    parts[#parts + 1] = "\"nodeId\":null"
  end
  parts[#parts + 1] = "\"childCount\":" .. tostring(node.childCount or 0)
  local buf = {}
  for _, child in ipairs(node.children or {}) do
    buf[#buf + 1] = "{" .. NodeToJson(child) .. "}"
  end
  parts[#parts + 1] = "\"children\":[" .. table.concat(buf, ",") .. "]"
  do return table.concat, parts end
  return table.concat, parts, ",", "]", ",", nil, #buf + 1, "{" .. NodeToJson(child) .. "}", NodeToJson(child), "}"
end

local function UnwrapRef(v)
  if type(v) ~= "table" then
    return v
  end
  local inner = rawget(v, "value")
  if nil ~= inner then
    do return UnwrapRef end
    return UnwrapRef, inner
  end
  return v
end

local function CopyScalarMap(src)
  if type(src) ~= "table" then
    return nil
  end
  local out = {}
  for k, v in pairs(src) do
    local tv = type(v)
    if "number" == tv or "string" == tv or "boolean" == tv then
      out[tostring(k)] = v
    end
  end
  return out
end

local function SafeCall(obj, methodName, ...)
  if not obj or type(obj[methodName]) ~= "function" then
    return nil
  end
  local ok, ret = pcall(obj[methodName], obj, ...)
  if ok then
    return ret
  end
  return nil
end

local function SnapshotAwaker(awaker)
  if not awaker or type(awaker) ~= "table" then
    return nil
  end
  local nameHint
  pcall(function()
    if awaker.GetName then
      local raw = awaker:GetName()
      if raw and "" ~= raw then
        nameHint = LT and LT.Text(raw) or raw
      end
    end
    if (not nameHint or "" == nameHint) and awaker.tid then
      nameHint = CfgName("AwakerConfig", awaker.tid) or CfgName("MonsterConfig", awaker.tid)
    end
  end)
  return {
    uid = awaker.uid,
    tid = awaker.tid,
    nameHint = nameHint,
    level = awaker.level,
    dead = awaker.dead,
    battleFieldPos = awaker.battleFieldPos,
    isBoss = awaker.isBoss,
    isElite = awaker.isElite,
    isMonster = awaker.isMonster,
    properties = CopyScalarMap(awaker.properties)
  }
end

local function SnapshotRole(role)
  if not role or type(role) ~= "table" then
    return nil
  end
  local awakers = {}
  for i, aw in ipairs(role.awakerDataList or {}) do
    awakers[i] = SnapshotAwaker(aw)
  end
  return {
    uid = role.uid,
    camp = role.camp,
    roleType = role.roleType,
    dead = role.dead,
    level = role.level,
    playerId = role.playerId,
    properties = CopyScalarMap(role.properties),
    awakers = awakers
  }
end

local function SnapshotCard(card)
  if not card or type(card) ~= "table" then
    return nil
  end
  local configId = UnwrapRef(card.vueConfigId) or card.configId or card.srcConfigId
  return {
    uid = card.uid,
    configId = configId,
    skillHint = configId and CfgName("Skill", configId) or nil,
    deck = card.deck,
    level = card.level,
    usable = UnwrapRef(card.usable),
    ownerUid = card.ownerUid,
    camp = card.camp
  }
end

local function SnapshotCardMgrDecks(cardMgr, outKey, target)
  if not cardMgr or type(cardMgr) ~= "table" then
    return
  end
  if cardMgr.cardMgrList then
    for camp, mgr in pairs(cardMgr.cardMgrList) do
      SnapshotCardMgrDecks(mgr, outKey .. "_camp" .. tostring(camp), target)
    end
    return
  end
  local decks = {}
  for deckId, cardList in pairs(cardMgr.cardData or {}) do
    local list = {}
    for i, card in ipairs(cardList or {}) do
      list[i] = SnapshotCard(card)
    end
    decks[tostring(deckId)] = list
  end
  target[outKey] = decks
end

local function SnapshotBattleStates(stateData)
  if not stateData or type(stateData) ~= "table" then
    return nil
  end
  local states = {}
  for uid, st in pairs(stateData.stateUidMap or {}) do
    if type(st) == "table" then
      states[tostring(uid)] = {
        stateId = st.stateId,
        stateHint = st.stateId and CfgName("State", st.stateId) or nil,
        ownerUid = st.ownerUid,
        roleUid = st.roleUid,
        layer = st.layer,
        stateType = st.stateType
      }
    end
  end
  return states
end

function DataInspectorExport.CollectBattleRuntimeSnapshot()
  local bm = BattleManager and BattleManager.Instance
  if not (bm and bm.IsInBattle) or not bm:IsInBattle() then
    return nil
  end
  local bgRef = BattleGlobal
  local dc = bm.battleDataCenter or bgRef and bgRef.battleDataCenter
  if not dc then
    return {
      summary = {
        isInBattle = true,
        error = "battleDataCenter 为空"
      }
    }
  end
  local snap = {
    summary = {
      isInBattle = true,
      battleTid = dc.battleTid or bm.battleTid,
      myCamp = UnwrapRef(dc.myCamp),
      realCamp = SafeCall(dc, "GetRealCamp"),
      realEnergy = UnwrapRef(dc._realEnergy),
      isMyBoutEnd = UnwrapRef(dc._isMyBoutEnd),
      playerName = dc.playerName,
      isPVE = bgRef and bgRef.isPVE,
      isPVP = bgRef and bgRef.isPVP,
      isReplay = bgRef and bgRef.isReplay,
      opMode = UnwrapRef(dc.opMode),
      cardDimensionStep = SafeCall(dc, "GetCardDimensionStep")
    }
  }
  if dc.boutData then
    local bout = dc.boutData
    snap.bout = {
      phase = bout.phase,
      camp = bout.camp,
      boutNumber = bout.boutNumber,
      boutDamage = bout.boutDamage,
      statsBoutDamage = bout.statsBoutDamage,
      isExtraBout = bout.isExtraBout
    }
  end
  local roles = {}
  for uid, role in pairs(dc.roleDataModelMap or {}) do
    roles[tostring(uid)] = SnapshotRole(role)
  end
  snap.roles = roles
  if dc.stateData then
    snap.states = SnapshotBattleStates(dc.stateData)
  end
  if bm.battleRender and bm.battleRender.cardMgr then
    snap.cards = {}
    SnapshotCardMgrDecks(bm.battleRender.cardMgr, "decks", snap.cards)
  end
  if DataCenter and DataCenter.relicData then
    snap.relic = {
      CurActivedRelicIds = DataCenter.relicData.CurActivedRelicIds,
      CurActivedRelicDatas = DataCenter.relicData.CurActivedRelicDatas
    }
  end
  return snap
end

local BOUT_PHASE_NAME = {
  [bc.BoutPhase.None] = "None",
  [bc.BoutPhase.Begin] = "Begin",
  [bc.BoutPhase.Action] = "Action",
  [bc.BoutPhase.End] = "End"
}

local function GetBoutPhaseName(phase)
  return BOUT_PHASE_NAME[phase] or tostring(phase)
end

local function IsUiWindowOpen(url)
  if not (UIManager and UIManager.Instance) or not url then
    return false
  end
  return UIManager.Instance:GetWindow(url) ~= nil
end

local function SnapshotHandCardGlow(cardData, cardItem, dataCenter)
  if not cardData then
    return nil
  end
  local uid = cardData.uid
  local configData = cardData.configData
  local nameHint
  if configData and configData.Name then
    nameHint = LT.Text(configData.Name)
  end
  local canUse, canUseReason = cardData:CanUse()
  local entry = {
    uid = uid,
    configId = cardData.configId,
    nameHint = nameHint,
    deck = cardData.deck,
    cost = SafeCall(cardData, "GetCost"),
    configCost = SafeCall(cardData, "GetConfigCost"),
    canUse = canUse,
    canUseReason = canUseReason,
    checkUsable = SafeCall(cardData, "CheckUsable"),
    usableRef = UnwrapRef(cardData.usable),
    highlight = UnwrapRef(cardData.highlightEffect),
    costHp = SafeCall(cardData, "CostHp"),
    stateRed = uid and dataCenter.stateData and dataCenter.stateData:GetIsCardRedState(uid),
    stateYellow = uid and dataCenter.stateData and dataCenter.stateData:GetIsCardYellowState(uid)
  }
  if cardItem then
    entry.glow = {
      blue = cardItem:CheckIsBlueEffect(),
      yellow = cardItem:CheckIsYellowEffect(),
      red = cardItem:CheckIsRedEffect(),
      isShowLight = UnwrapRef(cardItem.isShowLight),
      interactable = UnwrapRef(cardItem.interactable),
      isInserting = UnwrapRef(cardItem.isInserting),
      inAnimation = cardItem.inAnimation,
      edgeActive = cardItem.ui and cardItem.ui.Root_Effect_BianYuan and cardItem.ui.Root_Effect_BianYuan.activeSelf,
      blueActive = cardItem.ui and cardItem.ui.Effect_Card_BianYuan_Lan_yzw_vx and cardItem.ui.Effect_Card_BianYuan_Lan_yzw_vx.activeSelf,
      yellowActive = cardItem.ui and cardItem.ui.Effect_Card_BianYuan_Huang_yzw_vx and cardItem.ui.Effect_Card_BianYuan_Huang_yzw_vx.activeSelf,
      redActive = cardItem.ui and cardItem.ui.Effect_Card_BianYuan_Hong_yzw_vx and cardItem.ui.Effect_Card_BianYuan_Hong_yzw_vx.activeSelf,
      sameCardRef = cardItem.card and cardItem.card.value == cardData
    }
  end
  return entry
end

local function CollectBattleCardGlowAnomalies(snap)
  local anomalies = {}
  local energy = snap.energy
  if energy and energy.desync then
    anomalies[#anomalies + 1] = string.format("算力双轨不一致: 显示=%s 预计算(_realEnergy)=%s 差值=%s", tostring(energy.displayEnergy), tostring(energy.realEnergy), tostring(energy.desyncDelta))
  end
  local bout = snap.bout
  for index, card in ipairs(snap.handCards or {}) do
    local glow = card.glow
    local label = card.nameHint or card.configId or index
    if glow and glow.blue and not card.canUse then
      anomalies[#anomalies + 1] = string.format("外框误发光: [%s] blueGlow=true canUse=false cost=%s", tostring(label), tostring(card.cost))
    end
    if card.canUse and type(card.cost) == "number" and energy and type(energy.realEnergy) == "number" and card.cost > energy.realEnergy and not card.costHp then
      anomalies[#anomalies + 1] = string.format("可用性异常: [%s] canUse=true 但 cost(%s)>realEnergy(%s)", tostring(label), tostring(card.cost), tostring(energy.realEnergy))
    end
    if glow and (glow.blue or glow.yellow or glow.red) and snap.summary and snap.summary.realCamp ~= snap.summary.myCamp then
      anomalies[#anomalies + 1] = string.format("非我方回合仍发光: [%s]", tostring(label))
    end
  end
  return anomalies
end

function DataInspectorExport.CollectBattleCardGlowSnapshot()
  local base = DataInspectorExport.CollectBattleRuntimeSnapshot()
  if not base then
    return nil
  end
  local bgRef = BattleGlobal
  local dc = bgRef and bgRef.battleDataCenter
  local recordMgr = bgRef and bgRef.battleRender and bgRef.battleRender.recordMgr
  local playerRole = dc and dc:GetPlayerRoleDataModel()
  local displayEnergy = playerRole and playerRole:GetProperty(bc.BattleProperty.energy)
  local maxEnergy = playerRole and playerRole:GetProperty(bc.BattleProperty.max_energy)
  local hpForEnergy = playerRole and playerRole:GetProperty(bc.BattleProperty.hp_for_energy)
  local realEnergy = dc and SafeCall(dc, "GetRealEnergy")
  local snap = {
    tag = "BattleCardGlowSnapshot",
    capturedAt = os.time(),
    summary = base.summary,
    bout = base.bout,
    energy = {
      displayEnergy = displayEnergy,
      realEnergy = realEnergy,
      maxEnergy = maxEnergy,
      hpForEnergy = hpForEnergy or 0
    },
    record = {
      playRecordState = recordMgr and recordMgr.playRecordState,
      recordQueueLen = recordMgr and recordMgr.recordList and #recordMgr.recordList or 0,
      curPlayQueueLen = recordMgr and recordMgr.curPlayRecordList and #recordMgr.curPlayRecordList or 0,
      recordTime = recordMgr and recordMgr.recordTime,
      realRecordTime = recordMgr and recordMgr.realRecordTime
    },
    uiPanels = {
      deckCardSelectOpen = IsUiWindowOpen(Urls and Urls.DeckCardSelectPanel),
      battleSelectCardsOpen = IsUiWindowOpen(Urls and Urls.DbgBattleSelectCardsPanel),
      cardDropSelectOpen = IsUiWindowOpen(Urls and Urls.BattleCardDropSelectView)
    },
    handCards = {},
    anomalies = {}
  }
  if snap.bout and snap.energy then
    local isMyActionPVE = bgRef and bgRef.isPVE and snap.bout.phase == bc.BoutPhase.Action and snap.summary and snap.summary.myCamp == snap.bout.camp
    snap.energy.isMyActionPVE = isMyActionPVE
    if isMyActionPVE and type(displayEnergy) == "number" and type(realEnergy) == "number" then
      snap.energy.desync = displayEnergy ~= realEnergy
      snap.energy.desyncDelta = realEnergy - displayEnergy
    end
  end
  if bgRef and bgRef.battlePanel then
    local cardUI = bgRef.battlePanel:GetCardUI()
    if not cardUI and dc and dc.GetRealCamp then
      cardUI = bgRef.battlePanel:GetCardUI(dc:GetRealCamp())
    end
    if cardUI and cardUI.cardMgr then
      local handList = cardUI.cardMgr:GetHandCardList() or {}
      local cardItemMap = cardUI.cardItemMap or {}
      for _, cardData in ipairs(handList) do
        local cardItem = cardItemMap[cardData]
        local entry = SnapshotHandCardGlow(cardData, cardItem, dc)
        if entry then
          snap.handCards[#snap.handCards + 1] = entry
        end
      end
      snap.cardUI = {
        myCamp = cardUI.myCamp,
        handCount = #handList,
        cardItemCount = 0,
        isPVPSelecting = cardUI.isPVPSelecting and cardUI.isPVPSelecting.value
      }
      for _ in pairs(cardItemMap) do
        snap.cardUI.cardItemCount = snap.cardUI.cardItemCount + 1
      end
    end
  end
  snap.anomalies = CollectBattleCardGlowAnomalies(snap)
  return snap
end

function DataInspectorExport.FormatBattleCardGlowSnapshotLines(snap)
  if not snap then
    return {
      "[BattleSnap] 当前不在战斗中"
    }
  end
  local lines = {}
  
  local function add(fmt, ...)
    lines[#lines + 1] = string.format(fmt, ...)
  end
  
  add("[BattleSnap] ===== 战斗客户端快照 tag=%s ts=%s =====", snap.tag or "?", tostring(snap.capturedAt))
  local summary = snap.summary or {}
  local bout = snap.bout or {}
  add("[BattleSnap] battleTid=%s myCamp=%s realCamp=%s opMode=%s isPVE=%s isReplay=%s", tostring(summary.battleTid), tostring(summary.myCamp), tostring(summary.realCamp), tostring(summary.opMode), tostring(summary.isPVE), tostring(summary.isReplay))
  add("[BattleSnap] bout phase=%s(%s) camp=%s number=%s damage=%s", tostring(bout.phase), GetBoutPhaseName(bout.phase), tostring(bout.camp), tostring(bout.boutNumber), tostring(bout.boutDamage))
  local energy = snap.energy or {}
  add("[BattleSnap] 算力 显示(displayEnergy)=%s 预计算(realEnergy)=%s max=%s hpForEnergy=%s", tostring(energy.displayEnergy), tostring(energy.realEnergy), tostring(energy.maxEnergy), tostring(energy.hpForEnergy))
  if energy.desync then
    add("[BattleSnap] !! 算力双轨不一致 desyncDelta(real-display)=%s", tostring(energy.desyncDelta))
  end
  local record = snap.record or {}
  add("[BattleSnap] 录像 playState=%s queue=%s curPlay=%s recordTime=%.3f realRecordTime=%.3f", tostring(record.playRecordState), tostring(record.recordQueueLen), tostring(record.curPlayQueueLen), record.recordTime or 0, record.realRecordTime or 0)
  local uiPanels = snap.uiPanels or {}
  add("[BattleSnap] UI选牌 deckSelect=%s battleSelect=%s cardDrop=%s", tostring(uiPanels.deckCardSelectOpen), tostring(uiPanels.battleSelectCardsOpen), tostring(uiPanels.cardDropSelectOpen))
  local cardUI = snap.cardUI or {}
  add("[BattleSnap] 手牌UI hand=%s cardItemMap=%s isPVPSelecting=%s", tostring(cardUI.handCount), tostring(cardUI.cardItemCount), tostring(cardUI.isPVPSelecting))
  for index, card in ipairs(snap.handCards or {}) do
    local glow = card.glow or {}
    add("[BattleSnap] 手牌#%d uid=%s name=%s cost=%s cfgCost=%s canUse=%s reason=%s checkUsable=%s costHp=%s", index, tostring(card.uid), tostring(card.nameHint), tostring(card.cost), tostring(card.configCost), tostring(card.canUse), tostring(card.canUseReason), tostring(card.checkUsable), tostring(card.costHp))
    if card.glow then
      add("[BattleSnap]   glow blue=%s yellow=%s red=%s edgeActive=%s blueActive=%s interactable=%s inAnim=%s", tostring(glow.blue), tostring(glow.yellow), tostring(glow.red), tostring(glow.edgeActive), tostring(glow.blueActive), tostring(glow.interactable), tostring(glow.inAnimation))
    else
      add("[BattleSnap]   glow (无CardItem)")
    end
  end
  if snap.anomalies and #snap.anomalies > 0 then
    add("[BattleSnap] ===== 自动检出异常 (%d) =====", #snap.anomalies)
    for _, msg in ipairs(snap.anomalies) do
      add("[BattleSnap] !! %s", msg)
    end
  else
    add("[BattleSnap] 自动检出异常: 无")
  end
  add("[BattleSnap] ===== 快照结束 =====")
  return lines
end

function DataInspectorExport.GetBattleLogRootDir()
  local rootDir = CS.UnityEngine.Application.persistentDataPath
  if ApplicationUtils and ApplicationUtils.is_editor_mode and ApplicationUtils.is_editor_mode() then
    rootDir = CS.System.Environment.CurrentDirectory
  end
  return rootDir
end

function DataInspectorExport.BuildBattleCardGlowSnapshotFileName(snap)
  local battleBase = BattleGlobal and BattleGlobal.battleRender and BattleGlobal.battleRender:GetLogFileName()
  if not battleBase or "" == battleBase then
    battleBase = "Battle"
  end
  local boutNumber = snap and snap.bout and snap.bout.boutNumber or 0
  local timeStr = os.date("%Y%m%d_%H%M%S", snap and snap.capturedAt or os.time())
  do return string.format, "ClientSnap_%s_bout%s_%s.txt", battleBase, (tostring(boutNumber)) end
  return string.format, "ClientSnap_%s_bout%s_%s.txt", battleBase, tostring(boutNumber), timeStr
end

function DataInspectorExport.SaveBattleCardGlowSnapshotToFile(snap)
  if not snap then
    return nil, nil, false, "not in battle"
  end
  local lines = DataInspectorExport.FormatBattleCardGlowSnapshotLines(snap)
  local content = table.concat(lines, "\n") .. "\n"
  local fileName = DataInspectorExport.BuildBattleCardGlowSnapshotFileName(snap)
  local relativePath = "BattleLog/" .. fileName
  local rootDir = DataInspectorExport.GetBattleLogRootDir()
  local fullPath = rootDir .. "/BattleLog/" .. fileName
  if BattleStatsDetailUtil and BattleStatsDetailUtil.WriteAll then
    BattleStatsDetailUtil.WriteAll(relativePath, content)
    if ApplicationUtils and ApplicationUtils.IsEditor and ApplicationUtils.IsEditor() then
      return relativePath, fullPath, true, nil
    end
  end
  local ok, err = pcall(function()
    CS.System.IO.Directory.CreateDirectory("BattleLog")
    local file = io.open(relativePath, "w")
    if not file then
      error("io.open failed: " .. tostring(relativePath))
    end
    file:write(content)
    file:close()
  end)
  if ok then
    fullPath = (CS.System.Environment.CurrentDirectory or rootDir) .. "/BattleLog/" .. fileName
    return relativePath, fullPath, true, nil
  end
  return relativePath, fullPath, false, tostring(err)
end

local function BuildClientMemoryRoot()
  local root = {
    DataCenter = DataCenter
  }
  local battleSnap = DataInspectorExport.CollectBattleRuntimeSnapshot()
  if battleSnap then
    root.BattleRuntime = battleSnap
  end
  return root
end

local function PlayerSummaryJson()
  local d = DataCenter and DataCenter.playerData and DataCenter.playerData.DRole
  if not d then
    return "null"
  end
  return "{" .. table.concat({
    "\"uid\":\"" .. JsonEscape(tostring(d.uid or 0)) .. "\"",
    "\"name\":\"" .. JsonEscape(tostring(d.name or "")) .. "\"",
    "\"level\":\"" .. JsonEscape(tostring(d.level or 0)) .. "\"",
    "\"exp\":\"" .. JsonEscape(tostring(d.exp or 0)) .. "\""
  }, ",") .. "}"
end

function DataInspectorExport.BuildClientTreeJson()
  if not DataCenter then
    return "{\"ok\":false,\"error\":\"DataCenter 尚未初始化，请登录进主界面后再刷新\"}"
  end
  ResetRegistry("client")
  local json
  local ok, err = pcall(function()
    local root = BuildNode("ClientMemory", "ClientMemory", BuildClientMemoryRoot(), DataInspectorExport.DefaultDepth)
    json = "{" .. table.concat({
      "\"ok\":true",
      "\"source\":\"client\"",
      "\"player\":" .. PlayerSummaryJson(),
      "\"pageSize\":" .. tostring(DataInspectorExport.PageSize),
      "\"tree\":{" .. NodeToJson(root) .. "}"
    }, ",") .. "}"
  end)
  if not ok then
    return "{\"ok\":false,\"error\":\"" .. JsonEscape(tostring(err)) .. "\"}"
  end
  return json
end

function DataInspectorExport.BuildChildrenJson(nodeId, offset, count, depth)
  local entry = registry[tostring(nodeId)]
  if not entry then
    return "{\"ok\":false,\"error\":\"节点已过期（数据被重新刷新过），请点「刷新全部」\"}"
  end
  offset = tonumber(offset) or 0
  count = tonumber(count) or DataInspectorExport.PageSize
  depth = tonumber(depth) or 1
  currentDomain = entry.domain or "client"
  local json
  local ok, err = pcall(function()
    local keys, arrayLen = SortedKeys(entry.value)
    local total = #keys
    local last = math.min(offset + count, total)
    local buf = {}
    for i = offset + 1, last do
      local k = keys[i]
      local isIdx = type(k) == "number" and k >= 1 and arrayLen >= k
      local node = BuildNode(tostring(k), ChildPath(entry.path, k, isIdx), entry.value[k], depth - 1)
      buf[#buf + 1] = "{" .. NodeToJson(node) .. "}"
    end
    json = "{" .. table.concat({
      "\"ok\":true",
      "\"nodeId\":\"" .. JsonEscape(tostring(nodeId)) .. "\"",
      "\"offset\":" .. tostring(offset),
      "\"childCount\":" .. tostring(total),
      "\"children\":[" .. table.concat(buf, ",") .. "]"
    }, ",") .. "}"
  end)
  if not ok then
    return "{\"ok\":false,\"error\":\"" .. JsonEscape(tostring(err)) .. "\"}"
  end
  return json
end

function DataInspectorExport.BuildSectionJson(sectionName)
  if "BattleRuntime" == sectionName then
    local battleSnap = DataInspectorExport.CollectBattleRuntimeSnapshot()
    if not battleSnap then
      return "{\"ok\":false,\"error\":\"当前不在战斗中，BattleRuntime 仅在战斗内可用\"}"
    end
    ResetRegistry("client")
    local json
    local ok, err = pcall(function()
      local node = BuildNode("BattleRuntime", "BattleRuntime", battleSnap, DataInspectorExport.DefaultDepth)
      json = "{" .. table.concat({
        "\"ok\":true",
        "\"source\":\"client\"",
        "\"pageSize\":" .. tostring(DataInspectorExport.PageSize),
        "\"tree\":{" .. NodeToJson(node) .. "}"
      }, ",") .. "}"
    end)
    if not ok then
      return "{\"ok\":false,\"error\":\"" .. JsonEscape(tostring(err)) .. "\"}"
    end
    return json
  end
  if not DataCenter or DataCenter[sectionName] == nil then
    return "{\"ok\":false,\"error\":\"section not found: " .. JsonEscape(tostring(sectionName)) .. "\"}"
  end
  ResetRegistry("client")
  local json
  local ok, err = pcall(function()
    local node = BuildNode(tostring(sectionName), tostring(sectionName), DataCenter[sectionName], DataInspectorExport.DefaultDepth)
    json = "{" .. table.concat({
      "\"ok\":true",
      "\"source\":\"client\"",
      "\"pageSize\":" .. tostring(DataInspectorExport.PageSize),
      "\"tree\":{" .. NodeToJson(node) .. "}"
    }, ",") .. "}"
  end)
  if not ok then
    return "{\"ok\":false,\"error\":\"" .. JsonEscape(tostring(err)) .. "\"}"
  end
  return json
end

function DataInspectorExport.DeepSearchJson(keyword, limit)
  keyword = tostring(keyword or "")
  if "" == keyword then
    return "{\"ok\":false,\"error\":\"搜索关键字为空\"}"
  end
  if not DataCenter then
    return "{\"ok\":false,\"error\":\"DataCenter 尚未初始化\"}"
  end
  limit = tonumber(limit) or 300
  local needle = string.lower(keyword)
  local results = {}
  local visited = {}
  local scanned = 0
  local truncated = false
  
  local function Walk(value, path)
    if truncated or #results >= limit then
      return
    end
    if visited[value] then
      return
    end
    visited[value] = true
    local okKeys, keys, arrayLen = pcall(SortedKeys, value)
    if not okKeys then
      return
    end
    for _, k in ipairs(keys) do
      scanned = scanned + 1
      if scanned > DataInspectorExport.SearchNodeLimit then
        truncated = true
        return
      end
      local v = value[k]
      local isIdx = type(k) == "number" and k >= 1 and k <= arrayLen
      local childPath = ChildPath(path, k, isIdx)
      local keyHit = string.lower(tostring(k)):find(needle, 1, true) ~= nil
      if type(v) == "table" then
        if keyHit then
          results[#results + 1] = {
            path = childPath,
            text = tostring(k) .. " {table}"
          }
        end
        Walk(v, childPath)
        if truncated or #results >= limit then
          return
        end
      else
        local valStr = tostring(v)
        if keyHit or string.lower(valStr):find(needle, 1, true) then
          results[#results + 1] = {
            path = childPath,
            text = tostring(k) .. " = " .. valStr
          }
          if #results >= limit then
            truncated = true
            return
          end
        end
      end
    end
  end
  
  local ok, err = pcall(function()
    Walk(DataCenter, "ClientMemory.DataCenter")
    local battleSnap = DataInspectorExport.CollectBattleRuntimeSnapshot()
    if battleSnap then
      Walk(battleSnap, "ClientMemory.BattleRuntime")
    end
  end)
  if not ok then
    return "{\"ok\":false,\"error\":\"" .. JsonEscape(tostring(err)) .. "\"}"
  end
  local buf = {}
  for _, r in ipairs(results) do
    buf[#buf + 1] = "{" .. table.concat({
      "\"name\":\"" .. JsonEscape(r.path) .. "\"",
      "\"path\":\"" .. JsonEscape(r.path) .. "\"",
      "\"type\":\"search\"",
      "\"display\":\"" .. JsonEscape(r.path .. "   →   " .. r.text) .. "\"",
      "\"hint\":null",
      "\"leafValue\":\"" .. JsonEscape(r.text) .. "\"",
      "\"nodeId\":null",
      "\"childCount\":0",
      "\"children\":[]"
    }, ",") .. "}"
  end
  local title = "搜索 '" .. keyword .. "' 命中 " .. tostring(#results)
  if truncated then
    title = title .. "（已达上限，结果可能不全）"
  end
  local rootJson = "{" .. table.concat({
    "\"name\":\"SearchResult\"",
    "\"path\":\"SearchResult\"",
    "\"type\":\"table\"",
    "\"display\":\"" .. JsonEscape(title) .. "\"",
    "\"hint\":null",
    "\"leafValue\":null",
    "\"nodeId\":null",
    "\"childCount\":" .. tostring(#results),
    "\"children\":[" .. table.concat(buf, ",") .. "]"
  }, ",") .. "}"
  return "{\"ok\":true,\"source\":\"client_search\",\"tree\":" .. rootJson .. "}"
end

local serverMemory, serverBuf
local serverStatus = "idle"
local serverReceived = 0
local serverError
local serverTotal = 0

local function DecodeAccountBlob(b64)
  local lz4 = require("lz4")
  local msgpack = require("cmsgpack")
  local raw = _ejoysdk_crypt.base64decode(b64)
  if not raw or "" == raw then
    error("base64 解码失败")
  end
  local plain = lz4.decompress(raw)
  if not plain or "" == plain then
    error("lz4 解压失败")
  end
  local obj = msgpack.unpack(plain)
  if type(obj) ~= "table" then
    error("msgpack 解包结果不是 table: " .. type(obj))
  end
  return obj
end

local function OnAccountJsonChunk(accountData)
  if type(accountData) ~= "table" then
    return
  end
  serverBuf = (serverBuf or "") .. tostring(accountData.data or "")
  serverStatus = "receiving"
  serverReceived = #serverBuf
  if 1 ~= accountData.isFinish then
    return
  end
  local blob = serverBuf
  serverBuf = nil
  serverTotal = #blob
  local ok, result = pcall(DecodeAccountBlob, blob)
  if ok then
    serverMemory = result
    serverStatus = "ready"
    serverError = nil
  else
    serverMemory = nil
    serverStatus = "error"
    serverError = tostring(result)
  end
end

function DataInspectorExport.EnsureServerHook()
  if DataInspectorExport._serverHooked then
    return true
  end
  if type(ProtoBase) ~= "table" or not ProtoBase.RegisterDispatcher then
    return false, "ProtoBase 未就绪"
  end
  ProtoBase.RegisterDispatcher(DataInspectorExport, "Role", "OnSyncSaveAccountJson", OnAccountJsonChunk)
  DataInspectorExport._serverHooked = true
  return true
end

function DataInspectorExport.RequestServerMemoryJson()
  local hooked, hookErr = DataInspectorExport.EnsureServerHook()
  if not hooked then
    return "{\"ok\":false,\"error\":\"" .. JsonEscape(tostring(hookErr)) .. "\"}"
  end
  local gm = ProtoManager and ProtoManager.Instance and ProtoManager.Instance.GmRequest
  if not gm then
    return "{\"ok\":false,\"error\":\"ProtoManager.GmRequest 未就绪，请先登录进主界面\"}"
  end
  serverBuf = nil
  serverMemory = nil
  serverReceived = 0
  serverTotal = 0
  serverError = nil
  serverStatus = "requesting"
  local ok, err = pcall(function()
    gm:OnGmCommandBySend("output_account_data", {})
  end)
  if not ok then
    serverStatus = "error"
    serverError = tostring(err)
    return "{\"ok\":false,\"error\":\"" .. JsonEscape(tostring(err)) .. "\"}"
  end
  return "{\"ok\":true,\"status\":\"requesting\"}"
end

function DataInspectorExport.ServerMemoryStatusJson()
  local parts = {
    "\"ok\":true",
    "\"status\":\"" .. serverStatus .. "\"",
    "\"received\":" .. tostring(serverReceived),
    "\"total\":" .. tostring(serverTotal),
    "\"hooked\":" .. tostring(DataInspectorExport._serverHooked and true or false)
  }
  if serverError then
    parts[#parts + 1] = "\"error\":\"" .. JsonEscape(serverError) .. "\""
  end
  return "{" .. table.concat(parts, ",") .. "}"
end

function DataInspectorExport.BuildServerMemoryTreeJson()
  if "error" == serverStatus then
    return "{\"ok\":false,\"error\":\"" .. JsonEscape(tostring(serverError or "解包失败")) .. "\"}"
  end
  if type(serverMemory) ~= "table" then
    return "{\"ok\":false,\"error\":\"还没有服务端内存数据（当前状态: " .. serverStatus .. "），请先点「拉取服务端内存」\"}"
  end
  ResetRegistry("server")
  local json
  local ok, err = pcall(function()
    local root = BuildNode("ServerRole", "ServerRole", serverMemory, DataInspectorExport.DefaultDepth)
    json = "{" .. table.concat({
      "\"ok\":true",
      "\"source\":\"server_memory\"",
      "\"blobLen\":" .. tostring(serverTotal),
      "\"pageSize\":" .. tostring(DataInspectorExport.PageSize),
      "\"tree\":{" .. NodeToJson(root) .. "}"
    }, ",") .. "}"
  end)
  if not ok then
    return "{\"ok\":false,\"error\":\"" .. JsonEscape(tostring(err)) .. "\"}"
  end
  return json
end

function DataInspectorExport.DumpClientMemoryJson()
  if not DataCenter then
    return "{\"ok\":false,\"error\":\"DataCenter 尚未初始化，请登录进主界面后再 Dump\"}"
  end
  local ok, payload = pcall(function()
    do return SerializeValueJson, BuildClientMemoryRoot(), 64 end
    return SerializeValueJson, BuildClientMemoryRoot(), 64, {}
  end)
  if not ok then
    return "{\"ok\":false,\"error\":\"" .. JsonEscape(tostring(payload)) .. "\"}"
  end
  return "{\"ok\":true,\"source\":\"client_dump\",\"player\":" .. PlayerSummaryJson() .. ",\"payload\":" .. payload .. "}"
end

function DataInspectorExport.DumpServerMemoryJson()
  if "error" == serverStatus then
    return "{\"ok\":false,\"error\":\"" .. JsonEscape(tostring(serverError or "解包失败")) .. "\"}"
  end
  if type(serverMemory) ~= "table" then
    return "{\"ok\":false,\"error\":\"还没有服务端内存数据（当前状态: " .. serverStatus .. "）\"}"
  end
  local ok, payload = pcall(function()
    do return SerializeValueJson, serverMemory, 64 end
    return SerializeValueJson, serverMemory, 64, {}
  end)
  if not ok then
    return "{\"ok\":false,\"error\":\"" .. JsonEscape(tostring(payload)) .. "\"}"
  end
  return "{\"ok\":true,\"source\":\"server_memory_dump\",\"blobLen\":" .. tostring(serverTotal) .. ",\"payload\":" .. payload .. "}"
end

function DataInspectorExport._GuessDbName(serverId)
  if not serverId or "" == serverId then
    return nil
  end
  local key = string.lower(tostring(serverId))
  if "zcdev" == key or "z1cdev" == key then
    return "game_z1cdev"
  end
  if key:find("^global_") then
    return "game_z1_" .. key
  end
  if key:find("^z1_") then
    return "game_" .. key:sub(4)
  end
  return "game_" .. key
end

function DataInspectorExport._NormalizeServerFolder(serverId)
  if not serverId or "" == serverId then
    return nil
  end
  local key = string.lower(tostring(serverId))
  if "zcdev" == key or "z1cdev" == key then
    return "z1cdev"
  end
  if key:find("^z1_") then
    return key
  end
  if key:find("^global_") then
    return "z1_" .. key
  end
  return "z1_" .. key
end

function DataInspectorExport.BuildServerContextJson()
  local ctx = {}
  if DataCenter and DataCenter.playerData and DataCenter.playerData.DRole then
    local d = DataCenter.playerData.DRole
    ctx.uid = d.uid
    ctx.playerName = d.name
  end
  if DataCenter and DataCenter.loginData then
    ctx.serverId = DataCenter.loginData.serverId
    ctx.serverName = DataCenter.loginData.serverName
    ctx.loginAddress = DataCenter.loginData.loginAddress
    ctx.loginPort = DataCenter.loginData.loginPort
  end
  if LoginMgr and LoginMgr.Instance and LoginMgr.Instance.model then
    local m = LoginMgr.Instance.model
    if m.serverId then
      ctx.loginServerId = m.serverId
    end
    if m.GetServerNode then
      local node = m:GetServerNode()
      if node then
        ctx.serverNode = tostring(node)
      end
    end
    if m.GetServerName then
      local name = m:GetServerName()
      if name then
        ctx.serverNameDisplay = tostring(name)
      end
    end
    if m.gameServerNode then
      ctx.gameServerNode = tostring(m.gameServerNode)
    end
  end
  local folderKey = DataInspectorExport._NormalizeServerFolder(ctx.loginServerId or ctx.serverId)
  if folderKey then
    ctx.serverFolder = folderKey
    ctx.serverPath = folderKey .. "/server"
    ctx.dbName = DataInspectorExport._GuessDbName(ctx.loginServerId or ctx.serverId) or "game_" .. folderKey
  end
  local parts = {}
  parts[#parts + 1] = "\"ok\":true"
  parts[#parts + 1] = "\"source\":\"client_login\""
  for k, v in pairs(ctx) do
    if type(v) == "number" then
      parts[#parts + 1] = string.format("\"%s\":%s", k, tostring(v))
    else
      parts[#parts + 1] = string.format("\"%s\":\"%s\"", k, JsonEscape(tostring(v)))
    end
  end
  return "{" .. table.concat(parts, ",") .. "}"
end

return DataInspectorExport
