local SceneLoader = {
  __name = "SceneLoader"
}

function SceneLoader.PrepareLoading(completeCallback)
  SceneLoader.StartLoading()
  if completeCallback then
    completeCallback()
  end
end

function SceneLoader.StartLoading()
  ProtoManager.Instance:ClearRpcReconnectInfo()
end

function SceneLoader.StartMapLoading(loadCb)
  ProtoManager.Instance:ClearRpcReconnectInfo()
  local co = TaskMgr.Instance.Fork(function()
    TaskMgr.Instance:WaitForUpdate()
    if loadCb then
      loadCb()
    end
  end)
  return co
end

function SceneLoader.CloseLoadingPanel()
  UIManager.Instance:CloseByUrl(Urls.LoadingPanel)
end

function SceneLoader.EndLoading(completeCallback, co)
  local endStart
  endStart = TimerManager.Instance:CreateTimer(0.1, 1, nil, function()
    TimerManager.Instance:StopTimer(endStart)
    SceneLoader.CloseLoadingPanel()
    if completeCallback then
      completeCallback()
    end
    if co then
      TaskMgr.Instance:StopSleep(co)
    end
  end)
end

return SceneLoader
