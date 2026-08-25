local StageFsmReqEnter = System.NewClass("StageFsmReqEnter", LinearFsmState)

function StageFsmReqEnter:Enter()
  local recoverData = self.entity:GetRecoverData()
  if recoverData then
    self.entity:HandleEnterWorldData(recoverData)
    self:SetFinish()
  else
    self:ReqEnter()
  end
end

function StageFsmReqEnter:CheckExit()
  if self.entity:GetStageEnterData() then
    return true
  end
end

function StageFsmReqEnter:ReqEnter()
  self.entity:EnterWorldStage(function()
  end)
end

return StageFsmReqEnter
