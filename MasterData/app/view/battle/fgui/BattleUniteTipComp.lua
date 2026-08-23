local var_0_0 = g.core.model.User.uniteTokenData
local BattleUniteTipComp = class("BattleUniteTipComp", require("app.fairyGUI.battle.UI_BattleUniteTipComp"))

function BattleUniteTipComp:ctor()
	self._descArr = {}

	self.m_descList:setVirtual(self)
	self.m_descList:setItemRenderer(handler(self, self._onDescListRenderer))
end

function BattleUniteTipComp:updateView(arg_2_1)
	local var_2_0 = var_0_0:getTokenBaseInfo(g.core.config.unite_token_info.get(arg_2_1).skill_id).skillInfo

	self._descArr = {
		var_2_0.desc
	}

	self.m_descList:setNumItems(#self._descArr)
	self.m_bgPanel1:setTitle(var_2_0.cfg.curtain_name)
	self.m_skillIconComp:updateIcon(var_2_0)
	self.m_coolDownTxt:setText(g.core.lang:get(202517, {
		num = var_2_0.cfg.extra_cost_value
	}))
	self.m_skillCostTxt:setText(var_2_0.cfg.rage_value .. g.core.lang:get(202528))
end

function BattleUniteTipComp:_onDescListRenderer(arg_3_1, arg_3_2)
	arg_3_2:getChild("title"):enableRich()
	arg_3_2:setTitle(self._descArr[arg_3_1 + 1])
end

return BattleUniteTipComp
