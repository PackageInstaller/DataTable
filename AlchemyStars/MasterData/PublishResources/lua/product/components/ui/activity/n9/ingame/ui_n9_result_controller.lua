_class("UIN9ResultController", UIController)
UIN9ResultController = UIN9ResultController
local UIN9ResultType = {
  Fail = 1,
  Success = 2,
  TestResult = 3
}
_enum("UIN9ResultType", UIN9ResultType)

function UIN9ResultController:LoadDataOnEnter(TT, res, uiParams)
end

function UIN9ResultController:OnShow(uiParams)
  self:InitWidget()
  self._grad = uiParams[1]
  self:_SetGameType(self._grad:GetLevelType())
  self._ingameData = uiParams[2] or {}
  self._gradData = uiParams[3]
  self:_SendResultInfo(self)
  self:ShowResult()
  self:AttachEvent(GameEventType.OnN9SubjectRewardItemClicked, self.ShowTips)
end

function UIN9ResultController:InitWidget()
  self.itemInfo = self:GetUIComponent("UISelectObjectPath", "ItemInfo")
  self.bg = self:GetUIComponent("RawImageLoader", "Bg")
  self.titleText = self:GetUIComponent("UILocalizedTMP", "TitleText")
  self.titleTextContent = self:GetUIComponent("UILocalizedTMP", "TitleTextContent")
  self.testResult = self:GetGameObject("TestResult")
  self.success = self:GetGameObject("Success")
  self.fail = self:GetGameObject("Fail")
  self.sureButton = self:GetGameObject("SureButton")
  self.testSureButton = self:GetGameObject("TestSureButton")
  self.outButton = self:GetGameObject("OutButton")
  self.againButton = self:GetGameObject("AgainButton")
  self.rowItem = self:GetUIComponent("UISelectObjectPath", "RowItem")
  self.rightCountText = self:GetUIComponent("UILocalizationText", "RightCountText")
  self.evaluateText = self:GetUIComponent("UILocalizedTMP", "EvaluateText")
  self.failText = self:GetUIComponent("UILocalizedTMP", "FailText")
  self.failTextContent = self:GetUIComponent("UILocalizedTMP", "FailTextContent")
  self.hadReward = self:GetUIComponent("UILocalizationText", "HadReward")
  self.sureButtonTMP = self:GetUIComponent("UILocalizedTMP", "SureButtonText")
  self.spine = self:GetGameObject("Spine")
  self.cloud = self:GetGameObject("Cloud")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self:SetFontMat(self.evaluateText, "uieff_n9_subject_grade_name.mat")
  self:SetFontMat(self.titleText, "uieff_n9_ingame_success.mat")
  self:SetFontMat(self.titleTextContent, "uieff_n9_ingame_success1.mat")
  self:SetFontMat(self.failText, "uieff_n9_ingame_fail.mat")
  self:SetFontMat(self.failTextContent, "uieff_n9_ingame_fail.mat")
  self:SetFontMat(self.sureButtonTMP, "uieff_n9_ingame_surebtn.mat")
  self.anim = self:GetUIComponent("Animation", "go")
  self.testResult:SetActive(false)
  self.success:SetActive(false)
  self.fail:SetActive(false)
end

function UIN9ResultController:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  if self._resReqs then
    for _, req in ipairs(self._resReqs) do
      req:Dispose()
    end
  end
  self._ingameData = nil
  self:DetachEvent(GameEventType.OnN9SubjectRewardItemClicked, self.ShowTips)
end

function UIN9ResultController:_SetGameType(nType)
  self._gameType = nType
end

function UIN9ResultController:SureButtonOnClick(go)
  self:Lock("UIN9ResultController")
  self:StartTask(function(TT)
    YIELD(TT, 433)
    self:UnLock("UIN9ResultController")
    self:CloseDialog()
    GameGlobal.UIStateManager():CloseDialog("UIN9AnswerController")
  end, self)
end

function UIN9ResultController:AgainButtonOnClick(go)
  if self:CheckActivityOver() then
    self:SwitchState(UIStateType.UIActivityN9MainController)
    return
  end
  self:Lock("UIN9ResultController")
  self:StartTask(function(TT)
    YIELD(TT, 433)
    self:UnLock("UIN9ResultController")
    self:CloseDialog()
    GameGlobal.UIStateManager():CloseDialog("UIN9AnswerController")
    self:ShowDialog("UIN9AnswerController", self._grad, self._gradData)
  end, self)
end

function UIN9ResultController:OutButtonOnClick(go)
  self:Lock("UIN9ResultController")
  self:StartTask(function(TT)
    YIELD(TT, 433)
    self:UnLock("UIN9ResultController")
    self:CloseDialog()
    GameGlobal.UIStateManager():CloseDialog("UIN9AnswerController")
  end, self)
end

function UIN9ResultController:TestSureButtonOnClick(go)
  self:Lock("UIN9ResultController")
  self:StartTask(function(TT)
    YIELD(TT, 433)
    self:UnLock("UIN9ResultController")
    self:CloseDialog()
    GameGlobal.UIStateManager():CloseDialog("UIN9AnswerController")
  end, self)
end

function UIN9ResultController:CoculateResult()
  if self._gameType == 2 then
    return UIN9ResultType.TestResult
  end
  if self._ingameData:CheckAnswers() == self._ingameData:GetTotalCount() then
    return UIN9ResultType.Success
  end
  return UIN9ResultType.Fail
end

function UIN9ResultController:ShowResult()
  local resultType = self:CoculateResult(self._gameType)
  self.curType = resultType
  if resultType == UIN9ResultType.Fail then
    self:_ShowOnFail()
    self:_LoadSpine(3)
  elseif resultType == UIN9ResultType.Success then
    self:_ShowOnSuccess()
    self:_LoadSpine(2)
    self:StartTask(function(TT)
      if self._gameType == 1 then
        self:_GetRewards()
      end
    end, self)
  elseif resultType == UIN9ResultType.TestResult then
    self:_TestOver()
    self:_LoadSpine(1)
  end
end

function UIN9ResultController:GetScrollViewParam()
  local param = UIDynamicScrollViewInitParam:New()
  param.mItemDefaultWithPaddingSize = 150
  return param
end

function UIN9ResultController:_ShowOnSuccess()
  self:_ActiveGo()
  self:StartTask(function(TT)
    self.anim:Play("uieff_Answer_Result")
    YIELD(TT, 330)
    self:ShowSuccessEffect()
  end, self)
end

function UIN9ResultController:ShowSuccessEffect()
  if self._grad:GetHasComplete() then
    self:_HadReward(self._grad:GetHasComplete())
  else
    local rewards = self._gradData:GetRewards()
    self.rowItem:SpawnObjects("UIN9ResultRewardItem", #rewards)
    local items = self.rowItem:GetAllSpawnList()
    for i = 1, #items do
      items[i]:Refresh(rewards[i])
    end
    self:StartTask(function(TT)
      for i = 1, #items do
        YIELD(TT, 330)
        self:_LoadEffect(items[i]._go)
      end
    end, self)
  end
end

function UIN9ResultController:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIN9ResultController:_ShowOnFail()
  self:_ActiveGo()
end

function UIN9ResultController:_TestOver()
  self:_ActiveGo()
  self.rightCountText:SetText(StringTable.Get("str_activity_n9_questionindex", self._ingameData:GetTrueRight()))
  self.evaluateText:SetText(self._ingameData:GetTestEvaluate())
end

function UIN9ResultController:_ActiveGo()
  self.testResult:SetActive(self.curType == UIN9ResultType.TestResult)
  self.success:SetActive(self.curType == UIN9ResultType.Success)
  self.fail:SetActive(self.curType == UIN9ResultType.Fail)
  self.spine:SetActive(self.curType ~= UIN9ResultType.TestResult)
  self.cloud:SetActive(self.curType ~= UIN9ResultType.TestResult)
  self.sureButton:SetActive(self.curType ~= UIN9ResultType.Fail and self.curType ~= UIN9ResultType.TestResult)
  self.outButton:SetActive(self.curType == UIN9ResultType.Fail and self.curType ~= UIN9ResultType.TestResult)
  self.againButton:SetActive(self.curType == UIN9ResultType.Fail and self.curType ~= UIN9ResultType.TestResult)
  self.testSureButton:SetActive(self.curType == UIN9ResultType.TestResult)
end

function UIN9ResultController:_SendResultInfo(TT)
  if self._gameType == 1 then
    local resultType = self:CoculateResult(self._gameType)
  else
    self:_SendMessage(TaskToken:New())
  end
end

function UIN9ResultController:_GetRewards(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TaskToken:New(), res, ECampaignType.CAMPAIGN_TYPE_N9, ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  res = AsyncRequestRes:New()
  local subject = self._localProcess:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
  subject:HandleReward(TT, res, self._grad._levelId, self._grad._grade)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN9SubjectRefresh)
  if res and not res:GetSucc() then
    Log.error("UIN9ResultController:_GetRewards()  error")
    return
  end
end

function UIN9ResultController:_SendMessage(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TaskToken:New(), res, ECampaignType.CAMPAIGN_TYPE_N9, ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  res = AsyncRequestRes:New()
  local subject = self._localProcess:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
  subject:HandleTestScore(TT, res, self._ingameData:GetTrueRight())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN9SubjectRefresh)
  if res and not res:GetSucc() then
    Log.error("UIN9ResultController:_SendMessage() upload score fail")
    return
  end
end

function UIN9ResultController:_HadReward(bReward)
  self:GetGameObject("RowItem"):SetActive(not bReward)
  self:GetGameObject("HadReward"):SetActive(bReward)
  self.hadReward:SetText(StringTable.Get("str_activity_n9_hadreward"))
end

function UIN9ResultController:SetFontMat(lable, resname)
  local res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  if not res then
    return
  end
  local obj = res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIN9ResultController:_LoadSpine(nState)
  local spineName = "nuoweiya_n9_spine_idle"
  local aniName = "Story_norm"
  if nState == 1 then
    aniName = "Story_norm"
  elseif nState == 2 then
    aniName = "Story_congrats"
  elseif nState == 3 then
    aniName = "Story_sigh"
  end
  if string.isnullorempty(spineName) then
    return
  end
  self._spine = self:GetUIComponent("SpineLoader", "Spine")
  if not self._spineSke then
    self._spine:LoadSpine(spineName)
  end
  if self._spine then
    self._spineSke = self._spine.CurrentSkeleton
    if not self._spineSke then
      self._spineSke = self._spine.CurrentMultiSkeleton
    end
    if self._spineSke then
      self._spineSke.AnimationState:SetAnimation(0, aniName, true)
    end
  end
end

function UIN9ResultController:_LoadEffect(parentObj)
  local effName = "uieff_BattleResult_ExtraItem.prefab"
  if not self._resReqs then
    self._resReqs = {}
  end
  local req = ResourceManager:GetInstance():SyncLoadAsset(effName, LoadType.GameObject)
  local effectObj = req.Obj
  effectObj:SetActive(true)
  effectObj.transform:SetParent(parentObj.transform)
  effectObj.transform.localScale = Vector3(1, 1, 1)
  effectObj.transform.position = parentObj.transform.position
  self._resReqs[#self._resReqs + 1] = req
end

function UIN9ResultController:CheckActivityOver()
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TaskToken:New(), res, ECampaignType.CAMPAIGN_TYPE_N9, ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
  if res and not res:GetSucc() then
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  local subjectComponentInfo = self._localProcess:GetComponentInfo(ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
  local endTime = subjectComponentInfo.m_close_time
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  return seconds <= 0
end
