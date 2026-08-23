local var_0_0 = g.core.common.Path
local PreciousSuitGotoComp = class("PreciousSuitGotoComp", require("app.fairyGUI.infoPop.UI_PreciousSuitGotoComp"))

function PreciousSuitGotoComp:ctor(arg_1_1)
	self._preciousSuit = nil

	self:addClickListener(handler(self, self._onClickSelf))
end

function PreciousSuitGotoComp:_onClickSelf()
	if not self._preciousSuit then
		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.PRECIOUS_SUIT_DEV, {
		group = self._preciousSuit:getSuitGroup()
	})
end

function PreciousSuitGotoComp:updateGotoComp(arg_3_1)
	self._preciousSuit = arg_3_1

	self.m_showComp:setIcon(var_0_0:getPreciousSuitIconByResId(arg_3_1:getCfg().icon))
end

return PreciousSuitGotoComp
