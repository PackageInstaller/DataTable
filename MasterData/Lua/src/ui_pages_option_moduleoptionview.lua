local this = class("moduleOptionView", G_UIModuleBase)
local _keyCodeTpl = L_GameTpl:getKeyCodeTpl()
local _optionDataTpl = L_GameTpl:getOptionDataTpl()
local _optionDataTotalTpl = L_GameTpl:getOptionDataTotalTpl()
local _uiDecorationTpl = L_GameTpl:getUiDecorateTpl()
this.ignoreDefault = {
  L_Const.settingType.resolution,
  L_Const.settingType.windowMode,
  L_Const.settingType.dlss
}

function this.bind()
  return {
    detailedInfoTitle1 = "",
    detailedInfoTitle1_E = "",
    detailedInfoTitle2 = "",
    detailedInfoTitle2_E = "",
    detailedInfoTitle3 = "",
    detailedInfoTitle3_E = "",
    detailedInfoTitle4 = "",
    detailedInfoTitle4_E = "",
    detailedInfo1 = false,
    detailedInfoContent1 = false,
    detailedInfoContent2 = false,
    detailedInfoContent3 = false,
    space1 = false,
    space2 = false,
    space3 = false,
    detailedInfo2 = false,
    detailedInfo3 = false,
    detailedInfo4 = false,
    go_dropClickMask = false,
    detailedInfoList1 = {
      moduleName = "pages/option/cellSetItem"
    },
    detailedInfoList2 = {
      moduleName = "pages/option/cellSetItem"
    },
    detailedInfoList3 = {
      moduleName = "pages/option/cellSetItem"
    },
    detailedInfoList4 = {
      moduleName = "pages/option/cellSetItem"
    }
  }
end

local preferedPosition = {
  [L_Const.settingType.windowMode] = {
    prev = nil,
    next = L_Const.settingType.resolution
  }
}

function this.methods()
  return {
    detailedInfoList1 = {
      onChange = function(self, id, val, text, callback)
        self:changeSetting(id, val, text, callback)
        self.bind.go_dropClickMask = false
        L_SettingStore:recordChanged(id)
      end,
      onClick = function(self, id)
        self:emit("btnClick", id)
      end,
      changeKey = function(self, id)
        self:emit("escSet", id)
      end,
      changeDropdown = function(self, id, callback)
        self.dropMaskCallback = callback
        self.bind.go_dropClickMask = true
      end
    },
    detailedInfoList2 = {
      onChange = function(self, id, val)
        self:changeSetting(id, val)
        L_SettingStore:recordChanged(id)
      end,
      changeKey = function(self, id)
        self:emit("escSet", id)
      end
    },
    detailedInfoList3 = {
      onChange = function(self, id, val)
        self:changeSetting(id, val)
        L_SettingStore:recordChanged(id)
      end,
      changeKey = function(self, id)
        self:emit("escSet", id)
      end
    },
    detailedInfoList4 = {
      onChange = function(self, id, val)
        self:changeSetting(id, val)
        self.bind.go_dropClickMask = false
        L_SettingStore:recordChanged(id)
      end,
      changeKey = function(self, id)
        self:emit("escSet", id)
      end,
      changeDropdown = function(self, id, callback)
        self.dropMaskCallback = callback
        self.bind.go_dropClickMask = true
      end
    },
    onClick_changeDropdown = function(self)
      self:onClick_changeDropdown()
    end
  }
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.changeData = require("ui.pages.option.settingChangeData").new()
end

function this:refreshView(index, haveBtn)
  self.bindComponents.tableViewAnima:Stop()
  self.bindComponents.tableView:StopMovement()
  L_Vector3.setAnchored(self.bindComponents.viewContent, L_Vector3.getTemp())
  if haveBtn then
    print(self.bindComponents.viewport)
    self.bindComponents.viewport.offsetMin = L_Vector3.new(0, 130)
  else
    self.bindComponents.viewport.offsetMin = L_Vector3.new(0, 22)
  end
  self:refreshList(index)
  self.bindComponents.tableViewAnima:Play("anim_option_content_show")
end

function this:insertSettingData(settings, data)
  local postion = preferedPosition[data.id]
  if postion == nil then
    table.insert(settings, data)
    return
  end
  local len = #settings
  for i = 1, len do
    if settings[i].id == postion.prev then
      table.insert(settings, i + 1, data)
      return
    elseif settings[i].id == postion.next then
      table.insert(settings, i, data)
      return
    end
  end
  table.insert(settings, data)
end

function this:refreshList(titleIndex)
  self.titleIndex = titleIndex
  local tempTable1 = {}
  local tempTable2 = {}
  local tempTable3 = {}
  local tempTable4 = {}
  local ficationList = self:getViewList(titleIndex)
  for i, tpl in ipairs(ficationList) do
    local id = _optionDataTpl:getId(tpl)
    local skip = false
    if id == L_Const.settingType.userCenter and not L_LoginPlatformManager:haveUserCenter() then
      skip = true
    end
    if id == L_Const.settingType.customerService and not L_LoginPlatformManager:hasCustomer() then
      skip = true
    end
    if not skip then
      local data = self:refreshSetting(id, i)
      local titleType = _optionDataTpl:getOptionclassification2(tpl)
      local titleName = tpl.optionclassification2Name
      local decorationName = _uiDecorationTpl:getDecoEnglish(titleName)
      if titleType == L_Const.optionTitleType.first then
        self.bind.detailedInfoTitle1 = titleName
        self.bind.detailedInfoTitle1_E = decorationName
        self:insertSettingData(tempTable1, data)
      elseif titleType == L_Const.optionTitleType.second then
        self.bind.detailedInfoTitle2 = titleName
        self.bind.detailedInfoTitle2_E = decorationName
        self:insertSettingData(tempTable2, data)
      elseif titleType == L_Const.optionTitleType.third then
        self.bind.detailedInfoTitle3 = titleName
        self.bind.detailedInfoTitle3_E = decorationName
        self:insertSettingData(tempTable3, data)
      else
        self.bind.detailedInfoTitle4 = titleName
        self.bind.detailedInfoTitle4_E = decorationName
        self:insertSettingData(tempTable4, data)
      end
    end
  end
  
  local function optionSort(a, b)
    if a.order ~= b.order then
      return a.order < b.order
    else
      return a.id < b.id
    end
  end
  
  table.sort(tempTable1, optionSort)
  table.sort(tempTable2, optionSort)
  table.sort(tempTable3, optionSort)
  table.sort(tempTable4, optionSort)
  self.bind.detailedInfo1 = tempTable1[1] ~= nil
  self.bind.detailedInfoContent1 = tempTable1[1] ~= nil
  self.bind.space1 = tempTable1[1] ~= nil
  self.bind.detailedInfoList1:clear()
  self.bind.detailedInfoList1:insert_array(tempTable1)
  self.bind.detailedInfo2 = false
  self.bind.detailedInfoContent2 = tempTable2[2] ~= nil
  self.bind.space2 = tempTable2[1] ~= nil
  self.bind.detailedInfoList2:clear()
  Timer.once(0.1, function()
    if tempTable2[1] and self.titleIndex == titleIndex then
      self.bind.detailedInfoList2:insert_array(tempTable2)
      self.bind.detailedInfo2 = true
    end
  end, nil, self.gameObject)
  self.bind.detailedInfo3 = false
  self.bind.detailedInfoContent3 = tempTable3[2] ~= nil
  self.bind.space3 = tempTable3[1] ~= nil
  self.bind.detailedInfoList3:clear()
  local time = tempTable2[1] ~= nil and 0.2 or 0.1
  Timer.once(time, function()
    if tempTable3[1] and self.titleIndex == titleIndex then
      self.bind.detailedInfoList3:insert_array(tempTable3)
      self.bind.detailedInfo3 = true
    end
  end, nil, self.gameObject)
  self.bind.detailedInfo4 = false
  self.bind.detailedInfoList4:clear()
  time = (tempTable3[1] ~= nil and 0.1 or 0) + time
  Timer.once(time, function()
    if tempTable4[1] and self.titleIndex == titleIndex then
      self.bind.detailedInfoList4:insert_array(tempTable4)
      self.bind.detailedInfo4 = true
    end
    self:refreshDisplayState()
  end, nil, self.gameObject)
end

function this:refreshSetting(id, i)
  local tpl = _optionDataTpl:getTplById(id)
  local default = self.changeData:getNewOrDefault(id)
  local state, blockType = L_SettingStore.checkAdapter:checkState(id, self.changeData.map)
  local optionType = _optionDataTpl:getOptionType(tpl)
  if id == L_Const.settingType.language then
    default = L_Const.settingText:GetParamIdx(L_Const.settingType.language, C_Define.audio_language)
  end
  local data = {}
  if optionType == 8 then
    data = {
      id = id,
      default = default,
      optionType = 8,
      defaultCanvas = 50 - i,
      settingState = state,
      blockType = blockType,
      order = tpl.orderId
    }
  else
    data = {
      id = id,
      default = default,
      optionType = optionType,
      settingState = state,
      blockType = blockType,
      order = tpl.orderId
    }
  end
  return data
end

function this:getViewList(fication)
  if self.optionMap == nil then
    local equipType = L_DeviceTpl:getEquipment()
    self.optionMap = {
      all = _optionDataTpl:getActiveConfig(equipType)
    }
  end
  if self.optionMap[fication] == nil then
    self.optionMap[fication] = table.findAll(self.optionMap.all, function(v)
      return _optionDataTpl:getOptionclassification1(v) == fication
    end)
  end
  return self.optionMap[fication]
end

function this:defaultSet()
  local list = self:getViewList(self.titleIndex)
  for _, tpl in ipairs(list) do
    local id = _optionDataTpl:getId(tpl)
    if not table.containsValue(this.ignoreDefault, id) then
      local default = _optionDataTpl:getDefaultPara(tpl)
      if default ~= nil and default ~= "" then
        if id == L_Const.settingType.renderAccuracy then
          if L_SettingStore:getSetData(L_Const.settingType.superResolution) ~= "1" then
          else
            L_SettingStore:setSetting(id, default)
            self.changeData:removeOption(id)
          end
        else
          L_SettingStore:setSetting(id, default)
          self.changeData:removeOption(id)
        end
      end
    end
  end
  self:setDefaultImageQuality()
  self:refreshAllList()
end

function this:refreshAllList()
  self:refreshDetailedInfoList(self.bind.detailedInfoList1)
  if self.bind.detailedInfo2 then
    self:refreshDetailedInfoList(self.bind.detailedInfoList2)
  end
  if self.bind.detailedInfo3 then
    self:refreshDetailedInfoList(self.bind.detailedInfoList3)
  end
  if self.bind.detailedInfo4 then
    self:refreshDetailedInfoList(self.bind.detailedInfoList4)
  end
end

function this:setDefaultImageQuality()
  local imageLevel = L_SettingStore:getSetData(L_Const.settingType.image)
  local imageDatas = _optionDataTotalTpl.data
  imageLevel = tonumber(imageLevel)
  if imageLevel and 2 <= imageLevel and imageLevel <= 5 then
    for i, v in pairs(imageDatas) do
      local m = _optionDataTotalTpl:getVal(v, imageLevel)
      L_SettingStore:setSetting(i, m)
      self.changeData:removeOption(v)
    end
  end
end

function this:refreshDetailedInfoList(list)
  for i = 1, #list do
    local id = list:getValue(i, "id")
    if not table.containsValue(this.ignoreDefault, id) then
      local default = self.changeData:getNewOrDefault(id)
      list:change(i, {default = default, type7Mask = false})
    end
  end
end

function this:applyChangeData()
  self.changeData:apply()
end

local SETTING_SOUND = {
  [L_Const.settingType.bgm] = true,
  [L_Const.settingType.cv] = true,
  [L_Const.settingType.se] = true,
  [L_Const.settingType.mute] = true
}
local SETTING_RESOLUTION = {
  [L_Const.settingType.resolution] = true,
  [L_Const.settingType.windowMode] = true,
  [L_Const.settingType.dlss] = true
}

function this:changeSetting(id, value, text, callBack)
  if id == L_Const.settingType.language then
    self:changeSetting_language(id, value, text, callBack)
  else
    self.changeData:addOption(id, value)
  end
  if SETTING_SOUND[id] then
    self:changeSetting_sound(id, value)
  elseif SETTING_RESOLUTION[id] then
    self:changeSetting_resolution(id, value)
  elseif id == L_Const.settingType.image then
    self:changeSetting_image(id, value)
  elseif _optionDataTotalTpl:getTplById(id) then
    self:changeSetting_imageSibling(id, value)
  elseif L_Const.settingKey[id] then
    self:changeSetting_key(id, value)
  end
  self:checkPostponeTip(id)
  if id == L_Const.settingType.image and self:_needPostponeTipForImageChildren() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_option_changescenetip"))
  end
end

function this:changeSetting_language(id, value, text, callBack)
  local function callback(id, value, text)
    if callBack then
      callBack(text)
    end
    self.changeData:addOption(id, value)
    L_SettingStore:setCurrentPack(value)
  end
  
  if L_SettingStore:getIsExistsLangPack(value) then
    callback(id, value)
  else
    local capacity = L_SettingStore:byteToGBText(L_SettingStore:getLangPackSize(value))
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("ui_option_down_ensure_tips"),
      txtSubContent = L_WordsTpl:getValue("ui_option_down_lang_tips"):gsub("{language}", L_SettingStore.getSelectLangText()):gsub("{num}", capacity),
      confirmCallback = function()
        local option = {
          txtTitle = L_WordsTpl:getValue("notice_pageTipProcess"),
          immediateOk = function()
            callback(id, value)
          end,
          cancelCallback = function()
          end,
          optionID = id,
          languageIndex = value,
          success = callback
        }
        L_UI:open("pageTipProcess", option)
      end
    })
  end
end

function this:changeSetting_sound(id, value)
  local tpl = _optionDataTpl:getTplById(id)
  local viewType = _optionDataTpl:getOptionType(tpl)
  if viewType == L_Const.optionType.toggle then
    for i = 1, #self.bind.detailedInfoList1 do
      local cellId = self.bind.detailedInfoList1:getValue(i, "id")
      if cellId >= L_Const.settingType.bgm and cellId <= L_Const.settingType.cv then
        if self.bind.detailedInfoList1:getValue(i, "sliderText") == "0" then
          self.bind.detailedInfoList1:change(i, {closeIcon = true})
        else
          self.bind.detailedInfoList1:change(i, {closeIcon = value})
        end
      end
    end
  elseif viewType == L_Const.optionType.slider then
    self.changeData:addOption(L_Const.settingType.mute, false)
    for i = 1, #self.bind.detailedInfoList1 do
      local cellId = self.bind.detailedInfoList1:getValue(i, "id")
      if cellId == id then
        self.bind.detailedInfoList1:change(i, {default = value})
      end
      if cellId >= L_Const.settingType.bgm and cellId <= L_Const.settingType.cv then
        self.bind.detailedInfoList1:change(i, {
          default = L_SettingStore:getSetData(cellId)
        })
      end
      if L_Const.settingType.mute == cellId then
        self.bind.detailedInfoList1:change(i, {default = "false"})
      end
    end
  end
end

function this:changeSetting_image(id, value)
  if value == 1 then
    return
  end
  local touched = {}
  local imageDatas = _optionDataTotalTpl.data
  for i = 1, #self.bind.detailedInfoList1 do
    local cellId = self.bind.detailedInfoList1:getValue(i, "id")
    local tpl = imageDatas and imageDatas[cellId] or _optionDataTotalTpl:getTplById(cellId)
    if tpl then
      local data = _optionDataTotalTpl:getVal(tpl, value)
      if data then
        self.bind.detailedInfoList1:change(i, {
          default = tostring(data)
        })
        self.changeData:addOption(cellId, data)
        touched[cellId] = true
      end
    end
  end
  for i = 1, #self.bind.detailedInfoList2 do
    local cellId = self.bind.detailedInfoList2:getValue(i, "id")
    local tpl = imageDatas and imageDatas[cellId] or _optionDataTotalTpl:getTplById(cellId)
    if tpl then
      local data = _optionDataTotalTpl:getVal(tpl, value)
      if data then
        self.bind.detailedInfoList2:change(i, {
          default = tostring(data)
        })
        self.changeData:addOption(cellId, data)
        touched[cellId] = true
      end
    end
  end
  for i = 1, #self.bind.detailedInfoList4 do
    local cellId = self.bind.detailedInfoList4:getValue(i, "id")
    local tpl = imageDatas and imageDatas[cellId] or _optionDataTotalTpl:getTplById(cellId)
    if tpl then
      local data = _optionDataTotalTpl:getVal(tpl, value)
      if data then
        self.bind.detailedInfoList4:change(i, {
          default = tostring(data)
        })
        self.changeData:addOption(cellId, data)
        touched[cellId] = true
      end
    end
  end
  if imageDatas then
    for settingId, tpl in pairs(imageDatas) do
      if not touched[settingId] then
        local data = _optionDataTotalTpl:getVal(tpl, value)
        if data then
          self.changeData:addOption(settingId, data)
        end
      end
    end
  end
end

function this:changeSetting_imageSibling()
  local index = self:calImageLevel()
  for i = 1, #self.bind.detailedInfoList1 do
    local cellId = self.bind.detailedInfoList1:getValue(i, "id")
    if cellId == L_Const.settingType.image then
      self.bind.detailedInfoList1:change(i, {
        default = tostring(index)
      })
      break
    end
  end
  self.changeData:addOption(L_Const.settingType.image, index)
  if index ~= 1 then
    local imageDatas = _optionDataTotalTpl.data
    if imageDatas then
      for settingId, tpl in pairs(imageDatas) do
        if tpl.isActive == 0 then
          local data = _optionDataTotalTpl:getVal(tpl, index)
          if data ~= nil then
            self.changeData:addOption(settingId, data)
          end
        end
      end
    end
  end
  self:refreshAllList()
end

function this:calImageLevel()
  local imageDatas = _optionDataTotalTpl.data
  if self.imageMatch == nil then
    self.imageMatch = {}
    for j = 2, 5 do
      local t = {}
      for i, v in pairs(imageDatas) do
        if v.isActive ~= 0 then
          local m = _optionDataTotalTpl:getVal(v, j)
          t[i] = m
        end
      end
      self.imageMatch[j] = t
    end
  end
  local temp = {}
  for i, v in pairs(imageDatas) do
    if v.isActive ~= 0 then
      local id = i
      local val = self.changeData:getNewOrDefault(id)
      temp[id] = tonumber(val)
    end
  end
  local index = 1
  for j = 2, 5 do
    local isSame = false
    for i, v in pairs(self.imageMatch[j]) do
      if temp[i] ~= v then
        isSame = false
        break
      else
        isSame = true
      end
    end
    if isSame then
      index = j
      break
    end
  end
  return index
end

function this:changeSetting_imagebright(id, value)
  for i, v in ipairs(self.modules.detailedInfoList3) do
    local cell = v
    cell:refreshBright(value)
  end
end

function this:changeSetting_imageContrast(id, value)
  for i, v in ipairs(self.modules.detailedInfoList3) do
    local cell = v
    cell:refreshContrast(value)
  end
end

function this:changeSetting_imageSaturation(id, value)
  for i, v in ipairs(self.modules.detailedInfoList3) do
    local cell = v
    cell:refreshSaturation(value)
  end
end

function this:_needPostponeTipForImageChildren()
  local imageDatas = _optionDataTotalTpl.data
  if not imageDatas then
    return false
  end
  local target
  if L_DeviceTpl:getIsPc() then
    target = 1
  elseif L_DeviceTpl:getIsMobile() then
    target = 2
  else
    return false
  end
  
  local function containsPlatform(list, tgt)
    if not list then
      return false
    end
    for _, v in ipairs(list) do
      if tonumber(v) == tgt then
        return true
      end
    end
    return false
  end
  
  for settingId, _ in pairs(imageDatas) do
    local subTpl = _optionDataTpl:getTplById(settingId)
    if subTpl and subTpl.postpone and #subTpl.postpone > 0 and containsPlatform(subTpl.postpone, target) then
      return true
    end
  end
  return false
end

function this:checkPostponeTip(id)
  local tpl = _optionDataTpl:getTplById(id)
  if not tpl then
    return
  end
  local postpone = tpl.postpone
  if not postpone then
    return
  end
  
  local function containsPlatform(list, target)
    for _, v in ipairs(list) do
      if tonumber(v) == target then
        return true
      end
    end
    return false
  end
  
  local needTip = false
  if L_DeviceTpl:getIsPc() then
    needTip = containsPlatform(postpone, 1)
  elseif L_DeviceTpl:getIsMobile() then
    needTip = containsPlatform(postpone, 2)
  end
  if needTip then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_option_changescenetip"))
  end
end

function this:changeSetting_resolution(id, value)
  if id == L_Const.settingType.dlss then
    if tostring(value) == "true" then
      self.tmp_renderAccuracy = self.changeData:getNew(L_Const.settingType.renderAccuracy)
      self.changeData:removeOption(L_Const.settingType.renderAccuracy)
    elseif self.tmp_renderAccuracy then
      self.changeData:addOption(L_Const.settingType.renderAccuracy, self.tmp_renderAccuracy)
    end
    return
  end
  local resolutionId = L_SettingStore:getSetNumData(L_Const.settingType.resolution)
  local windowMode = L_SettingStore:getSetNumData(L_Const.settingType.windowMode)
  local result
  if windowMode ~= 3 then
    local displayTpl = L_GameTpl:getOptionDataDisplayTpl()
    local tpl = displayTpl:getTplById(resolutionId)
    local width = displayTpl:getHorizontalPixels(tpl)
    local height = displayTpl:getVerticalPixels(tpl)
    result = C_ResolutionUtility.SetAndRecordResolution(width, height, windowMode - 1)
  elseif windowMode == 3 then
    local width, height = C_ResolutionUtility.GetSystemResolution()
    local res = L_SettingStore.resolutions[resolutionId]
    if res then
      width = res[1]
      height = res[2]
    end
    result = C_ResolutionUtility.SetAndRecordResolution(width, height, windowMode - 1)
  end
  L_SettingStore.adapter:adapt(L_Const.settingType.resolution)
  if result then
    C_SettingUtility.SaveSettingData()
    L_WaterMarkManager:refreshMarkNode(not C_IntegrateMgr.SystemUnlockModule:getSystemIsBan(L_SystemConst.enum.waterMark))
  end
end

function this:changeSetting_key(id, val)
end

function this:startRebind(settingId, callback)
  local cfg = L_Const.settingKey[settingId]
  if cfg == nil then
    return
  end
  local actionName = cfg[1]
  local bindIndex = cfg[2]
  local action = C_InputManager.GetAction(actionName)
  local curPath
  if 0 <= bindIndex and bindIndex < action.controls.Count then
    curPath = action.controls[bindIndex].path
  end
  C_InputManager.StartRebind(action, bindIndex, function(newIndex, operation)
    if newIndex == -1 then
      action:RemoveBindingOverride(bindIndex)
      callback(false)
      return
    end
    local display = action:GetBindingDisplayString(newIndex)
    local prefix = "Mutex "
    if string.sub(display, 1, #prefix) == prefix then
      display = string.sub(display, #prefix + 1)
    end
    local keyTpl = _keyCodeTpl:getTplByKey(display)
    if keyTpl and _keyCodeTpl:getCanBeUsed(keyTpl) then
      local k2Id = self.changeData:getSameKey(settingId, display)
      if k2Id then
        action:RemoveBindingOverride(bindIndex)
        if curPath ~= nil and not string.isEmpty(curPath) then
          action:ApplyBindingOverride(bindIndex, curPath)
        end
        local tpl = _optionDataTpl:getTplById(k2Id)
        local allow = _optionDataTpl:getAllowChange(tpl)
        if allow then
          self:noticeExchangeTip(callback, settingId, k2Id)
        else
          self:noticeFailureTip(callback, settingId, k2Id)
        end
      else
        self:changeSetting(settingId, display)
        callback(newIndex ~= -1)
      end
    else
      action:RemoveBindingOverride(bindIndex)
      if curPath ~= nil and not string.isEmpty(curPath) then
        action:ApplyBindingOverride(bindIndex, curPath)
      end
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_setting_keycode_none"))
      callback(false)
    end
  end)
end

function this:noticeExchangeTip(callback, k1Id, k2Id)
  local str = L_WordsTpl:getValue("notice_repeated_keys")
  local data = {
    txtContent = str,
    confirmCallback = function()
      self:exchangeKey(k1Id, k2Id)
      callback(true)
    end,
    pageClosedCallback = function()
      callback(false)
    end
  }
  L_GameUtil.showCommonTip(data)
end

function this:noticeFailureTip(callback, k1Id, k2Id)
  local str = L_WordsTpl:getValue("notice_unallowed_repetition")
  L_FlyMsgManager:showNormalMsg(str)
  callback(false)
end

function this:exchangeKey(k1Id, k2Id)
  local cfg1 = L_Const.settingKey[k1Id]
  local cfg2 = L_Const.settingKey[k2Id]
  local action1 = C_InputManager.GetAction(cfg1[1])
  local action2 = C_InputManager.GetAction(cfg2[1])
  C_InputManager.ExchangeKey(action1, action2, cfg1[2], cfg2[2])
  local v1 = self.changeData:getNewOrDefault(k1Id)
  local v2 = self.changeData:getNewOrDefault(k2Id)
  self:changeSetting(k1Id, v2)
  self:changeSetting(k2Id, v1)
end

function this:forceRebuildLayout()
end

function this:refreshDisplayState()
  local show4 = false
  for i, v in pairs(self.modules.detailedInfoList4) do
    if v.gameObject and v.gameObject.activeSelf then
      show4 = true
      break
    end
  end
  self.bind.detailedInfo4 = show4
end

function this:onClick_changeDropdown()
  if not self.bind.go_dropClickMask then
    return
  end
  self.bind.go_dropClickMask = false
  if self.dropMaskCallback then
    self.dropMaskCallback()
  end
end

return this
