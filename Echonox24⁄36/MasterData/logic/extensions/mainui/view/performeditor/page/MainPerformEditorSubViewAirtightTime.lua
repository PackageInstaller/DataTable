-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/page/MainPerformEditorSubViewAirtightTime.lua

module("logic.extensions.mainui.view.performeditor.page.MainPerformEditorSubViewAirtightTime", package.seeall)

local M = class("MainPerformEditorSubViewAirtightTime")

function M:ctor(mainGo)
	self.mainGO = mainGo
end

function M:init(viewRegistry)
	self._viewRegistry = viewRegistry

	self:buildUI()
	self:bindEvents()

	self._isInit = true
end

function M:Awake()
	return
end

function M:OnEnable()
	if not self._isInit then
		return
	end

	self:_refreshTime()

	self._toggleIgnoreSpSetting.IsOn = AirtightRoomModel.instance:getIgnoreSpSetting()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local go = goutil.findChild(self.mainGO, "ViewPort/Content/base_AirtightTime").gameObject

	self._txtTime = goutil.findChildTextComponent(go, "txtTime")
	self._txtInfo = goutil.findChildTextComponent(go, "txtInfo")
	self._btnRefresh = UIComponentType.ButtonAdapter(goutil.findChild(go, "txtTime/btnRefresh"))
	self._btnReset = UIComponentType.ButtonAdapter(goutil.findChild(go, "change/btnReset"))
	self._btnToAirtight = UIComponentType.ButtonAdapter(goutil.findChild(go, "jump/btnToAirtight"))
	self._btnToNormal = UIComponentType.ButtonAdapter(goutil.findChild(go, "jump/btnToNormal"))
	self._btnDayAdd = UIComponentType.ButtonAdapter(goutil.findChild(go, "change/day/btnAdd"))
	self._btnDayMinus = UIComponentType.ButtonAdapter(goutil.findChild(go, "change/day/btnMinus"))
	self._btnHourAdd = UIComponentType.ButtonAdapter(goutil.findChild(go, "change/hour/btnAdd"))
	self._btnHourMinus = UIComponentType.ButtonAdapter(goutil.findChild(go, "change/hour/btnMinus"))
	self._btnMinuteAdd = UIComponentType.ButtonAdapter(goutil.findChild(go, "change/minute/btnAdd"))
	self._btnMinuteMinus = UIComponentType.ButtonAdapter(goutil.findChild(go, "change/minute/btnMinus"))
	self._inputItemExitTime = UIComponentType.InputFieldAdapter(goutil.findChild(go, "itemExitTime/input_time"))
	self._btnSaveItemExitTime = UIComponentType.ButtonAdapter(goutil.findChild(go, "itemExitTime/btnSave"))
	self._toggleIgnoreSpSetting = goutil.findChildComponent(go, "toggle_ignoreSpSetting", UIComponentType.SpaceXToggle)
end

function M:destroyUI()
	self:setHandler(nil)

	self.mainGO = nil
	self._viewRegistry = nil
end

function M:bindEvents()
	self._btnToAirtight:AddClickListener(self._onClickToAirtight, self)
	self._btnToNormal:AddClickListener(self._onClickToNormal, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnRefresh:AddClickListener(self._onClickRefresh, self)
	self._btnDayAdd:AddClickListener(function()
		self:_editTime(1, 0, 0)
	end, self)
	self._btnDayMinus:AddClickListener(function()
		self:_editTime(-1, 0, 0)
	end, self)
	self._btnHourAdd:AddClickListener(function()
		self:_editTime(0, 1, 0)
	end, self)
	self._btnHourMinus:AddClickListener(function()
		self:_editTime(0, -1, 0)
	end, self)
	self._btnMinuteAdd:AddClickListener(function()
		self:_editTime(0, 0, 1)
	end, self)
	self._btnMinuteMinus:AddClickListener(function()
		self:_editTime(0, 0, -1)
	end, self)
	self._btnSaveItemExitTime:AddClickListener(self._onClickSaveItemExitTime, self)
	self._toggleIgnoreSpSetting:AddListener(self._onToggleIgnoreSpSetting, self)
end

function M:unbindEvents()
	self._btnToAirtight:RemoveClickListener()
	self._btnToNormal:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
	self._btnDayAdd:RemoveClickListener()
	self._btnDayMinus:RemoveClickListener()
	self._btnHourAdd:RemoveClickListener()
	self._btnHourMinus:RemoveClickListener()
	self._btnMinuteAdd:RemoveClickListener()
	self._btnMinuteMinus:RemoveClickListener()
	self._btnSaveItemExitTime:RemoveClickListener()
	self._toggleIgnoreSpSetting:RemoveListener()
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getMainGo()
	return self.mainGO
end

function M:getActiveSubPageDirty()
	return false
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:_onClickReset()
	AirtightRoomModel.instance:setEditOffsetTime(0)
	self:_refreshTime()
end

function M:_onClickRefresh()
	self:_refreshTime()
end

function M:_onClickToAirtight()
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTime = AirtightRoomController.instance:getAirtightTimeInfo(nil, false, false)

	if hour >= 24 then
		return
	end

	local nextTimeStamp = AirtightRoomController.instance:getNextAirtightBeginTimeStamp()
	local offsetTime = AirtightRoomModel.instance:getEditOffsetTime()

	offsetTime = offsetTime + (nextTimeStamp - self._nowTime) + 1

	AirtightRoomModel.instance:setEditOffsetTime(offsetTime)
	self:_refreshTime()
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_EDITOR_HIDE, true)
end

function M:_onClickToNormal()
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTime = AirtightRoomController.instance:getAirtightTimeInfo(nil, false, false)

	if hour < 24 then
		return
	end

	local offsetTime = AirtightRoomModel.instance:getEditOffsetTime()

	offsetTime = offsetTime + (airtightEndTime - self._nowTime) + 1

	AirtightRoomModel.instance:setEditOffsetTime(offsetTime)
	self:_refreshTime()
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_EDITOR_HIDE, true)
end

function M:_onClickSaveItemExitTime()
	local str = self._inputItemExitTime:GetText()

	if string.nilorempty(str) then
		str = 0
	end

	str = tonumber(str)

	AirtightRoomController.instance:onAirtightRoomExitTimeChange(str)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_EDITOR_HIDE, true)
end

function M:_onToggleIgnoreSpSetting(_, isOn)
	AirtightRoomModel.instance:setIgnoreSpSetting(isOn)
	self:_refreshTime()
end

function M:_editTime(day, hour, min)
	local offsetTime = AirtightRoomModel.instance:getEditOffsetTime()

	offsetTime = offsetTime + day * 24 * 60 * 60 + hour * 60 * 60 + min * 60

	AirtightRoomModel.instance:setEditOffsetTime(offsetTime)
	self:_refreshTime()
end

function M:_refreshTime()
	self._nowTime = AirtightRoomModel.instance:getServerTime()

	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(self._nowTime)

	self._txtTime.text = string.format("当前时间：%s\n密室时间：%02d:%02d:%02d", TimeUtil.instance:stampToDateStr(self._nowTime), hour, minute, second)

	if AirtightRoomModel.instance:getEditOffsetTime() ~= 0 then
		self._txtTime.color = parsecolor("#FF4343")
	else
		self._txtTime.color = parsecolor("#E4E4E4")
	end

	self._inputItemExitTime:SetText(AirtightRoomModel.instance:getExitTime())
	self:_refreshInfo()
end

function M:_refreshInfo()
	local str = ""
	local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()
	local isSystemOpen = AirtightRoomUtil.isSystemOpen()

	if not inSpTime and isSystemOpen then
		str = "<b>当前密室状态</b>：可<color=#87FF5D>正常</color>切换"

		local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(self._nowTime)

		if inAirtightTime then
			str = string.format("%s\n--------------------距密室结束还有: %s", str, TimeUtil.instance:numberToTime(airtightEndTS - self._nowTime, "h:m"))
		else
			local nextTimeStamp = AirtightRoomController.instance:getNextAirtightBeginTimeStamp()

			str = string.format("%s\n--------------------距密室开始还有: %s", str, TimeUtil.instance:numberToTime(nextTimeStamp - self._nowTime, "h:m"))
		end
	else
		if inSpTime then
			str = inSpNormal and "<b>当前密室状态</b>  固定正常时间，<color=#FD47A9>不响应切换</color>" or inSpAirtight and "<b>当前密室状态</b>  固定密室时间，<color=#FD47A9>不响应切换</color>" or "<b>当前密室状态</b>  <color=#FD47A9>不响应切换</color>"
		end

		local guideId = AirtightRoomUtil.getAirtightTimeGuideId()

		if guideId > 0 then
			local guideFinish = GuideModel.instance:isGuideFinish(guideId)

			str = string.format("%s\n引导 <color=#E7DA06>%s</color> 完成 = %s", str, guideId, guideFinish)
		end

		guideId = AirtightRoomUtil.getNormalTimerGuideId()

		if guideId > 0 then
			local guideFinish = GuideModel.instance:isGuideFinish(guideId)

			str = string.format("%s\n引导 <color=#E7DA06>%s</color> 完成 = %s", str, guideId, guideFinish)
		end

		local dungeonId = ChamberConfig.instance:getConstByKey(ConstConfigKeyEnum.NormalTimeDungeon)

		if dungeonId > 0 then
			local mo = DungeonModel.instance:getDungeonMoById(dungeonId)

			if mo then
				str = string.format("%s\n副本 <color=#E7DA06>%s</color> %s-%s 通关 = %s", str, dungeonId, mo:getIndex(), mo:getName(), mo:hasPassed())
			else
				str = string.format("%s\n副本[%s] 无法找到dungeonMo = ", str, dungeonId)
			end
		end

		local systemKey = AirtightRoomUtil.getSystemKey()

		str = string.format("%s\n功能开启 <color=#E7DA06>%s</color> = %s", str, systemKey, SystemOpenFacade.instance:isOpen(systemKey, false))
	end

	self._txtInfo.text = str
end

return M
