local Util = require("utils.util")
local M = Util.create_class()

function M:_init()
  self:clear()
end

function M:push(pool, path, owner, callback, id)
  if not path or "" == path then
    assert(false, "path 不能为nil")
  end
  self.v_tail = self.v_tail + 1
  self.v_pools[self.v_tail] = pool
  self.v_paths[self.v_tail] = path
  self.v_owners[self.v_tail] = owner
  self.v_callbacks[self.v_tail] = callback
  self.v_ids[self.v_tail] = id
end

function M:pop()
  local head = self.v_head
  if head > self.v_tail then
    return
  end
  local pool = self.v_pools[head]
  local path = self.v_paths[head]
  local owner = self.v_owners[head]
  local callback = self.v_callbacks[head]
  local id = self.v_ids[head]
  self.v_pools[head] = nil
  self.v_paths[head] = nil
  self.v_owners[head] = nil
  self.v_callbacks[head] = nil
  self.v_ids[head] = nil
  self.v_head = self.v_head + 1
  return pool, path, owner, callback, id
end

function M:get_top()
  local head = self.v_head
  if head > self.v_tail then
    return
  end
  return self.v_pools[head], self.v_paths[head], self.v_owners[head], self.v_callbacks[head], self.v_ids[head]
end

function M:length()
  return self.v_tail - self.v_head + 1
end

function M:clear()
  self.v_head = 1
  self.v_tail = 0
  self.v_pools = {}
  self.v_paths = {}
  self.v_owners = {}
  self.v_callbacks = {}
  self.v_ids = {}
end

return M
