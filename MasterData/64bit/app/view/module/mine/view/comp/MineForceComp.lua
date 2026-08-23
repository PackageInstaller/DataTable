local MineForceComp = class("MineForceComp", require("app.fairyGUI.mine.UI_MineForceComp"))

function MineForceComp:ctor()
	self._maxPower = g.core.config.mine_parameter_info.indexOf(1).max_hp

	self.m_buyForceBtn:addClickListener(handler(self, self._onBuyForce))
end

function MineForceComp:updateView(arg_2_1)
	self.m_process:setMax(arg_2_1.max)
	self.m_process:setValue(arg_2_1.cur)
	self.m_processTxt:setText(arg_2_1.cur .. "/" .. arg_2_1.max)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_buyForceBtn
	})
end

function MineForceComp:_onBuyForce()
	if not g.core.model.User.mineData:isOwnCapital() then
		g.core.module.ModuleManager:tip(g.core.lang:get(307527))
	elseif g.core.model.User.mineData:getCurPower() >= self._maxPower then
		g.core.module.ModuleManager:tip(g.core.lang:get(307528))
	else
		g.core.module.ModuleManager:pushPopup((require("app.view.module.mine.view.pop.MineForceBuyPop").new()))
	end
end

return MineForceComp
