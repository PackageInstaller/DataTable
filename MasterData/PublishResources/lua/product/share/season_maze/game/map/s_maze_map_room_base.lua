_class("SMazeMapRoomBase", Object)
SMazeMapRoomBase = SMazeMapRoomBase

function SMazeMapRoomBase:Constructor(svrData, node)
  self._id = svrData.cfg_id
  if svrData.type == SeasonMazeRoomType.SMRT_PVE and svrData.is_bomb then
    self._type = SeasonMazeRoomType.SMRT_Empty
    self._srcType = SeasonMazeRoomType.SMRT_PVE
  else
    self._type = svrData.type
  end
  self._node = node
  self._events = {}
  self:_LoadModel(self._type)
  self._active = true
  self._awardAssets = {}
end

function SMazeMapRoomBase:Dispose()
  self._req:Dispose()
  self._req = nil
  self._node = nil
  self._gameObject = nil
  self._transform = nil
  self._active = false
  for k, v in pairs(self._events) do
    GameGlobal.EventDispatcher():RemoveCallbackListener(k, v)
  end
  self._events = nil
  self._triggering = true
end

function SMazeMapRoomBase:Type()
  return self._type
end

function SMazeMapRoomBase:ID()
  return self._id
end

function SMazeMapRoomBase:NodeID()
  return self._node:ID()
end

function SMazeMapRoomBase:Node()
  return self._node
end

function SMazeMapRoomBase:GameObject()
  return self._gameObject
end

function SMazeMapRoomBase:ShowDialog(name, ...)
  GameGlobal.UIStateManager():ShowDialog(name, ...)
end

function SMazeMapRoomBase:OnCross()
end

function SMazeMapRoomBase:Trigger()
  if self._triggering then
    Log.info("房间不处理重复触发:", self._className, self._id, self._type)
    return
  end
  self._triggering = true
  self:OnTrigger()
end

function SMazeMapRoomBase:OnTrigger()
  Log.exception("子类必须重写OnTrigger方法", debug.traceback())
end

function SMazeMapRoomBase:OnTriggerComplete(...)
  Log.exception("子类必须重写OnTriggerComplete方法", debug.traceback())
end

function SMazeMapRoomBase:Finish()
  self._triggering = false
  SMazeAdaptor.OnRoomSettleFinish(self)
end

function SMazeMapRoomBase:BindEvent(eventType, func)
  local callback = self._events[eventType]
  if callback then
    Log.fatal("不可重复监听事件:", eventType, debug.traceback())
    return
  end
  callback = GameHelper:GetInstance():CreateCallback(func, self)
  self._events[eventType] = callback
  GameGlobal.EventDispatcher():AddCallbackListener(eventType, callback)
end

function SMazeMapRoomBase:UnBindEvent(eventType)
  local callback = self._events[eventType]
  if callback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(eventType, callback)
    self._events[eventType] = nil
  else
    Log.fatal("未监听该事件，不用解绑:", eventType)
  end
end

function SMazeMapRoomBase:_LoadModel(type)
  local cfg = Cfg.cfg_season_maze_room_view[type]
  if type == SeasonMazeRoomType.SMRT_Resource then
    local roomCfg = Cfg.cfg_component_season_maze_room_res[self._id]
    if not roomCfg then
      Log.exception("cfg_component_season_maze_room_res 中找不到配置:", self._id)
    end
    local prefab = cfg.CustomParam[roomCfg.ResType].Prefab .. ".prefab"
    self._req = ResourceManager:GetInstance():SyncLoadAsset(prefab, LoadType.GameObject)
  else
    self._req = ResourceManager:GetInstance():SyncLoadAsset(cfg.Prefab .. ".prefab", LoadType.GameObject)
  end
  self._gameObject = self._req.Obj
  self._gameObject.layer = SMazeSceneLayer.Room
  self._gameObject:SetActive(true)
  self._transform = self._gameObject.transform
  self._transform.position = self._node:Position()
  self._transform.rotation = Quaternion.identity
  self._transform.localScale = Vector3.one * cfg.Scale
  self._animation = self._gameObject:GetComponentInChildren(typeof(UnityEngine.Animation))
  self._animName = {
    OpenLoop = cfg.OpenLoopAni,
    Open_To_Close = cfg.OpenOutAni,
    CloseLoop = cfg.CloseLoopAni,
    Open_To_Hightlight = cfg.TouchInAni,
    HightlightLoop = cfg.TouchLoopAni,
    Hightlight_To_Open = cfg.TouchOutAni,
    Open_To_Stay = cfg.StayInAni,
    StayLoop = cfg.StayLoopAni,
    Open_To_Close = cfg.StayOutAni
  }
end

function SMazeMapRoomBase:SetAwardAssets(assets)
  self._awardAssets = assets
end

function SMazeMapRoomBase:GetAndClearAwardAssets()
  local tmp = self._awardAssets
  self._awardAssets = nil
  return tmp
end

function SMazeMapRoomBase:Anim_HighLight(highLight)
  if highLight then
    self._animation:Play(self._animName.Open_To_Hightlight)
    self._animation:PlayQueued(self._animName.HightlightLoop)
  else
    self._animation:Play(self._animName.Hightlight_To_Open)
    self._animation:PlayQueued(self._animName.OpenLoop)
  end
end

function SMazeMapRoomBase:Anim_Init(state)
  if state == SMazeNodeState.StayTemp then
    self._animation:Play(self._animName.StayLoop)
  elseif state == SMazeNodeState.UnReachable then
    self._animation:Play(self._animName.CloseLoop)
  else
    if state == SMazeNodeState.Reachable then
      self._animation:Play(self._animName.OpenLoop)
    else
    end
  end
end

function SMazeMapRoomBase:Anim_State(oldState, newState)
  if oldState == SMazeNodeState.Reachable and newState == SMazeNodeState.UnReachable then
    self._animation:Play(self._animName.Open_To_Close)
    self._animation:PlayQueued(self._animName.CloseLoop)
    return
  end
  if oldState == SMazeNodeState.Reachable and newState == SMazeNodeState.StayTemp then
    self._animation:Play(self._animName.Open_To_Stay)
    self._animation:PlayQueued(self._animName.StayLoop)
    return
  end
  if oldState == SMazeNodeState.StayTemp and newState == SMazeNodeState.UnReachable then
    self._animation:Play(self._animName.Open_To_Close)
    self._animation:PlayQueued(self._animName.CloseLoop)
    return
  end
  Log.error("不处理的动画状态:", oldState, newState)
end
