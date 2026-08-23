local var_0_0 = g.core.model.User.userBackData
local ActivityUserBackResourceItem = class("ActivityUserBackResourceItem", require("app.fairyGUI.activity.UI_ActivityUserBackResourceItem"))

function ActivityUserBackResourceItem:ctor()
	self:_initBtn()
end

function ActivityUserBackResourceItem:_initBtn()
	self.m_itemIcon:addClickListener(handler(self, self._onItemIconClick))
	self.m_getAwardBtn:addClickListener(handler(self, self._onGetAwardBtnClick))
end

function ActivityUserBackResourceItem:updateCell(arg_3_1)
	if not arg_3_1 then
		return
	end

	self._resourceData = arg_3_1

	local var_3_0 = g.core.common.Goods:convert(arg_3_1)

	self.m_numText:setText(arg_3_1.size)
	self.m_nameText:setText(var_3_0.name)
	self.m_itemIcon:setURL(var_3_0.icon)

	local var_3_1 = var_0_0:getResourceActionValueByDay(arg_3_1.day, arg_3_1.action)

	self.m_progBar:setPercent({
		cur = var_3_1,
		max = arg_3_1.actionValue
	})
	self.m_progText:setText(var_3_1 .. "/" .. arg_3_1.actionValue)
	self.m_actionText:setText(g.core.lang:getByString(arg_3_1.description, {
		num = arg_3_1.actionValue
	}))

	if var_0_0:isResourceGet(arg_3_1.day, arg_3_1.id) then
		self.m_getStateController:setSelectedIndex(2)
	elseif var_3_1 >= arg_3_1.actionValue then
		self.m_getStateController:setSelectedIndex(1)
	else
		self.m_getStateController:setSelectedIndex(0)
	end
end

function ActivityUserBackResourceItem:_onItemIconClick()
	if not self._resourceData then
		return
	end

	g.core.common.GlobalFunc.pushInfoPop(self._resourceData)
end

function ActivityUserBackResourceItem:_onGetAwardBtnClick()
	if not self._resourceData then
		return
	end

	g.core.network.GameNetProxy:send_C2S_UserBack_GetBackRes({
		day = self._resourceData.day,
		target_id = self._resourceData.id
	})
end

return ActivityUserBackResourceItem
