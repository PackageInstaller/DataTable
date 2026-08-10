local var_0_0 = class("AutoChessSubLabelView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
	arg_1_0:SetActive(true)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListener()
	arg_2_0:InitContext()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.UiGradientCompoment = arg_3_0:FindCom("UIGradient", nil, arg_3_0.descTrans_)
	arg_3_0.iconController_ = arg_3_0.controller_:GetController("state")
end

function var_0_0.InitContext(arg_4_0)
	arg_4_0.context_ = {
		score = 1,
		data_uid = 1,
		base_praise_num = 666,
		is_praise = false
	}
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.praiseBtn_, nil, function()
		if arg_5_0.isCanVote_ then
			manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_zan", "")

			arg_5_0.context_.is_praise = not arg_5_0.context_.is_praise

			arg_5_0:UpdateView()

			if arg_5_0.context_.is_praise then
				OperationRecorder.RecordButtonTouch({
					button_name = "activity_autochess_profile_like_touch",
					activity_id = AutoChessData:GetActivityID(),
					polyhedron_id_str = AutoChessData:GetPlayerData().battleUID,
					profile_label = arg_5_0.context_.data_uid
				})
			end
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.context_.data_uid = arg_7_1
	arg_7_0.context_.score = arg_7_2
	arg_7_0.context_.is_praise = false

	local var_7_0 = AutoChessTeamTagCfg[arg_7_1].vote_range[arg_7_2]

	arg_7_0.context_.base_praise_num = math.random(var_7_0[1], var_7_0[2])
	arg_7_0.isCanVote_ = arg_7_3
	arg_7_0.parentWidth_ = arg_7_4

	if not arg_7_0.isCanVote_ then
		arg_7_0.context_.is_praise = true
	end

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	local var_8_0 = AutoChessTeamTagCfg[arg_8_0.context_.data_uid]

	arg_8_0.descText_.text = var_8_0.name
	arg_8_0.numText_.text = arg_8_0.context_.is_praise and tostring(arg_8_0.context_.base_praise_num + 1) or tostring(arg_8_0.context_.base_praise_num)

	arg_8_0.iconController_:SetSelectedState("not")

	if arg_8_0.context_.score == 3 then
		arg_8_0.UiGradientCompoment.enabled = true

		if arg_8_0.context_.is_praise then
			arg_8_0.iconController_:SetSelectedState("toplike")
		end
	elseif arg_8_0.context_.score == 2 then
		arg_8_0.UiGradientCompoment.enabled = false

		if arg_8_0.context_.is_praise then
			arg_8_0.iconController_:SetSelectedState("like")
		end
	end
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	arg_9_0.gameObject_:SetActive(arg_9_1)
end

function var_0_0.GetLocalPosX(arg_10_0)
	return arg_10_0.transform_.localPosition.x
end

function var_0_0.SetMaxWidth(arg_11_0, arg_11_1)
	arg_11_0.maxWidth_ = arg_11_1

	arg_11_0:UpdateLeanTween()
end

function var_0_0.UpdateLeanTween(arg_12_0)
	arg_12_0:StopTimer()

	local var_12_0 = 150
	local var_12_1 = arg_12_0.parentWidth_ / 2 - arg_12_0.maxWidth_

	arg_12_0.frameTimer = FrameTimer.New(function()
		if arg_12_0.transform_.localPosition.x < var_12_1 then
			arg_12_0.transform_.localPosition = Vector2.New(arg_12_0.parentWidth_ / 2 + arg_12_0.transform_.rect.width / 2 + 100, arg_12_0.transform_.localPosition.y)
		end

		arg_12_0.transform_.localPosition = Vector2.New(arg_12_0.transform_.localPosition.x - Time.deltaTime * var_12_0, arg_12_0.transform_.localPosition.y)
	end, 1, -1)

	arg_12_0.frameTimer:Start()
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.frameTimer then
		arg_14_0.frameTimer:Stop()

		arg_14_0.frameTimer = nil
	end
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:StopTimer()
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
