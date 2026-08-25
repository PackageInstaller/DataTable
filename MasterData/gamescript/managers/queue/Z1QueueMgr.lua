local Z1QueueMgr, Super = System.NewClass("Z1QueueMgr", Manager, IUpdater)

function Z1QueueMgr:ctor()
  Super.ctor(self)
end

function Z1QueueMgr:Awake()
  Super.Awake(self)
  self.queueList = {}
end

function Z1QueueMgr:CreateQueue()
  local queue = Z1Queue()
  table.insert(self.queueList, queue)
  return queue
end

function Z1QueueMgr:DestroyQueue(queue)
  for index, _q in ipairs(self.queueList) do
    if _q == queue then
      table.remove(self.queueList, index)
      break
    end
  end
  queue:OnDestroy()
end

function Z1QueueMgr:Update()
  for i, queue in ipairs(self.queueList) do
    queue:Update()
  end
end

function Z1QueueMgr:OnDestroy()
  Super.OnDestroy(self)
  self.queueList = nil
end

return Z1QueueMgr
