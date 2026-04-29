require("ui_side_enter_center_content_base")
_class("UIEventTrailerContent", UISideEnterCenterContentBase)
UIEventTrailerContent = UIEventTrailerContent

function UIEventTrailerContent:DoInit(params)
  self._mainCfgKey = params.main_cfg
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self:InitCampaignList()
end

function UIEventTrailerContent:DoShow()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnShowEliminateWorldBoss)
  local events = self._content:GetAllSpawnList()
  for i, event in pairs(events) do
    event:PlayInAnim(i)
  end
end

function UIEventTrailerContent:DoHide()
end

function UIEventTrailerContent:DoDestroy()
end

function UIEventTrailerContent:InitCampaignList()
  local list = Cfg.cfg_event_trailer_main[self._mainCfgKey].CampaignGroup
  self:StartTask(function(TT)
    local campaignModule = self:GetModule(CampaignModule)
    local res = AsyncRequestRes:New()
    local lList = {}
    for _, v in pairs(list) do
      local cfg = Cfg.cfg_event_trailer_campaign[v]
      local campaignSample = campaignModule:GetReviewCampaignSampleByCampaignId(cfg.CampaignID)
      if not table.icontains(lList, cfg.CampaignID) and campaignSample and campaignSample.is_open then
        table.insert(lList, cfg.CampaignID)
      end
    end
    campaignModule:CampaignListComProtoLoadInfo(TT, res, lList)
    if res:GetSucc() then
      self._dataGroup = {}
      for _, v in pairs(list) do
        local cfg = Cfg.cfg_event_trailer_campaign[v]
        if cfg then
          local data = UIEventTrailerData:New()
          local statue, startTime, endTime = UIEventTrailerContent.GetEventStatue(cfg)
          data.cfg = cfg
          data.statue = statue
          data.startTime = startTime
          data.endTime = endTime
          table.insert(self._dataGroup, data)
        end
      end
      table.sort(self._dataGroup, function(a, b)
        if a == nil or b == nil or a == b then
          return false
        end
        if a.statue == EEventTrailerBtnStatue.Go and b.statue ~= EEventTrailerBtnStatue.Go then
          return true
        elseif a.statue ~= EEventTrailerBtnStatue.Go and b.statue == EEventTrailerBtnStatue.Go then
          return false
        elseif a.statue == EEventTrailerBtnStatue.Go and b.statue == EEventTrailerBtnStatue.Go then
          return a.cfg.OpenOrder < b.cfg.OpenOrder
        else
          return a.cfg.Order < b.cfg.Order
        end
      end)
      local events = self._content:SpawnObjects("UIEventTrailerItem", table.count(list))
      for i, event in pairs(events) do
        event:SetData(self._dataGroup[i])
        event:ClearNew()
        event:PlayInAnim(i)
      end
    else
      Log.fatal("拉取活动数据错误！", res:GetResult())
    end
  end)
end

local EEventTrailerType = {Campaign = 1, NormalEvent = 2}
_enum("EEventTrailerType", EEventTrailerType)

function UIEventTrailerContent.GetEventStatue(cfg)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local startTime = 0
  local endTime = 0
  local statue = EEventTrailerBtnStatue.End
  if cfg.CampaignType == EEventTrailerType.Campaign then
    local compCfg = Cfg.cfg_campaign_component[cfg.ComponentID]
    if not compCfg then
      Log.error("cfg_campaign_component can't find ", cfg.ComponentID)
      return
    end
    startTime = loginModule:GetTimeStampByTimeStr(compCfg.UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    endTime = loginModule:GetTimeStampByTimeStr(compCfg.CloseTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  elseif cfg.CampaignType == EEventTrailerType.NormalEvent then
    startTime = loginModule:GetTimeStampByTimeStr(cfg.StartTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    endTime = loginModule:GetTimeStampByTimeStr(cfg.EndTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  else
    Log.fatal("活动预告类型配置错误！！！", cfg.ID)
  end
  if curTime > endTime then
    statue = EEventTrailerBtnStatue.End
  elseif curTime < startTime then
    if cfg.HasIntro then
      statue = EEventTrailerBtnStatue.Watch
    else
      statue = EEventTrailerBtnStatue.NoWatch
    end
  else
    statue = EEventTrailerBtnStatue.Go
  end
  return statue, startTime, endTime
end

_class("UIEventTrailerData", Object)
UIEventTrailerData = UIEventTrailerData

function UIEventTrailerData:Constructor()
  self.cfg = nil
  self.statue = EEventTrailerBtnStatue.NoWatch
  self.startTime = 0
  self.endTime = 0
end
