local E = require("ejoysdk_lua.ejoysdk")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local CfgHelper = require("ejoysdk_lua.apm-sdk-lua.config.helper")
local cfg = {}
local update_callback = {}
local M = {}
M.CATEGORY_STATS = "stats"
M.CATEGORY_EVENT = "event"
M.CATEGORY_LOG = "log"
M.CATEGORY_TRACE = "trace"
M.CATEGORY_REPORT = "report"
M.CATEGORY_GLOBAL = "global"
M.CATEGORY_STORE = "store"
M.CATEGORY_LABELER = "labeler"
M.CATEGORY_FILE_REPORT = "file_upload"
M.KEY_ENABLED = "enabled"
local LOGGER = "apm_config"

local function hanlder_err_fn(err)
  E.LOG.debug(LOGGER, err)
end

local default_cfg = {
  global = {enabled = true},
  store = {store_type = "file"},
  labeler = {
    http_post_timeout = 10,
    normal_refresh_token_interval = 21600,
    abnormal_refresh_token_interval = 60
  },
  stats = {
    enabled = true,
    collect_interval = 60,
    max_series_num = 100,
    modules = {
      apm_stats = {enabled = true},
      app_stats = {enabled = true},
      api_stats = {
        enabled = true,
        api_pattern = {
          {
            ["ann/v2/detail/%w+"] = "ann/v2/detail/id",
            ["ann/realm/detail/%w+"] = "ann/realm/detail/id"
          }
        }
      },
      rpc_stats = {enabled = true},
      engine_stats = {enabled = true},
      ui_stats = {enabled = false},
      common_stats = {enabled = true}
    },
    verbose = false
  },
  event = {
    enabled = true,
    rate_limit = 10,
    burst = 100,
    max_length = 1000000,
    blacklist = {},
    fast_event_report_interval = 5
  },
  log = {
    enabled = true,
    rate_limit = 10,
    burst = 100,
    max_length = 1000000,
    level = Global.LogLevelEnum.ERROR,
    bucket = "console|cloud",
    bucket_conf = {
      console = {
        format = "simple_text",
        color = false
      },
      cloud = {format = "cloud_text", color = false},
      file = {
        format = "text",
        color = true,
        file_pattern = "game_$Y$m$d_$H$M$S.log"
      }
    },
    send_log_to_cloud_through_file = true,
    open_log_param = {
      is_save = true,
      is_console = false,
      priority = 1,
      level = "error"
    },
    blacklist = {},
    enable_minimised_log_labels = false,
    whitelist_labels = {},
    disable_debug_stack = false,
    collect_line_info = false,
    dedup = {queue_len = 5, enabled = false},
    fast_log_report_interval = 5
  },
  trace = {
    enabled = true,
    rate_limit = 10,
    burst = 100,
    default_ratio = 1
  },
  file_upload = {
    enabled = true,
    retry_budget = 3,
    rate_limit = 1,
    burst = 1,
    retry_code_list = {}
  },
  report = {
    enabled = true,
    report_interval = 60,
    ingester_server = {
      formal_domain = "https://apus-ingester.ejoy.com",
      test_domain = "https://apus-ingester-test.ejoy.com",
      is_formal_env = true
    },
    transport = "http",
    skip_auth = false,
    buff_size = {
      200,
      200,
      200,
      200
    }
  }
}

function M.init()
  local cfg_from_file = E.CONFIG.get_vendor_config_v2("apm")
  E.LOG.debug(LOGGER, "read config from file:")
  E.LOG.debug(LOGGER, cfg_from_file)
  cfg = Utils.merge_table(default_cfg, cfg_from_file)
  local cfg_from_cc = M.get_from_config_center()
  E.LOG.debug(LOGGER, "retrieve config from config center:")
  E.LOG.debug(LOGGER, cfg_from_cc or {})
  cfg = Utils.merge_table(cfg, cfg_from_cc, true)
  E.LOG.debug(LOGGER, "generated apm config:")
  E.LOG.debug(LOGGER, cfg)
  Global.set_disable_debug_stack(M.disable_debug_stack())
  
  local function safely_handle_update(new_cfg)
    local function handle_update()
      do return M.handle_update end
      
      return M.handle_update, new_cfg
    end
    
    xpcall(handle_update, hanlder_err_fn)
  end
  
  ECC.subscribe(ECC.NAMESPACE.APM, safely_handle_update)
end

function M.set_hanlder_err_fn(hanlder_err_func)
  if type(hanlder_err_func) == "function" then
    hanlder_err_fn = hanlder_err_func
  end
end

function M.get_http_post_timeout()
  return cfg[M.CATEGORY_LABELER].http_post_timeout
end

function M.get_normal_refresh_token_interval()
  return cfg[M.CATEGORY_LABELER].normal_refresh_token_interval
end

function M.get_abnormal_refresh_token_interval()
  return cfg[M.CATEGORY_LABELER].abnormal_refresh_token_interval
end

function M.get_ingester_server()
  local result = cfg[M.CATEGORY_REPORT].ingester_server.formal_domain
  local is_formal_env = cfg[M.CATEGORY_REPORT].ingester_server.is_formal_env
  if not is_formal_env then
    result = cfg[M.CATEGORY_REPORT].ingester_server.test_domain
  end
  return result
end

function M.get_log_blacklist()
  return cfg[M.CATEGORY_LOG].blacklist
end

function M.get_fast_log_report_interval()
  if cfg[M.CATEGORY_LOG] == nil then
    return nil
  end
  return cfg[M.CATEGORY_LOG].fast_log_report_interval
end

local default_log_dedup_cfg = {queue_len = 1, enabled = false}

function M.get_log_dedup_cfg()
  if cfg[M.CATEGORY_LOG] == nil then
    return nil
  end
  local log_dedup_cfg = cfg[M.CATEGORY_LOG].dedup or default_log_dedup_cfg
  if type(log_dedup_cfg.enabled) ~= "boolean" then
    log_dedup_cfg.enabled = default_log_dedup_cfg.enabled
  end
  if type(log_dedup_cfg.queue_len) ~= "number" or log_dedup_cfg.queue_len < 1 then
    log_dedup_cfg.queue_len = default_log_dedup_cfg.queue_len
  end
  return log_dedup_cfg
end

function M.get_fast_event_report_interval()
  if cfg[M.CATEGORY_EVENT] == nil then
    return nil
  end
  return cfg[M.CATEGORY_EVENT].fast_event_report_interval
end

function M.get_event_blacklist()
  return cfg[M.CATEGORY_EVENT].blacklist
end

function M.get_store_type()
  return cfg[M.CATEGORY_STORE].store_type or Global.StoreTypeEnum.MEM
end

function M.get_stats_verbose()
  return cfg[M.CATEGORY_STATS].verbose
end

function M.get_api_pattern()
  return cfg[M.CATEGORY_STATS].modules.api_stats.api_pattern
end

function M.get_log_bucket()
  return cfg[M.CATEGORY_LOG].bucket or "console"
end

function M.is_log_enabled()
  return cfg[M.CATEGORY_LOG][M.KEY_ENABLED]
end

function M.disable_debug_stack()
  return cfg[M.CATEGORY_LOG].disable_debug_stack
end

function M.should_collect_line_info()
  return cfg[M.CATEGORY_LOG].collect_line_info
end

function M.should_send_log_to_cloud_through_file()
  return cfg[M.CATEGORY_LOG].send_log_to_cloud_through_file
end

function M.get_open_log_param()
  return cfg[M.CATEGORY_LOG].open_log_param
end

function M.enable_minimised_log_labels()
  return cfg[M.CATEGORY_LOG].enable_minimised_log_labels
end

function M.get_log_whitelist_labels()
  return cfg[M.CATEGORY_LOG].whitelist_labels
end

function M.is_formal_env()
  return cfg[M.CATEGORY_REPORT].ingester_server.is_formal_env
end

function M.get_log_bucket_conf()
  return cfg[M.CATEGORY_LOG].bucket_conf
end

function M.get_final_conf()
  return cfg
end

function M.set(category, key, value)
  CfgHelper.set(cfg, category, key, value)
end

function M.get(category, key, default_value)
  do return CfgHelper.get, cfg, category, key end
  return CfgHelper.get, cfg, category, key, default_value
end

function M.set_update_callback(category, func)
  update_callback[category] = func
end

function M.get_version()
  local meta = E.CONFIG.get_config("unisdk_meta")
  if not meta or not meta.sdks then
    return
  end
  for _, i in ipairs(meta.sdks) do
    if i.name == "apm" then
      return i.version
    end
  end
end

function M.get_from_config_center()
  local data = ECC.get_config(ECC.NAMESPACE.APM)
  if nil ~= data then
    return data.config
  end
end

function M.handle_update(new_cfg)
  E.LOG.debug(LOGGER, "got update from config center:")
  E.LOG.debug(LOGGER, new_cfg)
  if new_cfg.config == nil then
    E.LOG.error(LOGGER, "invalid new config")
    return
  end
  for cat, cat_cfg in pairs(new_cfg.config) do
    if type(cat_cfg) == "table" and nil ~= cfg[cat] then
      CfgHelper.handle_cat_update(cfg, update_callback, cat, cat_cfg)
    else
      E.LOG.debug(LOGGER, "invalid new config: " .. cat)
    end
  end
end

return M
