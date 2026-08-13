class = var_0_10000

local var_0_0 = var_0_10000("IslandBaseVisitorCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	local var_1_0 = arg_1_1.transform
	local var_1_1 = var_2.Find(var_1_0, "frame/icon")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.icon = var_1_2(var_1_1, var_4(var_1_10005))

	local var_1_3 = arg_1_1.transform
	local var_1_4 = var_2.Find(var_1_3, "name")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_5(var_1_4, var_4(var_1_10005))

	local var_1_6 = arg_1_1.transform
	local var_1_7 = var_2.Find(var_1_6, "level")
	local var_1_8 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.levelTxt = var_1_8(var_1_7, var_4(var_1_10005))

	local var_1_9 = arg_1_1.transform

	arg_1_0.btn = var_2.Find(var_1_9, "btn")

	local var_1_10 = arg_1_1.transform
	local var_1_11 = var_2.Find(var_1_10, "btn/Text")
	local var_1_12 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.btnTxt = var_1_12(var_1_11, var_4(var_1_10005))

	local var_1_13 = arg_1_1.transform

	arg_1_0.cardBtn = var_2.Find(var_1_13, "frame/icon")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	local var_2_0 = arg_2_0.icon

	pg = var_1_10003

	local var_2_1 = var_1_10003.ship_data_statistics[arg_2_1.icon]

	Ship = var_4

	local var_2_2 = var_4.New({
		configId = arg_2_1.icon
	})

	LoadSpriteAsync = var_5

	var_5("qicon/" .. var_2_2:getPrefab(), function(arg_3_0)
		var_2_0.sprite = arg_3_0

		return
	end)

	arg_2_0.nameTxt.text = arg_2_1.name
	arg_2_0.levelTxt.text = "LV." .. arg_2_1.level

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
