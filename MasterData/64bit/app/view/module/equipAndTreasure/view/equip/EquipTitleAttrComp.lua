local EquipTitleAttrComp = class("EquipTitleAttrComp", require("app.fairyGUI.equipAndTreasure.UI_EquipTitleAttrComp"))

function EquipTitleAttrComp:ctor()
	self._id = 0
	self._knightPos = 0
	self._isShowStr = false
	self._isShowRef = false
	self._isShowGly = false

	self.m_list:setVirtual()
	self.m_list:setItemRenderer(handler(self, self._onItemRenderer))

	self._data = {}

	self:getChild("title"):addClickListener(handler(self, self._onClickTitle))
end

function EquipTitleAttrComp:setTitleAttrCtrl(arg_2_1)
	self.m_isDevlopController:setSelectedIndex(arg_2_1 and 1 or 0)
end

function EquipTitleAttrComp:_onItemRenderer(arg_3_1, arg_3_2)
	if not self._data[arg_3_1 + 1] then
		return
	end

	local var_3_0 = arg_3_2:getChild("attrValueComp")

	if var_3_0 then
		local var_3_1 = arg_3_2:getController("width")

		var_3_0:updateAttr({
			type = self._data[arg_3_1 + 1].type,
			value = self._data[arg_3_1 + 1].value,
			value2 = self._data[arg_3_1 + 1].value2
		})

		if self._isLong then
			var_3_1:setSelectedIndex(0)
		else
			var_3_1:setSelectedIndex(1)
		end
	end
end

function EquipTitleAttrComp:setItemData(arg_4_1, arg_4_2)
	if type(arg_4_1) ~= "table" then
		return
	end

	self._data = arg_4_1
	self._isLong = arg_4_2 or false

	self.m_isDevlopController:setSelectedIndex(#arg_4_1 > 0 and 1 or 0)
	self.m_list:setNumItems(#arg_4_1)
end

function EquipTitleAttrComp:_onClickTitle()
	self:dispatchCompEvent("EquipTitleAttrComp_onClickTitle")
end

return EquipTitleAttrComp
