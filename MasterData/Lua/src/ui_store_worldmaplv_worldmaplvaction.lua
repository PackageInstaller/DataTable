local this = {}
local _worldDifficultyCityTpl = L_GameTpl:getWorldDifficultyCityTpl()

function this:req_worldMapLevel(mapid, level, callback)
  local data = {map_id = mapid, difficulty = level}
  L_Net:sendMessage(MsgGenCode.CSProtoWorldDifficultySwitch, data, function(rspData, errorCode)
    if callback ~= nil then
      callback(rspData, errorCode)
    end
  end)
end

function this:req_worldMapReddot(mapid, level, callback)
  local data = {
    u32s = {
      mapid,
      level,
      1
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoWorldDifficultyRedPointSet, data, function(rspData, errorCode)
    if callback ~= nil then
      callback(rspData, errorCode)
    end
  end)
end

function this:rsp_syncWorldMapLevel(data)
  if data.send_type == 0 then
    self.data = {}
  end
  local needRefreshReddot = false
  if data == nil or data.infos == nil then
    return
  end
  for k, v in pairs(data.infos) do
    local mapId = v.map_id
    local item = self:getInfoByMapId(v.map_id)
    local minLevel = _worldDifficultyCityTpl:getMapsMinDifficultLevel(mapId) or 1
    local lvBef = L_CommonUtil.getLocalValue("mapWorldLv" .. tostring(mapId)) or minLevel
    if item == nil then
      item = require(L_R.store .. "worldMapLv.worldMapLvItem").new()
      item.mapId = v.map_id
      item.difficulty = v.difficulty
      item.needShowLevel = lvBef ~= v.difficulty
      item.reddotFinished = {}
      if v.redpoints_info ~= nil then
        for k, v2 in pairs(v.redpoints_info) do
          if not table.containsValue(item.reddotFinished, v2.difficulty) then
            table.insert(item.reddotFinished, v2.difficulty)
            needRefreshReddot = true
          end
        end
      end
      table.insert(self.data.itemDic, item)
    else
      item.mapId = v.map_id
      item.difficulty = v.difficulty
      item.needShowLevel = lvBef ~= v.difficulty
      if v.redpoints_info ~= nil then
        for k, v2 in pairs(v.redpoints_info) do
          if not table.containsValue(item.reddotFinished, v2.difficulty) then
            table.insert(item.reddotFinished, v2.difficulty)
            needRefreshReddot = true
          end
        end
      end
    end
    C_GlobalParamManager.SetMapIdWorldLvDic(v.map_id, v.difficulty)
  end
  if needRefreshReddot then
    self:call(self.event.refreshDeddot)
  end
end

return this
