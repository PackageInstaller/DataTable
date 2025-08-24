local M = Util.create_class()
local Math = require("base.mathx")
local prefab_name = "UI_Float_Icon"
local PATH = "item/"
local OBJNAME_2_VARNAME = {
  Text = "v_text_obj",
  Icon = "v_icon_obj",
  Content = "v_content",
  DOTween = "v_dotween_obj"
}
local COMNAME_2_VARNAME = {Text_txt = "v_text", Icon_img = "v_icon"}

function M:_init(dynamic_ui)
  self.v_dynamic_ui = dynamic_ui
  self.v_is_destroy = nil
end

function M:init_char_info(char, magic_id)
  local magic_cfg = ShareRes.create("magic.magic")[magic_id]
  if not magic_cfg then
    return
  end
  self.v_char = char
  self.v_magic_cfg = magic_cfg
  self:_init_bindings()
end

function M:_init_uicontainer(go)
  local ui_container = go.gameObject:GetComponent(typeof(CS.UIContainer))
  if not ui_container then
    return
  end
  local list_name = ui_container.ListName
  local list_objects = ui_container.ListObj
  local list_comp_name = ui_container.ListCompName
  local list_comp_objects = ui_container.ListComponent
  for i = 0, list_name.Count - 1 do
    local name = list_name[i]
    local object = list_objects[i]
    local var_name = OBJNAME_2_VARNAME[name]
    if var_name then
      self[var_name] = object
    end
  end
  for i = 0, list_comp_name.Count - 1 do
    local name = list_comp_name[i]
    local component = list_comp_objects[i]
    local var_name = COMNAME_2_VARNAME[name]
    if var_name then
      self[var_name] = component
    end
  end
end

function M:_init_bindings()
  if not self.v_dynamic_ui then
    return
  end
  local cfg = self.v_magic_cfg
  if not cfg.FloatingIconParam or Util.is_empty(cfg.FloatingIconParam[1]) or Util.is_empty(cfg.FloatingIconParam[2]) then
    return
  end
  self.v_prefab_name = cfg.FloatingIconParam[3] or prefab_name
  self.v_local_scale = cfg.FloatingIconParam[4] or 1
  self.v_attach_point = cfg.FloatingIconParam[5] or Config.DEFAULT_HIT_POINT
  if Util.is_nil(self.v_float_icon_obj) then
    self.is_loading_obj = true
    ResPoolMgr:get_ui_effect_async(self.v_prefab_name, function(go)
      self.is_loading_obj = false
      if self.v_is_destroy then
        self.obj_is_destory = true
        ResPoolMgr:release(go)
        return
      end
      self.obj_is_destory = false
      self:_init_uicontainer(go)
      self.v_float_icon_obj = go
      self.v_rect_tf = Util.get_rect_transform(nil, go)
      self.v_rect_tf:SetParent(self.v_dynamic_ui:get_object_transform())
      self:set_float_icon()
      go.transform:SetLocalScaleA(self.v_local_scale)
    end)
  else
    self.is_loading_obj = false
    self:set_float_icon()
  end
end

function M:set_float_icon()
  if not self.v_dynamic_ui then
    return
  end
  local is_visible = self.v_char:get_gameobj_active()
  self:set_visible(is_visible)
  if not is_visible then
    return
  end
  ResMgr:load_set_icon(self.v_icon, self.v_magic_cfg.FloatingIconParam[1])
  self.v_text.text = self.v_magic_cfg.FloatingIconParam[2]
  self.v_dotween = self.v_dotween_obj:GetComponent(typeof(CS.DG.Tweening.DOTweenAnimation))
  self.v_dotween:DORestart()
  self.v_dotween_canvas = Util.get_canvas_group(nil, self.v_dotween_obj)
  self.v_dotween_canvas.alpha = 1
  self.v_float_icon_obj.transform:SetLocalPositionA(99999, 99999, 0)
end

function M:on_destroy()
  self:set_visible(false)
  if self.v_float_icon_obj then
    ResPoolMgr:release(self.v_float_icon_obj)
  end
  self.v_float_icon_obj = nil
  self.v_rect_tf = nil
  self.v_dynamic_ui = nil
  self.v_char = nil
  self.v_magic_cfg = nil
  self.v_is_destroy = true
end

function M:set_visible(is_visible)
  if not self.v_float_icon_obj or self.v_float_icon_obj:IsNull() then
    return
  end
  self.v_float_icon_obj:SetActiveEx(is_visible)
end

function M:get_obj()
  return self.v_float_icon_obj
end

function M:follow_npc()
  if not self.is_loading_obj and not self.v_is_destroy then
    self.obj_is_destory = Util.is_nil(self.v_float_icon_obj)
    if not self.obj_is_destory then
      self.v_float_icon_obj.transform:SetLocalScaleA(self.v_local_scale)
      Util.set_ui_follow_npc(self.v_rect_tf.component, self.v_char, 0, self.v_attach_point)
    end
  end
end

function M:preload()
  local go = ResPoolMgr:get_ui_effect(prefab_name)
  self:_init_uicontainer(go)
  self.v_float_icon_obj = go
  self.v_rect_tf = Util.get_rect_transform(nil, go)
  self.v_rect_tf:SetParent(self.v_dynamic_ui:get_object_transform())
end

return M
