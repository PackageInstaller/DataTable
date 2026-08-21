local var_0_0 = class("QuarryItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.ani_ = arg_3_0.transform_:GetComponent("Animator")
	arg_3_0.smokeAni_ = arg_3_0.smokeGo_.transform:GetComponent("Animator")
	arg_3_0.texture_ = arg_3_0.transform_:GetComponent("SpriteRenderer").sprite.texture
	arg_3_0.script_ = arg_3_0.transform_:GetComponent(typeof(CowRun))
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.Pause(arg_6_0)
	arg_6_0.ani_.enabled = false
	arg_6_0.smokeAni_.enabled = false

	arg_6_0:SetPause(true)
end

function var_0_0.Continue(arg_7_0)
	arg_7_0.ani_.enabled = true
	arg_7_0.smokeAni_.enabled = true

	arg_7_0:SetPause(false)
end

function var_0_0.SetState(arg_8_0, arg_8_1)
	arg_8_0.ani_:Play(arg_8_1)

	if arg_8_1 == "fall" then
		arg_8_0:SetSpeed(arg_8_0.fallSpeed_)
		SetActive(arg_8_0.scoreGo_, true)

		local var_8_0 = 0

		arg_8_0.timer_ = FrameTimer.New(function()
			if var_8_0 > 0 then
				local var_9_0 = arg_8_0.ani_:GetCurrentAnimatorStateInfo(0).speed

				TimeTools.StartAfterSeconds(arg_8_0.fallTime_ / (var_9_0 * var_9_0) * 0.714, function()
					SetActive(arg_8_0.smokeGo_, true)
					arg_8_0.smokeAni_:Play("smoke")
					manager.audio:PlayEffect("minigame_activity_1_3", "minigame_fall", "")
				end, {})
			end

			var_8_0 = var_8_0 + 1
		end, 1, 2)

		arg_8_0.timer_:Start()
	end
end

function var_0_0.SetData(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.data_ = arg_11_1
	arg_11_0.speed_ = arg_11_2 or 100
	arg_11_0.fallSpeed_ = arg_11_3 or 100

	arg_11_0:SetSpeed(arg_11_0.speed_)

	local var_11_0 = arg_11_0.gameObject_:GetComponent("SpriteRenderer").sprite.texture
	local var_11_1 = arg_11_0.gameObject_:GetComponent("SpriteRenderer").size
	local var_11_2 = var_11_1.x / var_11_0.width
	local var_11_3 = var_11_1.y / var_11_0.height

	arg_11_0.hitTrans_ = {}
	arg_11_0.hitTrans_ = {
		hitLeft = var_11_1.x / 2 - arg_11_1.hitLeft * var_11_2,
		hitRight = var_11_1.x / 2 - arg_11_1.hitRight * var_11_2
	}
	arg_11_0.width_ = var_11_1.x

	for iter_11_0 = 1, arg_11_0.ani_.runtimeAnimatorController.animationClips.Length do
		local var_11_4 = arg_11_0.ani_.runtimeAnimatorController.animationClips[iter_11_0]

		if var_11_4.name == "fall" then
			arg_11_0.fallTime_ = var_11_4.length

			break
		end
	end

	arg_11_0.isHitOrTaunt_ = false
	arg_11_0.isPass_ = false

	SetActive(arg_11_0.scoreGo_, false)
	SetActive(arg_11_0.smokeGo_, false)
end

function var_0_0.SetIsHitOrTaunt(arg_12_0)
	arg_12_0.isHitOrTaunt_ = true
end

function var_0_0.GetIsHitOrTaunt(arg_13_0)
	return arg_13_0.isHitOrTaunt_
end

function var_0_0.SetIsPass(arg_14_0)
	arg_14_0.isPass_ = true
end

function var_0_0.GetIsPass(arg_15_0)
	return arg_15_0.isPass_
end

function var_0_0.GetData(arg_16_0)
	return arg_16_0.data_
end

function var_0_0.GetWidth(arg_17_0)
	return arg_17_0.width_
end

function var_0_0.GetHitRect(arg_18_0)
	return arg_18_0.hitTrans_
end

function var_0_0.SetSpeed(arg_19_0, arg_19_1)
	if arg_19_0.script_ then
		arg_19_0.script_:SetSpeed(arg_19_1)
	end
end

function var_0_0.SetPause(arg_20_0, arg_20_1)
	if arg_20_0.script_ then
		arg_20_0.script_:SetPause(arg_20_1)
	end
end

function var_0_0.SetStop(arg_21_0, arg_21_1)
	if arg_21_0.script_ then
		arg_21_0.script_:SetStop(arg_21_1)
	end
end

function var_0_0.OnExit(arg_22_0)
	Object.Destroy(arg_22_0.gameObject_)
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
