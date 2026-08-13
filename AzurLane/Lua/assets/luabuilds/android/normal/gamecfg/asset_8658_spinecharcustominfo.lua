pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg

local var_0_1 = {}

this = this
var_0.SpineCharCustomInfo = var_1
this = var_1
var_1.char_material_default_alpha = {}
this = var_1

function var_1.GetCharMaterial(arg_1_0)
	local var_1_0

	table = var_1_10002

	if var_1_10002.contains(var_0.SpineCharCustomInfo.char_material_default_alpha, arg_1_0) then
		LoadAny = var_2

		local var_1_1 = "spinematerials"
		local var_1_2 = "CharDefaultAlpha"

		typeof = var_1_10005
		Material = var_1_10006
		var_1_0 = var_2(var_1_1, var_1_2, var_1_10005(var_1_10006))
		var_1_0.name = "SkeletonGraphicDefault"
	end

	return var_1_0
end

return
