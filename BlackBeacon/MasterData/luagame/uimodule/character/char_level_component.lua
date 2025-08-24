local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local Char_Helper = require("uimodule.character.char_helper")
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_exp_max = {
    "ExpMax",
    BIND_TYPE.TEXT
  },
  v_exp_now = {
    "ExpNow",
    BIND_TYPE.TEXT
  },
  v_exp_silder = {
    "Exp_Silder",
    BIND_TYPE.IMAGE
  },
  v_lv_max = {
    "LvMax",
    BIND_TYPE.TEXT
  },
  v_lv_now = {
    "LvNow",
    BIND_TYPE.TEXT
  },
  v_star1 = {
    "Star1",
    BIND_TYPE.IMAGE
  },
  v_star2 = {
    "Star2",
    BIND_TYPE.IMAGE
  },
  v_star3 = {
    "Star3",
    BIND_TYPE.IMAGE
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  if self.v_uiobjects.RedLevel then
    RedPointMgr:bind_redpoint(self, self.v_uiobjects.RedLevel, RedEnum.CHAR_LEVEL)
  end
  self:set_button("BtnCharBreakPre", function()
    local data = {
      buddy_id = self.v_buddy_id,
      type = 1,
      fixed_data = self.v_buddy_data,
      hide_reward = self.v_hide_preview_reward,
      hide_own_res = self.v_is_other_player
    }
    UIMgr:get_ui("break_preview"):ui_show(data)
  end)
  self.v_element = self.v_uiobjects.Element
  self.v_max_star_count = self.v_uiobjects.StarLayout.transform.childCount
end

function ui:ui_on_hide()
  self.v_buddy_data = nil
end

function ui:refresh_level_ui(buddy_idx, buddy_info, is_other_player, is_fake)
  self.v_buddy_data = buddy_info
  self.v_buddy_id = buddy_info.id
  self.v_is_other_player = true == is_other_player
  if is_fake then
    self.v_hide_preview_reward = true
    local hide_preview_btn = 0 == ShareRes.get_comm_value("DrawcardPreviewShowBreakBtn")
    self.v_uiobjects.BtnCharBreakPre:SetActive(not hide_preview_btn)
  else
    self.v_uiobjects.BtnCharBreakPre:SetActive(true)
  end
  self:refresh_level_info(buddy_idx, buddy_info, is_other_player)
  self:refresh_buddy_star_info(buddy_info)
  self:refresh_buddy_element(buddy_info)
end

function ui:refresh_level_info(buddy_idx, buddy_info, is_other_player)
  local exp, max_exp
  if is_other_player then
    exp, max_exp = Player_Hero_Helper.get_hero_exp_info()
  else
    exp, max_exp = CharacterMgr:get_character_exp_info(buddy_info.id)
  end
  local buddy_next_break_cfg = ShareRes.create("buddy.buddy_break", buddy_info.id)[buddy_info.break_lv + 1]
  local max_level = ShareRes.get_buddy_max_level(buddy_info.break_lv)
  local now_level = buddy_info.lv
  if not buddy_next_break_cfg and max_level <= now_level then
    exp = max_exp
  end
  self.v_lv_now.text = now_level
  self.v_lv_max.text = max_level
  self.v_exp_now.text = exp
  self.v_exp_max.text = max_exp
  self.v_exp_silder.fillAmount = exp / max_exp
  if now_level == max_level then
    self.v_exp_now.text = "-"
    self.v_exp_max.text = "-"
    self.v_exp_silder.fillAmount = 1
  end
end

function ui:refresh_buddy_star_info(buddy_info)
  local break_lv = buddy_info.break_lv
  break_lv = break_lv - 1
  local max_break_lv = ShareRes.get_role_max_break_lv(buddy_info.id)
  for i = 1, self.v_max_star_count do
    local star_obj = self.v_uiobjects["Star" .. i]
    if i <= max_break_lv then
      local lightup = Util.get_child_gameobj("Lightup", star_obj)
      lightup:SetActive(i <= break_lv)
      star_obj:SetActive(true)
    else
      star_obj:SetActive(false)
    end
  end
end

function ui:refresh_buddy_element(buddy_info)
  if not self.v_element then
    return
  end
  local buddy_id = buddy_info.id
  local element_icon = Char_Helper.get_char_element_icon(buddy_id)
  ResMgr:load_set_icon(self.v_element, element_icon)
end

return ui
