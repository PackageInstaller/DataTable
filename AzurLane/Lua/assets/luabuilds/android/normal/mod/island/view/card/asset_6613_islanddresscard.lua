class = var_0_10000

local var_0_0 = var_0_10000("IslandDressCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform

	local var_1_0 = {}
	local var_1_1 = arg_1_0.tf

	var_1_0[1] = var_3.Find(var_1_1, "select")
	arg_1_0.selectGos = var_1_0

	local var_1_2 = arg_1_0.tf

	arg_1_0.canSendTF = var_2.Find(var_1_2, "canSend")

	local var_1_3 = arg_1_0.tf

	arg_1_0.ownNumTF = var_2.Find(var_1_3, "icon/count_bg")

	local var_1_4 = arg_1_0.ownNumTF

	arg_1_0.ownNumText = var_2.Find(var_1_4, "count")

	local var_1_5 = arg_1_0.tf

	arg_1_0.redDot = var_2.Find(var_1_5, "red_dot")

	local var_1_6 = arg_1_0.tf

	arg_1_0.shipHoldTF = var_2.Find(var_1_6, "shipHold")

	local var_1_7 = arg_1_0.shipHoldTF

	arg_1_0.shipIcon = var_2.Find(var_1_7, "ship_icon")

	local var_1_8 = arg_1_0.tf

	arg_1_0.exclusionTF = var_2.Find(var_1_8, "exclusion_item")

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
	arg_2_0.configType = var_1_10003.island_dress_template[arg_2_1].type
	setScrollText = var_4

	local var_2_0 = arg_2_0.tf

	var_4(var_5.Find(var_2_0, "textMask/Text"), var_3.name)

	local var_2_1

	if var_3.icon ~= "" then
		GetImageSpriteFromAtlasAsync = var_4
		string = var_2_1
		var_2_1 = var_2_1.format("island/IslandDressIcon/%s", var_3.icon)

		local var_2_2 = ""
		local var_2_3 = arg_2_0.tf

		var_4(var_2_1, var_2_2, var_7.Find(var_2_3, "icon"))
	end

	if var_3.quality ~= 0 then
		GetImageSpriteFromAtlasAsync = var_4
		string = var_2_1

		local var_2_4 = var_2_1.format("island/IslandDressIcon/%s", var_0_1[var_3.quality])
		local var_2_5 = ""
		local var_2_6 = arg_2_0.tf

		var_4(var_2_4, var_2_5, var_7.Find(var_2_6, "frame"))
	end

	arg_2_0:UpdateSelected(arg_2_2)

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.selectGos) do
		setActive = var_1_10007

		var_1_10007(iter_3_1, arg_3_1)
	end

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
