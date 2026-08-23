local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.signActivityData
local var_0_3 = g.core.config.activity_login_group_info
local LindellSignActivityIcon = class("LindellSignActivityIcon", require("app.fairyGUI.signActivity.UI_LindellSignActivityIcon"))

function LindellSignActivityIcon:ctor()
	self._subId = 0
	self._goods = nil

	self:addClickListener(handler(self, self._onClick))
end

function LindellSignActivityIcon:updateDayIcon(arg_2_1, arg_2_2)
	self._info = arg_2_1
	self._subId = arg_2_2

	local var_2_0 = var_0_3.get(arg_2_2)

	if var_2_0 then
		self._groupId = var_2_0.group
	end

	self._goods = var_0_0:convert({
		type = arg_2_1.reward_type,
		value = arg_2_1.reward_value
	})

	if self._goods then
		local var_2_1, var_2_2 = g.core.common.Path:getEquipIconQualityBg1(self._goods.quality)

		self.m_qualityLoader_1:setURL(var_2_2)
		self.m_qualityLoader_2:setURL(var_2_2)

		if self._info.day == var_0_1:getSignActivityDayCount(self._groupId) then
			self.m_iconLoader:setIcon(self._goods.icon)
		else
			self.m_iconLoader:setURL(self._goods.icon)
		end

		self.m_numTxt:setText("×" .. arg_2_1.reward_size)
	end

	self:_updateStateCtrl()
end

function LindellSignActivityIcon:playSignedEffect(arg_3_1)
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

function LindellSignActivityIcon:_updateStateCtrl()
	local var_5_0 = var_0_1:getSignSvrDataBySubId(self._subId)

	if var_5_0 then
		self.m_stateController:setSelectedIndex(var_0_1:getIsSigned(var_5_0.id, self._info.day) and 1 or 0)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function LindellSignActivityIcon:_onClick()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return LindellSignActivityIcon
