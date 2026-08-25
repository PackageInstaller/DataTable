local E = require("ejoysdk_lua.ejoysdk")
local V = require("ejoysdk_lua.version")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local split_string = E.Utils.split_string
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "ver_check"
local SDK_NAME = {
  EJOYSDK = "EJOYSDK",
  ANDROID_UNITY_SDK = "UNITYSDK",
  IOS_EJOYSDK_BASE = "EJOYSDK_BASE"
}
local M = {}

local function collect_sdk_min_versions(vendors)
  local sdk_min_version_list = {}
  local sdk_name_list = {}
  table.insert(sdk_name_list, SDK_NAME.EJOYSDK)
  local platform_min_versions = {}
  local os = E.Sysinfo.os()
  if "ios" == os then
    platform_min_versions = V.IOS_MIN_VER
    table.insert(sdk_name_list, SDK_NAME.IOS_EJOYSDK_BASE)
  elseif "android" == os then
    platform_min_versions = V.ANDROID_MIN_VER
  elseif "windows" == os then
    platform_min_versions = V.WINDOWS_MIN_VER
  end
  for vendor_name, _ in pairs(vendors) do
    table.insert(sdk_name_list, vendor_name)
  end
  for _i, name in ipairs(sdk_name_list) do
    sdk_min_version_list[name] = platform_min_versions[name]
  end
  return sdk_min_version_list
end

local function compare_versions(version1, version2)
  if nil == version1 or "" == version1 or nil == version2 or "" == version2 then
    if nil ~= version1 and "" ~= version1 then
      return 1
    elseif nil ~= version2 and "" ~= version2 then
      return -1
    else
      return 0
    end
  end
  local version_arr1 = split_string(version1, "%.")
  local version_arr2 = split_string(version2, "%.")
  local min_len = math.min(#version_arr1, #version_arr2)
  local diff = 0
  local idx = 1
  while min_len >= idx do
    local str1 = version_arr1[idx]
    local str2 = version_arr2[idx]
    diff = string.len(str1) - string.len(str2)
    if 0 == diff then
      if str1 == str2 then
        diff = 0
      elseif str1 > str2 then
        diff = 1
      else
        diff = -1
      end
    end
    if 0 ~= diff then
      break
    end
    idx = idx + 1
  end
  if 0 ~= diff then
    if diff > 0 then
      return 1
    else
      return -1
    end
  else
    local len = #version_arr1 - #version_arr2
    if len > 0 then
      return 1
    elseif 0 == len then
      return 0
    else
      return -1
    end
  end
end

M.compare_versions = compare_versions

function M.check_sdk_version(vendors)
  local sdk_list = collect_sdk_min_versions(vendors)
  E.log(sdk_list)
  local check_result = {result = true}
  local stat_table_data = {}
  table.insert(stat_table_data, "lua_ver:" .. V.LUA_VERSION)
  for k, v in pairs(sdk_list) do
    local sdk_name = k
    local sdk_min_version = v
    if "table" == type(sdk_min_version) then
      for ck, cv in pairs(sdk_min_version) do
        local ch_sdk_min_version = cv
        local ch_sdk_name = ck
        local ch_cur_sdk_version = E.get_sdk_version_name(ch_sdk_name)
        E.log("version>> sdk detail, sdk_name:" .. (ch_sdk_name or "") .. ", min_ver:" .. (ch_sdk_min_version or "") .. ", sdk_ver:" .. (ch_cur_sdk_version or ""))
        if nil == ch_cur_sdk_version or "" == ch_cur_sdk_version then
          E.log("version>> warnning game not integrate sdk_name:" .. ch_sdk_name)
        else
          local ch_compare_result = compare_versions(ch_cur_sdk_version, ch_sdk_min_version)
          if ch_compare_result < 0 then
            check_result.result = false
            check_result.sdk_name = ch_sdk_name
            check_result.sdk_min_version = ch_sdk_min_version
            check_result.current_sdk_version = ch_cur_sdk_version
            break
          end
        end
      end
    else
      local current_sdk_version = E.get_sdk_version_name(sdk_name)
      local compare_result
      E.log("version>> sdk detail, sdk_name:" .. (sdk_name or "") .. ", min_ver:" .. (sdk_min_version or "") .. ", sdk_ver:" .. (current_sdk_version or ""))
      if nil ~= current_sdk_version and "" ~= current_sdk_version then
        compare_result = compare_versions(current_sdk_version, sdk_min_version)
        if compare_result < 0 then
          check_result.result = false
          check_result.sdk_name = sdk_name
          check_result.sdk_min_version = sdk_min_version
          check_result.current_sdk_version = current_sdk_version
        end
      else
        E.LOG.warn(TAG, "current native sdk version is nil, sdk_name:" .. sdk_name)
      end
      local item_stat_data = {}
      table.insert(item_stat_data, sdk_name)
      table.insert(item_stat_data, "min_ver:" .. (sdk_min_version or "nil"))
      table.insert(item_stat_data, "curr_ver:" .. (current_sdk_version or "nil"))
      table.insert(item_stat_data, "result:" .. tostring(compare_result))
      local item_stat_str = table.concat(item_stat_data, "-")
      table.insert(stat_table_data, item_stat_str)
    end
    if not check_result.result then
      break
    end
  end
  if check_result.result then
    E.log("version>> version check success!")
    table.insert(stat_table_data, "check_result:true")
  else
    E.log("version>> check error! current version is smaller than min version, sdk_name:" .. check_result.sdk_name .. ", sdk_min_ver:" .. (check_result.sdk_min_version or "") .. ", cur_sdk_ver:" .. (check_result.current_sdk_version or ""))
    table.insert(stat_table_data, "check_result:false")
  end
  table.sort(stat_table_data)
  local comp_ver_stat_str = table.concat(stat_table_data, ",")
  ESTAT.stat_action("version.check", TAG, check_result.result, {comp_ver_stat_result = comp_ver_stat_str})
  E.LOG.debug(TAG, "comp_ver_stat_str:" .. comp_ver_stat_str)
  return check_result
end

return M
