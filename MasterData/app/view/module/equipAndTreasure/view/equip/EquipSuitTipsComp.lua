local EquipSuitTipsComp = class("EquipSuitTipsComp", require("app.fairyGUI.equipAndTreasure.UI_EquipSuitTipsComp"))
local var_0_1 = g.core.model.User.equipmentData

function EquipSuitTipsComp:ctor()
	self._knight = nil
	self._knightPos = 0
end

function EquipSuitTipsComp:updateSuitSimpleIcon(arg_2_1)
	self._knight = arg_2_1.knight
	self._knightIndex = arg_2_1.index or 0
	self._knightPos = self._knight:getInfo().position
	self._isOther = arg_2_1.isOther

	for iter_2_0 = 1, 4 do
		local var_2_0 = ""
		local var_2_1 = self["m_simpleIcon" .. iter_2_0]
		local var_2_2 = not self._isOther and var_0_1:getEquipBySid((var_0_1:getEquipIdByPos((self._knightIndex - 1) * 4 + iter_2_0))) or g.core.model.User.playerInfoData:getEquipmentByPos((self._knightIndex - 1) * 4 + iter_2_0)

		if var_2_2 then
			local var_2_3 = var_2_2:getCfg().suit_id

			if var_2_3 > 0 then
				var_2_0 = self:getSimpleSuitIconUrl(var_2_3)
			end
		end

		var_2_1:setURL(var_2_0)
	end
end

function EquipSuitTipsComp:getActiveSuitIdData()
	local var_3_0 = {}

	for iter_3_0 = 1, 4 do
		local var_3_1 = var_0_1:getEquipBySid((var_0_1:getEquipIdByPos((self._knightIndex - 1) * 4 + iter_3_0)))

		if var_3_1 then
			local var_3_2 = var_3_1:getCfg().suit_id
			local var_3_3 = g.core.model.User.formationData:getEquipSuitByKnightPos(self._knightPos)

			if var_3_3 then
				if var_3_3[var_3_2] and var_3_3[var_3_2] >= 2 then
					table.insert(var_3_0, var_3_2)
				end
			end
		end
	end

	local var_3_4 = g.core.utils.Table.delRepeatItem(var_3_0)

	table.sort(var_3_4, function(arg_4_0, arg_4_1)
		return arg_4_1 < arg_4_0
	end)

	return var_3_4
end

function EquipSuitTipsComp:getSimpleSuitIconUrl(arg_5_1)
	local var_5_0 = self:getActiveSuitIdData()

	if not next(var_5_0) then
		return ""
	end

	local var_5_1 = ""

	if #var_5_0 == 1 and var_5_0[1] == arg_5_1 then
		var_5_1 = "ui://base_new/pic_zb_taozhuang2"
	else
		local var_5_2 = {
			"ui://base_new/pic_zb_taozhuang1",
			"ui://base_new/pic_zb_taozhuang2"
		}

		for iter_5_0 = 1, #var_5_0 do
			if var_5_0[iter_5_0] == arg_5_1 then
				var_5_1 = var_5_2[iter_5_0]
			end
		end
	end

	return var_5_1
end

return EquipSuitTipsComp
