local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local CommonDefind = require("cs_share.common_define")
local LocalStorage = require("utils.localstorage")
local NOTICE_TYPE = CommonDefind.NOTICE_TYPE
local Json = require("utils.json")
local _tinsert = table.insert
local _tinsort = table.sort

function M:init_sys()
  Base.init_sys(self)
  self.v_notice_data_list = {}
  self.v_notice_data_list_cdn = {}
  self.v_local_read_data = {}
  self.v_not_read_system_notice = 0
  self.v_not_read_activity_notice = 0
  self:get_cdn_notices()
end

function M:count_read_num(num, type)
  if type == NOTICE_TYPE.ACTIVITY then
    self.v_not_read_activity_notice = self.v_not_read_activity_notice + num
  elseif type == NOTICE_TYPE.SYSTEM then
    self.v_not_read_system_notice = self.v_not_read_system_notice + num
  end
  MsgGame:mq_publish2(Const.MSG_ON_NOTICE_UPDATE_READ)
  local is_need_show_red = self:is_notice_main_red()
  if is_need_show_red and self.v_notice_main_red_state then
    is_need_show_red = false
  end
  if SDKType == Config.SDK_TYPE.HIVE_SDK then
    is_need_show_red = false
  end
  RedPointMgr:enable_redpoint(RedEnum.NOTICE, is_need_show_red)
end

function M:set_ignore_notice_main_red()
  self.v_ignore_notice_main_red = true
  RedPointMgr:enable_redpoint(RedEnum.NOTICE, false)
end

function M:get_is_no_notice()
  local activity_count = #self.v_notice_data_list[NOTICE_TYPE.ACTIVITY] + #self.v_notice_data_list_cdn[NOTICE_TYPE.ACTIVITY]
  local system_count = #self.v_notice_data_list[NOTICE_TYPE.SYSTEM] + #self.v_notice_data_list_cdn[NOTICE_TYPE.SYSTEM]
  return 0 == activity_count + system_count
end

local function _sort_func(a, b)
  if a.sort_id ~= b.sort_id then
    return a.sort_id < b.sort_id
  end
  return a.cdn_index < b.cdn_index
end

function M:get_cdn_notices()
  self.v_notice_data_list_cdn[NOTICE_TYPE.ACTIVITY] = {}
  self.v_notice_data_list_cdn[NOTICE_TYPE.SYSTEM] = {}
  local url = SDKManager:get_notice_url()
  CSHelper.RequestContent(url, function(content)
    if not content or "" == content then
      Log.Error("request.error：", url)
    else
      local data = Json.decode(content)
      if data and "" ~= data and #data > 0 then
        for index, notice_data in ipairs(data) do
          local ty, single_data = self:_bulid_single_notice_data_tb_cdn(index, notice_data)
          if single_data then
            _tinsert(self.v_notice_data_list_cdn[ty], single_data)
          end
        end
        _tinsort(self.v_notice_data_list_cdn[NOTICE_TYPE.ACTIVITY], _sort_func)
        _tinsort(self.v_notice_data_list_cdn[NOTICE_TYPE.SYSTEM], _sort_func)
      end
    end
  end)
end

function M:_build_notice_data_tb(type, data)
  self.v_player_uuid = PlayerMgr:get_player_uid()
  local temp_tb = {}
  if type == NOTICE_TYPE.ACTIVITY then
    self:refresh_local_read_data()
    for id, notice_data in pairs(self.notice_cfg) do
      if 1 == notice_data.Type then
        temp_tb[id] = self:_bulid_single_notice_data_tb(type, notice_data, true)
        if 0 == temp_tb[id].is_read then
          self:count_read_num(1, type)
        end
      end
    end
  elseif type == NOTICE_TYPE.SYSTEM then
    self:refresh_local_read_data()
    for id, notice_data in pairs(self.notice_cfg) do
      if 2 == notice_data.Type then
        temp_tb[id] = self:_bulid_single_notice_data_tb(type, notice_data, true)
        if 0 == temp_tb[id].is_read then
          self:count_read_num(1, type)
        end
      end
    end
    local notices = data.notices
    for uuid, notice_data in pairs(notices) do
      if notice_data.type == NOTICE_TYPE.SYSTEM then
        temp_tb[uuid] = self:_bulid_single_notice_data_tb(type, notice_data)
        if not notice_data.is_read then
          self:count_read_num(1, type)
        end
      end
    end
  end
  return temp_tb
end

function M:refresh_local_read_data()
  self.v_all_local_read_data = self:_load_all_local_read_data() or {}
  if self.v_all_local_read_data[self.v_player_uuid] ~= nil then
    self.v_local_read_data = self.v_all_local_read_data[self.v_player_uuid]
  end
  local local_read_length = UtilTable.hash_lenth(self.v_local_read_data)
  local cfg_read_length = UtilTable.hash_lenth(self.notice_cfg)
  if local_read_length > cfg_read_length then
    for id, _ in pairs(self.v_local_read_data) do
      if nil == self.notice_cfg[id] then
        self.v_local_read_data[id] = nil
      end
    end
  end
end

function M:_bulid_single_notice_data_tb(type, notice_data, is_config)
  if type == NOTICE_TYPE.ACTIVITY or is_config then
    if self.v_local_read_data[notice_data.Id] == nil or self.v_local_read_data[notice_data.Id] ~= nil and self:_notice_cfg_is_change(notice_data.Id) then
      local default_read_state = {is_read = 0}
      self.v_local_read_data[notice_data.Id] = default_read_state
    end
    local start_time, end_time
    if is_config then
      start_time = notice_data.BeginTime and Date.get_time_stamp_by_scheme_id(notice_data.BeginTime)
      end_time = notice_data.EndTime and Date.get_time_stamp_by_scheme_id(notice_data.EndTime)
    else
      start_time = notice_data.BeginTime
      end_time = notice_data.EndTime
    end
    local is_read = self.v_local_read_data[notice_data.Id].is_read
    if 0 == is_read and end_time < Date.server_time() then
      is_read = 1
      self.v_local_read_data[notice_data.Id].is_read = is_read
    end
    local tb = {
      type = type,
      title = notice_data.Title,
      content = notice_data.Content,
      id = notice_data.Id,
      month = tonumber(os.date("!%m", start_time)),
      day = tonumber(os.date("!%d", start_time)),
      start_time = start_time,
      end_time = end_time,
      jump_id = notice_data.JumpId,
      jump_image = notice_data.JumpImage,
      priority = notice_data.Priority,
      is_read = is_read,
      is_config = true
    }
    return tb
  elseif type == NOTICE_TYPE.SYSTEM then
    local start_time = notice_data.start_time
    local tb = {
      type = notice_data.type,
      title = notice_data.title,
      content = notice_data.content,
      uuid = notice_data.uuid,
      is_read = notice_data.is_read or false,
      is_delete = false,
      month = tonumber(os.date("!%m", start_time)),
      day = tonumber(os.date("!%d", start_time)),
      start_time = notice_data.start_time,
      end_time = notice_data.end_time,
      jump_image = notice_data.jump_image,
      jump_id = notice_data.jump_id
    }
    return tb
  else
    return nil
  end
end

function M:_bulid_single_notice_data_tb_cdn(index, notice_data)
  if notice_data.limit_platform and notice_data.limit_platform == Config.CommonDefine.TSI_NOTICE_CHANNEL_LIMIT_TYPE.CHANNEL_LIMIT and not SDKManager:check_sdk_notice_is_show(notice_data.channel_list) then
    return
  end
  if notice_data.game_paging == NOTICE_TYPE.ACTIVITY then
    local tb = {
      type = NOTICE_TYPE.ACTIVITY,
      title = notice_data.title,
      content = notice_data.content,
      is_read = 1,
      jump_image = notice_data.picture,
      priority = notice_data.sort_id or 1,
      cdn_index = index
    }
    return NOTICE_TYPE.ACTIVITY, tb
  elseif notice_data.game_paging == NOTICE_TYPE.SYSTEM then
    local tb = {
      type = NOTICE_TYPE.SYSTEM,
      title = notice_data.title,
      content = notice_data.content,
      is_read = 1,
      jump_image = notice_data.picture,
      priority = notice_data.sort_id,
      cdn_index = index
    }
    return NOTICE_TYPE.SYSTEM, tb
  else
    return nil
  end
end

function M:on_notice_list(data)
  self.notice_cfg = {}
  local temp_notice_cfg = ShareRes.create("notice.notice")
  for _, cfg_data in pairs(temp_notice_cfg) do
    self.notice_cfg[cfg_data.Id] = cfg_data
  end
  self.v_notice_data_list[NOTICE_TYPE.ACTIVITY] = self:_build_notice_data_tb(NOTICE_TYPE.ACTIVITY)
  self.v_notice_data_list[NOTICE_TYPE.SYSTEM] = self:_build_notice_data_tb(NOTICE_TYPE.SYSTEM, data)
end

function M:on_delete_notice(data)
  local uuid = data.uuid
  local system_notice_list = self.v_notice_data_list[NOTICE_TYPE.SYSTEM]
  if nil ~= system_notice_list[uuid] and not system_notice_list[uuid].is_read then
    self:count_read_num(-1, system_notice_list[uuid].type)
  end
  system_notice_list[uuid].is_delete = true
end

function M:on_update_notice(data)
  local notice = data.notice
  local uuid = notice.uuid
  local system_notice_list = self.v_notice_data_list[NOTICE_TYPE.SYSTEM]
  if nil == system_notice_list[uuid] then
    self:count_read_num(1, notice.type)
  elseif nil ~= system_notice_list[uuid] and system_notice_list[uuid].is_read then
    self:count_read_num(1, notice.type)
  end
  system_notice_list[uuid] = self:_bulid_single_notice_data_tb(NOTICE_TYPE.SYSTEM, notice)
end

function M:upgrade_notice_read(uuid, cb)
  Network:call("c2gs_notice_read", {uuid = uuid}, function(ok, resp)
    if ok then
      cb(resp)
      self:count_read_num(-1, NOTICE_TYPE.SYSTEM)
    end
  end)
end

function M:update_local_notice_read(id)
  self.v_local_read_data[id].is_read = 1
  local temp_notice_cfg = ShareRes.create("notice.notice")
  local config_type = NOTICE_TYPE.ACTIVITY
  for _, notice_cfg in pairs(temp_notice_cfg) do
    if notice_cfg.Id == id then
      config_type = notice_cfg.Type
      break
    end
  end
  self:count_read_num(-1, config_type)
end

function M:get_notice_data_list(type)
  return self.v_notice_data_list[type]
end

function M:get_notice_data_list_cdn(type)
  return self.v_notice_data_list_cdn[type]
end

function M:is_notice_main_red()
  local sum = self.v_not_read_activity_notice + self.v_not_read_system_notice
  return 0 ~= sum
end

function M:have_not_read_system_notice()
  return 0 ~= self.v_not_read_system_notice
end

function M:have_not_read_activity_notice()
  return 0 ~= self.v_not_read_activity_notice
end

function M:save_local_read_data()
  self.v_all_local_read_data[self.v_player_uuid] = self.v_local_read_data
  LocalStorage:save_table(Config.LOCAL_NOTICE_READ_KEY, self.v_all_local_read_data)
  LocalStorage:save_table(Config.LOCAL_NOTICE_CFG_KEY, self.notice_cfg)
end

function M:_load_all_local_read_data()
  return LocalStorage:load_table(Config.LOCAL_NOTICE_READ_KEY)
end

function M:_notice_cfg_is_change(id)
  local pre_notice_cfg = LocalStorage:load_table(Config.LOCAL_NOTICE_CFG_KEY)
  if nil == pre_notice_cfg then
    return false
  else
    local current_cfg_data = self.notice_cfg[id]
    local pre_cfg_data = pre_notice_cfg[id]
    if pre_cfg_data.Title ~= current_cfg_data.Title or pre_cfg_data.JumpImage ~= current_cfg_data.JumpImage then
      return true
    else
      return false
    end
  end
end

return M
