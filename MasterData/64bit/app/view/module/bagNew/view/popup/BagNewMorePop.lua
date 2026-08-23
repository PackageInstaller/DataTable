local BagNewMorePop = class("BagNewMorePop", require("app.fairyGUI.bagNew.UI_BagNewMorePop"), function()
	return fgui.GComponent:create({
		pkgName = "bagNew",
		pkgPath = "ui/bagNew/bagNew",
		resName = "BagNewMorePop"
	})
end)
local var_0_1 = g.core.model.User
local var_0_2 = g.core.lang

function BagNewMorePop:ctor()
	self:showAtCenter()
	self.m_propertyList:setVirtual()
	self.m_propertyList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_propertyList:setScrollLimit(true)

	self._data = self:_getData()

	self.m_propertyList:setNumItems(#self._data)
end

function BagNewMorePop:_getDescAndValue(arg_3_1)
	local var_3_0, var_3_1 = var_0_2:getAttr(arg_3_1.type, arg_3_1.value, true)

	return var_3_0, var_3_1
end

function BagNewMorePop:_onItemRenderer(arg_4_1, arg_4_2)
	if self._data[arg_4_1 + 1] then
		local var_4_0, var_4_1 = self:_getDescAndValue(self._data[arg_4_1 + 1])

		arg_4_2:updateView(var_4_0, var_4_1)
	end
end

function BagNewMorePop:_getData()
	local var_5_0 = var_0_1.uniteTokenData:getTokenTotalAttr()
	local var_5_1 = var_0_1.uniteTokenData:getUniteTotalAttr()
	local var_5_2 = {}

	for iter_5_0 = 1, #var_5_0 do
		table.insert(var_5_2, var_5_0[iter_5_0])
	end

	for iter_5_1 = 1, #var_5_1 do
		table.insert(var_5_2, var_5_1[iter_5_1])
	end

	return var_5_2
end

return BagNewMorePop
