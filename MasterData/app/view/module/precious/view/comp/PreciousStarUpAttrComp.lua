local PreciousStarUpAttrComp = class("PreciousStarUpAttrComp", require("app.fairyGUI.precious.UI_PreciousStarUpAttrComp"))

function PreciousStarUpAttrComp:updateAttr(arg_1_1, arg_1_2, arg_1_3)
	for iter_1_0 = 1, 4 do
		if arg_1_3 then
			self["m_attrValue" .. iter_1_0]:updateAttr({
				type = iter_1_0,
				value = arg_1_1[iter_1_0]
			})
		else
			self["m_attrValue" .. iter_1_0]:updateAttr({
				type = iter_1_0,
				value = arg_1_2[iter_1_0]
			})
		end
	end
end

return PreciousStarUpAttrComp
