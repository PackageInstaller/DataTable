local var_0_0 = 1
local var_0_1 = g.core.model.User.cultivateDataMgr
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.model.User.commanderWorldData
local var_0_5 = g.core.model.User.doubleElevenData
local var_0_6 = g.core.common.ModuleUnlock
local var_0_7 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_8 = require("app.view.module.home.const.HomeConst").OTHER_BTN
local HomeOtherComp = class("HomeOtherComp", require("app.fairyGUI.home.UI_HomeOtherComp"))

function HomeOtherComp:ctor()
	self._mySchedulerId = nil
	self._btnPool = {}
	self._btnUsedList = {}
end

function HomeOtherComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT, handler(self, self._onUpdateActivity), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_INFO, handler(self, self._onUpdateActivity), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onUpdateActivity), self)
	self:_onUpdateActivity()
end

function HomeOtherComp:_onUpdateActivity()
	if var_0_6:isModuleUnlock(var_0_7.COMMANDER_WORLD) then
		self:onUpdateCommanderWorldBtn()
		self.m_commanderWorldBtn:updateCell(var_0_8.TYPE_COMMANDER_WORLD)
	else
		self.m_commanderWorldBtn:setVisible(false)
	end

	if var_0_6:isModuleUnlock(var_0_7.DOUBLE_ELEVEN) then
		self:onUpdateDoubleElevenBtn()
		self.m_doubleElevenBtn:updateCell(var_0_8.TYPE_DOUBLE_ELEVEN)
	else
		self.m_doubleElevenBtn:setVisible(false)
	end

	local var_3_0 = 0

	if self.m_commanderWorldBtn:isVisible() then
		self.m_commanderWorldBtn:setPosition(var_3_0 * 150 + 90, 60)

		var_3_0 = var_3_0 + 1
	end

	if self.m_doubleElevenBtn:isVisible() then
		self.m_doubleElevenBtn:setPosition(var_3_0 * 150 + 90, 60)

		var_3_0 = var_3_0 + 1
	end

	self:clearBtnList()

	for iter_3_0, iter_3_1 in ipairs((var_0_1:getCulActivityLocationAct(2))) do
		if iter_3_1:isInActivityShowTime() then
			local var_3_1 = self:getOtherBtn()

			if iter_3_1:getActivityCfg().type == CultivateConst.ACTIVITY_TYPE.WITCH then
				var_3_1:updateCell(var_0_8.TYPE_WITCH, iter_3_1)
			else
				var_3_1:updateCell(var_0_8.TYPE_CULTIVATE, iter_3_1)
			end

			var_3_1:setPosition(var_3_0 * 150 + 90, 60)

			var_3_0 = var_3_0 + 1
		end
	end

	self:setSize(var_3_0 * 150 + 30, 121)

	if var_3_0 > 0 and not self._mySchedulerId then
		self:updateListTime()

		self._mySchedulerId = self:newSchedule(handler(self, self.onUpdateScheduler), var_0_0)
	else
		self:cancelSchedule(self._mySchedulerId)

		self._mySchedulerId = nil
	end
end

function HomeOtherComp:getOtherBtn()
	if not next(self._btnPool) then
		local var_4_0 = fgui.UIPackage:createObject("home", "HomeOtherBtn")

		table.insert(self._btnUsedList, var_4_0)
		self:addChild(var_4_0)

		return var_4_0
	end

	local var_4_1 = table.remove(self._btnPool)

	table.insert(self._btnUsedList, var_4_1)
	var_4_1:setVisible(true)

	return var_4_1
end

function HomeOtherComp:clearBtnList()
	for iter_5_0, iter_5_1 in ipairs(self._btnUsedList) do
		table.insert(self._btnPool, iter_5_1)
		iter_5_1:setVisible(false)
	end

	self._btnUsedList = {}
end

function HomeOtherComp:onUpdateScheduler(arg_6_1)
	self:_onUpdateCommanderWorldTime()
	self:_onUpdateDoubleElevenTime()
	self:updateListTime()
end

function HomeOtherComp:updateListTime()
	for iter_7_0, iter_7_1 in ipairs(self._btnUsedList) do
		iter_7_1:updateOtherBtnTime()
	end
end

function HomeOtherComp:onUpdateCommanderWorldBtn()
	local var_8_0 = var_0_4:checkActivityOpen()

	self.m_commanderWorldBtn:setVisible(var_8_0)

	if var_8_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_commanderWorldBtn
		})
		self:_onUpdateCommanderWorldTime()
	end
end

function HomeOtherComp:onUpdateDoubleElevenBtn()
	local var_9_0 = var_0_5:checkActivityOpen()

	self.m_doubleElevenBtn:setVisible(var_9_0)

	if var_9_0 then
		local var_9_1 = var_0_5:getCurActivityType()

		if var_9_1 == 1 or var_9_1 == 14 then
			self.m_doubleElevenBtn:getChild("icon"):setURL("ui://text_new/txt_hd_11_home")
		elseif var_9_1 == 2 then
			self.m_doubleElevenBtn:getChild("icon"):setURL("ui://text_new/txt_hd_11_home_1")
		elseif var_9_1 == 4 then
			self.m_doubleElevenBtn:getChild("icon"):setURL("ui://text_new/txt_hd_halfyear_home")
		elseif var_9_1 == 6 or var_9_1 == 7 then
			self.m_doubleElevenBtn:getChild("icon"):setURL("ui://text_new/txt_hd_xrcz_home")
		elseif var_9_1 == 8 then
			self.m_doubleElevenBtn:getChild("icon"):setURL("ui://text_new/txt_hd_znth_home")
		elseif var_9_1 == 9 or var_9_1 == 11 then
			self.m_doubleElevenBtn:getChild("icon"):setURL("ui://text_new/txt_hd_1.5znth_home")
		elseif var_9_1 == 12 then
			self.m_doubleElevenBtn:getChild("icon"):setURL("ui://text_new/txt_hd_616_home")
		elseif var_9_1 == 13 then
			self.m_doubleElevenBtn:getChild("icon"):setURL("ui://text_new/txt_hd_erznth_home")
		elseif var_9_1 == 15 then
			self.m_doubleElevenBtn:getChild("icon"):setURL("ui://text_new/txt_hd_td_grateful_home")
		elseif var_9_1 == 19 then
			self.m_doubleElevenBtn:getChild("icon"):setURL("ui://text_new/txt_hd_xnth_home")
		elseif var_9_1 == 20 then
			self.m_doubleElevenBtn:getChild("icon"):setURL("ui://text_new/txt_hd_xcznth_home")
		elseif var_9_1 == 24 then
			self.m_doubleElevenBtn:getChild("icon"):setURL("ui://text_new/txt_hd_edwznth_home")
		elseif var_9_1 == 25 or var_9_1 == 26 then
			self.m_doubleElevenBtn:getChild("icon"):setURL("ui://text_new/txt_hd_xsznth_home")
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_doubleElevenBtn
		})
		self:_onUpdateDoubleElevenTime()
	end
end

function HomeOtherComp:_onUpdateCommanderWorldTime()
	if not self.m_commanderWorldBtn:isVisible() then
		return
	end

	local var_10_0, var_10_1 = var_0_4:getEndTime()

	if var_10_0 > var_0_3:getTime() then
		if var_10_1 then
			self.m_commanderWorldBtn:updateCD(var_10_1)
		else
			self.m_commanderWorldBtn:updateCD(var_0_3:getLeftSecondsString(var_10_0))
		end
	elseif not var_10_1 then
		self.m_commanderWorldBtn:setVisible(false)
	end
end

function HomeOtherComp:_onUpdateDoubleElevenTime()
	if not self.m_doubleElevenBtn:isVisible() then
		return
	end

	local var_11_0, var_11_1 = var_0_5:getEndTime()

	if var_11_0 > var_0_3:getTime() then
		if var_11_1 then
			self.m_doubleElevenBtn:updateCD(var_11_1)
		else
			self.m_doubleElevenBtn:updateCD(var_0_3:getLeftSecondsString(var_11_0))
		end
	elseif not var_11_1 then
		self.m_doubleElevenBtn:setVisible(false)
	end
end

function HomeOtherComp:onUnload()
	self:cancelSchedule(self._mySchedulerId)

	self._mySchedulerId = nil
end

return HomeOtherComp
