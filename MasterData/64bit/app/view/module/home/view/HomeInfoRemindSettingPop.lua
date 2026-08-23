local HomeInfoRemindSettingPop = class("HomeInfoRemindSettingPop", require("app.fairyGUI.home.UI_HomeInfoRemindSettingPop"), function()
	return fgui.GComponent:create({
		resName = "HomeInfoRemindSettingPop",
		pkgName = "home",
		pkgPath = "ui/home/home"
	}, ...)
end)

function HomeInfoRemindSettingPop:ctor(arg_2_1)
	self.m_setList:setVirtual(self)
	self.m_setList:setItemRenderer(handler(self, self._onItemRenderer))

	self._data = {}

	local var_2_0 = {}
	local var_2_1 = g.core.model.User.homeInfoRemindData:getTipSelectData()

	for iter_2_0 = 1, g.core.config.tips_info.getLength() do
		local var_2_2 = g.core.config.tips_info.indexOf(iter_2_0)

		if not var_2_0[var_2_2.function_id] then
			self._data[#self._data + 1] = {
				functionId = var_2_2.function_id,
				selected = not var_2_1[tostring(var_2_2.function_id)]
			}
			var_2_0[var_2_2.function_id] = true
		end
	end

	self:getView():center(true)
end

function HomeInfoRemindSettingPop:onLoad(arg_3_1)
	self.m_setList:setNumItems(#self._data)
end

function HomeInfoRemindSettingPop:_onItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._data[arg_4_1 + 1])
end

function HomeInfoRemindSettingPop:onUnload()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(self._data) do
		if not iter_5_1.selected then
			var_5_0[#var_5_0 + 1] = iter_5_1.functionId
		end
	end

	g.core.model.User.homeInfoRemindData:updateTipSelect(var_5_0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_HOME_REMIND_TIP_SETTING_CHANGED, false)
end

return HomeInfoRemindSettingPop
