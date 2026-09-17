local this = class("settingChangeData")
local _optionDataTpl = L_GameTpl:getOptionDataTpl()

function this:ctor()
  self.map = {}
end

function this:addOption(id, val)
  local strVal = tostring(val)
  local data = L_SettingStore:getSetData(id)
  local isChanged = strVal ~= data
  if isChanged then
    local tpl = _optionDataTpl:getTplById(id)
    local changeImmediately = _optionDataTpl:getChangeImmediately(tpl)
    if changeImmediately then
      L_SettingStore:setSetting(id, val)
    else
      self.map[id] = {new = strVal}
    end
    self:onChanged(id, strVal)
    L_SettingStore:recordChanged(id)
  else
    self:removeOption(id)
  end
  return isChanged
end

function this:removeOption(id)
  self.map[id] = nil
  local cfg = L_Const.settingKey[id]
  if cfg then
    local action = C_InputManager.GetAction(cfg[1])
    if action then
      action:RemoveAllBindingOverrides()
    else
      local a = 1
    end
  end
end

function this:getNew(id)
  local val = self.map[id]
  return val and val.new
end

function this:getNewOrDefault(id)
  local val = self:getNew(id) or L_SettingStore:getSetData(id)
  return val
end

function this:getMap()
  return self.map
end

function this:getSameKey(id, val)
  for i, _ in pairs(L_Const.settingKey) do
    if id ~= i and self:getNewOrDefault(i) == val then
      return i
    end
  end
end

function this:apply()
  for id, v in pairs(self.map) do
    if id == L_Const.settingType.renderAccuracy and L_DeviceTpl:getEquipment() == L_Const.equipment.pc and L_SettingStore:getSetData(L_Const.settingType.superResolution) ~= "1" then
    else
      L_SettingStore:setSetting(id, v.new)
    end
  end
end

function this:onChanged(id, val)
  if id == L_Const.settingType.vSync then
    local isOn = val == "2"
    L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.frame, isOn and L_Const.settingState.block or L_Const.settingState.none)
  end
  if id == L_Const.settingType.superResolution then
    local isOn = val ~= "1"
    local showLevel = L_SettingStore.checkAdapter:checkState(L_Const.settingType.dlssLevel)
    L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.dlssLevel, showLevel)
    L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.renderAccuracy, isOn and L_Const.settingState.block or L_Const.settingState.none)
  elseif id == L_Const.settingType.windowMode then
    L_SettingStore.data.cache[L_Const.settingType.resolution] = L_SettingStore:getResolutionData(tonumber(val))
    L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.resolution, L_Const.settingState.none)
  end
  if id == L_Const.settingType.resolution or id == L_Const.settingType.windowMode then
    local dlssOn = L_SettingStore:getSetData(L_Const.settingType.superResolution) ~= "1"
    if dlssOn then
      L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.renderAccuracy, L_Const.settingState.block)
    else
      L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.renderAccuracy, L_Const.settingState.none)
    end
  end
  if id == L_Const.settingType.dlssLevel then
    local dlssOn = L_SettingStore:getSetData(L_Const.settingType.superResolution) ~= "1"
    if dlssOn then
      L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.renderAccuracy, L_Const.settingState.block)
    else
      L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.renderAccuracy, L_Const.settingState.none)
    end
  end
  if id == L_Const.settingType.textureQuality then
    L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.graphicsMemory, L_Const.settingState.none)
  end
end

return this
