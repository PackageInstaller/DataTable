local M = {}
M.DEFAULT_ASSET_TYPE = "default_asset_type"

function M:init()
  self.v_caches = {}
  self.v_refs = {}
  self.v_need_unloads = {}
end

function M:del_all_caches()
  for _, caches in pairs(self.v_caches) do
    for _, cache in pairs(caches) do
      ResMgr:do_unload(cache, true)
    end
  end
  self.v_caches = {}
  self.v_refs = {}
  self.v_need_unloads = {}
end

function M:count()
  local count = 0
  for _, caches in pairs(self.v_caches) do
    for _, _ in pairs(caches) do
      count = count + 1
    end
  end
  return count
end

function M:print_count()
  Log.Info("-----  count ------ ", self:count())
end

function M:pre_snapshot()
  print("------- pre_snapshot --------")
  self.v_pre_snapshot = {}
  for _, caches in pairs(self.v_caches) do
    for name, _ in pairs(caches) do
      self.v_pre_snapshot[name] = true
    end
  end
end

function M:next_snapshot()
  print("------- next_snapshot --------")
  self.v_next_snapshot = {}
  for _, caches in pairs(self.v_caches) do
    for name, _ in pairs(caches) do
      self.v_next_snapshot[name] = true
    end
  end
end

function M:diff_snapshot()
  print("-------- diff snapshot --------")
  local leak_asset_paths = {}
  for name, _ in pairs(self.v_next_snapshot) do
    if not self.v_pre_snapshot[name] then
      local asset_path = self:_bundle_to_asset(name)
      print("----- leak ----- ", asset_path)
      table.insert(leak_asset_paths, asset_path)
    end
  end
  self:_write_to_file(leak_asset_paths)
end

function M:collectgarbage(unload_type)
  if nil == unload_type then
    unload_type = true
  end
  for asset_type, need_unloads in pairs(self.v_need_unloads) do
    local caches = self.v_caches[asset_type]
    local refs = self.v_caches[asset_type]
    for res_name, asset in pairs(need_unloads) do
      ResMgr:do_unload(asset, unload_type)
      caches[res_name] = nil
      refs[res_name] = nil
      if Game_AssetBundle then
        Global.assetbundle_mgr:on_bundle_unload(res_name)
      end
    end
  end
  self.v_need_unloads = {}
end

function M:get_cache_res(res_name, asset_type)
  local caches = self.v_caches[asset_type]
  if caches then
    return caches[res_name]
  end
end

function M:cache_res(res_path, asset_type, asset)
  local caches = self.v_caches[asset_type]
  if not caches then
    caches = {}
    self.v_caches[asset_type] = caches
  end
  if not caches[res_path] then
    caches[res_path] = asset
    self:add_ref(res_path, asset_type)
  else
    self:add_ref(res_path, asset_type)
  end
  local need_unloads = self.v_need_unloads[asset_type]
  if need_unloads then
    need_unloads[res_path] = nil
  end
end

function M:uncache_res(res_name, asset_type)
  local caches = self.v_caches[asset_type]
  if caches then
    self.v_caches[asset_type] = nil
  end
  local refs = self.v_refs[asset_type]
  if refs then
    refs[res_name] = nil
  end
end

function M:get_ref(res_name, asset_type)
  local refs = self.v_refs[asset_type]
  if not refs then
    refs = {}
    self.v_refs[asset_type] = refs
  end
  return refs[res_name] or 0
end

function M:add_ref(res_path, asset_type)
  local refs = self.v_refs[asset_type]
  if not refs then
    refs = {}
    self.v_refs[asset_type] = refs
  end
  local ref = refs[res_path] or 0
  refs[res_path] = ref + 1
  local need_unloads = self.v_need_unloads[asset_type]
  if need_unloads then
    need_unloads[res_path] = nil
  end
end

function M:del_ref(res_path, asset_type, count)
  count = count or 1
  local refs = self.v_refs[asset_type]
  local ref = refs[res_path]
  if not ref or count >= ref then
    local caches = self.v_caches[asset_type]
    if caches then
      local asset = caches[res_path]
      if asset then
        if not self.v_need_unloads[asset_type] then
          self.v_need_unloads[asset_type] = {}
        end
        self.v_need_unloads[asset_type][res_path] = asset
      end
    end
    refs[res_path] = 0
    return true
  else
    refs[res_path] = ref - count
    return false
  end
end

function M:log_asset_cache()
  local refs = {}
  for _, refs_type in pairs(self.v_refs) do
    for k, count in pairs(refs_type) do
      if count > 0 then
        refs[k] = count
      end
    end
  end
  local init_base_refs = false
  if not self.v_record_base_refs then
    self.v_record_base_refs = {}
    init_base_refs = true
  end
  local content = ""
  
  local function on_add_ref_content(name, count)
    content = content .. "name: " .. name .. " count: " .. count .. " \n"
  end
  
  local record_add_refs = {}
  local ref_count = 0
  content = "ref_count           --------" .. ref_count .. " \n"
  for name, count in pairs(refs) do
    ref_count = ref_count + 1
    on_add_ref_content(name, count)
    if init_base_refs then
      self.v_record_base_refs[name] = count
    elseif not self.v_record_base_refs[name] then
      record_add_refs[name] = count
    end
  end
  content = content .. "---------------------ChangeAdd-------------------------\n"
  for name, count in pairs(record_add_refs) do
    on_add_ref_content(name, count)
  end
  content = content .. "---------------------ChangeDec-------------------------\n"
  for name, count in pairs(self.v_record_base_refs) do
    if not refs[name] then
      on_add_ref_content(name, count)
    end
  end
  local oSaveFile = io.open("ref.txt", "w")
  oSaveFile:write(content)
  oSaveFile:close()
end

function M:_init_bundle_to_name_dic()
  local PathDefine = require("utils.path_define")
  local AssetToBundle = PathDefine.requrie_assettobundle()
  self.v_bundle_to_name = {}
  for key, value in pairs(AssetToBundle) do
    self.v_bundle_to_name[value] = key
  end
end

function M:_bundle_to_asset(bundle_name)
  if self.v_bundle_to_name == nil then
    self:_init_bundle_to_name_dic()
  end
  return self.v_bundle_to_name[bundle_name]
end

function M:_write_to_file(paths)
  local log_path = UnityEngine.Application.dataPath .. "/diff_snapshot.txt"
  local file = io.open(log_path, "w")
  for _, line in pairs(paths) do
    file:write(line .. "\n")
  end
  file:close()
  Log.Info("diff_snapshot.txt已保存到：" .. log_path)
end

function M:_write_loaded_bundle_names()
  local content = ""
  for bundle_name, _ in pairs(self.v_caches[M.DEFAULT_ASSET_TYPE]) do
    content = content .. bundle_name .. "\n"
  end
  local Application = UnityEngine.Application
  local log_path = Application.persistentDataPath .. "/debug/loaded_bundle_names.txt"
  CSHelper.WriteAllText(log_path, content)
  Log.Error("loaded_bundle_count: ", self:count())
end

return M
