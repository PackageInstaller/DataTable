local Base = require("ui.uiobject")
local FightDefine = require("cs_share.fight_define")
local ui = Util.create_child_mt(Base)
local _tinsert = table.insert
local _tremove = table.remove
local MAX_COUNT = 3
local ATTR_OBJ_TEMP = "fight_attr_change"
local STAY_TIME = 1
local NEXT_INDEX_TIME = 1
local FADE_ING_TIME = 0.2
local FADE_OUT_TIME = 0.2
local NO_FIGHT_ATTR_TYPE_MAP = FightDefine.NO_FIGHT_ATTR_TYPE_MAP

function ui:ui_finish_load()
  self.v_obj_cur_attr_list = {}
  self.v_obj_cache_attr_list = {}
  self.v_attr_fifo = require("utils.util_fifo"):new()
  self.v_attr_type_cfg = ShareRes.create("equip.attr_type")
  self:register_exist_auto_template(ATTR_OBJ_TEMP, self.v_uiobjects.ChangeTem, self.v_uiobjects.Queue)
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_SCREEN_UI_SHOW, self.on_uimgr_fullscreen, self)
end

function ui:ui_on_hide()
  for k, v in pairs(self.v_obj_cur_attr_list) do
    if v.start_seq then
      v.start_seq:Kill(false)
    end
    if v.next_seq then
      v.next_seq:Kill(false)
    end
    if v.end_seq then
      v.end_seq:Kill(false)
    end
  end
  self.v_obj_cur_attr_list = {}
  if next(self.v_obj_cache_attr_list) then
    self:give_back_auto_cache(ATTR_OBJ_TEMP, false)
    self.v_obj_cache_attr_list = {}
  end
end

function ui:get_attr_obj()
  local cache_count = #self.v_obj_cache_attr_list
  if 0 == cache_count then
    return self:get_auto_cache(ATTR_OBJ_TEMP)
  else
    local obj = self.v_obj_cache_attr_list[cache_count]
    _tremove(self.v_obj_cache_attr_list, cache_count)
    return obj
  end
end

function ui:push_attr_obj(obj)
  obj:SetActive(false)
  _tinsert(self.v_obj_cache_attr_list, obj)
end

function ui:change_attr(attr_type, change_val)
  change_val = math.ceil(change_val)
  if 0 == change_val then
    return
  end
  if NO_FIGHT_ATTR_TYPE_MAP[attr_type] then
    return
  end
  if #self.v_obj_cur_attr_list < MAX_COUNT and not UIMgr:has_opening_fullscreen_ui() then
    self:play_animation_start(attr_type, change_val)
  else
    self.v_attr_fifo:push({attr_type = attr_type, change_val = change_val})
  end
end

function ui:on_uimgr_fullscreen(msg)
  if msg.mm_x then
    return
  end
  local count = #self.v_obj_cur_attr_list
  local add = MAX_COUNT - count
  for i = 1, add do
    local next_obj_info = self.v_attr_fifo:pop()
    if not next_obj_info then
      break
    end
    self:play_animation_start(next_obj_info.attr_type, next_obj_info.change_val)
  end
end

function ui:get_index_pos(index)
  return 25 + (index - 1) * 55
end

function ui:play_animation_start(attr_type, change_val)
  local count = #self.v_obj_cur_attr_list + 1
  if count > MAX_COUNT then
    return
  end
  self:play_animation_next()
  local obj = self:get_attr_obj()
  obj:SetActive(true)
  local transform = obj.transform
  local obj_rect = self:get_rect_transform(nil, transform)
  local attr_name_txt = self:get_text("ChangeName", transform)
  local attr_change_val_txt = self:get_text("ChangData", transform)
  local icon_up_img = self:get_image("IconUp", transform)
  local icon_down_img = self:get_image("IconDown", transform)
  local attr_name = self.v_attr_type_cfg[attr_type].Name
  attr_name_txt.text = attr_name
  attr_change_val_txt.text = change_val
  local add_value = change_val > 0
  icon_up_img:SetActive(add_value)
  icon_down_img:SetActive(not add_value)
  obj_rect:SetAnchoredPositionA(0, 0)
  local alpha_target = obj:GetComponent("CanvasGroup")
  alpha_target.alpha = 0
  local start_seq = Util.create_sequence()
  start_seq:AppendInterval(0.05)
  start_seq:AppendCallback(function()
    obj:SetActive(false)
    obj:SetActive(true)
  end)
  start_seq:Append(alpha_target:DOFade(1, FADE_ING_TIME))
  start_seq:AppendInterval(STAY_TIME)
  start_seq:OnComplete(function()
    self:play_animation_end()
    start_seq:Kill(false)
    start_seq = nil
  end)
  _tinsert(self.v_obj_cur_attr_list, 1, {
    obj = obj,
    index = 1,
    start_seq = start_seq
  })
end

function ui:play_animation_next()
  for k, v in ipairs(self.v_obj_cur_attr_list) do
    v.index = v.index + 1
    local pos_y = self:get_index_pos(v.index)
    if v.next_seq then
      v.next_seq:Kill(false)
      v.next_seq = nil
    end
    local next_seq = Util.create_sequence()
    v.next_seq = next_seq
    next_seq:Append(v.obj.transform:DOLocalMoveY(pos_y, 0.1))
    next_seq:OnComplete(function()
      next_seq:Kill(false)
      next_seq = nil
    end)
  end
end

function ui:play_animation_end()
  local count = #self.v_obj_cur_attr_list
  if 0 == count then
    return
  end
  local obj_info = self.v_obj_cur_attr_list[count]
  self.v_obj_cur_attr_list[count] = nil
  local start_seq = obj_info.start_seq
  if start_seq then
    start_seq:Kill(false)
    obj_info.start_seq = nil
  end
  local next_seq = obj_info.next_seq
  if next_seq then
    next_seq:Kill(false)
    obj_info.next_seq = nil
  end
  local alpha_target = obj_info.obj:GetComponent("CanvasGroup")
  local end_seq = Util.create_sequence()
  obj_info.end_seq = end_seq
  end_seq:Append(alpha_target:DOFade(0, FADE_OUT_TIME))
  end_seq:OnComplete(function()
    if self:is_destroy() then
      return
    end
    end_seq:Kill(false)
    end_seq = nil
    local next_obj_info = self.v_attr_fifo:pop()
    if next_obj_info then
      self:play_animation_start(next_obj_info.attr_type, next_obj_info.change_val)
    end
  end)
  self:push_attr_obj(obj_info.obj)
end

return ui
