local PreciousAttrComp = class("PreciousAttrComp", require("app.fairyGUI.precious.UI_PreciousAttrComp"))

function PreciousAttrComp:updateAttr(arg_1_1, arg_1_2, arg_1_3)
	self.m_isMaxController:setSelectedIndex(arg_1_3 and 1 or 0)

	for iter_1_0 = 1, 4 do
		if arg_1_3 then
			self["m_attrValue" .. iter_1_0]:updateAttr({
				isAll = true,
				type = iter_1_0,
				value = arg_1_1[iter_1_0]
			})
		else
			self["m_attrValue" .. iter_1_0]:updateAttr({
				isAll = true,
				type = iter_1_0,
				value = arg_1_1[iter_1_0],
				value2 = arg_1_2[iter_1_0]
			})
		end
	end
end

return PreciousAttrComp
