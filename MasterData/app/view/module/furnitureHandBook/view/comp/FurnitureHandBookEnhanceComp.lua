local var_0_0 = g.core.model.User.furnitureHandBookData
local var_0_1 = g.core.const.ConstMgr.FurnitureHandBookConst
local FurnitureHandBookEnhanceComp = class("FurnitureHandBookEnhanceComp", require("app.fairyGUI.furnitureHandBook.UI_FurnitureHandBookEnhanceComp"))

function FurnitureHandBookEnhanceComp:ctor()
	self._effAttrData = {}
	self._baseAttrData = {}

	self.m_effAttrList:setVirtual()
	self.m_effAttrList:setScrollLimit(true)
	self.m_effAttrList:setItemRenderer(handler(self, self._onEffAttrListItemRender))
	self.m_baseAttrList:setVirtual()
	self.m_baseAttrList:setItemRenderer(handler(self, self._onBaseAttrListItemRender))
end

function FurnitureHandBookEnhanceComp:_onEffAttrListItemRender(arg_2_1, arg_2_2)
	local var_2_0 = self._effAttrData[arg_2_1 + 1]

	if self._effAttrData[arg_2_1 + 1] then
		local var_2_1 = arg_2_2:getChild("nameTxt")
		local var_2_2 = arg_2_2:getChild("valueTxt")

		if var_2_0.type == var_0_1.HOME_LAND_TYPE then
			var_2_1:setText(g.core.lang:get(113506))
		elseif var_2_0.type == var_0_1.FURNITURE_TYPE then
			var_2_1:setText(g.core.lang:get(113508))
		end

		var_2_2:setText(g.core.lang:get(113507, {
			value = var_2_0.value
		}))
	end
end

function FurnitureHandBookEnhanceComp:_onBaseAttrListItemRender(arg_3_1, arg_3_2)
	if self._baseAttrData[arg_3_1 + 1] then
		local var_3_0, var_3_1 = g.core.lang:getAttr(self._baseAttrData[arg_3_1 + 1].type, self._baseAttrData[arg_3_1 + 1].value, false)

		arg_3_2:getChild("nameTxt"):setText((g.core.lang:get(2071, {
			name = var_3_0
		})))
		arg_3_2:getChild("valueTxt"):setText(var_3_1)
	end
end

function FurnitureHandBookEnhanceComp:onLoad()
	self._effAttrData = var_0_0:getEfficiencyData()

	self.m_effAttrList:setNumItems(#self._effAttrData)
	self.m_isNoneEffController:setSelectedIndex(#self._effAttrData > 0 and 0 or 1)

	self._baseAttrData = var_0_0:getBaseAttributeData()

	self.m_baseAttrList:setNumItems(#self._baseAttrData)
	self.m_isNoneBaseController:setSelectedIndex(#self._baseAttrData > 0 and 0 or 1)
end

return FurnitureHandBookEnhanceComp
