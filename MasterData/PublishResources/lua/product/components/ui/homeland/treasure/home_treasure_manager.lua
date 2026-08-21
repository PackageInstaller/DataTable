TreasureBirthPosType = {Good = 0, Bad = 1}
_class("HomelandTreasureManager", Object)
HomelandTreasureManager = HomelandTreasureManager

function HomelandTreasureManager:Constructor()
end

function HomelandTreasureManager:Init(homeClient)
  self._homelandClient = homeClient
  self._interactPointMng = homeClient:InteractPointManager()
  self._buildMng = homeClient:BuildManager()
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._treasureInfo = self._homelandModule:GetTreasureInfo()
  self._treasures = {}
  self._enterCallback = GameHelper:GetInstance():CreateCallback(self.DisposeTreasure, self)
  self._exitCallback = GameHelper:GetInstance():CreateCallback(self.ShowTreasure, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.EnterFindTreasure, self._enterCallback)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.ExitFindTreasure, self._exitCallback)
  self._treaCallback = GameHelper:GetInstance():CreateCallback(self.TreasureHandle, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.TreasureRemove, self._treaCallback)
end

function HomelandTreasureManager:Dispose()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.EnterFindTreasure, self._enterCallback)
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.ExitFindTreasure, self._exitCallback)
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.TreasureRemove, self._treaCallback)
  self:DisposeTreasure()
  self._homelandClient = nil
  self._homelandModule = nil
end

function HomelandTreasureManager:DisposeTreasure()
  for k, v in pairs(self._treasures) do
    v:Dispose()
  end
  self._treasures = {}
end

function HomelandTreasureManager:HomelandClient()
  return self._homelandClient
end

function HomelandTreasureManager:HomelandModule()
  return self._homelandModule
end

function HomelandTreasureManager:RefreshTreasure()
  local cfg = GameGlobal.GetUIModule(HomelandModule):GetCurrentToolCfg(ToolType.TT_SHOVEL)
  if cfg == nil then
    return false
  end
  local limit = Cfg.cfg_homeland_global.TreasureCountLimit.IntValue
  if limit <= table.count(self._treasureInfo.treasures) then
    return false
  end
  local item_id = Cfg.cfg_homeland_global.TreasureRefreshItemId.IntValue
  local im = GameGlobal.GetModule(ItemModule)
  if im:GetItemCount(item_id) <= 0 then
    return false
  end
  local range = Cfg.cfg_homeland_global.TreasureOccupyRange.FloatValue
  local birthID
  local cfgs = Cfg.cfg_homeland_treasure_birth({
    BirthType = TreasureBirthPosType.Good
  })
  table.shuffle(cfgs)
  for i, cfg in ipairs(cfgs) do
    if not self._treasureInfo.treasures[cfg.ID] then
      local pos = Vector3(cfg.BirthPos[1], cfg.BirthPos[2], cfg.BirthPos[3])
      if not self:IsBirthPosOccupied(pos, range) then
        birthID = cfg.ID
        break
      end
    end
  end
  if birthID == nil then
    cfgs = Cfg.cfg_homeland_treasure_birth({
      BirthType = TreasureBirthPosType.Bad
    })
    table.shuffle(cfgs)
    for i, cfg in ipairs(cfgs) do
      if not self._treasureInfo.treasures[cfg.ID] then
        birthID = cfg.ID
        break
      end
    end
  end
  if birthID == nil then
    Log.error("HomelandTreasureManager:OnEnterHomeland()  birthID == nil.")
    return false
  end
  TaskManager:GetInstance():StartTask(function(TT)
    local res, trea = self._homelandModule:HomelandGetNewTreasure(TT, birthID)
    if res:GetSucc() then
      self._treasureInfo = trea
    end
    self:ShowTreasure()
  end)
  return true
end

function HomelandTreasureManager:OnEnterHomeland()
  if self:RefreshTreasure() == false then
    self:ShowTreasure()
  end
end

function HomelandTreasureManager:IsBirthPosOccupied(pos, range)
  local function cb(newPos, hitdis)
    local canStart, hits = UnityEngine.AI.NavMesh.SamplePosition(newPos, nil, hitdis, UnityEngine.AI.NavMesh.AllAreas)
    
    if canStart then
      return false
    end
    return true
  end
  
  if cb(pos, 2) == true then
    return true
  end
  pos.x = pos.x + range
  if cb(pos, 1) == true then
    return true
  end
  pos.x = pos.x - range
  pos.z = pos.z - range
  if cb(pos, 1) == true then
    return true
  end
  pos.x = pos.x - range
  pos.z = pos.z + range
  if cb(pos, 1) == true then
    return true
  end
  pos.x = pos.x + range
  pos.z = pos.z + range
  if cb(pos, 1) == true then
    return true
  end
  return false
end

function HomelandTreasureManager:ShowTreasure()
  local sceneManager = self._homelandClient:SceneManager()
  local root = sceneManager:RuntimeRootTrans()
  for birthID, v in pairs(self._treasureInfo.treasures) do
    if v.state ~= TreasureState.TS_DESTROY then
      local treasure = HomelandTreasure:New(self, birthID, v)
      self._treasures[birthID] = treasure
      treasure:Show(root)
    end
  end
end

function HomelandTreasureManager:GetTreasure(birthID)
  return self._treasures[birthID]
end

function HomelandTreasureManager:GetTreasureState(birthID)
  local info = self._treasures[birthID]
  if info == nil then
    return TreasureState.TS_DESTROY
  end
  return info:GetState()
end

function HomelandTreasureManager:GetTreasureByPet(pstID)
  for birthID, v in pairs(self._treasureInfo.treasures) do
    if v.pet_id == pstID then
      return v.state
    end
  end
  return TreasureState.TS_DESTROY
end

function HomelandTreasureManager:DelTreasure(birthID)
  local t = self._treasures[birthID]
  if t then
    t:Dispose()
  end
  self._treasures[birthID] = nil
end

function HomelandTreasureManager:GetAllTreasure()
  local vv = {}
  for k, v in pairs(self._treasures) do
    if v:GetGameObj() ~= nil then
      vv[k] = v
    end
  end
  return vv
end

function HomelandTreasureManager:TreasureHandle(delmap)
  if delmap == nil then
    return
  end
  for k, v in pairs(delmap) do
    self:DelTreasure(v)
  end
end
