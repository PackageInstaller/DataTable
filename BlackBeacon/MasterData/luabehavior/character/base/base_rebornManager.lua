local rebornChances = {}
rebornChances.__index = rebornChances

function rebornChances.new(base)
  local chances = setmetatable({}, base)
  chances.list_of_all_prio = {}
  chances.num = 0
  chances.maxPrio = 0
  return chances
end

function rebornChances.add(chances, magicId, prio, source, getLevel)
  local list_of_all_prio = chances.list_of_all_prio
  prio = prio or 0
  chances.maxPrio = math.max(chances.maxPrio, prio)
  local list = list_of_all_prio[prio]
  if not list then
    list = {}
    list_of_all_prio[prio] = list
  end
  local info = {
    magicId = magicId,
    source = source,
    getLevel = getLevel
  }
  table.insert(list, info)
  chances.num = chances.num + 1
  return info
end

function rebornChances.find(chances, magicId, prio, source, getLevel)
  local list_of_all_prio = chances.list_of_all_prio
  prio = prio or 0
  local list = list_of_all_prio[prio]
  if not list then
    return
  end
  for _, info in pairs(list) do
    if info.magicId == magicId and info.source == source and info.getLevel == getLevel then
      return info
    end
  end
end

function rebornChances.consume(chances, role)
  if 0 == chances.num then
    return
  end
  local list_of_all_prio = chances.list_of_all_prio
  local maxPrio = chances.maxPrio
  local validInfo
  for i = maxPrio, 0, -1 do
    local list = list_of_all_prio[i]
    if not list then
    else
      local info = table.remove(list, 1)
      if not info then
      else
        validInfo = info
        break
      end
    end
  end
  if validInfo then
    local source = validInfo.source
    local target = role.npc
    local getLevel = validInfo.getLevel
    cast_magic(target, target, validInfo.magicId, getLevel and getLevel(source, role))
    chances.num = chances.num - 1
    return validInfo
  end
end

function rebornChances.toString(chances)
  if 0 == chances.num then
    return "无\n"
  end
  local str = "[ "
  str = str .. "总次数: " .. tostring(chances.num) .. " || "
  str = str .. "历史最高优先级: " .. tostring(chances.maxPrio) .. " ]\n"
  local totList = chances.list_of_all_prio
  for prio = chances.maxPrio, 0, -1 do
    local list = totList[prio]
    if UtilTable.is_empty(list) then
    else
      str = str .. "优先级 " .. tostring(prio) .. ":\n"
      for _, info in ipairs(list) do
        str = str .. chances.infoToString(info) .. "\n"
      end
    end
  end
  return str
end

function rebornChances.infoToString(info)
  local str = "[ magicId: " .. tostring(info.magicId)
  local source = info.source
  if source then
    local file = source.file_id
    local constructor = source._init or source.new
    if file then
      str = str .. " || source: " .. file
    elseif constructor then
      str = str .. " || source: " .. debug.getinfo(constructor, "S").short_src
    else
      str = str .. " || source: " .. tostring(source.id)
    end
  end
  local getLevel = info.getLevel
  if getLevel then
    local funcInfo = debug.getinfo(getLevel, "S")
    str = str .. " || getLevel: " .. funcInfo.short_src .. "." .. funcInfo.linedefined
  end
  str = str .. " ]"
  return str
end

local rebornMgr = {}
rebornMgr.__index = rebornMgr
rebornMgr.tool = import("common.role_tool")
rebornMgr.debugSwitch = require("common.debug_config").role.rebornChance
rebornMgr.sharedChances = rebornChances:new()

function rebornMgr.new(base, role)
  local mgr = setmetatable({}, base)
  mgr.base = base
  mgr.role = role
  mgr.chances = rebornChances:new()
  return mgr
end

function rebornMgr.add_shared_chance(mgr, magicId, prio, source, getLevel, allowRepeat)
  local chances = mgr.sharedChances
  prio = prio or 0
  source = source or mgr.role
  if not allowRepeat and chances:find(magicId, prio, source, getLevel) then
    return
  end
  local info = chances:add(magicId, prio, source, getLevel)
  if mgr.debugSwitch then
    local str = "团队共享复活机会新增条目：" .. chances.infoToString(info) .. "\n"
    str = str .. mgr:toString()
    Log.Error(str, "\n", debug.traceback())
  end
end

function rebornMgr.consume_shared_chance(mgr)
  local info = mgr.sharedChances:consume(mgr.role)
  if not info then
    return false
  end
  if mgr.debugSwitch then
    local chances = mgr.sharedChances
    local str = "团队共享复活机会消耗条目：" .. chances.infoToString(info) .. "\n"
    str = str .. mgr:toString()
    Log.Error(str, "\n", debug.traceback())
  end
  return info
end

function rebornMgr.add_exclusive_chance(mgr, magicId, prio, source, getLevel, allowRepeat)
  local chances = mgr.chances
  source = source or mgr.role
  prio = prio or 0
  if not allowRepeat and chances:find(magicId, prio, source, getLevel) then
    return
  end
  local info = chances:add(magicId, prio, source, getLevel)
  if mgr.debugSwitch then
    local role = mgr.role
    local str = role.npc:get_hero_name() .. "独占复活机会新增条目：" .. chances.infoToString(info) .. "\n"
    str = str .. mgr:toString()
    Log.Error(str, "\n", debug.traceback())
  end
end

function rebornMgr.consume_exclusive_chance(mgr)
  local info = mgr.chances:consume(mgr.role)
  if not info then
    return false
  end
  if mgr.debugSwitch then
    local role = mgr.role
    local chances = mgr.chances
    local str = role.npc:get_hero_name() .. "独占复活机会消耗条目：" .. chances.infoToString(info) .. "\n"
    str = str .. mgr:toString()
    Log.Error(str, "\n", debug.traceback())
  end
  return info
end

function rebornMgr.toString(mgr)
  local str = ""
  str = str .. "团队共享复活机会：" .. mgr.sharedChances:toString()
  local team = mgr.tool.team.role
  for _, role in pairs(team) do
    local _mgr = role.rebornMgr
    if not _mgr then
    else
      str = str .. "\n" .. _mgr.role.npc:get_hero_name() .. "独占复活机会：" .. _mgr.chances:toString()
    end
  end
  return str
end

function rebornMgr.consume(mgr)
  if mgr:consume_exclusive_chance() then
    return true
  end
  if mgr:consume_shared_chance() then
    return true
  end
  return false
end

return rebornMgr
