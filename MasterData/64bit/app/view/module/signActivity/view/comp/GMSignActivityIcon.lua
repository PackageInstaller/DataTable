local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.signActivityData
local GMSignActivityIcon = class("GMSignActivityIcon", require("app.fairyGUI.signActivity.UI_GMSignActivityIcon"))

function GMSignActivityIcon:ctor()
	self._subId = 0
	self._goods = nil

	self:addClickListener(handler(self, self._onClick))
end

function GMSignActivityIcon:updateDayIcon(arg_2_1, arg_2_2)
	self._info = arg_2_1
	self._subId = arg_2_2
	self._goods = var_0_0:convert({
		type = arg_2_1.reward_type,
		value = arg_2_1.reward_value
	})

	if self._goods then
		self.m_qualityLoader:setURL(g.core.common.Path:getTitleQualityIcon(self._goods.quality))
		self.m_iconLoader:setURL(self._goods.icon)
		self.m_numTxt:setText("×" .. arg_2_1.reward_size)
	end

	self:_updateStateCtrl()
end

function GMSignActivityIcon:updateDayNumber(arg_3_1)
	self.m_dayIcon:setURL(arg_3_1)
end

function GMSignActivityIcon:playSignedEffect(arg_4_1)
	self:_updateStateCtrl()
	self.m_getTransition:play(function()
		if arg_4_1 then
			arg_4_1()
		end
	end)
end

function GMSignActivityIcon:_updateStateCtrl()
	local var_6_0 = var_0_1:getSignSvrDataBySubId(self._subId)

	if var_6_0 then
		self.m_stateController:setSelectedIndex(var_0_1:getIsSigned(var_6_0.id, self._info.day) and 1 or 0)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function GMSignActivityIcon:_onClick()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return GMSignActivityIcon
