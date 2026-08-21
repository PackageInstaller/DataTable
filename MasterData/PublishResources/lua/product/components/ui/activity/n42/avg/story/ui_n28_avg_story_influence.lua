_class("UIN28AVGStoryInfluence", UICustomWidget)
UIN28AVGStoryInfluence = UIN28AVGStoryInfluence

function UIN28AVGStoryInfluence:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
  self.animNames = {
    "uieff_UIN28AVGStoryInfluence_influence_in",
    "uieff_UIN28AVGStoryInfluence_influence_loop",
    "uieff_UIN28AVGStoryInfluence_ring_in",
    "uieff_UIN28AVGStoryInfluence_ring_loop"
  }
  self.animOutNames = {
    "uieff_UIN28AVGStoryInfluence_influence_out",
    "uieff_UIN28AVGStoryInfluence_ring_out"
  }
  self.taskIdPress = 0
  self.taskIdRelease = 0
end

function UIN28AVGStoryInfluence:OnShow()
  self.anim = self:GetUIComponent("Animation", "root")
  self.animOut = self:GetUIComponent("Animation", "out")
  self.imgInfluence = self:GetGameObject("imgInfluence")
  self.imgInfluence:SetActive(false)
  self.imgInfluenceNormal = self:GetGameObject("imgInfluenceNormal")
  self.imgInfluenceNormalRect = self:GetUIComponent("RectTransform", "imgInfluenceNormal")
  self.imgInfluencePress = self:GetGameObject("imgInfluencePress")
  self.imgInfluencePress:SetActive(false)
  self.btnInfluence = self:GetGameObject("btnInfluence")
  self.btnInfluenceRect = self:GetUIComponent("RectTransform", "btnInfluence")
  self.poolOptions = self:GetUIComponent("UISelectObjectPath", "options")
  self.options = self:GetGameObject("options")
  self.options:SetActive(false)
  self.atlas = self:GetAsset("UIAVG.spriteatlas", LoadType.SpriteAtlas)
  self:RegisterUICustomUIEventListener()
  self._audioCount = 0
  self:StartTask(function(TT)
    YIELD(TT)
    self.btnInfluenceRect.sizeDelta = Vector2(self.imgInfluenceNormalRect.sizeDelta.x, self.btnInfluenceRect.sizeDelta.y)
  end, self)
end

function UIN28AVGStoryInfluence:OnHide()
  self.anim = nil
  self.animOut = nil
  self.taskIdPress = 0
  self.taskIdRelease = 0
  self:UnRegisterUICustomUIEventListener()
end

function UIN28AVGStoryInfluence:RegisterUICustomUIEventListener()
  local etl = UICustomUIEventListener.Get(self.btnInfluence)
  self:AddUICustomEventListener(etl, UIEvent.Press, function(ped)
    self.imgInfluence:SetActive(true)
    self.imgInfluenceNormal:SetActive(false)
    self.imgInfluencePress:SetActive(true)
    self.options:SetActive(true)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N6CommonBuilding)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGShowHideOptionInfluence, true)
    self:PlayAnimPress()
  end)
  self:AddUICustomEventListener(etl, UIEvent.Release, function(ped)
    self.imgInfluence:SetActive(false)
    self.imgInfluenceNormal:SetActive(true)
    self.imgInfluencePress:SetActive(false)
    self.options:SetActive(false)
    if self._audioCount == 1 then
      if self._soundPlayingID then
        AudioHelperController.StopUISound(self._soundPlayingID)
      end
      self._audioCount = self._audioCount - 1
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGShowHideOptionInfluence, false)
    self:PlayAnimRelease()
  end)
end

function UIN28AVGStoryInfluence:UnRegisterUICustomUIEventListener()
  self:RemoveAllCustomEventListener()
end

function UIN28AVGStoryInfluence:Flush(options)
  local len = table.count(options)
  self.poolOptions:SpawnObjects("UIN28AVGStoryInfluenceItem", len)
  local uis = self.poolOptions:GetAllSpawnList()
  for i, option in ipairs(options) do
    local ui = uis[i]
    ui:Flush(option)
  end
  self:PlayAnimRelease()
end

function UIN28AVGStoryInfluence:PlayAnimPress()
  if not self.anim then
    return
  end
  self:StopAnim()
  self:StopAnimOut()
  self:PlayAnimOfItem("PlayAnimIn")
  self:KillTaskPress()
  self:KillTaskRelease()
  self.taskIdPress = self:StartTask(function(TT)
    self:PlayAnimOutRing()
    if self.anim then
      self.anim:Play(self.animNames[1])
    end
    YIELD(TT, 2800)
    if self.anim then
      self.anim:Play(self.animNames[2])
    end
    self.taskIdPress = 0
  end, self)
end

function UIN28AVGStoryInfluence:PlayAnimRelease()
  if not self.anim then
    return
  end
  self:StopAnim()
  self:StopAnimOut()
  self:PlayAnimOfItem("PlayAnimOut")
  self:KillTaskPress()
  self:KillTaskRelease()
  self.taskIdRelease = self:StartTask(function(TT)
    self:PlayAnimOutInfluence()
    if self.anim then
      self.anim:Play(self.animNames[3])
    end
    YIELD(TT, 2000)
    if self.anim then
      self.anim:Play(self.animNames[4])
    end
    self.taskIdRelease = 0
  end, self)
end

function UIN28AVGStoryInfluence:PlayAnimOutRing()
  if not self.animOut then
    return
  end
  self.animOut:Play(self.animOutNames[2])
end

function UIN28AVGStoryInfluence:PlayAnimOutInfluence()
  if not self.animOut then
    return
  end
  self.animOut:Play(self.animOutNames[1])
end

function UIN28AVGStoryInfluence:StopAnim()
  if not self.anim then
    return
  end
  for index, animName in ipairs(self.animNames) do
    local state = self.anim:get_Item(animName)
    if state then
      state.normalizedTime = 0
    end
  end
  self.anim:Stop()
end

function UIN28AVGStoryInfluence:StopAnimOut()
  if not self.animOut then
    return
  end
  for index, animName in ipairs(self.animOutNames) do
    local state = self.animOut:get_Item(animName)
    if state then
      state.normalizedTime = 0
    end
  end
  self.animOut:Stop()
end

function UIN28AVGStoryInfluence:PlayAnimOfItem(animName)
  local uis = self.poolOptions:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    if ui[animName] then
      ui[animName](ui)
    end
  end
end

function UIN28AVGStoryInfluence:KillTaskPress()
  if self.taskIdPress > 0 then
    GameGlobal.TaskManager():KillTask(self.taskIdPress)
  end
end

function UIN28AVGStoryInfluence:KillTaskRelease()
  if self.taskIdRelease > 0 then
    GameGlobal.TaskManager():KillTask(self.taskIdRelease)
  end
end
