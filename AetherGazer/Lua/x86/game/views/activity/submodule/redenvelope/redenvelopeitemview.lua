local var_0_0 = class("RedEnvelopeItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.headCon_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("head")
	arg_3_0.starCon_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("star")
	arg_3_0.getCon_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("get")
	arg_3_0.flipCon_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("flip")
	arg_3_0.blingCon_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("showBling")
	arg_3_0.selectCon_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("select")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.isGet then
			-- block empty
		elseif arg_4_0.receiveFunc_ then
			arg_4_0.selectCon_:SetSelectedIndex(1)
			arg_4_0.receiveFunc_(arg_4_0.index)
		end
	end)
end

function var_0_0.SetStarCtl(arg_6_0, arg_6_1)
	arg_6_0.starCon_:SetSelectedIndex(arg_6_1)
end

function var_0_0.SetHeadCtl(arg_7_0, arg_7_1)
	arg_7_0.headCon_:SetSelectedIndex(arg_7_1)

	if arg_7_1 == 1 then
		arg_7_0.blingCon_:SetSelectedIndex(math.random(0, 1))
		arg_7_0:BlingTimer()

		return
	end

	arg_7_0.blingCon_:SetSelectedIndex(arg_7_1)
end

function var_0_0.SetGetCtl(arg_8_0, arg_8_1)
	arg_8_0.getCon_:SetSelectedIndex(arg_8_1)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.isGet = arg_9_1
	arg_9_0.curSelectDay = RedEnvelopeData:GetCurSelectDay()

	arg_9_0:StopTimer()
	arg_9_0:StopTimerHideMeme()
	SetActive(arg_9_0.memeGo_, false)

	for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
		if arg_9_0.curSelectDay == iter_9_1.id - 1000 then
			for iter_9_2, iter_9_3 in ipairs(iter_9_1.hero_reward) do
				if iter_9_3.location == arg_9_0.index then
					arg_9_0.reward_list = iter_9_3.reward_list
					arg_9_0.hero_id = iter_9_3.hero_id

					break
				end
			end
		end
	end

	if arg_9_1 then
		arg_9_0.itemAnim_:Play("empty")
		arg_9_0.flipAnim_:Play("empty")

		if arg_9_0.reward_list and arg_9_0.reward_list[1] and arg_9_0.numTxt_ then
			arg_9_0.numTxt_.text = arg_9_0.reward_list[1].num
		end

		if arg_9_0.hero_id and arg_9_0.hero_id == 1 then
			local var_9_0 = RedEnvelopeData:GetCurSelectDay() + 1000

			arg_9_0.hero_id = ActivitySpringRedEnvelopeCfg[var_9_0].letter_people
		end

		arg_9_0.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_3_10/SandPlay_3_10/SandPlay_3_10_RedEnvelope/RedEnvelope_head_" .. arg_9_0.hero_id)
	end
end

function var_0_0.RefreshView(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.isGet = arg_10_1
	arg_10_0.curSelectDay = RedEnvelopeData:GetCurSelectDay()

	arg_10_0:StopTimer()
	arg_10_0:StopTimerHideMeme()
	SetActive(arg_10_0.memeGo_, false)

	for iter_10_0, iter_10_1 in ipairs(arg_10_2) do
		if arg_10_0.curSelectDay == iter_10_1.id - 1000 then
			for iter_10_2, iter_10_3 in ipairs(iter_10_1.hero_reward) do
				if iter_10_3.location == arg_10_0.index then
					arg_10_0.reward_list = iter_10_3.reward_list
					arg_10_0.hero_id = iter_10_3.hero_id

					break
				end
			end
		end
	end

	if arg_10_1 then
		arg_10_0.flipCon_:SetSelectedIndex(0)
		arg_10_0.itemAnim_:Play("empty")

		if arg_10_0.reward_list and arg_10_0.reward_list[1] and arg_10_0.numTxt_ then
			arg_10_0.numTxt_.text = arg_10_0.reward_list[1].num
		end

		if arg_10_0.hero_id and arg_10_0.hero_id == 1 then
			local var_10_0 = RedEnvelopeData:GetCurSelectDay() + 1000

			arg_10_0.hero_id = ActivitySpringRedEnvelopeCfg[var_10_0].letter_people

			arg_10_0.starCon_:SetSelectedIndex(1)
			arg_10_0.headCon_:SetSelectedIndex(0)
			arg_10_0.blingCon_:SetSelectedIndex(0)
			arg_10_0.getCon_:SetSelectedIndex(1)
		else
			arg_10_0.starCon_:SetSelectedIndex(0)
			arg_10_0.headCon_:SetSelectedIndex(1)
			arg_10_0.blingCon_:SetSelectedIndex(0)
			arg_10_0.getCon_:SetSelectedIndex(0)
			arg_10_0:RefreshMemeIcon()
		end

		arg_10_0.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_3_10/SandPlay_3_10/SandPlay_3_10_RedEnvelope/RedEnvelope_head_" .. arg_10_0.hero_id)
	else
		arg_10_0.flipCon_:SetSelectedIndex(1)
		arg_10_0.starCon_:SetSelectedIndex(0)
		arg_10_0.headCon_:SetSelectedIndex(0)
		arg_10_0.blingCon_:SetSelectedIndex(0)
		arg_10_0.getCon_:SetSelectedIndex(0)
		arg_10_0.itemAnim_:Play("UI_talk_cx")
		arg_10_0.itemAnim_:Update(0)
	end
end

function var_0_0.StopBlingTimer(arg_11_0)
	if arg_11_0.blingTimer_ then
		arg_11_0.blingTimer_:Stop()

		arg_11_0.blingTimer_ = nil
	end
end

function var_0_0.BlingTimer(arg_12_0)
	arg_12_0:StopBlingTimer()

	arg_12_0.blingTimer_ = Timer.New(function()
		arg_12_0.blingCon_:SetSelectedIndex(0)
	end, 2, -1)

	arg_12_0.blingTimer_:Start()
end

function var_0_0.RefreshMemeIcon(arg_14_0, arg_14_1)
	if arg_14_0.index == arg_14_1 then
		SetActive(arg_14_0.memeGo_, false)

		return
	end

	arg_14_0.meme_list = {}

	local var_14_0 = ActivitySpringRedEnvelopeCfg[arg_14_0.curSelectDay + 1000].hero_meme_list

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1[1] == arg_14_0.hero_id then
			arg_14_0.meme_list = iter_14_1[2]
			arg_14_0.delayTime = iter_14_1[3]

			break
		end
	end

	if arg_14_0.meme_list and #arg_14_0.meme_list > 0 then
		arg_14_0:AddTimer()
	end
end

function var_0_0.AddTimer(arg_15_0)
	arg_15_0:StopTimer()

	arg_15_0.timer_ = Timer.New(function()
		SetActive(arg_15_0.memeGo_, true)

		local var_16_0 = math.random(1, #arg_15_0.meme_list)
		local var_16_1 = arg_15_0.meme_list[var_16_0]

		arg_15_0.memeImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chat/ChatSticker/" .. var_16_1)

		arg_15_0:StopTimer()
		arg_15_0:HideMeme()
	end, arg_15_0.delayTime, -1)

	arg_15_0.timer_:Start()
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

function var_0_0.HideMeme(arg_18_0)
	arg_18_0:StopTimerHideMeme()

	local var_18_0 = GameSetting.chatsticker_show_time.value[1]

	arg_18_0.timer_hidememe = Timer.New(function()
		SetActive(arg_18_0.memeGo_, false)
		arg_18_0:StopTimerHideMeme()
	end, var_18_0, -1)

	arg_18_0.timer_hidememe:Start()
end

function var_0_0.StopTimerHideMeme(arg_20_0)
	if arg_20_0.timer_hidememe then
		arg_20_0.timer_hidememe:Stop()

		arg_20_0.timer_hidememe = nil
	end
end

function var_0_0.RegisterClickFunc(arg_21_0, arg_21_1)
	arg_21_0.receiveFunc_ = arg_21_1
end

function var_0_0.RefreshAnim(arg_22_0)
	arg_22_0.selectCon_:SetSelectedIndex(0)
	arg_22_0.flipCon_:SetSelectedIndex(0)
	arg_22_0.flipAnim_:Play("UI_card_cx")
	arg_22_0.flipAnim_:Update(0)
end

function var_0_0.OnExit(arg_23_0)
	arg_23_0:StopTimer()
	arg_23_0:StopTimerHideMeme()
	arg_23_0:StopBlingTimer()
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
