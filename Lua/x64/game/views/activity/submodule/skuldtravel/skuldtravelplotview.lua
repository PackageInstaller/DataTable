local var_0_0 = class("SkuldTravelPlotView", ReduxView)
local var_0_1 = "TextureConfig/EmptyDream/travel/item/"

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelDetails"
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

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgbtn_, nil, function()
		if arg_5_0.params_.poltid then
			JumpTools.Back()
		else
			gameContext:Go("/skuldTravelView")
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()

	if not arg_7_0.params_.poltid then
		SkuldTravelAction:ReadTravelResult()
	end

	arg_7_0.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)

	arg_7_0.skuldidle_ = true

	arg_7_0:CreatTiemrAndStart()
end

function var_0_0.CreatTiemrAndStart(arg_8_0)
	if arg_8_0.timer_ == nil then
		arg_8_0.timer_ = Timer.New(function()
			if arg_8_0.skuldidle_ then
				arg_8_0.skuldSpine_.AnimationState:SetAnimation(0, "camera", true)
				manager.audio:PlayEffect("minigame_activity_1_6", "minigame_activity_1_6_camera", "")

				arg_8_0.skuldidle_ = false
			else
				arg_8_0.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)

				arg_8_0.skuldidle_ = true
			end
		end, 4, -1)

		arg_8_0.timer_:Start()
	end
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0

	if arg_10_0.params_.poltid then
		var_10_0 = TravelSkuldStoryCfg[arg_10_0.params_.poltid]
	else
		var_10_0 = TravelSkuldStoryCfg[SkuldTravelData:GetCurPlotId()]
	end

	arg_10_0.nametext_.text = GetI18NText(var_10_0.story_name)
	arg_10_0.stroytext_.text = GetI18NText(var_10_0.story_word)
	arg_10_0.itemnametext_.text = GetI18NText(TravelSkuldItemCfg[var_10_0.item_id].name)
	arg_10_0.itemimage_.sprite = pureGetSpriteWithoutAtlas(var_0_1 .. TravelSkuldItemCfg[var_10_0.item_id].icon)
end

function var_0_0.OnExit(arg_11_0)
	manager.audio:StopEffect()

	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end

	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
