local var_0_0 = class("IslandAnimationAttachmentHelper")

function var_0_0.ResolveId(arg_1_0, arg_1_1)
	if not pg.island_animation_attachments[arg_1_1] or not arg_1_0 then
		return arg_1_1
	end

	local var_1_0 = pg.island_animation_attachments[arg_1_1].override

	if pg.island_animation_attachments[arg_1_1].override == "" or type(var_1_0) ~= "table" then
		return arg_1_1
	end

	if type(var_1_0[1]) == "table" then
		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			if var_1_1(iter_1_1[1]) then
				return iter_1_1[2] or arg_1_1
			end
		end
	elseif var_1_1(var_1_0[1]) then
		return var_1_0[2] or arg_1_1
	end

	return arg_1_1
end

return var_0_0
