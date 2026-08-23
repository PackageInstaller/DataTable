local var_0_0 = g.core.const.ConstMgr.RedPointConst
local HLBuildRedPointComp = class("HLBuildRedPointComp", require("app.fairyGUI.homeLand.UI_HLBuildRedPointComp"))

function HLBuildRedPointComp:ctor()
	self._func = nil
end

function HLBuildRedPointComp:initRedPoint(arg_2_1)
	self.m_bgStyleController:setSelectedIndex(arg_2_1.bgStyle or var_0_0.BuildRedPointBgStyle.BLUE)
	self.m_iconStyleController:setSelectedIndex(arg_2_1.iconStyle or var_0_0.BuildRedPointIconStyle.BATH)

	self._func = arg_2_1.func
end

function HLBuildRedPointComp:refresh()
	if self._func then
		local var_3_0 = self._func() or 0

		self.m_nTxt:setText(var_3_0)
		self:setVisible(var_3_0 > 0)
	else
		self:setVisible(false)
	end
end

return HLBuildRedPointComp
