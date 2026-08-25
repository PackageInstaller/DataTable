local EM = require("ejoysdk_lua.ejoysdk_module")
local Queue = {}
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "queue"

function Queue.create(capacity)
  local q = {
    capacity = capacity,
    data = {},
    size_ = 0,
    head = -1,
    rear = -1
  }
  return q
end

function Queue.enqueue(q, element, error_cb)
  if 0 == q.size_ then
    q.head = 1
    q.rear = 1
    q.size_ = 1
    q.data[q.rear] = element
  else
    local temp = (q.rear + 1) % q.capacity
    if temp == q.head then
      if error_cb then
        error_cb(-1, "the queue is full")
      end
      return
    else
      q.rear = temp
    end
    q.data[q.rear] = element
    q.size_ = q.size_ + 1
  end
end

function Queue.dequeue(q)
  if Queue.isEmpty(q) then
    return
  end
  q.size_ = q.size_ - 1
  local value = q.data[q.head]
  q.data[q.head] = nil
  q.head = (q.head + 1) % q.capacity
  return value
end

function Queue.replace(q, element, compare)
  for i = q.head, q.head + q.size_ - 1 do
    if q.data[i % q.capacity] and compare(q.data[i % q.capacity], element) then
      q.data[i % q.capacity] = element
      return
    end
  end
  Queue.enqueue(q, element)
end

function Queue.traverse(q, func)
  for i = q.head, q.head + q.size_ - 1 do
    if q.data[i % q.capacity] and func then
      local succ, msg = pcall(func, q.data[i % q.capacity])
      print(TAG .. " >> pcall " .. tostring(func) .. " succ >> " .. tostring(succ) .. ", msg >> " .. tostring(msg))
    end
  end
end

function Queue.clear(q)
  q.data = {}
  q.size_ = 0
  q.head = -1
  q.rear = -1
end

function Queue.isEmpty(q)
  if 0 == q.size_ then
    return true
  end
  return false
end

return Queue
