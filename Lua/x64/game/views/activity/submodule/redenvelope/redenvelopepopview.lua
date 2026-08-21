local var_0_0 = class("RedEnvelopePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_3_10/RedEnvelope_3_10/RedEnvelopePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.cardCon_ = arg_4_0.item_:GetComponent("ControllerExCollection"):GetController("card")
	arg_4_0.flipCon_ = arg_4_0.item_:GetComponent("ControllerExCollection"):GetController("flip")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		if not arg_5_0.params_.isGetReward then
			RedEnvelopeData:SetIsFlipCardAnim(true)
		end

		RedEnvelopeData:SetIsResetNormalSelect(false)
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.id = arg_7_0.params_.id
	arg_7_0.hero_id = ActivitySpringRedEnvelopeCfg[arg_7_0.id].letter_people
	arg_7_0.reward_list = arg_7_0.params_.reward_list
	arg_7_0.bgBtn_.enabled = false

	if arg_7_0.params_.isGetReward then
		arg_7_0.isGetReward = arg_7_0.params_.isGetReward
		arg_7_0.bgBtn_.enabled = true
	end

	arg_7_0.cardCon_:SetSelectedIndex(1)
	arg_7_0.flipCon_:SetSelectedIndex(1)
	arg_7_0:RefreshView()
end

function var_0_0.RefreshView(arg_8_0)
	arg_8_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/BackHouseUI/Portrait/" .. arg_8_0.hero_id)
	arg_8_0.num_.text = arg_8_0.reward_list.num
	arg_8_0.talkTxt_.text = ActivitySpringRedEnvelopeCfg[arg_8_0.id].letter_content

	if arg_8_0.isGetReward then
		arg_8_0.cardCon_:SetSelectedIndex(0)
		arg_8_0.flipCon_:SetSelectedIndex(0)
		SetActive(arg_8_0.characterGo_, true)
	else
		arg_8_0:AddTimer()
	end
end

function var_0_0.AddTimer(arg_9_0)
	arg_9_0:StopTimer()

	arg_9_0.timer_ = Timer.New(function()
		arg_9_0.flipCon_:SetSelectedIndex(0)
		arg_9_0.flipAnim_:Play("UI_card_cx")
		arg_9_0.flipAnim_:Update(0)
		arg_9_0:AnimTimer()
		arg_9_0:StopTimer()
	end, 1.5, -1)

	arg_9_0.timer_:Start()
end

function var_0_0.StopTimer(arg_11_0)
	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end
end

function var_0_0.AnimTimer(arg_12_0)
	arg_12_0:StopAnimTimer()

	arg_12_0.animtimer_ = Timer.New(function()
		getReward(formatRewardCfgList({
			arg_12_0.reward_list
		}), nil, function()
			arg_12_0.cardCon_:SetSelectedIndex(0)
			SetActive(arg_12_0.characterGo_, true)
		end)
		arg_12_0:StopAnimTimer()
	end, 1.5, -1)

	arg_12_0.animtimer_:Start()
end

function var_0_0.StopAnimTimer(arg_15_0)
	if arg_15_0.animtimer_ then
		arg_15_0.bgBtn_.enabled = true

		arg_15_0.animtimer_:Stop()

		arg_15_0.animtimer_ = nil
	end
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:StopTimer()
	arg_16_0:StopAnimTimer()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
