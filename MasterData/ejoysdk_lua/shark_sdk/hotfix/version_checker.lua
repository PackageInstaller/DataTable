local logger = require("ejoysdk_lua.shark_sdk.util.logger")
local file_util = require("ejoysdk_lua.shark_sdk.util.file_util")
local client_config = require("ejoysdk_lua.shark_sdk.config.client_config")
local ejoysdk_json = require("ejoysdk_lua.ejoysdk_json")
local M = {}
local VERSION_FILENAME = "version.json"

function M.get_version_url_list()
  local cdn_urls = client_config.get_cdn_urls()
  local branch = client_config.get_branch()
  local version = client_config.get_version()
  local url_list = {}
  for _, base_url in ipairs(cdn_urls) do
    table.insert(url_list, base_url .. "/" .. tostring(branch) .. "/" .. tostring(version) .. "/" .. VERSION_FILENAME)
  end
  return url_list
end

function M.get_version_file_path()
  local hotfix_dir = client_config.get_hotfix_dir()
  return hotfix_dir .. "/" .. VERSION_FILENAME
end

function M.get_version_temp_path()
  local temp_dir = client_config.get_hotfix_temp_dir()
  return temp_dir .. "/" .. VERSION_FILENAME
end

function M.parse_version_md5(path)
  if not file_util.file_exists(path) then
    return nil
  end
  local content = file_util.read_file(path)
  if not content then
    logger.error("读取 version.json 失败: %s", path)
    return nil
  end
  local version = ejoysdk_json.decode(content)
  if nil == version then
    return nil
  end
  return version.md5
end

function M.is_version_up_to_date()
  local remote_md5 = M.parse_version_md5(M.get_version_temp_path())
  local local_md5 = M.parse_version_md5(M.get_version_file_path())
  logger.info("远程版本 md5: %s", tostring(remote_md5))
  logger.info("本地版本 md5: %s", tostring(local_md5))
  if remote_md5 and local_md5 and remote_md5 == local_md5 then
    return true
  end
  return false
end

function M.get_version_filename()
  return VERSION_FILENAME
end

return M
