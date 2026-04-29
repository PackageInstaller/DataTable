_class("UICampaignCenterDanTangPre", UISideEnterCenterContentBase)
UICampaignCenterDanTangPre = UICampaignCenterDanTangPre

function UICampaignCenterDanTangPre:DoInit()
  self:InitWidget()
end

function UICampaignCenterDanTangPre:InitWidget()
  self.red = self:GetGameObject("redGo")
end

function UICampaignCenterDanTangPre:DoLoadData(TT)
end

function UICampaignCenterDanTangPre:DoShow()
  self:_CheckRed()
  self:AttachEvent(GameEventType.DanTangPreAwardCollected, self._CheckRed)
  AudioHelperController.PlayBGM(CriAudioIDConst.BGMDanTang, AudioConstValue.BGMCrossFadeTime)
  self:StartTask(function(TT)
    self._data:ClearCampaignNew(TT)
  end)
end

function UICampaignCenterDanTangPre:DoHide()
  AudioHelperController.PlayBGM(CriAudioIDConst.BGMMainUI, AudioConstValue.BGMCrossFadeTime)
end

function UICampaignCenterDanTangPre:DoDestroy()
end

function UICampaignCenterDanTangPre:AwardBtnOnClick(go)
  self:ShowDialog("UICampaignCenterDanTangPreAwards")
end

function UICampaignCenterDanTangPre:_CheckRed()
  local cptInfo = self._data:GetComponentInfo(ECCampaignInlandS0ComponentID.TIME_REWARD)
  local canCollect = cptInfo.m_reward_info[1].rec_reward_status == ETimeRewardRewardStatus.E_TIME_REWARD_CAN_RECV
  self.red:SetActive(canCollect)
end
