local var_0_0 = g.core.config.monster_info
local GveBossEscortCell = class("GveBossEscortCell", require("app.fairyGUI.gve.UI_GveBossEscortCell"))

function GveBossEscortCell:updateComp(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = tostring(arg_1_1.guardIndex)

	if arg_1_1.guardIndex < 10 then
		var_1_0 = "0" .. var_1_0
	end

	self.m_guardIndexText:setText(var_1_0)
	self.m_guardNameText:setText(g.core.lang:get(309003, {
		index = arg_1_1.guardIndex
	}))
	self.m_buttonController:setSelectedIndex(arg_1_2 == arg_1_1.wave and 1 or 0)

	for iter_1_0 = 1, 6 do
		local var_1_1 = self["m_knight" .. iter_1_0]
		local var_1_2 = var_0_0.fetch(arg_1_1.monsterTeamInfo["monster_" .. iter_1_0])

		if var_1_2 then
			local var_1_3, var_1_4, var_1_5

			if arg_1_1.hpList then
				var_1_3 = arg_1_1.hpList[iter_1_0]

				if not arg_1_1.hpList[iter_1_0] then
					var_1_3 = 0
					var_1_4 = arg_1_3:getInfo()["guard_" .. arg_1_1.guardIndex .. "_elite"]
					var_1_5 = {
						knightId = var_1_2.res_id
					}
				end
			end

			var_1_5.hpPer = math.clamp(var_1_3 / var_1_2.initial_hp * 100, 0, 100)
			var_1_5.equipLv = arg_1_3:getInfo().guard_equip_lv
			var_1_5.isDead = var_1_3 <= 0
			var_1_5.star = var_1_2.star or 0

			var_1_1:updateByMonsterData(var_1_5, var_1_4 == iter_1_0)
			var_1_1:setVisible(true)
		else
			var_1_1:setVisible(false)
		end
	end
end

return GveBossEscortCell
