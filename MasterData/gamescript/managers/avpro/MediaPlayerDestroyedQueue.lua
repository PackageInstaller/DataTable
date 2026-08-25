local MediaPlayerDestroyedQueue, Super = System.NewClass("MediaPlayerDestroyedQueue")
local Time = CS.UnityEngine.Time

function MediaPlayerDestroyedQueue:ctor()
  Super.ctor(self)
  self.toDestroyGameobjects = {}
end

function MediaPlayerDestroyedQueue:CloseMedia(rootNode)
  if IsNil(rootNode) then
    return
  end
  local item = {}
  rootNode:SetActive(false)
  rootNode.transform:SetParent(nil)
  item.rootNode = rootNode
  item.time = Time.time
  table.insert(self.toDestroyGameobjects, item)
  if not self.isRunning then
    self.isRunning = true
    UpdateBeat.Instance:Add(self.Update, self)
  end
end

function MediaPlayerDestroyedQueue:Update()
  if not self.toDestroyGameobjects or 0 == #self.toDestroyGameobjects then
    self.isRunning = false
    UpdateBeat.Instance:Remove(self.Update, self)
    return
  end
  local index = 1
  while index <= #self.toDestroyGameobjects do
    local rootNode = self.toDestroyGameobjects[index].rootNode
    local time = self.toDestroyGameobjects[index].time
    if Time.time - time >= 1.0 then
      table.remove(self.toDestroyGameobjects, index)
    else
      index = index + 1
    end
  end
end

MediaPlayerDestroyedQueue.Instance = MediaPlayerDestroyedQueue()
return MediaPlayerDestroyedQueue
