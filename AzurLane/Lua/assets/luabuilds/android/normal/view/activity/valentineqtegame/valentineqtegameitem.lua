class = var_0_10000

local var_0_0 = var_0_10000("ValentineQteGameItem")
local var_0_1 = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6"
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.rect = arg_1_0._tf.rect

	local var_1_0 = arg_1_0._go
	local var_1_1 = var_4.GetComponent

	typeof = var_1_10006
	Image = var_1_10007
	arg_1_0.image = var_1_1(var_1_0, var_1_10006(var_1_10007))

	arg_1_0:SetTime(arg_1_3)
	arg_1_0:SetPosition(arg_1_2)

	getBounds = var_4
	arg_1_0.bound = var_4(arg_1_0._tf)
	math = var_4

	local var_1_2 = var_4.random(1, #var_0_1)

	GetSpriteFromAtlas = var_5

	local var_1_3 = var_5("ui/minigameui/valentineqtegame_atlas", var_0_1[var_1_2])

	arg_1_0.image.sprite = var_1_3

	local var_1_4 = arg_1_0.image

	var_6.SetNativeSize(var_1_4)

	return
end

function var_0_0.SetTime(arg_2_0, arg_2_1)
	arg_2_0.genTime = arg_2_1

	return
end

function var_0_0.SetPosition(arg_3_0, arg_3_1)
	arg_3_0.genPos = arg_3_1
	arg_3_0._tf.localPosition = arg_3_1

	return
end

function var_0_0.ShouldDisapper(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.genTime - arg_4_1

	ValentineQteGameConst = var_1_10003

	if var_4_0 >= var_1_10003.ITEM_DISAPPEAR_TIME then
		return true
	end

	return false
end

function var_0_0.IsOverlap(arg_5_0, arg_5_1)
	getBounds = var_1_10002

	local var_5_0 = var_1_10002(arg_5_1)
	local var_5_1 = arg_5_0.bound

	return var_3.Intersects(var_5_1, var_5_0)
end

function var_0_0.IsSufficientLength(arg_6_0, arg_6_1, arg_6_2)
	math = var_1_10003

	return arg_6_2 < var_1_10003.abs(arg_6_0._tf.localPosition.x - arg_6_1)
end

function var_0_0.Destroy(arg_7_0)
	arg_7_0.image.sprite = nil

	return
end

return var_0_0
