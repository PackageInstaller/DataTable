_class("UIMainLobbyExtraCampEntry", UICustomWidget)
UIMainLobbyExtraCampEntry = UIMainLobbyExtraCampEntry

function UIMainLobbyExtraCampEntry:OnShow()
  self._max = 2
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self:AttachEvent(GameEventType.OnMainLobbyExtraRefresh, self.RefreshSpawnList)
  self:AttachEvent(GameEventType.OnMainLobbyExtraSampleRequest, self.RequestSampleList)
end

function UIMainLobbyExtraCampEntry:OnHide()
  self:UnLock("UIMainLobbyExtraCampEntry:RequestSampleList")
end

function UIMainLobbyExtraCampEntry:SetData(extraData)
  self._extraData = extraData
  self:SetEntrys()
end

function UIMainLobbyExtraCampEntry:RequestSampleList()
  self:Lock("UIMainLobbyExtraCampEntry:RequestSampleList")
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CampaignLoadInfoList(TT, res)
    self._extraData:RefreshCampaignDic()
    self:RefreshSpawnList()
    self:UnLock("UIMainLobbyExtraCampEntry:RequestSampleList")
  end, self)
end

function UIMainLobbyExtraCampEntry:RefreshSpawnList()
  self._extraData:RefreshSampleList()
  self:SetEntrys()
end

function UIMainLobbyExtraCampEntry:SetEntrys()
  self._campList = self._extraData:GetCampList()
  self._pool:SpawnObjects("UIMainLobbyExtraCampEntryItem", #self._campList)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #self._campList do
    local item = pools[i]
    local obj = self._campList[i]
    item:SetData(obj)
  end
end

function UIMainLobbyExtraCampEntry:RefreshCampSampleInfo(extraData)
  self._campList = extraData:GetCampList()
  self:SetEntrys()
end

_class("MainLobbyExtraData", Object)
MainLobbyExtraData = MainLobbyExtraData

function MainLobbyExtraData:Constructor()
  local campModule = GameGlobal.GetModule(CampaignModule)
  local tmpDic = campModule:GetCampaignSampleDic()
  self._openCampDic = tmpDic
  self._campList = {}
end

function MainLobbyExtraData:LoadCampaignData(TT)
  self._campList = {}
  local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  local idList = {}
  if self._openCampDic and table.count(self._openCampDic) > 0 then
    for id, obj in pairs(self._openCampDic) do
      local cfg = Cfg.cfg_main_lobby_side_entrys[id]
      if cfg then
        local sampleInfo = obj.m_sample_info
        if sampleInfo:IsShow(svrTime) then
          table.insert(idList, id)
        end
        if 2 <= #idList then
          break
        end
      end
    end
  end
  if 0 < #idList then
    table.sort(idList, function(a, b)
      local cfg_a = Cfg.cfg_main_lobby_side_entrys[a]
      local cfg_b = Cfg.cfg_main_lobby_side_entrys[b]
      return cfg_a.Sort < cfg_b.Sort
    end)
    for i = 1, #idList do
      local obj = self._openCampDic[idList[i]]
      table.insert(self._campList, obj)
    end
  end
  if idList and next(idList) then
    local campaignMpdul = GameGlobal.GetModule(CampaignModule)
    for index, id in ipairs(idList) do
      local cfg = Cfg.cfg_main_lobby_side_entrys[id]
      if cfg and cfg.DetailData then
        local res = AsyncRequestRes:New()
        res:SetSucc(false)
        campaignMpdul:CampaignComProtoLoadInfo(TT, res, id)
        if res:GetSucc() then
          Log.debug("###[MainLobbyExtraData] 侧边栏需要拉详细数据，成功，id:", id)
        else
          local result = res:GetResult()
          Log.error("###[MainLobbyExtraData] 侧边栏需要拉详细数据，但是失败了，id:", id, "|result:", result)
        end
      end
    end
  end
end

function MainLobbyExtraData:RefreshCampaignDic(CampDic)
  if CampDic then
    self._openCampDic = CampDic
  end
end

function MainLobbyExtraData:RefreshSampleList()
  self._campList = {}
  local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  local idList = {}
  if self._openCampDic and table.count(self._openCampDic) > 0 then
    for id, obj in pairs(self._openCampDic) do
      local cfg = Cfg.cfg_main_lobby_side_entrys[id]
      if cfg then
        local sampleInfo = obj.m_sample_info
        if sampleInfo:IsShow(svrTime) then
          table.insert(idList, id)
        end
        if 2 <= #idList then
          break
        end
      end
    end
  end
  if 0 < #idList then
    table.sort(idList, function(a, b)
      local cfg_a = Cfg.cfg_main_lobby_side_entrys[a]
      local cfg_b = Cfg.cfg_main_lobby_side_entrys[b]
      return cfg_a.Sort < cfg_b.Sort
    end)
    for i = 1, #idList do
      local obj = self._openCampDic[idList[i]]
      table.insert(self._campList, obj)
    end
  end
end

function MainLobbyExtraData:GetCampList()
  return self._campList
end

function MainLobbyExtraData:RefreshCampSampleInfo()
  local campModule = GameGlobal.GetModule(CampaignModule)
  local tmpDic = campModule:GetCampaignSampleDic()
  self._openCampDic = tmpDic
  self._campList = {}
  local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  local idList = {}
  if self._openCampDic and table.count(self._openCampDic) > 0 then
    for id, obj in pairs(self._openCampDic) do
      local cfg = Cfg.cfg_main_lobby_side_entrys[id]
      if cfg then
        local sampleInfo = obj.m_sample_info
        if sampleInfo:IsShow(svrTime) then
          table.insert(idList, id)
        end
        if 2 <= #idList then
          break
        end
      end
    end
  end
  if 0 < #idList then
    table.sort(idList, function(a, b)
      local cfg_a = Cfg.cfg_main_lobby_side_entrys[a]
      local cfg_b = Cfg.cfg_main_lobby_side_entrys[b]
      return cfg_a.Sort < cfg_b.Sort
    end)
    for i = 1, #idList do
      local obj = self._openCampDic[idList[i]]
      table.insert(self._campList, obj)
    end
  end
end
