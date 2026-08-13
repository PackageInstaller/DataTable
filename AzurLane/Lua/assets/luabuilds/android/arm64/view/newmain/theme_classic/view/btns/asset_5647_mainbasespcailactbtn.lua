class = var_0_10000

local var_0_0 = var_0_10000("MainBaseSpcailActBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0.root = arg_1_1
	arg_1_0.event = arg_1_2
	arg_1_0.isloading = false

	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.isScale = arg_2_1
	arg_2_0.isOverflow = arg_2_2

	if arg_2_0.isloading then
		return
	end

	if not arg_2_0._tf then
		arg_2_0.isloading = true
		ResourceMgr = var_3

		local var_2_0 = var_3.Inst
		local var_2_1 = var_3.getAssetAsync
		local var_2_2 = "ui/" .. arg_2_0:GetUIName()
		local var_2_3 = ""

		UnityEngine = var_1_10008

		var_2_1(var_2_0, var_2_2, var_2_3, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
			arg_2_0.isloading = false

			if arg_2_0.exited then
				return
			end

			local var_3_0 = arg_2_0

			Object = var_2

			local var_3_1 = var_2.Instantiate
			local var_3_2 = arg_3_0
			local var_3_3 = arg_2_0

			var_3_0._tf = var_3_1(var_3_2, var_5.GetContainer(var_3_3)).transform

			local var_3_4 = arg_2_0

			var_1.OnRegister(var_3_4)

			local var_3_5 = arg_2_0

			var_1.OnInit(var_3_5)

			onButton = var_1

			local var_3_6 = arg_2_0
			local var_3_7 = arg_2_0._tf

			local function var_3_8()
				local var_4_0 = arg_2_0

				var_0.OnClick(var_4_0)

				return
			end

			SFX_MAIN = var_2_10006

			var_1(var_3_6, var_3_7, var_3_8, var_2_10006)

			if arg_2_0.shouldHide then
				setActive = var_1

				var_1(arg_2_0._tf, false)
			end

			return
		end), true, true)
	else
		arg_2_0:OnInit()
	end

	arg_2_0:CheckHide()

	return
end

function var_0_0.Clear(arg_5_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_5_0._tf) then
		Destroy = var_1

		var_1(arg_5_0._tf.gameObject)

		arg_5_0._tf = nil

		arg_5_0:OnClear()
	end

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.exited = true
	pg = var_1

	var_1.DelegateInfo.Dispose(arg_6_0)
	arg_6_0:Clear()

	return
end

function var_0_0.Refresh(arg_7_0)
	arg_7_0:CheckHide()

	return
end

function var_0_0.CheckHide(arg_8_0)
	if arg_8_0.shouldHide then
		IsNil = var_1

		if not var_1(arg_8_0._tf) then
			setActive = var_1

			var_1(arg_8_0._tf, true)
		end
	end

	arg_8_0.shouldHide = false

	return
end

function var_0_0.Disable(arg_9_0)
	arg_9_0.shouldHide = true

	arg_9_0:OnDisable()

	return
end

function var_0_0.GetContainer(arg_10_0)
	assert = var_1_10001

	var_1_10001(false, "overview me !!!")

	return
end

function var_0_0.InShowTime(arg_11_0)
	assert = var_1_10001

	var_1_10001(false, "overview me !!!")

	return
end

function var_0_0.GetUIName(arg_12_0)
	return
end

function var_0_0.OnClick(arg_13_0)
	return
end

function var_0_0.OnRegister(arg_14_0)
	return
end

function var_0_0.OnInit(arg_15_0)
	return
end

function var_0_0.OnClear(arg_16_0)
	return
end

function var_0_0.OnDisable(arg_17_0)
	return
end

return var_0_0
