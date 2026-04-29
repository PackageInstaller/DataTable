_class("AircraftAffinityAnim", Object)
AircraftAffinityAnim = AircraftAffinityAnim

function AircraftAffinityAnim:Constructor(petGameObject, award, affinityTip, onFinish)
  self._resReqs = {}
  local req = ResourceManager:GetInstance():SyncLoadAsset("uieff_other_light_1.prefab", LoadType.GameObject)
  self._lightEft = req.Obj
  self._lightEft.transform.position = petGameObject.transform.position
  self._resReqs[#self._resReqs + 1] = req
  local tls = {}
  tls[#tls + 1] = EZTL_Callback:New(function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "AircraftAffinityAnim")
    self._lightEft:SetActive(true)
    GameGlobal.UIStateManager():ShowDialog("UIAircraftUnlockFileController", StringTable.Get("str_aircraft_review_story"), StringTable.Get("str_aircraft_review_story_en"))
  end, "打开ui")
  tls[#tls + 1] = EZTL_Wait:New(3000, "等3秒")
  tls[#tls + 1] = EZTL_Callback:New(function()
    self._lightEft:SetActive(false)
    GameGlobal.UIStateManager():CloseDialog("UIAircraftUnlockFileController")
  end, "关闭ui")
  if affinityTip then
    tls[#tls + 1] = EZTL_Callback:New(function()
      ToastManager.ShowToast(affinityTip)
    end, "toast")
    tls[#tls + 1] = EZTL_Wait:New(1500, "等toast1.5秒")
  end
  if award then
    tls[#tls + 1] = EZTL_Callback:New(function()
      GameGlobal.UIStateManager():ShowDialog("UIGetItemController", award, onFinish)
    end, "获得物品弹窗")
  end
  tls[#tls + 1] = EZTL_Callback:New(function()
    self:Dispose()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "AircraftAffinityAnim")
  end, "动画播完，析构")
  self._timeLine = EZTL_Sequence:New(tls, "动画总时间线，串行")
  self._player = EZTL_Player:New()
end

function AircraftAffinityAnim:Play()
  if self._player:IsPlaying() then
    Log.fatal("正在播放动画")
    return
  end
  self._player:Play(self._timeLine)
end

function AircraftAffinityAnim:Dispose()
  for _, req in ipairs(self._resReqs) do
    req:Dispose()
  end
end
