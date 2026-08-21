_class("UIMainLobbyExtraBase", UICustomWidget)
UIMainLobbyExtraBase = UIMainLobbyExtraBase

function UIMainLobbyExtraBase:SetData(sample_info)
  self._sample_info = sample_info
  self:RefreshView()
end

function UIMainLobbyExtraBase:RefreshView()
end

function UIMainLobbyExtraBase:CheckCampaignOpen()
  local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  if self._sample_info:IsShow(svrTime) then
    return true
  end
  local tips = StringTable.Get("str_activity_error_107")
  ToastManager.ShowToast(tips)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainLobbyExtraRefresh)
  return false
end

function UIMainLobbyExtraBase:RefreshSampleData()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainLobbyExtraSampleRequest)
end
