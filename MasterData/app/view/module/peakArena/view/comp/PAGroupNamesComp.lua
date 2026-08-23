local var_0_0 = {
	CLOSE = 0,
	OPEN = 1
}
local var_0_1 = g.core.const.ConstMgr.PeakArenaConst
local var_0_2 = g.core.model.User.peakArenaData
local PAGroupNamesComp = class("PAGroupNamesComp", require("app.fairyGUI.peakArena.UI_PAGroupNamesComp"))

function PAGroupNamesComp:ctor()
	self._groupId = var_0_2:getDefaultShowGroupId()

	self.m_title:setText(var_0_2:getGroupStruct(self._groupId):getName())
	self.m_bgLoader:addClickListener(handler(self, self._onclickBgLoader))
	self.m_groupList:setVirtual()
	self.m_groupList:setItemRenderer(handler(self, self._onGroupListRenderer))
	self.m_groupList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickGroupItem))
	self.m_groupList:setNumItems(var_0_1.GROUP_NUM)
	self.m_openController:setSelectedIndex(var_0_0.CLOSE)
end

function PAGroupNamesComp:updateComp(arg_2_1)
	if self._groupId == arg_2_1 then
		return
	elseif arg_2_1 == var_0_1.FINAL_GROUP_ID then
		-- block empty
	else
		self._groupId = arg_2_1

		self.m_title:setText(var_0_2:getGroupStruct(arg_2_1):getName())
	end
end

function PAGroupNamesComp:getSelectedGroupId()
	return self._groupId
end

function PAGroupNamesComp:_onGroupListRenderer(arg_4_1, arg_4_2)
	arg_4_2:setTitle(var_0_2:getGroupStruct(arg_4_1 + 1):getName())

	local var_4_0 = arg_4_2:getController("last")

	if arg_4_1 + 1 == var_0_1.GROUP_NUM then
		var_4_0:setSelectedIndex(1)
	else
		var_4_0:setSelectedIndex(0)
	end
end

function PAGroupNamesComp:_onClickGroupItem(arg_5_1)
	local var_5_0 = arg_5_1:getDataValue() + 1

	if var_5_0 ~= self._groupId then
		self:dispatchCompEvent("ClickGroupNameItem", var_5_0)
	end

	self.m_openController:setSelectedIndex(var_0_0.CLOSE)
end

function PAGroupNamesComp:_onclickBgLoader()
	if self.m_openController:getSelectedIndex() == var_0_0.CLOSE then
		self.m_openController:setSelectedIndex(var_0_0.OPEN)
	else
		self.m_openController:setSelectedIndex(var_0_0.CLOSE)
	end
end

return PAGroupNamesComp
