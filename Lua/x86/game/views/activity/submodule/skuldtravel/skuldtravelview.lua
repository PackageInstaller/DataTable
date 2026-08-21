local var_0_0 = class("SkuldTravelView", ReduxView)
local var_0_1 = {
	{
		x = 368,
		y = -420
	},
	{
		x = -183,
		y = -352
	}
}
local var_0_2 = {
	55,
	33
}

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelmain"
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

	arg_4_0.cacheOpenPlotView_ = false
	arg_4_0.skuldcontroller_ = ControllerUtil.GetController(arg_4_0.mytrans_, "Skuld")
	arg_4_0.btncontroller_ = ControllerUtil.GetController(arg_4_0.btntrans_, "btnstatu")
	arg_4_0.skuldSpine_ = arg_4_0.skuldGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_4_0.curState_ = "idle"
	arg_4_0.statusAndNextStatus_ = {
		camera = {
			"idle",
			"sit"
		},
		idle = {
			"camera",
			"sit"
		},
		sit = {
			"camera",
			"idle",
			"sleep",
			"sleep"
		},
		sleep = {
			"sit"
		}
	}
	arg_4_0.statusWaitCount_ = {
		sleep = 5,
		sit = 3,
		idle = 3,
		camera = 1
	}
	arg_4_0.statusAndNextStatusAudio_ = {
		camera = {
			sit = "minigame_activity_1_6_up"
		},
		idle = {
			sit = "minigame_activity_1_6_up",
			camera = "minigame_activity_1_6_camera"
		},
		sit = {
			sleep = "minigame_activity_1_6_up",
			idle = "minigame_activity_1_6_down",
			camera = "minigame_activity_1_6_camera"
		},
		sleep = {
			sit = "minigame_activity_1_6_down"
		}
	}
	arg_4_0.aniwait_ = arg_4_0.statusWaitCount_[arg_4_0.curState_]
end

function var_0_0.CreatTiemrAndStart(arg_5_0)
	if arg_5_0.skuldtimer_ == nil then
		arg_5_0.skuldtimer_ = Timer.New(function()
			if arg_5_0.aniwait_ > 1 then
				arg_5_0.aniwait_ = arg_5_0.aniwait_ - 1
			else
				local var_6_0 = arg_5_0.statusAndNextStatus_[arg_5_0.curState_]
				local var_6_1 = math.random(#var_6_0)

				arg_5_0:CheckSkuldPosition(arg_5_0.curState_, var_6_0[var_6_1])
				arg_5_0:PlaySkuldAudio(arg_5_0.curState_, var_6_0[var_6_1])

				arg_5_0.curState_ = var_6_0[var_6_1]

				arg_5_0.skuldSpine_.AnimationState:SetAnimation(0, arg_5_0.curState_, true)

				arg_5_0.aniwait_ = arg_5_0.statusWaitCount_[arg_5_0.curState_]
			end
		end, 4, -1)
	end

	arg_5_0.skuldtimer_:Start()
	arg_5_0.skuldSpine_.AnimationState:SetAnimation(0, arg_5_0.curState_, true)
	arg_5_0:FixSkuldPosition()

	if arg_5_0.curState_ == "camera" then
		manager.audio:PlayEffect("minigame_activity_1_6", "minigame_activity_1_6_camera", "")
	end
end

function var_0_0.CheckSkuldPosition(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.skuldGo_.transform.localPosition
	local var_7_1 = 0

	if (arg_7_1 == "idle" or arg_7_1 == "camera") and arg_7_2 == "sit" then
		var_7_1 = var_0_2[arg_7_0.curSkuldStatu_]
	end

	if arg_7_1 == "sit" and (arg_7_2 == "idle" or arg_7_2 == "camera") then
		var_7_1 = -var_0_2[arg_7_0.curSkuldStatu_]
	end

	arg_7_0.skuldGo_.transform.localPosition = Vector3.New(var_7_0.x, var_7_0.y + var_7_1, var_7_0.z)
end

function var_0_0.FixSkuldPosition(arg_8_0)
	if arg_8_0.curState_ == "sit" or arg_8_0.curState_ == "sleep" then
		local var_8_0 = arg_8_0.skuldGo_.transform.localPosition
		local var_8_1 = 0
		local var_8_2 = var_0_2[arg_8_0.curSkuldStatu_]

		arg_8_0.skuldGo_.transform.localPosition = Vector3.New(var_8_0.x, var_8_0.y + var_8_2, var_8_0.z)
	end
end

function var_0_0.PlaySkuldAudio(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.statusAndNextStatusAudio_[arg_9_1][arg_9_2]

	manager.audio:PlayEffect("minigame_activity_1_6", var_9_0, "")
end

function var_0_0.AddUIListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.gototravelbtn_, nil, function()
		if SkuldTravelData:GetSkuldIsCanTravel() then
			arg_10_0:Go("/skuldTravelMapView")
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.plotbtn_, nil, function()
		arg_10_0:Go("/skuldTravelShowPlotView")
	end)
	arg_10_0:AddBtnListener(arg_10_0.finalresultbtn_, nil, function()
		arg_10_0:Go("/skuldTravelFinalResultView")
	end)
	arg_10_0:AddBtnListener(arg_10_0.rewardbtn_, nil, function()
		JumpTools.OpenPageByJump("skuldTravelRewardView")
	end)
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:BindUIAndRedPoint()
end

function var_0_0.RandomSkuldPosition(arg_16_0)
	local var_16_0 = math.random(2)

	arg_16_0.curSkuldStatu_ = var_16_0
	arg_16_0.position_ = var_0_1[var_16_0]
	arg_16_0.skuldGo_.transform.localPosition = Vector3.New(arg_16_0.position_.x, arg_16_0.position_.y, 0)
end

function var_0_0.OnTop(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("TRAVEL_SKULD_DESCRIPE")

	if arg_17_0.cacheOpenPlotView_ then
		arg_17_0.cacheOpenPlotView_ = false

		JumpTools.OpenPageByJump("skuldTravelResultView")
	end

	arg_17_0:RandomSkuldPosition()
	arg_17_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_18_0)
	local var_18_0 = SkuldTravelData:GetAttrib()

	for iter_18_0 = 1, 4 do
		arg_18_0["attribtext_" .. iter_18_0].text = GetI18NText(var_18_0[iter_18_0])
	end

	arg_18_0:RefreshStatu()
end

function var_0_0.RefreshStatu(arg_19_0)
	if SkuldTravelData:GetSkuldBtnIsBreach() then
		arg_19_0.skuldcontroller_:SetSelectedState("breach")
		SetActive(arg_19_0.gototravelbtn_.gameObject, false)
		arg_19_0:RemoveTiemr()

		return
	else
		SetActive(arg_19_0.gototravelbtn_.gameObject, true)
	end

	if SkuldTravelData:GetSkuldStatu() == 0 then
		arg_19_0.skuldcontroller_:SetSelectedState("home")
		arg_19_0.btncontroller_:SetSelectedState("home")
		arg_19_0:CreatTiemrAndStart()
	elseif SkuldTravelData:GetSkuldStatu() == 1 then
		arg_19_0.skuldcontroller_:SetSelectedState("travel")
		arg_19_0.btncontroller_:SetSelectedState("travel")
		arg_19_0:RemoveTiemr()
	elseif SkuldTravelData:GetSkuldStatu() == 2 then
		arg_19_0.skuldcontroller_:SetSelectedState("travel")
		arg_19_0.btncontroller_:SetSelectedState("travel")
		arg_19_0:RemoveTiemr()

		if arg_19_0:IsOpenSkuldTravelingView() then
			arg_19_0.cacheOpenPlotView_ = true
		else
			JumpTools.OpenPageByJump("skuldTravelResultView")
		end
	end
end

function var_0_0.OnSkuldStateChange(arg_20_0)
	arg_20_0:RandomSkuldPosition()
	arg_20_0:RefreshUI()
end

function var_0_0.OnExit(arg_21_0)
	manager.windowBar:HideBar()
	manager.audio:StopEffect()
	arg_21_0:RemoveTiemr()
	arg_21_0:UnBindUIAndRedPoint()
end

function var_0_0.OnBehind(arg_22_0)
	manager.windowBar:HideBar()
	manager.audio:StopEffect()
	arg_22_0:RemoveTiemr()
end

function var_0_0.RemoveTiemr(arg_23_0)
	if arg_23_0.skuldtimer_ then
		arg_23_0.skuldtimer_:Stop()

		arg_23_0.skuldtimer_ = nil
	end
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0:RemoveTiemr()
	arg_24_0.super.Dispose(arg_24_0)
end

function var_0_0.BindUIAndRedPoint(arg_25_0)
	local var_25_0 = RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	local var_25_1 = RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	local var_25_2 = RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	manager.redPoint:bindUIandKey(arg_25_0.gototravelbtn_.transform, var_25_0)
	manager.redPoint:bindUIandKey(arg_25_0.finalresultbtn_.transform, var_25_1)
	manager.redPoint:bindUIandKey(arg_25_0.rewardbtn_.transform, var_25_2)
end

function var_0_0.UnBindUIAndRedPoint(arg_26_0)
	local var_26_0 = RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	local var_26_1 = RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
	local var_26_2 = RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	manager.redPoint:unbindUIandKey(arg_26_0.gototravelbtn_.transform, var_26_0)
	manager.redPoint:unbindUIandKey(arg_26_0.finalresultbtn_.transform, var_26_1)
	manager.redPoint:unbindUIandKey(arg_26_0.rewardbtn_.transform, var_26_2)
end

function var_0_0.IsOpenSkuldTravelingView(arg_27_0)
	return arg_27_0:IsOpenRoute("skuldTravelTipsView")
end

return var_0_0
