local var_0_0 = g.core.const.ConstMgr.FurnitureHandBookConst
local FurnitureCollectValueComp = class("FurnitureCollectValueComp", require("app.fairyGUI.furnitureHandBook.UI_FurnitureCollectValueComp"))

function FurnitureCollectValueComp:updateValue(arg_1_1, arg_1_2, arg_1_3)
	if arg_1_1 then
		local var_1_0 = math.ceil(arg_1_2.efficiency_process / 1000 * 100)

		self:setTitle(var_1_0 .. "%")

		if arg_1_1 == var_0_0.HOME_LAND_TYPE then
			self.m_attrName:setText(g.core.lang:get(113506))
		elseif arg_1_1 == var_0_0.FURNITURE_TYPE then
			self.m_attrName:setText(g.core.lang:get(113508))
		end

		self.m_attrValue:setText(g.core.lang:get(113507, {
			value = arg_1_2.efficiency_value / 1000 * 100
		}))
		self:setIsActivate(var_1_0 <= arg_1_3)
	else
		local var_1_1 = math.ceil(arg_1_2.attribute_process / 1000 * 100)

		self:setTitle(var_1_1 .. "%")

		local var_1_2, var_1_3 = g.core.lang:getAttr(arg_1_2.attribute_type, arg_1_2.attribute_value, false)

		self.m_attrName:setText((g.core.lang:get(2071, {
			name = var_1_2
		})))
		self.m_attrValue:setText(var_1_3)
		self:setIsActivate(var_1_1 <= arg_1_3)
	end
end

function FurnitureCollectValueComp:setIsActivate(arg_2_1)
	self.m_isDoneController:setSelectedIndex(arg_2_1 and 1 or 0)
end

return FurnitureCollectValueComp
