local var_0_0 = g.core.config.outpost_attribute_info
local var_0_1 = {
	1,
	2,
	3,
	4
}
local var_0_2 = {
	11,
	12,
	13,
	14,
	101,
	102,
	103,
	104,
	105,
	106,
	201,
	202,
	203,
	204,
	207,
	208
}
local OutPostKnightAttrTipComp = class("OutPostKnightAttrTipComp", require("app.fairyGUI.outpost.UI_OutPostKnightAttrTipComp"))

function OutPostKnightAttrTipComp:ctor()
	self._baseAttr = {}
	self._exAttr = {}

	self.m_baseAttrList:setIniter()
	self.m_baseAttrList:setItemRenderer(handler(self, self._onBaseAttrRenderer))
	self.m_seniorAttrList:setIniter()
	self.m_seniorAttrList:setItemRenderer(handler(self, self._onExAttrRenderer))
end

function OutPostKnightAttrTipComp:updateKnightAttr(arg_2_1)
	local var_2_0 = arg_2_1:getCfg()

	self.m_nameText:setText(var_2_0.name)
	self.m_icon:updateIcon({
		struct = g.core.model.User.knightsData:getKnightByAdvanceId(var_2_0.advance_id)
	})

	self._baseAttr = {}
	self._exAttr = {}

	local var_2_1 = arg_2_1:getFinalAtkAttrs()

	local function var_2_2(arg_3_0)
		local var_3_0 = var_0_0.get(arg_3_0)
		local var_3_1 = var_2_1[arg_3_0]
		local var_3_2

		if not var_2_1[arg_3_0] then
			var_3_1 = 0
			var_3_2 = {
				type = arg_3_0,
				name = var_3_0.name
			}
		end

		var_3_2.value = var_3_0.value_format == 1 and var_3_1 or var_3_1 / 10 .. "%"

		return var_3_2
	end

	for iter_2_0, iter_2_1 in ipairs(var_0_1) do
		table.insert(self._baseAttr, var_2_2(iter_2_1))
	end

	for iter_2_2, iter_2_3 in ipairs(var_0_2) do
		table.insert(self._exAttr, var_2_2(iter_2_3))
	end

	self.m_baseAttrList:setNumItems(#self._baseAttr)
	self.m_baseAttrList:resizeToFit(#self._baseAttr)
	self.m_seniorAttrList:setNumItems(#self._exAttr)
	self.m_seniorAttrList:resizeToFit(#self._exAttr)
end

function OutPostKnightAttrTipComp:_onBaseAttrRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateAttr(self._baseAttr[arg_4_1 + 1])
end

function OutPostKnightAttrTipComp:_onExAttrRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateAttr(self._exAttr[arg_5_1 + 1])
end

return OutPostKnightAttrTipComp
