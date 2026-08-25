local event = require("ejoysdk_lua.shark_sdk.util.event")
local M = {}
M.EVENT = {
  DOWNLOAD_START = "download_start",
  DOWNLOAD_FILE_SUCCESS = "download_file_success",
  DOWNLOAD_FILE_FAILED = "download_file_failed",
  APPLY_START = "apply_start",
  APPLY_SUCCESS = "apply_success",
  APPLY_FAILED = "apply_failed",
  TASK_CREATE_FAILED = "task_create_failed",
  FILE_NOT_FOUND = "file_not_found",
  CONFIG_PARSE_FAILED = "config_parse_failed",
  CONFIG_EMPTY = "config_empty",
  CONDITION_BLOCKED = "condition_blocked",
  FILE_DEDUP = "file_dedup",
  VERSION_UP_TO_DATE = "version_up_to_date",
  FILE_ALREADY_FIXED = "file_already_fixed",
  CONFIG_FETCH_START = "config_fetch_start",
  CONFIG_FETCH_SUCCESS = "config_fetch_success",
  CONFIG_FETCH_FAILED = "config_fetch_failed"
}

function M.report(event_name, labels, msg, state)
  event.report(event_name, labels or {}, msg or "shark hotfix event", state or {})
end

return M
