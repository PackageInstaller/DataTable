_class("UIDiscoveryIntroEnter", UICustomWidget)
UIDiscoveryIntroEnter = UIDiscoveryIntroEnter

function UIDiscoveryIntroEnter:OnShow()
  self.root = self:GetGameObject("root")
  self.img = self:GetUIComponent("RawImageLoader", "img")
  self.imgRect = self:GetUIComponent("RectTransform", "img")
  self.txt = self:GetUIComponent("UILocalizationText", "txt")
  self.txt1 = self:GetUIComponent("UILocalizationText", "txt1")
  self.txtRect = self:GetUIComponent("RectTransform", "txt")
  self.txtRect1 = self:GetUIComponent("RectTransform", "txt1")
  self.awardMulti = self:GetGameObject("AwardMulti")
  self.awardMultiRect = self:GetUIComponent("RectTransform", "AwardMulti")
  self:_CheckActivityIntro()
end

function UIDiscoveryIntroEnter:OnHide()
end

function UIDiscoveryIntroEnter:_CheckActivityIntro()
  self.root:SetActive(false)
  self.awardMulti:SetActive(false)
  self:StartTask(function(TT)
    local campaignModule = self:GetModule(CampaignModule)
    local bShowIntro = false
    local showIntroCfg
    local latestCampObj = campaignModule:GetLatestCampaignObj(TT)
    if latestCampObj then
      local sampleInfo = latestCampObj:GetSampleInfo()
      if sampleInfo then
        local campId = sampleInfo.id
        local introCfg = Cfg.cfg_activity_intro_in_discovery[campId]
        if introCfg then
          local begin_time = 0
          local close_time = 0
          local componentId = introCfg.BindComponentId
          if componentId then
            local campaign = UIActivityCampaign:New()
            local res = AsyncRequestRes:New()
            campaign:LoadCampaignInfo(TT, res, sampleInfo.camp_type, componentId)
            local componentInfo = campaign:GetComponentInfo(componentId)
            if componentInfo then
              begin_time = componentInfo.m_unlock_time
              if string.isnullorempty(introCfg.SpecialEndTimeIndex) then
                close_time = componentInfo.m_close_time
              else
                close_time = componentInfo[introCfg.SpecialEndTimeIndex]
                if not close_time then
                  close_time = 0
                end
              end
            end
          else
            begin_time = sampleInfo.begin_time
            close_time = sampleInfo.end_time
          end
          local svrTimeModule = self:GetModule(SvrTimeModule)
          local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
          if begin_time <= curTime and close_time >= curTime then
            bShowIntro = true
            showIntroCfg = introCfg
          end
        end
      end
    end
    self.root:SetActive(bShowIntro)
    local awardMulti = self:GetModule(WorldBossModule):AwardMultiOpen()
    local unlock = GameGlobal.GetModule(RoleModule):CheckModuleUnlock(GameModuleID.MD_WorldBoss)
    self.awardMulti:SetActive(awardMulti and unlock)
    if bShowIntro and showIntroCfg then
      self:_FillActivityIntroEntry(showIntroCfg)
    else
      self.awardMultiRect.anchoredPosition = Vector2(0, 5)
    end
    return
  end, self)
end

function UIDiscoveryIntroEnter:_FillActivityIntroEntry(introCfg)
  if introCfg then
    self._activityIntroKey = introCfg.ActivityIntroKey
    self._introLoaderKey = introCfg.IntroLoaderKey
    if introCfg.TitleTextSet then
      if introCfg.TitleTextSet.font and introCfg.TitleTextSet.font == 2 then
        self.txt = self.txt1
        self.txtRect = self.txtRect1
        self.txt.gameObject:SetActive(true)
      end
      if introCfg.TitleTextSet.outline then
        local txt = introCfg.TitleTextSet.font and introCfg.TitleTextSet.font == 2 and "txt1" or "txt"
        self._circleOutline = self:GetUIComponent("H3D.UGUI.CircleOutline", txt)
        
        local function arr2color(arr)
          local color = Color.white
          if arr then
            color:Set(arr[1] / 255, arr[2] / 255, arr[3] / 255)
          end
          return color
        end
        
        self._circleOutline.enabled = true
        self._circleOutline.effectColor = arr2color(introCfg.TitleTextSet.outline)
      end
    end
    if self.img and not string.isnullorempty(introCfg.IconImg) then
      self.img:LoadImage(introCfg.IconImg)
    end
    if self.imgRect and introCfg.IconSize then
      local sizeX = introCfg.IconSize[1]
      local sizeY = introCfg.IconSize[2]
      self.imgRect.sizeDelta = Vector2(sizeX, sizeY)
    end
    if self.imgRect and introCfg.IconPos then
      local posX = introCfg.IconPos[1]
      local posY = introCfg.IconPos[2]
      self.imgRect.anchoredPosition = Vector2(posX, posY)
    end
    if self.txt and not string.isnullorempty(introCfg.TitleText) then
      self.txt:SetText(StringTable.Get(introCfg.TitleText))
      if introCfg.TitleTextSet then
        local colorTable = introCfg.TitleTextSet.color
        if colorTable then
          local color = Color(colorTable[1] / 255, colorTable[2] / 255, colorTable[3] / 255)
          self.txt.color = color
        end
        self.txt.fontSize = introCfg.TitleTextSet.fontSize or 30
      end
    end
    if self.txtRect and introCfg.TitlePos then
      local posX = introCfg.TitlePos[1]
      local posY = introCfg.TitlePos[2]
      self.txtRect.anchoredPosition = Vector2(posX, posY)
    end
    self.awardMultiRect.anchoredPosition = Vector2(self.imgRect.anchoredPosition.x + self.imgRect.sizeDelta.x + 10, 5)
  end
end

function UIDiscoveryIntroEnter:RootOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SakuraCommonClick)
  if self._activityIntroKey then
    UIActivityHelper.ShowActivityIntro(self._activityIntroKey)
  end
  if self._introLoaderKey then
    self:ShowDialog("UIIntroLoader", self._introLoaderKey)
  end
end

function UIDiscoveryIntroEnter:AwardMultiOnClick(go)
  ToastManager.ShowToast(StringTable.Get("str_world_boss_multi_tips"))
end
