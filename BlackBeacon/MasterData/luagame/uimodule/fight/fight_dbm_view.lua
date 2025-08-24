local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local util_get_color = Util.get_unity_color_by_hex
local util_format = Util.format_str
local FIGHT_DBM_ITEM_KEY = "FIGHT_DBM_ITEM_KEY"
local DEFAULT_BG = "UICommon2/Com/sj_bg_dbzz2"
local DEFAULT_HEIGHT = 43
local DEFAULT_COLOR = "FFFFFF"
local bg_color_list = {
  [1] = util_get_color(tonumber("FFFFFF", 16)),
  [2] = util_get_color(tonumber("66718C", 16))
}
local CLOSE_TYPE = {ALL = 1, LATEST = 2}
local _tinsert = table.insert
local _tremove = table.remove
local is_tween_running = false

function ui:ui_finish_load()
  self:register_exist_auto_template(FIGHT_DBM_ITEM_KEY, self.v_uiobjects.DBMText, self.v_uiobjects.DBMList)
end

function ui:ui_on_show()
  self.v_dbm_show_list = {}
  self.v_head = 1
  self.v_tail = 1
end

function ui:ui_on_hide()
  self.v_dbm_show_list = nil
end

function ui:ui_on_update(delta_time)
  local length = #self.v_dbm_show_list
  if length > 0 then
    for idx, data in pairs(self.v_dbm_show_list) do
      local live_time = data.live_time
      local rest_time = live_time - delta_time
      if rest_time < 0 then
        self:remove_item(idx)
      else
        data.live_time = rest_time
      end
    end
  elseif not is_tween_running then
    self:set_enable(false)
  end
end

function ui:remove_item(idx)
  local data = self.v_dbm_show_list[idx]
  _tremove(self.v_dbm_show_list, idx)
  if data.canvas_group ~= nil then
    if self.v_hide_sequence then
      self.v_hide_sequence:Kill()
    end
    self.v_hide_sequence = Util.create_sequence()
    self.v_hide_sequence:SetUpdate(true)
    self.v_hide_sequence:Append(data.canvas_group:DOFade(0, 0.5))
    is_tween_running = true
    self.v_hide_sequence:AppendCallback(function()
      is_tween_running = false
      self:refresh_show_list_ui()
    end)
  else
    self:refresh_show_list_ui()
  end
end

function ui:add_item(id)
  local dbm_cfg = ShareRes.create("dbmText.dbmText", id)
  local temp = {
    dbm_id = id,
    live_time = dbm_cfg.LiveTime,
    Text = dbm_cfg.Text,
    BGColor = dbm_cfg.BGColor,
    BGTexture = dbm_cfg.BGTexture,
    Icon = dbm_cfg.Icon,
    IconColor = dbm_cfg.IconColor
  }
  _tinsert(self.v_dbm_show_list, temp)
end

function ui:ui_on_destroy()
  if self.v_Sequence then
    self.v_Sequence:Kill()
    self.v_Sequence = nil
  end
  if self.v_hide_sequence then
    self.v_hide_sequence:Kill()
    self.v_hide_sequence = nil
  end
  self.v_dbm_queue = nil
end

function ui:add_dbm_item(id, need_fade)
  local dbm_cfg = ShareRes.create("dbmText.dbmText", id)
  local live_time = dbm_cfg.LiveTime
  self:refresh_dbm_show_list(id, live_time, need_fade)
end

function ui:remove_dbm_item(id, close_type)
  if not self.v_dbm_show_list or next(self.v_dbm_show_list) == nil then
    return
  end
  if close_type == CLOSE_TYPE.ALL then
    local i = 1
    while self.v_dbm_show_list[i] do
      local dbm_data = self.v_dbm_show_list[i]
      local dbm_id = dbm_data.dbm_id
      if dbm_id == id then
        _tremove(self.v_dbm_show_list, i)
      else
        i = i + 1
      end
    end
  elseif close_type == CLOSE_TYPE.LATEST then
    if id then
      for idx, data in ipairs(self.v_dbm_show_list) do
        local dbm_id = data.dbm_id
        if dbm_id == id then
          _tremove(self.v_dbm_show_list, idx)
          break
        end
      end
    else
      _tremove(self.v_dbm_show_list, 1)
    end
  end
  self:refresh_show_list_ui()
end

function ui:add_item_with_banner(text, live_time, color)
  local temp = {
    live_time = live_time,
    Text = text,
    BGColor = color
  }
  _tinsert(self.v_dbm_show_list, temp)
end

function ui:add_dbm_item_with_banner(text, live_time, color)
  if not self.v_dbm_show_list then
    self.v_dbm_show_list = {}
  end
  local length = #self.v_dbm_show_list
  if length > 2 then
    self:remove_item(1)
  end
  self:add_item_with_banner(text, live_time, color)
  self:refresh_show_list_ui(true)
end

function ui:remove_dbm_item_with_banner()
  if not self.v_dbm_show_list or next(self.v_dbm_show_list) == nil then
    return
  end
  for idx, data in ipairs(self.v_dbm_show_list) do
    if nil == data.dbm_id then
      _tremove(self.v_dbm_show_list, idx)
      break
    end
  end
  self:refresh_show_list_ui()
end

function ui:refresh_dbm_show_list(dbm_id, live_time, need_fade)
  local length = #self.v_dbm_show_list
  local tail_dbm = self.v_dbm_show_list[length]
  if tail_dbm then
    local now_id = tail_dbm.dbm_id
    if now_id == dbm_id then
      tail_dbm.live_time = live_time
      return
    end
  end
  if length > 2 then
    self:remove_item(1)
  end
  self:add_item(dbm_id)
  self:refresh_show_list_ui(need_fade)
end

function ui:refresh_show_list_ui(is_need_show_tween)
  self:give_back_auto_cache(FIGHT_DBM_ITEM_KEY)
  for i = 1, #self.v_dbm_show_list do
    local data = self.v_dbm_show_list[i]
    local item_obj = self:get_auto_cache(FIGHT_DBM_ITEM_KEY)
    local content_com = Util.get_text("Content", item_obj)
    local content_rect = Util.get_rect_transform("Content", item_obj)
    local dbm_img = Util.get_image(nil, item_obj)
    local dbm_rect = Util.get_rect_transform(nil, item_obj)
    local icon_img = Util.get_image("Icon", item_obj)
    local content = data.Text
    local idx = tonumber(data.BGColor)
    local bg_color = bg_color_list[idx]
    content_com.text = util_format(content)
    local preferredWidth = content_com.preferredWidth
    content_rect:SetSizeDeltaWidthA(preferredWidth)
    if data.BGTexture then
      ResMgr:load_set_icon(dbm_img, data.BGTexture)
      dbm_rect:SetSizeDeltaA(dbm_img.preferredWidth, dbm_img.preferredHeight)
    else
      ResMgr:load_set_icon(dbm_img, DEFAULT_BG)
      local width = self.v_parent_ui:get_rect_sizedelta()
      dbm_rect:SetSizeDeltaA(width, DEFAULT_HEIGHT)
    end
    if data.Icon then
      icon_img.gameObject:SetActive(true)
      ResMgr:load_set_icon(icon_img, data.Icon)
      local icon_rect = Util.get_rect_transform("Icon", item_obj)
      icon_rect:SetSizeDeltaA(icon_img.preferredWidth, icon_img.preferredHeight)
      local icon_color = data.IconColor or DEFAULT_COLOR
      Util.set_color(icon_img, icon_color)
    else
      icon_img.gameObject:SetActive(false)
    end
    dbm_img.color = bg_color
    if i == #self.v_dbm_show_list then
      local canvas_group = Util.get_canvas_group(nil, item_obj).component
      if is_need_show_tween then
        canvas_group.alpha = 0
        if self.v_Sequence then
          self.v_Sequence:Kill()
        end
        self.v_Sequence = Util.create_sequence()
        self.v_Sequence:SetUpdate(true)
        self.v_Sequence:Append(canvas_group:DOFade(1, 0.5))
        self.v_dbm_show_list[i].canvas_group = canvas_group
      else
        canvas_group.alpha = 1
      end
    end
  end
end

return ui
