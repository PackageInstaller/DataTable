local this = class("gameEventsPartygameTpl")

local function splitPipeList(str)
  local result = {}
  if not str then
    return result
  end
  if type(str) == "table" then
    for _, val in ipairs(str) do
      local num = tonumber(val)
      if num then
        table.insert(result, num)
      end
    end
    return result
  end
  if type(str) == "number" then
    return {str}
  end
  if type(str) ~= "string" then
    return result
  end
  for val in string.gmatch(str, "[^|]+") do
    local num = tonumber(val)
    if num then
      table.insert(result, num)
    end
  end
  return result
end

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return tpl.name
end

function this:getType(tpl)
  return tpl.partytype
end

function this:getDungeonId(tpl)
  return tpl.dungeonid
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.description)
end

function this:getSkillList(tpl)
  return splitPipeList(tpl.skilllist)
end

function this:getSkillChanceList(tpl)
  return splitPipeList(tpl.skillchancelist)
end

function this:getMatchMinMember(tpl)
  local limitList = splitPipeList(tpl.matchmemberlimit)
  return limitList[1]
end

function this:getMatchMaxMember(tpl)
  local limitList = splitPipeList(tpl.matchmemberlimit)
  return limitList[2]
end

function this:getMatchExtraTime(tpl)
  return tpl.matchextratime
end

function this:getMatchMaxTime(tpl)
  return tpl.matchmaxtime
end

function this:getLoadingTime(tpl)
  return tpl.loadingtime
end

function this:getLoadingExtraTime(tpl)
  return tpl.loadingextratime
end

function this:getRoundTime(tpl)
  return tpl.roundtime
end

function this:getGameParam(tpl)
  return splitPipeList(tpl.gameparam or tpl.gamepar)
end

function this:getRankScore(tpl)
  return splitPipeList(tpl.rankscore)
end

function this:getTimeScore(tpl)
  return splitPipeList(tpl.timescore)
end

function this:getRankCoin(tpl)
  return splitPipeList(tpl.rankcoin)
end

function this:getTimeCoin(tpl)
  return splitPipeList(tpl.timecoin)
end

function this:getOpenPeriod(tpl)
  return splitPipeList(tpl.openperiod)
end

return this
