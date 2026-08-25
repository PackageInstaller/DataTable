local E = require("ejoysdk_lua.ejoysdk")
local launcher = require("ejoysdk_lua.ejoysdk_launcher")
local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local EAM = require("ejoysdk_lua.agreement.ejoysdk_agreement")
local LUTIL = require("ejoysdk_lua.native.utils.Utils")
local ECS = require("ejoysdk_lua.custom.ejoysdk_custom_service")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local ticket
local TAG = EM.MODULE.NATIVE .. "core.login"

local function get_ticket(cb)
  if ticket and string.len(ticket) > 0 then
    cb(ticket)
  else
    launcher.server_list_ticket(function(succ, ...)
      if succ then
        local hash, _time = ...
        ticket = hash
        cb(ticket)
      else
        cb(nil)
      end
    end)
  end
end

function M.get_server_list(cb)
  get_ticket(function(ret_ticket)
    if ret_ticket and string.len(ret_ticket) > 0 then
      launcher.server_list_detail(ret_ticket, function(succ, server_list)
        if succ then
          LUTIL.notify(cb, true, "获取服务器列表成功", server_list)
        else
          LUTIL.notify(cb, false, "获取列表失败")
        end
      end)
    else
      LUTIL.notify(cb, false, "ticket获取失败")
    end
  end)
end

function M.get_anns(cb)
  get_ticket(function(ret_ticket)
    if ret_ticket and string.len(ret_ticket) > 0 then
      launcher.ticket_detail("login", nil, nil, function(succ, anns)
        if succ then
          LUTIL.notify(cb, true, "获取公告成功", anns)
        else
          LUTIL.notify(cb, false, "获取公告失败")
        end
      end)
    else
      LUTIL.notify(cb, false, "ticket获取失败")
    end
  end)
end

function M.login(params)
  params = params or {}
  local vendor_name = params.login_vendor
  gangplank.login(vendor_name)
end

function M.enter_game(params)
  params = params or {}
  local login_server = params.login_server
  gangplank.enter_game(login_server)
end

function M.open_user_center(params)
  params = params or {}
  local vendor_name = params.vendor
  gangplank.open_user_center(vendor_name)
  do return LUTIL.notify_resp end
  return LUTIL.notify_resp, true
end

function M.open_custom_service(params, cb)
  params = params or {}
  ECS.show_custom_service(params, function(succ, ...)
    if succ then
      LUTIL.notify(cb, true, "成功")
    else
      local code, msg = ...
      LUTIL.notify(cb, code, msg)
    end
  end)
end

function M.show_userinfo_completion(params, cb)
  if type(params) == "function" then
    cb = params
    params = {}
  end
  params = params or {}
  gangplank.open_userinfo_completion(params.vendor, function(succ)
    LUTIL.notify(cb, succ, "")
  end)
end

function M.set_player_info(player_info)
  gangplank.set_player_info(player_info, "enterGame")
end

function M.logout()
  gangplank.logout()
end

function M.thirdparty_player_login(player_info, cb)
  local token_adapter = require("ejoysdk_lua.ejoysdk_token_adapter")
  token_adapter.setup_player_token_type(token_adapter.PLAYER_TOKEN_TYPE.THIRDPARTY_TYPE)
  token_adapter.thirdparty_player_login(player_info, cb)
end

function M.user_info()
  local gangplank_user_info = gangplank.user_info()
  if gangplank_user_info and USER.user_info() and USER.user_info().token and string.len(USER.user_info().token) then
    gangplank_user_info.usercenter_token = USER.user_info().token
  end
  do return LUTIL.notify_resp, true, "" end
  return LUTIL.notify_resp, true, "", gangplank_user_info or {}
end

function M.sdk_info()
  local INIT = require("ejoysdk_lua.native.core.init")
  do return LUTIL.notify_resp, true, "", INIT.get_opts() end
  return LUTIL.notify_resp, true, "", INIT.get_opts()
end

M.show_agreement = EAM.show_agreement

function M.analog_enter_game(player_id, player_name, game_server, cb)
  local analog = require("sdk_test.analog")
  analog.login(player_id, function(succ)
    if succ then
      E.LOG.debug(TAG, "进入游戏成功")
      local player_info = {
        player_id = player_id,
        player_name = player_name,
        server_id = game_server
      }
      E.LOG.debug(TAG, player_info)
      LUTIL.notify(cb, true, "获取角色成功: " .. player_name)
      gangplank.set_player_info(player_info, "enterGame")
    else
      LUTIL.notify(cb, false, "进入游戏失败")
    end
  end)
end

function M.anlog_login_game(params, cb)
  local analog = require("sdk_test.analog")
  local game_token = params.game_token
  local game_server = params.game_server
  local player_name = params.player_name
  analog.init(game_token)
  analog.create_player(game_server, player_name, function(succ, player_id)
    if succ then
      M.analog_enter_game(player_id, player_name, game_server, cb)
    else
      LUTIL.notify(cb, false, "创建角色失败")
    end
  end)
end

function M.get_thirdparty_player_token(thirdparty_info, cb)
  local token_adapter = require("ejoysdk_lua.ejoysdk_token_adapter")
  token_adapter.get_thirdparty_player_token(thirdparty_info, function(succ, ...)
    if succ then
      local body_data = (...)
      cb(true, body_data)
    else
      local code, msg = ...
      cb(false, {
        code = tostring(code),
        msg = tostring(msg)
      })
    end
  end)
end

return M
