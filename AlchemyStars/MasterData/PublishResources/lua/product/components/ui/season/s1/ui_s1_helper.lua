_class("UIS1Helper", Object)
UIS1Helper = UIS1Helper

function UIS1Helper.GetQuestInfo_BySeasonFilter(component)
  if component == nil then
    return {}
  end
  local filter = {
    [CampaignQuestStatus.CQS_NotStart] = false,
    [CampaignQuestStatus.CQS_Accepted] = true,
    [CampaignQuestStatus.CQS_Completed] = true,
    [CampaignQuestStatus.CQS_Taken] = true,
    [CampaignQuestStatus.CQS_Over] = false
  }
  local questList = component:GetQuestInfo_ByCampaignQuestStatus(filter)
  return questList
end

function UIS1Helper.HideQuest(tb_in)
  local tb_out = {}
  local tb_remove = {
    [800223] = true,
    [800227] = true
  }
  for i, v in ipairs(tb_in) do
    local quest = v:QuestInfo()
    if not tb_remove[quest.quest_id] then
      table.insert(tb_out, v)
    end
  end
  return tb_out
end
