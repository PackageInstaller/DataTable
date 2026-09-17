local this = class("cellSetItem", G_UIModuleBase)
local _keyCodeTpl = L_GameTpl:getKeyCodeTpl()
local _optionDataTpl = L_GameTpl:getOptionDataTpl()
local _gameTpl = L_GameTpl:getGameConstTpl()
local COUNT_LIMIT = 5

function this.bind()
  return {
    name = "",
    type1 = false,
    type1Text = "",
    type2 = false,
    sliderText = "0",
    sliderValue = nil,
    sliderMin = nil,
    sliderMax = nil,
    closeIcon = false,
    text = true,
    additionFill = false,
    additionBackground = false,
    type3 = false,
    type3Btn1 = false,
    type3Btn2 = false,
    off = false,
    on = false,
    type4 = false,
    type5 = false,
    btnName = "",
    type6 = false,
    type7 = false,
    type7Name = L_WordsTpl:getValue("ui_cellSetItem"),
    type7Icon = false,
    type7Sprite = "",
    type7Text = true,
    type7Mask = false,
    type8 = false,
    type8Text = "",
    type8TextCanvas = 51,
    dropdownCanvas = 50,
    noneCanvas = 50,
    grid_dropCanvas = 30000,
    dropdownToggle = false,
    dropdown = false,
    type9 = false,
    type10 = false,
    type10FillAmountH = 0,
    type10FillAmountM = 0,
    type10FillAmountL = 0,
    type10FillText = "",
    type10Text = "",
    type10FillHight = false,
    type10FillMiddle = false,
    type10FillLow = false,
    type10Tips = false,
    type10TipsText = "",
    cellChoiceItemList = {
      moduleName = "pages/Option/cellListItem"
    },
    cellChoiceWhiteItem = {
      moduleName = "pages/Option/cellChoiceWhiteItem"
    },
    txt_block = "",
    active_txtBlock = false
  }
end

function this.methods()
  return {
    cellChoiceWhiteItem = {
      onClick = function(self, index, num)
        local isIn = self.bind.cellChoiceWhiteItem:getValue(num, "bgB")
        if isIn then
        else
          for i = 1, #self.bind.cellChoiceWhiteItem do
            local val = {
              bgB = i == num
            }
            self.bind.cellChoiceWhiteItem:change(i, val)
          end
          if self.bind.id == L_Const.settingType.dlssLevel then
            self.bind.default = index
          end
          if self.bind.id == L_Const.settingType.frame then
            self.bind.default = index
          end
          self:emit("onChange", self.bind.id, index)
        end
      end
    },
    cellChoiceItemList = {
      onClick = function(self, text, index, num)
        self:onDropdownItemClick(text, index)
      end
    },
    onClick_type2ChangeSlider = function(self, value)
      if self.bind.sliderMax == nil or self.bind.sliderMin == nil then
        return
      end
      if self.bind.optionType ~= L_Const.optionType.slider then
        return
      end
      if self.refreshDirty then
        self.refreshDirty = false
      else
        local val = string.format("%d", value)
        if val ~= self.bind.default then
          L_AudioUtil.playSound("Play_SFX_System_UI_General_Slide_L1")
          if self.bind.id == L_Const.settingType.renderAccuracy and L_DeviceTpl:getEquipment() == L_Const.equipment.pc then
            if L_SettingStore:getSetData(L_Const.settingType.superResolution) == "1" then
              self:emit("onChange", self.bind.id, val)
            end
          else
            self:emit("onChange", self.bind.id, val)
          end
        end
      end
      self:refresh_addition(value)
    end,
    onClick_type3Btn1 = function(self)
      if self:showBlockTips() then
        return
      end
      if self.bind.id == L_Const.settingType.physicalPush then
        C_AppMessageFeedManager.Instance:SetStaminaFeedNotificationActive(true)
        return
      end
      self.bind.type3Btn1 = false
      self.bind.type3Btn2 = true
      self.bind.off = false
      self.bind.on = true
      self:emit("onChange", self.bind.id, true)
    end,
    onClick_type3Btn2 = function(self)
      if self.bind.id == L_Const.settingType.physicalPush then
        C_AppMessageFeedManager.Instance:SetStaminaFeedNotificationActive(false)
        return
      end
      self.bind.type3Btn1 = true
      self.bind.type3Btn2 = false
      self.bind.off = true
      self.bind.on = false
      self:emit("onChange", self.bind.id, false)
    end,
    onClick_type4Btn = function(self)
      if self.bind.id == L_Const.settingType.CDK then
        local text = self.bindComponents.inputfield.text
        local msg = {command = "CDKEY"}
        print("cdk" .. text)
        L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
      end
    end,
    onClick_type5Btn = function(self)
      self:emit("onClick", self.bind.id)
    end,
    onClick_type7Btn = function(self)
      local tpl = _optionDataTpl:getTplById(self.bind.id)
      local allowChange = _optionDataTpl:getAllowChange(tpl)
      if allowChange then
        self:emit("changeKey", self.bind.id)
        self.bind.type7Mask = true
        self.bind.type7Text = false
      else
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_keycode_not_support_change"))
      end
    end,
    onClick_type8Btn = function(self)
      self:refresh_dropdown()
      L_AudioUtil.playSound("Play_SFX_System_UI_General_Drop_Open")
      self:emit("changeDropdown", self.bind.id, function()
        L_AudioUtil.playSound("Play_SFX_System_UI_General_Drop_Close")
        self:refresh_dropdown()
      end)
    end
  }
end

function this:toBind(...)
  self.refreshDirty = true
  this.super.toBind(self, ...)
end

function this:refresh()
  self:refreshShowState()
  local tpl = _optionDataTpl:getTplById(self.bind.id)
  self.bind.name = tpl.optionName
  self.bind.cellChoiceWhiteItem:clear()
  if self.bind.optionType == L_Const.optionType.text then
    self:refresh_text()
  elseif self.bind.optionType == L_Const.optionType.slider then
    self:refresh_slider()
  elseif self.bind.optionType == L_Const.optionType.toggle then
    self:refresh_toggle()
  elseif self.bind.optionType == L_Const.optionType.textInput then
    self:refresh_textInput()
  elseif self.bind.optionType == L_Const.optionType.button then
    self:refresh_button()
  elseif self.bind.optionType == L_Const.optionType.multiMenu then
    self:refresh_multiMenu()
  elseif self.bind.optionType == L_Const.optionType.changeKey then
    self:refresh_changeKey()
  elseif self.bind.optionType == L_Const.optionType.dropMenu then
    self:refresh_dropMenu()
  elseif self.bind.optionType == L_Const.optionType.fill then
    self:refresh_fillImage()
  elseif self.bind.optionType == L_Const.optionType.imageSet then
    self:refreshBright(L_SettingStore:getSetData(L_Const.settingType.bright))
    self:refreshContrast(L_SettingStore:getSetData(L_Const.settingType.contrast))
    self:refreshSaturation(L_SettingStore:getSetData(L_Const.settingType.saturation))
  end
  local size = self.gameObject.transform.sizeDelta
  if self.bind.optionType == L_Const.optionType.imageSet then
    self.bind.type9 = true
    size.y = 280
  else
    self.bind.type9 = false
    local size = self.gameObject.transform.sizeDelta
    size.y = 81
  end
  self.gameObject.transform.sizeDelta = size
  if self.bind.optionType == L_Const.optionType.imageSet then
    self.preview1Mat = self.bindComponents.imgPreview1.material
    self.preview2Mat = self.bindComponents.imgPreview2.material
    self.preview3Mat = self.bindComponents.imgPreview3.material
  end
end

function this:open()
  L_SettingStore:listenCallFunc(L_SettingStore.event.showStateChange, self.onShowStateChange, self)
  self.onEvent_AppPushMessageSync = self.onEvent_AppPushMessageSync or handler(self, self.AppPushSettingSwitchCallback)
  C_AppPushMessageEvent.instance:Listen(C_EAppPushMessageEvent.RequestCompleted, self.onEvent_AppPushMessageSync)
end

function this:close()
  L_SettingStore:unListenCallFunc(L_SettingStore.event.showStateChange, self.onShowStateChange, self)
  C_AppPushMessageEvent.instance:Cancel(C_EAppPushMessageEvent.RequestCompleted, self.onEvent_AppPushMessageSync)
  self.preImgQuality = nil
  if self.graphicTimer then
    Timer.remove(self.graphicTimer)
    self.graphicTimer = nil
  end
end

function this:onShowStateChange(id, settingState, blockType)
  if id == self.bind.id then
    self.bind.settingState = settingState
    if blockType then
      self.bind.blockType = blockType
    end
    self:refresh()
    self.parent:forceRebuildLayout()
  end
end

function this:refreshShowState()
  local state, blockType = L_SettingStore.checkAdapter:checkState(self.bind.id, self.parent and self.parent.changeData.map or nil)
  self.bind.settingState = state
  local settingState = self.bind.settingState
  self:setBlock(false)
  if settingState == L_Const.settingState.none then
    self.gameObject:SetActive(true)
  elseif settingState == L_Const.settingState.block then
    self:setBlock(true, self.bind.blockType)
  elseif settingState == L_Const.settingState.hide then
    self.gameObject:SetActive(false)
  end
  self.parent:refreshDisplayState()
end

function this:refreshBright(bright)
  local value = tonumber(bright)
  if value <= 50 then
    value = 0.012 * value - 0.6
  else
    value = 0.004 * value - 0.2
  end
  if self.preview1Mat then
    self.preview1Mat:SetFloat("_Brightness", value)
  end
  if self.preview2Mat then
    self.preview2Mat:SetFloat("_Brightness", value)
  end
  if self.preview3Mat then
    self.preview3Mat:SetFloat("_Brightness", value)
  end
end

function this:refreshSaturation(saturation)
  local value = tonumber(saturation)
  if value <= 50 then
    value = 0.012 * value + 0.4
  else
    value = 0.008 * value + 0.6
  end
  if self.preview1Mat then
    self.preview1Mat:SetFloat("_Saturation", value)
  end
  if self.preview2Mat then
    self.preview2Mat:SetFloat("_Saturation", value)
  end
  if self.preview3Mat then
    self.preview3Mat:SetFloat("_Saturation", value)
  end
end

function this:refreshContrast(contrast)
  local value = tonumber(contrast)
  value = 0.004 * value + 0.8
  if self.preview1Mat then
    self.preview1Mat:SetFloat("_Contrast", value)
  end
  if self.preview2Mat then
    self.preview2Mat:SetFloat("_Contrast", value)
  end
  if self.preview3Mat then
    self.preview3Mat:SetFloat("_Contrast", value)
  end
end

function this:refresh_text()
  self.bind.type1 = true
  self.bind.type1Text = L_Const.settingText:ReadParam(self.bind.id, tonumber(self.bind.default))
end

function this:refresh_slider()
  local tpl = _optionDataTpl:getTplById(self.bind.id)
  local data = _optionDataTpl:getOptionPara2(tpl)
  self.bind.type2 = true
  if self.bind.id == L_Const.settingType.renderAccuracy and L_SettingStore:getSetData(L_Const.settingType.superResolution) == "1" and self.parent and self.parent.changeData then
    local newV = self.parent.changeData:getNew(L_Const.settingType.renderAccuracy)
    if newV then
      self.bind.default = newV
    end
  end
  self.bind.sliderMin = data[1]
  if self.bind.id == L_Const.settingType.multiPlayerNum then
    local maxShows = L_GameTpl:getGameConstTpl():getValue("MULTIMAINCITY_MAXSHOW_SETTING")
    if L_DeviceTpl:getIsPc() then
      self.bind.sliderMax = maxShows[2]
    else
      self.bind.sliderMax = maxShows[1]
    end
  else
    self.bind.sliderMax = data[2]
  end
  self.bind.sliderText = self.bind.default
  self.bind.sliderValue = tonumber(self.bind.sliderText)
  self.bind.closeIcon = false
  if self.bind.id == L_Const.settingType.renderAccuracy and L_SettingStore:getSetData(L_Const.settingType.superResolution) ~= "1" then
    local ac = C_DeviceGradingManager.GetQualityValue(C_QualityConstants.PIPELINE_RENDER_SCALE) or "1"
    local showVal = tonumber(ac) * 100
    self.bind.sliderText = tostring(showVal)
    self.bind.sliderValue = showVal
  end
  self:refresh_addition(self.bind.sliderValue)
  local slider = self.bindComponents.slider
  if self.bind.id == L_Const.settingType.bgm then
    slider.eventDownName = "Play_SFX_System_UI_Setting_Slide_BGM_On"
    slider.eventUpName = "Play_SFX_System_UI_Setting_Slide_BGM_Off"
  elseif self.bind.id == L_Const.settingType.cv then
    slider.eventDownName = "Play_SFX_System_UI_Setting_Slide_VO_On"
    slider.eventUpName = "Play_SFX_System_UI_Setting_Slide_VO_Off"
  elseif self.bind.id == L_Const.settingType.se then
    slider.eventDownName = "Play_SFX_System_UI_Setting_Slide_SFX_On"
    slider.eventUpName = "Play_SFX_System_UI_Setting_Slide_SFX_Off"
  else
    slider.eventDownName = nil
    slider.eventUpName = nil
  end
  if L_Const.settingType.bgm <= self.bind.id and self.bind.id <= L_Const.settingType.cv and self.bind.sliderText == "0" then
    self.bind.closeIcon = true
  end
  if L_Const.settingType.bgm <= self.bind.id and self.bind.id <= L_Const.settingType.cv and L_SettingStore:getSetData(L_Const.settingType.mute) == "true" then
    self.bind.closeIcon = true
  end
  self.bind.text = not self.bind.closeIcon
  self.refreshDirty = false
end

function this:refresh_toggle()
  self.bind.type3 = true
  if self.bind.default == 0 then
  end
  if self.bind.default == "false" or self.bind.default == "0" then
    self.bind.type3Btn1 = true
    self.bind.type3Btn2 = false
    self.bind.off = true
    self.bind.on = false
  else
    self.bind.type3Btn1 = false
    self.bind.type3Btn2 = true
    self.bind.off = false
    self.bind.on = true
  end
end

function this:refresh_textInput()
  self.bind.type4 = true
end

function this:refresh_button()
  self.bind.type5 = true
  local tpl = _optionDataTpl:getTplById(self.bind.id)
  self.bind.btnName = tpl.optionPara4
end

function this:refresh_multiMenu()
  local tpl = _optionDataTpl:getTplById(self.bind.id)
  local data = _optionDataTpl:getOptionPara6(tpl)
  local defaultId = tonumber(self.bind.default)
  local whiteData = {}
  local count = #data
  if self.bind.id == L_Const.settingType.image then
    for i = 1, #data do
      if i == defaultId then
        table.insert(whiteData, {
          text = data[i],
          textB = data[i],
          bgB = true,
          index = i,
          num = i
        })
      else
        table.insert(whiteData, {
          text = data[i],
          textB = data[i],
          bgB = false,
          index = i,
          num = i
        })
      end
    end
  elseif self.bind.id == L_Const.settingType.frame then
    if L_DeviceTpl:getIsPc() then
      for i = 1, #data do
        if i == defaultId then
          table.insert(whiteData, {
            text = data[i],
            textB = data[i],
            bgB = true,
            index = i,
            num = i
          })
        else
          table.insert(whiteData, {
            text = data[i],
            textB = data[i],
            bgB = false,
            index = i,
            num = i
          })
        end
      end
    elseif C_AppConfigManager.Platform == C_EAppPlatform.IOS then
      local f30 = L_WordsTpl:getValue("ui_frame", {
        [0] = " 30"
      })
      local f60 = L_WordsTpl:getValue("ui_frame", {
        [0] = " 60"
      })
      table.insert(whiteData, {
        text = f30,
        textB = f30,
        bgB = defaultId == 1,
        index = 1,
        num = 1
      })
      table.insert(whiteData, {
        text = f60,
        textB = f60,
        bgB = defaultId == 2,
        index = 2,
        num = 2
      })
      count = 2
    elseif L_DeviceTpl:getIsMobile() then
      local f30 = L_WordsTpl:getValue("ui_frame", {
        [0] = " 30"
      })
      local f45 = L_WordsTpl:getValue("ui_frame", {
        [0] = " 45"
      })
      local f60 = L_WordsTpl:getValue("ui_frame", {
        [0] = " 60"
      })
      table.insert(whiteData, {
        text = f30,
        textB = f30,
        bgB = defaultId == 1,
        index = 1,
        num = 1
      })
      table.insert(whiteData, {
        text = f45,
        textB = f45,
        bgB = defaultId == 2,
        index = 2,
        num = 2
      })
      table.insert(whiteData, {
        text = f60,
        textB = f60,
        bgB = defaultId == 3,
        index = 3,
        num = 3
      })
    end
  else
    for i = 1, #data do
      if i == defaultId then
        table.insert(whiteData, {
          text = data[i],
          textB = data[i],
          bgB = true,
          index = i,
          num = i
        })
      else
        table.insert(whiteData, {
          text = data[i],
          textB = data[i],
          bgB = false,
          index = i,
          num = i
        })
      end
    end
  end
  self.bind.cellChoiceWhiteItem:insert_array(whiteData)
  self.bind.cellChoiceWhiteItem:change(count, {line = false})
  self.bind.type6 = true
end

local _sprite_LMB = "UI/Atlas/Guide/tex_guide_fight_icon_sb1.png"
local _sprite_RMB = "UI/Atlas/Guide/tex_guide_fight_icon_sb1.png"
local _sprite_MMB = "UI/Atlas/Guide/tex_guide_fight_icon_sb2.png"

function this:refresh_changeKey()
  self.bind.type7 = true
  self.bind.type7Text = true
  local name
  local tpl = _keyCodeTpl:getTplByKey(self.bind.default)
  if tpl then
    name = tpl.keyName
    local keyCode = tpl.keyName
    if keyCode == "LMB" then
      self.bind.type7Icon = true
      self.bind.type7Sprite = _sprite_LMB
      self.bindComponents.layout.padding.left = 10
      self.bind.type7Name = name
      return
    end
    if keyCode == "RMB" then
      self.bind.type7Icon = true
      self.bind.type7Sprite = _sprite_RMB
      self.bindComponents.mouseIcon.flipHorizontal = true
      self.bindComponents.layout.padding.left = 10
      self.bind.type7Name = name
      return
    end
    if keyCode == "MMB" then
      self.bind.type7Icon = true
      self.bind.type7Sprite = _sprite_MMB
      self.bindComponents.layout.padding.left = 10
      self.bind.type7Name = name
      return
    end
  else
    name = self.bind.default
  end
  self.bind.type7Name = name
  self.bind.type7Icon = false
  self.bindComponents.mouseIcon.flipHorizontal = false
  self.bindComponents.layout.padding.left = 21
end

function this:refresh_dropMenu()
  self.bind.type8 = true
  self.bind.dropdownCanvas = self.bind.defaultCanvas
  self.bind.noneCanvas = self.bind.defaultCanvas
  self.bind.type8TextCanvas = self.bind.defaultCanvas + 1
  self.bind.grid_dropCanvas = self.bind.defaultCanvas + 1
  local tpl = _optionDataTpl:getTplById(self.bind.id)
  local data = _optionDataTpl:getOptionPara6(tpl)
  local defaultId = tonumber(self.bind.default)
  local tempData = {}
  local srcId = 1
  if self.bind.id == L_Const.settingType.resolution then
    local windowMode = L_SettingStore:getSetNumData(L_Const.settingType.windowMode)
    if windowMode ~= 3 then
      local curId = L_SettingStore:getSetNumData(L_Const.settingType.resolution)
      srcId = L_SettingStore:getDeviceCapResultionId()
      defaultId = math.max(srcId, curId)
    else
      defaultId = L_SettingStore:getSetNumData(L_Const.settingType.resolution)
      for i = 1, #L_SettingStore.resolutions do
        local res = L_SettingStore.resolutions[i]
        local text = string.format("%s×%s", res[1], res[2])
        table.insert(tempData, {
          textW = text,
          textG = text,
          index = i,
          line = i < #L_SettingStore.resolutions
        })
        if i == defaultId then
          self.bind.type8Text = text
        end
      end
      self.bind.default = defaultId
      self.bind.dropdown = true
      self.bind.cellChoiceItemList:refresh_array(tempData)
      self.bindComponents.noneCanvas.overrideSorting = false
      self.bindComponents.type8TextCanvas.overrideSorting = false
      return
    end
  end
  self.bind.default = defaultId
  self.bind.dropdown = true
  self.bind.type8Text = data[defaultId]
  local dataSize = #data
  if self.bind.id == L_Const.settingType.language then
    for i = srcId, dataSize do
      local size = L_SettingStore:byteToGBText(L_SettingStore:getLangPackSize(i))
      local text = L_SettingStore:getIsExistsLangPack(i) and data[i] or data[i] .. " " .. size
      table.insert(tempData, {
        textW = text,
        textG = text,
        index = i,
        line = i < dataSize
      })
    end
  else
    for i = srcId, dataSize do
      table.insert(tempData, {
        textW = data[i],
        textG = data[i],
        index = i,
        line = i < dataSize
      })
    end
  end
  self.bind.cellChoiceItemList:refresh_array(tempData)
  self.bindComponents.noneCanvas.overrideSorting = false
  self.bindComponents.type8TextCanvas.overrideSorting = false
end

function this:refresh_dropdown()
  if not self.bind.dropdownToggle then
    for i = 1, #self.bind.cellChoiceItemList do
      if self.bind.cellChoiceItemList:getValue(i, "textW") == self.bind.type8Text then
        self.bind.cellChoiceItemList[i].wObj = true
        self.bind.cellChoiceItemList[i].gObj = false
      else
        self.bind.cellChoiceItemList[i].wObj = false
        self.bind.cellChoiceItemList[i].gObj = true
      end
    end
    self.bind.dropdownToggle = true
    self.bindComponents.noneCanvas.overrideSorting = true
    self.bindComponents.type8TextCanvas.overrideSorting = true
  else
    self.bind.dropdownToggle = false
    self.bindComponents.noneCanvas.overrideSorting = false
    self.bindComponents.type8TextCanvas.overrideSorting = false
  end
end

function this:refresh_addition(value)
  if value == self.bind.sliderMin then
    self.bind.additionFill = false
    self.bind.additionBackground = true
    return
  end
  if value == self.bind.sliderMax then
    self.bind.additionFill = true
    self.bind.additionBackground = false
  end
  local curPercent = value / self.bind.sliderMax
  local limitMinPercent = 0.03
  if self.bind.sliderMin > 0 then
    limitMinPercent = self.bind.sliderMin / self.bind.sliderMax
  end
  local limitMaxPercent = 0.97
  if curPercent <= limitMinPercent then
    self.bind.additionFill = false
  elseif curPercent > limitMinPercent and curPercent < limitMaxPercent then
    self.bind.additionFill = true
    self.bind.additionBackground = true
  elseif curPercent >= limitMaxPercent then
    self.bind.additionBackground = false
  end
end

function this:refresh_fillImage()
  if not self.isBind then
    return
  end
  self.bind.type10 = true
  if self.bind.id == L_Const.settingType.graphicsMemory then
    local total = Unity.SystemInfo.graphicsMemorySize
    local graphicMemoryRange = _gameTpl:getData("SETTING_MEMORY_PC", L_Const.GameTplType.list_list_int)
    if Unity.Application.IsMobilePlatformForUI then
      graphicMemoryRange = _gameTpl:getData("SETTING_MEMORY_MOBILE", L_Const.GameTplType.list_list_int)
    end
    local levelVal = L_SettingStore:getSetData(L_Const.settingType.textureQuality) or 1
    if self.preImgQuality and self.preImgQuality == levelVal then
      return
    end
    self.preImgQuality = levelVal
    levelVal = tonumber(levelVal)
    local range = graphicMemoryRange[levelVal]
    local cur = math.random(range[1], range[2])
    cur = total < cur and total or cur
    self.bind.type10FillText = string.format("%sM/%sM", math.floor(cur), math.floor(total))
    self.bind.type10TipsText = ""
    local percent = cur / total
    self.bind.type10FillAmountH = percent
    self.bind.type10FillAmountM = percent
    self.bind.type10FillAmountL = percent
    percent = percent * 10000
    local config = _gameTpl:getData("option_graphic_memory_bar", L_Const.GameTplType.list_int)
    if config[1] and config[2] then
      local l1 = config[1]
      local l2 = config[2]
      if percent <= l1 then
        self.bind.type10FillLow = true
        self.bind.type10FillMiddle = false
        self.bind.type10FillHight = false
        self.bind.type10Tips = false
        self.bind.type10Text = "<color=#27ae89>" .. L_WordsTpl:getValue("ui_setup_low") .. "</color>"
      elseif percent <= l2 then
        self.bind.type10FillLow = false
        self.bind.type10FillMiddle = true
        self.bind.type10FillHight = false
        self.bind.type10Tips = false
        self.bind.type10Text = "<color=#df801b>" .. L_WordsTpl:getValue("ui_setup_medium") .. "</color>"
      else
        self.bind.type10FillLow = false
        self.bind.type10FillMiddle = false
        self.bind.type10FillHight = true
        self.bind.type10Tips = true
        self.bind.type10Text = "<color=#e07062>" .. L_WordsTpl:getValue("ui_setup_high") .. "</color>"
        self.bind.type10TipsText = L_WordsTpl:getValue("notice_setup_graphic_memory_suggestion")
      end
    end
  end
end

function this:setBlock(isOn, blockType)
  if isOn then
    if blockType then
      self.bind.active_txtBlock = true
      local txt = L_WordsTpl:getValue(L_Const.blockInfo[blockType] or "block")
      self.bind.txt_block = txt
    else
      local canvasGroup = self.bindComponents.canvasGroup
      canvasGroup.alpha = 0.5
      canvasGroup.interactable = false
    end
  else
    self.bind.active_txtBlock = false
    local canvasGroup = self.bindComponents.canvasGroup
    canvasGroup.alpha = 1
    canvasGroup.interactable = true
  end
end

function this:showBlockTips()
  if self.bind.settingState == L_Const.settingState.block then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue(L_Const.blockInfo[self.bind.blockType]))
    return true
  end
  return false
end

function this:onDropdownItemClick(text, index)
  if self.bind.id == L_Const.settingType.language and not L_SettingStore:getIsExistsLangPack(index) then
    local function callBack(text)
      self.bind.type8Text = text
    end
    
    self:emit("onChange", self.bind.id, index, text, callBack)
  elseif self.bind.id == L_Const.settingType.superResolution then
    local SUPER_RESOLUTION_TYPES = {
      [L_Const.superResolutionType.dlss] = {
        checkSupport = function()
          return C_SettingUtility.IsSupportDLSS()
        end
      },
      [L_Const.superResolutionType.xess] = {
        checkSupport = function()
          return C_SettingUtility.IsSupportXeSS()
        end
      }
    }
    local superResConfig = SUPER_RESOLUTION_TYPES[index]
    if superResConfig then
      if superResConfig.checkSupport() then
        self.bind.type8Text = text
        self:emit("onChange", self.bind.id, index)
      else
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue(L_Const.blockInfo[L_Const.settingBlockType.hardware]))
        self.parent.bind.go_dropClickMask = false
      end
    else
      self.bind.type8Text = text
      self:emit("onChange", self.bind.id, index)
    end
  else
    self.bind.type8Text = text
    self:emit("onChange", self.bind.id, index)
  end
  self.bind.dropdownToggle = false
  self.bindComponents.noneCanvas.overrideSorting = false
  self.bindComponents.type8TextCanvas.overrideSorting = false
end

function this:AppPushSettingSwitchCallback()
  if self.bind.id == L_Const.settingType.physicalPush then
    local isOpen = C_AppMessageFeedManager.Instance:GetStaminaFeedNotificationActive()
    self.bind.type3Btn1 = not isOpen
    self.bind.type3Btn2 = isOpen
    self.bind.off = not isOpen
    self.bind.on = isOpen
    self:emit("onChange", self.bind.id, isOpen)
  end
end

return this
