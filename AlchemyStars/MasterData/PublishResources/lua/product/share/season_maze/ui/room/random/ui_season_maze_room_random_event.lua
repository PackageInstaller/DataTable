_class("UISeasonMazeRoomRandomEvent", UISeasonMazeRoomBase)
UISeasonMazeRoomRandomEvent = UISeasonMazeRoomRandomEvent

function UISeasonMazeRoomRandomEvent:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeRoomRandomEvent:OnShowUI()
  self:InitWidget()
  self.cfgId = self._roomInfo.cfg_id
  self.eventCfg = self:GetRandomEventCfg()
  self.desc:SetText(StringTable.Get(self.eventCfg.EventDesc))
  self.cg:LoadImage(self.eventCfg.NpcImage)
  self:InitOptions()
end

function UISeasonMazeRoomRandomEvent:GetRandomEventCfg()
  local cfgs = Cfg.cfg_component_season_maze_room_event({
    ID = self.cfgId
  })
  if cfgs and 0 < #cfgs then
    return cfgs[1]
  end
end

function UISeasonMazeRoomRandomEvent:InitWidget()
  self.options = self:GetUIComponent("UISelectObjectPath", "options")
  self.desc = self:GetUIComponent("UILocalizationText", "desc")
  self.start = self:GetGameObject("start")
  self.after = self:GetGameObject("after")
  self.cg = self:GetUIComponent("RawImageLoader", "cg")
  self.anim = self:GetUIComponent("Animation", "anim")
  self.start:SetActive(true)
  self.after:SetActive(false)
  local leave = self:GetUIComponent("UISelectObjectPath", "UISMazeRoomLeaveBtn")
  local btn = leave:SpawnObject("UISMazeRoomLeaveBtn")
  btn:SetData(function()
    self:OnlyHideUI()
  end)
  self:AttachEvent(GameEventType.OnSeasonMazeShowRewardsFinish, self.OnSeasonMazeShowRewardsFinish)
end

function UISeasonMazeRoomRandomEvent:InitOptions()
  self.options:SpawnObjects("UISeasonMazeRoomRandomEventOption", #self.eventCfg.Options)
  self.spawnlist = self.options:GetAllSpawnList()
  for i = 1, #self.eventCfg.Options do
    local optionId = self.eventCfg.Options[i]
    local cfgs = Cfg.cfg_component_season_maze_event_option({ID = optionId})
    if cfgs and 0 < #cfgs then
      local cfg = cfgs[1]
      self.spawnlist[i]:SetData(cfg, self)
    else
      Log.exception("UISeasonMazeRoomRandomEvent cfg_component_season_maze_event_option option is nil", optionId)
    end
  end
end

function UISeasonMazeRoomRandomEvent:StartBtnOnClick()
  self.start:SetActive(false)
  self.after:SetActive(true)
  self.anim:Play("uieffanim_UISeasonMazeRoomRandomEvent_select")
  for i = 1, #self.spawnlist do
    self.spawnlist[i]:PlayShowAnim()
  end
end

function UISeasonMazeRoomRandomEvent:OnOptionSelect(cfg)
  GameGlobal.TaskManager():StartTask(self.OnReqEventRoom, self, cfg.ID, cfg.Decide)
end

function UISeasonMazeRoomRandomEvent:OnReqEventRoom(TT, cfg_id, decide)
  local res = AsyncRequestRes:New()
  self:Lock("UISeasonMazeRoomRandomEvent:OnReqEventRoom")
  self._response = self._component:HandleSeasonMazeEvent(TT, res, cfg_id)
  if res and res:GetSucc() then
    local rewards = self._response.reward
    if decide and decide ~= 0 then
      local hands = self._response.hands
      self:ShowDialog("UISeasonMazeCardDecide", hands, decide, function()
        if rewards and 0 < #rewards then
          self._waitNotifyReward = rewards
          local showRewards = self:GetShowRewards(rewards)
          if 0 < #showRewards then
            self:UnLock("UISeasonMazeRoomRandomEvent:OnReqEventRoom")
            SeasonMazeTool:GetInstance():ShowUIGetRewards(showRewards)
          else
            self:OnHideUIAnim(TT, self._response.reward)
          end
        else
          self:OnHideUIAnim(TT)
        end
      end)
    elseif rewards and 0 < #rewards then
      self._waitNotifyReward = rewards
      local showRewards = self:GetShowRewards(rewards)
      if 0 < #showRewards then
        self:UnLock("UISeasonMazeRoomRandomEvent:OnReqEventRoom")
        SeasonMazeTool:GetInstance():ShowUIGetRewards(showRewards)
      else
        self:OnHideUIAnim(TT, self._response.reward)
      end
    else
      self:OnHideUIAnim(TT)
    end
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMazeRoomRandomEvent] HandleSeasonMazeEvent fail ! result : ", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoomRandomEvent:GetShowRewards(rewards)
  local showRewards = {}
  for _, value in ipairs(rewards) do
    local reward = value
    if reward.type == SeasonMazeEffectType.SMET_Pet or reward.type == SeasonMazeEffectType.SMET_Bead or reward.type == SeasonMazeEffectType.SMET_Relic or reward.type == SeasonMazeEffectType.SMET_GetRandomPet then
      table.insert(showRewards, reward)
    end
  end
  return showRewards
end

function UISeasonMazeRoomRandomEvent:OnHideUIAnim(TT, ...)
  self:Lock("UISeasonMazeRoomRandomEvent:OnHideUIAnim")
  self.anim:Play("uieffanim_UISeasonMazeRoomRandomEvent_out")
  for i = 1, #self.spawnlist do
    self.spawnlist[i]:PlayHideAnim()
  end
  YIELD(TT, 400)
  self:UnLock("UISeasonMazeRoomRandomEvent:OnHideUIAnim")
  self:UnLock("UISeasonMazeRoomRandomEvent:OnReqEventRoom")
  self:OnHideUI(...)
end

function UISeasonMazeRoomRandomEvent:OnSeasonMazeShowRewardsFinish(flag)
  GameGlobal.TaskManager():StartTask(self.OnHideUIAnim, self, self._waitNotifyReward)
end
