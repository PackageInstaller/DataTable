_class("SeasonMapExpressLevel", SeasonMapExpressBase)
SeasonMapExpressLevel = SeasonMapExpressLevel

function SeasonMapExpressLevel:Constructor(cfg, eventPoint)
  self._content = self._cfg.MissionID
  self._autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
  self._autoBinder:BindEvent(GameEventType.UISeasonOnLevelDiffChanged, self, self.RefreshRecord)
end

function SeasonMapExpressLevel:Update(deltaTime)
end

function SeasonMapExpressLevel:Dispose()
  self.super.Dispose(self)
  self._autoBinder:UnBindAllEvents()
end

function SeasonMapExpressLevel:OnPlay()
  if self._param == true then
    local cfg = Cfg.cfg_season_mission[self._content]
    if cfg and cfg.AudioID and cfg.AudioID > 0 then
      local module = GameGlobal.GetModule(SeasonModule)
      local component = module:GetSeasonMissionComponent()
      if component then
        local componentInfo = component:GetComponentInfo()
        local pass = componentInfo.m_pass_mission_info
        local map = componentInfo.m_stage_info
        if pass[cfg.ID] and not map[cfg.ID] then
          AudioHelperController.PlayUISoundAutoRelease(tonumber(cfg.AudioID))
        end
      end
    end
    self:Next()
  elseif self._content then
    local module = GameGlobal.GetModule(SeasonModule)
    local uiModule = GameGlobal.GetUIModule(SeasonModule)
    local curDiff = uiModule:GetCurrentSeasonLevelDiff()
    local missionID = self._content
    local cfg = Cfg.cfg_season_mission[self._content]
    if cfg and cfg.OrderID ~= curDiff then
      local cfgs = Cfg.cfg_season_mission({
        GroupID = cfg.GroupID,
        OrderID = curDiff
      })
      if cfgs then
        missionID = cfgs[1].ID
      end
    end
    UISeasonHelper.TriggerMissionNode(self._eventPoint:EventPointType(), missionID, module:GetCurSeasonObj(), self._eventPoint)
    uiModule:SeasonManager():SeasonPlayerManager():GetPlayer():PlayAnimation(SeasonPlayerAnimation.BattleIdle)
    self._state = SeasonExpressState.Playing
    module:RecordLevelExpress(self._eventPoint:GetID(), self._eventPoint:GroupID(), SeasonExpressType.Level)
  end
end

function SeasonMapExpressLevel:RefreshRecord(diff)
  if self._state == SeasonExpressState.Playing then
    local module = GameGlobal.GetModule(SeasonModule)
    local info = module:GetLevelExpress()
    if info and info.groupID == self._eventPoint:GroupID() then
      local cfg = Cfg.cfg_season_mission({
        GroupID = info.groupID,
        OrderID = diff
      })
      if cfg then
        module:RecordLevelExpress(cfg[1].ID, info.groupID, SeasonExpressType.Level)
      end
    end
  end
end
