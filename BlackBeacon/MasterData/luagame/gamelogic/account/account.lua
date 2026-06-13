local UnityPlayerPrefs = UnityEngine.PlayerPrefs
local Application = UnityEngine.Application
local M = {}
local KEY = "TMP_ACCOUNT_" .. Application.dataPath

local function generate_account()
  local t = os.time() / 1.0E8 % 1 * 1.0E8
  return math.floor(t)
end

function M:set_tourist_account(account)
  UnityPlayerPrefs.SetString(KEY, account)
end

function M:get_account()
  if SDKManager:is_use_sdk() then
    return SDKManager:get_sdk_account()
  end
  local account
  if UnityPlayerPrefs.HasKey(KEY) then
    account = UnityPlayerPrefs.GetString(KEY)
    if account and "" ~= account then
      return account
    end
  end
  return account
end

function M:_init_device_type()
  local device_type = 0
  if UNITY_EDITOR then
    device_type = 0
  elseif UNITY_IOS then
    device_type = 1
  elseif UNITY_ANDROID then
    device_type = 2
  elseif UNITY_STANDALONE_WIN then
    device_type = 3
  end
  return device_type
end

function M:init()
  self.v_device_type = self:_init_device_type()
  self.v_login_token = "L6BMdekz6Z"
  self.v_gatesvrs_count = 0
  self.v_gatesvrs = {}
  self.v_login_ip = nil
end

function M:update_auth(info)
  self.v_gatesvrs = info.gatesvrs
  self.v_gatesvrs_count = #info.gatesvrs
  self.v_login_token = info.login_token
  SDKManager:on_game_server_auth_success(info)
end

function M:get_fst_gatesvr_address()
  return self:get_gatesvr_address(1)
end

function M:get_gatesvr_address(idx)
  local info = self.v_gatesvrs[idx]
  if info then
    return info.address, info.ipv6_ip
  end
  return ""
end

function M:update_login_token(login_token)
  self.v_login_token = login_token
end

function M:get_login_token()
  return self.v_login_token
end

function M:get_gatesvrs_count()
  return self.v_gatesvrs_count
end

function M:get_device_type()
  return self.v_device_type
end

function M:get_platform()
  return SDKManager:get_platform()
end

function M:is_new_register_account()
  return self.v_is_new_account
end

function M:update_login_ip(ip)
  self.v_login_ip = ip
end

function M:get_ip()
  return self.v_login_ip
end

M:init()
return M
