local Base = require("obj.base_component")
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local CSUnityEngine = UnityEngine
local CSUnityUI = CSUnityEngine.UI
local TypeUIImage = TypeUnityUIImage
local TypeUIText = typeof(CSUnityUI.Text)
local TypeSetValueHelper = typeof(CS.Game.EffectBarSetValueHelper)
local M = Util.create_child_mt(Base)
local USAGE_TYPE = {MAGIC_NUN = 1, ATTR = 2}
local TXT_SRC_TYPE = {PARENT = 1, PRESET = 2}
local USAGE_FUNC = {
  [USAGE_TYPE.MAGIC_NUN] = "_update_magic_num",
  [USAGE_TYPE.ATTR] = "_update_attr"
}
local _ticket = 1

local function _next_ticket()
  _ticket = _ticket + 1
  return _ticket
end

local HudItem = Util.create_class()

function HudItem:_init(config, attach_point, comp, txt)
  self.v_config = config
  self.v_comp = comp
  self.v_char = comp.v_char
  self.v_attach_name = attach_point
  self.v_ticket = _next_ticket()
  self.v_is_destroy = false
  self.v_txt_content = txt
  self.v_txt = nil
  self.v_obj = nil
  self.v_tf = nil
  self.v_rect_tf = nil
  self.v_fore_img = nil
  self.v_back_img = nil
  self.v_attach_tf = nil
  self:_load()
end

function HudItem:_check_valid(ticket)
  local is_valid = self.v_ticket == ticket and not self.v_is_destroy
  local attach_tf
  if self.v_char then
    attach_tf = self.v_char:get_setting_point(self.v_attach_name) or self.v_char.transform
    if nil == attach_tf or attach_tf:IsNull() then
      is_valid = false
    end
  end
  local ui = UIMgr:try_get_visible_ui("uidynamic_canvas")
  if not ui then
    is_valid = false
  end
  return is_valid, attach_tf, ui
end

function HudItem:_load_txt()
  local res_config = self.v_config.res_config
  if res_config.TxtSrc == TXT_SRC_TYPE.PRESET then
    local txt_tf = self.v_tf:FindChild(res_config.TxtParent)
    txt_tf.gameObject:SetActive(true)
    self.v_txt = txt_tf.gameObject:GetComponent(TypeUIText)
    assert(self.v_txt, "hud txt缺失")
    self.v_txt.text = self.v_txt_content
    return
  end
  local ticket = self.v_ticket
  ResPoolMgr:get_ui_effect_async(res_config.Font, function(go)
    local is_valid = self:_check_valid(ticket)
    if not is_valid then
      ResPoolMgr:release(go)
      return
    end
    local parent
    if res_config.TxtParent then
      parent = self.v_tf:FindChild(res_config.TxtParent)
    end
    if nil == parent then
      parent = self.v_fore_img.transform
    end
    go:SetActive(true)
    go.transform:SetParent(parent)
    go:ResetAttr()
    self.v_txt = go:GetComponent(TypeUIText)
    assert(self.v_txt, "hud txt缺失")
    self.v_txt.text = self.v_txt_content
  end)
end

function HudItem:_load()
  local res_config = self.v_config.res_config
  local ticket = self.v_ticket
  ResPoolMgr:get_ui_effect_async(res_config.Prefab, function(go)
    local is_valid, attach_tf, ui = self:_check_valid(ticket)
    if not is_valid then
      ResPoolMgr:release(go)
      return
    end
    go:SetActive(true)
    go.transform:SetParent(ui:get_object_transform())
    go:ResetAttr()
    self.v_obj = go
    self.v_tf = go.transform
    self.v_rect_tf = Util.get_rect_transform(nil, go)
    self.v_attach_tf = attach_tf
    local fore = Util.get_image("Fore", go)
    if not fore then
      Log.Error("预制", res_config.Prefab, "丢失Fore图片", self.v_config, debug.traceback())
    end
    self.v_fore_img = fore.component
    local back = Util.get_image("Back", go)
    if not back then
      Log.Error("预制", res_config.Prefab, "丢失Back图片", self.v_config, debug.traceback())
    end
    self.v_back_img = back.component
    ResMgr:load_set_icon(self.v_fore_img, res_config.Fore)
    ResMgr:load_set_icon(self.v_back_img, res_config.Back)
    self.v_fore_img.fillAmount = 1
    local func = USAGE_FUNC[self.v_config.usage_type]
    self[func](self)
    Util.refresh_language_text(go)
    if res_config.HasTxt then
      self:_load_txt()
    end
    if self.v_rect_tf and not Util.is_nil(self.v_rect_tf.component) then
      self.v_rect_tf.component:SetAnchoredMinMax(0, 0, 0, 0)
    end
  end)
end

function HudItem:_update_pos()
  if not self.v_obj or not Global.camera then
    return
  end
  if not Global.ui_dynamic_canvas then
    return
  end
  Util.set_ui_follow_npc(self.v_rect_tf.component, self.v_char, -0.8, self.v_attach_name)
end

function HudItem:update()
  if self.v_obj == nil then
    return
  end
  local ct_info = Cinemachine:get_ct_info()
  if ct_info and self.v_obj then
    self.v_obj:SetActiveEx(false)
    return
  end
  if self.v_obj then
    self.v_obj:SetActiveEx(true)
  end
  self:_update_pos()
end

function HudItem:_update_bar(cur, max)
  if self.v_fore_img == nil then
    return
  end
  if max <= 0 then
    self.v_fore_img.fillAmount = 0
  else
    self.v_fore_img.fillAmount = cur / max
  end
end

function HudItem:_update_magic_num()
  local magic_id = self.v_config.param1
  local magic_mgr = self.v_char.magic_mgr
  local magic_cfg = ShareRes.get_magic_cfg(magic_id)
  local cur = magic_mgr:get_magic_num(magic_id)
  local max = magic_cfg.logic.Limit or 0
  self:_update_bar(cur, max)
end

function HudItem:_update_attr()
  local cur_type = self.v_config.param1
  local max_type = self.v_config.param2
  local attr_mgr = self.v_char.attr_mgr
  local cur = attr_mgr:get_attr(cur_type)
  local max = attr_mgr:get_attr(max_type)
  self:_update_bar(cur, max)
end

function HudItem:check_update_magic_num(magic_id)
  if self.v_char == nil then
    return
  end
  local target_magic_id = self.v_config.param1
  if target_magic_id ~= magic_id then
    return
  end
  self:_update_magic_num()
end

function HudItem:check_update_attr(attr_type)
  if self.v_char == nil then
    return
  end
  local cur_type = self.v_config.param1
  local max_type = self.v_config.param2
  if cur_type == attr_type or max_type == attr_type then
    self:_update_attr()
  end
end

function HudItem:get_usage_type()
  return self.v_config.usage_type
end

function HudItem:on_destroy()
  local res_config = self.v_config.res_config
  self.v_is_destroy = true
  self.v_config = nil
  self.v_comp = nil
  self.v_attach_name = nil
  self.v_char = nil
  if self.v_txt and res_config.TxtSrc == TXT_SRC_TYPE.PARENT then
    self.v_txt = nil
  end
  if self.v_obj then
    ResPoolMgr:release(self.v_obj)
    self.v_obj = nil
    self.v_tf = nil
    self.v_rect_tf = nil
    self.v_fore_img = nil
    self.v_back_img = nil
    self.v_attach_tf = nil
  end
end

local HudItemWorldSpace = Util.create_class()

function HudItemWorldSpace:_init(config, attach_point, comp, x, y, z)
  self.v_config = config
  self.v_comp = comp
  self.v_char = comp.v_char
  self.v_attach_name = attach_point
  self.v_ticket = _next_ticket()
  self.v_is_destroy = false
  self.v_obj = nil
  self.v_tf = nil
  self.v_rect_tf = nil
  self.v_attach_tf = nil
  self.v_pos_x = x
  self.v_pos_y = y
  self.v_pos_z = z
  self:_load()
end

function HudItemWorldSpace:on_destroy()
  self.v_config = nil
  self.v_comp = nil
  self.v_char = nil
  self.v_attach_name = nil
  self.v_ticket = nil
  self.v_is_destroy = true
  self.v_obj = nil
  self.v_tf = nil
  self.v_rect_tf = nil
  self.v_attach_tf = nil
end

function HudItemWorldSpace:_check_valid(ticket)
  local is_valid = self.v_ticket == ticket and not self.v_is_destroy
  local attach_tf
  if self.v_char then
    attach_tf = self.v_char:get_setting_point(self.v_attach_name) or self.v_char.transform
    if nil == attach_tf or attach_tf:IsNull() then
      is_valid = false
    end
  end
  return is_valid, attach_tf
end

function HudItemWorldSpace:_load()
  local res_config = self.v_config.res_config
  local ticket = self.v_ticket
  ResPoolMgr:get_ui_effect_async(res_config.Prefab, function(go)
    local is_valid, attach_tf = self:_check_valid(ticket)
    if not is_valid then
      ResPoolMgr:release(go)
      return
    end
    go:SetActive(true)
    go.transform:SetParent(attach_tf)
    go:ResetAttr()
    self.v_set_val_helper = go:GetComponent(TypeSetValueHelper)
    if self.v_pos_x then
      self.v_pos_y = self.v_pos_y or 0
      self.v_pos_z = self.v_pos_z or 0
      self.v_set_val_helper:SetHudPos(self.v_pos_x, self.v_pos_y, self.v_pos_z)
    end
    self.v_obj = go
    self.v_tf = go.transform
    self.v_rect_tf = Util.get_rect_transform(nil, go)
    self.v_attach_tf = attach_tf
    local func = USAGE_FUNC[self.v_config.usage_type]
    self[func](self)
  end)
end

function HudItemWorldSpace:_update_pos()
end

function HudItemWorldSpace:update()
  if self.v_obj == nil then
    return
  end
  local ct_info = Cinemachine:get_ct_info()
  if ct_info and self.v_obj then
    self.v_obj:SetActiveEx(false)
    return
  end
  if self.v_obj then
    self.v_obj:SetActiveEx(true)
  end
end

function HudItemWorldSpace:_update_bar(cur, max)
  if Util.is_nil(self.v_set_val_helper) then
    return
  end
  cur = cur or 0
  if max <= 0 then
    if 0 == self.v_cur_set_val then
      return
    end
    self.v_set_val_helper:SetValue(0)
    self.v_cur_set_val = 0
  else
    local set_val = cur / max
    if self.v_cur_set_val == set_val then
      return
    end
    self.v_set_val_helper:SetValue(set_val)
    self.v_cur_set_val = set_val
  end
end

function HudItemWorldSpace:_update_magic_num()
  local magic_id = self.v_config.param1
  local magic_mgr = self.v_char.magic_mgr
  local magic_cfg = ShareRes.get_magic_cfg(magic_id)
  local cur = magic_mgr:get_magic_num(magic_id)
  local max = magic_cfg.logic.Limit or 0
  self:_update_bar(cur, max)
end

function HudItemWorldSpace:_update_attr()
  local cur_type = self.v_config.param1
  local max_type = self.v_config.param2
  local attr_mgr = self.v_char.attr_mgr
  local cur = attr_mgr:get_attr(cur_type)
  local max = attr_mgr:get_attr(max_type)
  self:_update_bar(cur, max)
end

function HudItemWorldSpace:check_update_magic_num(magic_id)
  if self.v_char == nil then
    return
  end
  local target_magic_id = self.v_config.param1
  if target_magic_id ~= magic_id then
    return
  end
  self:_update_magic_num()
end

function HudItemWorldSpace:check_update_attr(attr_type)
  if self.v_char == nil then
    return
  end
  local cur_type = self.v_config.param1
  local max_type = self.v_config.param2
  if cur_type == attr_type or max_type == attr_type then
    self:_update_attr()
  end
end

function HudItemWorldSpace:get_usage_type()
  return self.v_config.usage_type
end

function HudItemWorldSpace:on_destroy()
  self.v_is_destroy = true
  self.v_config = nil
  self.v_comp = nil
  self.v_attach_name = nil
  self.v_char = nil
  if self.v_obj then
    ResPoolMgr:release(self.v_obj)
    self.v_obj = nil
    self.v_tf = nil
    self.v_rect_tf = nil
    self.v_attach_tf = nil
  end
end

local s_config_dic = {}

function M:_init(char)
  Base._init(self)
  M._init_pool()
  self.v_char = char
  self.v_hud_dic = {}
  self.v_hud_dic_world = {}
  self.v_handle_magic_hud_map = {}
  self.v_handle_attr_hud_map = {}
  self:mgr_bind_auto_mq(Const.MSG_ADD_MAGIC, self._handle_magic_change, self)
  self:mgr_bind_auto_mq(Const.MSG_REMOVE_MAGIC, self._handle_magic_change, self)
end

function M:on_before_destroy()
  self.v_char = nil
end

function M:on_destroy_gameobj()
  for _, item in pairs(self.v_hud_dic) do
    M._push_item(item)
  end
  for _, hud_world in pairs(self.v_hud_dic_world) do
    M._push_item_worldspace(hud_world)
  end
  self.v_hud_dic = nil
  self.v_hud_dic_world = nil
end

function M._init_pool()
  if M.s_pool then
    return
  end
  M.s_pool = LuaObjPoolMgr.get_pool("fight_hud_pool") or LuaObjPoolMgr.register("fight_hud_pool", 10, HudItem)
  M.s_pool_worldspace = LuaObjPoolMgr.get_pool("fight_hud_pool_worldspace") or LuaObjPoolMgr.register("fight_hud_pool_worldspace", 10, HudItemWorldSpace)
end

function M._pop_item(...)
  local obj = M.s_pool:new_obj(...)
  obj.v_is_world_space = false
  return obj
end

function M._pop_item_worldspace(...)
  local obj = M.s_pool_worldspace:new_obj(...)
  obj.v_is_world_space = true
  return obj
end

function M._push_item(item)
  M.s_pool:destroy_obj(item)
end

function M._push_item_worldspace(item)
  M.s_pool_worldspace:destroy_obj(item)
end

function M:_handle_magic_change(msg)
  local char = msg.mm_x
  local magic_id = msg.mm_y
  if self.v_char ~= char then
    return
  end
  if self.v_handle_magic_hud_map[magic_id] then
    for _, hud in pairs(self.v_handle_magic_hud_map[magic_id]) do
      hud:check_update_magic_num(magic_id)
    end
  end
end

function M:update()
  if self.v_hud_dic ~= nil then
    for _, item in pairs(self.v_hud_dic) do
      item:update()
    end
  end
  if nil ~= self.v_hud_dic_world then
    for _, item in pairs(self.v_hud_dic_world) do
      item:update()
    end
  end
end

do
  local DEFAULT_RES_CONFIG = {
    Prefab = "UI_Hud",
    HasTxt = false,
    Font = "FontNum5",
    TxtSrc = TXT_SRC_TYPE.PARENT
  }
  
  function M.set_hud_config(name, res_config, usage_type, param1, param2)
    assert(res_config.Fore, "进度条图片配置缺失")
    assert(res_config.Back, "进度条背景图片配置缺失")
    assert(USAGE_FUNC[usage_type], "未知用途")
    Util.set_default(res_config, DEFAULT_RES_CONFIG)
    s_config_dic[name] = {
      res_config = res_config,
      usage_type = usage_type,
      param1 = param1,
      param2 = param2
    }
  end
  
  function M.set_hud_config_world(name, res_config, usage_type, param1, param2)
    s_config_dic[name] = {
      res_config = res_config,
      usage_type = usage_type,
      param1 = param1,
      param2 = param2
    }
  end
  
  function M.clear_hud_config()
    s_config_dic = {}
  end
  
  local function _push_handle_map(handle_map, param, name, hud)
    if handle_map and param then
      handle_map[param] = handle_map[param] or {}
      if handle_map[param][name] then
        Log.Error("存在相同命名的fight_hud", debug.traceback())
      end
      handle_map[param][name] = hud
    end
  end
  
  local function _check_push_hud_handle(self, name, hud)
    local config = hud.v_config
    local usage_type = config.usage_type
    local handle_map
    local param1, param2 = config.param1, config.param2
    if usage_type == USAGE_TYPE.MAGIC_NUN then
      handle_map = self.v_handle_magic_hud_map
    elseif usage_type == USAGE_TYPE.ATTR then
      handle_map = self.v_handle_attr_hud_map
    end
    if handle_map then
      _push_handle_map(handle_map, param1, name, hud)
      if usage_type == USAGE_TYPE.ATTR then
        _push_handle_map(handle_map, param2, name, hud)
      end
    end
  end
  
  local function _pop_handle_map(handle_map, param, name)
    if handle_map and param and handle_map[param] and handle_map[param][name] then
      handle_map[param][name] = nil
    end
  end
  
  local function _check_pop_handle_map(self, name, hud)
    local config = hud.v_config
    local usage_type = config.usage_type
    local handle_map
    local param1, param2 = hud.v_config.param1, hud.v_config.param2
    if usage_type == USAGE_TYPE.MAGIC_NUN then
      handle_map = self.v_handle_magic_hud_map
    elseif usage_type == USAGE_TYPE.ATTR then
      handle_map = self.v_handle_attr_hud_map
    end
    if handle_map then
      _pop_handle_map(handle_map, param1, name)
      if usage_type == USAGE_TYPE.ATTR then
        _pop_handle_map(handle_map, param2, name)
      end
    end
  end
  
  function M:active_hud(name, attach_point, is_active, txt)
    local config = s_config_dic[name]
    assert(config, "需要先初始化指示器的配置")
    local hud = self.v_hud_dic[name]
    if is_active and hud or not is_active and not hud then
      return
    end
    if is_active then
      hud = M._pop_item(config, attach_point, self, txt)
      self.v_hud_dic[name] = hud
      _check_push_hud_handle(self, name, hud)
    else
      _check_pop_handle_map(self, name, hud)
      M._push_item(hud)
      self.v_hud_dic[name] = nil
    end
  end
  
  function M:active_hud_world(name, attach_point, is_active, x, y, z)
    local config = s_config_dic[name]
    assert(config, "需要先初始化指示器的配置")
    local hud = self.v_hud_dic_world[name]
    if is_active and hud or not is_active and not hud then
      return
    end
    if is_active then
      hud = M._pop_item_worldspace(config, attach_point, self, x, y, z)
      self.v_hud_dic_world[name] = hud
      _check_push_hud_handle(self, name, hud)
    else
      _check_pop_handle_map(self, name, hud)
      M._push_item_worldspace(hud)
      self.v_hud_dic_world[name] = nil
    end
  end
  
  function M:refresh_attr(attr_type)
    if self.v_handle_attr_hud_map[attr_type] then
      for _, hud in pairs(self.v_handle_attr_hud_map[attr_type]) do
        hud:check_update_attr(attr_type)
      end
    end
  end
end
return M
