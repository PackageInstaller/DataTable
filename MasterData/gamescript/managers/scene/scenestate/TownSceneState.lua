local TownScene, Super = System.NewClass("TownScene", BaseSceneState)

function TownScene:ctor()
  Super.ctor(self)
end

function TownScene:OnInitSceneData()
  Super.OnInitSceneData(self)
  TownDataUtils.ResetAll()
end

function TownScene:OnEnterScene()
  Super.OnEnterScene(self)
  Pool.Clear()
  SceneMgr.Instance:UnLoadAllBattleScenes()
  UnityBattleSceneMgr.UnLoadAllBattleResources()
  SceneMgr.Instance:UnLoadAllMapScenes()
  self:_EnterTown(1)
  AvgStoryManager.Instance:ClearSkipPlot()
  CS.UnityEngine.Input.multiTouchEnabled = false
  PoolManager.Instance:PreloadUIRes(function()
    UIManager.Instance:CloseByUrl(Urls.LoadingPanel)
  end)
  self:_StartReleaseResTimer()
end

function TownScene:OnExitScene()
  PoolManager.Instance:ClearUIRes()
  Super.OnExitScene(self)
  self:_ExitTown()
  UIManager.Instance:CloseAllExcept()
end

function TownScene:_EnterTown(townId)
  self:_ExitTown()
  self._town = Town(townId)
  self._town:Awake()
  DataCenter.townData.TownId = townId
end

function TownScene:_ExitTown()
  if self._town ~= nil then
    self._town:Destroy()
  end
  self._town = nil
  DataCenter.townData.TownId = 0
end

function TownScene:InsertQueue(queueLabel, callBack, safeTime, delayTime)
  self._town.queue:Insert(queueLabel, callBack, safeTime or 999, delayTime or 0)
end

function TownScene:FinishQueue(queueLabel)
  self._town.queue:Next(queueLabel)
end

function TownScene:Clear()
  self._town.queue:Clear()
end

return TownScene
