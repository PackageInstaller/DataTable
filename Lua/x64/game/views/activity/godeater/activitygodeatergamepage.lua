ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityGodEaterGamePage", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Entrance/V4_2_GodEaterUI_EntranceUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.super.Init(arg_2_0)

	arg_2_0.preRewardList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexPreviewItem), arg_2_0.rewardListGo_, CommonItemView)
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)
	arg_3_0:OnUpdateView()
	manager.redPoint:bindUIandKey(arg_3_0.btn01Btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_3_0.activityID_), arg_3_0.activityID_))
end

function var_0_0.OnExit(arg_4_0)
	var_0_0.super.OnExit(arg_4_0)
	manager.redPoint:unbindUIandKey(arg_4_0.btn01Btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_4_0.activityID_), arg_4_0.activityID_))
end

function var_0_0.OnTop(arg_5_0)
	return
end

function var_0_0.OnUpdateView(arg_6_0)
	local var_6_0 = ActivityCfg[arg_6_0.activityID_]

	if var_6_0 and var_6_0.reward_show and var_6_0.reward_show ~= "" then
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(var_6_0.reward_show) do
			table.insert(var_6_1, rewardToItemTemplate({
				id = iter_6_1
			}, nil, true))
		end

		arg_6_0.preRewards_ = ItemTools.SortRewardItemList(var_6_1)

		arg_6_0.preRewardList_:StartScroll(#arg_6_0.preRewards_)
	end
end

function var_0_0.IndexPreviewItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_0.preRewards_[arg_7_1])
end

function var_0_0.RefreshTimeText(arg_8_0)
	arg_8_0.m_timeLab.text = manager.time.WrapTimeStrWithTips(manager.time:GetLostTimeStrWith2Unit(arg_8_0.stopTime_))
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.btn01Btn_, nil, function()
		JumpTools.OpenPageByJump("/ActivityGodEaterGameMainView", {
			activity_id = arg_9_0.activityID_
		})
	end)
	arg_9_0:AddBtnListener(arg_9_0.m_descBtn, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "GOD_EATER_GAME_TIPS_1",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("GOD_EATER_GAME_TIPS_1")
		})
	end)
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.preRewardList_ then
		arg_12_0.preRewardList_:Dispose()

		arg_12_0.preRewardList_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
