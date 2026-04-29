_class("SeasonMazePlayerEffect", Object)
SeasonMazePlayerEffect = SeasonMazePlayerEffect

function SeasonMazePlayerEffect:Constructor()
  self._effCfgs = {
    TransStartPoint = {
      res = "S4_pfb_chuansong_out.prefab",
      duration = 1500
    },
    TransEndPoint = {
      res = "S4_pfb_chuansong_in.prefab",
      duration = 1500
    },
    GetGold = {
      res = "eff_gold_main_01.prefab",
      duration = 1500
    }
  }
  self._timers = {}
end

function SeasonMazePlayerEffect:Init(rootGo)
  self._rootTrans = rootGo.transform
  self._effect = {}
  for k, cfg in pairs(self._effCfgs) do
    local req = ResourceManager:GetInstance():SyncLoadAsset(cfg.res, LoadType.GameObject)
    if not req then
      Log.error("SeasonMazePlayerEffect load ClickEffect fail..", cfg.res)
    else
      local d = {}
      d.resReq = req
      d.trans = req.Obj.transform
      d.trans:SetParent(self._rootTrans)
      d.trans.rotation = Vector3(0, 0, 0)
      d.trans.gameObject:SetActive(false)
      self._effect[k] = d
    end
  end
  self._disposed = nil
end

function SeasonMazePlayerEffect:Dispose()
  self._disposed = true
  for k, eff in pairs(self._effect) do
    local req = eff.resReq
    req:Dispose()
    req = nil
  end
  table.clear(self._effect)
end

function SeasonMazePlayerEffect:PlayEffect(key, position)
  local eff = self._effect[key]
  if not eff then
    Log.error("SeasonMazePlayerEffect can't find eff ", key)
    return
  end
  local trans = eff.trans
  if self._timers[key] then
    GameGlobal.Timer():CancelEvent(self._timers[key])
    trans.gameObject:SetActive(false)
    self._timers[key] = nil
  end
  trans.gameObject:SetActive(true)
  trans:SetParent(self._rootTrans)
  trans.position = position
  local duration = self._effCfgs[key].duration
  self._timers[key] = GameGlobal.Timer():AddEventTimes(duration, TimerTriggerCount.Once, function()
    if not self._disposed then
      trans.gameObject:SetActive(false)
      self._timers[key] = nil
    end
  end)
end

function SeasonMazePlayerEffect:PlayEffectWithParent(key, parent)
  if self._disposed then
    return
  end
  local eff = self._effect[key]
  if not eff then
    Log.error("SeasonMazePlayerEffect can't find eff ", key)
    return
  end
  local trans = eff.trans
  if self._timers[key] then
    GameGlobal.Timer():CancelEvent(self._timers[key])
    trans.gameObject:SetActive(false)
    self._timers[key] = nil
  end
  trans:SetParent(parent)
  trans.gameObject:SetActive(true)
  trans.localPosition = Vector3(0, 0, 0)
  local duration = self._effCfgs[key].duration
  self._timers[key] = GameGlobal.Timer():AddEventTimes(duration, TimerTriggerCount.Once, function()
    if not self._disposed then
      trans.gameObject:SetActive(false)
      self._timers[key] = nil
    end
  end)
end
