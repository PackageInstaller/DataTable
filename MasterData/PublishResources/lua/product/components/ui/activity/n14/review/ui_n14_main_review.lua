_class("UIN14MainReview", UIController)
UIN14MainReview = UIN14MainReview

function UIN14MainReview:Constructor(ui_root_transform)
  self.strsLeftTime = {
    "str_n14_left_time_d_h",
    "str_n14_left_time_h_m",
    "str_n14_left_time_m"
  }
  self.strsTakeAwardLeftTime = {
    "str_n14_take_award_left_time_d_h",
    "str_n14_take_award_left_time_h_m",
    "str_n14_take_award_left_time_m"
  }
  self.strsWillOpen = {
    "str_n14_will_open_after_d_h",
    "str_n14_will_open_after_h_m",
    "str_n14_will_open_after_m"
  }
  self.lanActivityTip = {
    "str_activity_common_state_notstart",
    "str_activity_common_end"
  }
end

function UIN14MainReview:LoadDataOnEnter(TT, res, uiParams)
  self.isShow = true
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_REVIEW_N14
  self._componentId_LineMission = ECampaignReviewN14ComponentID.ECAMPAIGN_REVIEW_ReviewN14_LINE_MISSION
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self.activityCampaign = UIActivityCampaign:New()
  self.activityCampaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId_LineMission)
  self.activityCampaign:ReLoadCampaignInfo_Force(TT, res)
  if res and res:GetSucc() then
    self._line_component = self.activityCampaign:GetComponent(self._componentId_LineMission)
    self._line_info = self._line_component:GetComponentInfo()
  end
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  self:_SetProgressData(TT, res)
end

function UIN14MainReview:_SetProgressData(TT, res)
  local uiModule = GameGlobal.GetUIModule(CampaignModule)
  self._reviewData = uiModule:GetReviewData():GetActivityByType(ECampaignType.CAMPAIGN_TYPE_REVIEW_N14)
  self._reviewData:ReqDetailInfo(TT, res)
end

function UIN14MainReview:OnShow(uiParams)
  N14Data.SetPrefsMain()
  self.atlas = self:GetAsset("UIN14.spriteatlas", LoadType.SpriteAtlas)
  self.dictSprite = {
    [1] = {
      n = "n13_zjm_btn05",
      d = "n13_zjm_btn05"
    },
    [2] = {
      n = "n14_zjm_shop",
      d = "n14_zjm_shop"
    },
    [3] = {
      n = "n13_zjm_btn07",
      d = "n13_zjm_btn07"
    },
    [4] = {
      n = "n14_zjm_xxg",
      d = "n14_zjm_xxg"
    },
    [5] = {
      n = "n14_zjm_hard",
      d = "n14_zjm_hard"
    },
    [6] = {
      n = "n14_zjm_game",
      d = "n14_zjm_game"
    }
  }
  self._useColor = {
    Color(1, 1, 1, 1),
    Color(0.36470588235294116, 0.36470588235294116, 0.36470588235294116, 0.8470588235294118)
  }
  local btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._backBtns = btns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIActivityReview)
  end, nil, nil, false, function()
    if self.isShow then
      self.isShow = false
      self:ShowHideUI()
    end
  end)
  self.animTopBtns = self._backBtns:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self.btnStageNormal = self:GetUIComponent("Button", "btnStageNormal")
  self.redStageNormal = self:GetGameObject("redStageNormal")
  self._spineLoader = self:GetGameObject("spine")
  self.imgStageNormal = self:GetUIComponent("Image", "btnStageNormal")
  self.anim = self:GetUIComponent("Animation", "ani")
  self._masktable = {
    self:GetGameObject("MaskStageNormal")
  }
  self._modRawImagetable = {
    self:GetUIComponent("RawImage", "Normal")
  }
  self._modImagetable = {
    self:GetUIComponent("Image", "btnStageNormal")
  }
  self._modTexttable = {
    self:GetUIComponent("UILocalizationText", "StageNormalText")
  }
  self:Flush()
  local progress = UIReviewProgressConst.SpawnObject(self, "_progress", self._reviewData)
end

function UIN14MainReview:OnHide()
  self.data = nil
  self.btnStageNormal = nil
end

function UIN14MainReview:CancelTimerEvent(nState)
  if nState == ECampaignReviewN14ComponentID.ECAMPAIGN_REVIEW_ReviewN14_LINE_MISSION and self.teNormal then
    GameGlobal.Timer():CancelEvent(self.teNormal)
    self.teNormal = nil
  end
end

function UIN14MainReview:Flush()
  self:FlushNormalStage()
end

function UIN14MainReview:SetModeState(mode, isOpen)
  if self._masktable[mode] then
    self._masktable[mode]:SetActive(not isOpen)
  end
  if self._modRawImagetable[mode] then
    self._modRawImagetable[mode].color = isOpen and self._useColor[1] or self._useColor[2]
  end
  if self._modImagetable[mode] then
    self._modImagetable[mode].color = isOpen and self._useColor[1] or self._useColor[2]
  end
end

function UIN14MainReview:GetSpriteN(idx)
  local n = self.atlas:GetSprite(self.dictSprite[idx].n)
  return n
end

function UIN14MainReview:GetSpriteD(idx)
  local d = self.atlas:GetSprite(self.dictSprite[idx].d)
  return d
end

function UIN14MainReview:FlushNormalStage()
  self.btnStageNormal.interactable = false
  self.imgStageNormal.sprite = self:GetSpriteD(4)
  local cNormalInfo = self._line_info
  if not cNormalInfo then
    Log.fatal("### cNormalInfo nil.")
    return
  end
  local state = self:GetState(self._line_info)
  self:SetModeState(1, state == UISummerOneEnterBtnState.Normal)
  if state == UISummerOneEnterBtnState.NotOpen then
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cNormalInfo.m_unlock_time)
    self._modTexttable[1]:SetText(StringTable.Get(self.lanActivityTip[1]))
  elseif state == UISummerOneEnterBtnState.Closed then
    self._modTexttable[1]:SetText(StringTable.Get(self.lanActivityTip[2]))
  elseif state == UISummerOneEnterBtnState.Normal then
    self.btnStageNormal.interactable = true
    self.imgStageNormal.sprite = self:GetSpriteN(4)
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cNormalInfo.m_close_time)
  else
    Log.fatal("### state=", state)
  end
end

function UIN14MainReview:GetState(cInfo)
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if nowTimestamp < cInfo.m_unlock_time then
    return UISummerOneEnterBtnState.NotOpen
  elseif nowTimestamp > cInfo.m_close_time then
    return UISummerOneEnterBtnState.Closed
  elseif cInfo.m_b_unlock then
    return UISummerOneEnterBtnState.Normal
  else
    local cfgv = Cfg.cfg_campaign_mission[cInfo.m_need_mission_id]
    if cfgv then
      return UISummerOneEnterBtnState.Locked
    else
      return UISummerOneEnterBtnState.Normal
    end
  end
end

function UIN14MainReview:FlushCDText(uiText, time, strs)
  local leftSeconds = UICommonHelper.CalcLeftSeconds(time)
  local d, h, m, s = UICommonHelper.S2DHMS(leftSeconds)
  if 1 <= d then
    uiText:RefreshText(StringTable.Get(strs[1], math.floor(d), math.floor(h)))
  elseif 1 <= h then
    uiText:RefreshText(StringTable.Get(strs[2], math.floor(h), math.floor(m)))
  elseif 1 <= m then
    uiText:RefreshText(StringTable.Get(strs[3], math.floor(m)))
  else
    uiText:RefreshText(StringTable.Get(strs[3], "<1"))
  end
end

function UIN14MainReview:BgOnClick(go)
  if not self.isShow then
    self.isShow = true
    self:ShowHideUI()
  end
end

function UIN14MainReview:BtnStageNormalOnClick(go)
  self:SwitchState(UIStateType.UIActivityN14LineMissionControllerReview)
end

function UIN14MainReview:ShowHideUI()
  local goSafeArea = self:GetGameObject("SafeArea")
  if self.isShow then
    self.anim:Play("uieff_UIN14Main_show")
    self._backBtns:GetGameObject():SetActive(true)
  else
    self.anim:Play("uieff_UIN14Main_hide")
    self._backBtns:GetGameObject():SetActive(false)
  end
  self._spineLoader:SetActive(true)
end
