local E = require("ejoysdk_lua.ejoysdk")
local M = {}
local TAG = "harmonyos#notification"
local jf = lunate.js_functions
local KEEP_BACKGROUND_REQUEST_CODE = 100

function M.add_local_progress_notification(_params)
  local bg_task_mgr = jf.import("@ohos.resourceschedule.backgroundTaskManager")
  local want_agent = jf.import("@ohos.app.ability.wantAgent")
  local context = jf.get_context()
  local bundle_name = context.abilityInfo.bundleName
  local module_name = context.abilityInfo.moduleName
  local ability_name = context.abilityInfo.name
  local want_agent_info = {
    wants = {
      {
        bundleName = bundle_name,
        moduleName = module_name,
        abilityName = ability_name
      }
    },
    actionType = want_agent.OperationType.START_ABILITY,
    requestCode = KEEP_BACKGROUND_REQUEST_CODE,
    wantAgentFlags = {
      want_agent.WantAgentFlags.UPDATE_PRESENT_FLAG
    }
  }
  E.LOG.debug(TAG, "add_local_progress_notification bundle_name:" .. tostring(bundle_name) .. ", module_name:" .. tostring(module_name) .. ", ability_name:" .. tostring(ability_name))
  want_agent.getWantAgent(want_agent_info):Then(function(want_agent_obj)
    E.LOG.debug(TAG, "startBackgroundRunning begin")
    bg_task_mgr.startBackgroundRunning(context, bg_task_mgr.BackgroundMode.DATA_TRANSFER, want_agent_obj):Then(function()
      E.LOG.debug(TAG, "startBackgroundRunning for DATA_TRANSFER succ")
      E.log(want_agent_info)
    end):catch(function(error)
      E.LOG.warn(TAG, "startBackgroundRunning failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
    end)
  end):catch(function(error)
    E.LOG.warn(TAG, "add_local_progress_notification failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
  end)
end

_ejoysdk.register_ejoysdk_vm_func("setup_passive_mode_progress_presenter_info", function(progress_presenter_info)
  E.LOG.debug(TAG, "setup_passive_mode_progress_presenter_info received")
  E.log(progress_presenter_info)
  M.add_local_progress_notification({})
end)
_ejoysdk.register_ejoysdk_vm_func("stop_notification_service_foreground", function()
  E.LOG.debug(TAG, "stop_notification_service_foreground received")
  local bg_task_mgr = jf.import("@ohos.resourceschedule.backgroundTaskManager")
  local context = jf.get_context()
  bg_task_mgr.stopBackgroundRunning(context):Then(function()
    E.LOG.debug(TAG, "stopBackgroundRunning for DATA_TRANSFER succ")
  end):catch(function(err)
    E.LOG.warn(TAG, "stopBackgroundRunning for DATA_TRANSFER failed, code:" .. tostring(err.code) .. ", msg:" .. tostring(err.message))
  end)
end)
_ejoysdk.register_ejoysdk_vm_func("update_local_progress_notification", function(params)
  E.LOG.debug(TAG, "update_local_progress_notification begin")
  E.log(params)
end)
_ejoysdk.register_ejoysdk_vm_func("add_local_progress_notification", function(_params)
  E.LOG.debug(TAG, "add_local_progress_notification begin")
  M.add_local_progress_notification(_params)
end)
return M
