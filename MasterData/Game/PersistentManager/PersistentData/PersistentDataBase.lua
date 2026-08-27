local PersistentDataBase = class("PersistenDataBase")

function PersistentDataBase:InitBySaveData(data)
end

function PersistentDataBase:InitByDefaultData()
end

function PersistentDataBase:GetSaveEncodeTable()
  return self
end

function PersistentDataBase:GetSaveDataFilePath()
  return ""
end

function PersistentDataBase:SetPstDataDirty()
  self.isDirty = true
end

function PersistentDataBase:IsPstDataDirty()
  return self.isDirty
end

function PersistentDataBase:ResetPstDataDirty()
  self.isDirty = false
end

function PersistentDataBase:AutoSaveSingletonPst()
  PersistentManager:SaveModelData(self.__packageId)
  self.__delayTimerId = nil
end

function PersistentDataBase:DelaySavePstData(delay)
  if self.__delayTimerId ~= nil then
    return
  end
  self.__delayTimerId = TimerManager:StartTimer(delay, self.AutoSaveSingletonPst, self, true, false, true)
end

function PersistentDataBase:OnLogoutDelete()
  TimerManager:StopTimer(self.__delayTimerId)
end

return PersistentDataBase
