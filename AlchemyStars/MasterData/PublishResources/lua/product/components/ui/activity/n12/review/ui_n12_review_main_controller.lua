_class("UIN12MainController_Review", UIController)
UIN12MainController_Review = UIN12MainController_Review

function UIN12MainController_Review:Constructor()
  self._campaignModule = self:GetModule(CampaignModule)
  self._showSpine = false
  self._redDotModule = self:GetModule(RedDotModule)
end

function UIN12MainController_Review:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_REVIEW_N12)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  if not self._campaign then
    return
  end
  self._cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._story_component = self._campaign:GetLocalProcess()._storyComponent
  self._storyInfo = self._campaign:GetComponentInfo(ECampaignReviewN12ComponentID.ECAMPAIGN_REVIEW_ReviewN12_STORY)
  self._storyComponentID = self._story_component:GetComponetCfgId(self._campaign._id, self._storyInfo.m_component_id)
  self._stroyCfg = Cfg.cfg_component_story[self._storyComponentID]
  self:_SetProgressData(TT, res)
end

function UIN12MainController_Review:OnShow(uiParams)
  self._rt = uiParams[1]
  self:_GetComponent()
  self:_OnValue()
  self:_CheckStory()
end

function UIN12MainController_Review:_CheckStory()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  local play = LocalDB.GetInt("UIN12MainControllerReviewPlayStory" .. pstid, 0)
  if play == 1 then
    self._storyReviewBtn:SetActive(true)
  else
    self._storyReviewBtn:SetActive(false)
    self:StoryReviewBtnOnClick()
    LocalDB.SetInt("UIN12MainControllerReviewPlayStory" .. pstid, 1)
  end
end

function UIN12MainController_Review:_GetComponent()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:_Close()
  end, nil, nil, false, function()
    if not self._showSpine then
      self:_ShowBgSpine(true, "uieff_N12_Main_Review_Hide")
    end
  end)
  self._animation = self.view.gameObject:GetComponent("Animation")
  self._screenCut = self:GetUIComponent("RawImage", "ScreenCut")
  local progress = UIReviewProgressConst.SpawnObject(self, "_progress", self._reviewData)
  self._scoreStoreRedPoint = self:GetGameObject("ScoreStoreRedPoint")
  self._storyReviewBtn = self:GetGameObject("StoryReviewBtn")
end

function UIN12MainController_Review:_OnValue()
  if self._rt then
    self._screenCut.texture = self._rt
    self._animation:Play("uieff_N12_Main_In3")
  else
    self._animation:Play("uieff_N12_Main_In3")
  end
  self:_PlayStory()
  self:_CheckRedPointAll()
end

function UIN12MainController_Review:_Close()
  self:SwitchState(UIStateType.UIActivityReview)
end

function UIN12MainController_Review:_SetProgressData(TT, res)
  local uiModule = GameGlobal.GetUIModule(CampaignModule)
  self._reviewData = uiModule:GetReviewData():GetActivityByType(ECampaignType.CAMPAIGN_TYPE_REVIEW_N12)
  self._reviewData:ReqDetailInfo(TT, res)
end

function UIN12MainController_Review:_GetComponentState(componentid)
  return self._campaign:CheckComponentOpen(componentid)
end

function UIN12MainController_Review:_CheckRedPointAll()
  local recv_list = self._story_component:GetAlreadyReceivedStoryIdList()
  self._scoreStoreRedPoint:SetActive(#recv_list ~= #self._stroyCfg.StoryID)
end

function UIN12MainController_Review:ScoreStoreOnClick(go)
  self:SwitchState(UIStateType.UIN12IntegralController_Review)
end

function UIN12MainController_Review:_ShowBgSpine(showSpine, animationName)
  self._showSpine = showSpine
  self._animation:Play(animationName)
end

function UIN12MainController_Review:BgOnClick(go)
  local hideBtn = self._commonTopBtn:GetGameObject("btnShowHideUI")
  hideBtn:SetActive(false)
  hideBtn:SetActive(true)
  if self._showSpine then
    self:_ShowBgSpine(false, "uieff_N12_Main_Review_Show")
  end
end

function UIN12MainController_Review:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN12MainController_Review)
end

function UIN12MainController_Review:_PlayStory()
  if not self._campaign:GetSample():GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) then
    return
  end
  if self._cfg_campaign ~= nil then
    if self._cfg_campaign.FirstEnterStoryID ~= nil and self._cfg_campaign.FirstEnterStoryID[1] ~= nil then
      GameGlobal.GetModule(StoryModule):StartStory(self._cfg_campaign.FirstEnterStoryID[1], function()
        self._clearNewTask = self:StartTask(function(TT)
          local res = AsyncRequestRes:New()
          GameGlobal.GetModule(CampaignModule):CampaignClearNewFlag(TT, res, self._campaign._id)
          if res:GetSucc() then
            Log.info("n12 play first enter story succ.")
            self:_CheckGuide()
          end
        end, self)
      end, true)
    else
      self._clearNewTask = self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        GameGlobal.GetModule(CampaignModule):CampaignClearNewFlag(TT, res, self._campaign._id)
        if res:GetSucc() then
          self:_CheckGuide()
          Log.info("n12 play first enter story succ.")
        end
      end, self)
    end
  end
end

function UIN12MainController_Review:StoryReviewBtnOnClick(go)
  self:ShowDialog("UIStoryController", 150150001, function()
    self._storyReviewBtn:SetActive(true)
  end)
end
