LoopScrollViewBaseItem = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")

local var_0_0 = class("AdminChipBaseItem", LoopScrollViewBaseItem)

function var_0_0.Show(arg_1_0, arg_1_1)
	if not arg_1_1 and arg_1_0.playingAni_ then
		arg_1_0.animInfo_.aniNormTime_ = arg_1_0:GetAnimTime()
	end

	var_0_0.super.Show(arg_1_0, arg_1_1)
end

function var_0_0.GetAnimTime(arg_2_0)
	local var_2_0 = arg_2_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime

	if var_2_0 > 0.999 then
		return 1
	end

	return var_2_0
end

function var_0_0.UpdateAnim(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0.animInfo_.inited then
		arg_3_0.animInfo_.inited = true
		arg_3_0.animInfo_.aniNormTime_ = 1
		arg_3_0.animInfo_.selected = arg_3_1
		arg_3_0.playingAni_ = arg_3_2
	end

	if arg_3_0.animInfo_.selected ~= arg_3_1 then
		arg_3_0.animInfo_.selected = arg_3_1
		arg_3_0.animInfo_.aniNormTime_ = 0
	elseif arg_3_0.animator_:GetCurrentAnimatorStateInfo(0):IsName(arg_3_0.playingAni_) then
		arg_3_0.animInfo_.aniNormTime_ = arg_3_0:GetAnimTime()
	end

	arg_3_0.playingAni_ = arg_3_2

	arg_3_0.animator_:Play(arg_3_0.playingAni_, -1, arg_3_0.animInfo_.aniNormTime_)
	arg_3_0.animator_:Update(0)
end

return var_0_0
