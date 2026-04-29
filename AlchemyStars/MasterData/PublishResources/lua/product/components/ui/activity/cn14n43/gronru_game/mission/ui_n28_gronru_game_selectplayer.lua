_class("UIN28GronruGameSelectPlayer", UIController)
UIN28GronruGameSelectPlayer = UIN28GronruGameSelectPlayer

function UIN28GronruGameSelectPlayer:Constructor()
  self._aniCfg = {
    [1] = {
      "idle_1600061",
      "idle_1600061_2"
    },
    [2] = {
      "idle_1000011",
      "idle_1000011_2"
    },
    [3] = {
      "idle_1500331",
      "idle_1500331_2"
    }
  }
end

function UIN28GronruGameSelectPlayer:LoadDataOnEnter(TT, res, uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  local campaignModule = self:GetModule(CampaignModule)
  self._campaignModule = campaignModule
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N28_MINI_GAME, ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    self:Lock("UIN28GronruGameSelectPlayer")
    self:StartTask(function(TT)
      YIELD(TT)
      self:UnLock("UIN28GronruGameSelectPlayer")
      self:CloseDialog()
    end)
    return
  end
  local sample = self._campaign:GetSample()
  self._endTime = sample.end_time
  self._component = self._campaign:GetComponent(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  self._componentInfo = self._campaign:GetComponentInfo(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  local openTime = self._componentInfo.m_unlock_time
  local closeTime = self._endTime
  local nowtime = self._svrTimeModule:GetServerTime() / 1000
  if closeTime < nowtime then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
    campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
end

function UIN28GronruGameSelectPlayer:OnShow(uiParams)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._Refresh)
  self._curPlayerIndex = 2
  UIN28GronruGameConst.SetSelectPlayer(self._curPlayerIndex)
  self:InitWidget()
  self:Flush()
  UIN28GronruGameConst.SetSelectPlayer(self._curPlayerIndex)
  self:PlaySelectAction(self._curPlayerIndex)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN28GronruGameSelectPlayer)
end

function UIN28GronruGameSelectPlayer:OnHide()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._Refresh)
end

function UIN28GronruGameSelectPlayer:InitWidget()
  self.players = {}
  self.playerAnis = {}
  for i = 1, 3 do
    self.players[i] = self:GetUIComponent("RectTransform", "player" .. i)
  end
  for i = 1, 3 do
    self.playerAnis[i] = self:GetUIComponent("Animator", "playerprefab" .. i)
  end
  self._arrow = self:GetUIComponent("RectTransform", "arrow")
  self._anim = self:GetUIComponent("Animation", "root")
  self._anim = self:GetUIComponent("Animation", "root")
  self._againImage = self:GetUIComponent("RectTransform", "againImage")
  self._againImage.gameObject:SetActive(true)
end

function UIN28GronruGameSelectPlayer:Flush()
  for i = 1, #self.playerAnis do
    self.playerAnis[i]:Play(self._aniCfg[i][2])
  end
end

function UIN28GronruGameSelectPlayer:InfobtnOnClick(go)
  if self:CheckActivityOver() then
    return
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
  self:ShowDialog("UIIntroLoader", "UIN28GronruGameIntro")
end

function UIN28GronruGameSelectPlayer:ButtonBackOnClick(go)
  if self:CheckActivityOver() then
    return
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
  self:CloseDialog()
end

function UIN28GronruGameSelectPlayer:GameBtnOnClick(go)
  if self:CheckActivityOver() then
    return
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
  if self:CheckActivityOver() then
    return
  end
  self:StartTask(function(TT)
    self:Lock("UIN28GronruGameSelectPlayer:GameBtnOnClick")
    self._anim:Play("uieff_UIN28GronruGameIntro_out")
    YIELD(TT, 200)
    self:ShowDialog(UIStateType.UIN28GronruGameLevel)
    self:UnLock("UIN28GronruGameSelectPlayer:GameBtnOnClick")
  end)
end

function UIN28GronruGameSelectPlayer:SelectBtnOnClick(go)
  if self:CheckActivityOver() then
    return
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
  self._curPlayerIndex = self._curPlayerIndex + 1
  self._curPlayerIndex = self._curPlayerIndex % 3 == 0 and 3 or self._curPlayerIndex % 3
  self._arrow.anchoredPosition = Vector2(self.players[self._curPlayerIndex].anchoredPosition.x, self._arrow.anchoredPosition.y)
  UIN28GronruGameConst.SetSelectPlayer(self._curPlayerIndex)
  self:PlaySelectAction(self._curPlayerIndex)
end

function UIN28GronruGameSelectPlayer:PlaySelectAction(index)
  for i = 1, #self.playerAnis do
    if index == i then
      self.playerAnis[i]:Play(self._aniCfg[i][1])
    else
      self.playerAnis[i]:Play(self._aniCfg[i][2])
    end
  end
end

function UIN28GronruGameSelectPlayer:CheckActivityOver()
  local closeTime = self._endTime
  local nowtime = self._svrTimeModule:GetServerTime() * 0.001
  if closeTime < nowtime then
    self:CloseDialog()
    return true
  end
  return false
end

function UIN28GronruGameSelectPlayer:_Refresh(bo)
  local topDepth = GameGlobal.UIStateManager().uiControllerManager:TopDepth()
  if topDepth == self:GetDepth() and not self:CheckActivityOver() then
    self:PlaySelectAction(self._curPlayerIndex)
  end
end
