local this = {}
local _optionDataTpl = L_GameTpl:getOptionDataTpl()
local _optionDisplayTpl = L_GameTpl:getOptionDataDisplayTpl()

function this:init()
  this.super.init(self)
  self.data = {
    cache = {},
    recordId = nil,
    keyDirty = false
  }
  self:injectCache()
end

function this:getSetData(id)
  local val = C_GameSettingManager.GetSettingValueById(id)
  return val
end

function this:getSetNumData(id)
  local num = self:getSetData(id)
  return tonumber(num) or 0
end

function this:getSetStrData(id)
  return self:getSetData(id)
end

function this:getDefaultNormal(type)
  local para = tonumber(_optionDataTpl:getOptionPara2(_optionDataTpl:getTplById(type))[2])
  return self:getSetData(type) / para
end

function this:getKeyWithPlayerId(key)
  return string.format("%s_%s", key, L_PlayerStore:getPlayerId())
end

function this:getMoveBlockJoystickPos()
  if not self:getHasKey(self:getKeyWithPlayerId(self.saveKey.setting_pos_joystickObj)) then
    return
  end
  local joyStrArr = string.split(self:getPrefsString(self:getKeyWithPlayerId(self.saveKey.setting_pos_joystickObj)), "_")
  if table.count(joyStrArr) < 2 then
    return nil
  end
  local joyStickRectPos = L_Vector3.new(joyStrArr[1], joyStrArr[2], 0)
  return joyStickRectPos
end

function this:getMovementBlockBtnPos(key)
  if not self:getHasKey(self:getKeyWithPlayerId(self.saveKey.setting_pos_joystickObj)) then
    return
  end
  local strArr = string.split(self:getPrefsString(self:getKeyWithPlayerId(string.format(self.saveKey.setting_pos, key))), "_")
  return L_Vector3.new(strArr[1], strArr[2], 0)
end

function this:getDeviceCapResultionId()
  local resultId = 1
  local maxWidth, maxHeight = L_DeviceTpl:getSystemResolution()
  local list = _optionDisplayTpl:getConfig()
  for i = 1, #list do
    local tpl = list[i]
    local id = _optionDisplayTpl:getId(tpl)
    local width = _optionDisplayTpl:getHorizontalPixels(tpl)
    local height = _optionDisplayTpl:getVerticalPixels(tpl)
    if maxWidth >= width and maxHeight >= height then
      return id
    end
  end
  return resultId
end

function this:getKeyDirty()
  return self.data.keyDirty
end

function this:getSettingKey(pId, id)
  local key = string.format(self.saveKey.setting_normal, pId, id)
  return key
end

function this:setLastPlayerId(playerId)
  if playerId ~= nil then
    self:setPrefsString(L_Const.prefsKey.lastPlayerId, playerId)
  end
end

function this:getLastPlayerId()
  return self:getPrefsString(L_Const.prefsKey.lastPlayerId)
end

function this:getLocalAccount()
  return self:getPrefsString(L_Const.prefsKey.playerAccount)
end

function this:getPrefsString(str)
  local val = C_PlayerPrefsUtility.GetString(str)
  return val
end

function this:getPrefsInt(str)
  local val = C_PlayerPrefsUtility.GetInt(str)
  return val
end

function this:getPrefsBool(str)
  local val = C_PlayerPrefsUtility.GetBool(str)
  return val
end

function this:getHasKey(key)
  local val = C_PlayerPrefsUtility.HasKey(key)
  return val
end

return this
