local var_0_0 = g.core.config.equipment_stage_info
local EquipMagicalStageBaseAttrTip = class("EquipMagicalStageBaseAttrTip", require("app.fairyGUI.tip.UI_EquipMagicalStageBaseAttrTip"), function()
	return fgui.GComponent:create({
		resName = "EquipMagicalStageBaseAttrTip",
		pkgPath = "ui/tip/tip",
		pkgName = "tip"
	})
end)

function EquipMagicalStageBaseAttrTip:ctor(arg_2_1)
	self:showAtCenter()
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))

	self._attrList = {}

	self:updateView(arg_2_1)
end

function EquipMagicalStageBaseAttrTip:updateView(arg_3_1)
	local var_3_0 = arg_3_1.nextCfg

	self._attrList = {}

	self.m_isMaxController:setSelectedIndex(arg_3_1.isMaxStage and 1 or 0)

	if arg_3_1.isMaxStage then
		local var_3_1 = 1

		while var_0_0.hasKey("attr_type_" .. var_3_1) do
			if arg_3_1.curCfg["attr_type_" .. var_3_1] > 0 and arg_3_1.curCfg["attr_value_" .. var_3_1] > 0 then
				table.insert(self._attrList, {
					withoutPlus1 = false,
					type = arg_3_1.curCfg["attr_type_" .. var_3_1],
					value = arg_3_1.curCfg["attr_value_" .. var_3_1]
				})
			end

			var_3_1 = var_3_1 + 1
		end

		for iter_3_0 = 1, 4 do
			if self._attrList[iter_3_0] then
				self["m_attr" .. iter_3_0]:setVisible(true)
				self["m_attr" .. iter_3_0]:updateAttr(self._attrList[iter_3_0])
			else
				self["m_attr" .. iter_3_0]:setVisible(false)
			end
		end
	else
		local var_3_2 = 1
		local var_3_3 = {}
		local var_3_4 = {}

		while var_0_0.hasKey("attr_type_" .. var_3_2) do
			var_3_3[arg_3_1.curCfg["attr_type_" .. var_3_2]] = arg_3_1.curCfg["attr_value_" .. var_3_2]
			var_3_4[var_3_0["attr_type_" .. var_3_2]] = var_3_0["attr_value_" .. var_3_2]
			var_3_2 = var_3_2 + 1
		end

		for iter_3_1, iter_3_2 in pairs(var_3_4) do
			if iter_3_1 > 0 and iter_3_2 > 0 then
				local var_3_5 = {}
				local var_3_6 = {
					type = iter_3_1
				}

				var_3_6.value = var_3_3[iter_3_1] or 0
				var_3_5.curAttr = var_3_6
				var_3_5.nextAttr = {
					type = iter_3_1,
					value = iter_3_2
				}

				table.insert(self._attrList, var_3_5)
			end
		end

		self.m_attrList:setNumItems(#self._attrList)
	end
end

function EquipMagicalStageBaseAttrTip:_onRenderAttrList(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._attrList[arg_4_1 + 1].curAttr, self._attrList[arg_4_1 + 1].nextAttr)
end

return EquipMagicalStageBaseAttrTip
