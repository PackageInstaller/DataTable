local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)
local ICON_PATH = "Icon/BattleRune/%s"
local COLOR_1 = tonumber("f0ebe4", 16)
local COLOR_2 = tonumber("ffffff", 16)
local COLOR_3 = tonumber("c3beb6", 16)
local _floor = math.floor

function M:ui_finish_load()
  self.v_rune_list = {}
  for i = 1, 4 do
    self.v_rune_list[i] = self.v_uiobjects["AttrItem" .. i]
  end
  self.v_color1 = Util.get_unity_color_by_hex(COLOR_1)
  self.v_color2 = Util.get_unity_color_by_hex(COLOR_2)
  self.v_color3 = Util.get_unity_color_by_hex(COLOR_3)
end

function M:ui_on_show(hero, ...)
  self.v_rune_cfg = ShareRes.create("battle.battle_rune")
  self:_set_rune_info()
  self:_regist_client_event()
end

function M:ui_on_hide()
end

function M:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DIAMOND_UPDATE, self.response_bag_update_event, self)
end

function M:response_bag_update_event(msg)
  self:_set_rune_info()
end

function M:_set_rune_info()
  for i, v in ipairs(self.v_rune_cfg) do
    local obj = self.v_rune_list[i]
    self:_set_data(obj, v)
  end
end

function M:_set_data(obj, data)
  local level = self:get_text("Level", obj)
  local num_color = self.v_color3
  if cur_lv > 0 then
    num_color = self.v_color2
  end
  level.color = num_color
  level.text = cur_lv
  local icon = self:get_image("Icon", obj)
  ResMgr:load_set_icon(icon, string.format(ICON_PATH, data.Icon))
  local name = self:get_text("Name", obj)
  name.text = data.Name
  local slider = self:get_slider("Slider", obj)
  local lvCfg = ShareRes.create("battle.battle_rune_level_by_parent", data.Id)
  local max_lv = #lvCfg
  local total_exp = max_lv > cur_lv and lvCfg[cur_lv + 1].Exp or lvCfg[cur_lv].Exp
  slider.value = cur_exp / total_exp
  local now_exp_txt = self:get_text("Nowexp", obj)
  local total_exp_txt = self:get_text("Totalexp", obj)
  now_exp_txt.text = cur_exp
  local percent = _floor(cur_exp * 100 / total_exp)
  total_exp_txt.text = Util.format_str("{1}%", percent)
  local btn = self:get_button("Icon", obj)
  self:set_button_listener(btn, function()
    UIMgr:get_ui("rune_tips"):ui_show(data.Id)
  end)
end

return M
