local var_0_0 = g.core.model.User.domainData
local DomainTurnGameIcon = class("DomainTurnGameIcon", require("app.fairyGUI.domainDungeon.UI_DomainTurnGameIcon"))

function DomainTurnGameIcon:lightStateChange(arg_1_1)
	self.m_lightController:setSelectedIndex(arg_1_1 and 1 or 0)
end

function DomainTurnGameIcon:playFinish(arg_2_1)
	self.m_eff:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_domainDungeon_rotateget_" .. arg_2_1
	})
end

function DomainTurnGameIcon:_onClickIcon()
	if self._clickData then
		g.core.common.GlobalFunc.pushInfoPop(self._clickData)
	end
end

function DomainTurnGameIcon:updateRewardItem(arg_4_1, arg_4_2)
	local var_4_0 = g.core.common.Goods:convert(arg_4_2)

	self:setIcon(var_4_0.icon)

	if var_4_0.type == g.core.common.Goods.TYPE_FRAGMENT then
		self.m_isFragController:setSelectedIndex(1)
	else
		self.m_isFragController:setSelectedIndex(0)
	end

	self.m_bgLoader:setURL(var_0_0:getDungeonResource(arg_4_1, "pic_mnly_zhuanpan03.png"))
	self.m_selectLoader:setURL(var_0_0:getDungeonResource(arg_4_1, "pic_mnly_zhuanpan04.png"))
end

return DomainTurnGameIcon
