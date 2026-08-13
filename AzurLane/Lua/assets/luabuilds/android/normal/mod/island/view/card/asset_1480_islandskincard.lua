class = var_0_10000

local var_0_0 = var_0_10000("IslandSkinCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform

	local var_1_0 = {}
	local var_1_1 = arg_1_0.tf

	var_1_0[1] = var_3.Find(var_1_1, "select")
	arg_1_0.selectGos = var_1_0

	local var_1_2 = arg_1_0.tf

	arg_1_0.notGetTF = var_2.Find(var_1_2, "not_get")

	local var_1_3 = arg_1_0.tf

	arg_1_0.changeColorTF = var_2.Find(var_1_3, "changeColor")

	local var_1_4 = arg_1_0.notGetTF

	arg_1_0.buyTF = var_2.Find(var_1_4, "buy")

	return
end

local var_0_1 = {
	"white",
	"blue",
	"purple",
	"golden"
}

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.configId = arg_2_1
	pg = var_1_10003

	local var_2_0 = var_1_10003.island_skin_template[arg_2_0.configId]

	setText = var_4

	local var_2_1 = arg_2_0.tf

	var_4(var_5.Find(var_2_1, "Text"), var_2_0.name)

	if var_2_0.icon ~= "" then
		GetImageSpriteFromAtlasAsync = var_4
		string = var_5

		local var_2_2 = var_5.format("island/IslandDressIcon/%s", var_2_0.icon)
		local var_2_3 = ""
		local var_2_4 = arg_2_0.tf

		var_4(var_2_2, var_2_3, var_7.Find(var_2_4, "icon"))
	end

	arg_2_0:UpdateSelected(arg_2_2)

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 == arg_3_0.configId

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_0.selectGos) do
		setActive = var_1_10008

		var_1_10008(iter_3_1, var_3_0)
	end

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
