local var_0_9 = pairs

require("fight.FightHalo")

local var_0_13 = FightHalo

return function(arg_1_0)
	return setfenv(function()
		halos = {}
		source_halo = {}
		target_halo = {}

		function registerHalo(arg_3_0, arg_3_1, arg_3_2, ...)
			if source_halo[arg_3_2] and source_halo[arg_3_2][arg_3_0] then
				halos[source_halo[arg_3_2][arg_3_0]]:addHalo()
			else
				local var_3_0 = #halos + 1

				halos[#halos + 1] = var_0_13:create(arg_3_0, arg_3_1, arg_3_2, ...)
				source_halo[arg_3_2] = source_halo[arg_3_2] or {}
				source_halo[arg_3_2][arg_3_0] = var_3_0
			end
		end

		function unregisterHalo(arg_4_0, arg_4_1)
			if not halos[source_halo[arg_4_1][arg_4_0]]:removeHalo() then
				halos[source_halo[arg_4_1][arg_4_0]] = nil
				source_halo[arg_4_1][arg_4_0] = nil
			end
		end

		function unregisterAllHalo(arg_5_0, arg_5_1)
			halos[source_halo[arg_5_1][arg_5_0]]:removeAllHalo()

			halos[source_halo[arg_5_1][arg_5_0]] = nil
			source_halo[arg_5_1][arg_5_0] = nil
		end

		function clearHalo(arg_6_0)
			if source_halo[arg_6_0] then
				for iter_6_0, iter_6_1 in var_0_9(source_halo[arg_6_0]) do
					unregisterAllHalo(iter_6_0, arg_6_0)
				end
			end

			source_halo[arg_6_0] = nil

			for iter_6_2, iter_6_3 in var_0_9(halos) do
				iter_6_3:onCharacterDied(arg_6_0)
			end
		end

		function updateHalo(arg_7_0)
			for iter_7_0, iter_7_1 in var_0_9(halos) do
				iter_7_1:update(arg_7_0)
			end
		end
	end, arg_1_0)
end
