local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_bless_icon = {
    "BlessingIcon",
    BIND_TYPE.IMAGE
  },
  v_bless_lv = {
    "BlessingLv",
    BIND_TYPE.TEXT
  },
  v_consume_layout = {
    "ConsumeLayout",
    BIND_TYPE.OBJECT
  },
  v_consume_icon = {
    "ConsumeIcon",
    BIND_TYPE.IMAGE
  },
  v_consume_num = {
    "ConsumeNum",
    BIND_TYPE.TEXT
  },
  v_mask = {
    "Mask",
    BIND_TYPE.OBJECT
  },
  v_lock = {
    "Lock",
    BIND_TYPE.OBJECT
  },
  v_wear = {
    "Wear",
    BIND_TYPE.OBJECT
  },
  v_can_upgrade = {
    "CanUpgrade",
    BIND_TYPE.OBJECT
  }
}
local EFFECT_NAME = {
  UNLOCK = "UnlockEffect",
  LEVEL_UP = "LvUpEffect"
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_tog = Util.get_toggle(nil, self.v_object)
  self:set_toggle_listener(self.v_tog, function(isOn)
    self:on_click_tog(isOn)
  end)
end

function ui:ui_on_show(bless_current_lv_cfg, bless_next_lv_cfg, is_wear, bless_max_lv, index, effect_state)
  self.v_bless_current_lv_cfg = bless_current_lv_cfg
  self.v_bless_next_lv_cfg = bless_next_lv_cfg
  self.v_is_wear = is_wear
  self.v_bless_max_lv = bless_max_lv
  self.v_bless_index = index
  self.v_effect_state = effect_state
  self:refresh_info()
end

function ui:ui_on_hide()
  self:close_effect()
end

function ui:close_effect()
  for key, effect_name in pairs(EFFECT_NAME) do
    self.v_uiobjects[effect_name]:SetActive(false)
  end
  if self.v_effect_timer then
    Timer:remove_timer(self.v_effect_timer)
    self.v_effect_timer = nil
  end
end

function ui:refresh_info()
  self.v_can_upgrade:SetActive(false)
  local effect_name = EFFECT_NAME[self.v_effect_state]
  if effect_name then
    self:close_effect()
    local pd = self.v_uicompents[effect_name .. "_pd"]
    pd.gameObject:SetActive(true)
    pd:Stop()
    pd:Play()
    
    local function stopped()
      self.v_effect_timer = nil
      pd:Stop()
      pd.gameObject:SetActive(false)
    end
    
    self.v_effect_timer = Timer:add_timer(nil, 0.7, stopped)
  end
  if self.v_bless_next_lv_cfg then
    if BagMgr:get_item_num(self.v_bless_next_lv_cfg.CostItem) >= self.v_bless_next_lv_cfg.CostCnt then
      self.v_consume_num.text = string.format("<color=#ffffff>%s</color>", self.v_bless_next_lv_cfg.CostCnt)
    else
      self.v_consume_num.text = string.format("<color=#ff0000>%s</color>", self.v_bless_next_lv_cfg.CostCnt)
    end
    self.v_consume_layout:SetActive(true)
    if 1 == self.v_bless_next_lv_cfg.Lv then
      ResMgr:load_set_icon(self.v_bless_icon, self.v_bless_next_lv_cfg.Icon)
      ResMgr:load_set_icon(self.v_consume_icon, UtilUI.get_item_icon(self.v_bless_next_lv_cfg.CostItem))
      self.v_bless_lv.gameObject:SetActive(false)
      self.v_mask:SetActive(true)
      self.v_lock:SetActive(true)
      self.v_wear:SetActive(false)
    else
      ResMgr:load_set_icon(self.v_bless_icon, self.v_bless_current_lv_cfg.Icon)
      ResMgr:load_set_icon(self.v_consume_icon, UtilUI.get_item_icon(self.v_bless_current_lv_cfg.CostItem))
      self.v_bless_lv.gameObject:SetActive(true)
      self.v_bless_lv.text = string.format("LV." .. self.v_bless_next_lv_cfg.Lv - 1)
      self.v_mask:SetActive(self.v_is_wear)
      self.v_lock:SetActive(false)
      self.v_wear:SetActive(self.v_is_wear)
      self.v_can_upgrade:SetActive(BagMgr:get_item_num(self.v_bless_next_lv_cfg.CostItem) >= self.v_bless_next_lv_cfg.CostCnt)
    end
  else
    ResMgr:load_set_icon(self.v_bless_icon, self.v_bless_current_lv_cfg.Icon)
    self.v_bless_lv.gameObject:SetActive(true)
    self.v_bless_lv.text = string.format("LV." .. self.v_bless_max_lv)
    self.v_mask:SetActive(self.v_is_wear)
    self.v_lock:SetActive(false)
    self.v_wear:SetActive(self.v_is_wear)
    self.v_consume_layout:SetActive(false)
  end
end

function ui:on_click_tog(isOn)
  if not isOn then
    return
  end
  self.v_parent_ui:refresh_current_select_item_info(self.v_bless_current_lv_cfg, self.v_bless_next_lv_cfg, self.v_is_wear, self.v_bless_index)
end

function ui:force_onclick()
  self.v_tog.isOn = true
  self:on_click_tog(true)
end

return ui
