_class("HomelandOre", Object)
HomelandOre = HomelandOre
local OreState = {
  Empty = 1,
  Half = 2,
  Full = 3
}
_enum("OreState", OreState)

function HomelandOre:Constructor(oreID, oreGO, oreCfg, miningManager)
  self._oreID = oreID
  self._oreGO = oreGO
  self._oreCfg = oreCfg
  self._miningManager = miningManager
  self._dropTimes = 0
  self._nextRefreshTime = 0
  self._cutTimes = 0
  self._timerEvent = nil
  self._refreshEvent = nil
  self._oreStateGo = oreGO
  self._clearCutTimesTime = 1800000
  self._oreGoName = {
    "CutForbidden.prefab",
    "CutForbidden.prefab",
    "CutForbidden.prefab"
  }
  self._oreStateGoOffset = Vector3(0, 0, 0)
  self._serverData = nil
  self._refreshTimesTime = nil
  self._needRefresh = true
  self._oreState = nil
  self._stoneLod0 = self._oreGO.transform:Find("model/hl_envpfb_props_ore_01/meshroot/hl_envmod_props_ore_01_LOD0/hl_envmod_props_ore_01_part01")
  self._stoneLod1 = self._oreGO.transform:Find("model/hl_envpfb_props_ore_01/meshroot/hl_envmod_props_ore_01_LOD1/hl_envmod_props_ore_01_part01")
  if self._stoneLod0 == nil then
    Log.error("HomelandOre:Constructor _stone = nil oreID ", self._oreID, self._oreGO.name)
  end
  self._objFadeCpt0 = self._stoneLod0:GetComponent(typeof(FadeComponent))
end

function HomelandOre:Dispose()
  if self._timerEvent then
    self._timerEvent:Cancel()
  end
  if self._oreStateGo then
    UIHelper.DestroyGameObject(self._oreStateGo)
    self._oreStateGo = nil
  end
end

function HomelandOre:ID()
  return self._oreID
end

function HomelandOre:GetInteractRedStatus()
  return false
end

function HomelandOre:EnterInteractScope()
  self:RefreshOnOreStateChange()
end

function HomelandOre:LeaveInteractScope()
  if self._oreStateGo then
  end
end

function HomelandOre:RefreshOnOreStateChange()
  if not self._oreState then
    self._oreState = self:GetOreState()
  elseif self:GetOreState() == self._oreState then
    return
  else
    self._oreState = self:GetOreState()
  end
  if self._oreState == OreState.Empty then
    self:Disappear()
  else
    self._objFadeCpt0.Alpha = 1
    self._stoneLod0.gameObject:SetActive(true)
    self._stoneLod1.gameObject:SetActive(true)
  end
end

function HomelandOre:SetOreServerData(data)
  self._serverData = data
  self:SetDropTimes(data.drop_times)
  self._needRefresh = self:CheckNeedRefresh()
end

function HomelandOre:SetDropTimes(dropTimes)
  self._dropTimes = dropTimes
  self:RefreshOnOreStateChange()
end

function HomelandOre:SetRefreshTime(nextTime)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = self._timeModule:GetServerTime()
  self._nextRefreshTime = nextTime * 1000 - nowTime
  if self._nextRefreshTime > 0 and not self._refreshEvent then
    self._refreshEvent = GameGlobal.Timer():AddEvent(self._nextRefreshTime, function()
      self._refreshEvent:Cancel()
      self._refreshEvent = nil
      self._needRefresh = true
      GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandRefreshOreInfo)
    end)
  end
end

function HomelandOre:IncreaseDropTimes()
  self._dropTimes = self._dropTimes + 1
  self:RefreshOnOreStateChange()
  self._needRefresh = self:CheckNeedRefresh()
end

function HomelandOre:ResetClearTimer()
  if self._timerEvent then
    self._timerEvent:Cancel()
    self._timerEvent = nil
  end
  self._timerEvent = GameGlobal.Timer():AddEvent(self._clearCutTimesTime, function()
    self._cutTimes = 0
  end)
end

function HomelandOre:ClearCutTimes()
  self._cutTimes = 0
  if self._timerEvent then
    self._timerEvent:Cancel()
    self._timerEvent = nil
  end
end

function HomelandOre:IncreaseCutTimes()
  self._cutTimes = self._cutTimes + 1
  return self._cutTimes
end

function HomelandOre:GetInteractPosition(index)
  if self._interactpos == nil then
    self._interactpos = self._oreGO.transform.position
  end
  return self._interactpos
end

function HomelandOre:RefreshOreState(state)
  if state == OreState.Full then
  elseif state == OreState.Half then
  elseif state == OreState.Empty then
  end
end

function HomelandOre:ClearRefreshTimeEvent()
  self._refreshEvent = nil
end

function HomelandOre:GetOreServerId()
  if self._serverData then
    return self._serverData.mine_id
  end
end

function HomelandOre:CheckCanCut()
  return not (self._dropTimes >= self._oreCfg.DropLimit)
end

function HomelandOre:CheckNeedRefresh()
  if self._dropTimes >= self._oreCfg.DropLimit then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandOreRefresh)
    return true
  end
  return false
end

function HomelandOre:GetOreState()
  local curState = OreState.Empty
  if self._dropTimes >= self._oreCfg.DropLimit then
    curState = OreState.Empty
  elseif self._dropTimes >= self._oreCfg.DropLimit / 2 and self._dropTimes < self._oreCfg.DropLimit then
    curState = OreState.Half
  else
    curState = OreState.Full
  end
  return curState
end

function HomelandOre:GetPlayerDirection(chara)
  if not self._oreStateGo then
    return chara._currentForward
  end
  local pos = self._oreStateGo.transform.position
  local vec = Vector3(pos.x, 0, pos.z)
  local charaPos = Vector3(chara:Transform().position.x, 0, chara:Transform().position.z)
  return vec - charaPos
end

function HomelandOre:GetCutRadius()
  return self._oreCfg.CutRadius
end

function HomelandOre:GetOreEffectPos(chara)
  local path = ""
  if self._oreStateGo then
    local cfg = GameGlobal.GetUIModule(HomelandModule):GetCurrentToolCfg(ToolType.TT_PICK)
    path = cfg.AttachPath
    local data = string.split(cfg.Res, ".prefab")
    return path .. "/" .. data[1]
  end
  return path
end

function HomelandOre:Disappear()
  TaskManager:GetInstance():StartTask(function(TT)
    local addtime = 0
    local anitime = 1
    local aptime = 0.05
    while addtime < anitime do
      self._objFadeCpt0.Alpha = self._objFadeCpt0.Alpha - aptime
      addtime = addtime + 0.05
      YIELD(TT, 10)
    end
    self._objFadeCpt0.Alpha = 0
    self._stoneLod0.gameObject:SetActive(false)
    self._stoneLod1.gameObject:SetActive(false)
  end)
end
