local this = {}
local _worldDifficultyCityTpl = L_GameTpl:getWorldDifficultyCityTpl()

function this:init()
  this.super.init(self)
  self.data = {
    itemDic = {}
  }
end

function this:state()
  return {}
end

function this:getInfoByMapId(mapId)
  for k, v in pairs(self.data.itemDic) do
    if v.mapId == mapId then
      return v
    end
  end
  return nil
end

function this:getMapsMinDifficultLevel(mapId)
  return _worldDifficultyCityTpl:getMapsMinDifficultLevel(mapId)
end

function this:printAllInfoData()
  for k, v in pairs(self.data.itemDic) do
    printf("map lv", "map_id:" .. tostring(v.mapId))
    for k2, v2 in pairs(v.reddotFinished) do
      printf("map lv", "reddot map lv" .. tostring(v2))
    end
  end
  return nil
end

function this:getNowLevel(mapId)
  local mapInfo = self:getInfoByMapId(mapId)
  if mapInfo and mapInfo.difficulty then
    return mapInfo.difficulty
  else
    return _worldDifficultyCityTpl:getMapsMinDifficultLevel(mapId)
  end
end

function this:getLastLevel()
  return self.lastLevel
end

function this:setLastLevel(level)
  self.lastLevel = level
end

function this:getNeedShowLevel(mapId)
  local mapInfo = self:getInfoByMapId(mapId)
  return mapInfo and mapInfo.needShowLevel or false
end

return this
