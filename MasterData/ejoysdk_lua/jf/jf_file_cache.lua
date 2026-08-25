local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.JF .. "JF_FILE_CACHE"
local JF_DIR_NAME = "ejoysdk_jf_res"
local M = {}

function M.is_support_jf_file_cache()
  local is_support_jf_file_cache = E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.INIT_JF_FILE_CACHE)
  return is_support_jf_file_cache
end

function M.init_jf_file_cache()
  E.init_jf_file_cache(JF_DIR_NAME)
end

function M.new(sub_dir_name)
  local instance = {sub_dir_name = sub_dir_name}
  
  local function _switch_and_call(func, ...)
    E.switch_jf_sub_dir(instance.sub_dir_name)
    do return func, ... end
    return func, ...
  end
  
  function instance.insert_file_cache_event(event_log_str)
    E.LOG.debug(TAG, "insert_file_cache_event jf_cache_file_log: " .. tostring(event_log_str))
    do return _switch_and_call, E.jf_log end
    return _switch_and_call, E.jf_log, event_log_str, tostring(event_log_str), event_log_str
  end
  
  function instance.get_jf_file_infos(cb)
    do return _switch_and_call, E.get_jf_file_infos end
    return _switch_and_call, E.get_jf_file_infos, cb
  end
  
  function instance.get_current_jf_file_info(cb)
    do return _switch_and_call, E.get_current_jf_file_info end
    return _switch_and_call, E.get_current_jf_file_info, cb
  end
  
  function instance.flush_jf_log()
    do return _switch_and_call end
    return _switch_and_call, E.flush_jf_log
  end
  
  function instance.scroll_jf_log()
    do return _switch_and_call end
    return _switch_and_call, E.scroll_jf_log
  end
  
  return instance
end

return M
