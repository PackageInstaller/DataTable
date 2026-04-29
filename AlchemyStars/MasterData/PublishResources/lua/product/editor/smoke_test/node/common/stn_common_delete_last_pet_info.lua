require("common_async_base")
_class("Common_DeleteLastPetInfo", Common_AsyncBase)
Common_DeleteLastPetInfo = Common_DeleteLastPetInfo

function Common_DeleteLastPetInfo:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local currentTemplateID = runData:GetCurrentTeamBuildFormationTemplateID()
  for _, petTemplateID in ipairs(currentTemplateID) do
    runData._petInfo[petTemplateID] = nil
  end
end
