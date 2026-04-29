_class("IEntityCommandPreHandler", Object)
IEntityCommandPreHandler = IEntityCommandPreHandler

function IEntityCommandPreHandler:BindOwner(owner)
end

function IEntityCommandPreHandler:UnBindOwner()
end

function IEntityCommandPreHandler:PreHandleCommand(cmd)
end

_class("CommandSenderComponent", Object)
CommandSenderComponent = CommandSenderComponent

function CommandSenderComponent:Constructor(preHandler)
  self.SendQueue = ArrayList:New()
  self.preHandler = preHandler
end

function CommandSenderComponent:WEC_PostInitialize(owner)
  self._CSC_OwnerEntity = owner
  if self.preHandler then
    self.preHandler:BindOwner(owner)
  end
end

function CommandSenderComponent:WEC_PostRemoved()
  if self.preHandler then
    self.preHandler:UnBindOwner()
    self.preHandler = nil
  end
  self.SendQueue:Clear()
end

function CommandSenderComponent:PreHandleCommand()
  if self.preHandler then
    for i = 1, self.SendQueue:Size() do
      self.preHandler.PreHandleCommand(self.SendQueue:GetAt(i))
    end
  end
end

function CommandSenderComponent:SetPreHandle(pre_handle)
  self.preHandler = pre_handle
  self.preHandler:BindOwner(self._CSC_OwnerEntity)
end

function Entity:CommandSender()
  return self:GetComponent(self.WEComponentsEnum.CommandSender)
end

function Entity:HasCommandSender()
  return self:HasComponent(self.WEComponentsEnum.CommandSender)
end

function Entity:AddCommandSender(preHandler)
  local index = self.WEComponentsEnum.CommandSender
  local component = CommandSenderComponent:New(preHandler)
  self:AddComponent(index, component)
end

function Entity:PushCommand(cmd)
  if not self:HasCommandSender() then
    Log.fatal("Entity:PushCommand must has CommandSenderComponent!")
    return
  end
  local battleStatCmpt = self._world:BattleStat()
  cmd.EntityID = self:GetID()
  cmd.RoundCount = battleStatCmpt:GetGameRoundCount()
  cmd.IsAutoFight = battleStatCmpt:GetAutoFight()
  cmd.ClientWaitInput = battleStatCmpt:GetWaitInputCount()
  local cmdIndex = battleStatCmpt:IncPushCommandIndex()
  cmd.CmdIndex = cmdIndex
  if cmd:GetCommandType() ~= "BattleSync" then
    Log.debug("[LuaCommand] send command ", echo_one_line(ELogLevel.Debug, cmd))
  end
  local index = self.WEComponentsEnum.CommandSender
  local cmdsender = self:CommandSender()
  cmdsender.SendQueue:PushBack(cmd)
  self:ReplaceComponent(index, cmdsender)
end
