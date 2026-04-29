function G_ShowException(expmessage, stWorkPath)
  if Log.loglevel < ELogLevel.None then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.System, PopupMsgBoxType.OkCancel, "", expmessage)
  end
end

function G_StartLuaProfiler()
  GameGlobal.StartProfiler()
end

function G_StopLuaProfiler()
  GameGlobal.StopProfiler()
end

function G_GetNoticeData(noticeGroup, language, region, partition, extraJson)
  local data = ""
  local fileName
  if noticeGroup == "beforeEnter" then
    fileName = "noticedata_beforeEnter.bytes"
  elseif noticeGroup == "system" then
    fileName = "noticedata_system.bytes"
  elseif noticeGroup == "active" then
    fileName = "noticedata_active.bytes"
  elseif noticeGroup == "afterEnter" then
    fileName = "noticedata_afterEnter.bytes"
  end
  if fileName == nil then
    Log.fatal("###noticedata --  fileName is nil !")
    return nil
  end
  local request = ResourceManager:GetInstance():SyncLoadAsset(fileName, LoadType.Text)
  if request.Obj ~= nil then
    data = EngineGameHelper.GetUTF8String(request.Obj)
  else
  end
  return data
end
