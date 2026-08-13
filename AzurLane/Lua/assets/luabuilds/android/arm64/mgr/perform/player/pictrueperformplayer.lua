class = var_0_10000

local var_0_0 = "StoryPerformPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BasePerformPlayer"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0._tf

	arg_1_0.bgTF = var_2.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0.bgTF

	arg_1_0.nameTF = var_2.Find(var_1_1, "name")

	local var_1_2 = arg_1_0.bgTF
	local var_1_3 = var_2.Find(var_1_2, "picture")
	local var_1_4 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.imageCom = var_1_4(var_1_3, var_5(var_1_10007))

	return
end

function var_0_1.Play(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_0

	arg_2_0.Show(var_2_0)

	if arg_2_0._anim then
		var_2_0 = arg_2_0._anim

		var_4.Play(var_2_0)
	end

	if arg_2_3 then
		setText = var_4

		var_4(arg_2_0.nameTF, arg_2_3)
	end

	local var_2_1

	if not arg_2_1.param[1] then
		var_2_1 = ""
	end

	local var_2_2

	if not arg_2_1.param[2] then
		var_2_2 = 3
	end

	setActive = var_2_0

	var_2_0(arg_2_0.bgTF, false)

	LoadAnyAsync = var_2_0

	local var_2_3 = "educatepicture/" .. var_2_1
	local var_2_4 = ""

	typeof = var_1_10010
	Sprite = var_1_10012

	var_2_0(var_2_3, var_2_4, var_1_10010(var_1_10012), function(arg_3_0)
		local var_3_0 = arg_2_0.imageCom

		var_3_0.sprite = arg_3_0
		setActive = var_3_0

		var_3_0(arg_2_0.bgTF, true)

		local var_3_1 = arg_2_0

		Timer = var_2_10002
		var_3_1.timer = var_2_10002.New(function()
			if arg_2_2 then
				arg_2_2()
			end

			return
		end, var_2_2)

		local var_3_2 = arg_2_0.timer

		var_1.Start(var_3_2)

		return
	end)

	return
end

function var_0_1.Clear(arg_5_0)
	arg_5_0.imageCom.sprite = nil

	if arg_5_0.timer ~= nil then
		local var_5_0 = arg_5_0.timer

		var_1.Stop(var_5_0)

		arg_5_0.timer = nil
	end

	setText = var_1

	var_1(arg_5_0.nameTF, "")
	arg_5_0:Hide()

	return
end

return var_0_1
