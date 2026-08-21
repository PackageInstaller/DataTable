function AirLog(...)
  Log.debug("[AircraftLog] ", ...)
end

function AirError(...)
  if EDITOR then
    Log.exception(...)
  else
    Log.fatal("[AircraftError] ", ...)
  end
end

function AirException(...)
  Log.exception("[AircraftError] ", ...)
end

function PopMsgBox(title, onOK)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", title, onOK, nil, function(param)
  end, nil)
end

function GetSvrTimeNow()
  return math.floor(GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001)
end
