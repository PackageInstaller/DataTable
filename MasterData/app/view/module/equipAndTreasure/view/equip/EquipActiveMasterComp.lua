local var_0_0 = g.core.config.enhance_master_info
local var_0_1 = g.core.const.ConstMgr.EquipConst
local EquipActiveMasterComp = class("EquipActiveMasterComp", require("app.fairyGUI.equipAndTreasure.UI_EquipActiveMasterComp"))

function EquipActiveMasterComp:update(arg_1_1)
	self._enhanceMaster = arg_1_1.master

	self:_initView()
end

function EquipActiveMasterComp:_initView()
	if not self._enhanceMaster then
		return
	end

	local var_2_0 = var_0_0.match(function(arg_3_0)
		return arg_3_0.type == self._enhanceMaster.type and arg_3_0.value == self._enhanceMaster.aLevel
	end)[1]

	self.m_descTxt:setText(var_2_0.master_name)

	self._enhanceAfter = var_2_0

	self:_showAttr()
end

function EquipActiveMasterComp:_showAttr()
	local var_4_0 = {}

	for iter_4_0 = 1, var_0_1.EQUIP_FIELDNUM do
		if self._enhanceAfter["affect_value_" .. iter_4_0] > 0 and self._enhanceAfter["affect_type_" .. iter_4_0] > 0 then
			local var_4_1, var_4_2 = g.core.lang:getAttr(self._enhanceAfter["affect_type_" .. iter_4_0], self._enhanceAfter["affect_value_" .. iter_4_0])

			table.insert(var_4_0, {
				attrName = var_4_1,
				attrValue = var_4_2
			})
		end
	end

	for iter_4_1 = 1, var_0_1.EQUIP_FIELDNUM do
		if iter_4_1 <= #var_4_0 then
			self["m_afterName" .. iter_4_1]:setText(var_4_0[iter_4_1].attrName)
			self["m_afterValue" .. iter_4_1]:setText(var_4_0[iter_4_1].attrValue)
			self["m_afterIcon" .. iter_4_1]:setURL((g.core.model.User.equipmentData:getUpTypeIconByName(var_4_0[iter_4_1].attrName)))
		end
	end
end

return EquipActiveMasterComp
