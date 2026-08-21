_class("UIActivityN34MainController", UIActivityMainBase)
UIActivityN34MainController = UIActivityN34MainController

function UIActivityN34MainController:OnInit(uiParams)
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._itemText = self:GetUIComponent("UILocalizationText", "Item")
  self._itemBackText = self:GetUIComponent("UILocalizationText", "ItemBack")
  self._rawImageLoader = self:GetUIComponent("RawImageLoader", "RawImage")
  self._rawImage = self:GetUIComponent("RawImage", "RawImage")
  self._photoImage = self:GetUIComponent("RawImage", "photo")
  self._screenShot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self:AttachEvent(GameEventType.ItemCountChanged, self.ShowItems)
  self:RefreshActivityRemainTime()
  self:StartTask(self.PlayAnimEnterCoro, self)
  self:ReplaceMaterial()
end

function UIActivityN34MainController:OnUpdate(deltaTimeMS)
  if self.view then
    self:RefreshActivityRemainTime()
  end
end

function UIActivityN34MainController:RefreshActivityRemainTime()
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_n34_activity_end"))
    return
  end
  local status, endTime = self._activityConst:GetComponentStatus(ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY)
  if status == ActivityComponentStatus.Open then
    local tipsStr = "str_n34_activity_remain_time"
    local seconds = endTime
    if seconds <= 0 then
      seconds = 0
    end
    local timeStr = UIActivityCustomHelper.GetTimeString(seconds, "str_n34_day", "str_n34_hour", "str_n34_minus", "str_n34_less_one_minus")
    local timeTips = StringTable.Get(tipsStr, timeStr)
    self._timeLabel:SetText(timeTips)
  end
end

function UIActivityN34MainController:OnRefresh()
  self:ShowItems()
end

function UIActivityN34MainController:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N34
end

function UIActivityN34MainController:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_DISPATCH
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_QUEST
  return componentIds
end

function UIActivityN34MainController:GetLoginComponentId()
  return ECampaignN34ComponentID.ECAMPAIGN_N34_CUMULATIVE_LOGIN
end

function UIActivityN34MainController:GetCustomTimeStr()
  return "str_n34_day", "str_n34_hour", "str_n34_minus", "str_n34_less_one_minus"
end

function UIActivityN34MainController:GetButtonStatusConfig()
  local configs = {}
  local survey = {}
  survey.Name = "Survey"
  survey.ComponentId = ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY
  survey.CheckRedComponentIds = {
    ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY,
    ECampaignN34ComponentID.ECAMPAIGN_N34_QUEST
  }
  
  function survey.Callback()
    self._activityConst:ClearComponentNew(ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY)
    self:ShowDialog("UIActivityN34TaskMainController", 1, true)
  end
  
  survey.RemainTimeStr = "str_n34_activity_survey_level_remain_time"
  survey.UnlockTimeStr = "str_n34_activity_survey_level_lock_time_tips"
  survey.UnlockMissionStr = "str_n34_activity_survey_level_lock_mission_tips"
  configs[#configs + 1] = survey
  local dispath = {}
  dispath.Name = "Dispath"
  dispath.ComponentId = ECampaignN34ComponentID.ECAMPAIGN_N34_DISPATCH
  dispath.CheckRedComponentIds = nil
  
  function dispath.Callback()
    self._activityConst:ClearComponentNew(ECampaignN34ComponentID.ECAMPAIGN_N34_DISPATCH)
    self:ShowDialog("UIN34DispatchMain")
  end
  
  dispath.RemainTimeStr = "str_n34_activity_dispath_level_remain_time"
  dispath.UnlockTimeStr = "str_n34_activity_dispatch_level_lock_time_tips"
  dispath.UnlockMissionStr = "str_n34_activity_dispatch_level_lock_mission_tips"
  configs[#configs + 1] = dispath
  return configs
end

function UIActivityN34MainController:SurveyOnClick()
  self:ClickButton("Survey")
end

function UIActivityN34MainController:DispathOnClick()
  self:ClickButton("Dispath")
end

function UIActivityN34MainController:StoryOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIStoryController", self._activityConst:GetPlotId())
end

function UIActivityN34MainController:SetPanelStatus(TT, isShow)
  if self._anim then
    if isShow then
      self._anim:Play("uieffanim_UIActivityN34MainController_show")
    else
      self._anim:Play("uieffanim_UIActivityN34MainController_hide")
    end
  end
  self._showBtn:SetActive(not isShow)
end

function UIActivityN34MainController:PlayAnimEnterCoro(TT)
  self:Lock("UIActivityN30MainController_PlayAnimEnterCoro")
  self._anim:Play("uieffanim_UIActivityN34MainController_in")
  YIELD(TT, 900)
  self:UnLock("UIActivityN30MainController_PlayAnimEnterCoro")
  self:CheckGuide()
end

function UIActivityN34MainController:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN34MainController)
end

function UIActivityN34MainController:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N34
end

function UIActivityN34MainController:ShowItems()
  self._itemModule = GameGlobal.GetModule(ItemModule)
  local str = Cfg.cfg_global.survey_tokens_item.StrValue
  local a, b = string.match(str, "(.*)%|(.*)")
  local num = self._itemModule:GetItemCount(tonumber(a))
  if 9999999 < num then
    num = 9999999
  end
  self._itemText:SetText(UIActivityCustomHelper.GetItemCountStr(7, num, "#d9d9d9", "#fff5cc"))
  self._itemBackText:SetText(UIActivityCustomHelper.GetItemCountStr(7, num, "#180f1f", "#180f1f"))
end

function UIActivityN34MainController:Close(TT)
  self._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local rt = self._screenShot:RefreshBlurTexture()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  UnityEngine.Graphics.Blit(rt, cache_rt)
  YIELD(TT)
  self._screenShot.gameObject:SetActive(false)
  self._photoImage.texture = rt
  self:Lock("UIActivityN30MainController_PlayAnimEnterCoro")
  self._anim:Play("uieffanim_UIActivityN34MainController_out")
  YIELD(TT, 100)
  self:SwitchState(UIStateType.UIMain)
  self:UnLock("UIActivityN30MainController_PlayAnimEnterCoro")
end

function UIActivityN34MainController:ReplaceMaterial()
  self._lastMaterial = self._rawImage.material
  self._reqEffectMat = ResourceManager:GetInstance():SyncLoadAsset("uieff_n34_zjm_title01" .. ".mat", LoadType.Mat)
  self._effectMat = self._reqEffectMat.Obj
  self._rawImageLoader:SetMat("uieff_n34_zjm_title01", self._effectMat, false)
  self._rawImage.material:SetTexture("_MainTex", self._lastMaterial:GetTexture("_MainTex"))
end
