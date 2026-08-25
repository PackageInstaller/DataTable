local Queue = {}

function Queue.create()
  do return setmetatable, {
    queue = {},
    head = 0,
    tail = -1
  } end
  return setmetatable, {
    queue = {},
    head = 0,
    tail = -1
  }, {__index = Queue}, Queue
end

function Queue.enqueue(Q, v)
  Q.tail = Q.tail + 1
  Q.queue[Q.tail] = v
end

function Queue.dequeue(Q)
  if Q.tail < Q.head then
    return nil
  end
  local v = Q.queue[Q.head]
  Q.queue[Q.head] = nil
  Q.head = Q.head + 1
  if Q.tail < Q.head then
    Q.tail = -1
    Q.head = 0
  end
  return v
end

function Queue.get_item(Q, index)
  assert(index > 0)
  return Q.queue[Q.head + index - 1]
end

function Queue.qsize(Q)
  return Q.tail - Q.head + 1
end

return Queue
