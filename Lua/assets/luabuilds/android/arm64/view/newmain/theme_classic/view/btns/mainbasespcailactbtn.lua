local var_0_0 = class("MainBaseSpcailActBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)

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

		ResourceMgr.Inst:getAssetAsync("ui/" .. arg_2_0:GetUIName(), "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
			arg_2_0.isloading = false

			if arg_2_0.exited then
				return
			end

			arg_2_0._tf = Object.Instantiate(arg_3_0, arg_2_0:GetContainer()).transform

			arg_2_0:OnRegister()
			arg_2_0:OnInit()
			onButton(arg_2_0, arg_2_0._tf, function()
				arg_2_0:OnClick()

				return
			end, SFX_MAIN)

			if arg_2_0.shouldHide then
				setActive(arg_2_0._tf, false)
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
	if not IsNil(arg_5_0._tf) then
		Destroy(arg_5_0._tf.gameObject)

		arg_5_0._tf = nil

		arg_5_0:OnClear()
	end

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.exited = true

	pg.DelegateInfo.Dispose(arg_6_0)
	arg_6_0:Clear()

	return
end

function var_0_0.Refresh(arg_7_0)
	arg_7_0:CheckHide()

	return
end

function var_0_0.CheckHide(arg_8_0)
	if arg_8_0.shouldHide and not IsNil(arg_8_0._tf) then
		setActive(arg_8_0._tf, true)
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
	assert(false, "overview me !!!")

	return
end

function var_0_0.InShowTime(arg_11_0)
	assert(false, "overview me !!!")

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
