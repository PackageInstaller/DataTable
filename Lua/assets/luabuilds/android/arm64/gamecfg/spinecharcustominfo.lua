pg = pg or {}

local var_0_0 = pg

this = {}
pg.SpineCharCustomInfo = this
this.char_material_default_alpha = {}

function this.GetCharMaterial(arg_1_0)
	local var_1_0

	if table.contains(var_0_0.SpineCharCustomInfo.char_material_default_alpha, arg_1_0) then
		var_1_0 = LoadAny("spinematerials", "CharDefaultAlpha", typeof(Material))
		var_1_0.name = "SkeletonGraphicDefault"
	end

	return var_1_0
end

return
