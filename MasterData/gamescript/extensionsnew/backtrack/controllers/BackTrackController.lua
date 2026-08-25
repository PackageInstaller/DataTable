local BackTrackController = NewClass("BackTrackController", BaseController)

function BackTrackController:OnInit()
end

function BackTrackController:OnReset()
end

function BackTrackController:ReqUseBacktrackItem(itemId, chooseTid, successCallback, failCallback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnUseBacktrackItem", function(_data)
    if successCallback then
      successCallback()
    end
  end, function(_, code)
    Logger.Error("[回溯道具使用] 失败！错误码: %s", code.code)
    if failCallback then
      failCallback(code)
    end
  end, itemId, chooseTid)
end

return BackTrackController
