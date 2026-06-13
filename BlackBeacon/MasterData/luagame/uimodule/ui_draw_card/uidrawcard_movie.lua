local BagCfg = require("gamelogic.character.fight_bag_configs")
local Char_Helper = require("uimodule.character.char_helper")
local Quat = require("base.quat")
local _tinsert = table.insert
local Cs_color = UnityEngine.Color
local TWEEN_EASE_OUT_EXPO = CS.DG.Tweening.Ease.OutExpo
local WHITE = Cs_color.white
local BLACK = Cs_color.black
local MovieStateType = {Step1 = 1, Step2 = 2}
local TYPE_TO_OBJ = {
  [Config.AWARD_TYPE.CHARA] = {
    obj = "v_chara_obj",
    info = "v_chara_info_obj",
    info_func = "_refresh_chara_info"
  },
  [Config.AWARD_TYPE.EQUIP] = {
    obj = "v_weapon_obj",
    info = "v_weapon_info_obj",
    info_func = "_refresh_weapon_info"
  },
  [Config.AWARD_TYPE.ITEM] = {
    obj = "v_item_obj",
    info = "v_item_info_obj",
    info_func = "_refresh_item_info"
  }
}
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_bg1 = {
    "BG1",
    BIND_TYPE.BUTTON
  },
  v_bg2 = {
    "BG2",
    BIND_TYPE.BUTTON
  },
  v_btn_skip = {
    "BtnSkip",
    BIND_TYPE.BUTTON
  },
  v_chara_info_obj = {
    "CharaInfoObj",
    BIND_TYPE.OBJECT
  },
  v_chara_obj = {
    "CharaObj",
    BIND_TYPE.OBJECT
  },
  v_extra_reward = {
    "ExtraReward",
    BIND_TYPE.OBJECT
  },
  v_item_info_obj = {
    "ItemInfoObj",
    BIND_TYPE.OBJECT
  },
  v_item_obj = {
    "ItemObj",
    BIND_TYPE.OBJECT
  },
  v_weapon_info_obj = {
    "WeaponInfoObj",
    BIND_TYPE.OBJECT
  },
  v_weapon_obj = {
    "WeaponObj",
    BIND_TYPE.OBJECT
  },
  v_quality_eff_3 = {
    "Ani_VX_UIDrawCard_Movie_Blue",
    BIND_TYPE.OBJECT
  },
  v_quality_eff_4 = {
    "Ani_VX_UIDrawCard_Movie_Pur",
    BIND_TYPE.OBJECT
  },
  v_quality_eff_5 = {
    "Ani_VX_UIDrawCard_Movie_Glod",
    BIND_TYPE.OBJECT
  }
}
local CHARACTER_CONFIG = require("uimodule.character.character_config")

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BG1", function()
    self:_enter_movie_step_2()
  end)
  self:set_button("BG2", function()
    self:_try_play_next_item()
  end)
  self:set_button("BtnSkip", function()
    if self.v_is_multi then
      self:_do_finish()
    elseif self.v_step_state == MovieStateType.Step1 then
      self:_enter_movie_step_2()
    elseif self.v_is_can_skip_now then
      self:_do_finish()
    end
  end)
end

function ui:ui_on_show(data_list, hide_cb)
  assert(data_list)
  local cnt = #data_list
  assert(cnt > 0, "data is empty")
  self.v_data_list = data_list
  self.v_hide_cb = hide_cb
  self.v_cur_play_index = 0
  self.v_is_multi = cnt > 1
  self.v_sequence_list = {}
  self.v_step_state = nil
  self.v_btn_skip.gameObject:SetActive(self.v_is_multi)
  self:_try_play_next_item()
end

function ui:ui_after_show()
  UIMgr:try_hide_ui("award_show_panel")
end

function ui:ui_on_hide()
  self.v_data_list = nil
  self:_clear_sequence(false)
  if self.v_hide_cb then
    self.v_hide_cb()
  end
end

function ui:_clear_sequence(is_complete)
  if nil == is_complete then
    is_complete = true
  end
  for _, se in ipairs(self.v_sequence_list) do
    if se then
      se:Kill(is_complete)
    end
  end
  self.v_sequence_list = {}
end

function ui:_do_finish()
  if self.v_is_multi then
    UIMgr:get_ui("uidrawcard_multi_rlt"):ui_show(self.v_data_list)
  else
    self:ui_hide()
  end
end

function ui:_try_play_next_item()
  if #self.v_data_list <= self.v_cur_play_index then
    self:_do_finish()
    return
  end
  self.v_cur_play_index = self.v_cur_play_index + 1
  self.v_cur_vo = self.v_data_list[self.v_cur_play_index]
  self:_enter_movie_step_1()
end

function ui:_enter_movie_step_1()
  if self.v_step_state == MovieStateType.Step1 then
    return
  end
  self.v_step_state = MovieStateType.Step1
  self:_clear_sequence()
  local type_config = Util.get_item_type_cfg(self.v_cur_vo.item_id)
  local item_type = type_config.AwardType
  local item_id = self.v_cur_vo.item_id
  local is_new = self.v_cur_vo.is_new
  self.v_bg1.gameObject:SetActiveEx(true)
  self.v_bg2.gameObject:SetActiveEx(false)
  self.v_extra_reward:SetActiveEx(false)
  local quality = UtilUI.get_item_qulity(item_id)
  local qulity_config = ShareRes.get_drawcard_anim_res(quality)
  ResMgr:load_set_icon(self:get_image(nil, self.v_bg1.transform), qulity_config.Bg[1], nil, true, self)
  ResMgr:load_set_icon(self:get_image(nil, self.v_bg2.transform), qulity_config.Bg[2], nil, true, self)
  self.v_quality_eff_3:SetActive(false)
  self.v_quality_eff_4:SetActive(false)
  self.v_quality_eff_5:SetActive(false)
  local eff_obj = self["v_quality_eff_" .. quality]
  if eff_obj then
    eff_obj:SetActive(true)
  end
  self.v_cur_obj = nil
  self.v_cur_info_obj = nil
  self.v_cur_icon = nil
  local anim_scale_obj
  for type, objs in pairs(TYPE_TO_OBJ) do
    if type == item_type then
      self.v_cur_obj = self[objs.obj]
      self.v_cur_info_obj = self[objs.info]
      self.v_cur_obj:SetActiveEx(true)
      self.v_cur_info_obj:SetActiveEx(false)
      anim_scale_obj = self:get_child_gameobj("AnimScale", self.v_cur_obj)
      self.v_cur_icon = self:get_image("Icon", anim_scale_obj)
      self:_refresh_big_icon(self.v_cur_icon, item_type, item_id, false)
      self[objs.info_func](self, self.v_cur_info_obj.transform, item_id, is_new)
    else
      self[objs.obj]:SetActiveEx(false)
      self[objs.info]:SetActiveEx(false)
    end
  end
  self.v_cur_icon.color = BLACK
  anim_scale_obj.transform:SetLocalScaleA(3, 3, 1)
  local sequence = Util.create_sequence()
  sequence:Append(anim_scale_obj.transform:DOScale(1, 1):SetEase(TWEEN_EASE_OUT_EXPO))
  sequence:AppendInterval(0.2)
  sequence:OnComplete(function()
    Util.wrap_xpcall_func(self._enter_movie_step_2, self)
  end)
  _tinsert(self.v_sequence_list, sequence)
end

function ui:_enter_movie_step_2()
  if self.v_step_state == MovieStateType.Step2 then
    return
  end
  self.v_step_state = MovieStateType.Step2
  self:_clear_sequence()
  self.v_bg1.gameObject:SetActiveEx(false)
  self.v_bg2.gameObject:SetActiveEx(true)
  self.v_bg2.interactable = false
  self.v_is_can_skip_now = self.v_is_multi
  local LOCK_TIME = 1
  local TWEEN_TIME = 0.3
  if self.v_cur_vo.has_extra then
    self.v_extra_reward:SetActiveEx(true)
    self:_refresh_extra_info()
  end
  self.v_cur_info_obj:SetActiveEx(true)
  local move_info_obj = self:get_rect_transform(nil, self.v_cur_info_obj.transform)
  local fade_obj = self:get_canvas_group(nil, self.v_cur_info_obj.transform)
  fade_obj.alpha = 0
  local pos = move_info_obj.anchoredPosition
  move_info_obj:SetAnchoredPositionA(-1170, pos.y)
  local move_extra_obj = self:get_rect_transform(nil, self.v_extra_reward.transform)
  pos = move_extra_obj.anchoredPosition
  move_extra_obj:SetAnchoredPositionA(0, pos.y)
  local extra_width = move_extra_obj.sizeDelta.x
  local sequence = Util.create_sequence()
  sequence:Append(fade_obj:DOFade(1, TWEEN_TIME):SetEase(TWEEN_EASE_OUT_EXPO))
  sequence:Join(move_info_obj:DOAnchorPosX(-280, TWEEN_TIME):SetEase(TWEEN_EASE_OUT_EXPO))
  sequence:Join(self.v_cur_icon:DOColor(WHITE, TWEEN_TIME):SetEase(TWEEN_EASE_OUT_EXPO))
  if self.v_cur_vo.has_extra then
    sequence:Join(move_extra_obj:DOAnchorPosX(-extra_width, TWEEN_TIME):SetEase(TWEEN_EASE_OUT_EXPO))
  end
  sequence:AppendInterval(LOCK_TIME - TWEEN_TIME)
  sequence:AppendCallback(function()
    if not self.v_is_multi then
      self.v_is_can_skip_now = true
    end
    self.v_bg2.interactable = true
  end)
  _tinsert(self.v_sequence_list, sequence)
  if not self.v_is_multi then
    MsgGame:mq_publish2(Const.MSG_RELEASE_COMMON_BATTLE_TIPS_HOLD_TASK)
  end
end

function ui:_refresh_big_icon(img, item_type, item_id, is_shadow)
  local function cb()
    if item_type == Config.AWARD_TYPE.ITEM then
      img.transform:SetLocalScaleA(3, 3, 1)
    elseif item_type == Config.AWARD_TYPE.CHARA then
      img.transform:SetLocalScaleA(1, 1, 1)
    else
      img.transform:SetLocalScaleA(1.6, 1.6, 1)
    end
  end
  
  if item_type == Config.AWARD_TYPE.CHARA then
    local path = UtilUI.get_hero_images(item_id, Config.HERO_ICON_LV.HD_FULL_IMG)
    ResMgr:load_set_icon(img, path, cb, true, self)
  elseif item_type == Config.AWARD_TYPE.EQUIP then
    local equip_cfg = ShareRes.get_equip(item_id)
    local path = UtilUI.get_weapon_tex(equip_cfg.Painting[2])
    local pos_rotate = equip_cfg.SinglePosRotate
    img.transform:SetLocalPositionA(pos_rotate[1], pos_rotate[2], pos_rotate[3])
    img.transform.localRotation = Quat.Euler(0, 0, pos_rotate[4])
    ResMgr:load_set_icon(img, path, cb, true)
  else
    local item_config = ShareRes.get_item_cfg(item_id)
    if item_config then
      local path = string.format("Icon/Item/%s", item_config.Icon)
      ResMgr:load_set_icon(img, path, cb)
    end
  end
end

function ui:_refresh_chara_info(obj, item_id, is_new)
  local buddy_config = ShareRes.get_buddy_cfg(item_id)
  local element_path = CharacterMgr:get_buddy_element_icon_path(item_id)
  local quality_path = Char_Helper.get_char_icon_quality(buddy_config.Id, Config.CHAR_QUALITY_TYPE.NAME)
  ResMgr:load_set_icon(self:get_image("Quality", obj), quality_path)
  self:get_text("Name", obj).text = buddy_config.Name
  ResMgr:load_set_icon(self:get_image("Attri", obj), element_path)
  self:get_child_gameobj("IsNew", obj):SetActiveEx(true == is_new)
  CharacterMgr:trigger_buddy_sound(CHARACTER_CONFIG.TRIGGER_SOUND_TYPE.GET_CHARACTER, buddy_config.Id)
end

function ui:_refresh_weapon_info(obj, item_id, is_new)
  local equip_cfg = ShareRes.get_equip(item_id)
  local quality_cfg = ShareRes.get_equip_icon_cfg(equip_cfg.Quality)
  Util.load_char_icon(self:get_image("Quality", obj), quality_cfg.QualityIcon)
  self:get_text("Name", obj).text = equip_cfg.Name
  self:get_child_gameobj("IsNew", obj):SetActiveEx(true == is_new)
end

function ui:_refresh_item_info(obj, item_id)
  local item_config = ShareRes.get_item_cfg(item_id)
  self:get_text("Name", obj).text = item_config.Name
end

function ui:_refresh_extra_info()
  local parent_tf = self.v_extra_reward.transform
  local item_config = ShareRes.get_item_cfg(self.v_cur_vo.extra_id)
  local name_txt = self:get_text("Name", parent_tf)
  name_txt.text = item_config.Name
  local num_txt = self:get_text("Num", parent_tf)
  num_txt.text = "X" .. self.v_cur_vo.extra_num
  local path = ShareRes.get_item_icon_path(self.v_cur_vo.extra_id)
  ResMgr:load_set_icon(self:get_image("Icon", parent_tf), path)
  local qulity_config = ShareRes.get_drawcard_anim_res(item_config.Quality)
  path = string.format("UIDraw/%s", qulity_config.Bg[3])
  ResMgr:load_set_icon(self:get_image("BG", parent_tf), path)
end

return ui
