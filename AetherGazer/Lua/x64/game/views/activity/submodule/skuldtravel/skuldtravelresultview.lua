local var_0_0 = class("SkuldTravelResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelsettlement"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.skuldSpine_ = arg_4_0.skuldGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_4_0.skuldidle_ = true
end

function var_0_0.CreatTiemrAndStart(arg_5_0)
	if arg_5_0.timer_ == nil then
		arg_5_0.timer_ = Timer.New(function()
			if arg_5_0.skuldidle_ then
				arg_5_0.skuldSpine_.AnimationState:SetAnimation(0, "camera", true)
				manager.audio:PlayEffect("minigame_activity_1_6", "minigame_activity_1_6_camera", "")

				arg_5_0.skuldidle_ = false
			else
				arg_5_0.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)

				arg_5_0.skuldidle_ = true
			end
		end, 4, -1)

		arg_5_0.timer_:Start()
	end
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btn_, nil, function()
		JumpTools.OpenPageByJump("/skuldTravelPlotView")
	end)
	arg_7_0:AddBtnListener(arg_7_0.bgbtn_, nil, function()
		JumpTools.OpenPageByJump("/skuldTravelPlotView")
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:RefreshUI()
	arg_10_0.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)

	arg_10_0.skuldidle_ = true

	arg_10_0:CreatTiemrAndStart()
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = TravelSkuldStoryCfg[SkuldTravelData:GetCurPlotId()]

	for iter_11_0 = 1, 4 do
		SetActive(arg_11_0["attribgo_" .. iter_11_0], false)
	end

	for iter_11_1, iter_11_2 in pairs(var_11_0.attrib_reward) do
		if iter_11_2[2] > 0 then
			SetActive(arg_11_0["attribgo_" .. iter_11_2[1]], true)

			arg_11_0["attribtext_" .. iter_11_2[1]].text = GetI18NText(iter_11_2[2])
		end
	end
end

function var_0_0.OnExit(arg_12_0)
	manager.audio:StopEffect()

	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end

	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
