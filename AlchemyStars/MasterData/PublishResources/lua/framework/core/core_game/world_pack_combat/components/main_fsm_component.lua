_class("IFSM", Object)

function IFSM:UpdateFSM(dt)
end

function IFSM:CurrentStateType()
end

_class("MainFSMComponent", Object)

function MainFSMComponent:Constructor(configID)
  self.createInfo = {ConfigID = configID}
end

function MainFSMComponent:WEC_PostInitialize(owner)
  local createInfo = self.createInfo
  createInfo.OwnerEntity = owner
  self.fsmImp = FSMFactory:GetInstance():CreateFSM(createInfo)
end

function MainFSMComponent:WEC_PostRemoved()
  FSMFactory:GetInstance():DestroyFSM(self.fsmImp)
  self.fsmImp = nil
end

function MainFSMComponent:CurStateID()
  return self.fsmImp:CurrentStateType()
end

function MainFSMComponent:HandleCommand(cmd)
  if self.fsmImp.HandleCommand then
    return self.fsmImp:HandleCommand(cmd)
  end
end

function MainFSMComponent:Update(delta_time)
  return self.fsmImp:Update(delta_time)
end

function Entity:MainFSM()
  return self:GetComponent(self.WEComponentsEnum.MainFSM)
end

function Entity:HasMainFSM()
  return self:HasComponent(self.WEComponentsEnum.MainFSM)
end

function Entity:AddMainFSM(configID)
  local index = self.WEComponentsEnum.MainFSM
  local component = MainFSMComponent:New(configID)
  self:AddComponent(index, component)
end

function Entity:ReplaceMainFSM(configID)
  local index = self.WEComponentsEnum.MainFSM
  local component = MainFSMComponent:New(configID)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveMainFSM()
  if self:HasMainFSM() then
    self:RemoveComponent(self.WEComponentsEnum.MainFSM)
  end
end
