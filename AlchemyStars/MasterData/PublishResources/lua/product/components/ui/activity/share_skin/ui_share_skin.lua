require("ui_side_enter_center_content_base")
_class("UIShareSkin", UISideEnterCenterContentBase)
UIShareSkin = UIShareSkin

function UIShareSkin:Constructor()
end

function UIShareSkin:DoInit()
  self._campaign = self._data
  self._curSelSkinId = self:GetSkinId()
  self._localProcess = self._campaign:GetLocalProcess()
  self._storyComp = self._localProcess:GetComponent(ECCampaignInlandStoryComponentID.STORY)
  self._storyCompInfo = self._localProcess:GetComponentInfo(ECCampaignInlandStoryComponentID.STORY)
  self._componentId = self._storyCompInfo.m_campaign_id * 100000 + self._storyCompInfo.m_component_type * 100 + self._storyCompInfo.m_component_id
  self._storyId = -1
  local cfg_story = Cfg.cfg_component_story[self._componentId]
  if not cfg_story then
    Log.fatal("UIShareSkin can't find cfg_component_story ", self._componentId)
  else
    self._storyId = cfg_story.StoryID[1]
  end
  self._storyCfg = Cfg.cfg_campaign_story[self._storyId]
  if not self._storyCfg then
    Log.fatal("UIShareSkin can't find cfg_campaign_story ", self._storyId)
  end
end

function UIShareSkin:DoShow(uiParams)
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self:InitWidget()
  self:Refresh()
  self:PlayEnterAni()
  self:StartCheckActivityEnd()
  self:CheckAndRefreshTime()
end

function UIShareSkin:DoHide()
  self:CancelTimer()
  UIWidgetHelper.ClearWidgets(self, "itemInfo")
  self._itemInfo = nil
  self:CloseSubPanelAreaOnClick()
end

function UIShareSkin:DoDestroy()
end

function UIShareSkin:PlayEnterAni()
end

function UIShareSkin:Refresh()
  self.txtShare:SetText(StringTable.Get("str_cn9_n38_nading_skin_desc"))
  self:RefreshByStatus()
  if not self._rewardWidgets then
    local rewards = self._storyCfg.RewardList
    local len = #rewards
    self._rewardWidgets = self._rewardPool:SpawnObjects("UIShareSkinRewardItem", len)
    for i, v in ipairs(rewards) do
      local subWidget = self._rewardWidgets[i]
      subWidget:SetData(v[1], v[2], function(itemid, pos)
        if not self._itemInfo then
          self._itemInfo = self._itemInfoPool:SpawnObject("UISelectInfo")
        end
        self._itemInfo:SetData(itemid, pos + Vector3(0, 0.15, 0))
      end)
    end
  end
  local logo = self:GetAsset("nt_qiandao_di23.mat", LoadType.Mat)
  local tex = logo:GetTexture("_MainTex")
  self._eft1.sharedMaterial:SetTexture("_MainTex", tex)
  self._eft2.sharedMaterial:SetTexture("_MainTex", tex)
  self._logo1.sharedMaterial:SetTexture("_MainTex", tex)
  self._logo2.sharedMaterial:SetTexture("_MainTex", tex)
end

function UIShareSkin:RefreshByStatus()
  if self:_HasReceived() then
    self.hasReceive:SetActive(true)
    self.shareBtn:SetActive(false)
    self.receiveBtn:SetActive(false)
  elseif self:_HasShared() then
    self.hasReceive:SetActive(false)
    self.shareBtn:SetActive(false)
    self.receiveBtn:SetActive(true)
  else
    self.hasReceive:SetActive(false)
    self.shareBtn:SetActive(true)
    self.receiveBtn:SetActive(false)
  end
end

function UIShareSkin:InitWidget()
  self.txtTime = self:GetUIComponent("UILocalizationText", "txtTime")
  self.shareBtn = self:GetGameObject("shareBtn")
  self.receiveBtn = self:GetGameObject("receiveBtn")
  self.hasReceive = self:GetGameObject("hasReceive")
  self.txtShare = self:GetUIComponent("UILocalizationText", "txtShare")
  self._designInfoBtnGo = self:GetGameObject("DesignInfoBtn")
  self._designInfoBtnImg = self:GetUIComponent("Image", "DesignInfoBtn")
  self._designInfoBtnText = self:GetUIComponent("UILocalizationText", "DesignInfoBtnText")
  self._designScroll = self:GetUIComponent("ScrollRect", "DesignInfoScroll")
  self._designScrollRect = self:GetUIComponent("RectTransform", "DesignInfoScroll")
  self._subPanelAreaGo = self:GetGameObject("SubPanelShowArea")
  self._closeSubPanelAreaGo = self:GetGameObject("CloseSubPanelArea")
  self._designPanelGo = self:GetGameObject("DesignPanel")
  self._subPanelTitleText = self:GetUIComponent("UILocalizationText", "SubPanelTitleText")
  self._designText = self:GetUIComponent("UILocalizationText", "DesignText")
  self._designTextTrans = self:GetUIComponent("RectTransform", "DesignText")
  self._rewardPreviewGo = self:GetGameObject("rewardPreview")
  self._rewardPreviewGo:SetActive(false)
  self._rewardPool = self:GetUIComponent("UISelectObjectPath", "rewardPool")
  self._itemInfoPool = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._fullGo = self:GetGameObject("full")
  self._eft1 = self:GetUIComponent("MeshRenderer", "1")
  self._eft2 = self:GetUIComponent("MeshRenderer", "2")
  self._logo1 = self:GetUIComponent("MeshRenderer", "logo1")
  self._logo2 = self:GetUIComponent("MeshRenderer", "logo2")
end

function UIShareSkin:CloseCoro(TT)
end

function UIShareSkin:CancelTimer()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIShareSkin:StartCheckActivityEnd()
  self._activityEnd = self:CheckAndRefreshTime()
  if not self._activityEnd then
    self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self._activityEnd = self:CheckAndRefreshTime()
      if self._activityEnd then
        self:CancelTimer()
      end
    end)
  end
end

function UIShareSkin:CheckAndRefreshTime()
  if not self._storyCompInfo then
    return
  end
  local time = self._storyCompInfo.m_close_time
  local now = math.floor(self:GetModule(SvrTimeModule):GetServerTime() / 1000)
  if time < now then
    local timeStr = StringTable.Get("str_activity_finished")
    self.txtTime:SetText(timeStr)
    self._timeStr = timeStr
    return true
  else
    local timeStr = HelperProxy:GetInstance():FormatTime_3(time - now)
    if self._timeStr ~= timeStr then
      self.txtTime:SetText(StringTable.Get("str_cn9_n38_nading_skin_time", timeStr))
      self._timeStr = timeStr
    end
    return false
  end
end

function UIShareSkin:SetShareInfo(bShare)
  self._fullGo:SetActive(not bShare)
  local controller = self:RootUIOwner()
  if controller then
    controller:ShowOrHide(not bShare, not bShare)
  end
end

function UIShareSkin:SkinNameBtnOnClick(go)
  self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, self:GetSkinId())
end

function UIShareSkin:ShareBtnOnClick(go)
  if EDITOR then
    self:_OnShareResult(0)
    return
  end
  self:Lock("UIShareSkin")
  self:StartTask(function(TT)
    self:SetShareInfo(true)
    YIELD(TT)
    self:ShowDialog("UIShare", self:RootUIOwner():GetName(), ShareAnchorType.BottomRight, function()
      self:SetShareInfo(false)
    end, ShareAnchorType.Hide, nil, nil, ShareSceneType.CampaignKV)
    self:UnLock("UIShareSkin")
  end, self)
end

function UIShareSkin:ReceiveBtnOnClick(go)
  if self._storyId < 1 then
    return
  end
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local reward = self._storyComp:HandleStoryTake(TT, res, self._storyId)
    if reward then
      self:ShowDialog("UIGetItemController", reward, function()
        local skin = RoleAsset:New()
        skin.assetid = 90544
        skin.count = 1
        self:ShowDialog("UIPetSkinObtainController", skin, function()
          GameGlobal.UIStateManager():CloseDialog("UIPetSkinObtainController")
        end)
        self:RefreshByStatus()
      end)
    else
      local result = self._campaign:CheckComponentOpenClientError(ECCampaignInlandStoryComponentID.STORY)
      self._campaign:CheckErrorCode(result)
    end
  end)
end

function UIShareSkin:RewardBtnOnClick(go)
  self._rewardPreviewGo:SetActive(true)
end

function UIShareSkin:DesignInfoBtnOnClick(go)
  self._DesignInfoShow = not self._DesignInfoShow
  self._3DModelShow = false
  self._subPanelAreaGo:SetActive(self._DesignInfoShow)
  self._closeSubPanelAreaGo:SetActive(self._DesignInfoShow)
  self._designPanelGo:SetActive(self._DesignInfoShow)
  if self._DesignInfoShow then
    self:_SetDesignTitle()
    self:_RefreshDesignInfo()
    self._designInfoBtnText:SetText(StringTable.Get("str_pet_skin_hide_design_info"))
  else
    self._designInfoBtnText:SetText(StringTable.Get("str_pet_skin_show_design_info"))
  end
  if self._DesignInfoShow then
  end
end

function UIShareSkin:CloseSubPanelAreaOnClick(go)
  if self._DesignInfoShow then
    self:DesignInfoBtnOnClick(nil)
  end
end

function UIShareSkin:RewardPreviewOnClick(go)
  self._rewardPreviewGo:SetActive(false)
  UIWidgetHelper.ClearWidgets(self, "itemInfo")
  self._itemInfo = nil
end

function UIShareSkin:_SetDesignTitle()
  local cfgSkin = Cfg.cfg_pet_skin[self._curSelSkinId]
  local skinName = ""
  if cfgSkin then
    skinName = StringTable.Get(cfgSkin.SkinName)
  end
  local title = StringTable.Get("str_pet_skin_show_design_info")
  self._subPanelTitleText:SetText(title)
end

function UIShareSkin:_RefreshDesignInfo()
  local cfgSkin = Cfg.cfg_pet_skin[self._curSelSkinId]
  if cfgSkin then
    self._designText:SetText(StringTable.Get(cfgSkin.DesignStr))
    local timerEvent = GameGlobal.Timer():AddEventTimes(100, 1, function()
      if self._designTextTrans.sizeDelta.y < self._designScrollRect.sizeDelta.y then
        self._designScroll.vertical = false
      else
        self._designScroll.vertical = true
      end
    end)
  end
end

function UIShareSkin:_GetShareStatusKey()
  local mRole = GameGlobal.GetModule(RoleModule)
  local key = mRole:GetPstId() .. self._componentId .. "share"
  return key
end

function UIShareSkin:_HasShared()
  return true
end

function UIShareSkin:_SetAsShared()
  local key = self:_GetShareStatusKey()
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function UIShareSkin:_HasReceived()
  return self._storyComp:IsStoryReceived(self._storyId)
end

function UIShareSkin:_OnShareResult(errorCode)
  if errorCode == GCloud.MSDK.MSDKError.SUCCESS or errorCode == GCloud.MSDK.MSDKError.CANCEL then
    self:_SetAsShared()
    self:RefreshByStatus()
  end
end

function UIShareSkin:GetSkinId()
  return 90544
end
