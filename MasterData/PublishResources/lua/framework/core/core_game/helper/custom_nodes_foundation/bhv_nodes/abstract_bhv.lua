require("custom_node")
_class("HasBeginBhv", CustomNode)
HasBeginBhv = HasBeginBhv

function HasBeginBhv:Constructor()
  self.firstUpdate = true
end

function HasBeginBhv:Reset()
  self.firstUpdate = true
end

function HasBeginBhv:Update(dt)
  if self.firstUpdate then
    self.firstUpdate = false
    self:OnBegin()
  end
  self:OnUpdate(dt)
end

function HasBeginBhv:Destroy()
  self.firstUpdate = true
end

function HasBeginBhv:OnBegin()
end

function HasBeginBhv:OnUpdate(dt)
end
