local var_0_0 = g.core.model.User.allianceData
local AllianceExpandComp = class("AllianceExpandComp", require("app.fairyGUI.alliance.UI_AllianceExpandComp"))

function AllianceExpandComp:update(arg_1_1)
	if arg_1_1 then
		self._params = arg_1_1.data or {}
	end

	self:_initView()
	var_0_0:savePopExpandAlliance()
end

function AllianceExpandComp:_initView()
	self.m_expandTip:setText(g.core.lang:get(428515, {
		num = var_0_0:getCurDilatationDay()
	}))
	self.m_afterNum:setText(var_0_0:getAllianceGuildMaxNum())
end

function AllianceExpandComp:playAnimate()
	self.m_enterTransition:play()
end

return AllianceExpandComp
