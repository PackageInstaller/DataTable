_class("UIXiaoLinJiaMissionItem", Object)
UIXiaoLinJiaMissionItem = UIXiaoLinJiaMissionItem

function UIXiaoLinJiaMissionItem:Constructor(uiView, owner)
  self._uiView = uiView
  self._owner = owner
  self.isLock = false
  self.isHide = false
  self.icon = self._uiView:GetUIComponent("RawImageLoader", "icon")
  self.lockText = self._uiView:GetUIComponent("UILocalizationText", "lockText")
  self.normal = self._uiView:GetGameObject("normal")
  self.select = self._uiView:GetGameObject("select")
  self.lock = self._uiView:GetGameObject("lock")
  self.root = self._uiView:GetGameObject("root")
  self.canvasGroup = self._uiView:GetUIComponent("CanvasGroup", "root")
  self.btnObj = self._uiView:GetGameObject("btn")
  self.headIcon1 = self._uiView:GetUIComponent("Image", "headIcon1")
  self.headIcon2 = self._uiView:GetUIComponent("Image", "headIcon2")
  self.notFinish = self._uiView:GetGameObject("notFinish")
  self.finish = self._uiView:GetGameObject("finish")
  self.line = self._uiView:GetGameObject("line")
  self._uicustomEventListener = UICustomUIEventListener:New()
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self.btnObj), UIEvent.Click, function(go)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
    self:OnSelect()
  end)
  self.finishIn = true
end

function UIXiaoLinJiaMissionItem:GetIsLock()
  return self.isLock
end

function UIXiaoLinJiaMissionItem:GetIsHide()
  return self.isHide
end

function UIXiaoLinJiaMissionItem:GetClientCfg()
  return self.clientCfg
end

function UIXiaoLinJiaMissionItem:GetServerCfg()
  return self.serverCfg
end

function UIXiaoLinJiaMissionItem:GetMissionID()
  return self.serverCfg.CampaignMissionId
end

function UIXiaoLinJiaMissionItem:SetData(clientCfg, serverCfg, serverData)
  self.clientCfg = clientCfg
  self.serverCfg = serverCfg
  self.serverData = serverData
  local unlockTime = self.serverCfg.UnlockTime
  self.diff = self._owner:GetCheckTimeIsUnlock(unlockTime)
  if self.diff <= 0 then
    if self.clientCfg.AfterPlayIcon then
      self.isHide = true
      if not self._owner:GetHasHideMissionUnLock() then
        self.isLock = true
      end
    else
      self.isLock = false
      if self.serverData then
        self.star = self.serverData.star
      end
    end
  else
    self.isHide = self.clientCfg.AfterPlayIcon ~= nil
    self.isLock = true
  end
end

function UIXiaoLinJiaMissionItem:Refresh()
  local showRoot = true
  if self.isLock then
    local nextMission = self._owner:GetNextUnlockMission()
    if nextMission then
      if nextMission:GetMissionID() == self:GetMissionID() then
        local str = StringTable.Get("str_xiaolinjia_levellock_countdown", UIActivityHelper.GetFormatTimerStr(self.diff))
        self.lockText:SetText(str)
        self.icon:LoadImage(self.clientCfg.Icon)
        self.lock:SetActive(true)
        if nextMission.isHide then
          showRoot = false
        end
      else
        showRoot = false
      end
    end
    self.notFinish:SetActive(true)
    self.finish:SetActive(false)
    self.headIcon1.gameObject:SetActive(false)
    self.headIcon2.gameObject:SetActive(false)
  else
    if self.clientCfg.AfterPlayIcon and self.serverData then
      self.icon:LoadImage(self.clientCfg.AfterPlayIcon)
    else
      self.icon:LoadImage(self.clientCfg.Icon)
    end
    if self.clientCfg.HeadIcon then
      self.headIcon1.gameObject:SetActive(true)
      self.headIcon2.gameObject:SetActive(true)
      self.headIcon1.sprite = self._owner.atlas:GetSprite(self.clientCfg.HeadIcon[1])
      self.headIcon2.sprite = self._owner.atlas:GetSprite(self.clientCfg.HeadIcon[2])
    else
      self.headIcon1.gameObject:SetActive(false)
      self.headIcon2.gameObject:SetActive(false)
    end
    self.notFinish:SetActive(self.serverData == nil)
    self.finish:SetActive(self.serverData ~= nil)
    self.lock:SetActive(false)
  end
  self.root:SetActive(showRoot)
  self.line:SetActive(showRoot)
  self.canvasGroup.alpha = 0
  if self.finishIn then
    self.finishIn = false
    local id = self:GetMissionID()
    if 1 < id then
      local anim = self._uiView:GetUIComponent("Animation", "anim")
      GameGlobal.TaskManager():StartTask(function(TT)
        YIELD(TT, (id - 1) * 80)
        self.canvasGroup.alpha = 1
        anim:Play("uieffanim_UIXiaoLinJiaMainController_anim")
      end)
    else
      self.canvasGroup.alpha = 1
    end
  else
    self.root:SetActive(showRoot)
    self.line:SetActive(showRoot)
  end
end

function UIXiaoLinJiaMissionItem:ShowSelectIcon(missionID)
  self.select:SetActive(missionID == self:GetMissionID())
end

function UIXiaoLinJiaMissionItem:OnSelect()
  local title, content
  if self.isHide then
    title = self.serverData and self.clientCfg.Title or self.clientCfg.lockTitle
    content = self.serverData and self.clientCfg.Content or self.clientCfg.lockContent
  else
    title = self.isLock and self.clientCfg.lockTitle or self.clientCfg.Title
    content = self.isLock and self.clientCfg.lockContent or self.clientCfg.Content
  end
  self._owner:ShowMissionInfo(self:GetMissionID(), title, content, self.isLock, self.isHide, self.star, self.diff)
end
