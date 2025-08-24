local Base = require("ui.uibase")
local _tinsert = table.insert
local _tremove = table.remove
local Vec3 = require("base.vec3")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_block_panel = {
    "BlockPanel",
    BIND_TYPE.OBJECT
  },
  v_waiting_img = {
    "WaitingImg",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_info_list = {}
  self.v_block_panel:SetActiveEx(false)
  self.v_uiobjects.Block:SetActive(false)
end

function ui:ui_on_hide()
  self.v_block_panel:SetActiveEx(false)
  self.v_uiobjects.Block:SetActive(false)
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  self:_remove_delay_timer()
  self.v_info_list = {}
end

function ui:ui_on_update()
  local tmp_changed = false
  local tmp_time = Global.real_time
  for i = #self.v_info_list, 1, -1 do
    local tmp_info = self.v_info_list[i]
    if tmp_time >= tmp_info.end_time then
      if tmp_info.timeout_tips then
        Util.show_message_tip("网络不佳")
      end
      _tremove(self.v_info_list, i)
      tmp_changed = true
    end
  end
  if tmp_changed then
    self:_check_list()
  end
end

function ui:_remove_delay_timer()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
end

function ui:_check_list()
  if #self.v_info_list <= 0 then
    self:ui_hide()
    return
  end
  if not self:visible() then
    self:ui_show()
  end
  self:_check_delay()
end

function ui:_check_delay()
  if self.v_block_panel.activeSelf then
    return
  end
  local delay_show = true
  local delay_time
  local block_click = false
  for _, v in ipairs(self.v_info_list) do
    delay_show = v.delay_show_mask and delay_show
    if delay_show and v.delay_time then
      if not delay_time then
        delay_time = v.delay_time
      else
        delay_time = delay_time > v.delay_time and v.delay_time or delay_time
      end
    end
    block_click = block_click or v.need_block_click
  end
  delay_time = delay_time or 2
  self.v_uiobjects.Block:SetActive(block_click)
  if delay_show then
    if self.v_timer ~= nil then
      return
    end
    self.v_block_panel:SetActiveEx(false)
    self:_remove_delay_timer()
    self.v_timer = Timer:add_timer("ui_waiting_for_block_msg", delay_time, self._show_rotate_anim, self)
  else
    self:_remove_delay_timer()
    self:_show_rotate_anim()
  end
end

function ui:_show_rotate_anim()
  self.v_block_panel:SetActiveEx(true)
  self.v_uiobjects.Block:SetActive(true)
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  self.v_sequence = Util.create_sequence()
  self.v_sequence:Append(self.v_waiting_img.transform:DOLocalRotate(Vec3.New(0, 0, -252000), 600))
end

function ui:add_info(tag, end_time, delay_show_mask, delay_time, timeout_tips, need_block_click)
  _tinsert(self.v_info_list, {
    end_time = end_time,
    tag = tag,
    delay_show_mask = delay_show_mask,
    delay_time = delay_time,
    timeout_tips = timeout_tips,
    need_block_click = need_block_click
  })
  self:_check_list()
end

function ui:remove_info(tag)
  local len = #self.v_info_list
  local info
  local changed = false
  for i = len, 1, -1 do
    info = self.v_info_list[i]
    if info.tag == tag then
      _tremove(self.v_info_list, i)
      changed = true
    end
  end
  if changed then
    self:_check_list()
  end
end

return ui
