_class("UIN18MainEnter", UICustomWidget)
UIN18MainEnter = UIN18MainEnter

function UIN18MainEnter:OnShow(uiParams)
  self.atlas = self:GetAsset("UIN18.spriteatlas", LoadType.SpriteAtlas)
  self.new = self:GetGameObject("new")
  self.red = self:GetGameObject("red")
  self.second = self:GetGameObject("second")
  self.secondImg = self:GetUIComponent("Image", "second")
  self.rlt2nd = self:GetUIComponent("RollingText", "txt2nd")
  self.rltGame = self:GetUIComponent("RollingText", "txtGame")
  self:_AttachEvents()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = N18Data:New()
  self:RequestCampaign()
end

function UIN18MainEnter:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:_DetachEvents()
end

function UIN18MainEnter:_AttachEvents()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIN18MainEnter:_DetachEvents()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIN18MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN18MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN18MainEnterRequestCampaign"
    self:Lock(lockName)
    self.data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_N18)
    self:Flush()
    self:FlushNewRed()
    self:UnLock(lockName)
  end, self)
end

function UIN18MainEnter:btnOnClick(go)
  if self._uiMainLobbyController then
    self._uiMainLobbyController._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self._uiMainLobbyController:GetName())
    local rt = self._uiMainLobbyController._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(UIStateType.UIN18Main, cache_rt)
    end)
  else
    self:SwitchState(self._stateType)
  end
end

function UIN18MainEnter:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:FlushNewRed()
  end
end

function UIN18MainEnter:_OnQuestUpdate()
  self:FlushNewRed()
end

function UIN18MainEnter:Flush()
  local state = self.data:GetStateHard()
  self.second:SetActive(false)
  if state == UIN18BtnState.Locked or state == UIN18BtnState.Normal then
    self.second:SetActive(false)
    self.rlt2nd.gameObject:SetActive(false)
    self.rltGame.gameObject:SetActive(false)
    self.secondImg.sprite = self.atlas:GetSprite("n18_zjm_state1")
  end
  state = self.data:GetStateMiniGame()
  if state == UIN18BtnState.Locked or state == UIN18BtnState.Normal then
    self.second:SetActive(true)
    self.rlt2nd.gameObject:SetActive(false)
    self.rltGame.gameObject:SetActive(true)
    self.secondImg.sprite = self.atlas:GetSprite("n18_zjm_state2")
  end
end

function UIN18MainEnter:FlushNewRed()
  local notEnterMain = not N18Data.HasPrefsMain()
  local notEnterHard = not N18Data.HasPrefsHard()
  local notEnterMinigame = not N18Data.HasPrefsMiniGame()
  local hasHardOpen = self.data:GetStateHard() == UIN18BtnState.Normal
  local hasMinigameOpen = self.data:GetStateMiniGame() == UIN18BtnState.Normal
  local new = notEnterMain or hasHardOpen and notEnterHard or hasMinigameOpen and notEnterMinigame
  local red = false
  if not new then
    local redMiniGame = self.data:CheckRedMiniGame() and hasMinigameOpen
    red = self.data:CheckRedCumulativeLogin() or self.data:CheckRedNormal() or redMiniGame or self.data:CheckRedLevelFixteam()
  end
  UIActivityHelper.SetWidgetNewAndRed(self.new, new, self.red, red)
end
