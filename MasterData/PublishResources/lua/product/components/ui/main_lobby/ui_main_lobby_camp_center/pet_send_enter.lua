require("main_lobby_center_camp_data")
_class("PetSendEnter", MainLobbyCenterCampData)
PetSendEnter = PetSendEnter

function PetSendEnter:LoadData(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_OPTION_PET, ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_QUEST, ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_PERSON_PROCESS)
  self.localProcess = self._campaign:GetLocalProcess()
  self._questCom = self.localProcess:GetComponent(ECampaignOptionPetComponentID.CAMPAIGN_TYPE_OPTION_PET)
  self._questComInfo = self.localProcess:GetComponentInfo(ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_QUEST)
  self._progressInfo = self.localProcess:GetComponentInfo(ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_PERSON_PROCESS)
  self._questModule = GameGlobal.GetModule(QuestModule)
end

function PetSendEnter:CheckNew()
  return self._campaign:CheckCampaignNew() and 1 or 0
end

function PetSendEnter:CheckRed()
  if not self._progressInfo then
    return 0
  end
  for k, v in pairs(self._progressInfo.m_progress_rewards) do
    if self:GetState(k) == QuestStatus.QUEST_Completed then
      return 1
    end
  end
  if not self._questComInfo then
    return 0
  end
  local questList = self._questComInfo.m_accept_cam_quest_list
  self._questList = {}
  for k, v in pairs(questList) do
    if self._questModule:GetQuest(v):QuestInfo().status == QuestStatus.QUEST_Completed then
      return 1
    end
  end
  return 0
end

function PetSendEnter:GetState(progress)
  local cur = self._progressInfo.m_current_progress
  local pass = self._progressInfo.m_received_progress
  if table.icontains(pass, progress) then
    return QuestStatus.QUEST_Taken
  end
  if progress <= cur then
    return QuestStatus.QUEST_Completed
  end
  return QuestStatus.QUEST_Accepted
end
