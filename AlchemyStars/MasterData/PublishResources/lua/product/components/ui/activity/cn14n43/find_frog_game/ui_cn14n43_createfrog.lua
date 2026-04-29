_class("UICN14N43CreateFrog", Object)
UICN14N43CreateFrog = UICN14N43CreateFrog

function UICN14N43CreateFrog:Constructor()
  self.CollectFrogData = {}
  self.RecycleFrogNum = 0
  self.FrogNumMax = 0
  self.FrogItems = {}
end

function UICN14N43CreateFrog:CreateFrog(uiName)
  local infos = self:_GetFrogInfos(uiName)
  if table.count(infos) == 0 then
    return
  end
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = UIStateSwitchReq:New()
    res:SetSucc(true)
    local campaign = UIActivityCampaign.New()
    campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_COLLECT_FROG, ECampaignCollectFrogComponentID.ECAMPAIGN_COLLECT_FROG_PERSON_PROCESS)
    self._localProcess = campaign:GetLocalProcess()
    self._personProgressComponent = self._localProcess:GetComponent(ECampaignCollectFrogComponentID.ECAMPAIGN_COLLECT_FROG_PERSON_PROCESS)
    self.cmpInfo = self._personProgressComponent:ComponentInfo()
    local sample = campaign:GetSample()
    self._endTime = sample.end_time
    self:_CollectFrogFormatData()
    self.RecycleFrogNum = self.cmpInfo.m_mark_else
    Log.debug("[Frog] [CreateFrog]  mark:", self.cmpInfo.m_mark, ", self.RecycleFrogNum:", self.RecycleFrogNum)
    self.FrogItems = {}
    for k, v in pairs(infos) do
      if self.CollectFrogData[v.ID] == 0 then
        self:_CreateFrogByInfo(v)
      end
    end
  end)
end

function UICN14N43CreateFrog:_GetFrogInfos(uiName)
  self.FrogNumMax = table.count(Cfg.cfg_frog_info())
  local infos = Cfg.cfg_frog_info({UIName = uiName})
  local formatInfos = {}
  if not infos then
    return formatInfos
  end
  for k, v in pairs(infos) do
    local o = CfgFrogInfo:New(v)
    table.insert(formatInfos, o)
  end
  return formatInfos
end

function UICN14N43CreateFrog:_CreateFrogByInfo(info)
  local frogNode = GameGlobal.UIStateManager():CallUIMethod(info.UIName, "GetUIComponent", "UISelectObjectPath", info.UINodeName)
  if not frogNode then
    return
  end
  local items = frogNode:SpawnObjects("UICN14N43Frog", 1)
  local item = items[1]
  self.FrogItems[info.ID] = item
  item:SetData(false, info.ID, function()
    self:_ClickFrog(info)
  end)
end

function UICN14N43CreateFrog:_ClickFrog(info)
  if self:_CheckActivityOver() then
    return
  end
  GameGlobal.UIStateManager():ShowDialog(UIStateType.UICN14N43FrogCollect, info, function(frogID)
    if self:_CheckActivityOver() then
      return
    end
    self.cmpInfo = self._personProgressComponent:ComponentInfo()
    self:_CollectFrogFormatData()
    self:_CollectFrog(frogID)
  end)
end

function UICN14N43CreateFrog:_CollectFrog(frogID)
  local item = self.FrogItems[frogID]
  self.CollectFrogData[frogID] = 1
  local mark = 0
  for i = 1, self.FrogNumMax do
    local t = self.CollectFrogData[i]
    if t == 1 then
      mark = mark << 1 | 1
    else
      mark = mark << 1
    end
  end
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = UIStateSwitchReq:New()
    res:SetSucc(true)
    local response = self._personProgressComponent:HandlePersonProgressCollect(TT, res, 0, mark, self.RecycleFrogNum)
    Log.debug("[Frog] [HandlePersonProgressCollect]  mark:", mark, ", self.RecycleFrogNum:", self.RecycleFrogNum)
    if item and response and response.ret == 0 then
      Log.debug("[Frog] [HandlePersonProgressCollect]  response.ret == 0")
      item:PlayCollectOver()
    end
  end)
end

function UICN14N43CreateFrog:_CollectFrogFormatData()
  self.CollectFrogData = {}
  local mark = self.cmpInfo.m_mark
  for i = self.FrogNumMax, 1, -1 do
    self.CollectFrogData[i] = mark & 1
    mark = mark >> 1
  end
end

function UICN14N43CreateFrog:_CheckActivityOver()
  local closeTime = self._endTime
  local nowtime = self._svrTimeModule:GetServerTime() * 0.001
  if closeTime < nowtime then
    GameGlobal.GetModule(CampaignModule):ShowErrorToast(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED, true)
    for key, value in pairs(self.FrogItems) do
      value:SetActive(false)
    end
    return true
  end
  return false
end

_class("CfgFrogInfo", Object)
CfgFrogInfo = CfgFrogInfo

function CfgFrogInfo:Constructor(info)
  self.ID = info.ID
  self.UIName = info.UIName
  self.UINodeName = info.UINodeName
  self.PopPos = Vector3(info.PopPos[1], info.PopPos[2], 0)
  self.PopTxtKey = info.PopTxtKey
end
