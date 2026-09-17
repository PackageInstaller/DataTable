local this = class("pageFishingEvent", G_UIPageBase)
local _fishEventTpl = L_GameTpl:getFishEventTpl()
local _moduleName = {
  [L_FishingConst.FishingEventType.Egg] = "",
  [L_FishingConst.FishingEventType.DriftBottle] = "driftBottle",
  [L_FishingConst.FishingEventType.Dialog] = "",
  [L_FishingConst.FishingEventType.Chess] = "",
  [L_FishingConst.FishingEventType.Salvage] = "reward"
}

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    txt_title = nil,
    img_icon = nil,
    go_rewardModule = false,
    module_reward = {
      moduleName = "pages/fishing/moduleEventReward"
    },
    go_driftBottleModule = false,
    module_driftBottle = {
      moduleName = "pages/fishing/moduleEventDriftBottle"
    }
  }
end

function this.methods()
  return {
    onClick_mask = function(self)
      self:onClickMask()
    end,
    module_info = {
      reward = {
        onClick_mask = function(self)
          self:onClickMask()
        end
      }
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._canClick = false
  self._director = self.bindComponents.playableDirector_pageFishingEvent
  self:setTrackActive({})
  self:initPreview()
end

function this:close(options)
  this.super.close(self, options)
  L_TimerManager:clearTimer(self)
end

function this:escHandle()
end

function this:initPreview()
  local event = L_FishingStore:getFishFinish()
  local tpl = _fishEventTpl:getTplById(event:getEventId())
  self.bind.txt_title = _fishEventTpl:getName(tpl)
  self.bind.img_icon = _fishEventTpl:getIcon(tpl)
  self:showEncounterContent()
end

function this:showEncounterContent()
  local event = L_FishingStore:getFishFinish()
  local tpl = _fishEventTpl:getTplById(event:getEventId())
  local type = _fishEventTpl:getType(tpl)
  if type == L_FishingConst.FishingEventType.Dialog then
    C_AudioManager.Play("Play_SFX_System_Fishing_Reward_Secret")
    self:delayClosePage(function()
      AzurWorld.StoryMgr:PlayStory(_fishEventTpl:getParam(tpl))
    end)
  elseif type == L_FishingConst.FishingEventType.Chess then
    C_AudioManager.Play("Play_SFX_System_Fishing_Reward_Treasure")
    self:delayClosePage()
  else
    local director = self.bindComponents.playableDirector_pageFishingEvent
    local moduleName = _moduleName[type]
    if moduleName == "reward" then
      C_AudioManager.Play("Play_SFX_System_Fishing_Reward_Item")
      self.bind.go_rewardModule = true
      self.modules.module_reward:initModule()
      self:setTrackActive({
        [0] = true,
        [1] = true
      })
    elseif moduleName == "driftBottle" then
      C_AudioManager.Play("Play_SFX_System_Fishing_Reward_Letter")
      self.bind.go_driftBottleModule = true
      self.modules.module_driftBottle:initModule()
      self.modules.module_driftBottle:refresh()
      self:setTrackActive({
        [2] = true,
        [3] = true
      })
    end
    L_TimerManager:newOrResetTimer(self, "pauseTimeline", function()
      director:Pause()
      self._canClick = true
    end, 1.47)
  end
end

function this:delayClosePage(callback)
  self:setTrackActive({
    [4] = true
  })
  L_TimerManager:newOrResetTimer(self, "delayClosePage", function()
    self:closePage(callback)
  end, 1.25)
end

function this:onClickMask()
  if self._canClick then
    local time = self._director.time + 3
    self._director.time = time
    self._director:Resume()
    L_TimerManager:newOrResetTimer(self, "closePage", function()
      self:closePage()
    end, 0.166)
  end
end

function this:closePage(callback)
  L_UI:close(self.pageName, nil, function()
    local fish = L_FishingStore:getFishFinish()
    L_FlyMsgManager:showItemServerRewards(fish:getRewards())
    if callback then
      callback()
    end
  end)
end

function this:setTrackActive(activeList)
  self._director:Stop()
  local tracks = self._director.playableAsset:GetOutputTracks()
  for i = 0, tracks.Length - 1 do
    local track = tracks[i]
    track.muted = not activeList[i]
  end
  local t0 = self._director.time
  self._director:RebuildGraph()
  self._director.time = t0
  self._director:Play()
end

return this
