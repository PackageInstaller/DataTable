local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local Vec3 = require("base.vec3")
local MenuCfg = ShareRes.create("activity.barbecue_menu")
local MatCfg = ShareRes.create("activity.barbecue_materail")
local any_food_icon_path = "ActivitySummer/Xyxt/xyxt_icon_main_sp"

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
  self.v_food_id = nil
  self.v_food_map = nil
  self.v_any_food = false
  self.v_num = 0
  self:clear_fly_icon_tween()
end

function ui:ui_on_destroy()
end

function ui:set_food(food_id, num)
  if not MenuCfg[food_id] then
    Log.Error("烧烤小游戏 顾客配置所需食物ID不存在：", food_id)
    return
  end
  self:reset_data(food_id, nil, false, num, MenuCfg[food_id].Icon)
end

function ui:set_material(mat_id, num)
  local food_map = self:get_food_map_by_material(mat_id)
  self:reset_data(nil, food_map, false, num, MatCfg[mat_id].Icon)
end

function ui:set_any_food(num)
  self:reset_data(nil, nil, true, num, any_food_icon_path)
end

function ui:reset_data(food_id, food_map, is_any_food, num, icon_path)
  self.v_food_id = food_id
  self.v_food_map = food_map
  self.v_any_food = is_any_food
  self.v_num = num
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, icon_path)
  ResMgr:load_set_icon(self.v_uicompents.DoneMask_img, icon_path)
  self.v_uiobjects.NumObj:SetActiveEx(num > 1)
  self.v_uiobjects.DoneMask:SetActiveEx(false)
  self.v_uiobjects.FlyIcon:SetActiveEx(false)
  self.v_uicompents.NumText_txt.text = num
  self:set_enable(true)
end

function ui:try_match(food_id, from_trans)
  if not self.v_num or self.v_num < 1 then
    return false
  end
  if self.v_food_id then
    if self.v_food_id == food_id then
      self:do_recive(food_id, from_trans)
      return true
    end
  elseif self.v_food_map then
    if self.v_food_map[food_id] then
      self:do_recive(food_id, from_trans)
      return true
    end
  elseif self.v_any_food then
    self:do_recive(food_id, from_trans)
    return true
  end
end

function ui:do_recive(result_food_id, from_trans)
  self.v_num = self.v_num - 1
  local cfg = MenuCfg[result_food_id]
  ResMgr:load_set_icon(self.v_uicompents.FlyIcon_img, cfg.Icon)
  if self.v_icon_tween then
    self.v_icon_tween:Complete()
  end
  self:clear_fly_icon_tween()
  self.v_uiobjects.FlyIcon:SetActiveEx(true)
  self.v_uicompents.FlyIcon_rect:SetPositionA(from_trans:GetPositionA())
  self.v_icon_tween = self.v_uicompents.FlyIcon_rect:DOLocalMove(Vec3.zero, 0.3):OnComplete(function()
    self.v_uiobjects.FlyIcon:SetActiveEx(false)
    if 0 == self.v_num then
      self.v_uiobjects.DoneMask:SetActiveEx(true)
      self.v_uiobjects.NumObj:SetActiveEx(false)
    end
    self.v_uicompents.NumText_txt.text = self.v_num
    self.v_parent_ui:get_score(cfg.Score)
  end)
end

function ui:clear_fly_icon_tween()
  if self.v_icon_tween then
    self.v_icon_tween:Kill()
    self.v_icon_tween = nil
  end
end

function ui:get_food_map_by_material(material_id)
  local map = {}
  for food_id, cfg in pairs(MenuCfg) do
    if cfg.PrefixMatId == material_id or cfg.NextMatId == material_id then
      map[food_id] = true
    end
  end
  return map
end

return ui
