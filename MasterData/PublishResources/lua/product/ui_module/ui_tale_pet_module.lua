_class("UITalePetModule", UIModule)

function UITalePetModule:Constructor()
  self._talePetModule = GameGlobal.GetModule(TalePetModule)
  self:AttachEvent(GameEventType.TalePetBuffChange, self.HandleTalePetBuffChange)
end

function UITalePetModule:Dispose()
  self:DetachEvent(GameEventType.TalePetBuffChange)
end

function UITalePetModule:HandleTalePetBuffChange()
  ToastManager.ShowToast(StringTable.Get("str_tale_pet_buff_level_up_tips"))
end

function UITalePetModule:OpenTrailLevel()
  self:ShowDialog("UITrailLevelController")
  self:Lock("UITalePetModule_OpenTrailLevel")
  GameGlobal.TaskManager():StartTask(self.OpenTrailLevelCoro, self)
end

function UITalePetModule:OpenTrailLevelCoro(TT)
  YIELD(TT, 830)
  self:ShowStory()
  self:UnLock("UITalePetModule_OpenTrailLevel")
end

function UITalePetModule:ShowStory()
  local storyIds, templateIds = self._talePetModule:GetEnterTrailLevelStoryIds()
  if storyIds then
    self:_PlayEnterTrailLevelStory(storyIds, templateIds, 1)
  else
    self:ShowBuffTipsUI()
  end
end

function UITalePetModule:_PlayEnterTrailLevelStory(storyIds, templateIds, index)
  if index > #storyIds then
    self:ShowBuffTipsUI()
    return
  end
  self:ShowDialog("UIStoryBanner", storyIds[index], StoryBannerShowType.HalfPortrait, function()
    GameGlobal.TaskManager():StartTask(self.PlayStoryComplete, self, templateIds[index], storyIds, templateIds, index + 1)
  end)
end

function UITalePetModule:ShowBuffTipsUI()
  if self._talePetModule:IsShowBuffTips() then
    self:ShowDialog("UITrailLevelBuffTips")
  end
end

function UITalePetModule:PlayStoryComplete(TT, templateId, storyIds, templateIds, index)
  local talePetModule = GameGlobal.GetModule(TalePetModule)
  talePetModule:PlayTrailLevelStroyComplete(TT, templateId)
  self:_PlayEnterTrailLevelStory(storyIds, templateIds, index)
end

function UITalePetModule:OpenPracticeLevel(petTemplateId)
  local cfg = Cfg.cfg_tale_pet[petTemplateId]
  if not cfg then
    return
  end
  self:ShowDialog("UITrailLevelDetail", cfg.PracticeLevelId)
end

function UITalePetModule:BattleExist(stageId)
  local cfg = Cfg.cfg_tale_stage[stageId]
  if cfg.Type == TaleType.TT_FightMission then
    self:SwitchState(UIStateType.UITrailLevel, true)
  elseif cfg.Type == TaleType.TT_TrainMission then
    local callState = GameGlobal.GetModule(TalePetModule):GetCurCallState()
    if callState then
      self:SwitchState(UIStateType.UITalePetCollect, callState, true)
    else
      self:SwitchState(UIStateType.UITalePetList, true)
    end
  end
end

function UITalePetModule:FormatTime(second)
  if second <= 0 then
    return "00:00:00"
  else
    local sec = second % 60
    local _sec = math.ceil(sec)
    local _min = math.floor(second / 60) % 60
    local _hour = math.floor(math.floor(second / 60) / 60) % 24
    local _day = math.floor(math.floor(math.floor(second / 60) / 60) / 24)
    if 0 < _day then
      return string.format("%dd-%02d:%02d:%02d", _day, _hour, _min, _sec)
    else
      return string.format("%02d:%02d:%02d", _hour, _min, _sec)
    end
  end
end

function UITalePetModule:ShowDialog(name, ...)
  GameGlobal.UIStateManager():ShowDialog(name, ...)
end

function UITalePetModule:SwitchState(uiStateType, ...)
  GameGlobal.UIStateManager():SwitchState(uiStateType, ...)
end

function UITalePetModule:Lock(name)
  GameGlobal.UIStateManager():Lock(name)
end

function UITalePetModule:UnLock(name)
  GameGlobal.UIStateManager():UnLock(name)
end
