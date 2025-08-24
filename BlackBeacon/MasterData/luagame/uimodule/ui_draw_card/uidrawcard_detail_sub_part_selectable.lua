local Quat = require("base.quat")
local Char_Helper = require("uimodule.character.char_helper")
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")
local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BtnChoose", function()
    self:on_click_change()
  end)
  if self.v_uicompents.BtnWeaponDetail_btn then
    self:set_button("BtnWeaponDetail", function()
      if self.v_choose_item_id then
        UIMgr:get_ui("char_weapon", true):ui_show(nil, nil, nil, self.v_choose_item_id)
      end
    end)
  end
  if self.v_uicompents.BtnCharInfo_btn then
    self:set_button("BtnCharInfo", function()
      self:on_click_major_char_btn()
    end)
  end
  for i = 1, 5 do
    if self.v_uicompents["BtnCharInfo" .. i .. "_btn"] then
      self:set_button("BtnCharInfo" .. i, function()
        self:on_click_char_btn(i)
      end)
    end
  end
end

function ui:on_click_change()
  if self.v_award_type == Config.AWARD_TYPE.EQUIP then
    UIMgr:get_ui("uidrawcard_select_panel"):ui_show(self.v_pool_id)
  elseif self.v_award_type == Config.AWARD_TYPE.CHARA then
    UIMgr:get_ui("uidrawcard_select_panel_char"):ui_show(self.v_pool_id)
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
  local pool_vo = DrawCardMgr:get_pool_vo(self.v_group_id, self.v_pool_id)
  if nil == pool_vo then
    return
  end
  local choose_id = pool_vo.choose_id
  if 0 == choose_id then
    return
  end
  local choose_cfg = ShareRes.create("draw.draw_pool_choose_group", choose_id)
  local show_buddy = choose_cfg.ItemId or 0
  if 0 ~= show_buddy then
    Player_Hero_Helper.build_fake_buddy(show_buddy)
    UIMgr:get_ui("player_hero"):ui_show()
  end
end

function ui:ui_on_show(pool_id)
  self.v_pool_config = ShareRes.get_drawcard_pool(pool_id)
  self.v_group_id = self.v_pool_config.Group
  self.v_pool_id = pool_id
  self.v_choose_group_id = self.v_pool_config.Arg[1]
  if not self.v_choose_group_id or 0 == self.v_choose_group_id then
    Log.Error("自选卡池没配自选组id,卡池id：", pool_id)
    return
  end
  local award_type = self:get_award_item_type()
  if award_type == Config.AWARD_TYPE.EQUIP then
    self:_refresh_weapon_view()
  elseif award_type == Config.AWARD_TYPE.CHARA then
    self:_refresh_char_view()
  end
  self.v_award_type = award_type
end

function ui:get_award_item_type()
  local any_item_id
  local choose_group_cfg = ShareRes.create("draw.draw_pool_choose_group")
  for _, cfg in ipairs(choose_group_cfg) do
    if self.v_choose_group_id == cfg.Group then
      any_item_id = cfg.ItemId
      break
    end
  end
  if not any_item_id then
    Log.Error("卡池未找到指定id自选组，卡池id、自选组id：", self.v_pool_id, self.v_choose_group_id)
    return
  end
  return Util.get_item_type_cfg(any_item_id).AwardType
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:_refresh_weapon_view()
  local pool_vo = DrawCardMgr:get_pool_vo(self.v_group_id, self.v_pool_id)
  if nil == pool_vo then
    return
  end
  local choose_id = pool_vo.choose_id
  self.v_uiobjects.NoChoose:SetActive(0 == choose_id)
  self.v_uiobjects.Choose:SetActive(0 ~= choose_id)
  self.v_uicompents.WeaponChangeTxt_txt.text = Util.format_str(0 == choose_id and "武器选择" or "武器更换")
  local new_item = DrawCardMgr:check_selectable_item_any_new(self.v_pool_id)
  self.v_uiobjects.WeaponChangeRed:SetActive(new_item)
  if 0 == choose_id then
    return
  end
  local choose_cfg = ShareRes.create("draw.draw_pool_choose_group", choose_id)
  local item_id = choose_cfg.ItemId
  local buddy_id = choose_cfg.BuddyId
  self.v_choose_item_id = item_id
  local img = self.v_uicompents.WeaponIconL_img
  local name_txt = self.v_uicompents.WeaponName_txt
  local char_obj = self.v_uiobjects.Char
  local equip_cfg = ShareRes.get_equip(item_id)
  local path = UtilUI.get_weapon_tex(equip_cfg.Painting[2])
  local pos_rotate = equip_cfg.SinglePosRotate
  img.transform.localRotation = Quat.Euler(0, 0, pos_rotate[4])
  ResMgr:load_set_icon(img, path, nil, true)
  name_txt.text = equip_cfg.Name
  char_obj:SetActive(nil ~= buddy_id)
  if nil ~= buddy_id then
    ResMgr:load_set_icon(self.v_uicompents.Profile_img, CharacterMgr:get_buddy_icon_path(buddy_id))
    self.v_uicompents.CharName_txt.text = ShareRes.get_buddy_name(buddy_id)
  end
  local icon_path, quality_path = UtilUI.get_item_images(item_id)
  ResMgr:load_set_icon(self.v_uicompents.WeaponIconS_img, icon_path)
  ResMgr:load_set_icon(self.v_uicompents.Quality_img, quality_path)
end

function ui:_refresh_char_view()
  local pool_vo = DrawCardMgr:get_pool_vo(self.v_group_id, self.v_pool_id)
  if nil == pool_vo then
    return
  end
  local choose_id = pool_vo.choose_id
  self.v_uiobjects.NoChoose:SetActive(0 == choose_id)
  self.v_uiobjects.Choose:SetActive(0 ~= choose_id)
  if 0 == choose_id then
    local show_buddys = self.v_pool_config.BuddyId
    for idx, buddy_id in ipairs(show_buddys) do
      local obj = self.v_uiobjects["BtnCharInfo" .. idx]
      if obj then
        obj:SetActive(0 ~= buddy_id)
        if 0 ~= buddy_id then
          self:set_show_buddy_info(obj, buddy_id)
        end
      end
    end
  else
    local choose_cfg = ShareRes.create("draw.draw_pool_choose_group", choose_id)
    self:set_show_texture(self.v_uicompents.ChooseCharIcon_img, choose_cfg.ShowIcon, choose_cfg.ShowIconOffset)
    self:set_show_buddy_info(self.v_uiobjects.BtnCharInfo, choose_cfg.ItemId)
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

function ui:set_show_texture(img_com, icon_path, offset)
  if img_com and icon_path then
    ResMgr:load_set_icon(img_com, icon_path, function(img)
      img:SetNativeSize()
    end, true)
    if offset then
      img_com.transform:SetLocalPositionA(offset[1], offset[2], offset[3])
      img_com.transform:SetLocalScaleA(offset[4], offset[4], offset[4])
    end
  end
end

return ui
