local var_0_0 = class("ActivityPtScrollPopItem", ReduxView)

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
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.RefreshData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.data_ = arg_6_1
	arg_6_0.handler_ = arg_6_2
	arg_6_0.viewHeight_ = arg_6_3
	arg_6_0.height_ = arg_6_0.transform_.rect.height
	arg_6_0.centerY_ = centerY

	arg_6_0:RefreshUI()
	arg_6_0:RefreshScroll()
end

function var_0_0.RefreshUI(arg_7_0)
	if arg_7_0.data_.useless then
		local var_7_0 = ActivityPtRouletteTipsCfg[arg_7_0.data_.affix]

		arg_7_0.title_.text = var_7_0.name
		arg_7_0.desc_.text = var_7_0.desc
		arg_7_0.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. var_7_0.icon)
	else
		arg_7_0.title_.text = getAffixName({
			arg_7_0.data_.affix
		})
		arg_7_0.desc_.text = getAffixDesc({
			arg_7_0.data_.affix,
			arg_7_0.data_.level
		})
		arg_7_0.icon_.sprite = getAffixSprite({
			arg_7_0.data_.affix
		})
	end

	arg_7_0.icon_:SetNativeSize()
end

function var_0_0.RefreshScroll(arg_8_0)
	arg_8_0:StopTimer()
	arg_8_0:RefreshSelf()

	arg_8_0.timer_ = FrameTimer.New(function()
		arg_8_0:RefreshSelf()
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.RefreshSelf(arg_10_0)
	local var_10_0 = arg_10_0.handler_.localPosition.y + arg_10_0.transform_.localPosition.y - 0.5 * arg_10_0.height_
	local var_10_1 = (arg_10_0.viewHeight_ - math.abs(var_10_0)) / arg_10_0.viewHeight_

	arg_10_0.content_.localScale = Vector3(var_10_1, var_10_1, var_10_1)
	arg_10_0.canvas_.alpha = var_10_1
end

function var_0_0.StopTimer(arg_11_0)
	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:StopTimer()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()
	arg_13_0:StopTimer()
	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
