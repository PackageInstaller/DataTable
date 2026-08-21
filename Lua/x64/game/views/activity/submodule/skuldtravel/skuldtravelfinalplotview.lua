local var_0_0 = class("SkuldTravelFinalPlotView", ReduxView)
local var_0_1 = "TextureConfig/EmptyDream/travel/image/"

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelEndDetails"
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
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgbtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = TravelSkuldEndingCfg[arg_8_0.params_.endingid]

	arg_8_0.stroytext_.text = GetI18NText(var_8_0.story_word)
	arg_8_0.storyname_.text = GetI18NText(var_8_0.story_name)

	local var_8_1 = var_0_1

	if SkuldTravelData:GetSkuldBtnIsBreach() then
		var_8_1 = var_8_1 .. var_8_0.destroy_picture
	else
		var_8_1 = var_8_1 .. var_8_0.picture
	end

	arg_8_0.itemimage_.sprite = pureGetSpriteWithoutAtlas(var_8_1)

	SetActive(arg_8_0.panelGo_, false)
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
