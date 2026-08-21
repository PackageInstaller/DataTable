_class("SeasonMapExpressStory3D", SeasonMapExpressBase)
SeasonMapExpressStory3D = SeasonMapExpressStory3D

function SeasonMapExpressStory3D:Constructor(cfg, eventPoint)
  self._content = self._cfg.StoryID3D
  self._missionID = eventPoint:GetID()
end

function SeasonMapExpressStory3D:Update(deltaTime)
end

function SeasonMapExpressStory3D:OnPlay()
  self._state = SeasonExpressState.Playing
  UISeasonHelper.PlayStory3DInSeasonScence(self._content, function()
    self:_Record()
  end)
end

function SeasonMapExpressStory3D:_Record()
  GameGlobal.TaskManager():StartTask(function(TT)
    local module = GameGlobal.GetModule(MissionModule)
    module:SetMissionStoryActive(TT, self._content, ActiveStoryType.ActiveStoryType_BeforeBattle)
    self:_PlayAudio()
    self:Next()
  end)
end

function SeasonMapExpressStory3D:_PlayAudio()
  local cfg = Cfg.cfg_season_mission[self._missionID]
  if cfg and cfg.AudioID and cfg.AudioID > 0 then
    local module = GameGlobal.GetModule(SeasonModule)
    local component = module:GetSeasonMissionComponent()
    if component then
      local componentInfo = component:GetComponentInfo()
      local map = componentInfo.m_stage_info
      if not map[cfg.ID] then
        AudioHelperController.PlayUISoundAutoRelease(tonumber(cfg.AudioID))
      end
    end
  end
end
