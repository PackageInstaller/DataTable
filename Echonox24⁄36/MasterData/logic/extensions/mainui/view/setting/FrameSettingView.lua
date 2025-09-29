-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/setting/FrameSettingView.lua

module("logic.extensions.mainui.view.setting.FrameSettingView", package.seeall)

local M = class("FrameSettingView", ViewComponent)
local kOriginalOffsetWidthKey = "main_setting_original_offset_width"
local kFrameSettingIndex = 3
local kMaxWidth = MainSettingModel.instance:getMaxAdaptationOffsetWidth()
local kResetTime = 0
local kShowWarmingTipsBarIndex = 4
local kShowWarmingTipsFrameIndex = 3
local kShowWarmingTipsDpiIndex = 1
local kSwitchDpiWaitTime = 1

function M:buildUI()
	self._togglePowerSaving = self:getUIComponent("main_setting_tips_355029231", UIComponentType.SpaceXToggle)
	self._sliderBoarder = self:getSlider("main_setting_tips_-1323553838")
	self._originalOffsetWidth = 0
	self._toggleGroup = self:getUIComponent("main_setting_tips_-1382810314", UIComponentType.SpaceXToggleGroup)
	self._toggleCompList = {}

	local toggleGoList = Astral.GameObjectUtil.GetChildren(self:getGo("main_setting_tips_-1382810314"))

	self._goRecommends = {}

	for index = 0, toggleGoList.Length - 1 do
		local toggleComp = toggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._toggleCompList, toggleComp)

		if toggleComp then
			local co = ConstConfig.instance:getFrameSettingById(index + 1)

			if co then
				local text1 = goutil.findChildTextComponent(toggleComp.gameObject, "normal/Text")
				local text2 = goutil.findChildTextComponent(toggleComp.gameObject, "select/Text")

				text1.text = co.typeString
				text2.text = co.typeString

				table.insert(self._goRecommends, goutil.findChild(toggleComp.gameObject, "recommend"))
			end
		end
	end

	self._picQualityToggleGroup = self:getUIComponent("main_setting_tips_1719059031", UIComponentType.SpaceXToggleGroup)
	self._picQualityToggleCompList = {}

	local picQualityToggleGoList = Astral.GameObjectUtil.GetChildren(self:getGo("main_setting_tips_1719059031"))

	for index = 0, picQualityToggleGoList.Length - 1 do
		local toggleComp = picQualityToggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._picQualityToggleCompList, toggleComp)
	end

	self._dpiToggleGroup = self:getUIComponent("main_setting_tips_454467676", UIComponentType.SpaceXToggleGroup)
	self._dpiToggleCompList = {}

	local dpiToggleGoList = Astral.GameObjectUtil.GetChildren(self:getGo("main_setting_tips_454467676"))

	for index = 0, dpiToggleGoList.Length - 1 do
		local toggleComp = dpiToggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._dpiToggleCompList, toggleComp)
	end

	self._effectToggleGroup = self:getUIComponent("main_setting_tips_28890650", UIComponentType.SpaceXToggleGroup)
	self._effectToggleCompList = {}

	local effectToggleGoList = Astral.GameObjectUtil.GetChildren(self:getGo("main_setting_tips_28890650"))

	for index = 0, effectToggleGoList.Length - 1 do
		local toggleComp = effectToggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._effectToggleCompList, toggleComp)
	end

	self._fpsToggleGroup = self:getUIComponent("main_setting_tips_2045414667", UIComponentType.SpaceXToggleGroup)
	self._fpsToggleCompList = {}

	local fpsToggleGoList = Astral.GameObjectUtil.GetChildren(self:getGo("main_setting_tips_2045414667"))

	for index = 0, fpsToggleGoList.Length - 1 do
		local toggleComp = fpsToggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._fpsToggleCompList, toggleComp)
	end

	self._toggleHdr = self:getUIComponent("main_setting_tips_-410949881", UIComponentType.SpaceXToggle)
	self._toggleAntialiasing = self:getUIComponent("main_setting_tips_-1206689931", UIComponentType.SpaceXToggle)
end

function M:destroyUI()
	self._togglePowerSaving = nil
end

function M:bindEvents()
	self:syncSetting()
	self._togglePowerSaving:AddListener(self._onTogglePowerSaving, self)
	self._toggleHdr:AddListener(self._onToggleHdr, self)
	self._toggleAntialiasing:AddListener(self._onToggleAntialiasing, self)

	for k, v in pairs(self._toggleCompList) do
		v:AddListener(function(_, isOn)
			self._inSwitching = true

			settimer(kResetTime, self._resetInSwitching, self, false)
			self:_dealBarClick(k, isOn)
			self:_storageSettings()
		end, nil)
	end

	for k, v in pairs(self._picQualityToggleCompList) do
		v:AddListener(function(_, isOn)
			self:_dealPicQualityBarClick(k, isOn)
		end, nil)
	end

	for k, v in pairs(self._dpiToggleCompList) do
		v:AddListener(function(_, isOn)
			self:_dealDpiBarClick(k, isOn)
		end, nil)
	end

	for k, v in pairs(self._effectToggleCompList) do
		v:AddListener(function(_, isOn)
			self:_dealEffectBarClick(k, isOn)
		end, nil)
	end

	for k, v in pairs(self._fpsToggleCompList) do
		v:AddListener(function(_, isOn)
			self:_dealFpsBarClick(k, isOn)
		end, nil)
	end

	self._sliderBoarder:AddOnValueChanged(self._onBoarderValueChanged, self)
end

function M:unbindEvents()
	self._togglePowerSaving:RemoveListener()

	for k, v in ipairs(self._toggleCompList) do
		v:RemoveListener()
	end

	for k, v in ipairs(self._picQualityToggleCompList) do
		v:RemoveListener()
	end

	for k, v in ipairs(self._dpiToggleCompList) do
		v:RemoveListener()
	end

	for k, v in ipairs(self._effectToggleCompList) do
		v:RemoveListener()
	end

	for k, v in ipairs(self._fpsToggleCompList) do
		v:RemoveListener()
	end

	self._sliderBoarder:RemoveOnValueChanged()
end

function M:onEnter()
	self._hasInit = false
	self._originalOffsetWidth = MainSettingModel.instance:getAdaptationOffsetWidth()

	MainSettingModel.instance:saveAdaptationOffsetWidth(self._originalOffsetWidth)
	self._sliderBoarder:SetValue(1 - self._originalOffsetWidth / kMaxWidth)
	self:syncSetting()

	self._hasInit = true

	for k, v in pairs(self._goRecommends) do
		goutil.setActive(v, k == GfxGradeUtil.getRecommendLevel().level)
	end
end

function M:onExit()
	EventSystemUtils.ReloadActiveInputModule()
	removetimer(self.__delayResetBlock, self)
	self:_setPageBlock(false)

	self._isCustom = false
	self._inSwitching = false
	self._hasInit = false
	self._showDialog = nil
	self._closeWarmingDialogCallback = nil

	removetimer(self._resetInSwitching, self)
end

function M:_showWarmingTips(content)
	if not self._hasInit or self._showDialog then
		return
	end

	local dialog = Dialog.showWarnMessage(lang("tip_title"), content or lang("tip_frame_setting_warming"))

	dialog:setConfirmListener(self._onConfirmDialog, self)
	dialog:setCancelListener(self._onCancelDialog, self)

	self._showDialog = dialog
end

function M:_onConfirmDialog()
	self._showDialog = nil

	if self._closeWarmingDialogCallback then
		self._closeWarmingDialogCallback()

		self._closeWarmingDialogCallback = nil
	end
end

function M:_onCancelDialog()
	self._showDialog = nil
end

function M:_setPageBlock(isBlock)
	if not self._hasInit then
		return
	end

	ViewBlockMgr.instance:blockClick(isBlock, ViewBlockKey.Anim)
end

function M:syncSettingStorage()
	if not self._hasInit then
		return
	end

	if self._picQualityIndex ~= PlayerLocalStorageModel.instance:getGraphicsQualityLevel() then
		GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kGraphicsQuality, self._picQualityIndex)
	else
		if self._resolutionRatioQualityIndex ~= PlayerLocalStorageModel.instance:getResolutionRatioQuality() then
			GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kResolutionRatioQuality, self._resolutionRatioQualityIndex)
		end

		if self._effectQualityIndex ~= PlayerLocalStorageModel.instance:getEffectQuality() then
			GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kEffectQuality, self._effectQualityIndex)
		end

		if self._gameFrameIndex ~= PlayerLocalStorageModel.instance:getGameFrame() then
			GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kGameFrame, self._gameFrameIndex)
		end

		if self._isOpenAntialiasing ~= PlayerLocalStorageModel.instance:getAntialiasingSwitch() then
			GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kGameAntialiasing, self._isOpenAntialiasing)
		end

		if self._isOpenHdr ~= PlayerLocalStorageModel.instance:getOpenHdr() then
			GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kGameHDR, self._isOpenHdr)
		end
	end

	local offsetWidth = AdaptationUtils.GetDefaultOffsetSize(0)

	MainSettingModel.instance:saveAdaptationOffsetWidth(offsetWidth)
	PlayerLocalStorageModel.instance:setPowerSavingSwitch(self._isPowerSavingOn)
	PlayerLocalStorageModel.instance:setGraphicsSettingQuality(self._graphicsSettingQualityIndex)
	PlayerLocalStorageModel.instance:setGraphicsQualityLevel(self._picQualityIndex)
	PlayerLocalStorageModel.instance:setResolutionRatioQuality(self._resolutionRatioQualityIndex)
	PlayerLocalStorageModel.instance:setEffectQuality(self._effectQualityIndex)
	PlayerLocalStorageModel.instance:setGameFrame(self._gameFrameIndex)
	PlayerLocalStorageModel.instance:setAntialiasingSwitch(self._isOpenAntialiasing)
	PlayerLocalStorageModel.instance:setOpenHdr(self._isOpenHdr)
end

function M:syncSetting()
	local graphicsQuality = PlayerLocalStorageModel.instance:getGraphicsSettingQuality()
	local picQuality = PlayerLocalStorageModel.instance:getGraphicsQualityLevel()
	local dpiQuality = PlayerLocalStorageModel.instance:getResolutionRatioQuality()
	local barItem = self._toggleCompList[graphicsQuality]

	self._isCustom = graphicsQuality == 5

	self._toggleGroup:TryActiveChildOn(barItem, true)
	self._picQualityToggleGroup:TryActiveChildOn(self._picQualityToggleCompList[picQuality], true)
	self._dpiToggleGroup:TryActiveChildOn(self._dpiToggleCompList[dpiQuality], true)

	local effectQuality = PlayerLocalStorageModel.instance:getEffectQuality()

	self._effectToggleGroup:TryActiveChildOn(self._effectToggleCompList[effectQuality], true)

	local gameFrame = PlayerLocalStorageModel.instance:getGameFrame()

	if gameFrame <= 0 or gameFrame > 2 then
		gameFrame = 1
	end

	self._fpsToggleGroup:TryActiveChildOn(self._fpsToggleCompList[gameFrame], true)
	self._togglePowerSaving:ForceSetOn(PlayerLocalStorageModel.instance:getPowerSavingSwitch())
	self._toggleHdr:ForceSetOn(PlayerLocalStorageModel.instance:getOpenHdr())
	self._toggleAntialiasing:ForceSetOn(PlayerLocalStorageModel.instance:getAntialiasingSwitch())

	self._graphicsSettingQualityIndex = graphicsQuality
	self._picQualityIndex = picQuality
	self._resolutionRatioQualityIndex = dpiQuality
	self._effectQualityIndex = effectQuality
	self._gameFrameIndex = gameFrame
	self._isOpenHdr = PlayerLocalStorageModel.instance:getOpenHdr()
	self._isOpenAntialiasing = PlayerLocalStorageModel.instance:getAntialiasingSwitch()
	self._isPowerSavingOn = PlayerLocalStorageModel.instance:getPowerSavingSwitch()
	self._originalOffsetWidth = MainSettingModel.instance:getAdaptationOffsetWidth()

	self._sliderBoarder:SetValue(1 - self._originalOffsetWidth / kMaxWidth)
end

function M:checkSettingChange()
	local isChange = self._isPowerSavingOn ~= PlayerLocalStorageModel.instance:getPowerSavingSwitch()

	isChange = isChange or self._graphicsSettingQualityIndex ~= PlayerLocalStorageModel.instance:getGraphicsSettingQuality()
	isChange = isChange or self._resolutionRatioQualityIndex ~= PlayerLocalStorageModel.instance:getResolutionRatioQuality()
	isChange = isChange or self._effectQualityIndex ~= PlayerLocalStorageModel.instance:getEffectQuality()
	isChange = isChange or self._gameFrameIndex ~= PlayerLocalStorageModel.instance:getGameFrame()

	local offsetWidth = AdaptationUtils.GetDefaultOffsetSize(0)
	local newOffsetWidth = MainSettingModel.instance:getAdaptationOffsetWidth()

	isChange = isChange or math.abs(offsetWidth - newOffsetWidth) > 0.0001
	isChange = isChange or self._isOpenAntialiasing ~= PlayerLocalStorageModel.instance:getAntialiasingSwitch()
	isChange = isChange or self._isOpenHdr ~= PlayerLocalStorageModel.instance:getOpenHdr()
	isChange = isChange or self._picQualityIndex ~= PlayerLocalStorageModel.instance:getGraphicsQualityLevel()

	return isChange
end

function M:_onBoarderValueChanged(value)
	local width = kMaxWidth * (1 - value)

	self:_setBoarderOffsetWidth(width)

	if self._tabIndex == kFrameSettingIndex then
		-- block empty
	end

	self:_storageSettings()
end

function M:_storageSettings()
	local isChange = self:checkSettingChange()

	if isChange then
		self:syncSettingStorage()
	end
end

function M:resetSetting()
	PlayerLocalStorageModel.instance:setGraphicsSettingQuality(4)
	PlayerLocalStorageModel.instance:setResolutionRatioQuality(3)
	PlayerLocalStorageModel.instance:setEffectQuality(3)
	PlayerLocalStorageModel.instance:setGameFrame(2)
	PlayerLocalStorageModel.instance:setPowerSavingSwitch(false)
	self:_setBoarderOffsetWidth(MainSettingModel.instance:getBestOffsetSize())
end

function M:_setBoarderOffsetWidth(width)
	AdaptationUtils.SetDefaultOffsetSize(width)
end

function M:_checkSwitching()
	if not self._hasInit then
		return
	end

	if not self._inSwitching then
		if not self._isCustom then
			self._toggleGroup:TryActiveChildOn(self._toggleCompList[5], true)
		end

		self._inSwitching = true

		settimer(kResetTime, self._resetInSwitching, self, false)
		self:_storageSettings()
	end
end

function M:_onTogglePowerSaving(index, isOn)
	self._isPowerSavingOn = isOn

	self:_storageSettings()

	if isOn then
		PlayerLocalStorageModel.instance:saveLastFrameSetting()

		local barItem = self._toggleCompList[1]

		self._toggleGroup:TryActiveChildOn(barItem, true)
	else
		self:_restoreLastSetting()
	end
end

function M:_restoreLastSetting()
	if self._inSwitching then
		return
	end

	local v1, v2, v3, v4, v5, v6, v7 = PlayerLocalStorageModel.instance:getLastFrameSetting()

	self._graphicsSettingQualityIndex = v1
	self._picQualityIndex = v2
	self._resolutionRatioQualityIndex = v3
	self._effectQualityIndex = v4
	self._gameFrameIndex = v5
	self._isOpenHdr = v6 == 1
	self._isOpenAntialiasing = v7 == 1

	PlayerLocalStorageModel.instance:setGraphicsSettingQuality(self._graphicsSettingQualityIndex)
	PlayerLocalStorageModel.instance:setGraphicsQualityLevel(self._picQualityIndex)
	PlayerLocalStorageModel.instance:setResolutionRatioQuality(self._resolutionRatioQualityIndex)
	PlayerLocalStorageModel.instance:setEffectQuality(self._effectQualityIndex)
	PlayerLocalStorageModel.instance:setGameFrame(self._gameFrameIndex)
	PlayerLocalStorageModel.instance:setAntialiasingSwitch(self._isOpenAntialiasing)
	PlayerLocalStorageModel.instance:setOpenHdr(self._isOpenHdr)
	self._toggleGroup:TryActiveChildOn(self._toggleCompList[v1], true)
	self._picQualityToggleGroup:TryActiveChildOn(self._picQualityToggleCompList[v2], true)
	self._dpiToggleGroup:TryActiveChildOn(self._dpiToggleCompList[v3], true)
	self._effectToggleGroup:TryActiveChildOn(self._effectToggleCompList[v4], true)
	self._fpsToggleGroup:TryActiveChildOn(self._fpsToggleCompList[v5], true)
	self._toggleHdr:ForceSetOn(self._isOpenHdr)
	self._toggleAntialiasing:ForceSetOn(self._isOpenAntialiasing)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kGraphicsQuality, self._picQualityIndex)
end

function M:_onToggleHdr(index, isOn)
	self._isOpenHdr = isOn

	local isChange = self._isOpenHdr ~= PlayerLocalStorageModel.instance:getOpenHdr()

	if isChange then
		GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kGameHDR, self._isOpenHdr)
	end

	self:_checkSwitching()
end

function M:_onToggleAntialiasing(index, isOn)
	self._isOpenAntialiasing = isOn

	local isChange = self._isOpenAntialiasing ~= PlayerLocalStorageModel.instance:getAntialiasingSwitch()

	if isChange then
		GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kGameAntialiasing, self._isOpenAntialiasing)
	end

	self:_checkSwitching()
end

function M:_dealBarClick(index, isOn)
	if isOn then
		if index == kShowWarmingTipsBarIndex and not self._ignoreCheck and not Astral.OSDef.RunOS == Astral.OSDef.Win32 then
			self:_showWarmingTips()

			function self._closeWarmingDialogCallback()
				self._ignoreCheck = true

				self._toggleGroup:TryActiveChildOn(self._toggleCompList[kShowWarmingTipsBarIndex], true)
			end

			local activeTab = self._toggleCompList[self._graphicsSettingQualityIndex]

			if activeTab then
				activeTab.IsOn = true
			end

			return
		end

		self._ignoreCheck = false

		local co = ConstConfig.instance:getFrameSettingById(index)

		if co then
			local resolutionRatio, effectLevel, frameNum, openAntialiasing, useHdr = GfxConfig.getGraphicsSettingInfo(index)

			PlayerLocalStorageModel.instance:setGraphicsSettingQuality(index)
			PlayerLocalStorageModel.instance:setGraphicsQualityLevel(index)
			PlayerLocalStorageModel.instance:setResolutionRatioQuality(resolutionRatio)
			PlayerLocalStorageModel.instance:setEffectQuality(effectLevel)
			PlayerLocalStorageModel.instance:setGameFrame(frameNum)
			PlayerLocalStorageModel.instance:setOpenHdr(useHdr)
			PlayerLocalStorageModel.instance:setAntialiasingSwitch(openAntialiasing)
			GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kGraphicsQuality, index)

			local barItem = self._picQualityToggleCompList[index]

			self._picQualityToggleGroup:TryActiveChildOn(barItem, true)

			barItem = self._dpiToggleCompList[resolutionRatio]

			self._dpiToggleGroup:TryActiveChildOn(barItem, true)

			barItem = self._effectToggleCompList[effectLevel]

			self._effectToggleGroup:TryActiveChildOn(barItem, true)

			barItem = self._fpsToggleCompList[frameNum]

			self._fpsToggleGroup:TryActiveChildOn(barItem, true)

			self._toggleHdr.IsOn = useHdr
			self._toggleAntialiasing.IsOn = openAntialiasing
		end

		self._isCustom = index == 5
		self._graphicsSettingQualityIndex = index
		self._togglePowerSaving.IsOn = index == 1
	end
end

function M:_resetInSwitching()
	self._inSwitching = false
end

function M:_dealDpiBarClick(index, isOn)
	if self._showDialog then
		return
	end

	if isOn then
		if index == kShowWarmingTipsDpiIndex and not self._ignoreCheck and not Astral.OSDef.RunOS == Astral.OSDef.Win32 then
			self:_showWarmingTips(lang("tip_frame_setting_low_warming"))

			function self._closeWarmingDialogCallback()
				self._ignoreCheck = true

				self._dpiToggleGroup:TryActiveChildOn(self._dpiToggleCompList[kShowWarmingTipsDpiIndex], true)
			end

			local activeTab = self._dpiToggleCompList[self._resolutionRatioQualityIndex]

			if activeTab then
				activeTab.IsOn = true
			end

			return
		end

		self._ignoreCheck = false
		self._resolutionRatioQualityIndex = index

		self:_checkSwitching()
		self:_setPageBlock(true)
		settimer(kSwitchDpiWaitTime, self._delayResetBlock, self, false)
	end
end

function M:_delayResetBlock()
	self:_setPageBlock(false)
end

function M:_dealEffectBarClick(index, isOn)
	if isOn then
		self._effectQualityIndex = index

		self:_checkSwitching()
	end
end

function M:_dealPicQualityBarClick(index, isOn)
	if isOn then
		self._picQualityIndex = index

		self:_checkSwitching()
	end
end

function M:_dealFpsBarClick(index, isOn)
	if isOn then
		if index == kShowWarmingTipsFrameIndex and not self._ignoreCheck and not Astral.OSDef.RunOS == Astral.OSDef.Win32 then
			self:_showWarmingTips()

			function self._closeWarmingDialogCallback()
				self._ignoreCheck = true

				self._fpsToggleGroup:TryActiveChildOn(self._fpsToggleCompList[kShowWarmingTipsFrameIndex], true)
			end

			local activeTab = self._fpsToggleCompList[self._gameFrameIndex]

			if activeTab then
				activeTab.IsOn = true
			end

			return
		end

		self._ignoreCheck = false
		self._gameFrameIndex = index

		self:_checkSwitching()
	end
end

return M
