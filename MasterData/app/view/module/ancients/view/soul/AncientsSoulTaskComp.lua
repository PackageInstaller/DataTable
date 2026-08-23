local AncientsSoulTaskComp = class("AncientsSoulTaskComp", require("app.fairyGUI.ancients.UI_AncientsSoulTaskComp"))
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum

function var_0_0:ctor()
	self._compRedPoint1 = self.m_Comp_tab1:getChild("ComRedPoint")
	self._compRedPoint2 = self.m_Comp_tab2:getChild("ComRedPoint")

	self.m_List_task:setVirtual(self)
	self.m_List_task:setItemRenderer(handler(self, self._onRenderListTaskCell))
	self.m_task_groupController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCtrlTaskGroupChange))

	self._tabIndex = 0
end

function var_0_0:onLoad()
	self._tabChange = true

	var_0_2:dispatchEvent(var_0_3.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_Comp_tab1
	})
	var_0_2:dispatchEvent(var_0_3.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_Comp_tab2
	})
end

function var_0_0:_onCtrlTaskGroupChange()
	self._tabChange = true

	local var_3_0 = self.m_task_groupController:getSelectedIndex()

	if self._tabIndex == var_3_0 then
		return
	end

	self._tabIndex = var_3_0

	self:updateView()
end

function var_0_0:updateView()
	if g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.COOP then
		self.m_is_openController:setSelectedIndex(0)

		return
	end

	self.m_is_openController:setSelectedIndex(1)

	self._taskArr = g.core.model.User.ancientsData:getTaskInfoArr(self._tabIndex + 1)

	self:_sort()
	self.m_List_task:setNumItems(#self._taskArr)

	if self._tabChange then
		self.m_List_task:transitionShowCells("enter_up", 0.03)

		self._tabChange = false
	end
end

function var_0_0:_sort()
	table.sort(self._taskArr, function(arg_6_0, arg_6_1)
		local var_6_0 = g.core.model.User.ancientsData:getTaskState(arg_6_0)
		local var_6_1 = g.core.model.User.ancientsData:getTaskState(arg_6_1)

		if var_6_0 ~= var_6_1 then
			return var_6_0 < var_6_1
		end

		if arg_6_0.order ~= arg_6_1.order then
			return arg_6_0.order < arg_6_1.order
		end

		return arg_6_0.id < arg_6_1.id
	end)
end

function var_0_0:_onRenderListTaskCell(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._taskArr[arg_7_1 + 1])
end

return var_0_0
