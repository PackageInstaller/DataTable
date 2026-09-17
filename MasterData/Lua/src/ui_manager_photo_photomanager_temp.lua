local this = {}
this.IDTOFIELD = {
  [L_Const.photoParam.postExposure] = "postExposure",
  [L_Const.photoParam.brightness] = "brightness",
  [L_Const.photoParam.hightlights] = "hightlights",
  [L_Const.photoParam.shadows] = "shadows",
  [L_Const.photoParam.contrast] = "contrast",
  [L_Const.photoParam.saturation] = "saturation",
  [L_Const.photoParam.temperature] = "temperature",
  [L_Const.photoParam.whitebalancetint] = "whitebalancetint"
}
this.FILTERTOID = {
  [L_Const.photoParam.filter0] = 0,
  [L_Const.photoParam.filter1] = 1,
  [L_Const.photoParam.filter2] = 2,
  [L_Const.photoParam.filter3] = 3,
  [L_Const.photoParam.filter4] = 4,
  [L_Const.photoParam.filter5] = 5,
  [L_Const.photoParam.filter6] = 6
}
this.applySettingParamDict = {
  [L_Const.photoTemplateSettingParam.player] = {
    L_Const.photoTemplateSettingParam.camera,
    L_Const.photoTemplateSettingParam.parm,
    L_Const.photoTemplateSettingParam.action
  },
  [L_Const.photoTemplateSettingParam.setting] = true,
  [L_Const.photoTemplateSettingParam.time] = true,
  [L_Const.photoTemplateSettingParam.wind] = true,
  [L_Const.photoTemplateSettingParam.filter] = true,
  [L_Const.photoTemplateSettingParam.color] = true,
  [L_Const.photoTemplateSettingParam.parm] = true,
  [L_Const.photoTemplateSettingParam.lightSetting] = true,
  [L_Const.photoTemplateSettingParam.lightParam] = true
}

function this:initTemplateData()
  self.settingFields = {
    [L_Const.photoTemplateSettingParam.player] = {"val", "v3Val"},
    [L_Const.photoTemplateSettingParam.time] = {"val"},
    [L_Const.photoTemplateSettingParam.wind] = {"val", "v3Val"},
    [L_Const.photoTemplateSettingParam.camera] = {"extStrTb"},
    [L_Const.photoTemplateSettingParam.filter] = {
      "val",
      "sliderValue"
    },
    [L_Const.photoTemplateSettingParam.action] = {
      "val",
      "sliderValue"
    },
    [L_Const.photoTemplateSettingParam.color] = {"extStrTb"},
    [L_Const.photoTemplateSettingParam.parm] = {"extStrTb"},
    [L_Const.photoTemplateSettingParam.setting] = {"extStrTb"},
    [L_Const.photoTemplateSettingParam.lightSetting] = {"extStrTb"},
    [L_Const.photoTemplateSettingParam.lightParam] = {"extStrTb"}
  }
end

function this:getCfgIdByFilterId(id)
  for cfgId, filterId in pairs(this.FILTERTOID) do
    if id == filterId then
      return cfgId
    end
  end
end

function this:createArgsByResStr(str)
  local args = {}
  if not string.isEmpty(str) then
    local list = string.split(str, "_")
    local paramStr = list[1]
    if string.isEmpty(paramStr) then
      return nil
    end
    args.paramStr = paramStr
    local filedNameList = self.settingFields[paramStr]
    for index, nameStr in ipairs(filedNameList) do
      local res = self:str2Result(list[index + 1])
      args[nameStr] = res
      if res == nil then
        errorf("cant find filedName:" .. nameStr)
        return nil
      end
    end
  end
  return args
end

function this:getTemplateDataStr(data)
  return data and data:toString()
end

function this:applyTemplateDataById(type, id)
  local data = L_PhotoStore:getTemplateData(type, id)
  if data then
    self:applyTemplateData(data)
  end
end

function this:applyTemplateData(data, isReset, endCallback)
  if not isReset and not self:applyTemplatePreCheck(data) then
    return
  end
  
  local function applyParamFunc(paramStr, endCb)
    local str = not data.settingParamDict[paramStr] and self.curWorldTemplateData and self.curWorldTemplateData.settingParamDict[paramStr]
    if str then
      printf("applyTemplateData", str)
      local args = self:createArgsByResStr(str)
      self:invokeApplyTemplateFunc(paramStr, args, isReset, endCb)
    elseif endCb then
      endCb()
    end
  end
  
  local function finishApply()
    if endCallback then
      endCallback()
    end
    if not isReset then
      L_PhotoManager:sendEvent(L_PhotoManager.event.photoSettingChange)
      L_PhotoManager:sendEvent(L_PhotoManager.event.photoTemplateChangeo)
    end
  end
  
  if isReset then
    for paramStr, _ in pairs(L_PhotoManager.applySettingParamDict) do
      applyParamFunc(paramStr)
    end
    finishApply()
    return
  end
  local playerParamStr = L_Const.photoTemplateSettingParam.player
  local parmParamStr = L_Const.photoTemplateSettingParam.parm
  for paramStr, value in pairs(L_PhotoManager.applySettingParamDict) do
    if type(value) ~= "table" and paramStr ~= parmParamStr then
      applyParamFunc(paramStr)
    end
  end
  local afterPlayerParamList = L_PhotoManager.applySettingParamDict[playerParamStr]
  applyParamFunc(playerParamStr, function()
    for index = 1, #afterPlayerParamList do
      applyParamFunc(afterPlayerParamList[index])
    end
    finishApply()
  end)
end

function this:applyPartOfTemplate(data)
  if not self:applyTemplatePreCheck(data) then
    return
  end
  
  local function applyParamFunc(paramStr, endCb)
    local str = data.settingParamDict[paramStr]
    if str then
      local args = self:createArgsByResStr(str)
      self:invokeApplyTemplateFunc(paramStr, args, nil, endCb)
    end
  end
  
  for paramStr, value in pairs(L_PhotoManager.applySettingParamDict) do
    applyParamFunc(paramStr)
  end
end

function this:applyTemplatePreCheck(data)
  if data == nil then
    return false
  end
  if AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_notemplate"))
    return false
  end
  local str = data.settingParamDict[L_Const.photoTemplateSettingParam.player]
  local args = self:createArgsByResStr(str)
  if args and args.val then
    local configId = math.ceil(args.val)
    if not L_HeroStore:getHasHero(configId) then
      printf("applyTemplatePreCheck", configId)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_templates_error01"))
      return false
    end
  end
  return true
end

function this:parseParamArgs(paramStr, args)
  args.paramStr = paramStr
  local filedNameList = self.settingFields[args.paramStr]
  local tb = {}
  table.insert(tb, paramStr)
  for _, nameStr in ipairs(filedNameList) do
    local str = self:result2str(nameStr, args)
    table.insert(tb, str)
  end
  return table.concat(tb, "_")
end

function this:addFieldOutLine(str)
  return string.format("{%s}", str)
end

function this:result2str(fieldName, args)
  if fieldName == "val" then
    local val = string.format("%.3f", args.val or 0)
    return self:addFieldOutLine(string.format("%s|%s", fieldName, val))
  elseif fieldName == "sliderValue" then
    local val = string.format("%.3f", args.sliderValue)
    return self:addFieldOutLine(string.format("%s|%s", fieldName, val))
  elseif fieldName == "v3Val" then
    return self:addFieldOutLine(string.format("%s|%s|%s|%s", fieldName, math.ceil(args.v3Val.x), math.ceil(args.v3Val.y), math.ceil(args.v3Val.z)))
  elseif fieldName == "extStrTb" then
    return self:addFieldOutLine(string.format("%s|%s", fieldName, table.concat(args.extStrTb, "|")))
  else
    return ""
  end
end

function this:str2Result(str)
  if string.isEmpty(str) then
    return
  end
  local s = string.sub(str, 2, #str - 1)
  local list = string.split(s, "|")
  local name = list[1]
  if name == "val" or name == "sliderValue" then
    return tonumber(list[2])
  elseif name == "v3Val" then
    local x, y, z = tonumber(list[2]), tonumber(list[3]), tonumber(list[4])
    if x == nil or y == nil or z == nil then
      errorf("str2Result v3Val parse fail: " .. tostring(str))
      return nil
    end
    return C_Vector3(x, y, z)
  elseif name == "extStrTb" then
    table.remove(list, 1)
    return list
  else
    return list[2]
  end
end

function this:invokeApplyTemplateFunc(paramStr, args, isReset, endCb)
  if args == nil then
    errorf(string.format("invokeApplyTemplateFunc args is nil, paramStr: %s", tostring(paramStr)))
    return
  end
  local funcName = string.format("applyTemplate_%s", paramStr)
  if self[funcName] then
    self[funcName](self, args, isReset, endCb)
  else
    errorf(string.format("cant find applyTemplate func: %s", paramStr))
  end
end

function this:getWorldTemplateArgs(paramStr)
  local funcName = string.format("getWorldTemplateArgs_%s", paramStr)
  if self[funcName] then
    return self[funcName](self, paramStr)
  else
  end
end

function this:applyTemplate_time(args, isReset)
  if isReset then
  else
    C_GameTime.SetVirTimeWithHour(args.val)
  end
end

function this:getWorldTemplateArgs_time(paramStr)
  local args = {}
  args.paramStr = paramStr
  args.val = C_GameTime.GetVirMinute() / 60
  return args
end

function this:applyTemplate_wind(args, isReset)
  local wind = C_RealWeather.GetWeatherWind()
  if wind then
    args.v3Val.x = 0
    args.v3Val.z = 0
    wind:SetDirection(args.v3Val)
    C_RealWeather.SetPower(args.val)
  end
end

function this:getWorldTemplateArgs_wind(paramStr)
  local args = {}
  args.paramStr = paramStr
  local wind = C_RealWeather.GetWeatherWind()
  if wind then
    args.val = wind:GetPower()
    args.v3Val = wind:GetDirection()
    args.v3Val.x = 0
    args.v3Val.z = 0
    return args
  else
    args.val = 0
    args.v3Val = C_Vector3.zero
    return
  end
end

function this:applyTemplate_camera(args, isReset)
  if isReset then
    return
  end
  local controller = C_CameraManager.GetTactics(C_ECameraType.Photo)
  if controller then
    local argsList = args.extStrTb
    local cameraDis = tonumber(argsList[1]) or 3.5
    local horizontalVal, verticalVal = tonumber(argsList[2]) or 0, tonumber(argsList[3]) or 0
    local screenX, screenY = tonumber(argsList[4]) or 0.5, tonumber(argsList[5]) or 0.5
    controller:SetCameraDis(cameraDis)
    controller:SetCameraRotateX(horizontalVal, true)
    controller:SetCameraRotateY(verticalVal, true)
    controller:SetCameraScreen(screenX, screenY)
  end
end

function this:getWorldTemplateArgs_camera(paramStr)
  local args = {}
  args.paramStr = paramStr
  local controller = C_CameraManager.GetTactics(C_ECameraType.Photo)
  local cameraDis = 3.5
  local horizontalVal, verticalVal = 0, 0
  local screenX, screenY = 0.5, 0.5
  if controller then
    cameraDis = controller:GetCameraDis()
    local virCam = C_CameraManager.GetTactics(C_ECameraType.Photo).cineMachineCamera
    local anim = virCam:GetCinemachineComponent(1)
    horizontalVal, verticalVal = anim.m_HorizontalAxis.Value, anim.m_VerticalAxis.Value
    local transposer = controller.transposer or {}
    screenX, screenY = transposer.m_ScreenX or 0.5, transposer.m_ScreenY or 0.5
  end
  args.extStrTb = {
    cameraDis,
    horizontalVal,
    verticalVal,
    screenX,
    screenY
  }
  return args
end

function this:applyTemplate_filter(args, isReset)
  if isReset then
    return
  end
  local filter = L_PhotoManager:getMediator().photoFilter
  if filter then
    filter.filterIntensity = 0
    filter.filterId = this.FILTERTOID[args.val]
    filter.filterIntensity = args.sliderValue
  end
end

function this:getWorldTemplateArgs_filter(paramStr)
  local args = {}
  args.paramStr = paramStr
  local filter = L_PhotoManager:getMediator().photoFilter
  if filter then
    args.val = self:getCfgIdByFilterId(filter.filterId)
    args.sliderValue = filter.filterIntensity
  else
    args.val = L_Const.photoParam.filter0
    args.sliderValue = 0
  end
  return args
end

function this:applyTemplate_action(args, isReset)
  if isReset then
    local entity = L_PhotoManager:getMediator().target
    if not entity then
      return
    end
    C_MediaPackUtility.ChangeEffectSpeed(entity, 1, true)
    return
  end
  local entity = L_PhotoManager:getMediator().target
  if not entity then
    return
  end
  local actionId = args.val
  local paramTpl = L_GameTpl:getPhotographParamTpl()
  local tpl = paramTpl:getTplById(actionId)
  local animName = paramTpl:getParam(tpl)
  local setPause = actionId ~= L_Const.photoParam.idle
  local state = self:getStateMachine(entity.entity.data.entityId)
  if state then
    if actionId == L_Const.photoParam.idle then
      state:reset()
    else
      state:doSingleAction(animName, true, function()
      end, true, args.sliderValue, setPause, nil, nil, function()
        if not entity then
          return
        end
        local animator = entity.entity.data.animator
        if animator and setPause then
          local animLen = animator:GetAnimatorStateLength(animName)
          local state = animator:GetState(animName)
          local dt = (args.sliderValue - math.min(state.normalizedTime, 1)) * animLen
          C_MediaPackUtility.AnimatorTimelineEvaluate(entity, dt)
        end
      end)
    end
  end
end

function this:getWorldTemplateArgs_action(paramStr)
  local args = {}
  args.paramStr = paramStr
  args.val = L_PhotoManager:getMediator().playActionId or L_Const.photoParam.idle
  local entity = L_PhotoManager:getMediator().target
  if not entity then
    return
  end
  local paramTpl = L_GameTpl:getPhotographParamTpl()
  local tpl = paramTpl:getTplById(args.val)
  local animName = paramTpl:getParam(tpl)
  local animator = entity.entity.data.animator
  local state = animator:GetState(animName)
  if not state then
    errorf(animName)
    return args
  end
  args.sliderValue = state.normalizedTime
  return args
end

function this:applyTemplate_color(args, isReset)
  if isReset then
    return
  end
  local filter = L_PhotoManager:getMediator().photoFilter
  if filter then
    local dict = {}
    for i = 1, #args.extStrTb, 2 do
      local settingId = tonumber(args.extStrTb[i])
      local val = tonumber(args.extStrTb[i + 1])
      dict[settingId] = val
    end
    for key, colorSetName in pairs(L_PhotoManager.IDTOFIELD) do
      filter[colorSetName] = dict[key] or 0
    end
  end
end

function this:getWorldTemplateArgs_color(paramStr)
  local args = {}
  args.paramStr = paramStr
  local list = {}
  local filter = L_PhotoManager:getMediator().photoFilter
  if filter then
    for settingId, colorSetName in pairs(L_PhotoManager.IDTOFIELD) do
      table.insert(list, settingId)
      table.insert(list, math.clamp(filter[colorSetName], -1, 1))
    end
  end
  args.extStrTb = list
  return args
end

function this:applyTemplate_parm(args, isReset)
  if isReset then
    return
  end
  local filter = L_PhotoManager:getMediator().photoFilter
  if filter then
    for i = 1, #args.extStrTb, 2 do
      local settingId = tonumber(args.extStrTb[i])
      local val = tonumber(args.extStrTb[i + 1])
      if settingId and val then
        L_PhotoManager:getMediator():setPhotoParmVal(settingId, val)
      end
    end
  end
end

function this:getWorldTemplateArgs_parm(paramStr)
  local filter = L_PhotoManager:getMediator().photoFilter
  if filter then
    local args = {}
    args.paramStr = paramStr
    args.extStrTb = L_PhotoManager:getMediator():getPhotoParmList()
    return args
  end
end

function this:applyTemplate_player(args, isReset, endCallback)
  if isReset then
    return
  end
  if self.moduleGroupHero ~= nil then
    self.moduleGroupHero:clearPutHeroes()
  end
  local main = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  local id = math.ceil(args.val)
  local configId = main.data.configId
  if configId ~= id then
    local guid = L_HeroStore:getGuidByConfigId(args.val)
    self:invokeCreateHeroFunc(guid, function(heroEntity)
      Timer.once(0.03, function()
        if not L_PhotoManager:getMediator() then
          return
        end
        if heroEntity.entity then
          heroEntity.entity:SetAngles(args.v3Val)
        end
        if endCallback then
          endCallback()
        end
      end)
    end)
  else
    main:SetAngles(args.v3Val)
    if endCallback then
      endCallback()
    end
  end
end

function this:registerCreateHeroFunc(cb)
  L_PhotoManager.cacheTempHeroId = nil
  self._createHeroFunc = cb
end

function this:invokeCreateHeroFunc(heroId, cb)
  L_PhotoManager.cacheTempHeroId = heroId
  if self._createHeroFunc then
    self._createHeroFunc(heroId, cb)
  end
end

function this:getWorldTemplateArgs_player(paramStr)
  local args = {}
  args.paramStr = paramStr
  args.v3Val = L_PlayerManager:getMainControlEntityRot()
  if AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
    return nil
  end
  local entity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  local heroConfigId = entity.data.configId
  args.val = heroConfigId
  return args
end

function this:applyTemplate_ik(args, isReset)
  local entity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  local characterControlProperty = entity.data.characterControlProperty
  if isReset then
    characterControlProperty:DisableIK(entity)
    return
  end
  local targetPos = args.v3Val
  if targetPos.x == 0 and targetPos.y == 0 and targetPos.z == 0 then
    return
  end
  local pointTrs = characterControlProperty:GetForwardIKPoint(entity)
  L_Vector3.setLocalPos(pointTrs, args.v3Val)
  characterControlProperty:EnableIK(entity, pointTrs)
end

function this:getWorldTemplateArgs_ik(paramStr)
  local args = {}
  args.paramStr = paramStr
  local entity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  local characterControlProperty = entity.data.characterControlProperty
  local pointTrs = characterControlProperty:GetForwardIKPoint(entity)
  if pointTrs then
    args.v3Val = pointTrs.localPosition
  else
    args.v3Val = L_Vector3.new(0, 0, 0)
  end
  return args
end

function this:applyTemplate_setting(args, isReset)
  local mediator = L_PhotoManager:getMediator()
  if mediator then
    for i = 1, #args.extStrTb, 2 do
      local settingId = tonumber(args.extStrTb[i])
      local val = args.extStrTb[i + 1]
      if settingId and val then
        local isOn = val == "1"
        mediator:setSetting(settingId, isOn)
      end
    end
    L_PhotoManager:sendEvent(L_PhotoManager.event.photoSettingChange)
  end
end

function this:getWorldTemplateArgs_setting(paramStr)
  local mediator = L_PhotoManager:getMediator()
  if mediator then
    local args = {}
    args.paramStr = paramStr
    local list = {}
    for key, _ in pairs(L_PhotoManager.util.translateSetting or table.empty) do
      local isOn = mediator:getSettingOrDefault(key)
      table.insert(list, key)
      table.insert(list, isOn and 1 or 0)
    end
    args.extStrTb = list
    return args
  end
end

function this:getWorldTemplateArgs_lightSetting(paramStr)
  local mediator = L_PhotoManager:getMediator()
  if not mediator.globalLightData then
    mediator.globalLightData = require("ui.pages.photo.submodule.globalLightData").new()
  end
  if mediator and mediator.globalLightData then
    local args = {}
    args.paramStr = paramStr
    local list = {}
    local color = mediator.globalLightData.color
    table.insert(list, color.r)
    table.insert(list, color.g)
    table.insert(list, color.b)
    table.insert(list, mediator.globalLightData.intensity)
    args.extStrTb = list
    return args
  end
end

function this:applyTemplate_lightSetting(args, isReset)
  local mediator = L_PhotoManager:getMediator()
  if isReset then
  end
  if mediator and #args.extStrTb == 4 then
    local r = tonumber(args.extStrTb[1]) or 1
    local g = tonumber(args.extStrTb[2]) or 1
    local b = tonumber(args.extStrTb[3]) or 1
    local intensity = tonumber(args.extStrTb[4]) or 0
    local color = C_Color(r, g, b, 1)
    if not mediator.globalLightData then
      mediator.globalLightData = require("ui.pages.photo.submodule.globalLightData").new()
    end
    mediator.globalLightData:setColor(color)
    mediator.globalLightData:setIntensity(intensity)
    mediator:setLightSetting(mediator.globalLightData)
  end
end

function this:getWorldTemplateArgs_lightParam(paramStr)
  local mediator = L_PhotoManager:getMediator()
  if mediator then
    local lightParam = mediator:getLightParam()
    local args = {}
    args.paramStr = paramStr
    local list = {}
    for i, v in pairs(lightParam.params) do
      table.insert(list, string.format("%s-%s", i, v))
    end
    args.extStrTb = list
    return args
  end
end

function this:applyTemplate_lightParam(args, isReset)
  local mediator = L_PhotoManager:getMediator()
  if mediator then
    if isReset then
    end
    for i, v in pairs(args.extStrTb) do
      local sp = string.split(v, "-")
      if #sp == 2 then
        local type = tonumber(sp[1])
        local val = tonumber(sp[2])
        mediator:setLightParam(type, val, true)
      end
    end
    if mediator.lightParam then
      mediator.lightParam:applyParam()
    end
  end
end

function this:setSettingParam(paramStr, data, args)
  data.settingParamDict[paramStr] = self:parseParamArgs(paramStr, args)
end

function this:updateDataByFullStr(data, fullStr)
  local list = string.split(fullStr, "$")
  for _, value in ipairs(list) do
    local params = string.split(value, "_")
    local paramStr = params[1]
    if paramStr then
      data.settingParamDict[paramStr] = value
    end
  end
end

function this:createPhotoWorldData(type, id, url, name)
  local data = L_PhotoStore:createPhotoTemplateData(type, id)
  data.url = url or ""
  if not string.isEmpty(name) then
    data.name = name
  end
  for _, paramStr in pairs(L_Const.photoTemplateSettingParam) do
    local args = self:getWorldTemplateArgs(paramStr)
    if args then
      self:setSettingParam(paramStr, data, args)
    end
  end
  return data
end

function this:createPhotoSceneData(type, id, url, name)
  local data = L_PhotoStore:createPhotoTemplateData(type, id)
  data.url = url or ""
  if not string.isEmpty(name) then
    data.name = name
  end
  for _, paramStr in pairs(L_Const.photoSwitchSceneSettingParam) do
    local args = self:getWorldTemplateArgs(paramStr)
    if args then
      self:setSettingParam(paramStr, data, args)
    end
  end
  return data
end

function this:createCurWorldData()
  self.curWorldTemplateData = self:createPhotoWorldData(L_Const.photoTemplateDataType.runtime, 0)
  return self.curWorldTemplateData
end

function this:createOriWorldData()
  self.oriWorldTemplateData = self:createPhotoWorldData(L_Const.photoTemplateDataType.runtime, -1)
  return self.oriWorldTemplateData
end

function this:resetWorldState()
  self.templateType = nil
  if self.oriWorldTemplateData then
    self:applyTemplateData(self.oriWorldTemplateData, true)
  end
  self.oriWorldTemplateData = nil
  self.curWorldTemplateData = nil
  self.chooseTempData = nil
  self._createHeroFunc = nil
end

function this:setTempChooseData(type, id, endCallback)
  if AzurWorld.photoMgr.isSwitching then
    return
  end
  if (not type or not id) and self.curWorldTemplateData then
    self:applyTemplateData(self.curWorldTemplateData, nil, endCallback)
    self.chooseTempData = nil
    self.curWorldTemplateData = nil
  else
    if self.curWorldTemplateData == nil then
      self.curWorldTemplateData = self:createCurWorldData()
    end
    local data = L_PhotoStore:getTemplateData(type, id)
    self.chooseTempData = data
    self:applyTemplateData(self.chooseTempData, nil, endCallback)
  end
  self.templateType = type
end

function this:getArgsByCurUseData(paramStr)
  local data = self.chooseTempData or self.curWorldTemplateData
  local str = data and data.settingParamDict[paramStr]
  if str then
    return self:createArgsByResStr(str)
  end
end

function this:screenTemplateShot(id, autoSave, notSend, callback)
  local function cb(rt)
    local tex = rt:ToTexture2D()
    
    local typeName = "cellBg"
    local playerId = L_PlayerStore:getPlayerId()
    local name = string.format("%s_%s_%s", id, typeName, playerId)
    local uploadKey = {
      L_PhotoStore.path.tempBgCDNPath,
      name
    }
    
    local function _onSuccess(key)
      key = string.split(key, "/")[3]
      if callback then
        callback(true, key, tex, name)
      end
    end
    
    local function _onFail(message)
      if callback then
        callback(false, message)
      end
    end
    
    if autoSave then
      local path = L_PhotoStore.path.tempBgSavePath .. typeName
      local imgFilePath = path .. "/" .. name
      imgFilePath = imgFilePath .. ".png"
      C_PhotoManager.SaveTexture2DByPath(imgFilePath, tex)
    end
    if not notSend then
      local texData = Unity.ImageConversion.EncodeToPNG(tex)
      uploadKey = table.concat(uploadKey)
      C_CDNManager.TransferUploadBytes(texData, uploadKey, _onSuccess, _onFail)
    else
      _onSuccess()
    end
    L_PhotoManager:releaseCaptureRT(rt)
  end
  
  local width = 320
  local height = math.ceil(C_Screen.height / C_Screen.width * width)
  self:capture(function(rt)
    Timer.once(0.05, function()
      cb(rt)
    end)
  end, width, height)
end

function this:uploadTemplateImg(id, autoSave, notSend, callback, oritex)
  local width = 320
  local height = math.ceil(C_Screen.height / C_Screen.width * width)
  local tex = oritex:ReScale(width, height)
  if L_CommonUtil.isValid(oritex) then
    oritex:ReleaseTexture()
  end
  local typeName = "cellBg"
  local playerId = L_PlayerStore:getPlayerId()
  local name = string.format("%s_%s_%s", id, typeName, playerId)
  local uploadKey = {
    L_PhotoStore.path.tempBgCDNPath,
    name
  }
  
  local function _onSuccess(key)
    if L_CommonUtil.isValid(tex) then
      tex:ReleaseTexture()
    end
    key = string.split(key, "/")[3]
    if callback then
      callback(true, key, name)
    end
  end
  
  local function _onFail(message)
    if L_CommonUtil.isValid(tex) then
      tex:ReleaseTexture()
    end
    if callback then
      callback(false, message)
    end
  end
  
  if autoSave then
    local path = L_PhotoStore.path.tempBgSavePath .. typeName
    local imgFilePath = path .. "/" .. name
    imgFilePath = imgFilePath .. ".png"
    C_PhotoManager.SaveTexture2DByPath(imgFilePath, tex)
  end
  if not notSend then
    local texData = Unity.ImageConversion.EncodeToPNG(tex)
    uploadKey = table.concat(uploadKey)
    C_CDNManager.TransferUploadBytes(texData, uploadKey, _onSuccess, _onFail)
  else
    _onSuccess()
  end
end

return this
