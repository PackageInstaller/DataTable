require("test_robot_module")

function TestRobotModule:GoldbergEventGetFullComponentID(campaignID, componentType, componentID)
  return campaignID * CampaignConfigDefine.CONFIG_CAMPAIGN_ID_MOD + componentType * CampaignConfigDefine.CONFIG_COMPONENT_TYPE_MOD + componentID
end

function TestRobotModule:PreparePetsByBuildDataList(TT, tBuildData, status)
  for _, petBuildData in ipairs(tBuildData) do
    local cmdAddPet = string.format("add_asset %s %d 1", self:GetTestAccountOpenID(), petBuildData:GetTemplateID())
    self:AsyncGM_AddAsset(TT, status, petBuildData:GetTemplateID(), 1)
    local cmdChangePet = petBuildData:GenerateGMCommand()
    self:__AsyncSendGM(TT, status, cmdChangePet)
  end
end
