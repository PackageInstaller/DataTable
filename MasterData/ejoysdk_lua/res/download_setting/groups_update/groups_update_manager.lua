local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local GRM = require("ejoysdk_lua.res.group_res_manager")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local NS = require("ejoysdk_lua.res.model.strategies.network_strategy")
local MULTI_UPDATE_TASK = require("ejoysdk_lua.res.predownload.multi_update_tasks")
local M = Class:Inherit("EjoyQzGroupsUpdateManager")
local TAG = "EjoyGroupsUpdateManager"

function M:_init(namespace, res_key, groups)
  self._data = {
    namespace = namespace,
    res_key = res_key,
    groups = groups
  }
  self.download_task = nil
end

function M:create(opts, listeners, cb)
  local namespace = self._data.namespace
  local res_key = self._data.res_key
  local update_info = SC.get_startup_update_infos()[namespace][res_key]
  E.LOG.debug(TAG, "group update info >>>")
  E.LOG.debug(TAG, update_info)
  self._opts = UTILS.deepcopy(opts) or {}
  self.listeners = listeners or {}
  self._opts[END.NAMESPACE_UPDATE_OPTIONS.DOWNLOAD_NETWORK_STRATEGY] = NS.get_strategy()
  E.LOG.debug(TAG, "create multi groups update with opts: ")
  E.log(self._opts)
  local _startup_params_info = (SC.get_startup_local_res_infos_cache() or {})[namespace] or {}[res_key] or {}
  local _extended_group_infos = UTILS.deepcopy(self._data.groups)
  for _, group_info in ipairs(_extended_group_infos) do
    local group_name = group_info.name
    group_info._res_key = res_key
    group_info._real_res_key = res_key
    if group_info.name ~= "default" then
      group_info._real_res_key = GRM.get_task_key(res_key, group_name)
      group_info._res_key = group_info._real_res_key
    end
  end
  self.download_task = MULTI_UPDATE_TASK:New(namespace, res_key, _extended_group_infos, update_info, _startup_params_info)
  self.download_task:create(opts, self.listeners, cb)
end

function M:start(cb)
  E.LOG.debug(TAG, "start update")
  E.log(self._data.groups)
  if self.download_task then
    E.LOG.debug(TAG, "start task reset")
    self.download_task:start(cb)
  else
    cb(true)
  end
end

function M:stop(cb)
  if self.download_task then
    self.download_task:stop(function(succ, ...)
      E.LOG.debug(TAG, "stop update:" .. tostring(succ))
      cb(succ, ...)
    end)
  else
    cb(true)
  end
end

function M:cancel(cb)
  E.LOG.debug(TAG, "cancel update")
  cb = cb or function()
  end
  self:stop(function(succ, ...)
    if true == succ then
      self:clean(cb)
    else
      cb(false, ...)
    end
  end)
end

function M:reset(cb)
  if self.download_task then
    self.download_task:reset(cb)
  else
    cb(true)
  end
end

function M:clean(cb)
  E.LOG.debug(TAG, "clean resource")
  cb = cb or function()
  end
  if self.download_task then
    self.download_task:clean(cb)
  else
    local ERMF = require("ejoysdk_lua.res.ejoy_res_model_factory")
    local ER = require("ejoysdk_lua.res.ejoysdk_res")
    local GMR = require("ejoysdk_lua.res.group_res_manager")
    local all_ns_resources = ER.get_all_cached_namespace_resources()
    local target_ns = self._data.namespace
    local target_res_key = self._data.res_key
    local groups = self._data.groups
    local groupNameSet = {}
    for _, group in ipairs(groups) do
      if group.name then
        groupNameSet[group.name] = true
      end
    end
    local res_map = all_ns_resources[target_ns]
    if not res_map then
      return
    end
    for _res_key, _res_info in pairs(res_map) do
      local real_res_key = GMR.get_real_res_key(_res_key)
      local group_name = GMR.get_group_name_by_task_key(_res_key)
      if target_res_key == real_res_key and groupNameSet[group_name] then
        E.LOG.debug(TAG, "clean res_key:" .. real_res_key .. ", group_name:" .. group_name)
        ER.repair(target_ns, target_res_key, group_name)
        RTM.static_clear_cached_res_info(target_ns, _res_key)
        ERMF.clear_ejoy_res_source_model(target_ns, _res_key)
      end
    end
    cb(true)
  end
end

return M
