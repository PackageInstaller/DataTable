local ICON_PREFIX = "UIBattleGame3/"
local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local UI_TYPE = {
  GREEN = 1,
  BLUE = 2,
  YELLOW = 3,
  PURPLE = 4
}
local CLICK_EFFECT = {
  [UI_TYPE.GREEN] = "Fx_U_UIBattleGame2_Click_Green",
  [UI_TYPE.BLUE] = "Fx_U_UIBattleGame2_Click_Blue",
  [UI_TYPE.YELLOW] = "Fx_U_UIBattleGame2_Click_Com"
}
local LOOP_EFFECT = {
  [UI_TYPE.GREEN] = "Fx_UI_UIBattleGame2_LineLoop_Green",
  [UI_TYPE.BLUE] = "Fx_UI_UIBattleGame2_LineLoop_Blue",
  [UI_TYPE.YELLOW] = "Fx_UI_UIBattleGame2_LineLoop_Com",
  [UI_TYPE.PURPLE] = "Fx_UI_UIBattleGame2_Type4_LineLoop"
}

function ui:ui_finish_load()
  self.v_node_icon_cg = self:get_canvas_group("", self.v_uiobjects.NodeIconBg)
end

function ui:hide_all_icon_line_click_effect()
  local transform = self.v_uiobjects.IconClickEffectRoot.transform
  local child_count = transform.childCount
  for i = 1, child_count do
    local child = transform:GetChild(i - 1)
    local gameobj = child.gameObject
    if gameobj.activeSelf then
      gameobj:SetActive(false)
    end
  end
end

function ui:get_line_click_effect(icon_name)
  local obj = self:get_child_gameobj(icon_name, self.v_uiobjects.IconClickEffectRoot)
  if not obj then
    Log.Error("插针小游戏 IconClickEffectRoot_节点下未能获取到与配置图标同名的动效", icon_name)
    return
  end
  return obj
end

function ui:ui_on_show()
  local objs = self.v_uiobjects
  for _, v in pairs(CLICK_EFFECT) do
    objs[v]:SetActiveEx(false)
  end
  for _, v in pairs(LOOP_EFFECT) do
    objs[v]:SetActiveEx(false)
  end
  self.v_uiobjects.Click_Handle1:SetActiveEx(false)
  self.v_uiobjects.Click_Handle2:SetActiveEx(false)
  self.v_uiobjects.Active1:SetActiveEx(false)
  self.v_uiobjects.Active2:SetActiveEx(false)
  self.v_uiobjects.Line:SetActiveEx(false)
  self:hide_all_icon_line_click_effect()
  self.v_node_icon_cg.alpha = 1
  self.v_uiobjects.Ani_GameType4_Out:SetActiveEx(false)
end

function ui:ui_on_hide()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
  if self.v_tween then
    self.v_tween:Kill()
    self.v_tween = nil
  end
end

function ui:ui_on_destroy()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
end

function ui:set_data(node_data)
  self.v_data = node_data
  local ui_type = node_data.ui_type
  local effect_type = node_data.effect_type
  local icon_name = node_data.icon
  local has_icon = icon_name and "" ~= icon_name and icon_name ~= {}
  local is_dead_node = node_data.is_dead_node
  self.v_has_icon = has_icon
  local click_effect_name = CLICK_EFFECT[effect_type]
  self.v_click_effect = click_effect_name and self.v_uiobjects[click_effect_name]
  if has_icon then
    self.v_click_effect = self:get_line_click_effect(icon_name)
  end
  self.v_line_effect_loop = self.v_uiobjects[LOOP_EFFECT[effect_type]]
  self.v_line_effect_loop:SetActiveEx(not is_dead_node)
  self.v_handle_effect = 4 == ui_type and self.v_uiobjects.Click_Handle2 or self.v_uiobjects.Click_Handle1
  self.v_uiobjects.Line:SetActive(is_dead_node or has_icon)
  if self.v_tween then
    self.v_tween:Kill()
  end
  self.v_node_icon_cg.alpha = 0
  self.v_tween = self.v_node_icon_cg:DOFade(1, 0.6)
  self.v_uiobjects.NodeIconBg:SetActiveEx(has_icon)
  if has_icon then
    ResMgr:load_set_icon(self.v_uicompents.NodeIcon_img, ICON_PREFIX .. icon_name)
    ResMgr:load_set_icon(self.v_uicompents.Vx_Glow_NodeIcon_img, ICON_PREFIX .. icon_name .. "_Glow")
  end
end

function ui:set_highlight(active)
end

function ui:set_order_highlight(wait_order)
  if self.v_uiobjects.NodeIconBg.activeSelf then
    local show = 0 == self.v_data.order or self.v_data.order == wait_order
    self.v_uiobjects.Vx_Glow_NodeIcon:SetActiveEx(show)
  end
end

function ui:do_judge_success(call_back)
  self.v_line_effect_loop:SetActiveEx(false)
  if self.v_click_effect then
    self.v_click_effect:SetActiveEx(true)
  end
  if self.v_handle_effect then
    self.v_handle_effect:SetActiveEx(true)
  end
  if self.v_has_icon then
    self.v_uiobjects.Ani_GameType4_Out:SetActiveEx(true)
  end
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
  end
  self.v_uiobjects.Line:SetActiveEx(true)
end

return ui
