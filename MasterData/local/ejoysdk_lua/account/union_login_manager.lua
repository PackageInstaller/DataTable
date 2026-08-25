local E = require("ejoysdk_lua.ejoysdk")
local MI = require("ejoysdk_lua.vendors.xiaomi")
local OPPO = require("ejoysdk_lua.vendors.oppo")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local API = require("ejoysdk_lua.user_center.usercenter_api")
local M = {}
local TAG = "union_login_manager#"
local union_vendor, dsToken
local MAX_RETRY_TIMES = 10
local RETRY_INTERVAL = 60

local function try_get_account_attribution(player_info)
  local ptid = E.get_ptid()
  if dsToken and "" ~= ptid then
    local get_account_attribution_task
    local retry_get_account_attribution_times = 0
    local account_token = dsToken
    
    local function retry_func()
      if get_account_attribution_task and retry_get_account_attribution_times < MAX_RETRY_TIMES then
        retry_get_account_attribution_times = retry_get_account_attribution_times + 1
        E.Timer.once(RETRY_INTERVAL, get_account_attribution_task)
      end
    end
    
    function get_account_attribution_task()
      E.LOG.debug(TAG, "get account attribution start, retry time = " .. tostring(retry_get_account_attribution_times))
      local channel_params = union_vendor.channel_params()
      API.get_account_attribution(dsToken, channel_params, function(succ, ...)
        E.LOG.debug(TAG, "get account attribution return, succ >> " .. tostring(succ))
        E.LOG.debug(TAG, {
          ...
        })
        if M.check_is_union_pkg() ~= "XIAOMI" then
          E.LOG.debug(TAG, "union not xiaomi, do not handle response")
          return
        end
        if account_token ~= dsToken then
          E.LOG.debug(TAG, "account_token change, do not handle response")
          return
        end
        if succ then
          E.LOG.debug(TAG, "get account attribution success ")
          local body = (...)
          local cddpResult = body.cddpResult
          if cddpResult and cddpResult.cddpAdmc and cddpResult.cddpAccountId and cddpResult.cddpTime then
            if union_vendor then
              union_vendor.report_account_info(player_info, cddpResult)
            end
          else
            retry_func()
          end
        else
          local code, msg = ...
          E.LOG.debug(TAG, "get account attribution fail code = " .. tostring(code) .. ", and msg = " .. tostring(msg))
          retry_func()
        end
      end)
    end
    
    retry_get_account_attribution_times = 0
    get_account_attribution_task()
  else
    E.LOG.debug(TAG, "ptid is empty")
  end
end

local function set_player_info_handler(player_info, type)
  E.LOG.debug(TAG, "receive set player info")
  if "enterGame" == type then
    pcall(try_get_account_attribution, player_info)
  end
end

local function acquire_handler()
  E.LOG.debug(TAG, "gangplank acquire acquire_handler ")
end

local function auth_handler(user_info)
  E.LOG.debug(TAG, "union login manager auth_handler ")
  if user_info and user_info.ptoken then
    E.LOG.debug(TAG, "user info ptoken >> " .. tostring(user_info.ptoken))
    dsToken = user_info.ptoken
  end
end

function M.init()
  E.LOG.debug(TAG, "init union login manager")
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO_WITH_TYPE, set_player_info_handler)
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_handler)
  ET.subscribe(ET.gangplank.AUTH_SUCC, auth_handler)
end

function M.check_is_union_pkg()
  if _ejoysdk.os() == "android" then
    if MI.is_channel_device() then
      union_vendor = MI
      return "XIAOMI"
    end
    if OPPO.is_channel_device() then
      union_vendor = OPPO
      return "OPPO"
    end
  end
  return nil
end

function M.union_login(cb)
  union_vendor.union_login(cb)
end

function M.upload_login_result()
end

return M
