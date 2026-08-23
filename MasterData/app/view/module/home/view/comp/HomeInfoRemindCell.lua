local HomeConst = require("app.view.module.home.const.HomeConst")
local HomeInfoRemindOneKeyCfgData = require("app.view.module.home.model.HomeInfoRemindOneKeyCfgData")
local HomeInfoRemindCell = class("HomeInfoRemindCell", require("app.fairyGUI.home.UI_HomeInfoRemindCell"))

function HomeInfoRemindCell:ctor()
	self._data = nil
	self._list = {}
	self.m_buttonController = self:getController("button")

	self:_initCell()
end

function HomeInfoRemindCell:_initCell()
	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChanged))
	self.m_subList:setVirtual(self)
	self.m_subList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_subList:setItemProvider(handler(self, self._onItemProvider))
	self.m_subList:doFairyBatching(false)
end

function HomeInfoRemindCell:onLoad()
	self:newSchedule(handler(self, self.updateSubTimer), 1)
end

function HomeInfoRemindCell:updateItem(arg_4_1)
	self._data = arg_4_1

	self:setTitle(g.core.config.function_info.get(arg_4_1.functionId).name)

	local var_4_0 = {}
	local var_4_1 = {}

	self._subNum = 0

	for iter_4_0, iter_4_1 in ipairs(self._data.list) do
		local var_4_2 = iter_4_1:getCfg()
		local var_4_3 = var_4_0[var_4_2.type]

		if not var_4_0[var_4_2.type] then
			var_4_0[var_4_2.type] = {}
			var_4_1[#var_4_1 + 1] = var_4_2.type
			var_4_3 = var_4_0[var_4_2.type]

			if var_4_2.template_type == 1 then
				var_4_3[1] = g.core.lang:get(429570 + var_4_2.type)
				self._subNum = self._subNum + 1
			end
		end

		var_4_3[#var_4_3 + 1] = iter_4_1
		self._subNum = self._subNum + 1
	end

	table.sort(var_4_1, function(arg_5_0, arg_5_1)
		return arg_5_0 < arg_5_1
	end)

	self._list = {}

	for iter_4_2, iter_4_3 in ipairs(var_4_1) do
		for iter_4_4, iter_4_5 in ipairs(var_4_0[iter_4_3]) do
			self._list[#self._list + 1] = iter_4_5
		end
	end
end

function HomeInfoRemindCell:_onItemRenderer(arg_6_1, arg_6_2)
	if type(self._list[arg_6_1 + 1]) == "string" then
		arg_6_2:setTitle(self._list[arg_6_1 + 1])
	else
		arg_6_2:updateDetailCell(self._list[arg_6_1 + 1])
	end
end

function HomeInfoRemindCell:_onItemProvider(arg_7_1)
	if type(self._list[arg_7_1 + 1]) == "string" then
		return "ui://home/HomeInfoRemindTitleCell"
	else
		return "ui://home/HomeInfoRemindDetailCell"
	end
end

function HomeInfoRemindCell:_onChanged()
	if not self._subNum or self._subNum == 0 then
		return
	end

	self._waitState = true

	local var_8_0 = self.m_buttonController:getSelectedIndex()

	if not self._selectedIndex then
		if var_8_0 == 1 then
			self:_getTransition():play()
			self:onExpand()
		end
	else
		local var_8_1 = self:_getTransition()

		if var_8_0 == 1 then
			var_8_1:play()
			self:onExpand()
		else
			var_8_1:playReverse()
			self:onCloseExpand()
		end
	end

	self._selectedIndex = var_8_0
end

function HomeInfoRemindCell:onExpand()
	self.m_subList:setVisible(true)
	self.m_subList:setNumItems(self._subNum)
	self.m_subList:resizeToFit(self._subNum)

	self._expandStatue = 2
end

function HomeInfoRemindCell:onCloseExpand()
	self.m_subList:setNumItems(0)
	self.m_subList:setVisible(false)

	self._expandStatue = 1
end

function HomeInfoRemindCell:_getTransition()
	local var_11_0 = "m_sizeMinTransition"

	if self._subNum > 3 then
		var_11_0 = "m_sizeMaxTransition"
	end

	local var_11_1 = self[var_11_0]

	self:_setTransitionTimeScale(var_11_0)
	self:_setTransitionEndSize(var_11_1)

	return var_11_1
end

function HomeInfoRemindCell:_setTransitionTimeScale(arg_12_1)
	self[arg_12_1]:setTimeScale(arg_12_1 == "m_sizeMinTransition" and self._subNum or self._subNum / 4)
end

function HomeInfoRemindCell:_setTransitionEndSize(arg_13_1)
	arg_13_1:setValue("endSize", {
		self:getSize().width,
		87 + self.m_subList:getSize().height
	})
end

function HomeInfoRemindCell:updateSubTimer()
	for iter_14_0, iter_14_1 in ipairs((self.m_subList:getChildren())) do
		if iter_14_1.updateTime then
			iter_14_1:updateTime()
		end
	end
end

return HomeInfoRemindCell
