_class("GuideCommand", IEntityCommand)
GuideCommand = GuideCommand

function GuideCommand:Constructor()
  self._commandType = "Guide"
  self._petPstId = nil
end

function GuideCommand:GetExecStateID()
  return {
    GameStateID.WaitInput,
    GameStateID.PickUpActiveSkillTarget
  }
end

function GuideCommand:IsExecExcluded()
  return 0
end

function GuideCommand:DependRoundCount()
  return false
end

function GuideCommand:SetPetPstId(pstId)
  self._petPstId = pstId
end

function GuideCommand:GetPetPstId(pstId)
  return self._petPstId
end

function GuideCommand:SetGuideStepID(guideStepID)
  self._guideStepID = guideStepID
end

function GuideCommand:GetGuideStepID()
  return self._guideStepID
end

function GuideCommand:GetCommandType()
  return self._commandType
end

function GuideCommand:ToNetMessage()
  local msg = CEventGuideCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.PetPstID = self._petPstId
  msg.GuideStepID = self._guideStepID
  return msg
end

function GuideCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  self._petPstId = msg.PetPstID
  self._guideStepID = msg.GuideStepID
end
