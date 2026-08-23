local NewSlgMainUIComp = class("NewSlgMainUIComp", require("app.fairyGUI.newSlg.UI_NewSlgMainUIComp"))

function NewSlgMainUIComp:ctor()
	self._compTeamInfo = self:getChild("Comp_team_info")
	self._compMiniMap = self:getChild("Comp_mini"):getChild("miniMapComp")
	self._compB = self:getChild("Comp_b")

	self:addListen(self._compB)
	self:getChild("Comp_gather"):setVisible(false)
	self:getChild("Comp_gather2"):setVisible(false)

	self._compGather = self:getChild("Comp_gather")

	if g.core.model.User.newSlgData:getSName() == "S2" then
		self._compGather = self:getChild("Comp_gather2")
	end

	self._searchComp = self:getChild("Comp_search")

	self._searchComp:setVisible(false)

	self._txtEndTime = self:getChild("Txt_endTime")
	self._compPeriod = self:getChild("Comp_period")
	self._btnPass = self:getChild("Btn_battlePass")

	self._btnPass:addClickListener(handler(self, self._onClickBtnPass))
	self.m_Btn_countDown:addClickListener(handler(self, self._onClickFarmCountDown))
	self.m_farmS2:setVisible(g.core.model.User.newSlgData:getSName() == "S2")
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
end

function NewSlgMainUIComp:_onClickFarmCountDown()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = 396
	}), {
		touchDisappear = true
	})
end

function NewSlgMainUIComp:setMap(arg_3_1)
	self._map = arg_3_1

	self._compMiniMap:setMap(arg_3_1)
end

function NewSlgMainUIComp:_onClickBtnPass()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_BP, {
		activityId = g.core.model.User.newSlgData:getCommonPassCardActId()
	})
end

function NewSlgMainUIComp:_updateSch()
	g.core.utils.Tools.newSlgFunc.addSchedule({
		key = "NewSlgEnd_updateTime",
		startTime = g.core.model.User.newSlgData:getActStartTime(),
		endTime = g.core.model.User.newSlgData:getActEndTime()
	})
end

function NewSlgMainUIComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETCITYSHOWDATA, handler(self, self._onGetCityShowData), self)
	self:_updateSch()
end

function NewSlgMainUIComp:_onSchedule(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = g.core.common.ServerTime:getTime()

	if arg_7_3.key == "NewSlgGatherComp_schedule" then
		self._compGather:updateView()
	elseif arg_7_3.key == "NewSlgEnd_updateTime" then
		self:updateEndTime()
	end
end

function NewSlgMainUIComp:updateView()
	self._compB:updateView()
end

function NewSlgMainUIComp:_onTouchBegin(arg_9_1)
	self:dispatchCompEvent("NewSlgMainUIComp_onTouchBegin")
end

function NewSlgMainUIComp:receiveCompEvent(arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or {}

	if arg_10_1 == "NewSlgMainBComp_onClickBtnGather" then
		self:setCompGatherVis(not self._compGather:isVisible())
	elseif arg_10_1 == "NewSlg_SearchBtn_Click" then
		self:setCompSearchVis(not self._searchComp:isVisible(), arg_10_2)
	else
		self:dispatchCompEvent(arg_10_1, arg_10_2)
	end
end

function NewSlgMainUIComp:hideUI()
	self:setCompSearchVis(false)
	self:setCompGatherVis(false)
end

function NewSlgMainUIComp:getCompSearchVis()
	return self._searchComp:isVisible()
end

function NewSlgMainUIComp:setCompSearchVis(arg_13_1, arg_13_2)
	if self._searchComp:isVisible() == arg_13_1 then
		return
	end

	if arg_13_1 then
		self._searchComp:setVisible(true)
		self:getTransition("sousuo_enter"):play()
		self._searchComp:updateView(arg_13_2)
	else
		local var_13_0 = self._searchComp

		self:getTransition("sousuo_back"):play(function()
			var_13_0:setVisible(false)
		end)
	end
end

function NewSlgMainUIComp:_onGetCityShowData()
	self._compGather:setVis(true)
	self._compGather:updateView()
end

function NewSlgMainUIComp:setCompGatherVis(arg_16_1)
	if arg_16_1 then
		if g.core.model.User.newSlgData:getSName() == "S2" then
			if g.core.model.User.newSlgData:getCityPeriod() == g.core.const.ConstMgr.NewSlgConst.battle then
				self:_getCityShowData()
				self._compGather:setVis(true)
				self._compGather:updateView()
			else
				local var_16_0 = g.core.model.User.newSlgData:getAllianceData().declareCities or {}

				if #var_16_0 == 0 then
					self._compGather:setVis(true)
					self._compGather:updateView()
				else
					g.core.network.GameNetProxy:send_C2S_NewSlg_GetCityShowData({
						city_id = var_16_0
					})
				end
			end
		else
			self._compGather:setVis(true)
			self._compGather:updateView()
		end
	else
		self._compGather:setVis(false)
	end
end

function NewSlgMainUIComp:_getCityShowData()
	local var_17_0 = g.core.model.User.newSlgData:getSelfDeclaredCities()

	for iter_17_0, iter_17_1 in ipairs((g.core.model.User.newSlgData:getOccupiedCities())) do
		if #g.core.model.User.newSlgData:getCityDeclaredAlliances(iter_17_1) > 0 then
			table.insert(var_17_0, iter_17_1)
		end
	end

	if #var_17_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_NewSlg_GetCityShowData({
			city_id = var_17_0
		})
	end
end

function NewSlgMainUIComp:updateGatePassBtn()
	self._compB:updatePassGateBtn()
end

function NewSlgMainUIComp:updateEndTime()
	local var_19_0 = g.core.common.ServerTime:getTime()
	local var_19_1 = g.core.model.User.newSlgData:getActEndTime()

	self._txtEndTime:setText((g.core.common.ServerTime:secondToDHString(var_19_1 - var_19_0)))
	self._compPeriod:updateView()

	if var_19_1 <= var_19_0 then
		g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgEnd_updateTime")
		g.core.module.ModuleManager:replaceModule(g.view.entrance.NEW_SLG_END_SHOW_LAYER)
	elseif var_19_0 >= g.core.model.User.newSlgData:getSettleStartTime() then
		self:getChild("Group_right"):setVisible(false)
	end
end

return NewSlgMainUIComp
