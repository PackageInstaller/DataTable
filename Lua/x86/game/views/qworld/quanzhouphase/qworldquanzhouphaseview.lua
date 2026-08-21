local var_0_0 = class("QWorldQuanzhouPhaseView", import("game.extend.ReduxView"))
local var_0_1 = {
	6.5,
	6.2,
	4
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Com/QuanZhou_InterludeUI"
end

function var_0_0.Ctor(arg_2_0)
	arg_2_0.gameObject_ = Object.Instantiate(Asset.Load(arg_2_0:UIName()), manager.ui.uiMessage.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:AdaptScreen()
	arg_2_0:Hide()
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.timeLineList_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.timeLineList_[iter_3_0] = arg_3_0["timeLine_" .. iter_3_0]
	end

	arg_3_0.timeLineController_ = arg_3_0.transCon_:GetController("timeLine")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnClose_, nil, function()
		if arg_4_0.canClick_ then
			QWorldQuanzhouNotify:Hide()
			QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_RECEIVE_EVENT, QWorldQuestConst.LISTENING_EVENT["EVENT_QUANZHOU_PHASE_CLOSE_" .. QWorldData:GetNowPhaseId() - 1])
		end
	end)
end

function var_0_0.SetData(arg_6_0)
	arg_6_0.nowPhase_ = QWorldData:GetNowPhaseId() - 1
	arg_6_0.nowPhaseCfg_ = QuanzhouPhaseCfg[arg_6_0.nowPhase_]
	arg_6_0.nextPhaseCfg_ = QuanzhouPhaseCfg[arg_6_0.nowPhaseCfg_.nextphase]
end

function var_0_0.Show(arg_7_0)
	arg_7_0.gameObject_:SetActive(true)
	arg_7_0.transform_:SetAsLastSibling()
	arg_7_0:RefreshUI()
	arg_7_0:AddTipsTimer()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.timeLineController_:SetSelectedState(arg_8_0.nowPhase_)

	local var_8_0 = arg_8_0.timeLineList_[arg_8_0.nowPhase_]

	if arg_8_0.nextPhaseCfg_ then
		arg_8_0.titleText_.text = arg_8_0.nowPhaseCfg_.name
		arg_8_0.nowTitleImg_.sprite = pureGetSpriteWithoutAtlas(arg_8_0.nowPhaseCfg_.icon)
		arg_8_0.nextTitleImg_.sprite = pureGetSpriteWithoutAtlas(arg_8_0.nextPhaseCfg_.icon)

		TimelineTools.PlayTimelineWithCallback(var_8_0, var_8_0.playableAsset, function()
			var_8_0.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Hold
			var_8_0.time = var_8_0.duration

			var_8_0:Evaluate()

			arg_8_0.timelineComplete_ = true
		end)
	else
		arg_8_0.timelineComplete_ = true
	end

	arg_8_0:CheckTitleAnim()
end

function var_0_0.AddTipsTimer(arg_10_0)
	local var_10_0 = arg_10_0.nextPhaseCfg_.start_time
	local var_10_1 = arg_10_0.nextPhaseCfg_.show_time
	local var_10_2 = #arg_10_0.nextPhaseCfg_.tips_desc

	arg_10_0.tipsComplete_ = false
	arg_10_0.startTimer_ = Timer.New(function()
		local var_11_0 = 1

		arg_10_0.tipsTimer_ = Timer.New(function()
			if var_11_0 <= var_10_2 then
				arg_10_0.tipIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SandPlay/MiniIcon/" .. arg_10_0.nextPhaseCfg_.tips_icon[var_11_0])
				arg_10_0.tipsText_.text = arg_10_0.nextPhaseCfg_.tips_desc[var_11_0]
				var_11_0 = var_11_0 + 1

				arg_10_0.tipsAnim_:Play("UI_nd1_cx_01", -1, 0)
				arg_10_0.tipsAnim_:Update(0)
			else
				arg_10_0.tipsTimer_:Stop()

				arg_10_0.tipsTimer_ = nil
				arg_10_0.tipsComplete_ = true
			end
		end, var_10_1, -1)

		arg_10_0.tipsTimer_:Start()
		arg_10_0.startTimer_:Stop()

		arg_10_0.startTimer_ = nil
	end, var_10_0, 1)

	arg_10_0.startTimer_:Start()

	arg_10_0.endTimer_ = Timer.New(function()
		if arg_10_0.timelineComplete_ and arg_10_0.tipsComplete_ then
			AnimatorTools.PlayAnimatorWithCallback(arg_10_0.lastAnim_, "UI_text_cx", function()
				arg_10_0.canClick_ = true

				arg_10_0.endTimer_:Stop()

				arg_10_0.endTimer_ = nil
			end)
		end
	end, 0.33, -1)

	arg_10_0.endTimer_:Start()
end

function var_0_0.CheckTitleAnim(arg_15_0)
	if arg_15_0.timer_ ~= nil then
		arg_15_0.timer_:Stop()
	end

	arg_15_0.timer_ = Timer.New(function()
		arg_15_0:ChangeTitle()
	end, var_0_1[arg_15_0.nowPhase_], 1)

	arg_15_0.timer_:Start()
end

function var_0_0.ChangeTitle(arg_17_0)
	if arg_17_0.nextPhaseCfg_ then
		arg_17_0.titleText_.text = arg_17_0.nextPhaseCfg_.name
	end
end

function var_0_0.Hide(arg_18_0)
	if arg_18_0.gameObject_ then
		arg_18_0.canClick_ = false
		arg_18_0.timelineComplete_ = false
		arg_18_0.tipsComplete_ = false

		SetActive(arg_18_0.gameObject_, false)

		if arg_18_0.timer_ ~= nil then
			arg_18_0.timer_:Stop()

			arg_18_0.timer_ = nil
		end

		if arg_18_0.startTimer_ ~= nil then
			arg_18_0.startTimer_:Stop()

			arg_18_0.startTimer_ = nil
		end

		if arg_18_0.tipsTimer_ ~= nil then
			arg_18_0.tipsTimer_:Stop()

			arg_18_0.tipsTimer_ = nil
		end

		if arg_18_0.endTimer_ ~= nil then
			arg_18_0.endTimer_:Stop()

			arg_18_0.endTimer_ = nil
		end
	end
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:Hide()
	GameObject.Destroy(arg_19_0.gameObject_)
	Asset.Unload(arg_19_0:UIName())
	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
