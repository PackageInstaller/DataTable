local var_0_0 = class("NewEducatePictureHandler")
local var_0_1 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._anim = arg_1_0._tf:GetComponent(typeof(Animation))
	arg_1_0.bgTF = arg_1_0._tf:Find("bg")
	arg_1_0.nameTF = arg_1_0.bgTF:Find("name")
	arg_1_0.imageCom = arg_1_0.bgTF:Find("picture"):GetComponent(typeof(Image))

	return
end

function var_0_0.Play(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	setActive(arg_2_0._go, true)

	if arg_2_0._anim then
		arg_2_0._anim:Play()
	end

	setText(arg_2_0.nameTF, arg_2_3 or "")
	ResourceMgr.Inst:getAssetAsync("neweducateicon/" .. arg_2_1, "", typeof(Sprite), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
		arg_2_0.imageCom.sprite = arg_3_0
		arg_2_0.timer = Timer.New(function()
			existCall(arg_2_2)

			return
		end, var_0_1)

		arg_2_0.timer:Start()

		return
	end), true, true)

	return
end

function var_0_0.Reset(arg_5_0)
	setActive(arg_5_0._go, false)

	arg_5_0.imageCom.sprite = nil

	if arg_5_0.timer ~= nil then
		arg_5_0.timer:Stop()

		arg_5_0.timer = nil
	end

	return
end

function var_0_0.Destroy(arg_6_0)
	return
end

return var_0_0
