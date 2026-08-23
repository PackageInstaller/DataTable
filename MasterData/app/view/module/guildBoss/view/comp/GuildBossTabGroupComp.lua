local var_0_0 = g.core.model.User.guildBossData
local GuildBossTabGroupComp = class("GuildBossTabGroupComp", require("app.fairyGUI.guildBoss.UI_GuildBossTabGroupComp"))
local var_0_2 = 0.1

function GuildBossTabGroupComp:ctor()
	self._curTabIndex = 0
	self._nextWeek = 1
	self._infoList = {}

	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))

	self._infoList = var_0_0:getInfoList()

	for iter_1_0 = #self._infoList, 1, -1 do
		local var_1_0

		if self._infoList[iter_1_0].info.is_open and self._infoList[iter_1_0].info.is_open == 1 then
			self["m_tab" .. iter_1_0]:setVisible(true)
			self["m_tab" .. iter_1_0]:playEnterEffect(0 * var_0_2)

			var_1_0 = 0 + 1
		else
			self["m_tab" .. iter_1_0]:setVisible(false)
		end
	end
end

function GuildBossTabGroupComp:setWeekDay(arg_2_1)
	self._infoList = var_0_0:getInfoList()

	local var_2_0 = false
	local var_2_1 = 0

	for iter_2_0 = 1, #self._infoList do
		self["m_tab" .. iter_2_0]:updateComp(self._infoList[iter_2_0].info, false)

		if self._infoList[iter_2_0].info.is_open and self._infoList[iter_2_0].info.is_open == 1 then
			self["m_tab" .. iter_2_0]:setVisible(true)

			if arg_2_1 <= iter_2_0 and not var_2_0 then
				var_2_0 = true
				self._nextWeek = iter_2_0

				self.m_tabController:setSelectedIndex(self._nextWeek - 1)
			end

			if var_2_1 == 0 then
				var_2_1 = iter_2_0
			end
		else
			self["m_tab" .. iter_2_0]:setVisible(false)
		end
	end

	if not var_2_0 then
		self._nextWeek = var_2_1

		self.m_tabController:setSelectedIndex(var_2_1 - 1)
	end

	self["m_tab" .. self._nextWeek]:updateComp(self._infoList[self._nextWeek].info, true)

	return self._nextWeek
end

function GuildBossTabGroupComp:_onChangeTabCtrl()
	self._curTabIndex = self.m_tabController:getSelectedIndex()

	self:dispatchCompEvent("GuildBossTabGroupComp_change", {
		index = self._curTabIndex + 1
	})
	self["m_tab" .. self._curTabIndex + 1]:showClickEffect()
end

return GuildBossTabGroupComp
