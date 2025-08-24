local Util = require("utils.util")
local AssetCache = require("manager.res.asset_cache")
local UnityTexture2D = CS.UnityEngine.Texture2D
local CSharpResLoader = CS.ResLoader
local UnityDontDestroyOnLoad = UnityGameObject.DontDestroyOnLoad
local TypeItem = typeof(CS.Game.EquipCube)
local DONT_DESTROY_ONLOAD_OBJS = {}
local Base = require("manager.res.base_loader")
local M = Global.util.create_child_mt(Base)

function M:_init()
  self.v_session = 0
  self.v_callbacks = {}
  self.v_callback_datas = {}
  self.v_loadings = {}
  self.v_session_paths = {}
  self.v_session_asset_types = {}
  self.v_wait_loading_sessions = {}
  self.v_need_instantiates = {}
  self.v_dont_destroy_onload = {}
  self.v_loaded_atlas_agent = {}
  self.v_addtive_scenes = {}
  self.v_instantiate_gameobj_callback = setmetatable({}, Global.config.WEAK_METATABLE)
  self.v_destroy_gameobj_callback = setmetatable({}, Global.config.WEAK_METATABLE)
end

function M:on_destroy()
  for _, obj in pairs(DONT_DESTROY_ONLOAD_OBJS) do
    if not obj:IsNull() then
      UnityDestroy(obj)
    end
  end
  DONT_DESTROY_ONLOAD_OBJS = {}
end

function M:register_instantaite_go_cb(callback, cbdata)
  self.v_instantiate_gameobj_callback[callback] = cbdata
end

function M:register_destroy_go_cb(callback, cbdata)
  self.v_destroy_gameobj_callback[callback] = cbdata
end

function M:create_empty_role_obj(name, dont_destroy)
  local gameobj = UnityGameObject()
  if name then
    gameobj.name = name
  end
  if dont_destroy then
    UnityDontDestroyOnLoad(gameobj)
  end
  return Util.wrap_gameobj(gameobj)
end

function M:raw_instantiate(obj, dont_destroy)
  if nil == obj or obj:IsNull() then
    Log.Error("尝试复制一个空的物体！")
    return nil
  end
  if Global.debug_res then
    Log.Error("帧id:", Global.frame_id, "Instantiate:", obj.name, debug.traceback())
  end
  local go = UnityGameObject.Instantiate(obj)
  if dont_destroy then
    self:dont_destroy_on_load(go)
  end
  local retgo = Util.wrap_gameobj(go)
  for callback, cbdata in pairs(self.v_instantiate_gameobj_callback) do
    callback(cbdata, retgo)
  end
  return retgo
end

function M:dont_destroy_on_load(go)
  local gameobj = go.gameObject
  DONT_DESTROY_ONLOAD_OBJS[gameobj:GetInstanceID()] = go
  UnityGameObject.DontDestroyOnLoad(gameobj)
  if Global.memory_debug then
    go.tag = Global.config.memory_tag
  end
end

function M:destroy_gameobj(go)
  local gameobj = go.gameObject
  local cid = gameobj:GetInstanceID()
  DONT_DESTROY_ONLOAD_OBJS[cid] = nil
  UnityDestroy(gameobj)
  for callback, cbdata in pairs(self.v_destroy_gameobj_callback) do
    callback(cbdata, go)
  end
  if Global.mat_mgr then
    Global.mat_mgr:on_destroy_gameobj(cid)
  end
end

function M:load_scene(path)
  return CSharpResLoader.LoadSceneAsync(path)
end

function M:load_raw_res(res_path)
  return self:load_res(res_path, UnityGameObject)
end

function M:load_res(res_path, type)
  local ret = CSharpResLoader.LoadRes(res_path, typeof(type))
  assert(ret, "asset not exist: " .. res_path)
  AssetCache:cache_res(res_path, type, ret)
  return ret
end

function M:unload_res(res_path, type, count)
  type = type or UnityGameObject
  AssetCache:del_ref(res_path, type, count)
end

local UnityUnLoad = UnityEngine.Resources.UnloadAsset

function M:do_unload(asset)
  UnityUnLoad(asset)
end

function M:load_set_icon(image, icon_path, callback, is_texture, uiobj, parent_name)
  if image.overrideSprite ~= nil then
    image.overrideSprite = nil
  end
  if not is_texture then
    local path = ShareRes.create("img_collection", icon_path)
    if path then
      icon_path = path
    end
    icon_path = Path.get_image_icon_path(icon_path)
  else
    icon_path = Path.get_texture_path(icon_path)
    if uiobj then
      uiobj:add_texture_reference(icon_path)
    end
  end
  Global.img_collector:collect_img(icon_path)
  local icon = self:load_res(icon_path, UnitySprite)
  image.sprite = icon
  if callback then
    callback(image)
  end
end

function M:load_set_icon_sync(image, icon_path, callback, is_texture, uiobj, parent_name)
  self:load_set_icon(image, icon_path, callback, is_texture, uiobj, parent_name)
end

function M:load_set_mat_texture(meshRenderer, icon_path, callback, uiobj)
  icon_path = Path.get_texture_path(icon_path)
  if uiobj then
    uiobj:add_texture_reference(icon_path)
  end
  Global.img_collector:collect_img(icon_path)
  local texture = self:load_res(icon_path, UnityTexture2D)
  meshRenderer.material.mainTexture = texture
  if callback then
    callback(meshRenderer)
  end
end

function M:load_atlas_sprite(image, sprite_name, atlas, uiobj)
  local atlas_path = Path.get_image_atlas_path(sprite_name)
  local agent = self:load_res(atlas_path, UnitySpriteAtlas)
  image.overrideSprite = agent:GetSprite(atlas)
  if uiobj then
    uiobj:add_texture_reference(sprite_name .. atlas)
  end
end

function M:load_set_itemobj_icon(gameobject, icon_path, callback)
  icon_path = Path.get_image_icon_path(icon_path)
  local icon = self:load_res(icon_path, UnitySprite)
  local item_compent = gameobject:GetComponent(TypeItem)
  item_compent:SetSprite(icon)
  if callback then
    callback()
  end
end

function M:load_set_itemobj_quality_icon(gameobject, icon_path)
  icon_path = Path.get_image_icon_path(icon_path)
  local icon = self:load_res(icon_path, UnitySprite)
  local item_compent = gameobject:GetComponent(TypeItem)
  item_compent:SetBg(icon)
end

function M:unload_texture(texture, count)
  self:unload_res(texture, UnitySprite, count)
end

function M:load_gameobj(res_name, asset_type, dont_destroy)
  local res = self:load_res(res_name, asset_type or UnityGameObject)
  if not res then
    return
  end
  local go = self:raw_instantiate(res, dont_destroy)
  if UNITY_EDITOR and Global.debug and DebugSetting:is_show_res_load_log() then
    Log.Info("load_gameobj No preload ---------------", res_name)
  end
  return go
end

function M:load_res_async(res_path, asset_type, cb, cbdata)
  assert(cb, "load_res_async without callback")
  asset_type = asset_type or UnityGameObject
  local cache_res = AssetCache:get_cache_res(res_path, asset_type)
  if cache_res then
    cb(cbdata, cache_res)
    return
  end
  if UNITY_EDITOR and Global.debug and DebugSetting:is_show_res_load_log() then
    Log.Info("load_res_async No preload ---------------", res_path)
  end
  local session = self:_new_session()
  self:_set_callback_data(session, cb, cbdata, nil, nil, res_path, asset_type)
  Global.unityres_mgr:load_res_async(res_path, asset_type, session)
end

function M:load_gameobj_async(res_path, asset_type, dont_destroy, cb, cbdata)
  assert(cb, "load_gameobj_async without callback")
  asset_type = asset_type or UnityGameObject
  local cache_res = AssetCache:get_cache_res(res_path, asset_type)
  if cache_res then
    local gameobj = self:raw_instantiate(cache_res, dont_destroy)
    cb(cbdata, gameobj)
    return
  end
  if UNITY_EDITOR and Global.debug and DebugSetting:is_show_res_load_log() then
    Log.Info("load_gameobj_async No preload ---------------", res_path)
  end
  local session = self:_new_session()
  self:_set_callback_data(session, cb, cbdata, true, dont_destroy, res_path, asset_type)
  Global.unityres_mgr:load_res_async(res_path, asset_type, session)
end

function M:on_resource_load(session, obj)
  local path = self.v_session_paths[session]
  local asset_type = self.v_session_asset_types[session]
  AssetCache:cache_res(path, asset_type, obj)
  self:_call_callback(session, obj)
  local sessions = {}
  for s, ls in pairs(self.v_wait_loading_sessions) do
    if ls == session then
      self.v_wait_loading_sessions[s] = nil
      table.insert(sessions, s)
    end
  end
  for _, s in ipairs(sessions) do
    self:_call_callback(s, obj)
  end
end

function M:is_gameobj_dont_destroy_on_load(go)
  return DONT_DESTROY_ONLOAD_OBJS[go:GetInstanceID()] ~= nil
end

function M:get_dont_destroy_on_load()
  return DONT_DESTROY_ONLOAD_OBJS
end

function M:_call_callback(session, obj)
  if not obj and self.v_session_paths[session] then
    self:_clear_session_data(session)
    Global.log.Debug("----- obj nil ------- ", self.v_session_paths[session])
    return
  end
  local gameobj = obj
  if self.v_need_instantiates[session] then
    gameobj = self:raw_instantiate(obj)
    if self.v_dont_destroy_onload[session] then
      self:dont_destroy_on_load(gameobj)
    end
  end
  local callback = self.v_callbacks[session]
  local cbdata = self.v_callback_datas[session]
  self:_clear_session_data(session)
  callback(cbdata, gameobj)
end

function M:_clear_session_data(session)
  self.v_need_instantiates[session] = nil
  self.v_dont_destroy_onload[session] = nil
  self.v_callbacks[session] = nil
  self.v_callback_datas[session] = nil
  self.v_session_asset_types[session] = nil
  self.v_session_paths[session] = nil
end

function M:_set_callback_data(session, cb, cbdata, need_instantiate, dont_destroy, prefab_name, asset_type)
  self.v_callbacks[session] = cb
  self.v_callback_datas[session] = cbdata
  self.v_need_instantiates[session] = need_instantiate
  self.v_dont_destroy_onload[session] = dont_destroy
  self.v_session_paths[session] = prefab_name
  self.v_session_asset_types[session] = asset_type
end

function M:_new_session()
  self.v_session = self.v_session + 1
  return self.v_session
end

function M:load_text_asset(text_path, cb)
  text_path = string.format("assets/product/%s", text_path)
  local text = self:load_res(text_path, UnityEngine.TextAsset)
  cb(text.bytes)
end

function M:check_is_can_fight_with_res(chapter_cfg)
  return true
end

return M
