_class("IEntityCommand", Object)
IEntityCommand = IEntityCommand

function IEntityCommand:Constructor()
  self.EntityID = nil
end

function IEntityCommand:GetEntityID()
  return self.EntityID
end

function IEntityCommand:GetCommandType()
end

function IEntityCommand:GetExecStateID()
  return 0
end

function IEntityCommand:IsExecExcluded()
  return 0
end

function IEntityCommand:DependRoundCount()
  return true
end

function IEntityCommand:ToNetMessage()
end

function IEntityCommand:FromNetMessage(msg)
end
