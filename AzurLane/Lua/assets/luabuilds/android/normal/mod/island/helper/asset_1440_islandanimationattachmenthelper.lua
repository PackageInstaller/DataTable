class = var_0_10000

local var_0_0 = var_0_10000("IslandAnimationAttachmentHelper")

function var_0_0.ResolveId(arg_1_0, arg_1_1)
	pg = var_1_10002

	if not var_1_10002.island_animation_attachments[arg_1_1] or not arg_1_0 then
		return arg_1_1
	end

	if var_2.override ~= "" then
		type = var_1_10004

		if var_1_10004(var_3) ~= "table" then
			return arg_1_1
		end

		local function var_1_0(arg_2_0)
			if not arg_2_0 or arg_2_0 == "" then
				return false
			end

			if not arg_1_0.runtimeAnimatorController then
				return false
			end

			string = var_2_10002

			return var_2_10002.gsub(var_1.name, "%(Clone%)$", "") == arg_2_0
		end

		type = var_1_10005

		if var_1_10005(var_3[1]) == "table" then
			ipairs = var_5

			for iter_1_0, iter_1_1 in var_5(var_3) do
				if var_1_0(iter_1_1[1]) then
					local var_1_1

					if not iter_1_1[2] then
						var_1_1 = arg_1_1
					end

					return var_1_1
				end
			end
		elseif var_1_0(var_3[1]) then
			local var_1_2

			if not var_3[2] then
				var_1_2 = arg_1_1
			end

			return var_1_2
		end

		return arg_1_1
	end
end

return var_0_0
