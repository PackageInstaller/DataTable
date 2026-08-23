local FormationAssociationEquipComp = class("FormationAssociationEquipComp", require("app.fairyGUI.formation.UI_FormationPreAssociationEquipComp"))
local var_0_1 = g.core.model.User.equipmentData
local var_0_2 = g.core.model.User.treasureData
local var_0_3 = g.core.common.Path
local var_0_5 = g.core.common.Goods
local var_0_6 = {
	1,
	4,
	2,
	3,
	5,
	6
}

function FormationAssociationEquipComp:ctor()
	self._knightIndex = 0
	self._mainKnightSid = 0
end

function FormationAssociationEquipComp:updateComp(arg_2_1)
	self._knightIndex = arg_2_1.index
	self._mainKnightSid = arg_2_1.mainKnightSid

	for iter_2_0 = 1, 4 do
		local var_2_0 = var_0_1:getEquipDataByKnightIndex(self._knightIndex, var_0_6[iter_2_0])

		self["m_equip" .. iter_2_0]:updateEquipIcon(var_2_0, iter_2_0)

		if var_2_0 then
			self["m_equip" .. iter_2_0 .. "QualityBg"]:setURL((var_0_3:getEquipEntranceQualityBg(var_2_0:getCfg().quality + 1)))
		else
			self["m_equip" .. iter_2_0 .. "QualityBg"]:setURL("")
		end
	end

	for iter_2_1 = 1, 2 do
		local var_2_1 = self["m_treasure" .. iter_2_1 .. "Quality"]:getController("qualityBg")

		var_2_1:setSelectedIndex(0)

		local var_2_2 = var_0_2:getTreasureDataByPos((self._knightIndex - 1) * 2 + iter_2_1)

		self["m_treasure" .. iter_2_1 .. "Level"]:updateLevel(false)

		if var_2_2 then
			local var_2_3 = var_0_5:convert({
				type = g.core.common.Goods.TYPE_TREASURE,
				value = var_2_2.base_id
			})

			self["m_treasure" .. iter_2_1]:setScale(0.9)
			self["m_treasure" .. iter_2_1]:setURL(var_2_3.icon)
			var_2_1:setSelectedIndex(var_2_3.quality or 0)

			if var_2_3.quality <= 1 then
				self["m_treasure" .. iter_2_1 .. "Level"]:updateLevel(true, var_2_2.level)
			else
				self["m_treasure" .. iter_2_1 .. "Level"]:updateLevel(true, var_2_2.level, var_2_2.refining_level)
			end
		else
			self["m_treasure" .. iter_2_1]:setScale(1)
			self["m_treasure" .. iter_2_1]:setURL((var_0_3:getEmptyTreasurePicIconById(true)))
		end
	end
end

return FormationAssociationEquipComp
