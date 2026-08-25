local logger = require("ejoysdk_lua.shark_sdk.util.logger")
local ejoysdk = require("ejoysdk_lua.ejoysdk")
local M = {}
local current_cfg
local DEFAULT_CONFIG = {
  client_info = {
    cdn_urls = {},
    hotfix_dir = "",
    hotfix_temp_dir = "",
    branch = "",
    version = ""
  },
  hotfix = {fetch_interval = 60},
  report = {enable = true}
}

local function deep_copy(source)
  if type(source) ~= "table" then
    return source
  end
  local copy = {}
  for key, value in pairs(source) do
    copy[key] = deep_copy(value)
  end
  return copy
end

local function merge_config(base_cfg, user_cfg)
  if type(user_cfg) ~= "table" then
    return base_cfg
  end
  local merged = deep_copy(base_cfg)
  for key, value in pairs(user_cfg) do
    if type(value) == "table" and type(merged[key]) == "table" then
      merged[key] = merge_config(merged[key], value)
    else
      merged[key] = value
    end
  end
  return merged
end

local function validate_client_info(client_info)
  if not client_info then
    return "client_info 不能为空"
  end
  local required_fields = {
    {
      name = "hotfix_dir",
      desc = "热更文件存储目录"
    },
    {
      name = "hotfix_temp_dir",
      desc = "热更临时目录"
    },
    {
      name = "branch",
      desc = "客户端分支"
    },
    {
      name = "version",
      desc = "客户端版本号"
    }
  }
  for _, field in ipairs(required_fields) do
    local value = client_info[field.name]
    if nil == value or "" == value then
      return string.format("client_info.%s 不能为空 (%s)", field.name, field.desc)
    end
  end
  if client_info.hotfix_dir == client_info.hotfix_temp_dir then
    return "hotfix_dir 和 hotfix_temp_dir 不能相同"
  end
  return nil
end

local function ensure_dir_exists(dir_path)
  local exists = ejoysdk.File.exists(dir_path)
  if not exists then
    local ok = ejoysdk.File.make_dirs(ejoysdk.File.get_ext_file_dir() .. "/" .. dir_path)
    if not ok then
      do return string.format, "创建目录失败: %s" end
      return string.format, "创建目录失败: %s", dir_path
    end
  end
  return nil
end

local function generate_random_dir_name()
  math.randomseed(os.time())
  do return string.format, "%d_%06x", os.time(), math.random(0, 16777215) end
  return string.format, "%d_%06x", os.time(), math.random(0, 16777215)
end

local function load_internal_config()
  return {
    pcode = ejoysdk.CONFIG.get_config("product") or ""
  }
end

function M.init(user_config)
  local merged = merge_config(DEFAULT_CONFIG, user_config)
  local err = validate_client_info(merged.client_info)
  if nil ~= err then
    logger.error("client_info 配置校验失败: " .. err)
    return nil, err
  end
  merged.client_info.hotfix_temp_dir = merged.client_info.hotfix_temp_dir .. "/" .. generate_random_dir_name()
  merged.internal = load_internal_config()
  current_cfg = merged
  err = ensure_dir_exists(current_cfg.client_info.hotfix_dir)
  if nil ~= err then
    logger.error("创建热更文件存储目录失败: " .. err)
    return nil, err
  end
  err = ensure_dir_exists(current_cfg.client_info.hotfix_temp_dir)
  if nil ~= err then
    logger.error("创建热更临时目录失败: " .. err)
    return nil, err
  end
  return current_cfg, nil
end

function M.get_config()
  if not current_cfg then
    current_cfg = deep_copy(DEFAULT_CONFIG)
  end
  return current_cfg
end

function M.get_cdn_urls()
  return M.get_config().client_info.cdn_urls
end

function M.get_branch()
  return M.get_config().client_info.branch
end

function M.get_version()
  return M.get_config().client_info.version
end

function M.get_hotfix_dir()
  return M.get_config().client_info.hotfix_dir
end

function M.get_hotfix_temp_dir()
  return M.get_config().client_info.hotfix_temp_dir
end

function M.get_fetch_interval()
  return M.get_config().hotfix.fetch_interval
end

function M.is_fetch_enabled()
  return M.get_config().hotfix.fetch_enable
end

function M.is_report_enabled()
  return M.get_config().report.enable
end

function M.get_pcode()
  local cfg = M.get_config()
  return cfg.internal and cfg.internal.pcode or ""
end

return M
