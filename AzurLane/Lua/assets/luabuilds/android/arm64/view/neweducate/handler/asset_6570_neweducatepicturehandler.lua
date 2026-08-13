class = var_0_10000

local var_0_0 = var_0_10000("NewEducatePictureHandler")
local var_0_1 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.GetComponent

	typeof = var_1_10005
	Animation = var_1_10007
	arg_1_0._anim = var_1_1(var_1_0, var_1_10005(var_1_10007))

	local var_1_2 = arg_1_0._tf

	arg_1_0.bgTF = var_2.Find(var_1_2, "bg")

	local var_1_3 = arg_1_0.bgTF

	arg_1_0.nameTF = var_2.Find(var_1_3, "name")

	local var_1_4 = arg_1_0.bgTF
	local var_1_5 = var_2.Find(var_1_4, "picture")
	local var_1_6 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.imageCom = var_1_6(var_1_5, var_5(var_1_10007))

	return
end

function var_0_0.Play(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	setActive = var_1_10004

	var_1_10004(arg_2_0._go, true)

	if arg_2_0._anim then
		local var_2_0 = arg_2_0._anim

		var_4.Play(var_2_0)
	end

	setText = var_4

	var_4(arg_2_0.nameTF, arg_2_3 or "")

	ResourceMgr = var_4

	local var_2_1 = var_4.Inst
	local var_2_2 = var_4.getAssetAsync
	local var_2_3 = "neweducateicon/" .. arg_2_1
	local var_2_4 = ""

	typeof = var_1_10009
	Sprite = var_1_10011

	local var_2_5 = var_1_10009(var_1_10011)

	UnityEngine = var_1_10010

	var_2_2(var_2_1, var_2_3, var_2_4, var_2_5, var_1_10010.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
		arg_2_0.imageCom.sprite = arg_3_0

		local var_3_0 = arg_2_0

		Timer = var_2_10002
		var_3_0.timer = var_2_10002.New(function()
			existCall = var_3_10000

			var_3_10000(arg_2_2)

			return
		end, var_0_1)

		local var_3_1 = arg_2_0.timer

		var_1.Start(var_3_1)

		return
	end), true, true)

	return
end

function var_0_0.Reset(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0._go, false)

	arg_5_0.imageCom.sprite = nil

	if arg_5_0.timer ~= nil then
		local var_5_0 = arg_5_0.timer

		var_1.Stop(var_5_0)

		arg_5_0.timer = nil
	end

	return
end

function var_0_0.Destroy(arg_6_0)
	return
end

return var_0_0
