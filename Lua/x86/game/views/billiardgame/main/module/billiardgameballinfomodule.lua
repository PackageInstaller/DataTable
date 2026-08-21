local var_0_0 = class("BilliardGameBallInfoModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.ballBtn_, nil, function()
		if manager.guide:IsPlaying() then
			return
		end

		SetActive(arg_3_0.tipsGo_, true)
	end)
	arg_3_0:AddBtnListener(arg_3_0.hideTipsBtn_, nil, function()
		if manager.guide:IsPlaying() then
			return
		end

		SetActive(arg_3_0.tipsGo_, false)
	end)
end

function var_0_0.OnEnter(arg_6_0, arg_6_1)
	local var_6_0 = MergeBallVehicleCfg[arg_6_1]

	arg_6_0.nameText_.text = var_6_0.name
	arg_6_0.descText_.text = var_6_0.desc
	arg_6_0.iconImg_.sprite = pureGetSpriteWithoutAtlas(var_6_0.icon_small)
	arg_6_0.maxHp_ = var_6_0.param[2]
	arg_6_0.nowHp_ = arg_6_0.maxHp_
	arg_6_0.nowBufferHp_ = arg_6_0.maxHp_
	arg_6_0.hpText_.text = arg_6_0.nowHp_ .. "/" .. arg_6_0.maxHp_
	arg_6_0.ballHpFillImg_.fillAmount = 1
end

function var_0_0.RefreshHp(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0.nowHp_ then
		return
	end

	arg_7_0:RemoveTween()

	arg_7_0.ballHpFillImg_.fillAmount = arg_7_1 / arg_7_0.maxHp_
	arg_7_0.nowHp_ = arg_7_1
	arg_7_0.hpText_.text = string.format("%d/%d", math.floor(arg_7_1), arg_7_0.maxHp_)

	local var_7_0 = arg_7_0.nowBufferHp_

	arg_7_0.bufferTween_ = LeanTween.value(var_7_0, arg_7_1, 1):setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
		arg_7_0.nowBufferHp_ = arg_8_0
		arg_7_0.ballHpBufferFillImg_.fillAmount = arg_8_0 / arg_7_0.maxHp_
	end)):setOnComplete(System.Action(function()
		arg_7_0:RemoveTween()
	end))
end

function var_0_0.RemoveTween(arg_10_0)
	if arg_10_0.bufferTween_ then
		arg_10_0.bufferTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_10_0.bufferTween_.id)

		arg_10_0.bufferTween_ = nil
		arg_10_0.ballHpBufferFillImg_.fillAmount = arg_10_0.nowHp_ / arg_10_0.maxHp_
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveTween()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
