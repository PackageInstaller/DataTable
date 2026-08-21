require("campaign_component_local_process_base")
_class("CCampaignBattlePass", ICampaignComponentLocalProcessBase)
CCampaignBattlePass = CCampaignBattlePass

function CCampaignBattlePass:Constructor()
  self._lvRewardComponent = nil
  self._lvRewardCompInfo = nil
  self._camQuestComponet1 = nil
  self._camQuestComponetInfo1 = nil
  self._camQuestComponet2 = nil
  self._camQuestComponetInfo2 = nil
  self._camQuestComponet3 = nil
  self._camQuestComponetInfo3 = nil
  self._buyGiftComponent = nil
  self._buyGiftComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignBattlePass:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_BATTLEPASS
end

function CCampaignBattlePass:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignBattlePass:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLVRewardComponent()
  self:_GetCamQuestComponent1()
  self:_GetCamQuestComponent2()
  self:_GetCamQuestComponent3()
  self:_GetBuyGiftComponent()
end

function CCampaignBattlePass:_GetLVRewardComponent()
  self._lvRewardComponent = self._campaignObj:GetComponent(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD)
  if not self._lvRewardComponent then
    return
  end
  self._lvRewardCompInfo = self._lvRewardComponent:ComponentInfo()
end

function CCampaignBattlePass:_GetCamQuestComponent1()
  self._camQuestComponet1 = self._campaignObj:GetComponent(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1)
  if not self._camQuestComponet1 then
    return
  end
  self._camQuestComponetInfo1 = self._camQuestComponet1:ComponentInfo()
end

function CCampaignBattlePass:_GetCamQuestComponent2()
  self._camQuestComponet2 = self._campaignObj:GetComponent(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2)
  if not self._camQuestComponet2 then
    return
  end
  self._camQuestComponetInfo2 = self._camQuestComponet2:ComponentInfo()
end

function CCampaignBattlePass:_GetCamQuestComponent3()
  self._camQuestComponet3 = self._campaignObj:GetComponent(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3)
  if not self._camQuestComponet3 then
    return
  end
  self._camQuestComponetInfo3 = self._camQuestComponet3:ComponentInfo()
end

function CCampaignBattlePass:_GetBuyGiftComponent()
  self._buyGiftComponent = self._campaignObj:GetComponent(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  if not self._buyGiftComponent then
    return
  end
  self._buyGiftComponentInfo = self._buyGiftComponent:ComponentInfo()
end

function CCampaignBattlePass:GetComponent(componentID)
  if ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD == componentID then
    return self._lvRewardComponent
  end
  if ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1 == componentID then
    return self._camQuestComponet1
  end
  if ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2 == componentID then
    return self._camQuestComponet2
  end
  if ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3 == componentID then
    return self._camQuestComponet3
  end
  if ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT == componentID then
    return self._buyGiftComponent
  end
  return nil
end

function CCampaignBattlePass:GetComponentInfo(componentID)
  if ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD == componentID then
    return self._lvRewardCompInfo
  end
  if ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1 == componentID then
    return self._camQuestComponetInfo1
  end
  if ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2 == componentID then
    return self._camQuestComponetInfo2
  end
  if ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3 == componentID then
    return self._camQuestComponetInfo3
  end
  if ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT == componentID then
    return self._buyGiftComponentInfo
  end
  return nil
end
