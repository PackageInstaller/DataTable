local var_0_0 = class("IslandBaseVisitorCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0.icon = arg_1_1.transform:Find("frame/icon"):GetComponent(typeof(Image))
	arg_1_0.nameTxt = arg_1_1.transform:Find("name"):GetComponent(typeof(Text))
	arg_1_0.levelTxt = arg_1_1.transform:Find("level"):GetComponent(typeof(Text))
	arg_1_0.btn = arg_1_1.transform:Find("btn")
	arg_1_0.btnTxt = arg_1_1.transform:Find("btn/Text"):GetComponent(typeof(Text))
	arg_1_0.cardBtn = arg_1_1.transform:Find("frame/icon")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	local var_2_0 = arg_2_0.icon

	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = arg_2_1.icon
	}):getPrefab(), function(arg_3_0)
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
