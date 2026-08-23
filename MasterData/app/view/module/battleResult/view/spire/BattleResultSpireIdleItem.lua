local BattleResultSpireIdleItem = class("BattleResultSpireIdleItem", require("app.fairyGUI.battleResult.UI_BattleResultSpireIdleItem"))

function BattleResultSpireIdleItem:ctor()
	self.m_timeTxt:setText(g.core.lang:get(432018, {
		time = g.core.config.spire_parameter_info.get(g.core.const.ConstMgr.SpireConst.PARAMETER_IDS.IDLE_SPEED_TIME).parameter / 3600
	}))
end

function BattleResultSpireIdleItem:updateIdleItem(arg_2_1)
	self.m_speedTxt:setText(arg_2_1.size)
	self.m_icon:setURL((g.core.common.Path:getIconByTypeValue(arg_2_1.type, arg_2_1.value, true)))
	self:_checkAndFixSize()
end

function BattleResultSpireIdleItem:_checkAndFixSize()
	local var_3_0 = self.m_widthComp:getSize()

	var_3_0.width = self.m_timeTxt:getPosition().x + self.m_timeTxt:getSize().width

	self.m_widthComp:setSize(var_3_0)
end

return BattleResultSpireIdleItem
