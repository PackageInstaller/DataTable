local var_0_0 = g.core.const.ConstMgr.KnightSoulConst
local KnightSoulUpAttrComp = class("KnightSoulUpAttrComp", require("app.fairyGUI.knightSoul.UI_KnightSoulUpAttrComp"))

function KnightSoulUpAttrComp:updateAttributes(arg_1_1, arg_1_2)
	local var_1_0 = {}

	if arg_1_1 then
		var_1_0 = arg_1_1:getBookAttrInfoList()
	elseif arg_1_2 then
		var_1_0 = arg_1_2
	end

	self.m_arrangeTypeController:setSelectedIndex((#var_1_0 == 1 or #var_1_0 == 2 or nil) and #var_1_0)

	for iter_1_0 = 1, var_0_0.MAX_ATTRIBUTE_NUM do
		self["m_attribute" .. iter_1_0]:setVisible(checkbool(var_1_0[iter_1_0]))

		if var_1_0[iter_1_0] then
			local var_1_2 = {
				withoutPlus1 = false,
				isAll = true,
				type = var_1_0[iter_1_0].attrType
			}

			var_1_2.value = var_1_0[iter_1_0].attrGrow or var_1_0[iter_1_0].attrValue

			self["m_attribute" .. iter_1_0]:updateAttr(var_1_2)
		end
	end
end

return KnightSoulUpAttrComp
