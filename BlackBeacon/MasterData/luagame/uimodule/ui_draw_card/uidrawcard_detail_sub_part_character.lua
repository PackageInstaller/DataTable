local Char_Helper = require("uimodule.character.char_helper")
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  for i = 1, 5 do
    if self.v_uicompents["BtnCharInfo" .. i .. "_btn"] then
      self:set_button("BtnCharInfo" .. i, function()
        self:on_click_char_btn(i)
      end)
    end
  end
  if self.v_uicompents.BtnCharInfoMajor_btn then
    self:set_button("BtnCharInfoMajor", function()
      self:on_click_major_char_btn()
    end)
  end
  if self.v_uicompents.BtnWeaponDetail_btn then
    self:set_button("BtnWeaponDetail", function()
      self:on_click_major_weapon_btn()
    end)
  end
end

function ui:ui_on_show(pool_id)
  self:init_spine_data()
  self.v_pool_config = ShareRes.get_drawcard_pool(pool_id)
  local major_buddy_id = self.v_pool_config.MajorBuddy
  local major_buddy_icon = self.v_pool_config.MajorBuddyIcon
  local major_buddy_spine_id = self.v_pool_config.MajorBuddySpine
  local show_buddys = self.v_pool_config.BuddyId
  local type_config = major_buddy_id and ShareRes.get_award_type_cfg(major_buddy_id)
  local is_equip = major_buddy_id and type_config.AwardType == Config.AWARD_TYPE.EQUIP
  self:set_show_title(self.v_uicompents.TitleTxt_txt, self.v_pool_config.Title)
  self:set_show_texture(self.v_uicompents.Bg_img, self.v_pool_config.Bg)
  self:set_show_spine(self.v_uiobjects.MajorCharRawImg, major_buddy_spine_id, self.v_pool_config.MajorBuddyIconOffset)
  self:set_show_texture(self.v_uicompents.MajorCharIcon_img, major_buddy_icon, self.v_pool_config.MajorBuddyIconOffset)
  if self.v_uiobjects.MajorCharIcon then
    self.v_uiobjects.MajorCharIcon:SetActiveEx(not major_buddy_spine_id and nil ~= major_buddy_icon)
  end
  local char_info_root = self.v_uiobjects.CharInfoRoot
  if char_info_root then
    char_info_root:SetActiveEx(nil == major_buddy_id)
  end
  local major_info_obj = self.v_uiobjects.BtnCharInfoMajor
  if major_info_obj then
    major_info_obj:SetActiveEx(nil ~= major_buddy_id and not is_equip)
  end
  local weapon_major_info_obj = self.v_uiobjects.WeaponInfoMajor
  if weapon_major_info_obj then
    weapon_major_info_obj:SetActiveEx(is_equip)
  end
  if is_equip then
    if weapon_major_info_obj then
      self:set_show_weapon_info(weapon_major_info_obj, major_buddy_id)
    end
    return
  end
  if major_buddy_id and not is_equip then
    if major_info_obj then
      self:set_show_buddy_info(major_info_obj, major_buddy_id, self.v_pool_config.MajorBuddyInfoOffset)
    end
    return
  end
  for idx, buddy_id in ipairs(show_buddys) do
    local obj = self.v_uiobjects["BtnCharInfo" .. idx]
    if obj then
      obj:SetActive(0 ~= buddy_id)
      if 0 ~= buddy_id then
        self:set_show_buddy_info(obj, buddy_id)
      end
    end
  end
end

function ui:set_show_buddy_info(obj, buddy_id, offset)
  if not obj then
    return
  end
  local element_icon = Util.get_image("Ele_", obj)
  local name_txt = Util.get_text("Name_", obj)
  local quality = ShareRes.get_buddy_cfg(buddy_id).Quality
  for index = 1, 5 do
    local star_obj = Util.get_child_gameobj("QualityStarLayout_/QualityStar" .. index, obj)
    if star_obj then
      star_obj:SetActive(index <= quality)
    end
  end
  local element_icon_path = Char_Helper.get_char_element_icon(buddy_id)
  ResMgr:load_set_icon(element_icon, element_icon_path)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  name_txt.text = buddy_cfg.Name
  if offset then
    obj.transform:SetLocalPositionA(offset[1], offset[2], offset[3])
  end
end

function ui:set_show_weapon_info(obj, item_id)
  if not obj then
    return
  end
  local equip_cfg = ShareRes.get_equip(item_id)
  self.v_uicompents.WeaponName_txt.text = equip_cfg.Name
  self.v_uicompents.WeaponCharName_txt.text = ShareRes.get_buddy_name(equip_cfg.BuddyID)
  ResMgr:load_set_icon(self.v_uicompents.WeaponCharProfile_img, CharacterMgr:get_buddy_icon_path(equip_cfg.BuddyID))
end

function ui:set_show_texture(img_com, bg_path, offset)
  if img_com and bg_path then
    ResMgr:load_set_icon(img_com, bg_path, function(img)
      img:SetNativeSize()
    end, true)
    if offset then
      img_com.transform:SetLocalPositionA(offset[1], offset[2], offset[3])
      img_com.transform:SetLocalScaleA(offset[4], offset[4], offset[4])
    end
  end
end

function ui:set_show_spine(rimg_obj, spine_id, offset)
  if rimg_obj then
    rimg_obj:SetActiveEx(nil ~= spine_id)
  elseif spine_id then
    Log.Error("【抽卡界面Spine显示错误】配置了MajorBuddySpine但是预制无MajorCharRawImg节点，卡池：", self.v_pool_config.Id)
  end
  if rimg_obj and spine_id then
    self.v_spine_id = spine_id
    self:clear_spine_rt()
    self.v_anim_interval = SpineHelper.get_anim_interval(spine_id)
    self.v_single_anim_delay = SpineHelper.get_single_anim_delay(self.v_spine_id)
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, rimg_obj)
    SpineHelper.load_char_spine_res(self.v_spine_rt, spine_id, rimg_obj)
    if offset then
      rimg_obj.transform:SetLocalPositionA(offset[1], offset[2], offset[3])
      rimg_obj.transform:SetLocalScaleA(offset[4], offset[4], offset[4])
    end
  else
    self.v_spine_id = nil
  end
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:set_show_title(txt_com, txt_str)
  if txt_com and txt_str then
    txt_com.text = txt_str
  end
end

function ui:on_click_char_btn(idx)
  local show_buddy = self.v_pool_config.BuddyId[idx] or 0
  if 0 ~= show_buddy then
    Player_Hero_Helper.build_fake_buddy(show_buddy)
    UIMgr:get_ui("player_hero"):ui_show()
  end
end

function ui:on_click_major_char_btn()
  local major_buddy = self.v_pool_config.MajorBuddy
  if major_buddy then
    Player_Hero_Helper.build_fake_buddy(major_buddy)
    UIMgr:get_ui("player_hero"):ui_show()
  end
end

function ui:on_click_major_weapon_btn()
  local weapon_id = self.v_pool_config.MajorBuddy
  if weapon_id then
    UIMgr:get_ui("char_weapon", true):ui_show(nil, nil, nil, weapon_id)
  end
end

function ui:ui_on_hide()
  self:clear_spine_rt()
end

function ui:ui_on_destroy()
  self:clear_spine_rt()
end

function ui:init_spine_data()
  self.v_spine_id = nil
  self.v_low_update = Global.real_time
  self.v_start_time = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
end

function ui:ui_on_update()
  if not self.v_spine_id then
    return
  end
  if Global.real_time - self.v_low_update < SpineHelper.UPDATE_TIME then
    return
  end
  self.v_low_update = Global.real_time
  if self.v_anim_data.record_data.play_end then
    self.v_start_time = self.v_start_time or Global.real_time
    if self.v_anim_interval and Global.real_time - self.v_start_time > self.v_anim_interval then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.INTERVAL)
    elseif self.v_single_anim_delay and Global.real_time - self.v_start_time > self.v_single_anim_delay then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.SINGLE)
      self.v_single_anim_delay = nil
    end
  else
    self.v_start_time = Global.real_time
  end
  SpineHelper.check_play_anim(self.v_spine_rt, self.v_anim_data)
end

return ui
