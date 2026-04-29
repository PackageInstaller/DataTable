_class("MedalModule", GameModule)
MedalModule = MedalModule

function MedalModule:Constructor()
  self.client_medal_info = {}
  self.client_medal_board_info = {}
  self.placement_info = {}
end

function MedalModule:Init()
  self.caller:RegisterPushHandler(CEventPushUpdateMedal, self.HandleMedalUpdate, self)
end

function MedalModule:ReqSaveMedal(TT, placement_info)
  if GameSingle then
    return self:GameSingleReqSaveMedal(placement_info)
  end
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplySaveMedalBoardReq)
  request.req_medal_board_info = placement_info
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(reply.res)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.n_ret)
  if reply.msg.n_ret == MedalErrorType.E_MEDAL_ERROR_TYPE_SUCCESS then
    self.placement_info = placement_info
    GameGlobal.EventDispatcher():Dispatch(GameEventType.BoardMedalUpdate)
  end
  return res
end

function MedalModule:GameSingleReqSaveMedal(placement_info)
  self.placement_info = placement_info
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BoardMedalUpdate)
  return self:GameSingleSavePlacementInfo(placement_info)
end

function MedalModule:GameSingleSavePlacementInfo(placement_info)
  local newMap = {}
  newMap.board_back_id = placement_info.board_back_id
  newMap.medal_on_board = self:NumberTableToStringTable(placement_info.medal_on_board)
  local jsonStr = cjson.encode(newMap)
  local saveKey = "placement_info"
  Log.debug("set placement_info jsonStr=", jsonStr)
  PlayerPrefsSetPersonString(saveKey, jsonStr)
  return EmptyRes
end

function MedalModule:NumberTableToStringTable(t)
  local t2 = {}
  for i, v in pairs(t) do
    t2[tostring(i)] = v
  end
  return t2
end

function MedalModule:StringTableToNumberTable(t)
  local t2 = {}
  for i, v in pairs(t) do
    t2[tonumber(i)] = v
  end
  return t2
end

function MedalModule:GameSingleGetPlacementInfo()
  local saveKey = "placement_info"
  local jsonStr = PlayerPrefsGetPersonString(saveKey, nil)
  Log.debug("get placement_info jsonStr=", jsonStr)
  if jsonStr ~= nil and jsonStr ~= "" then
    local info = cjson.decode(jsonStr)
    if info ~= nil then
      info.medal_on_board = self:StringTableToNumberTable(info.medal_on_board)
      self.placement_info = info
    end
  end
end

function MedalModule:GetMedalVec()
  return self.client_medal_info
end

function MedalModule:GetMedalBoardVec()
  return self.client_medal_board_info
end

function MedalModule:GetPlacementInfo()
  return self.placement_info
end

function MedalModule:HandleMedalUpdate(msg)
  for _, medal in ipairs(msg.medal_list) do
    if medal.medal_type == ItemSubType.ItemSubType_Medal then
      local unLockTime = self:FilterMedalUnLockTime(medal.medal_id)
      if unLockTime then
        self.client_medal_info[medal.medal_id] = medal
        if medal.status == RewardStatus.E_MEDAL_REWARD_RECVED then
          GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestMedalUpdate, medal.medal_id)
        end
      end
    else
      local unLockTime = self:FilterMedalBgUnLockTime(medal.medal_id)
      if unLockTime then
        self.client_medal_board_info[medal.medal_id] = medal
      end
    end
  end
end

function MedalModule:FilterMedalUnLockTime(medalid)
  if GameSingle then
    return true
  end
  local cfg_medal = Cfg.cfg_item_medal[medalid]
  if cfg_medal then
    local unLockTime = cfg_medal.BeginCountersTime
    local type = cfg_medal.TimeTransform
    if unLockTime then
      local timeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
      if type and type == 0 then
        timeType = Enum_DateTimeZoneType.E_ZoneType_GMT
      end
      local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
      local comTime = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(unLockTime, timeType)
      if svrTime < comTime then
        return false
      end
    end
  end
  return true
end

function MedalModule:FilterMedalBgUnLockTime(medalid)
  if GameSingle then
    return true
  end
  local cfg_board = Cfg.cfg_item_medal_board[medalid]
  if cfg_board then
    local unLockTime = cfg_board.BeginCountersTime
    local type = cfg_board.TimeTransform
    if unLockTime then
      local timeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
      if type and type == 0 then
        timeType = Enum_DateTimeZoneType.E_ZoneType_GMT
      end
      local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
      local comTime = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(unLockTime, timeType)
      if svrTime < comTime then
        return false
      end
    end
  end
  return true
end

function MedalModule:SetAllMedalData(all_medal_data)
  if GameSingle then
    all_medal_data = self:GameSingleSetAllMedalData()
  end
  if all_medal_data == nil then
    return
  end
  self.placement_info = all_medal_data.medal_board
  if GameSingle then
    self:GameSingleGetPlacementInfo()
  end
  local medal_data = all_medal_data.data
  local itemModule = GameGlobal.GetModule(ItemModule)
  for key, value in pairs(medal_data) do
    value.status = RewardStatus.E_MEDAL_REWARD_RECVED
    value.cur_progress = 0
    value.total_progress = 0
    value.condition_type = 0
    itemModule:GameSingleAddItem(value.medal_id)
    if value.medal_type == ItemSubType.ItemSubType_Medal then
      local unLockTime = self:FilterMedalUnLockTime(value.medal_id)
      if unLockTime then
        self.client_medal_info[value.medal_id] = value
      end
    else
      local unLockTime = self:FilterMedalBgUnLockTime(value.medal_id)
      if unLockTime then
        self.client_medal_board_info[value.medal_id] = value
      end
    end
  end
end

function MedalModule:GameSingleSetAllMedalData()
  local jsonStr = "{\"data\":[{\"condition_type\":108,\"medal_id\":6000001,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":53000,\"total_progress\":10000000,\"status\":1},{\"condition_type\":108,\"medal_id\":6000002,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":53000,\"total_progress\":100000000,\"status\":1},{\"condition_type\":1,\"medal_id\":6000101,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":1,\"total_progress\":10,\"status\":1},{\"condition_type\":1,\"medal_id\":6000102,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":1,\"total_progress\":30,\"status\":1},{\"condition_type\":1,\"medal_id\":6000103,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":1,\"total_progress\":50,\"status\":1},{\"condition_type\":1,\"medal_id\":6000104,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":1,\"total_progress\":80,\"status\":1},{\"condition_type\":800,\"medal_id\":6000201,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":1,\"total_progress\":100,\"status\":1},{\"condition_type\":800,\"medal_id\":6000202,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":1,\"total_progress\":365,\"status\":1},{\"condition_type\":300,\"medal_id\":6000301,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":1,\"total_progress\":30,\"status\":1},{\"condition_type\":300,\"medal_id\":6000302,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":1,\"total_progress\":50,\"status\":1},{\"condition_type\":300,\"medal_id\":6000303,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":1,\"total_progress\":100,\"status\":1},{\"condition_type\":300,\"medal_id\":6000401,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":5,\"status\":1},{\"condition_type\":300,\"medal_id\":6000402,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":20,\"status\":1},{\"condition_type\":300,\"medal_id\":6000403,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":50,\"status\":1},{\"condition_type\":302,\"medal_id\":6000501,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":5,\"status\":1},{\"condition_type\":302,\"medal_id\":6000502,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":20,\"status\":1},{\"condition_type\":302,\"medal_id\":6000503,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":50,\"status\":1},{\"condition_type\":0,\"medal_id\":6000601,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000602,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000603,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000604,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000605,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000606,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000607,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000608,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000609,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000610,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000611,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000612,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000613,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000614,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000615,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000616,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000617,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000618,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000619,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000620,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6000621,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":9,\"medal_id\":6000701,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":4,\"status\":1},{\"condition_type\":9,\"medal_id\":6000702,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":4,\"status\":1},{\"condition_type\":9,\"medal_id\":6000703,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":4,\"status\":1},{\"condition_type\":9,\"medal_id\":6000704,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":4,\"status\":1},{\"condition_type\":9,\"medal_id\":6000705,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":4,\"status\":1},{\"condition_type\":15,\"medal_id\":6000706,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":4,\"status\":1},{\"condition_type\":6,\"medal_id\":6000801,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":6,\"medal_id\":6000802,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":6,\"medal_id\":6000803,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":6,\"medal_id\":6000804,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":600,\"medal_id\":6000901,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":600,\"medal_id\":6000902,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":10,\"status\":1},{\"condition_type\":600,\"medal_id\":6000903,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":20,\"status\":1},{\"condition_type\":1303,\"medal_id\":6001001,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":1303,\"medal_id\":6001002,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":1303,\"medal_id\":6001003,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":1303,\"medal_id\":6001004,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":1303,\"medal_id\":6001005,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":1303,\"medal_id\":6001006,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":1303,\"medal_id\":6001007,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":1303,\"medal_id\":6001008,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":1303,\"medal_id\":6001009,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":1303,\"medal_id\":6001010,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":1303,\"medal_id\":6001011,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":1303,\"medal_id\":6001012,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":515,\"medal_id\":6001101,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":515,\"medal_id\":6001102,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":5,\"status\":1},{\"condition_type\":515,\"medal_id\":6001103,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":10,\"status\":1},{\"condition_type\":2013,\"medal_id\":6001201,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":20,\"status\":1},{\"condition_type\":2013,\"medal_id\":6001202,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":50,\"status\":1},{\"condition_type\":2008,\"medal_id\":6001203,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":20,\"status\":1},{\"condition_type\":2008,\"medal_id\":6001204,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":100,\"status\":1},{\"condition_type\":2024,\"medal_id\":6001205,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":30,\"status\":1},{\"condition_type\":2024,\"medal_id\":6001206,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":60,\"status\":1},{\"condition_type\":323,\"medal_id\":6001301,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":323,\"medal_id\":6001302,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":4,\"status\":1},{\"condition_type\":0,\"medal_id\":6001400,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001401,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001402,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001403,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001404,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001405,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001406,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001407,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001408,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001409,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001410,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001500,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001507,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001510,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001511,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001512,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001515,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6001516,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001517,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6001520,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6001521,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001524,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001525,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001526,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001529,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001530,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6001531,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002002,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002003,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002004,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002006,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002011,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002012,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002013,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002014,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002015,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002016,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002017,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002019,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002021,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6002022,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":501,\"medal_id\":6030101,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":501,\"medal_id\":6030102,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":9,\"status\":1},{\"condition_type\":5003,\"medal_id\":6030103,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":0,\"medal_id\":6030104,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030105,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030106,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030107,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030108,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030109,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030110,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030111,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030112,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030113,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030114,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030115,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030116,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030117,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030118,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030119,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030120,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030121,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030122,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030123,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6030124,\"medal_type\":26,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6100001,\"medal_type\":27,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6100001,\"medal_type\":27,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":0,\"medal_id\":6100002,\"medal_type\":27,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":3},{\"condition_type\":522,\"medal_id\":6100003,\"medal_type\":27,\"_className\":\"client_medal\",\"cur_progress\":24,\"total_progress\":30,\"status\":1},{\"condition_type\":522,\"medal_id\":6100004,\"medal_type\":27,\"_className\":\"client_medal\",\"cur_progress\":24,\"total_progress\":50,\"status\":1},{\"condition_type\":5003,\"medal_id\":6130101,\"medal_type\":27,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":5003,\"medal_id\":6130102,\"medal_type\":27,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":1,\"status\":1},{\"condition_type\":0,\"medal_id\":6130103,\"medal_type\":27,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6130104,\"medal_type\":27,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6130105,\"medal_type\":27,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6130106,\"medal_type\":27,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6130107,\"medal_type\":27,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1},{\"condition_type\":0,\"medal_id\":6130108,\"medal_type\":27,\"_className\":\"client_medal\",\"cur_progress\":0,\"total_progress\":0,\"status\":1}],\"medal_board\":{\"board_back_id\":6100001,\"medal_on_board\":{},\"_className\":\"medal_placement_info\"},\"_className\":\"all_medal_data\"}"
  local info = cjson.decode(jsonStr)
  return info
end

function MedalModule:GetN22MedalEditData()
  if not self.n22MedalEditData then
    self.n22MedalEditData = N22MedalEditData:New()
  end
  return self.n22MedalEditData
end
