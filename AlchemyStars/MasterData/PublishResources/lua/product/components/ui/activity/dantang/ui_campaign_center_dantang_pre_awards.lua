_class("UICampaignCenterDanTangPreAwards", UIController)
UICampaignCenterDanTangPreAwards = UICampaignCenterDanTangPreAwards

function UICampaignCenterDanTangPreAwards:LoadDataOnEnter(TT, res)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  res:SetSucc(true)
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_S0, ECCampaignInlandS0ComponentID.TIME_REWARD)
  if not res:GetSucc() then
    Log.fatal("请求丹棠预热活动数据失败:", res:GetResult())
    campaignModule:ShowErrorToast(res:GetResult(), true)
  end
  if not self._campaign:CheckComponentOpen(ECCampaignInlandS0ComponentID.TIME_REWARD) then
    Log.error("丹棠预热奖励组件已关闭")
    res:SetSucc(false)
    return
  end
  self._awardCpt = self._campaign:GetComponent(ECCampaignInlandS0ComponentID.TIME_REWARD)
  self._awardCptInfo = self._awardCpt:GetComponentInfo()
  self._awardInfo = self._awardCptInfo.m_reward_info[1]
end

function UICampaignCenterDanTangPreAwards:OnShow(uiParams)
  self:InitWidget()
  local assets = self._awardInfo.rewards
  local uiAssets = self.awards:SpawnObjects("UIDanTangPreAwardsItem", #assets)
  for i = 1, #assets do
    uiAssets[i]:SetData(assets[i], function(id, go)
      self:_OnClickAsset(id, go)
    end)
  end
  self._canCollect = self._awardInfo.rec_reward_status == ETimeRewardRewardStatus.E_TIME_REWARD_CAN_RECV
  self._red:SetActive(self._canCollect)
  self._collectBtn:SetActive(self._canCollect)
  self._collected:SetActive(not self._canCollect)
  if self._awardInfo.rec_reward_status == ETimeRewardRewardStatus.E_TIME_REWARD_CAN_RECV then
  elseif self._awardInfo.rec_reward_status == ETimeRewardRewardStatus.E_TIME_REWARD_RECVED then
  else
    Log.error("丹棠预热奖励领取状态错误:", self._award.rec_reward_status)
  end
  self._mainCampaignID = uiParams[1]
end

function UICampaignCenterDanTangPreAwards:InitWidget()
  self.awards = self:GetUIComponent("UISelectObjectPath", "awards")
  self._selectInfo = self:GetUIComponent("UISelectObjectPath", "selectInfo"):SpawnObject("UISelectInfo")
  self._selectInfo:SetType(3)
  local detailObj = self._selectInfo:GetG3CustomPool()
  detailObj.dynamicInfoOfEngine:SetObjectName("UISelectInfoDanTang.prefab")
  self._selectDetail = detailObj:SpawnObject("UISelectInfoDantang")
  self._red = self:GetGameObject("red")
  self._collectBtn = self:GetGameObject("CollectBtn")
  self._collected = self:GetGameObject("Collected")
end

function UICampaignCenterDanTangPreAwards:_OnClickAsset(id, go)
  self._selectDetail:SetData(id)
  self._selectInfo:OnlyShow(go.transform.position)
end

function UICampaignCenterDanTangPreAwards:CollectBtnOnClick(go)
  if not self._canCollect then
    return
  end
  self:StartTask(self._ReqAward, self)
end

function UICampaignCenterDanTangPreAwards:_ReqAward(TT)
  local res = AsyncRequestRes:New()
  local assets = self._awardCpt:HandleTakeTimeRewardReward(TT, res, self._awardInfo.reward_id)
  if not res:GetSucc() then
    self:GetModule(CampaignModule):CheckErrorCode(res:GetResult(), self._mainCampaignID)
    if res:GetResult() == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED then
      self:CloseDialog()
    end
    return
  end
  self._awardCpt = self._campaign:GetComponent(ECCampaignInlandS0ComponentID.TIME_REWARD)
  self._awardCptInfo = self._awardCpt:GetComponentInfo()
  self._awardInfo = self._awardCptInfo.m_reward_info[1]
  self._canCollect = self._awardInfo.rec_reward_status == ETimeRewardRewardStatus.E_TIME_REWARD_CAN_RECV
  self._red:SetActive(self._canCollect)
  self._collectBtn:SetActive(self._canCollect)
  self._collected:SetActive(not self._canCollect)
  if assets and 0 < #assets then
    self:ShowDialog("UIGetItemController", assets)
  else
    Log.error("丹棠预热奖励领取为空")
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DanTangPreAwardCollected)
end

function UICampaignCenterDanTangPreAwards:CloseBtnOnClick(go)
  self:CloseDialog()
end
