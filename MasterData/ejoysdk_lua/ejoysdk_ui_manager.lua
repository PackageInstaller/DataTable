local E = require("ejoysdk_lua.ejoysdk")
local Q = require("ejoysdk_lua.ejoysdk_queue")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "cloud_ui_mgr"
M.UI_PRIORITY = {
  HIGH = 1,
  NORMAL = 2,
  LOW = 3
}
M.DIALOG_STATUS = {
  PREPARE = 0,
  IN_LINE = 1,
  SHOWING = 2,
  FINISH = 3
}
local DIALOG_QUEUE_CAPACITY = 10
local high_queue = Q.create(DIALOG_QUEUE_CAPACITY)
local normal_queue = Q.create(DIALOG_QUEUE_CAPACITY)
local low_queue = Q.create(DIALOG_QUEUE_CAPACITY)
local current_show_dialog

function M.test()
  E.LOG.debug(TAG, "start test!")
  
  local function new_dialog(title)
    local dialog = {
      ui_content = {
        title = title,
        msg = "this is the test ui modal",
        btn = {"submit", "cancel"},
        modal = true,
        cb = function(index)
          if 0 == index then
            E.LOG.debug(TAG, "test modal btn click, index is 0")
          else
            E.LOG.debug(TAG, "test modal btn click, index is 1")
          end
        end
      },
      name = "CloudError",
      status = M.DIALOG_STATUS.PREPARE,
      is_cancel = false
    }
    return dialog
  end
  
  M.add_dialog(new_dialog("dialog 1"), M.UI_PRIORITY.HIGH)
  M.add_dialog(new_dialog("dialog 2"), M.UI_PRIORITY.HIGH)
  local dialog3 = new_dialog("dialog 3")
  M.add_dialog(dialog3, M.UI_PRIORITY.NORMAL)
  M.add_dialog(new_dialog("dialog 4"), M.UI_PRIORITY.LOW)
  M.add_dialog(new_dialog("dialog 5"), M.UI_PRIORITY.HIGH)
  dialog3.is_cancel = true
end

function M.add_dialog(dialog, priority)
  if not current_show_dialog then
    E.LOG.debug(TAG, "current show dialog is nil")
    M.show_dialog(dialog)
    return
  end
  if current_show_dialog and current_show_dialog.name == dialog.name then
    E.LOG.debug(TAG, "update current showing dialog")
    E.Modal.close(function()
      E.LOG.debug(TAG, "close callback")
      M.show_dialog(dialog)
    end)
    return
  end
  E.LOG.debug(TAG, "enqueue dialog into queue, priority >> " .. tostring(priority))
  
  local function compare(old_dialog, new_dialog)
    return old_dialog.name == new_dialog.name
  end
  
  if nil == priority or priority == M.UI_PRIORITY.NORMAL then
    E.LOG.debug(TAG, "priority is nil or normal")
    Q.replace(normal_queue, dialog, compare)
  elseif priority == M.UI_PRIORITY.HIGH then
    E.LOG.debug(TAG, "priority is high")
    Q.replace(high_queue, dialog, compare)
  else
    E.LOG.debug(TAG, "priority is low")
    Q.replace(low_queue, dialog, compare)
  end
  dialog.statue = M.DIALOG_STATUS.IN_LINE
end

function M.check_queue()
  if not Q.isEmpty(high_queue) then
    local dialog = Q.dequeue(high_queue)
    M.show_dialog(dialog)
    return
  end
  if not Q.isEmpty(normal_queue) then
    local dialog = Q.dequeue(normal_queue)
    M.show_dialog(dialog)
    return
  end
  if not Q.isEmpty(low_queue) then
    local dialog = Q.dequeue(low_queue)
    M.show_dialog(dialog)
    return
  end
end

function M.show_dialog(dialog)
  if dialog and dialog.is_cancel then
    M.check_queue()
    return
  end
  local ui_content = dialog.ui_content
  E.LOG.debug(TAG, "show dialog msg >> " .. ui_content.msg)
  local option = {
    message = ui_content.msg,
    buttons = ui_content.btn,
    modal = ui_content.modal,
    forceopen = true
  }
  
  local function cb_wrap(index)
    E.LOG.debug(TAG, "dialog dismiss callback, index >> " .. index)
    dialog.status = M.DIALOG_STATUS.FINISH
    if current_show_dialog and current_show_dialog.name == dialog.name then
      current_show_dialog = nil
      M.check_queue()
    end
    if -1 == index then
      if ui_content.force_close_cb then
        ui_content.force_close_cb()
      end
    else
      ui_content.cb(index)
    end
  end
  
  current_show_dialog = dialog
  dialog.status = M.DIALOG_STATUS.SHOWING
  E.Modal.open(ui_content.title, option, cb_wrap)
end

function M.close(name)
  if current_show_dialog and current_show_dialog.name == name then
    E.Modal.close()
    current_show_dialog.status = M.DIALOG_STATUS.FINISH
    current_show_dialog = nil
    M.check_queue()
  else
    M.find_and_cancel(name)
  end
end

function M.find_and_cancel(name)
  local function cancel_func(dialog)
    if dialog and dialog.name == name then
      dialog.is_cancel = true
    end
  end
  
  Q.traverse(high_queue, cancel_func)
  Q.traverse(normal_queue, cancel_func)
  Q.traverse(low_queue, cancel_func)
end

function M.clear()
  E.LOG.debug(TAG, "clear dialog queue")
  Q.clear(low_queue)
  Q.clear(normal_queue)
  Q.clear(high_queue)
end

function M.current_show_dialog()
  return current_show_dialog
end

return M
