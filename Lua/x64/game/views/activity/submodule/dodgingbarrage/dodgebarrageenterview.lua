local var_0_0 = class("DodgeBarrageEnterView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/ShashwatUI_3_7/ShashwatUI_3_7_BarrageUI/ShashwatUI_3_7_Barrage01UI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.rewardListGo_, CommonItemView)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		JumpTools.OpenPageByJump("dodgeBarrageMainView")
	end)
	arg_4_0:AddBtnListener(arg_4_0.descBtn_, nil, function()
		local var_6_0 = "ACTIVITY_DODGE_BARRAGE_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_6_0),
			key = var_6_0
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.redPointKey_ = DodgeBarrageData:GetRedPointKey()

	manager.redPoint:bindUIandKey(arg_7_0.goBtn_.transform, arg_7_0.redPointKey_)
	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.rewrdScroll_.horizontalNormalizedPosition = 0
	arg_8_0.activityId_ = DodgeBarrageData:GetActivityId()

	if arg_8_0.updateTimer_ then
		arg_8_0.updateTimer_:Stop()

		arg_8_0.updateTimer_ = nil
	end

	arg_8_0.remainTime = 0
	arg_8_0.remainTime = ActivityData:GetActivityData(arg_8_0.activityId_).stopTime
	arg_8_0.remainTxt_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_8_0.remainTime)
	arg_8_0.updateTimer_ = Timer.New(function()
		arg_8_0.remainTxt_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_8_0.remainTime)
	end, 1, arg_8_0.remainTime - manager.time:GetServerTime() + 1, 1)

	arg_8_0.updateTimer_:Start()

	arg_8_0.describeTxt_.text = GetTips("DODGE_BARRAGE_ENTER_DESCRIBE")

	arg_8_0:RefreshMainReward()
end

function var_0_0.RefreshMainReward(arg_10_0)
	local var_10_0 = DodgeBarrageData:GetTaskList()

	arg_10_0.showRewards_ = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = AssignmentCfg[iter_10_1.id].reward

		for iter_10_2, iter_10_3 in ipairs(var_10_1) do
			local var_10_2 = iter_10_3[1]

			if ItemCfg[var_10_2].rare >= 5 and not table.indexof(arg_10_0.showRewards_, var_10_2) then
				table.insert(arg_10_0.showRewards_, var_10_2)
			end
		end
	end

	table.sort(arg_10_0.showRewards_, function(arg_11_0, arg_11_1)
		return arg_11_0 < arg_11_1
	end)
	arg_10_0.rewardList_:StartScroll(#arg_10_0.showRewards_)
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = clone(ItemTemplateData)

	var_12_0.id = arg_12_0.showRewards_[arg_12_1]
	var_12_0.hideBottomRightTextFlag = true

	function var_12_0.clickFun(arg_13_0)
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_13_0.id
		})
	end

	arg_12_2:SetData(var_12_0)
end

function var_0_0.OnExit(arg_14_0)
	var_0_0.super.OnExit(arg_14_0)
	manager.redPoint:unbindUIandKey(arg_14_0.goBtn_.transform, arg_14_0.redPointKey_)
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
	arg_15_0.rewardList_:Dispose()

	if arg_15_0.updateTimer_ then
		arg_15_0.updateTimer_:Stop()

		arg_15_0.updateTimer_ = nil
	end
end

return var_0_0
