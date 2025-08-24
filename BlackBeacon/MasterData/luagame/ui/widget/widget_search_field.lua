local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)

function M:_init(ui)
  Base._init(self)
  self.v_ui = ui
end

function M:init_by_input_field(input_field, search_data_arr, cb_data_arr, cb, cb_self, detail_search)
  self.v_detail_search = detail_search
  self.v_input_field = input_field
  self.v_search_data_arr = search_data_arr
  self.v_cb_data_arr = cb_data_arr
  self.v_cb_self = cb_self
  self.v_cb = cb
  Global.listener_mgr:add_listener(self, self.v_input_field.onEndEdit, function(text)
    self:_on_search(text)
  end)
end

function M:_on_detail_search(text)
  local txt_tbl = {}
  local char_count = 0
  local text_len = #text
  for i = 1, text_len do
    local cur_byte = string.byte(text, i)
    local count = 1
    if cur_byte > 0 and cur_byte <= 127 then
      count = 1
    elseif cur_byte >= 192 and cur_byte < 223 then
      count = 2
    elseif cur_byte >= 224 and cur_byte < 239 then
      count = 3
    elseif cur_byte >= 240 and cur_byte <= 247 then
      count = 4
    end
    local char = string.sub(text, i, i + count - 1)
    i = i + count - 1
    char_count = char_count + 1
    txt_tbl[char_count] = char
  end
  local rt = {}
  for index, search_tbl in pairs(self.v_search_data_arr) do
    local find_flag = true
    for _, search in pairs(search_tbl) do
      for _, char in pairs(txt_tbl) do
        if string.find(search, char) == nil then
          find_flag = false
          break
        end
      end
      if find_flag then
        rt[index] = self.v_cb_data_arr[index]
      end
    end
  end
  if self.v_cb_self then
    self.v_cb(self.v_cb_self, rt)
  else
    self.v_cb(rt)
  end
end

function M:_on_normal_search(text)
  local rt = {}
  for index, search_tbl in pairs(self.v_search_data_arr) do
    for _, search in pairs(search_tbl) do
      if string.find(search, text) ~= nil then
        rt[index] = self.v_cb_data_arr[index]
        break
      end
    end
  end
  if self.v_cb_self then
    self.v_cb(self.v_cb_self, rt)
  else
    self.v_cb(rt)
  end
end

function M:_on_search(text)
  if "" == text then
    return
  end
  if self.v_detail_search then
    self:_on_detail_search(text)
  else
    self:_on_normal_search(text)
  end
end

function M:dispose()
  self.v_cb_self = nil
  if nil ~= self.v_input_field then
    self.v_input_field.onEndEdit:RemoveAllListeners()
  end
  self.v_cb = nil
  self.v_input_field = nil
end

return M
