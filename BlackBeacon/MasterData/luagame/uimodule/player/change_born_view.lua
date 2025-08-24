local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local CircleList = require("ui.widget.circle_loop_list")
local CircleItem = require("uimodule.player.local_widgets.drop_item")
local Player_cfg = require("uimodule.player.player_cfg")
local _tinsert = table.insert
local month_temp = {}
local day_temp = {}
local month_day = {
  [1] = 31,
  [2] = 29,
  [3] = 31,
  [4] = 30,
  [5] = 31,
  [6] = 30,
  [7] = 31,
  [8] = 31,
  [9] = 30,
  [10] = 31,
  [11] = 30,
  [12] = 31
}
local CIRCLE_LIST = {v_month_list = "Month_list", v_day_list = "Day_list"}
local TEMPLATE_KEY = {
  Month_list = "CIRCLE_MONTH_TEMPLATE",
  Day_list = "CIRCLE_DAY_TEMPLATE"
}

function ui:ui_finish_load()
  local model = {}
  for key, value in pairs(CIRCLE_LIST) do
    model[key] = {
      [1] = value,
      [2] = BIND_TYPE.OBJECT
    }
  end
  self:init_model(model)
  self:set_button("Submit", function()
    self:submit_born_date()
  end)
  self:set_button("BgReturn", function()
    self:ui_hide()
  end)
  self:set_button("Cancel", function()
    self:ui_hide()
  end)
  for i = 1, 12 do
    local temp = {
      num = i,
      state = Player_cfg.BORN_STATE.Month
    }
    _tinsert(month_temp, temp)
  end
  day_temp[29] = {}
  for i = 1, 29 do
    local temp = {
      num = i,
      state = Player_cfg.BORN_STATE.Day
    }
    _tinsert(day_temp[29], temp)
  end
  day_temp[30] = {}
  for i = 1, 30 do
    local temp = {
      num = i,
      state = Player_cfg.BORN_STATE.Day
    }
    _tinsert(day_temp[30], temp)
  end
  day_temp[31] = {}
  for i = 1, 31 do
    local temp = {
      num = i,
      state = Player_cfg.BORN_STATE.Day
    }
    _tinsert(day_temp[31], temp)
  end
  for key, value in pairs(CIRCLE_LIST) do
    local born_name = value
    local scroll_name = key
    self[born_name] = CircleList:new(self, self[scroll_name], CircleItem, TEMPLATE_KEY[value])
  end
end

function ui:ui_on_show()
  self.v_born_data = {month = 0, day = 0}
  for _, value in pairs(CIRCLE_LIST) do
    local born_name = value
    self[born_name]:refresh_data(month_temp)
  end
  self:init_event()
end

function ui:ui_on_hide()
  for _, value in pairs(CIRCLE_LIST) do
    local born_name = value
    self[born_name]:clear()
  end
end

function ui:ui_on_destroy()
  for _, value in pairs(CIRCLE_LIST) do
    local born_name = value
    self[born_name] = nil
  end
end

function ui:init_event()
  self:bind_auto_mq(Const.MSG_ON_SELECTED_PLAYER_BORN_ITEM, self.update_born_value, self)
end

function ui:update_born_value(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local num = msg.mm_obj.num
  local state = msg.mm_obj.state
  if state == Player_cfg.BORN_STATE.Month then
    self.v_born_data.month = num
    self:update_day_num(num)
  else
    self.v_born_data.day = num
  end
end

function ui:update_day_num(month)
  local day_num = month_day[month]
  self.Day_list:clear()
  self.Day_list:refresh_data(day_temp[day_num])
end

function ui:submit_born_date()
  local birthday_data = {
    month = self.v_born_data.month,
    day = self.v_born_data.day
  }
  Util.show_conform_tip("确认后将不可修改，是否确认？", nil, nil, nil, function()
    PlayerMgr:upgrade_birthday(birthday_data, function()
      local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_BIRTHDAY_SUCCESS)
      msg.mm_obj = birthday_data
    end)
    self:ui_hide()
  end)
end

return ui
