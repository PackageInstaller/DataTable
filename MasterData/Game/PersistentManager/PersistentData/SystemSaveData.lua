local PersistentDataBase = require("Game.PersistentManager.PersistentData.PersistentDataBase")
local SystemSaveData = class("SystemSaveData", PersistentDataBase)

function SystemSaveData:GetSaveDataFilePath()
  return PathConsts:GetPersistentSystemDataPath("system_data")
end

function SystemSaveData:InitBySaveData(data)
  self.audio = data.audio or {}
  self.display = data.display or {}
  self.oasisSky = data.oasisSky or {}
  self:__InitDefaultDisPlayData()
  self.misc = data.misc
  if self.misc == nil then
    self:__InitDefaultMiscSave()
  end
  if self.audio.globalMute == nil then
    self.audio.globalMute = false
  end
  self:_InitDefaultDescSet(data)
  self:_InitDecryptHotRes(data)
end

function SystemSaveData:InitByDefaultData()
  self.audio = {}
  self.audio.volumes = {}
  self.audio.mutes = {}
  self.audio.globalMute = false
  for index = 1, AudioManager.AudioTypeCount do
    self.audio.volumes[index] = 1
    self.audio.mutes[index] = false
  end
  self.display = {}
  self:__InitDefaultDisPlayData()
  self.oasisSky = {}
  self:_InitDefaultDescSet()
  self:__InitDefaultMiscSave()
  self:_InitDecryptHotRes(table.emptytable)
end

function SystemSaveData:__InitDefaultDisPlayData()
  local performanceCfg = self:__GetDefultPerformanceCfg()
  if performanceCfg == nil then
    error("performance setting cfg is null,id:" .. tostring(GameSystemInfo.GetDefaultPerformance()))
    return
  end
  if self.display == nil or self.display.performance_level == nil then
    self.display.performance_level = GameSystemInfo.GetDefaultPerformance()
  end
end

function SystemSaveData:__InitDefaultMiscSave()
  self.misc = {actEntranceReadOne = false}
end

function SystemSaveData:GetAudioData()
  return self.audio
end

function SystemSaveData:SetAudioDataVolume(index, value)
  if self.audio.volumes[index] ~= value then
    self.audio.volumes[index] = value
    self:SetPstDataDirty()
  end
end

function SystemSaveData:SetAudioDataMute(index, value)
  if self.audio.mutes[index] ~= value then
    self.audio.mutes[index] = value
    self:SetPstDataDirty()
  end
end

function SystemSaveData:SetAudioDataGlobalMute(value)
  if self.audio.globalMute ~= value then
    self.audio.globalMute = value
    self:SetPstDataDirty()
  end
end

function SystemSaveData:GetDisplayData()
  return self.display
end

function SystemSaveData:GetDisplaySettingValue(keyName)
  local id = ConfigData.performance_typeinfo.name_index[keyName]
  if id == nil then
    return 0
  end
  if self.display.performance_level == 0 and self.display.display_map ~= nil then
    return self.display.display_map[id] or 0
  else
    local performanceCfg = self:__GetCurrentPerformanceCfg()
    if performanceCfg == nil then
      return 0
    end
    return performanceCfg[keyName]
  end
end

function SystemSaveData:SetDisplaySettingValue(keyName, value)
  local id = ConfigData.performance_typeinfo.name_index[keyName]
  if id == nil then
    return
  end
  if self.display.display_map == nil then
    self:__InitDisplayMap()
  end
  value = value or 0
  if self.display.display_map[id] ~= value then
    self.display.display_map[id] = value
    self:SetPstDataDirty()
  end
end

function SystemSaveData:GetDisplayPerformanceLevelValue()
  if self.display ~= nil then
    return self.display.performance_level
  end
end

function SystemSaveData:SetDisplayPerformanceLevelValue(value)
  if self.display.performance_level ~= value then
    self.display.performance_level = value or 0
    self:SetPstDataDirty()
  end
end

function SystemSaveData:__GetDefultPerformanceCfg()
  return ConfigData.performance_setting[GameSystemInfo.GetDefaultPerformance()]
end

function SystemSaveData:__GetCurrentPerformanceCfg()
  if self.display then
    return ConfigData.performance_setting[self.display.performance_level]
  end
  return self:__GetDefultPerformanceCfg()
end

function SystemSaveData:__InitDisplayMap()
  if self.display.display_map ~= nil then
    return
  end
  local performanceCfg = self:__GetDefultPerformanceCfg()
  if performanceCfg == nil then
    error("performance setting cfg is null,id:" .. tostring(GameSystemInfo.GetDefaultPerformance()))
    return
  end
  if self.display.display_map == nil then
    self.display.display_map = {}
  end
  for id, typeinfoCfg in pairs(ConfigData.performance_typeinfo) do
    local keyName = typeinfoCfg.name
    if self.display.display_map[id] == nil then
      self.display.display_map[id] = performanceCfg[keyName]
    end
  end
end

function SystemSaveData:GetOasisSkyPreset()
  return self.oasisSky.presetId or 0
end

function SystemSaveData:SetOasisSkyPreset(value)
  if self.oasisSky.presetId ~= value then
    self.oasisSky.presetId = value
    self:SetPstDataDirty()
  end
end

function SystemSaveData:GetOasisSkyLocation()
  return self.oasisSky.latitude or 0, self.oasisSky.longitude or 0
end

function SystemSaveData:SetOasisSkyLocation(latitude, longitude)
  if self.oasisSky.latitude ~= latitude or self.oasisSky.longitude ~= longitude then
    self.oasisSky.latitude = latitude
    self.oasisSky.longitude = longitude
    self:SetPstDataDirty()
  end
end

function SystemSaveData:_InitDefaultDescSet(data)
  if data == nil or data.gameSet == nil then
    self.gameSet = {}
    self.gameSet.multSet = {}
    self.gameSet.isTodayPlayerUltSkillAnimi = {}
  else
    self.gameSet = data.gameSet
    self.gameSet.describes = data.gameSet.describes
    if data.gameSet.multSet ~= nil then
      self.gameSet.multSet = data.gameSet.multSet
    end
    if data.gameSet.isTodayPlayerUltSkillAnimi == nil then
      self.gameSet.isTodayPlayerUltSkillAnimi = {}
    else
      self.gameSet.isTodayPlayerUltSkillAnimi = data.gameSet.isTodayPlayerUltSkillAnimi
    end
  end
  if self.gameSet.multSet == nil or table.count(self.gameSet.multSet) < 1 then
    self.gameSet.multSet = self.gameSet.multSet or {}
    self.gameSet.singleReddot = true
  end
  for id, cfg in pairs(ConfigData.game_set_describe) do
    if id ~= eGameSetDescType.skill and id ~= eGameSetDescType.chip and self.gameSet.multSet[id] == nil then
      self.gameSet.multSet[id] = cfg.defalt_detail
    end
  end
end

function SystemSaveData:GetDescribeSettingOld()
  return self.gameSet.describes
end

function SystemSaveData:GetMultSettingIndex(eDescTypeId)
  if self.gameSet.multSet[eDescTypeId] == nil then
    return 1
  end
  return self.gameSet.multSet[eDescTypeId]
end

function SystemSaveData:SetMultSettingIndex(eDescTypeId, index)
  local val = self.gameSet.multSet[eDescTypeId]
  if val ~= index then
    self.gameSet.multSet[eDescTypeId] = index
    self:SetPstDataDirty()
  end
end

function SystemSaveData:GetIsTodayPlayedUltSkillAnimi(skillId)
  return self.gameSet.isTodayPlayerUltSkillAnimi[skillId] or false
end

function SystemSaveData:SetIsTodayPlayedUltSkillAnimi(skillId, bool)
  local val = self.gameSet.isTodayPlayerUltSkillAnimi[skillId]
  if val ~= bool then
    self.gameSet.isTodayPlayerUltSkillAnimi[skillId] = bool
    self:SetPstDataDirty()
  end
end

function SystemSaveData:CleanIsTodayPlayedUltSkillAnimi()
  self.gameSet.isTodayPlayerUltSkillAnimi = {}
  self:SetPstDataDirty()
end

function SystemSaveData:GetActEntranceReadOneValue()
  return self.misc.actEntranceReadOne
end

function SystemSaveData:SetActEntranceReadOneValue(value)
  if self.misc.actEntranceReadOne ~= value then
    self.misc.actEntranceReadOne = value or false
    self:SetPstDataDirty()
  end
end

function SystemSaveData:GetGameSettingIsHaveReddot()
  return self.gameSet.singleReddot
end

function SystemSaveData:SetGameSettingIsHaveReddot(value)
  if self.gameSet.singleReddot ~= value then
    self.gameSet.singleReddot = value
    self:SetPstDataDirty()
  end
end

function SystemSaveData:_InitDecryptHotRes(data)
  self.decryptHotResData = data.decryptHotResData or {
    resVersion = nil,
    decryptHotResDic = {}
  }
end

function SystemSaveData:IsDecryptedHotRes(resStr)
  return self.decryptHotResData.decryptHotResDic[resStr] ~= nil
end

function SystemSaveData:SetDecryptedHotRes(resStr)
  if self.decryptHotResData.decryptHotResDic[resStr] == true then
    return
  end
  self.decryptHotResData.decryptHotResDic[resStr] = true
  self:SetPstDataDirty()
  PersistentManager:SaveModelData(self.__packageId)
end

function SystemSaveData:TryClearDecryptedHotRes(curResVersion)
  if self.decryptHotResData.resVersion == curResVersion then
    return
  end
  self.decryptHotResData.decryptHotResDic = {}
  self.decryptHotResData.resVersion = curResVersion
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

return SystemSaveData
