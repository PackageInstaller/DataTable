local var_0_0 = 0.5
local var_0_1 = g.core.model.User.functionUnlockData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local ActivityCompManager = require("app.view.module.activity.view.activityBase.ActivityCompManager")
local var_0_5 = g.core.const.ConstMgr.ResourceBackConst
local var_0_6 = g.core.common.ServerTime
local ActivityMainLayer = class("ActivityMainLayer", require("app.fairyGUI.activity.UI_ActivityMainLayer"), function()
	return fgui.GComponent:create({
		resName = "ActivityMainLayer",
		pkgPath = "ui/activity/activity",
		isFullScreen = true,
		pkgName = "activity"
	})
end)

function ActivityMainLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._aTypeSelected = arg_2_1.activityType
	self._aValueSelected = arg_2_1.activityValue
	self._exeTimerLastTime = var_0_6:getTime()
	self._updateCDTimer = nil
	self._activityCompManager = ActivityCompManager.new(self.m_activityCompDad, self)
	self._activityMainLayerData = g.core.model.User.activityMainLayerData
	self._activityDataList = {}
	self._dailyCostComp = nil
	self._selectedIndex = 1
	self.m_bgLoader = nil

	self:_initView()
end

function ActivityMainLayer:onLoad()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_CUSTOM_ACTIVITY_GETINFO, self._onActivityInfoChanged, self)
	var_0_2:addEventListener(var_0_3.EVENT_CUSTOM_ACTIVITY_START_PREVIEW, self._onActivityInfoChanged, self)
	var_0_2:addEventListener(var_0_3.EVENT_CUSTOM_ACTIVITY_EXPIRE, self._onActivityInfoChanged, self)
	var_0_2:addEventListener(var_0_3.EVENT_CUSTOM_ACTIVITY_UPDATE_INFO, self._onActivityInfoChanged, self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_ACTIVITY_COMMON_GETINFOSERVER, self._onActivityInfoChanged, self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS, self._onActivityInfoChanged, self)
	self:updateView()
	self:_startCDTimer()
	self.m_enterTransition:play()
end

function ActivityMainLayer:onUnload()
	var_0_2:dispatchEvent(var_0_3.EVENT_TICK_WEAK_GUIDE_FINISH)
	self:_rmvCDTimer()
end

function ActivityMainLayer:_onActivityInfoChanged(arg_5_1, arg_5_2)
	self:updateView()
end

function ActivityMainLayer:_initView()
	self.m_topBarComp:setResInfoById(15)
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRenderer))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTabListItem))
	self:_updateBg()
end

function ActivityMainLayer:receiveCompEvent(arg_7_1)
	if arg_7_1 == "event_activity_expired" then
		self:updateView()

		return true
	end
end

function ActivityMainLayer:updateView()
	self._activityDataList = self._activityMainLayerData:getSortedActivityDataList()
	self._dailyCostComp = nil

	if #self._activityDataList < 1 then
		self.m_tabList:setNumItems(0)

		return
	end

	local var_8_0 = self:_getItemIndexCpp(self._aTypeSelected, self._aValueSelected)
	local var_8_1 = self:_cppIdx2LuaIdx(var_8_0)

	self._aTypeSelected = self._activityDataList[var_8_1]:getActivityType()
	self._aValueSelected = self._activityDataList[var_8_1]:getActivityValue()

	self:updateTopBar(self._aTypeSelected)
	var_0_1:saveUnlockedFunc((self._activityDataList[var_8_1]:getFunctionId()))
	self:_updateActivityComp(var_8_1)
	self.m_tabList:setNumItems(#self._activityDataList)
	self.m_tabList:addSelection(var_8_0, true)
	self:_checkSpeWeakGuide()
end

function ActivityMainLayer:_checkSpeWeakGuide()
	if self._dailyCostComp and not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.FIRST_DAILY_COST_ENTER) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_DAILY_COST_STEP_2",
			targetBtn = self._dailyCostComp
		})
	end
end

function ActivityMainLayer:_onUpdateCD(arg_10_1, arg_10_2)
	local var_10_0 = var_0_6:getTime()

	if var_10_0 - self._exeTimerLastTime < var_0_0 then
		return
	end

	self._exeTimerLastTime = var_10_0

	for iter_10_0 = 1, self.m_tabList:numChildren() do
		local var_10_1 = self.m_tabList:getChildAt(iter_10_0 - 1)

		if var_10_1.updateCD then
			var_10_1:updateCD()
		end
	end

	for iter_10_1 in self._activityCompManager:ipairs() do
		if iter_10_1:isVisible() and iter_10_1.updateCD then
			iter_10_1:updateCD()
		end
	end
end

function ActivityMainLayer:_onTabListItemRenderer(arg_11_1, arg_11_2)
	if self._activityDataList[arg_11_1 + 1]:getFunctionId() == g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_BOX then
		self._dailyCostComp = arg_11_2
	end

	arg_11_2:updateCell(self._activityDataList[arg_11_1 + 1])
end

function ActivityMainLayer:_onClickTabListItem(arg_12_1)
	if self._activityDataList[self._selectedIndex] then
		local var_12_0 = self._activityCompManager:getComp(self._activityDataList[self._selectedIndex]:getCompName())

		if var_12_0.checkCanChangeState and not var_12_0:checkCanChangeState() then
			self.m_tabList:setSelectedIndex(self:_luaIdx2CppIdx(self._selectedIndex))

			return
		end
	end

	local var_12_1 = arg_12_1:getDataValue()
	local var_12_2 = self:_cppIdx2LuaIdx(var_12_1)
	local var_12_3 = self._activityDataList[var_12_2]:getActivityType()
	local var_12_4 = self._activityDataList[var_12_2]:getActivityValue()

	if self._aTypeSelected == var_12_3 and self._aValueSelected == var_12_4 then
		return
	end

	self._selectedIndex = var_12_2

	self:updateTopBar(var_12_3)

	self._aTypeSelected = var_12_3
	self._aValueSelected = var_12_4

	local var_12_5 = self._activityDataList[var_12_2]:getFunctionId()

	var_0_1:saveUnlockedFunc(var_12_5)

	if var_12_5 == g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY_RECYCLE_BIN then
		self:_updateRetrieveRedPoint()
	end

	local var_12_6 = self.m_tabList:numChildren()
	local var_12_7 = self.m_tabList:itemIndexToChildIndex(var_12_1)

	if var_12_7 >= 0 and var_12_7 < var_12_6 then
		self.m_tabList:getChildAt(var_12_7):refreshRedPoint()
	end

	self:_updateActivityComp(var_12_2)
end

function ActivityMainLayer:updateTopBar(arg_13_1)
	if arg_13_1 == 108 then
		self.m_topBarComp:setResInfoById(133)
	else
		self.m_topBarComp:setResInfoById(15)
	end
end

function ActivityMainLayer:_updateActivityComp(arg_14_1)
	self:_updateBg(self._activityDataList[arg_14_1]:getBg())

	local var_14_0 = self._activityCompManager:getComp(self._activityDataList[arg_14_1]:getCompName())

	var_14_0:updateComp(self._activityDataList[arg_14_1]:getActivityValue(), self._activityDataList[arg_14_1]:getActivityType())
	self.m_topBarComp:setResInfoById(self._activityDataList[arg_14_1]:getTopBarId())

	if var_14_0.playEnterAni then
		var_14_0:playEnterAni()
	end

	for iter_14_0 in self._activityCompManager:ipairs() do
		iter_14_0:setVisible(var_14_0 == iter_14_0)
	end
end

function ActivityMainLayer:_updateBg(arg_15_1)
	if not arg_15_1 or string.len(arg_15_1) == 0 then
		arg_15_1 = "bg/activity/bg_hd_huodong.jpg"
	end

	if self.m_bgLoader then
		self.m_bgLoader:setURL(arg_15_1)
	else
		self.m_bgLoader = self:addBg(arg_15_1, false, nil, 1)
	end
end

function ActivityMainLayer:_startCDTimer()
	if not self._updateCDTimer then
		self:_onUpdateCD()

		self._updateCDTimer = g.core.common.Scheduler:newSchedule(handler(self, self._onUpdateCD), var_0_0)
	end
end

function ActivityMainLayer:_rmvCDTimer()
	if self._updateCDTimer then
		g.core.common.Scheduler:cancelSchedule(self._updateCDTimer)

		self._updateCDTimer = nil
	end
end

function ActivityMainLayer:_cppIdx2LuaIdx(arg_18_1)
	return math.max(1, arg_18_1 + 1)
end

function ActivityMainLayer:_luaIdx2CppIdx(arg_19_1)
	return math.max(0, arg_19_1 - 1)
end

function ActivityMainLayer:_getItemIndexCpp(arg_20_1, arg_20_2)
	if arg_20_1 and arg_20_2 and #self._activityDataList > 1 then
		for iter_20_0, iter_20_1 in ipairs(self._activityDataList) do
			if iter_20_1:getActivityType() == arg_20_1 and iter_20_1:getActivityValue() == arg_20_2 then
				return self:_luaIdx2CppIdx(iter_20_0)
			end
		end
	end

	return 0
end

function ActivityMainLayer:_updateRetrieveRedPoint()
	if #g.core.model.User.resouceBackData:getRetrieveResList() > 0 and not g.core.common.GlobalFunc.isTodayRecord(var_0_5.FRIST_ENTER_RECORD) then
		g.core.common.GlobalFunc.changeTodayRecord(var_0_5.FRIST_ENTER_RECORD, true)
	end
end

return ActivityMainLayer
