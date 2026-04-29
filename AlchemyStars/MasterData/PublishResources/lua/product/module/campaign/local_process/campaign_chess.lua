_class("CCampaignChess", ICampaignComponentLocalProcessBase)
CCampaignChess = CCampaignChess

function CCampaignChess:Constructor()
  self._chessComponent = nil
  self._chessCompInfo = nil
  self._campaignObj = nil
end

function CCampaignChess:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_CHESS
end

function CCampaignChess:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignChess:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetChessComponent()
end

function CCampaignChess:_GetChessComponent()
  self._chessComponent = self._campaignObj:GetComponent(ECampaignChessComponentID.ECAMPAIGN_CHESS_MISSION)
  if not self._chessComponent then
    return
  end
  self._chessCompInfo = self._chessComponent:ComponentInfo()
end

function CCampaignChess:GetComponent(componentID)
  if ECampaignChessComponentID.ECAMPAIGN_CHESS_MISSION == componentID then
    return self._chessComponent
  end
  return nil
end

function CCampaignChess:GetComponentInfo(componentID)
  if ECampaignChessComponentID.ECAMPAIGN_CHESS_MISSION == componentID then
    return self._chessCompInfo
  end
  return nil
end

function CCampaignChess:GetStepStatusNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_CHESS)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignChess:GetEntryRedDot()
  return false
end
