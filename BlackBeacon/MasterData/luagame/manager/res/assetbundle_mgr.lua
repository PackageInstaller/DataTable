local AssetCache = require("manager.res.asset_cache")
local RuntimePackage = require("manager.res.runtime_package")
local Fifo = require("manager.res.res_fifo")
local UnityAssetBundle = UnityEngine.AssetBundle
local CACHE_ASSET_TYPE = AssetCache.DEFAULT_ASSET_TYPE
local MAX_LOADING_BUNDLE_COUNT = 10
local MAX_LOADING_ASSET_COUNT = 3
local BUNDLE_PATH_IDX = 1
local FILE_IDX = 2
local SESSION_IDX = 3
local M = Global.util.create_class()

function M:_init()
  self.v_bundle_assets = {}
  self.v_loading_bundles = {}
  self.v_loading_assets = {}
  self.v_loading_session = 0
  self.v_loading_bundle_count = 0
  self.v_loading_asset_count = 0
  self.v_need_load_bundles = Fifo:new()
  self.v_need_load_bundle_infos = {}
  self.v_need_check_bundle_loads = Fifo:new()
  self.v_need_load_assets = Fifo:new()
  self.v_need_load_asset_infos = {}
  self.v_need_check_asset_loads = Fifo:new()
  RuntimePackage:init()
end

function M:init()
  self.v_shader_bundle = Global.assetbundle_mgr:load_bundle("shader.ab")
end

local function get_shader_variant_collection_path(name)
  return "assets/product/common/shadervariant/" .. name .. ".shadervariants"
end

function M:get_need_warmup_shader_variant_collections()
  if not self.v_shader_bundle then
    return nil
  end
  local shader_variants_collections = {}
  local all_shader_assets = self.v_shader_bundle:LoadAllAssets()
  for i = 0, all_shader_assets.Length - 1 do
    local asset = all_shader_assets[i]
    if asset:GetType() == typeof(UnityEngine.ShaderVariantCollection) and asset.name:find("need_prewarn") then
      shader_variants_collections[asset.name] = asset
    end
  end
  return shader_variants_collections
end

function M:get_all_shader_variant_collections()
  if not self.v_shader_bundle then
    return nil
  end
  local shader_variants_collections = {}
  local all_shader_assets = self.v_shader_bundle:LoadAllAssets()
  for i = 0, all_shader_assets.Length - 1 do
    local asset = all_shader_assets[i]
    if asset:GetType() == typeof(UnityEngine.ShaderVariantCollection) then
      shader_variants_collections[asset.name] = asset
    end
  end
  return shader_variants_collections
end

function M:warmup_shader_variant_collections()
  local shader_variants_collections = self:get_need_warmup_shader_variant_collections()
  if shader_variants_collections then
    for _, shader_variant_collection in pairs(shader_variants_collections) do
      shader_variant_collection:WarmUp()
    end
  end
end

function M:_update_bundle_loads()
  while true do
    local bundle_path, file, session = self.v_need_check_bundle_loads:get_top()
    if bundle_path and AssetCache:get_cache_res(file, CACHE_ASSET_TYPE) then
      self:_on_bundle_loaded(bundle_path, file, session)
      self.v_need_check_bundle_loads:pop()
    else
      break
    end
  end
  if self.v_loading_bundle_count > MAX_LOADING_BUNDLE_COUNT then
    return
  end
  ::lbl_29::
  if self.v_loading_bundle_count < MAX_LOADING_BUNDLE_COUNT then
    do
      local bundle_path, file, session = self.v_need_load_bundles:pop()
      if bundle_path then
        if AssetCache:get_cache_res(file, CACHE_ASSET_TYPE) then
          AssetCache:add_ref(file, CACHE_ASSET_TYPE)
          self:_on_bundle_loaded(bundle_path, file, session)
        else
          local loading_bundle = self.v_loading_bundles[bundle_path]
          if loading_bundle then
            AssetCache:add_ref(file, CACHE_ASSET_TYPE)
            self.v_need_check_bundle_loads:push(bundle_path, file, session)
          else
            loading_bundle = UnityAssetBundle.LoadFromFileAsync(bundle_path)
            if loading_bundle.isDone then
              AssetCache:cache_res(file, CACHE_ASSET_TYPE, loading_bundle.assetBundle)
              self:_on_bundle_loaded(bundle_path, file, session)
            else
              self.v_loading_bundles[bundle_path] = loading_bundle
              self.v_loading_bundle_count = self.v_loading_bundle_count + 1
              Coroutine.start(function()
                coroutine.yield(loading_bundle.isDone)
                AssetCache:cache_res(file, CACHE_ASSET_TYPE, loading_bundle.assetBundle)
                self.v_loading_bundles[bundle_path] = nil
                self.v_loading_bundle_count = self.v_loading_bundle_count - 1
                self:_on_bundle_loaded(bundle_path, file, session)
              end)
            end
          end
        end
        goto lbl_29
      end
    end
  end
end

function M:_update_asset_loads()
  while true do
    local assetbundle_name, asset_name, session = self.v_need_check_asset_loads:get_top()
    if not assetbundle_name then
      break
    end
    local bundle_assets = self.v_bundle_assets[assetbundle_name]
    if bundle_assets and bundle_assets[asset_name] then
      self.v_need_check_asset_loads:pop()
      self:_on_asset_loaded(session, assetbundle_name, bundle_assets[asset_name])
    else
      break
    end
  end
  if self.v_loading_asset_count > MAX_LOADING_ASSET_COUNT then
    return
  end
  while self.v_loading_asset_count < MAX_LOADING_ASSET_COUNT do
    local assetbundle_name, asset_name, session, asset_type = self.v_need_load_assets:pop()
    if not assetbundle_name then
      return
    end
    local request
    local loading_assets = self.v_loading_assets[asset_name]
    local bundle = AssetCache:get_cache_res(assetbundle_name, CACHE_ASSET_TYPE)
    if not bundle then
      self:_on_asset_loaded(session, assetbundle_name, nil)
    end
    if loading_assets then
      self.v_need_check_asset_loads:push(assetbundle_name, asset_name, session, asset_type)
      goto lbl_99
    elseif asset_type then
      request = bundle:LoadAssetAsync(asset_name, asset_type)
      self.v_loading_assets[asset_name] = request
    else
      request = bundle:LoadAssetAsync(asset_name)
      self.v_loading_assets[asset_name] = request
    end
    if not request then
      self:_on_asset_loaded(session, assetbundle_name, nil)
    else
      self.v_loading_assets[asset_name] = request
      self.v_loading_asset_count = self.v_loading_asset_count + 1
      Coroutine.start(function()
        coroutine.yield(request)
        local asset = request.asset
        local bundle_assets = self.v_bundle_assets[assetbundle_name]
        if not bundle_assets then
          bundle_assets = {}
          self.v_bundle_assets[assetbundle_name] = bundle_assets
        end
        self.v_loading_assets[asset_name] = nil
        bundle_assets[asset_name] = asset
        self.v_loading_asset_count = self.v_loading_asset_count - 1
        self:_on_asset_loaded(session, assetbundle_name, asset)
      end)
    end
    ::lbl_99::
  end
end

function M:update()
  self:_update_bundle_loads()
  self:_update_asset_loads()
end

function M:on_destroy()
  self.v_bundle_assets = {}
end

function M:get_bundle_asset(bundle, asset)
  local bundle = self.v_bundle_assets[bundle]
  if bundle then
    return bundle[asset]
  end
end

function M:load_bundle_async(file, finish_callback, finish_cbdata)
  assert(file)
  self:load_multi_bundles_async({file}, nil, nil, finish_callback, finish_cbdata)
end

function M:on_bundle_unload(bundle)
  self.v_bundle_assets[bundle] = {}
end

function M:load_multi_bundles_async(files, callback, cbdata, finish_callback, finish_cbdata)
  if Global.stop_update then
    return
  end
  if not files then
    finish_callback(finish_cbdata)
    return
  end
  local loading_session = self:_new_loading_session()
  local need_load_count = 0
  for _, file in pairs(files) do
    if not AssetCache:get_cache_res(file, CACHE_ASSET_TYPE) then
      local bundle_path = RuntimePackage.get_bundle_path(file)
      need_load_count = need_load_count + 1
      self:_add_to_need_load(bundle_path, file, loading_session)
    else
      AssetCache:add_ref(file, CACHE_ASSET_TYPE)
    end
  end
  if need_load_count <= 0 then
    finish_callback(finish_cbdata)
    return
  end
  self.v_need_load_bundle_infos[loading_session] = {
    callback = callback,
    cbdata = cbdata,
    finish_callback = finish_callback,
    finish_cbdata = finish_cbdata,
    need_load_count = need_load_count
  }
end

function M:load_bundle(file)
  if Global.stop_update then
    return nil
  end
  local bundle = AssetCache:get_cache_res(file, CACHE_ASSET_TYPE)
  if not bundle then
    local bundle_path = RuntimePackage.get_bundle_path(file)
    bundle = UnityAssetBundle.LoadFromFile(bundle_path)
    AssetCache:cache_res(file, CACHE_ASSET_TYPE, bundle)
  else
    AssetCache:add_ref(file, CACHE_ASSET_TYPE)
  end
  return bundle
end

function M:load_multi_bundles(files)
  if Global.stop_update then
    return nil
  end
  if not files then
    return
  end
  for _, file in ipairs(files) do
    self:load_bundle(file)
  end
end

function M:load_bundle_all_assets(assetbundle_name)
  self:load_multi_bundles_all_assets({assetbundle_name})
end

function M:load_multi_bundles_all_assets(assetbundle_names)
  for _, name in ipairs(assetbundle_names) do
    if not self.v_bundle_assets[name] then
      local bundle = AssetCache:get_cache_res(name, CACHE_ASSET_TYPE)
      bundle:LoadAllAssets()
    end
  end
end

function M:load_bundle_asset_async(assetbundle_name, asset_name, callback, cbdata, asset_type)
  if Global.stop_update then
    return
  end
  local bundle_assets = self.v_bundle_assets[assetbundle_name]
  if not bundle_assets then
    bundle_assets = {}
    self.v_bundle_assets[assetbundle_name] = bundle_assets
  elseif bundle_assets[asset_name] then
    callback(cbdata, bundle_assets[asset_name])
    return
  end
  local bundle = AssetCache:get_cache_res(assetbundle_name, CACHE_ASSET_TYPE)
  if not bundle then
    print("can't find bundle: ", assetbundle_name)
    callback(cbdata, nil)
    return
  end
  local request
  local loading_assets = self.v_loading_assets[asset_name]
  AssetCache:add_ref(assetbundle_name, CACHE_ASSET_TYPE)
  local session = self:_new_loading_session()
  self:_add_to_need_load_asset(assetbundle_name, asset_name, session, asset_type)
  self.v_need_load_asset_infos[session] = {finish_callback = callback, finish_cbdata = cbdata}
end

function M:load_bundle_asset(assetbundle_name, asset_name, asset_type)
  local bundle_assets = self.v_bundle_assets[assetbundle_name]
  if not bundle_assets then
    bundle_assets = {}
    self.v_bundle_assets[assetbundle_name] = bundle_assets
  elseif bundle_assets[asset_name] then
    return bundle_assets[asset_name]
  end
  local bundle = AssetCache:get_cache_res(assetbundle_name, CACHE_ASSET_TYPE)
  if not bundle then
    return
  end
  local asset
  if asset_type then
    asset = bundle:LoadAsset(asset_name, asset_type)
  else
    asset = bundle:LoadAsset(asset_name)
  end
  bundle_assets[asset_name] = asset
  return asset
end

function M:load_atlas_bundle_asset(assetbundle_name, asset_name, asset_type)
  local bundle_assets = self.v_bundle_assets[assetbundle_name]
  if not bundle_assets then
    bundle_assets = {}
    self.v_bundle_assets[assetbundle_name] = bundle_assets
  elseif bundle_assets[asset_name] then
    return bundle_assets[asset_name]
  end
  local bundle = AssetCache:get_cache_res(assetbundle_name, CACHE_ASSET_TYPE)
  if not bundle then
    return
  end
  local objs = bundle:LoadAllAssets(asset_type)
  for _, obj in ipairs(objs) do
    bundle_assets[string.lower(obj.name)] = obj
  end
  return bundle_assets[asset_name]
end

function M:has_loading_bundle()
  return next(self.v_loading_bundles) ~= nil
end

function M:_new_loading_session()
  self.v_loading_session = self.v_loading_session + 1
  return self.v_loading_session
end

function M:_add_to_need_load(bundle_path, file, session)
  self.v_need_load_bundles:push(bundle_path, file, session)
end

function M:_add_to_need_load_asset(bundle_path, file, session, asset_type)
  self.v_need_load_assets:push(bundle_path, file, session, asset_type)
end

function M:_on_bundle_loaded(bundle_path, file, session)
  local info = self.v_need_load_bundle_infos[session]
  info.need_load_count = info.need_load_count - 1
  if info.need_load_count <= 0 then
    self.v_need_load_bundle_infos[session] = nil
    info.finish_callback(info.finish_cbdata)
  elseif info.callback then
    info.callback(info.cbdata)
  end
end

function M:_on_asset_loaded(session, assetbundle_name, asset)
  AssetCache:del_ref(assetbundle_name, CACHE_ASSET_TYPE)
  local info = self.v_need_load_asset_infos[session]
  self.v_need_load_asset_infos[session] = nil
  info.finish_callback(info.finish_cbdata, asset)
end

return M
