local E = require("ejoysdk_lua.ejoysdk")
local CC = require("ejoysdk_lua.cloud_game.cloud_config")
local CG = require("ejoysdk_lua.vendors.cloud_game")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local TAG = "cloud_install_pkg_manager"
local M = {}
local install_package_name, appstore_app_id, appstore_app_scheme
local pkg_installed_change_listeners = {}
local has_start_check_loop = false
local loop_interval = 5
local current_install_state = false
local is_stat_install_action = false

local function stat_install_finish_action()
  E.LOG.debug(TAG, "stat install finish action")
  local params = {}
  params.installTime = os.time()
  CSTAT.commit_event("sdk.install.finish", params)
end

local function notify_pkg_installed(is_install)
  E.LOG.debug(TAG, "notify pkg installed >> " .. tostring(is_install))
  for _, listener in ipairs(pkg_installed_change_listeners) do
    listener(is_install)
  end
end

local function start_check_install_state_loop()
  if not has_start_check_loop then
    E.LOG.debug(TAG, "start check install state loop")
    local loop_func
    
    function loop_func()
      E.Timer.once(loop_interval, function()
        local is_pkg_installed = M.is_pkg_installed()
        E.LOG.debug(TAG, "do check >> " .. tostring(is_pkg_installed))
        if current_install_state ~= is_pkg_installed then
          if not current_install_state and not is_stat_install_action then
            stat_install_finish_action()
          end
          current_install_state = is_pkg_installed
          notify_pkg_installed(is_pkg_installed)
        end
        loop_func()
      end)
    end
    
    loop_func()
    has_start_check_loop = true
  end
end

function M.init()
  E.LOG.debug(TAG, "do init")
  install_package_name = CC.InstallPkgName
  E.LOG.debug(TAG, "pkg name read from cloud config >> " .. tostring(install_package_name))
  appstore_app_id = CC.AppStoreAppID
  appstore_app_scheme = CC.AppStoreScheme
  current_install_state = M.is_pkg_installed()
  start_check_install_state_loop()
end

function M.jump_to_store_install()
  CG.pull_appstore_download_page(appstore_app_id)
  E.LOG.debug(TAG, "receive jump to store install >> " .. tostring(appstore_app_id))
end

function M.run_local_game()
  E.LOG.debug(TAG, "run local game, scheme >> " .. tostring(appstore_app_scheme))
  if _ejoysdk.os() == "ios" then
    E.Sysinfo.open_url(appstore_app_scheme)
  else
    E.LOG.debug(TAG, "do nothing")
  end
end

local is_install = false

function M.is_pkg_installed()
  if _ejoysdk.os() == "ios" then
    if appstore_app_scheme then
      E.LOG.debug(TAG, "call sysinfo can_open_url >> " .. tostring(appstore_app_scheme))
      local can_open = E.Sysinfo.can_open_url(appstore_app_scheme)
      E.LOG.debug(TAG, "call sysinfo can_open_url result >> " .. tostring(can_open))
      return can_open
    end
  else
    return is_install
  end
end

function M.register_installed_listener(listener)
  for _, handler in ipairs(pkg_installed_change_listeners) do
    if handler == listener then
      return
    end
  end
  pkg_installed_change_listeners[#pkg_installed_change_listeners + 1] = listener
  E.LOG.debug(TAG, "register_install_state_change_listener succ")
end

function M.unregister_installed_listener(listener)
  local new = {}
  for _, handler in ipairs(pkg_installed_change_listeners) do
    if listener ~= handler then
      new[#new + 1] = handler
    end
  end
  pkg_installed_change_listeners = new
  E.LOG.debug(TAG, "unregister_installed_listener succ")
end

return M
