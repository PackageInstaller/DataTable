class = var_0_10000

local var_0_0 = var_0_10000("ShopBgView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._bg = arg_1_1

	local var_1_0 = arg_1_0._bg
	local var_1_1 = var_2.GetComponent

	typeof = var_1_10005
	Image = var_1_10007
	arg_1_0.img = var_1_1(var_1_0, var_1_10005(var_1_10007))
	setActive = var_2

	var_2(arg_1_1, false)

	arg_1_0.bgs = {}

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0._bg, arg_2_1 ~= nil)

	if arg_2_1 then
		local var_2_0

		if arg_2_0.bgs[arg_2_1] then
			var_2_0 = arg_2_0.bgs[arg_2_1]
		else
			GetSpriteFromAtlas = var_3
			var_2_0 = var_3(arg_2_1, "")
		end

		arg_2_0.img.sprite = var_2_0
	end

	return
end

function var_0_0.Dispose(arg_3_0)
	UIUtil = var_1_10001

	var_1_10001.ClearImageSprite(arg_3_0._bg.gameObject)

	arg_3_0.bgs = nil

	return
end

return var_0_0
