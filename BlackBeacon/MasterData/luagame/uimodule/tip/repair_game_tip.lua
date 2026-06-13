local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Timer = Global.timer
local _ceil = math.ceil
local _floor = math.floor
local REAPIR_STATE = {
  NONE = 0,
  CHECK = 1,
  CHECK_END = 2,
  REPAIRING = 3,
  REPAIR_END = 4
}

function ui:ui_finish_load()
  self.v_btn_sure_text = self:get_text("Text", self.v_uiobjects.BtnSure)
  self:set_button("BtnStop", function()
    self:ui_hide()
  end)
  self:set_button("BtnCancel", function()
    self:ui_hide()
  end)
  self:set_button("BtnSure", function()
    if self.v_state == REAPIR_STATE.NONE then
      Util.show_conform_tip("是否开始进行资源检测，检测时间较长，一旦开始无法中途暂停。", nil, nil, nil, function()
        Global.repair_game:check_update()
        self:refresh_btn_state()
      end)
    else
    end
    if self.v_callback then
      self.v_is_need_update = true
      self.v_callback()
      self.v_callback = nil
    end
  end)
  self.v_btn_sure_text.text = "开始检查"
end

function ui:ui_on_show(tip)
  self.v_is_need_update = false
  self.v_uicompents.BtnSure_btn.gameObject:SetActive(false)
  self.v_uicompents.BtnCancel_btn.gameObject:SetActive(false)
  self.v_uicompents.BtnStop_btn.gameObject:SetActive(true)
  self.v_uicompents.Progress_sld.value = 0
  self.v_uicompents.ProVal_txt.text = ""
end

function ui:update_content(tip, content_size, state, callback)
  self.v_callback = callback
  self.v_state = state
  tip = Util.format_str(tip, content_size)
  self.v_uicompents.Tip_txt.text = tip
  self.v_uicompents.BtnStop_btn.gameObject:SetActive(false)
  local is_show_btn = true
  if state == REAPIR_STATE.REPAIRING then
    is_show_btn = false
  elseif state == REAPIR_STATE.REPAIR_END then
    is_show_btn = false
    self.v_uicompents.BtnStop_btn.gameObject:SetActive(true)
  end
  self.v_uicompents.BtnSure_btn.gameObject:SetActive(is_show_btn)
  self.v_uicompents.BtnCancel_btn.gameObject:SetActive(is_show_btn)
end

function ui:refresh_is_need_update(value)
  self.v_is_need_update = value
end

function ui:ui_on_hide()
end

function ui:ui_update(delta_time)
  if not self.v_is_need_update then
    return
  end
  self:update_progress()
end

local MEGABYTE = 1048576

local function format_size(size)
  if size < MEGABYTE then
    return string.format("%.2fK", size / 1024)
  else
    return string.format("%.2fM", size / MEGABYTE)
  end
end

function ui:refresh_btn_state()
  if self.v_state == REAPIR_STATE.CHECK then
    self.v_uiobjects.BtnCancel:SetActive(false)
    self.v_uiobjects.BtnSure:SetActive(false)
  else
    self.v_uiobjects.BtnCancel:SetActive(true)
    self.v_uiobjects.BtnSure:SetActive(true)
    self.v_btn_sure_text.text = "开始修正"
    self.v_uicompents.Progress_sld.value = 0
    self.v_uicompents.ProVal_txt.text = ""
  end
end

function ui:refresh_check_progress(curr_count, total_count)
  if 0 == curr_count then
    return
  end
  local pro_val = curr_count / total_count
  self.v_uicompents.Progress_sld.value = pro_val
  self.v_uicompents.ProVal_txt.text = Util.format_str("进度:{1}/{2}", curr_count, total_count)
end

function ui:update_progress(cur_val, max_val)
  if not cur_val or not max_val then
    cur_val, max_val = Global.repair_game:get_cur_download_size()
  end
  if 0 == cur_val then
    self.v_uicompents.Progress_sld.value = 0
    self.v_uicompents.ProVal_txt.text = ""
  else
    local pro_val = cur_val / max_val
    self.v_uicompents.Progress_sld.value = pro_val
    self.v_uicompents.ProVal_txt.text = format_size(cur_val) .. "/" .. format_size(max_val)
    if cur_val >= max_val then
      self.v_is_need_update = false
    end
  end
end

return ui
