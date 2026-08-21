local var_0_0 = {
	sort = {
		{
			spr = "sort_rarity",
			type = 1,
			tag = i18n("word_equipment_rarity"),
			values = {
				"rarity",
				"id",
				"level"
			}
		},
		{
			spr = "sort_intensify",
			type = 2,
			tag = i18n("word_equipment_intensify"),
			values = {
				"level",
				"rarity",
				"id"
			}
		}
	},
	getWeight = function(arg_1_0, arg_1_1)
		return SpWeapon.bindConfigTable()[arg_1_0:GetConfigID()][arg_1_1]
	end
}

function var_0_0.sortFunc(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.values) do
		table.insert({}, function(arg_3_0)
			return (arg_2_1 and -1 or 1) * -var_0_0.getWeight(arg_3_0, iter_2_1)
		end)
	end

	return {}
end

return var_0_0
