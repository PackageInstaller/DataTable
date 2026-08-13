local var_0_0 = {
	IsMatchKey = function(arg_1_0, arg_1_1)
		if not arg_1_1 or arg_1_1 == "" then
			return true
		end

		string = var_1_10002

		local var_1_0 = var_1_10002.lower

		string = var_1_10003
		arg_1_1 = var_1_0(var_1_10003.gsub(arg_1_1, "%.", "%%."))
		underscore = var_2

		return var_2.any(arg_1_0, function(arg_2_0)
			string = var_2_10001

			local var_2_0 = var_2_10001.find

			string = var_2_10002

			return var_2_0(var_2_10002.lower(arg_2_0), arg_1_1)
		end)
	end
}

function var_0_0.IsMatchEquipmentSkinKey(arg_3_0, arg_3_1)
	local var_3_0 = {}

	pg = var_1_10003
	var_3_0[1] = var_1_10003.equip_skin_template[arg_3_0].name

	return var_0_0.IsMatchKey(var_3_0, arg_3_1)
end

function var_0_0.GetMatchSpEquipmentListKeyByShip(arg_4_0)
	local var_4_0 = {}

	pairs = var_1_10002
	pg = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10002(var_1_10003.spweapon_data_statistics.get_id_list_by_unique) do
		if iter_4_0 ~= 0 then
			ipairs = var_1_10007
			pg = var_1_10008

			for iter_4_2, iter_4_3 in var_1_10007(var_1_10008.ship_data_template.get_id_list_by_group_type[iter_4_0]) do
				string = var_1_10012
				var_1_10012 = var_1_10012.find
				string = var_1_10013
				var_1_10013 = var_1_10013.lower
				pg = var_1_10014

				if var_1_10012(var_1_10013(var_1_10014.ship_data_statistics[iter_4_3].name), arg_4_0) then
					table = var_1_10012
					var_4_0 = var_1_10012.insertto(var_4_0, iter_4_1)

					break
				end
			end
		end
	end

	return
end

return var_0_0
