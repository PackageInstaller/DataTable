local var_0_0 = g.core.common.Goods
local VipLinkAwardComp = class("VipLinkAwardComp", require("app.fairyGUI.vipLink.UI_VipLinkAwardComp"))

function VipLinkAwardComp:ctor()
	self._data = nil

	self:_initView()
end

function VipLinkAwardComp:_initView()
	return
end

function VipLinkAwardComp:updateView(arg_3_1)
	self._data = arg_3_1

	local var_3_0 = var_0_0:convert(self._data)

	self.m_award:setURL(var_3_0.icon)
	self.m_awardName:setText(var_3_0.name)
	self.m_awardNum:setText(var_3_0.size)
	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		name = "eff_ui_VipLink_itembglight",
		isLoop = true
	})
end

return VipLinkAwardComp
