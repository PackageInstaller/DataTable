local logger = require("ejoysdk_lua.shark_sdk.util.logger")
local file_util = require("ejoysdk_lua.shark_sdk.util.file_util")
local client_config = require("ejoysdk_lua.shark_sdk.config.client_config")
local ejoysdk_json = require("ejoysdk_lua.ejoysdk_json")
local M = {}
local HOTFIX_CFG_FILENAME = "hotfix_cfg.json"

function M.get_hotfix_cfg_filename()
  return HOTFIX_CFG_FILENAME
end

function M.get_config_url_list()
  local cdn_urls = client_config.get_cdn_urls()
  local branch = client_config.get_branch()
  local version = client_config.get_version()
  local url_list = {}
  for _, base_url in ipairs(cdn_urls) do
    url_list[#url_list + 1] = base_url .. "/" .. tostring(branch) .. "/" .. tostring(version) .. "/" .. HOTFIX_CFG_FILENAME
  end
  return url_list
end

function M.get_config_file_path()
  local hotfix_dir = client_config.get_hotfix_dir()
  return hotfix_dir .. "/" .. HOTFIX_CFG_FILENAME
end

function M.get_config_temp_path()
  local temp_dir = client_config.get_hotfix_temp_dir()
  return temp_dir .. "/" .. HOTFIX_CFG_FILENAME
end

function M.parse_config_from_path(file_path)
  if not file_util.file_exists(file_path) then
    return nil, "热更配置文件不存在"
  end
  local content = file_util.read_file(file_path)
  if not content then
    return nil, string.format("读取热更配置文件失败: %s", file_path)
  end
  local config = ejoysdk_json.decode(content)
  if type(config) ~= "table" or not config.hotfix_list then
    return nil, string.format("热更配置为空或无效: %s", file_path)
  end
  return config, nil
end

function M.parse_local_config()
  do return M.parse_config_from_path, M.get_config_file_path() end
  return M.parse_config_from_path, M.get_config_file_path()
end

function M.parse_downloaded_config()
  do return M.parse_config_from_path, M.get_config_temp_path() end
  return M.parse_config_from_path, M.get_config_temp_path()
end

function M.diff_hotfix_list(old_list, new_list)
  if not new_list then
    return {}
  end
  if not old_list then
    return new_list
  end
  local old_md5_map = {}
  for _, item in ipairs(old_list) do
    old_md5_map[item.fix_file_name] = item.md5
  end
  local changed_list = {}
  for _, item in ipairs(new_list) do
    local old_md5 = old_md5_map[item.fix_file_name]
    if not old_md5 or old_md5 ~= item.md5 then
      changed_list[#changed_list + 1] = item
    end
  end
  logger.info("配置对比完成: 总数=%s 变更数=%s", #new_list, #changed_list)
  return changed_list
end

return M
