_class("UIN19Helper", Object)
UIN19Helper = UIN19Helper

function UIN19Helper:Constructor()
end

function UIN19Helper.GetNewPoint(campaign)
  local sampleNew = campaign:CheckCampaignNew()
  local componentId = ECampaignN19CommonComponentID.PANGOLIN
  local component = campaign:GetComponent(componentId)
  local minigameOp = campaign:CheckComponentOpen(componentId)
  local new = component:NewTaskRed("N19TaskComp", "red")
  local comNew = component:GetPrefsComponentNew("N19TaskComp")
  return sampleNew or new ~= nil and 0 < new or minigameOp and comNew < 1
end
