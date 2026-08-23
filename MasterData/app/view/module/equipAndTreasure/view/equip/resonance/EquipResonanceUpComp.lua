local EquipResonanceUpComp = class("EquipResonanceUpComp", require("app.fairyGUI.equipAndTreasure.UI_EquipResonanceUpComp"))

function EquipResonanceUpComp:ctor(arg_1_1)
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onItemRenderer))

	self._attrData = {}
end

function EquipResonanceUpComp:onLoad()
	return
end

function EquipResonanceUpComp:onUnload()
	return
end

function EquipResonanceUpComp:update(arg_4_1)
	arg_4_1 = arg_4_1 or {}
	self._data = arg_4_1.data

	local var_4_0 = self._data.beforeLevel or 0
	local var_4_1 = self._data.afterLevel or 0

	self.m_levelupComp:updateLevelupComp({
		fromLevel = var_4_0,
		toLevel = var_4_1
	})

	local var_4_2 = {}

	for iter_4_0, iter_4_1 in ipairs(self._data.afterAttr) do
		local var_4_3 = false

		for iter_4_2, iter_4_3 in ipairs(self._data.beforeAttr) do
			if iter_4_1.type == iter_4_3.type then
				var_4_3 = true
				var_4_2[#var_4_2 + 1] = {
					type = iter_4_1.type,
					value = iter_4_3.value,
					value2 = iter_4_1.value
				}

				break
			end
		end

		if not var_4_3 then
			var_4_2[#var_4_2 + 1] = {
				value = 0,
				type = iter_4_1.type,
				value2 = iter_4_1.value
			}
		end
	end

	self._attrData = var_4_2

	self.m_attrList:setNumItems(#self._attrData)

	if self.m_talentComp.updateComp then
		self.m_talentComp:updateComp({
			name = self._data.talentSkillInfo.name,
			desc = self._data.talentSkillInfo.description
		})
	end
end

function EquipResonanceUpComp:_onItemRenderer(arg_5_1, arg_5_2)
	if self._attrData[arg_5_1 + 1] then
		arg_5_2:updateAttr(self._attrData[arg_5_1 + 1])
		arg_5_2:setWidth(205)
	end
end

return EquipResonanceUpComp
