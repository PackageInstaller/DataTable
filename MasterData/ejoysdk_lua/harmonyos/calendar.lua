local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local _UNISDK = require("ejoysdk_lua.vendors.unisdk")
local M = {}
local TAG = "harmonyos#calendar"
local calendar_manager, calendarKitManager
local jf = lunate.js_functions

local function init_calendar_manager()
  calendarKitManager = jf.import("@kit.CalendarKit.calendarManager")
  local context = jf.get_context()
  calendar_manager = calendarKitManager.getCalendarManager(context)
end

local calendar

local function get_or_create_calendar(_params, cb)
  if not calendarKitManager or not calendar_manager then
    init_calendar_manager()
  end
  if calendar then
    cb(true, calendar)
    return
  end
  local calendar_account = {
    name = E.Sysinfo.package_name(),
    type = calendarKitManager.CalendarType.LOCAL,
    displayName = E.Sysinfo.app_name()
  }
  
  local function set_calendar_config()
    calendar.setConfig({enableReminder = true, color = "#0000FF"}):catch(function(_err_data)
      local code = _err_data and _err_data.code
      local message = _err_data and _err_data.message
      E.LOG.error(TAG, "setConfig failed, code is " .. tostring(code) .. ", message is " .. tostring(message))
    end):finally(function()
      E.LOG.debug(TAG, "get_or_create_calendar finally")
      cb(true, calendar)
    end)
  end
  
  calendar_manager.getCalendar(calendar_account):Then(function(data)
    calendar = data
    set_calendar_config()
  end):catch(function(_err_data)
    calendar_manager.createCalendar(calendar_account):Then(function(data)
      calendar = data
      set_calendar_config()
    end):catch(function(_err_data2)
      local code = _err_data2 and _err_data2.code
      local message = _err_data2 and _err_data2.message
      E.LOG.error(TAG, "create_calendar failed, code is " .. tostring(code) .. ", message is " .. tostring(message))
      cb(false, nil)
    end)
  end)
end

local function convert_harmony_calendar_event_info(calendar_info)
  local event_info = calendar_info.event_info and calendar_info.event_info or {}
  local reminder_info = calendar_info.reminder_info and calendar_info.reminder_info or {}
  local harmony_calendar_event_info = {
    title = event_info.title,
    description = event_info.description,
    type = calendarKitManager.EventType.NORMAL,
    startTime = event_info.start_time_mills,
    endTime = event_info.end_time_mills,
    location = {
      location = event_info.event_location
    }
  }
  if reminder_info.minutes and reminder_info.minutes > 0 then
    harmony_calendar_event_info.reminderTime = {
      reminder_info.minutes
    }
  end
  if event_info.event_id and event_info.event_id > 0 then
    harmony_calendar_event_info.id = event_info.event_id
  end
  return harmony_calendar_event_info
end

local function add_calendar_event(calendar_info_params, cb)
  local calendar_info = UTILS.deepcopy(calendar_info_params)
  local harmony_calendar_event_info = convert_harmony_calendar_event_info(calendar_info)
  calendar.addEvent(harmony_calendar_event_info):Then(function(event_id)
    E.LOG.debug(TAG, "add_event success, event_id:" .. tostring(event_id))
    cb(true, {event_id = event_id})
  end):catch(function(_err_data)
    local code = _err_data and _err_data.code or -1
    local message = _err_data and _err_data.message
    E.LOG.error(TAG, "add_event failed, code is " .. tostring(code) .. ", message is " .. tostring(message))
    cb(false, EC.CALENDAR_ERROR_CODES.CODE_ADD_EVENT_FAILED, message)
  end)
end

local function upsert_calendar_event(calendar_info_params, cb)
  local calendar_info = UTILS.deepcopy(calendar_info_params)
  M.query_event_id(calendar_info.event_info, function(_succ, ...)
    if _succ then
      local event_info = (...)
      local event_id = event_info.event_id
      calendar_info.event_info.event_id = event_id
      local harmony_calendar_event_info = convert_harmony_calendar_event_info(calendar_info)
      E.LOG.debug(TAG, "upsert_event, now update_event, query_event_id event_id:" .. tostring(event_id))
      calendar.updateEvent(harmony_calendar_event_info):Then(function()
        cb(true, {event_id = event_id})
      end):catch(function(_err_data2)
        local code = _err_data2 and _err_data2.code or -1
        local message = _err_data2 and _err_data2.message
        E.LOG.error(TAG, "upsert_event(update_event) failed, code is " .. tostring(code) .. ", message is " .. tostring(message))
        cb(false, EC.CALENDAR_ERROR_CODES.CODE_EVENT_UPDATE_FAILED, message)
      end)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "upsert_event query_event_id failed, now add_event query code :" .. tostring(code) .. ", msg:" .. tostring(msg))
      add_calendar_event(calendar_info, cb)
    end
  end)
end

function M.add_event(calendar_info_params, cb)
  get_or_create_calendar(nil, function(succ, _calendar)
    if not succ or not _calendar then
      cb(false, EC.CALENDAR_ERROR_CODES.CODE_ADD_CALENDAR_FAILED, "create calendar failed, cannot get calendar manager")
      return
    end
    E.Permission.detect_permission("ohos.permission.READ_CALENDAR", function(_succ)
      if _succ then
        E.LOG.debug(TAG, "add_event has read_permission, succ: " .. tostring(_succ))
        upsert_calendar_event(calendar_info_params, cb)
      else
        E.LOG.debug(TAG, "add_event no read_permission, succ: " .. tostring(_succ))
        add_calendar_event(calendar_info_params, cb)
      end
    end)
  end)
end

function M.update_event(params, cb)
  get_or_create_calendar(nil, function(succ, _calendar)
    if not succ or not _calendar then
      cb(false, EC.CALENDAR_ERROR_CODES.CODE_ADD_CALENDAR_FAILED, "create calendar failed, cannot get calendar manager")
      return
    end
    local old_event_info = UTILS.deepcopy(params.old_event_info)
    local new_calendar_info = UTILS.deepcopy(params.new_calendar_info)
    local origin_new_calendar_info = UTILS.deepcopy(params.new_calendar_info)
    if old_event_info then
      M.query_event_id(old_event_info, function(_succ, ...)
        if _succ then
          local event_info = (...)
          local event_id = event_info.event_id
          new_calendar_info.event_info.event_id = event_id
          M.query_event_id(origin_new_calendar_info.event_info, function(_succ2, ...)
            if _succ2 then
              M.delete_event(origin_new_calendar_info.event_info, function(_succ3, ...)
                if _succ3 then
                  E.LOG.debug(TAG, "update_event, delete_event new_calendar_info success")
                else
                  local code, msg = ...
                  E.LOG.debug(TAG, "update_event, delete_event new_calendar_info failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
                end
              end)
            end
            E.LOG.debug(TAG, "update_event, old_event_info event_id:" .. tostring(event_id))
            upsert_calendar_event(new_calendar_info, cb)
          end)
        else
          local code, msg = ...
          E.LOG.debug(TAG, "update_event query old_event_info failed, now add_event new_calendar_info, query code :" .. tostring(code) .. ", msg:" .. tostring(msg))
          upsert_calendar_event(new_calendar_info, cb)
        end
      end)
    else
      E.LOG.debug(TAG, "update_event query old_event_info is nil, now add_event new_calendar_info")
      upsert_calendar_event(new_calendar_info, cb)
    end
  end)
end

function M.delete_event(event_info_params, cb)
  M.query_event_id(event_info_params, function(succ, ...)
    if succ then
      local event_info = (...)
      local event_id = event_info.event_id
      if not event_id or 0 == event_id then
        cb(false, EC.CALENDAR_ERROR_CODES.CODE_EVENT_ID_INVALID, "event id invalid")
        return
      end
      calendar.deleteEvent(event_id):Then(function(_data)
        cb(true, {count = 1})
      end):catch(function(_err_data)
        local code = _err_data and _err_data.code or -1
        local message = _err_data and _err_data.message or "calendar delete_event failed"
        E.LOG.error(TAG, "delete_event failed, code is " .. tostring(code) .. ", message is " .. tostring(message))
        cb(false, EC.CALENDAR_ERROR_CODES.CODE_EVENT_DELETE_FAILED, message)
      end)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

local function accurate_filter_query_events(query_events, event_info)
  if event_info.event_id then
    return query_events
  end
  local filtered_events = {}
  for _, event in ipairs(query_events) do
    if event.title == event_info.title then
      local start_time_mills = event_info.start_time_mills or 0
      local end_time_mills = event_info.end_time_mills or 0
      if start_time_mills > 0 and end_time_mills > 0 then
        if event.startTime == start_time_mills and event.endTime == end_time_mills then
          table.insert(filtered_events, event)
        end
      else
        table.insert(filtered_events, event)
      end
    end
  end
  return filtered_events
end

function M.query_event(event_info_params, cb)
  get_or_create_calendar(nil, function(succ, _calendar)
    if not succ or not _calendar then
      if cb then
        cb(false, EC.CALENDAR_ERROR_CODES.CODE_ADD_CALENDAR_FAILED, "create calendar failed, cannot get calendar manager")
      end
      return
    end
    local event_info = event_info_params and event_info_params or {}
    local event_filter
    if event_info.event_id then
      event_filter = calendarKitManager.EventFilter.filterById({
        event_info.event_id
      })
    elseif event_info.title then
      event_filter = calendarKitManager.EventFilter.filterByTitle(event_info.title)
    else
      cb(false, EC.CALENDAR_ERROR_CODES.CODE_EVENT_PARAM_INVALID, "query fail, event_id and title is empty")
      return
    end
    calendar.getEvents(event_filter):Then(function(events)
      local query_events = lunate.deepcopy(events)
      query_events = accurate_filter_query_events(query_events, event_info)
      if query_events and 0 == #query_events then
        cb(false, EC.CALENDAR_ERROR_CODES.CODE_QUERY_EMPTY, "query event id empty")
        return
      else
        local query_event = query_events[1]
        local CL = require("ejoysdk_lua.ejoysdk_calendar")
        cb(true, {
          event_info = {
            event_id = query_event.id,
            title = query_event.title,
            description = query_event.description,
            start_time_mills = query_event.startTime,
            end_time_mills = query_event.endTime,
            event_location = query_event.location and query_event.location.location or ""
          },
          reminder_info = {
            minutes = query_event.reminderTime and query_event.reminderTime[1] or 0,
            method_name = CL.REMINDER_METHODS.METHOD_ALERT
          }
        })
      end
    end):catch(function(_err_data)
      local code = _err_data and _err_data.code or -1
      local message = _err_data and _err_data.message or "calendar query_event failed"
      E.LOG.error(TAG, "query_event failed, code is " .. tostring(code) .. ", message is " .. tostring(message))
      cb(false, code, message)
    end)
  end)
end

function M.query_event_id(event_info_params, cb)
  M.query_event(event_info_params, function(succ, ...)
    if succ then
      local data = (...)
      cb(true, {
        event_id = data.event_info.event_id
      })
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

return M
