local E = require("ejoysdk_lua.ejoysdk")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local GRM = require("ejoysdk_lua.res.group_res_manager")
local M = {}
local _tasks = {}
local TAG = "PriorityMultiUpdates"

local function _invoke_listener(group_name, func_name, ...)
  if not UTILS.is_text_empty(group_name) and _tasks[group_name] and _tasks[group_name].listeners and type(_tasks[group_name].listeners[func_name]) == "function" then
    _tasks[group_name].listeners[func_name](group_name, ...)
  end
end

function M.groups_update(res_key, groups_info, listeners)
  local FACADE = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  local NOTIF = require("ejoysdk_lua.res.ui.download_android_notif_presenter")
  for _, config in pairs(groups_info) do
    local group_name = config.group_name
    local opts = config.opts or {}
    opts.default_progress_style = opts.default_progress_style or NOTIF.PROGRESS_STYLE.PROGRESS_STYLE_NO_PROGRESS
    if _tasks[group_name] then
      local __task_info = _tasks[group_name]
      local __opts = opts or __task_info.opts
      __task_info.listeners = listeners or __task_info.listeners
      __task_info.opts = __opts
      local _update_task = GRM.get_update_task(res_key, group_name)
      if _update_task then
        E.LOG.d(TAG, "update_task:" .. group_name)
        _update_task:update_config(opts)
      else
        E.LOG.d(TAG, "not found update task:" .. group_name)
      end
    else
      local _inner_listeners = {
        on_confirm_res_update = function(update_info, confirm_cb)
          _invoke_listener(group_name, "on_confirm_res_update", update_info, confirm_cb)
        end,
        on_res_download_progress_change_listener = function(state, progress_info)
          _invoke_listener(group_name, "on_res_download_progress_change_listener", state, progress_info)
        end,
        on_res_apply_progress_change_listener = function(state, progress_info)
          _invoke_listener(group_name, "on_res_apply_progress_change_listener", state, progress_info)
        end,
        on_group_res_update_complete = function(result, ...)
          E.LOG.d(TAG, "complete group_name:" .. group_name)
          _invoke_listener(group_name, "on_group_res_update_complete", result, ...)
          _tasks[group_name] = nil
        end
      }
      _tasks[group_name] = {
        listeners = listeners,
        opts = opts or {}
      }
      FACADE.group_res_update(group_name, nil, opts, _inner_listeners)
    end
  end
end

return M
