_class("UIN23MainEnter", UICustomWidget)
UIN23MainEnter = UIN23MainEnter

function UIN23MainEnter:Constructor()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN23Data()
end

function UIN23MainEnter:OnShow(uiParams)
  self.new = self:GetGameObject("new")
  self.red = self:GetGameObject("red")
  self.second = self:GetGameObject("second")
  self.rlt2nd = self:GetUIComponent("RollingText", "txt2nd")
  self:_AttachEvents()
  self:RequestCampaign()
end

function UIN23MainEnter:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:_DetachEvents()
end

function UIN23MainEnter:_AttachEvents()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIN23MainEnter:_DetachEvents()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIN23MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN23MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN23MainEnterRequestCampaign"
    self:Lock(lockName)
    self.data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_N23)
    self:Flush()
    self:FlushNewRed()
    self:UnLock(lockName)
  end, self)
end

function UIN23MainEnter:BtnOnClick(go)
  if self._uiMainLobbyController then
    self._uiMainLobbyController._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self._uiMainLobbyController:GetName())
    local rt = self._uiMainLobbyController._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(UIStateType.UIN23Main, cache_rt, true)
    end)
  else
    self:SwitchState(UIStateType.UIN23Main, nil, true)
  end
end

function UIN23MainEnter:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:FlushNewRed()
  end
end

function UIN23MainEnter:_OnQuestUpdate()
  self:FlushNewRed()
end

function UIN23MainEnter:Flush()
  if self.data:GetStateShop() == UISummerOneEnterBtnState.Normal then
    self.second:SetActive(true)
    self.rlt2nd:RefreshText(StringTable.Get("str_n23_shop_open"))
  else
    self.second:SetActive(false)
  end
end

function UIN23MainEnter:FlushNewRed()
  local notEnterMain = not N23Data.HasPrefsMain()
  local notEnterFilm = not N23Data.HasPrefsFilm()
  local notEnterAdventure = not N23Data.HasPrefsAdventure()
  local notEnterLine = not N23Data.HasPrefsLine()
  local notEnterShop = not N23Data.HasPrefsShop()
  local new = notEnterMain or notEnterFilm or notEnterAdventure or notEnterLine or notEnterShop
  local red = false
  if not new then
    local redAward = self.data:CheckRedAward()
    local redFilm = self.data:CheckRedFilm()
    local redAdventure = self.data:CheckRedAdventure()
    local redNormal = self.data:CheckRedNormal()
    red = redAward or redFilm or redAdventure or redNormal
  end
  UIActivityHelper.SetWidgetNewAndRed(self.new, new, self.red, red)
end
