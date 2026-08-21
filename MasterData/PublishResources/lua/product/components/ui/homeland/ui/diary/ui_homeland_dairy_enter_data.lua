_class("UIHomelandDairyEnterData", CampaignDataBase)
UIHomelandDairyEnterData = UIHomelandDairyEnterData

function UIHomelandDairyEnterData:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.storyTaskLocalData = UIHomelandStoryTaskLocalData:New()
end

function UIHomelandDairyEnterData:CheckNew()
  if not self.storyTaskLocalData.HasPrefsStoryTaskGroupNew() then
    self.storyTaskLocalData.SetPrefsStoryTaskGroupNew(0)
  end
  local num = self.storyTaskLocalData.GetPrefsStoryTaskGroupNew()
  local taskNew = self.storyTaskLocalData:CheckHaveNewStoryTask()
  self._globalCfgTime = Cfg.cfg_homeland_global.StoryTaskMenuTime.StrValue
  if not self:CheckOpen(self._globalCfgTime) then
    return false
  end
  local unlock = GameGlobal.GetModule(HomelandModule):CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_STORY_TASK)
  if not unlock then
    return false
  end
  unlock = self.GetUnLockPrefs()
  return 0 < num or taskNew or unlock == 0
end

function UIHomelandDairyEnterData:CheckOpen(beginTime, timetype)
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local loginModule = GameGlobal.GetModule(LoginModule)
  timetype = timetype or 0
  local type = timetype == 0 and Enum_DateTimeZoneType.E_ZoneType_GMT or Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
  local beginTime = loginModule:GetTimeStampByTimeStr(beginTime, type)
  if curTime >= beginTime then
    return true
  end
  return false
end

function UIHomelandDairyEnterData:GetDairyEventCount()
  self.dairyData = {}
  self.dairyData = self.mHomeland:GetHomeLandEventInfo().finish_event_list
  local finishDairys = {}
  self._homelandDiaryCfg = Cfg.cfg_homeland_dairy_item({})
  for i, v in pairs(self.dairyData) do
    for index, item in pairs(self._homelandDiaryCfg) do
      if item.EventId == i then
        table.insert(finishDairys, i)
      end
    end
  end
  local readedList = self.mHomeland:GetHomelandDairyInfo().is_readed_dairy
  local count = 0
  if #self.dairyData then
    count = #finishDairys - #readedList
  end
  return count, finishDairys
end

function UIHomelandDairyEnterData.GetPstId()
  local mRole = GameGlobal.GetModule(RoleModule)
  return mRole:GetPstId()
end

function UIHomelandDairyEnterData.GetPrefsKeyStr(str)
  local playerPrefsKey = UIHomelandDairyEnterData.GetPstId() .. str
  return playerPrefsKey
end

function UIHomelandDairyEnterData.GetPrefsKey(key)
  return UIHomelandDairyEnterData.GetPrefsKeyStr("UIHomeLandDiaryEnterPrefsKey" .. key)
end

function UIHomelandDairyEnterData.HasPrefs(key)
  return UnityEngine.PlayerPrefs.HasKey(UIHomelandDairyEnterData.GetPrefsKey(key))
end

function UIHomelandDairyEnterData.GetPrefs(key)
  return UnityEngine.PlayerPrefs.GetInt(UIHomelandDairyEnterData.GetPrefsKey(key), 1)
end

function UIHomelandDairyEnterData.SetPrefs(key, count)
  UnityEngine.PlayerPrefs.SetInt(UIHomelandDairyEnterData.GetPrefsKey(key), count)
end

function UIHomelandDairyEnterData.HasUnLockPrefs()
  return UnityEngine.PlayerPrefs.HasKey(UIHomelandDairyEnterData.GetPrefsKey("unlock"))
end

function UIHomelandDairyEnterData.GetUnLockPrefs()
  return UnityEngine.PlayerPrefs.GetInt(UIHomelandDairyEnterData.GetPrefsKey("unlock"), 0)
end

function UIHomelandDairyEnterData.SetUnLockPrefs()
  UnityEngine.PlayerPrefs.SetInt(UIHomelandDairyEnterData.GetPrefsKey("unlock"), 1)
end
