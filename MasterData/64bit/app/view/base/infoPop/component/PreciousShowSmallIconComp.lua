local PreciousShowSmallIconComp = class("PreciousShowSmallIconComp", require("app.fairyGUI.infoPop.UI_PreciousShowSmallIconComp"))

function PreciousShowSmallIconComp:ctor()
	return
end

function PreciousShowSmallIconComp:updateIconComp(arg_2_1, arg_2_2)
	local var_2_0 = g.core.config.precious_info.get(arg_2_1)

	self.m_icon:setIcon((g.core.common.Path:getPreciousSmallIconByResId(var_2_0.res_id)))
	self.m_nameText:setText(var_2_0.name)

	if arg_2_2 then
		self.m_isActiveController:setSelectedIndex(1)
	else
		self.m_isActiveController:setSelectedIndex(0)
	end
end

return PreciousShowSmallIconComp
