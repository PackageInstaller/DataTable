local DungeonListCell = class("DungeonListCell", require("app.fairyGUI.dungeon.UI_DungeonListCell"))
local var_0_1 = g.core.config.dungeon_land_info
local var_0_2 = g.core.model.User.dungeonData

function DungeonListCell:updateLandCell(arg_1_1)
	local var_1_1 = var_0_1.indexOf(arg_1_1.landIndex or 1)

	if var_1_1 then
		local var_1_2 = var_0_2:getLandStar(var_1_1.id)
		local var_1_3 = var_0_2:getLandTotalStar(var_1_1.id)

		self.m_starText:setText(var_1_2)
		self.m_totalText:setText("/" .. var_1_3)
		self.m_landTxt:setText(g.core.lang:get(300005, {
			num = var_1_1.id,
			desc = var_1_1.name
		}))

		if var_0_2:isFinishLand(var_1_1.id) then
			self.m_starStateController:setSelectedIndex(var_1_2 < var_1_3 and 0 or 1)
		else
			self.m_starStateController:setSelectedIndex(2)
		end
	end
end

return DungeonListCell
