local this = {}

local function _existSelf(v)
  return v.player_id == L_PlayerStore:getPlayerId()
end

function this.syncHomeDatas(data)
end

function this.syncAllHomeData(data, init)
end

local WMC = L_Const.WorldMapCmdType
local Cmd2Func = {
  [WMC.WMCT_PLAYER] = function(data)
    this.syncPlayer(data.map_info.players)
  end,
  [WMC.WMCT_ACED] = function(data)
    this.syncPlayer(data.map_info.players, nil, true)
  end,
  [WMC.WMCT_QUIT] = function(data)
  end,
  [WMC.WMCT_BUILD_LOCATE] = this.syncHomeDatas,
  [WMC.WMCT_BUILD_CREATE] = this.syncHomeDatas,
  [WMC.WMCT_BUILD_CREATE_FINISH] = this.syncHomeDatas,
  [WMC.WMCT_BUILD_UNLOCATE] = this.syncHomeDatas,
  [WMC.WMCT_HOME_LEVEL] = this.syncHomeDatas,
  [WMC.WMCT_PRODUCT_START] = this.syncHomeDatas,
  [WMC.WMCT_PRODUCT_FINISH] = this.syncHomeDatas,
  [WMC.WMCT_PRODUCT_CANCEL] = this.syncHomeDatas,
  [WMC.WMCT_HOUSE_REFRESH] = this.syncHomeDatas,
  [WMC.WMCT_FIELD_OPEN] = this.syncHomeDatas,
  [WMC.WMCT_FIELD_CLOSE] = this.syncHomeDatas,
  [WMC.WMCT_FIELD_PLANT] = this.syncHomeDatas,
  [WMC.WMCT_FIELD_WATER] = this.syncHomeDatas,
  [WMC.WMCT_FIELD_HARVEST] = this.syncHomeDatas,
  [WMC.WMCT_FIELD_UNPLANT] = this.syncHomeDatas,
  [WMC.WMCT_HATCH_REFRESH] = this.syncHomeDatas,
  [WMC.WMCT_HOME_INIT] = function(data)
    this.syncAllHomeData(data, true)
  end,
  [WMC.WMCT_HOME_REFRESH] = function(data)
    this.syncAllHomeData(data)
  end,
  [WMC.WMCT_INTERACT] = function(data)
    this.refreshCollectionItem(data)
  end
}

function this.socket_9103(data, errorCode)
  printf("lua", "9103处理中" .. tostring(data.cmd))
  if Cmd2Func[data.cmd] then
    Cmd2Func[data.cmd](data, errorCode)
  end
  if data.cmd == L_Const.WorldMapCmdType.WMCT_ENTER then
    local sPlayer = data.map_info.players
    local needSwitchScene = table.find(sPlayer, _existSelf) ~= nil
    this.syncPlayer(sPlayer, not needSwitchScene)
  end
  L_HomeStore:syncHomeMapDatas()
end

function this.refreshCollectionItem(data)
  if not (data and data.map_info) or not data.map_info.objs then
    return
  end
  local mapStore = C_MapManager:GetMapStore()
  if not mapStore then
    return
  end
  for _, obj in pairs(data.map_info.objs) do
    local worldMapId = obj.obj_id
    mapStore:refreshCollectionItem(worldMapId)
  end
end

function this.syncPlayer(sPlayer, isSend, stopTransfer)
  local playerId = L_PlayerStore:getPlayerId()
  for _, v in ipairs(sPlayer) do
    local isSelf = v.player_id == playerId
    if isSelf then
      L_PlayerStore:rsp_syncPlayerMapInfo(v, isSend, stopTransfer)
    end
  end
end

function this.syncPlayerMove(sPlayer)
  for _, v in ipairs(sPlayer) do
    local isSelf = v.player_id == L_PlayerStore:getPlayerId()
    if isSelf then
      L_PlayerStore:rsp_syncPlayerMapInfo(v)
    end
  end
end

function this.socket_9105(data, errorCode)
  if table.isEmpty(data) then
    return
  end
  L_SceneStore:rsp_syncMapPoint(data)
end

function this.socket_9133(data, errorCode)
  if errorCode == L_Const.errorCode.ErrCodeSucc then
  end
end

function this.socket_9406(data, errorCode)
  if errorCode == L_Const.errorCode.ErrCodeSucc then
    this._onGetReward(data.rewards, data.pos)
  end
end

function this._onGetReward(rewards, pos, dropIds, interactType, toolType)
  if rewards == nil then
    return
  end
  if rewards.rewards ~= nil then
    L_ProfilerUtil.BeginSample("lua _onGetReward pageRewardDataList")
    local pageRewardDataList = {}
    for i = #rewards.rewards, 1, -1 do
      local rewardUnit = rewards.rewards[i]
      if rewardUnit.itemtype == L_Const.resType.petEgg or rewardUnit.itemtype == L_Const.resType.pet then
        table.insert(pageRewardDataList, rewardUnit)
        table.remove(rewards.rewards)
      end
    end
    L_ProfilerUtil.EndSample()
    L_ProfilerUtil.BeginSample("lua _onGetReward ShowReward")
    local newRewards = require("ui.manager.reward.rewardData").new()
    newRewards.src = rewards.src
    newRewards:constructList(pageRewardDataList)
    L_RewardManager:ShowReward(newRewards, nil, interactType)
    L_ProfilerUtil.EndSample()
  else
    print("奖励数据为空, rewards.rewards == nil")
  end
end

function this.socket_9137(data, errorCode)
  if errorCode == L_Const.errorCode.ErrCodeSucc and data.u32s ~= nil then
    local mapStore = C_MapManager:GetMapStore()
    local _worldSpawnerTpl = L_GameTpl:getWorldSpawnerTpl()
    local _worldMapTpl = L_GameTpl:getWorldMapTpl()
    for k, v in pairs(data.u32s) do
      if mapStore then
        mapStore:setObjDiscovered(AzurWorldInstance.CurWorldId, v)
      end
      local tpl = _worldMapTpl:getTplById(AzurWorldInstance.CurWorldId, v)
      if tpl then
        local spawnerId = _worldMapTpl:getSpawnerId(tpl)
        local spawnerTpl = _worldSpawnerTpl:getTplById(spawnerId)
        if spawnerTpl then
          local objectType = _worldSpawnerTpl:getObjectType(spawnerTpl)
          local banTypes = L_GameTpl:getGameConstTpl():getData("WORLD_FIRST_DISCOVERED_NOTIPS", L_Const.GameTplType.list_int)
          for _, banType in ipairs(banTypes) do
            if banType == objectType then
              return
            end
          end
          local duration = 0
          if objectType == L_Const.WorldObjectType.Collection then
            duration = L_GameTpl:getGameConstTpl():getData("HOME_COLLECTION_BUILDING_TIP_TIME", L_Const.GameTplType.int)
          end
          local content = L_WordsTpl:getValue("notice_world_first_discovered", {
            [0] = _worldSpawnerTpl:getName(spawnerTpl)
          })
          L_FlyMsgManager:showNormalMsg(content, duration)
        end
      end
    end
  end
end

return this
