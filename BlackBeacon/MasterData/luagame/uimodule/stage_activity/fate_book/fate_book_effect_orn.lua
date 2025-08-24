local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local EFFECT_ORNAMENT_ITEM = "EFFECT_ORNAMENT_ITEM"

function ui:on_ornament_change()
  self:refresh_ornament_list()
end

function ui:on_select_ornament(ornament_id)
  if self.v_ornament_id == ornament_id then
    return
  end
  local select_go, tips
  local active_tips = false
  for id, go in pairs(self.v_ornament_obj_map) do
    select_go = self:get_child_gameobj("Select", go)
    select_go:SetActive(ornament_id == id)
    tips = self:get_child_gameobj("Tips", go)
    if not active_tips and ornament_id == id then
      active_tips = true
    end
    tips:SetActive(ornament_id == id)
  end
  self.v_uiobjects.BgButton:SetActive(active_tips)
  self.v_ornament_id = ornament_id
end

function ui:ui_finish_load()
  self.v_ornament_obj_map = {}
  self:set_button("BgButton", function()
    self:on_select_ornament()
  end)
  self:register_exist_auto_template(EFFECT_ORNAMENT_ITEM, self.v_uiobjects.EffectOrnTem, self.v_uiobjects.EffectOrnContent)
end

function ui:ui_on_show()
  self.v_uiobjects.BgButton:SetActive(false)
  self:bind_auto_mq(Const.MSG_ON_ORNAMENT_CHANGE, self.on_ornament_change, self)
end

function ui:ui_on_hide()
  self.v_ornament_id = nil
  self:give_back_auto_cache(EFFECT_ORNAMENT_ITEM)
  self.v_ornament_obj_map = {}
end

function ui:ui_on_destroy()
end

function ui:set_data(effect_ornament_list)
  self.v_effect_ornament_list = effect_ornament_list
  self:refresh_ornament_list()
end

function ui:refresh_ornament_list()
  local obj, icon, select_go, tips, tips_desc, btn, cfg
  local has_effect_orn = false
  for _, ornament_id in ipairs(self.v_effect_ornament_list) do
    if BattleOrnamentMgr:is_have_same_ornament(ornament_id) then
      obj = self.v_ornament_obj_map[ornament_id]
      if not obj then
        obj = self:get_auto_cache(EFFECT_ORNAMENT_ITEM)
        self.v_ornament_obj_map[ornament_id] = obj
      end
      cfg = ShareRes.get_ornaments(ornament_id)
      icon = self:get_image("Icon", obj)
      select_go = self:get_child_gameobj("Select", obj)
      tips = self:get_child_gameobj("Tips", obj)
      tips_desc = self:get_text("Tips/TipDesc", obj)
      btn = self:get_button(nil, obj)
      ResMgr:load_set_icon(icon, cfg.Icon)
      select_go:SetActive(self.v_ornament_id == ornament_id)
      tips:SetActive(false)
      tips_desc.text = cfg.Desc
      self:set_button_listener(btn, function()
        self:on_select_ornament(ornament_id)
      end)
      has_effect_orn = true
    end
  end
  self.v_uiobjects.Main:SetActive(has_effect_orn)
end

return ui
