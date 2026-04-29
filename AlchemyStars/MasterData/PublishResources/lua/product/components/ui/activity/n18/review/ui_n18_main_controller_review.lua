_class("UIN18MainController_Review", UIController)
UIN18MainController_Review = UIN18MainController_Review

function UIN18MainController_Review:LoadDataOnEnter(TT, res, uiParams)
  if not self.data then
    self.data = N18ReviewData:New()
  end
  self.mCampaign = self.data:GetCampaignModule()
  self.data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_REVIEW_N18, res)
  self.isShow = true
end

function UIN18MainController_Review:OnShow(uiParams)
  N18ReviewData.SetPrefsMain()
  self.atlas = self:GetAsset("UIN18.spriteatlas", LoadType.SpriteAtlas)
  self._useColor = {
    Color(1, 1, 1, 1),
    Color(0.36470588235294116, 0.36470588235294116, 0.36470588235294116, 0.8470588235294118)
  }
  local btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._backBtns = btns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIMain)
  end, nil, nil, false, function()
    if self.isShow then
      self.isShow = false
      self:ShowHideUI()
    end
  end)
  self.animTopBtns = self._backBtns:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self.btnStageNormal = self:GetUIComponent("Button", "btnStageNormal")
  self.redStageNormal = self:GetGameObject("redStageNormal")
  self.lockStage = self:GetGameObject("lockStage")
  self.hardLockStage = self:GetGameObject("hardLockStage")
  self.newStageHard = self:GetGameObject("newStageHard")
  self.newCatchFish = self:GetGameObject("newCatchFish")
  self.lockImage = self:GetGameObject("lockImage")
  self._spineLoader = self:GetGameObject("spine")
  self:AttachEvent(GameEventType.QuestUpdate, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnComponentStepChange)
  self.mask_big_root = self:GetGameObject("maskBigRoot")
  self.mask_big_root:SetActive(false)
  self.mask_big = self:GetUIComponent("MeshRenderer", "maskBig")
  self.mask_big2 = self:GetUIComponent("MeshRenderer", "maskBig2")
  self.reqBg = ResourceManager:GetInstance():SyncLoadAsset("n18_zjm_bg1" .. ".mat", LoadType.Mat)
  self.bgAsset = self.reqBg.Obj
  self.mask_big.material:SetTexture("_MainTex1", self.bgAsset:GetTexture("_MainTex"))
  self.mask_big2.material:SetTexture("_MainTex1", self.bgAsset:GetTexture("_MainTex"))
  self.anim = self:GetUIComponent("Animation", "anim")
  self.rt = self:GetUIComponent("RawImage", "rt")
  self:Flush()
  if self:_SetImgRT(uiParams[1]) then
    self.mask_big_root:SetActive(true)
    UIWidgetHelper.PlayAnimation(self, "anim", "eff_UIN18MainController_Review_in", 500, function()
      self.rt.gameObject:SetActive(false)
    end)
  else
    self.rt.gameObject:SetActive(false)
  end
end

function UIN18MainController_Review:_PlayAnimIn()
  self:StartTask(function(TT)
    self.mask_big_root:SetActive(true)
    local lockName = self:GetName() .. "_PlayAnimIn()"
    self:Lock(lockName)
    self.anim:Play("eff_UIN18MainController_Review_in")
    YIELD(TT, 1700)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN18MainController_Review)
    self:UnLock(lockName)
  end, self)
end

function UIN18MainController_Review:_PlayAnimOut(cb)
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "_PlayAnimOut()"
    self:Lock(lockName)
    self.anim:Play("eff_UIN18MainController_Review_out")
    YIELD(TT, 500)
    self:UnLock(lockName)
    cb()
  end, self)
end

function UIN18MainController_Review:_SetImgRT(imgRT)
  if imgRT ~= nil then
    self.rt.texture = imgRT
    return true
  end
  return false
end

function UIN18MainController_Review:OnHide()
  self:DetachEvent(GameEventType.QuestUpdate, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._OnComponentStepChange)
  self:CancelTimerEvent(ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON)
  self:CancelTimerEvent(ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD)
  self:CancelTimerEvent(ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME)
  self.data = nil
  self.btnStageNormal = nil
  self.btnStageHard = nil
  self.reqBg:Dispose()
  self.reqBg = nil
end

function UIN18MainController_Review:CancelTimerEvent(nState)
  if nState == ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON then
    if self.teNormal then
      GameGlobal.Timer():CancelEvent(self.teNormal)
      self.teNormal = nil
    end
  elseif nState == ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD then
    if self.teHard then
      GameGlobal.Timer():CancelEvent(self.teHard)
      self.teHard = nil
    end
  elseif nState == ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME and self.teMini then
    GameGlobal.Timer():CancelEvent(self.teMini)
    self.teMini = nil
  end
end

function UIN18MainController_Review:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self.data then
    self:Flush()
  end
end

function UIN18MainController_Review:Flush()
  self:FlushNormalStage()
end

function UIN18MainController_Review:FlushRedPointStageNormal()
  if not self.data then
    return
  end
  local red = self.data:CheckRedNormal() or self.data:CheckRedLevelFixteam()
  self.redStageNormal:SetActive(red)
end

function UIN18MainController_Review:FlushNormalStage()
  self.btnStageNormal.interactable = false
  local cNormalInfo = self.data:GetComponentInfoNormal()
  if not cNormalInfo then
    Log.fatal("### cNormalInfo nil.")
    return
  end
  local state = self.data:GetStateNormal()
  if state == UIN18BtnState.NotOpen then
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cNormalInfo.m_unlock_time)
    self:RegisterTimeEvent(leftSeconds, ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON)
  elseif state == UIN18BtnState.Closed then
    self:CancelTimerEvent(ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON)
  elseif state == UIN18BtnState.Normal then
    self.btnStageNormal.interactable = true
  else
    Log.fatal("### state=", state)
  end
  self:FlushRedPointStageNormal()
end

function UIN18MainController_Review:BgOnClick(go)
  if not self.isShow then
    self.isShow = true
    self:ShowHideUI()
  end
end

function UIN18MainController_Review:IntroBtnOnClick(go)
  self:ShowDialog("UIN18Intro2", "UIN18Main")
end

function UIN18MainController_Review:StageNormalBtnOnClick(go)
  local state = self.data:GetStateNormal()
  if state == UIN18BtnState.Normal then
    self:SwitchState(UIStateType.UIN18LineMissionController_Review)
  else
    self:_ShowBtnErrorMsg(state)
  end
end

function UIN18MainController_Review:_ShowBtnErrorMsg(btnState)
  local errType = 0
  if btnState == UIN18BtnState.NotOpen then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
  elseif btnState == UIN18BtnState.Closed then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
  end
  self.mCampaign:ShowErrorToast(errType, true)
end

function UIN18MainController_Review:ShowHideUI()
  local uielem = self:GetGameObject("UIElements")
  if self.isShow then
    self.anim:Play("eff_UIN18MainController_Review_in_2")
  else
    self.anim:Play("eff_UIN18MainController_Review_out")
  end
end
