local ActivityRetrieveDebugPop = class("ActivityRetrieveDebugPop", require("app.fairyGUI.activity.UI_ActivityRetrieveDebugPop"), function()
	return fgui.GComponent:create({
		resName = "ActivityRetrieveDebugPop",
		pkgPath = "ui/activity/activity",
		pkgName = "activity"
	})
end)

function ActivityRetrieveDebugPop:ctor(arg_2_1)
	self._data = arg_2_1

	self:showAtCenter()
	self.m_dataList:setVirtual()
	self.m_dataList:setItemRenderer(handler(self, self._onDataListItemRender))
	self:_initMainView()
end

function ActivityRetrieveDebugPop:_initMainView()
	self._name = g.core.config.resource_recovery_info.get(self._data.id).name

	self:_sortResourceBackData()
	self.m_dataList:setNumItems(#self._data.day_res)
end

function ActivityRetrieveDebugPop:_sortResourceBackData()
	table.sort(self._data.day_res, function(arg_5_0, arg_5_1)
		if arg_5_0.daily_zero_time ~= arg_5_1.daily_zero_time then
			return arg_5_0.daily_zero_time > arg_5_1.daily_zero_time
		end

		return false
	end)
end

function ActivityRetrieveDebugPop:_onDataListItemRender(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._data.day_res[arg_6_1 + 1], self._name)
end

return ActivityRetrieveDebugPop
