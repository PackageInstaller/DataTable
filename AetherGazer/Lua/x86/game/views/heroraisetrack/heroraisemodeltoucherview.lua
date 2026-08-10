local var_0_0 = class("HeroRaiseModelToucherView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.rotateNode_ = nil

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.backGo_ = arg_3_0:FindGo("back")
end

function var_0_0.SetRotateNode(arg_4_0, arg_4_1)
	arg_4_0.rotateNode_ = arg_4_1
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddDragListener(arg_5_0.backGo_, function()
		if arg_5_0.rotateNode_ then
			arg_5_0.startRot_ = arg_5_0.rotateNode_.localEulerAngles
		else
			arg_5_0.startRot_ = Vector3.zero
		end

		arg_5_0.lastRotateY_ = nil
		arg_5_0.lastDeltaX_ = 0
	end, function(arg_7_0, arg_7_1)
		if arg_5_0.rotateNode_ then
			local var_7_0 = arg_5_0.lastRotateY_ or arg_5_0.rotateNode_.localEulerAngles.y
			local var_7_1 = var_7_0 + (arg_7_0 - (arg_5_0.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_7_0
			local var_7_2 = var_7_1

			if var_7_1 < -HeroConst.MAX_RORATE_ANGLE then
				var_7_2 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_7_1 > HeroConst.MAX_RORATE_ANGLE then
				var_7_2 = HeroConst.MAX_RORATE_ANGLE
			end

			arg_5_0.lastRotateY_ = var_7_0 + var_7_2
			arg_5_0.lastDeltaX_ = arg_7_0
			arg_5_0.rotateNode_.localRotation = Quaternion.RotateTowards(arg_5_0.rotateNode_.localRotation, Quaternion.Euler(arg_5_0.startRot_.x, var_7_0 + var_7_2, arg_5_0.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	return
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0.rotateNode_ = nil
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.rotateNode_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
