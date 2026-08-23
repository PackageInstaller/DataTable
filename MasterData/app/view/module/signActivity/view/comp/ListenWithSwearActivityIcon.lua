local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.signActivityData
local ListenWithSwearActivityIcon = class("ListenWithSwearActivityIcon", require("app.fairyGUI.signActivity.UI_ListenWithSwearActivityIcon"))

function ListenWithSwearActivityIcon:ctor()
	self._subId = 0
	self._goods = nil

	self:addClickListener(handler(self, self._onClick))
end

function ListenWithSwearActivityIcon:updateDayIcon(arg_2_1, arg_2_2)
	self._info = arg_2_1
	self._subId = arg_2_2
	self._goods = var_0_0:convert({
		type = arg_2_1.reward_type,
		value = arg_2_1.reward_value
	})

	if self._goods then
		self.m_iconLoader:setURL(self._goods.icon)
		self.m_numTxt:setText("×" .. arg_2_1.reward_size)
	end

	self:_updateStateCtrl()
end

function ListenWithSwearActivityIcon:playSignedEffect(arg_3_1)
	self:_updateStateCtrl()
	self.m_effReceive:addEffectSpine({
		remove = true,
		name = "eff_ui_activity_sdOLReceive",
		isLoop = false
	})
	self.m_getTransition:play(function()
		if arg_3_1 then
			arg_3_1()
		end
	end)
end

function ListenWithSwearActivityIcon:_updateStateCtrl()
	local var_5_0 = var_0_1:getSignSvrDataBySubId(self._subId)

	if var_5_0 then
		self.m_stateController:setSelectedIndex(var_0_1:getIsSigned(var_5_0.id, self._info.day) and 1 or 0)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function ListenWithSwearActivityIcon:_onClick()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return ListenWithSwearActivityIcon
