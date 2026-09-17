local this = class("settingStore", G_BaseStore)
local _optionDataTpl = L_GameTpl:getOptionDataTpl()
local _optionDataTotalTpl = L_GameTpl:getOptionDataTotalTpl()
this:importPartialClass(require(L_R.store .. "setting.settingState"))
this.saveKey = {
  setting_normal = "setting_%s_%s",
  setting_startPos = "setting_startPos_%s",
  setting_pos = "setting_pos_%s",
  setting_startPos_joystickObj = "setting_startPos_joystickObj",
  setting_pos_joystickObj = "setting_pos_joystickObj"
}
this.event = {
  refreshEquipment = "refreshEquipment",
  refreshSceneQuality = "refreshQuality",
  refreshBright = "refreshBright",
  refreshContrast = "refreshContrast",
  refreshSaturation = "refreshSaturation",
  changeKey = "changeKey",
  showStateChange = "showStateChange",
  refreshMultiPlayerNum = "refreshMultiPlayerNum"
}
this.resolutions = {}

function this:ctor()
  self.adapter = nil
  self.checkAdapter = nil
  self:injectAdapter()
  this.super.ctor(self)
end

function this:clear()
end

function this:injectAdapter()
  self.checkAdapter = require(L_R.store .. "setting.adapter.settingCheckAdapter").new()
  local equip = L_DeviceTpl:getEquipment()
  if equip == L_Const.equipment.mobile then
    self.adapter = require(L_R.store .. "setting.adapter.settingAdapter_mobile").new()
  else
    self.adapter = require(L_R.store .. "setting.adapter.settingAdapter_pc").new()
  end
end

function this:injectCache(playerId)
  do return end
  error("lua设置已废弃，如果还有在调用的@wangsongyan  调用堆栈" .. debug.traceback())
  if playerId ~= nil then
    self:setLastPlayerId(playerId)
  end
  local lastId = tonumber(self:getLastPlayerId())
  playerId = playerId or lastId
  local isChanged = self.data.recordId ~= playerId
  if lastId == nil and playerId == nil then
    isChanged = true
  end
  if isChanged then
    self.data.recordId = playerId
    local data = _optionDataTpl:getConfig()
    for _, tpl in pairs(data) do
      local id = _optionDataTpl:getId(tpl)
      local key = self:getSettingKey(playerId, id)
      local initData = self:getPrefsString(key)
      if id == L_Const.settingType.language then
        initData = L_Const.settingText:GetParamIdx(L_Const.settingType.language, C_Define.audio_language)
      elseif id == L_Const.settingType.multiPlayerNum then
        local defaultShows = L_GameTpl:getGameConstTpl():getData("MULTIMAINCITY_DEFAULTSHOW", L_Const.GameTplType.list_int)
        if L_DeviceTpl:getIsPc() then
          initData = tostring(defaultShows[2])
        else
          initData = tostring(defaultShows[1])
        end
      elseif string.isEmpty(initData) or id == L_Const.settingType.resolution or id == L_Const.settingType.windowMode then
        initData = _optionDataTpl:getDefaultPara(tpl, self)
      end
      self.data.cache[id] = initData
    end
    self.adapter:adapt(L_Const.settingType.mute, self:getSetData(L_Const.settingType.mute))
    self.adapter:adapt(L_Const.settingType.bgm, self:getSetData(L_Const.settingType.bgm))
    self.adapter:adapt(L_Const.settingType.se, self:getSetData(L_Const.settingType.se))
    self.adapter:adapt(L_Const.settingType.cv, self:getSetData(L_Const.settingType.cv))
    self.adapter:adapt(L_Const.settingType.renderAccuracy, self:getSetData(L_Const.settingType.renderAccuracy))
  end
  return isChanged
end

function this:injectAndApplyCache(playerId)
  error("lua设置已废弃，如果还有在调用的@wangsongyan  调用堆栈" .. debug.traceback())
  self:injectCache(playerId)
  self:initImageQuality()
  local ignore = {
    [L_Const.settingType.text] = true,
    [L_Const.settingType.mute] = true,
    [L_Const.settingType.bgm] = true,
    [L_Const.settingType.se] = true,
    [L_Const.settingType.cv] = true,
    [L_Const.settingType.windowMode] = true,
    [L_Const.settingType.resolution] = true,
    [L_Const.settingType.renderAccuracy] = true
  }
  self:applyInit(ignore)
  self:initKeyJson(playerId)
end

function this:applyInit(ignore)
  for id, v in pairs(self.data.cache) do
    if ignore == nil or not ignore[id] then
      self.adapter:adapt(id, v)
    end
  end
end

function this:initImageQuality()
  local imageLevel = self.data.cache[L_Const.settingType.image]
  local imageDatas = _optionDataTotalTpl.data
  imageLevel = tonumber(imageLevel)
  if imageLevel and 2 <= imageLevel and imageLevel <= 5 then
    for i, v in pairs(imageDatas) do
      local m = _optionDataTotalTpl:getVal(v, imageLevel)
      self.data.cache[i] = tostring(m)
    end
  end
end

function this:setSetting(id, value)
  self.data.cache[id] = tostring(value)
  local playerId = L_PlayerStore:getPlayerId() or 0
  local key = self:getSettingKey(playerId, id)
  self:setPrefsString(key, tostring(value))
  self.adapter:adapt(id, value)
  if id == L_Const.settingType.module or id == L_Const.settingType.shadow then
    self:call(this.event.refreshSceneQuality)
  elseif L_Const.settingKey[id] then
    self.data.keyDirty = true
    self:call(this.event.changeKey, id)
  elseif id == L_Const.settingType.bright then
    self:setbright(value)
    self:call(this.event.refreshBright, id, value)
  elseif id == L_Const.settingType.contrast then
    self:setContrast(value)
    self:call(this.event.refreshContrast, id, value)
  elseif id == L_Const.settingType.saturation then
    self:setSaturation(value)
    self:call(this.event.refreshSaturation, id, value)
  elseif id == L_Const.settingType.multiPlayerNum then
    self:call(this.event.refreshMultiPlayerNum, id, value)
  end
end

function this:calResolutionFactor()
  return self.adapter:calResolutionFactor()
end

function this:refreshVolatileSetting()
  local data = _optionDataTpl:getConfig()
  for _, tpl in ipairs(data) do
    local id = _optionDataTpl:getId(tpl)
    if id == L_Const.settingType.windowMode then
      self.data.cache[id] = self:getWindowMode()
    elseif id == L_Const.settingType.resolution then
      self.data.cache[id] = self:getResolutionData()
    end
  end
end

function this:getWindowMode()
  return C_ResolutionUtility.s_windowMode + 1
end

local function filter(res, lastRes, sysRes)
  if res.width == lastRes[1] and res.height == lastRes[2] then
    return false
  end
  local resRatio = res.height / res.width
  local sysRatio = sysRes[2] / sysRes[1]
  if math.abs(resRatio - sysRatio) / sysRatio > 0.05 then
    return false
  end
  return true
end

function this:getResolutionData(windowMode)
  local width = C_Screen.width
  local height = C_Screen.height
  if IS_EDITOR then
    local data = C_SettingUtility.GetResolutionData()
    width = data.horizontalPixel
    height = data.verticalPixel
  end
  windowMode = windowMode or self:getWindowMode()
  if windowMode ~= 3 then
    return _optionDataTpl:getDefaultResultionId(width, height)
  end
  local displayTpl = L_GameTpl:getOptionDataDisplayTpl()
  local configs = displayTpl:getConfig()
  local minimum = configs[#configs]
  local minWidth = displayTpl:getHorizontalPixels(minimum)
  local minHeight = displayTpl:getVerticalPixels(minimum)
  local sysRes = {
    C_ResolutionUtility.GetSystemResolution()
  }
  local resolutions = C_Screen.resolutions
  for i = #self.resolutions, 1, -1 do
    self.resolutions[i] = nil
  end
  local selected
  local count = 0
  for i = 1, resolutions.Length do
    local res = resolutions[resolutions.Length - i]
    local lastRes = self.resolutions[count]
    if i == 1 or minWidth <= res.width and minHeight <= res.height and filter(res, lastRes, sysRes) then
      count = count + 1
      table.insert(self.resolutions, count, {
        res.width,
        res.height
      })
      if width <= res.width and height <= res.height then
        selected = count
      end
    end
  end
  return selected or 1
end

function this:initKeyJson(playerId)
  playerId = playerId or L_PlayerStore:getPlayerId() or 0
  local key = string.format("settingkey_%s", playerId)
  local json = self:getPrefsString(key)
  C_InputManager.ReadJson(json)
end

function this:trySaveKeyJson()
  if not self:getKeyDirty() then
    return
  end
  self.data.keyDirty = false
  local id = L_PlayerStore:getPlayerId() or 0
  local key = string.format("settingkey_%s", id)
  local json = C_InputManager.SaveAsJson()
  self:setPrefsString(key, json)
end

function this:setMoveBlockControlConfig(joyStickRectPos, childControlPosList)
  for i, v in pairs(childControlPosList) do
    self:setPrefsString(self:getKeyWithPlayerId(string.format(self.saveKey.setting_pos, i)), string.concat(v.x, "_", v.y))
  end
  local str = string.concat(joyStickRectPos.x, "_", joyStickRectPos.y)
  self:setPrefsString(self:getKeyWithPlayerId(self.saveKey.setting_pos_joystickObj), str)
end

function this:setStartMoveBlockControlConfig(joyStickRectPos, childControlPosList)
  for i, v in ipairs(childControlPosList) do
    self:setPrefsString(self:getKeyWithPlayerId(string.format(self.saveKey.setting_startPos, i)), string.concat(v.x, "_", v.y))
  end
  self:setPrefsString(self:getKeyWithPlayerId(self.saveKey.setting_startPos_joystickObj), string.concat(joyStickRectPos.x, "_", joyStickRectPos.y))
end

function this:setSoftCamera()
  local camTactics = C_CameraManager.GetTactics(C_ECameraType.NewWorld)
  if camTactics then
    camTactics:RefreshSoftCamera()
  end
end

function this:setLoginSave(selectedServerId, selectedServerName)
  if selectedServerId then
    self:setPrefsInt(L_Const.prefsKey.serverId, selectedServerId)
  end
  if selectedServerName then
    self:setPrefsString(L_Const.prefsKey.serverName, selectedServerName)
  end
end

function this:removeAllOption()
  local curId = self:getLastPlayerId()
  local lastId = self:getPrefsString(L_Const.prefsKey.lastPlayerId)
  for i, v in pairs(self.data.cache) do
    local key = self:getSettingKey(curId, i)
    self:deleteKey(key)
    if lastId and curId ~= lastId then
      local key1 = self:getSettingKey(lastId, i)
      self:deleteKey(key1)
    end
  end
end

function this:setClearCache()
  self:removeAllOption()
  self:deleteKey(L_Const.prefsKey.firstSetTemp)
  self:deleteKey(L_Const.prefsKey.playerAccount)
  self:deleteKey(L_Const.prefsKey.serverId)
  self:deleteKey(L_Const.prefsKey.serverName)
  self:deleteKey(L_Const.prefsKey.curTraceTask)
  self:deleteKey(L_Const.prefsKey.lastPlayerId)
end

function this:setCurTraceTask(number)
  self:setPrefsInt(L_Const.prefsKey.curTraceTask, number)
end

function this:setPrefsString(str, val)
  C_PlayerPrefsUtility.SetString(str, val)
end

function this:setPrefsInt(str, int)
  C_PlayerPrefsUtility.SetInt(str, int)
end

function this:setPrefsBool(str, bool)
  C_PlayerPrefsUtility.SetBool(str, bool)
end

function this:deleteKey(key)
  C_PlayerPrefsUtility.DeleteKey(key)
end

function this:_deleteAll()
  C_PlayerPrefsUtility.DeleteAll()
end

function this:getIsExistsLangPack(value)
  return true
end

function this:getIsExistsLangPackByTag(tag)
  return C_PlayerPrefsUtility.GetBool(tag)
end

function this:getLangPackSize(value)
  return 0
end

function this:getLangPackSizeByTag(tag)
  return 0
end

function this:downLangPack(value)
end

function this:setCurrentPack(value)
end

function this:getCurrentLangPackDownSize()
  return 0
end

function this:getIsLangPackDownComplete()
  return true
end

function this:getCurrentLangPackSize()
  return 0
end

local languageText = ""

function this:setSelectLangText(lang)
  languageText = lang
end

function this:getSelectLangText()
  return languageText
end

function this:byteToGBText(size)
  if size == nil or size == 0 then
    return "0"
  end
  local gb = size / 1073741824
  if 0.01 <= gb then
    return string.format("%.2f GB", gb)
  else
    local kb = size / 1024
    return string.format("%.2f KB", kb)
  end
end

function this:deleteLangPack(lang)
  return true
end

function this:setbright(value)
  local res = tonumber(value)
  if res <= 50 then
    res = 0.012 * res + 0.4
  else
    res = 0.036 * res - 0.8
  end
  C_GlobalEffectMgr.SetBSCBright(res)
end

function this:setSaturation(value)
  local res = tonumber(value)
  if res <= 50 then
    res = 0.12 * res - 6
  else
    res = 0.08 * res - 4
  end
  C_GlobalEffectMgr.SetBSCSaturation(res)
end

function this:setContrast(value)
  local res = tonumber(value)
  res = 0.04 * res - 2
  C_GlobalEffectMgr.SetBSCContrast(res)
end

function this:recordChanged(settingType)
  self.changedRecord = self.changedRecord or {}
  self.changedRecord[settingType] = 1
end

local reportTrigger = {
  imgae = {
    L_Const.settingType.image,
    L_Const.settingType.windowMode,
    L_Const.settingType.resolution,
    L_Const.settingType.renderAccuracy,
    L_Const.settingType.vSync,
    L_Const.settingType.dlss,
    L_Const.settingType.dlssLevel,
    L_Const.settingType.RetileHlod
  }
}

function this:checkReportTrigger(t)
  for i, v in pairs(t) do
    if self.changedRecord[v] then
      return true
    end
  end
  return false
end

function this:reportSetting()
  local logList = {}
  if self.changedRecord[L_Const.settingType.softCamera] or self.changedRecord[L_Const.settingType.cameraSpeed] then
    local log = {
      sensitivity = tonumber(self:getSetData(L_Const.settingType.cameraSpeed)),
      soft = tonumber(self:getSetData(L_Const.settingType.softCamera))
    }
    logList[L_Const.logEventName.camera_setup] = log
  end
  if self:checkReportTrigger(reportTrigger.imgae) then
    local log = {
      image_quality = tonumber(self:getSetData(L_Const.settingType.image)),
      display_mode = tonumber(self:getSetData(L_Const.settingType.windowMode)),
      resolution = string.format("%sx%s", C_Screen.width, C_Screen.height),
      renderscale = tonumber(self:getSetData(L_Const.settingType.renderAccuracy)),
      v_sync = tostring(self:getSetData(L_Const.settingType.vSync)) == "2" and 1 or 0,
      dlss = tostring(self:getSetData(L_Const.settingType.dlss)) == "true" and 1 or 0,
      sup_resolution = tonumber(self:getSetData(L_Const.settingType.dlssLevel))
    }
    logList[L_Const.logEventName.image_setup] = log
  end
  for i, v in pairs(logList) do
    L_GameUtil.logEvent(i, v)
  end
  self.changedRecord = {}
end

function this:update()
end

function this:onResolutionChange()
  local equip = L_DeviceTpl:getEquipment()
  if equip == L_Const.equipment.mobile then
    return
  end
  local is2K = L_GameUtil.isUnder2K()
  local superResolution = L_SettingStore:getSetData(L_Const.settingType.superResolution)
  local isDlssOn = L_SettingStore:getSetData(L_Const.settingType.superResolution) ~= "1"
  if not is2K and isDlssOn then
    local level = L_SettingStore:getSetData(L_Const.settingType.dlssLevel)
    local levelStr = L_Const.dlssLevel[tostring(level)]
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.PIPELINE_RENDER_SCALE, levelStr)
    if superResolution == tostring(L_Const.superResolutionType.dlss) and C_SettingUtility.IsSupportDLSS() then
      self.adapter:adapt(L_Const.settingType.superResolution, 2)
    elseif superResolution == tostring(L_Const.superResolutionType.xess) and C_SettingUtility.IsSupportXeSS() then
      self.adapter:adapt(L_Const.settingType.superResolution, 4)
    else
      self.adapter:adapt(L_Const.settingType.superResolution, superResolution)
    end
  elseif is2K and isDlssOn then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.PIPELINE_RENDER_SCALE, "1")
  else
    local rs = L_SettingStore:getSetData(L_Const.settingType.renderAccuracy)
    self.adapter:adapt(L_Const.settingType.renderAccuracy, rs)
  end
  if isDlssOn then
    L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.renderAccuracy, L_Const.settingState.block)
  else
    L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.renderAccuracy, L_Const.settingState.none)
  end
  if L_GameUtil.isUnder2K() then
    L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.dlssLevel, L_Const.settingState.hide)
  elseif isDlssOn then
    L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.dlssLevel, L_Const.settingState.none)
  else
    L_SettingStore:call(L_SettingStore.event.showStateChange, L_Const.settingType.dlssLevel, L_Const.settingState.hide)
  end
end

function this:setHighestQuality()
  CS.Lens.Gameplay.Setting.GameSettingUtil.SetHighestQuality()
end

function this:revertQuality()
  CS.Lens.Gameplay.Setting.GameSettingUtil.RevertQuality()
end

function this:openSuperResolution(index)
  local equip = L_DeviceTpl:getEquipment()
  if equip == L_Const.equipment.mobile then
    return
  end
  if index == L_Const.superResolutionType.close then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.SUPER_SAMPLING, "None")
  elseif index == L_Const.superResolutionType.dlss then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.SUPER_SAMPLING, "DLSS")
  elseif index == L_Const.superResolutionType.fsr then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.SUPER_SAMPLING, "Fsr3")
  elseif index == L_Const.superResolutionType.xess then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.SUPER_SAMPLING, "XeSS")
  end
end

function this:setTempRenderScale(v)
  v = tostring(v)
  CS.Lens.Gameplay.Setting.GameSettingUtil.SetTempRenderScale(v)
end

function this:revertRenderScale()
  CS.Lens.Gameplay.Setting.GameSettingUtil.RevertRenderScale()
end

function this:setCaptureSetting()
  CS.Lens.Gameplay.Setting.GameSettingUtil.SetCaptureSetting()
end

function this:revertCaptureSetting()
  CS.Lens.Gameplay.Setting.GameSettingUtil.RevertCaptureSetting()
end

function this:openCDKTextBox()
  self.isInCDKCD = false
  local data = {
    txtTitle = L_WordsTpl:getValue("ui_cdkey_1"),
    placeHolder = L_WordsTpl:getValue("ui_cdkey_2"),
    tip = "",
    limit = 20,
    textBoxType = L_Const.CommonTextBoxType.Rename,
    keepPageOpen = true,
    notNewLine = true,
    clearText = true,
    confirmCallback = function(txt)
      if string.isEmpty(txt) then
        return
      end
      if self.isInCDKCD then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cdkey_3"))
        return
      end
      L_Net:sendMessage(MsgGenCode.CSProtoExchangeGiftCode, {code = txt}, function()
      end)
      self:beginCDKCd()
    end,
    cancelCallback = function()
      L_UI:close("pageCommonTextBox")
    end
  }
  L_GameUtil.showNormalTextBox(data)
end

function this:showCDKResult(code)
  local codeDisplay = {
    [0] = "ui_cdkey_result_1",
    [1] = "ui_cdkey_result_2",
    [2] = "ui_cdkey_result_4",
    [3] = "ui_cdkey_result_3",
    [4] = "ui_cdkey_result_5"
  }
  local txt = codeDisplay[code] or ""
  txt = L_WordsTpl:getValue(txt)
  L_GameUtil.showCommonTip({
    txtTitle = L_WordsTpl:getValue("ui_cdkey_1"),
    txtContent = txt,
    hideCancel = true
  })
end

function this:beginCDKCd()
  if self.isInCDKCD then
    return
  end
  self.isInCDKCD = true
  L_TimerManager:newOrResetTimer(self, "cdkCountDown", function()
    self.isInCDKCD = false
  end, 1)
end

return this
