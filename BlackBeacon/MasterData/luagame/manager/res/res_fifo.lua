local Util = require("utils.util")
local M = Util.create_class()

function M:_init()
  self.v_head = 1
  self.v_tail = 0
  self.v_bundle_paths = {}
  self.v_files = {}
  self.v_sessions = {}
  self.v_asset_types = {}
end

function M:push(bundle_path, file, session, asset_type)
  self.v_tail = self.v_tail + 1
  self.v_bundle_paths[self.v_tail] = bundle_path
  self.v_files[self.v_tail] = file
  self.v_asset_types[self.v_tail] = asset_type
  self.v_sessions[self.v_tail] = session
end

function M:pop()
  local head = self.v_head
  if head > self.v_tail then
    return
  end
  local bundle_path = self.v_bundle_paths[head]
  local session = self.v_sessions[head]
  local asset_type = self.v_asset_types[head]
  local file = self.v_files[head]
  self.v_bundle_paths[head] = nil
  self.v_sessions[head] = nil
  self.v_asset_types[head] = nil
  self.v_files[head] = nil
  self.v_head = self.v_head + 1
  return bundle_path, file, session, asset_type
end

function M:get_top()
  local head = self.v_head
  if head > self.v_tail then
    return
  end
  return self.v_bundle_paths[head], self.v_files[head], self.v_sessions[head], self.v_asset_types[head]
end

function M:length()
  return self.v_tail - self.v_head + 1
end

return M
