local EquipMagicalStageUpComp = class("EquipMagicalStageUpComp", require("app.fairyGUI.equipAndTreasure.UI_EquipMagicalStageUpComp"))

function EquipMagicalStageUpComp:ctor()
	self._param = nil
	self._activeStage = 0
end

function EquipMagicalStageUpComp:update(arg_2_1)
	self._param = arg_2_1

	local var_2_0 = arg_2_1.equip:getMagicalStage()

	self._activeStage = var_2_0

	self.m_curStage:setText(var_2_0 - 1)
	self.m_nextStage:setText(var_2_0)

	local var_2_1 = arg_2_1.equip:getMagicalAttrMap(var_2_0 - 1)
	local var_2_2 = {}

	for iter_2_0, iter_2_1 in pairs((arg_2_1.equip:getMagicalAttrMap())) do
		local var_2_4 = {
			type = iter_2_0
		}

		var_2_4.value = var_2_1[iter_2_0] or 0
		var_2_4.value2 = iter_2_1

		table.insert(var_2_2, var_2_4)
	end

	for iter_2_2 = 1, 4 do
		if var_2_2[iter_2_2] then
			self["m_attr" .. iter_2_2]:setVisible(true)
			self["m_attr" .. iter_2_2]:updateAttr(var_2_2[iter_2_2])
		else
			self["m_attr" .. iter_2_2]:setVisible(false)
		end
	end

	self.m_equipIcon:updateIcon({
		equip = arg_2_1.equip,
		magicalStage = arg_2_1.equip:getMagicalStage()
	})
end

function EquipMagicalStageUpComp:playAnimate()
	self.m_enterTransition:play()
	self.m_equipIcon:playEquipMagicalStageUpEff(self._activeStage)
end

return EquipMagicalStageUpComp
