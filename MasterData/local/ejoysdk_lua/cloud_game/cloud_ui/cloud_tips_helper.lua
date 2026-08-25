local E = require("ejoysdk_lua.ejoysdk")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Q = require("ejoysdk_lua.ejoysdk_queue")
local CG = require("ejoysdk_lua.vendors.cloud_game")
local M = {}
local TAG = "cloud_tips_helper"
local ASYNC_SHOW_TIPS = "ASYNC_SHOW_TIPS"
local TIPS_QUEUE_CAPACITY = 10
local queue = Q.create(TIPS_QUEUE_CAPACITY)
M.TIPS_KEY = {
  LUA_KEY_TIPS_CONTENT = "tips_content",
  LUA_KEY_TIPS_DISPLAY_TIME = "display_time",
  LUA_KEY_TIPS_SHOW_CLOSE = "show_close",
  LUA_KEY_TIPS_BUTTON_TEXT = "button_text",
  LUA_KEY_TIPS_BUTTON_CLICK_CB = "btn_click_cb",
  LUA_KEY_TIPS_DISMISS_CB = "dismiss_cb",
  LUA_KEY_TIPS_EXT_DATA = "ext_data",
  LUA_KEY_TIPS_ADD_TIME = "add_time",
  LUA_KEY_TIPS_SCENE = "scene"
}
local current_show_tip, show_tip, real_show_tip

local function check_and_show_tips(content)
  local startupData = content.startupData
  local btn_cb = content.js_callback
  local tip = {
    [M.TIPS_KEY.LUA_KEY_TIPS_SCENE] = startupData.scene,
    [M.TIPS_KEY.LUA_KEY_TIPS_CONTENT] = startupData.message,
    [M.TIPS_KEY.LUA_KEY_TIPS_DISPLAY_TIME] = startupData.displayTime,
    [M.TIPS_KEY.LUA_KEY_TIPS_SHOW_CLOSE] = startupData.canClose,
    [M.TIPS_KEY.LUA_KEY_TIPS_BUTTON_TEXT] = startupData.btns,
    [M.TIPS_KEY.LUA_KEY_TIPS_BUTTON_CLICK_CB] = btn_cb,
    [M.TIPS_KEY.LUA_KEY_TIPS_EXT_DATA] = startupData.ext_data,
    [M.TIPS_KEY.LUA_KEY_TIPS_ADD_TIME] = os.time()
  }
  if current_show_tip then
    if current_show_tip.scene == tip.scene then
      E.LOG.debug(TAG, "current showing tip has the same scene, update it")
      show_tip(tip)
    else
      E.LOG.debug(TAG, "current showing tip is not nil >> " .. tostring(tip[M.TIPS_KEY.LUA_KEY_TIPS_CONTENT]))
      Q.enqueue(queue, tip)
      Q.replace(queue, tip, function(origin, new)
        return origin[M.TIPS_KEY.LUA_KEY_TIPS_SCENE] and new[M.TIPS_KEY.LUA_KEY_TIPS_SCENE] and new[M.TIPS_KEY.LUA_KEY_TIPS_SCENE] == origin[M.TIPS_KEY.LUA_KEY_TIPS_SCENE]
      end)
    end
  else
    show_tip(tip)
  end
end

local remain_time_update_loop, is_loop, message_temp

function remain_time_update_loop(tip, remain_time)
  if is_loop then
    E.LOG.debug(TAG, "remain_time_update_loop remain_time:" .. tostring(remain_time) .. ", current_show_tip:" .. tostring(current_show_tip) .. ", tip:" .. tostring(tip))
    if remain_time < 0 then
      if tip and current_show_tip == tip then
        CG.hide_tips()
      end
      return
    end
    local content = string.gsub(message_temp, "${countDown}", remain_time)
    tip[M.TIPS_KEY.LUA_KEY_TIPS_CONTENT] = content
    real_show_tip(tip)
    E.Timer.once(1, function()
      local next_time = remain_time - 1
      remain_time_update_loop(tip, next_time)
    end)
  end
end

function show_tip(tip)
  current_show_tip = tip
  local ext_data = tip[M.TIPS_KEY.LUA_KEY_TIPS_EXT_DATA]
  if ext_data and ext_data.countDown then
    local add_time = tip[M.TIPS_KEY.LUA_KEY_TIPS_ADD_TIME]
    local add_duration = os.time() - add_time
    local remain_time = ext_data.countDown - add_duration
    if remain_time > 0 then
      if is_loop then
        return
      end
      is_loop = true
      message_temp = tip[M.TIPS_KEY.LUA_KEY_TIPS_CONTENT]
      remain_time_update_loop(tip, remain_time)
    end
  else
    real_show_tip(tip)
  end
end

function real_show_tip(tip)
  local facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
  if not facade.is_cloud_game_visible() then
    E.LOG.debug(TAG, "current cloud state is pause, do not show any view")
    return
  end
  local real_data = {
    [M.TIPS_KEY.LUA_KEY_TIPS_SCENE] = tip[M.TIPS_KEY.LUA_KEY_TIPS_SCENE],
    [M.TIPS_KEY.LUA_KEY_TIPS_CONTENT] = tip[M.TIPS_KEY.LUA_KEY_TIPS_CONTENT],
    [M.TIPS_KEY.LUA_KEY_TIPS_DISPLAY_TIME] = tip[M.TIPS_KEY.LUA_KEY_TIPS_DISPLAY_TIME],
    [M.TIPS_KEY.LUA_KEY_TIPS_SHOW_CLOSE] = tip[M.TIPS_KEY.LUA_KEY_TIPS_SHOW_CLOSE],
    [M.TIPS_KEY.LUA_KEY_TIPS_BUTTON_TEXT] = tip[M.TIPS_KEY.LUA_KEY_TIPS_BUTTON_TEXT],
    [M.TIPS_KEY.LUA_KEY_TIPS_EXT_DATA] = tip[M.TIPS_KEY.LUA_KEY_TIPS_EXT_DATA],
    [M.TIPS_KEY.LUA_KEY_TIPS_ADD_TIME] = tip[M.TIPS_KEY.LUA_KEY_TIPS_ADD_TIME]
  }
  UNI.async_call("CLOUD_GAME", ASYNC_SHOW_TIPS, real_data, nil, function(_succ, ...)
    local params = (...)
    local event = params.tips_cb_event
    local click_params = params.tips_btn_click_params
    local values = {
      args = {
        chl = "cloud_game",
        type = "btn_click_event",
        params = {btn_id = click_params}
      }
    }
    if "onBtnClick" == event then
      if tip[M.TIPS_KEY.LUA_KEY_TIPS_BUTTON_CLICK_CB] then
        tip[M.TIPS_KEY.LUA_KEY_TIPS_BUTTON_CLICK_CB](values)
      else
        E.LOG.debug(TAG, "LUA_KEY_TIPS_BUTTON_CLICK_CB is nil")
      end
      E.LOG.debug(TAG, "current showing tip is not nil >> " .. tostring(event))
    end
    current_show_tip = nil
    is_loop = false
    if not Q.isEmpty(queue) then
      local next_tip = Q.dequeue(queue)
      show_tip(next_tip)
    end
  end)
end

function M.show_tips(content)
  check_and_show_tips(content)
end

function M.hide_all_tips()
  Q.clear(queue)
  is_loop = false
  CG.hide_tips()
end

return M
