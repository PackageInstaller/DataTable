local M = {}
local mt = {}

local function _new_block(v)
  local block = {
    value = v,
    next = false,
    prev = false
  }
  return block
end

local endian_fmt = {little = "<", big = ">"}

local function pack_data(data, header_len, endian)
  local len = #data
  local fmt = endian_fmt[endian] .. "I" .. header_len .. "c" .. len
  return string.pack(fmt, len, data)
end

local function insert_free_list(self, block)
  block.prev = false
  block.next = false
  local count = self.v_free_list_count
  count = count + 1
  self.v_free_list_count = count
  self.v_free_list[count] = block
end

local function get_block(self)
  local count = self.v_free_list_count
  if count > 0 then
    local block = self.v_free_list[count]
    self.v_free_list[count] = nil
    self.v_free_list_count = count - 1
    return block
  else
    return _new_block()
  end
end

local function free_block(self, block)
  local next = block.next
  local prev = block.prev
  if next then
    next.prev = prev
  end
  if prev then
    prev.next = next
  end
  insert_free_list(self, block)
end

local function init_buffer(self)
  local DEF_FREE_BLOCK = 3
  for i = 1, DEF_FREE_BLOCK do
    insert_free_list(self, _new_block())
  end
end

local function create()
  local raw = {
    v_free_list = {},
    v_free_list_count = 0,
    v_block_head = false,
    v_block_tail = false,
    v_size = 0
  }
  init_buffer(raw)
  setmetatable(raw, {__index = mt})
  return raw
end

function mt:push(data)
  local block = get_block(self)
  block.value = data
  local size = self.v_size
  self.v_size = size + #data
  if not self.v_block_head then
    assert(self.v_block_tail == false)
    self.v_block_head = block
  end
  local tail = self.v_block_tail
  if tail then
    tail.next = block
    block.prev = tail
    block.next = false
  end
  self.v_block_tail = block
end

local buff = {}

function mt:look(nbytes)
  local head = self.v_block_head
  local size = self.v_size
  if head and nbytes > 0 and nbytes <= size then
    local count = 0
    local index = 0
    while head and count ~= nbytes do
      local value = head.value
      local len = #value
      if nbytes < count + len then
        local sub = nbytes - count
        value = string.sub(value, 1, sub)
        count = count + sub
      else
        count = count + len
      end
      index = index + 1
      buff[index] = value
      head = head.next
    end
    return table.concat(buff, "", 1, index)
  end
  return false
end

function mt:pop(nbytes)
  local head = self.v_block_head
  nbytes = nbytes or head and #head.value
  if head and nbytes > 0 and nbytes <= self.v_size then
    local count = 0
    local index = 0
    while head and count ~= nbytes do
      local len = #head.value
      index = index + 1
      if nbytes < count + len then
        local sub = nbytes - count
        local value = head.value
        local sub_value = string.sub(value, 1, sub)
        buff[index] = sub_value
        count = count + sub
        head.value = string.sub(value, sub + 1)
      else
        count = count + len
        buff[index] = head.value
        local next = head.next
        free_block(self, head)
        head = next
      end
    end
    self.v_block_head = head
    self.v_size = self.v_size - count
    if not head then
      self.v_block_tail = false
    end
    local ret = table.concat(buff, "", 1, index)
    assert(#ret == nbytes)
    return ret
  end
  return false
end

function mt:pop_all(out)
  local v = self:pop()
  local count = 0
  while v do
    count = count + 1
    out[count] = v
    v = self:pop()
  end
  return count
end

function mt:push_block(data, header_len, endian)
  data = pack_data(data, header_len, endian)
  self:push(data)
end

function mt:pop_block(header_len, endian)
  if header_len < self.v_size then
    local header = self:look(header_len)
    local fmt = endian_fmt[endian] .. "I" .. header_len
    local len = string.unpack(fmt, header)
    if self.v_size >= len + header_len then
      self:pop(header_len)
      return self:pop(len)
    end
  end
  return false
end

function mt:pop_all_block(out, header_len, endian)
  local v = self:pop_block(header_len, endian)
  local count = 0
  while v do
    count = count + 1
    out[count] = v
    v = self:pop_block(header_len, endian)
  end
  return count
end

function mt:clear()
  local head = self.v_block_head
  while head do
    insert_free_list(self, head)
    head = head.next
  end
  self.v_block_head = false
  self.v_block_tail = false
  self.v_size = 0
end

function mt:get_head_data()
  local head = self.v_block_head
  return head and head.value or false
end

local function _dump_list(list)
  while list do
    print(" node = ", list)
    for k, v in pairs(list) do
      print(" ", k, v)
    end
    print("----------")
    list = list.next
  end
end

function mt:dump()
  print("==== meta info ====")
  for k, v in pairs(self) do
    print(k, v)
  end
  print("===== free list ====", self.v_free_list_count)
  local free_list = self.v_free_list
  for k, v in pairs(free_list) do
    print(k, v)
  end
  print("===== head list ====")
  _dump_list(self.v_block_head)
end

return {create = create, pack_data = pack_data}
