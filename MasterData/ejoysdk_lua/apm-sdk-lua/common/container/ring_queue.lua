local RingQueue = {}
RingQueue.__index = RingQueue

function RingQueue.new(capacity)
  assert(capacity > 0, "Capacity must be greater than 0")
  local instance = {
    capacity = capacity,
    queue = {},
    head = 1,
    tail = 1,
    cache = {
      last_mdf = 0,
      last_retrieve = 0,
      data = {}
    },
    size = 0
  }
  setmetatable(instance, RingQueue)
  return instance
end

function RingQueue:enqueue(value)
  self.cache.last_mdf = self.cache.last_mdf + 1
  if self:is_full() then
    self.queue[self.tail] = value
    self.tail = self.tail % self.capacity + 1
    self.head = self.tail
  else
    self.queue[self.tail] = value
    self.tail = self.tail % self.capacity + 1
    self.size = self.size + 1
  end
end

function RingQueue:dequeue()
  if 0 == self.size then
    return nil
  end
  self.cache.last_mdf = self.cache.last_mdf + 1
  local value = self.queue[self.head]
  self.queue[self.head] = nil
  self.head = self.head % self.capacity + 1
  self.size = self.size - 1
  return value
end

function RingQueue:clear()
  self.queue = {}
  self.head = 1
  self.tail = 1
  self.size = 0
  self.cache = {
    last_mdf = 0,
    last_retrieve = 0,
    data = {}
  }
end

function RingQueue:peek()
  if 0 == self.size then
    return nil
  end
  return self.queue[self.head]
end

function RingQueue:back()
  if 0 == self.size then
    return nil
  end
  local last_index = self.tail - 1
  if 0 == last_index then
    last_index = self.capacity
  end
  return self.queue[last_index]
end

function RingQueue:is_empty()
  return 0 == self.size
end

function RingQueue:is_full()
  return self.size == self.capacity
end

function RingQueue:get_size()
  return self.size
end

function RingQueue:get_all_elements()
  if self.cache.last_mdf == self.cache.last_retrieve and self.cache.last_mdf > 0 then
    return self.cache.data
  end
  local elements = {}
  if 0 == self.size then
    return elements
  end
  local index = self.tail - 1
  if 0 == index then
    index = self.capacity
  end
  for _ = 1, self.size do
    table.insert(elements, self.queue[index])
    index = index - 1
    if 0 == index then
      index = self.capacity
    end
  end
  self.cache.last_retrieve = self.cache.last_mdf
  self.cache.data = elements
  return elements
end

return RingQueue
