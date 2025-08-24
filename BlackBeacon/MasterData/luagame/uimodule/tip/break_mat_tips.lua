local Base = require("ui.uibase")
local _clamp = require("base.mathx").Clamp
local ui = Util.create_child_mt(Base)
local TEMPLATE_KEY = {STAR_ITEM = "STAR_ITEM", MAT_ITEM = "MAT_ITEM"}

function ui:ui_finish_load()
  self:set_button("Return", function()
    self:ui_hide()
  end)
  self.v_lv_desc = self:get_text(nil, self.v_uiobjects.Lv_need)
  self.v_cost_icon = self:get_image(nil, self.v_uiobjects.CostIcon)
  self.v_cost_num = self:get_text(nil, self.v_uiobjects.CostAmount)
  self:register_exist_auto_template(TEMPLATE_KEY.STAR_ITEM, self.v_uiobjects.StarTemp, self.v_uiobjects.StarList)
  self:register_exist_auto_template(TEMPLATE_KEY.MAT_ITEM, self.v_uiobjects.ItemTem, self.v_uiobjects.ItemList)
end

function ui:ui_on_show(data, ...)
  self.v_item_id = data
  self.v_item_cfg = ShareRes.get_item_cfg(self.v_item_id)
  self:_refresh_view()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:_refresh_view()
  ResMgr:load_set_icon(self.v_cost_icon, UtilUI.get_item_icon(Config.COIN_ITEMID))
  self:_refresh_star_list()
end

function ui:_refresh_star_list()
  local hero_id = self.v_item_cfg.Arg[1]
  self.v_buddy_cfg = ShareRes.create("buddy.buddy_break", hero_id)
  if self.v_buddy_cfg == nil then
    Log.Error("获取角色突破配置失败，buddy_id=", hero_id)
    return
  end
  local buddy_info = CharacterMgr:get_buddy_by_id(hero_id)
  self.v_break_lv = buddy_info.break_lv
  local is_max_lv = #self.v_buddy_cfg + 1 == self.v_break_lv
  local default_idx = 1
  if 1 == self.v_break_lv then
    default_idx = 1
  elseif self.v_break_lv == #self.v_buddy_cfg + 1 then
    default_idx = #self.v_buddy_cfg
  else
    default_idx = self.v_break_lv - 1
  end
  self.v_star_list = {}
  self:give_back_auto_cache(TEMPLATE_KEY.STAR_ITEM)
  for i = 1, #self.v_buddy_cfg - 1 do
    local show = i <= self.v_break_lv - 1
    local obj = self:get_auto_cache(TEMPLATE_KEY.STAR_ITEM)
    obj.name = "StarTemp_" .. i
    local light = self:get_child_gameobj("Light", obj)
    light:SetActiveEx(show)
    local tog = self:get_button(nil, obj)
    local checkobj = self:get_child_gameobj("Line", obj)
    self.v_star_list[i] = {btn = tog, checkobj = checkobj}
    Global.listener_mgr:add_listener(self.v_object, tog.onClick, function()
      self:_onclick_star_tog(i, isOn)
    end)
    checkobj:SetActiveEx(i == default_idx)
    if i == default_idx then
      self:_onclick_star_tog(i, true)
    end
  end
end

function ui:_refresh_mat_list(index)
  self:give_back_auto_cache(TEMPLATE_KEY.MAT_ITEM, false)
  local cfg = self.v_buddy_cfg[index]
  for k, v in pairs(cfg.Item) do
    if 0 ~= v then
      local obj = self:get_auto_cache(TEMPLATE_KEY.MAT_ITEM)
      self:_set_data(obj, k, cfg)
    end
  end
  local has = CharacterMgr:get_coin()
  self.v_cost_num.text = has >= cfg.Coin and cfg.Coin or string.format("<color=red>%d</color>", cfg.Coin)
end

function ui:_set_data(obj, index, data)
  local icon = self:get_image("Item_icon", obj)
  ResMgr:load_set_icon(icon, UtilUI.get_item_icon(data.Item[index]))
  local quality = self:get_image("Pz", obj)
  ResMgr:load_set_icon(quality, UtilUI.get_item_quality_icon(data.Item[index]))
  local cost_text = self:get_text("Amount/Amount_need", obj)
  cost_text.text = data.ItemCount[index]
  local has_text = self:get_text("Amount/Amount_have", obj)
  local has_num = BagMgr:get_item_num(data.Item[index])
  has_text.text = has_num >= data.ItemCount[index] and has_num or string.format("<color=red>%d</color>", has_num)
  local btn = self:get_button(nil, obj)
  Global.listener_mgr:add_listener(self.v_object, btn.onClick, function()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = data.Item[index]
    })
  end)
end

function ui:_refresh_break_desc(index)
  local cfg = self.v_buddy_cfg[index]
  if self.v_break_lv >= index + 1 then
    self.v_lv_desc.text = Util.format_str("已突破")
  else
    local star = 0 == index - 1 and 1 or index - 1
    local lv_cfg = ShareRes.create("buddy.buddy_level", star)
    local lv = #lv_cfg
    if 0 == index - 1 then
      self.v_lv_desc.text = Util.format_str("角色提升到{1}级可以突破", lv)
    else
      self.v_lv_desc.text = Util.format_str("角色提升到{1}星{2}级可以突破", star, lv)
    end
  end
end

function ui:_onclick_star_tog(index, isOn)
  self:_refresh_mat_list(index)
  self:_refresh_break_desc(index)
  for i, v in ipairs(self.v_star_list) do
    v.checkobj:SetActiveEx(i == index)
  end
end

return ui
