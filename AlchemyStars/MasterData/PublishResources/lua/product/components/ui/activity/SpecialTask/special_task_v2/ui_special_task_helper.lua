_class("UISpecialTaskHelper", Object)
UISpecialTaskHelper = UISpecialTaskHelper

function UISpecialTaskHelper.GetStrIdInCampaign(campaign, strId)
  return strId .. "_campaignid_" .. campaign._id
end

function UISpecialTaskHelper.QuestSort(tb)
  local val = {}
  val[QuestStatus.QUEST_Completed] = 0
  val[QuestStatus.QUEST_Accepted] = 1
  val[QuestStatus.QUEST_Taken] = 2
  val[QuestStatus.QUEST_NotStart] = 3
  table.sort(tb, function(a, b)
    local a_status = a:Status()
    local b_status = b:Status()
    if val[a_status] == val[b_status] then
      return a:ID() < b:ID()
    end
    return val[a_status] < val[b_status]
  end)
end
