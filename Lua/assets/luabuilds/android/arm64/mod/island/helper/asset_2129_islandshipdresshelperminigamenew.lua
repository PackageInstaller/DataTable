local IslandShipDressHelperMiniGameNew = class("IslandShipDressHelperMiniGameNew", import(".IslandShipDressHelperNew"))

function IslandShipDressHelperMiniGameNew:SetShipId(arg_1_1, arg_1_2, arg_1_3)
	self.super.SetShipId(self, arg_1_1)

	if not arg_1_3 then
		self.dataAfterRoleInit = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
			local var_1_0 = {
				id = iter_1_1
			}

			var_1_0.colorId = 0

			for iter_1_2, iter_1_3 in ipairs(pg.gameset.bar_not_display_dress_type.description) do
				if pg.island_dress_template[iter_1_1].type ~= iter_1_3 and pg.island_dress_template[iter_1_1].type ~= IslandShipDressHelperMiniGameNew.DressType.Flotage then
					self.dataAfterRoleInit[pg.island_dress_template[iter_1_1].type] = var_1_0
				end
			end
		end
	end

	return
end

return IslandShipDressHelperMiniGameNew
