local var_0_0 = class("CombineGamePoolView", ReduxView)
local var_0_1 = 2

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfEggUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.poolRewardItem_ = {}
	arg_4_0.poolRewardItem_[1] = KagutsuchiGachaRewardItem.New(arg_4_0.rewardItem1Go_)
	arg_4_0.poolRewardItem_[2] = KagutsuchiGachaRewardItem.New(arg_4_0.rewardItem2Go_)
	arg_4_0.poolRewardItem_[3] = KagutsuchiGachaRewardItem.New(arg_4_0.rewardItem3Go_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.draw10Btn_, nil, function()
		arg_5_0:TryStartDraw(arg_5_0.bigDrawTimes)
	end)
	arg_5_0:AddBtnListener(arg_5_0.draw1Btn_, nil, function()
		arg_5_0:TryStartDraw(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.poolBtn_, nil, function()
		JumpTools.GoToSystem("CombineGamePoolPopView", {
			activityId = ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL,
			poolId = KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1]
		})
	end)
end

function var_0_0.OnEnter(arg_9_0)
	local var_9_0 = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(var_9_0) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	arg_9_0:UpdateView()
	arg_9_0:BindRedPoint()
end

function var_0_0.UpdateView(arg_10_0)
	local var_10_0 = KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1]
	local var_10_1 = KagutsuchiGachaData:GetMaxDrawTimes(var_10_0)
	local var_10_2 = math.max(var_10_1, var_0_1)
	local var_10_3, var_10_4 = KagutsuchiGachaData:GetDrawCost(var_10_0, 1)
	local var_10_5, var_10_6 = KagutsuchiGachaData:GetDrawCost(var_10_0, var_10_2)
	local var_10_7, var_10_8 = KagutsuchiGachaData:GetDrawCost(var_10_0, 1)

	arg_10_0.bigDrawText_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_POOL_TIPS"), var_10_2)
	arg_10_0.drawCostText_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_POOL_TIPS"), 1)
	arg_10_0.bigDrawCostText_.text = "<color=#" .. (var_10_1 < var_0_1 and "CC0013" or "F3E7C3") .. ">x" .. var_10_6 .. "</color>"
	arg_10_0.drawText_.text = "<color=#" .. (var_10_1 == 0 and "CC0013" or "F3E7C3") .. ">x" .. var_10_8 .. "</color>"
	arg_10_0.bigDrawTimes = var_10_2
	arg_10_0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_POOL_NAME")
	arg_10_0.getText_.text = GetTips("ACTIVITY_COMBINE_GAME_DRAW_POOL_FINISH")
	arg_10_0.draw1Img_.sprite = ItemTools.getItemSprite(var_10_3)
	arg_10_0.draw2Img_.sprite = ItemTools.getItemSprite(var_10_3)

	local var_10_9 = KagutsuchiGachaData:GetDisplayDrawItemIds(var_10_0)

	for iter_10_0, iter_10_1 in ipairs(var_10_9) do
		arg_10_0.poolRewardItem_[iter_10_0]:SetData(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL, var_10_0, iter_10_1)
	end
end

function var_0_0.TryStartDraw(arg_11_0, arg_11_1)
	local var_11_0 = KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1]
	local var_11_1 = KagutsuchiGachaData:GetMaxDrawTimes(var_11_0)

	if KagutsuchiGachaData:GetPoolRemains(var_11_0) == 0 then
		ShowTips("ACTIVITY_COMBINE_GAME_DRAW_POOL_FINISH")

		return
	end

	if var_11_1 < arg_11_1 then
		ShowTips("ACTIVITY_COMBINE_GAME_DRAW_POOL_COST_NOT_ENOUGH")

		return
	end

	KagutsuchiGachaAction:StartDraw(arg_11_1, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL, var_11_0, handler(arg_11_0, arg_11_0.OnFinishDraw))
end

function var_0_0.OnFinishDraw(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:UpdateView()

	local var_12_0 = arg_12_1.pool_id
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.reward_list) do
		local var_12_2, var_12_3 = KagutsuchiGachaData:GetDrawItemReward(var_12_0, iter_12_1)

		table.insert(var_12_1, {
			id = var_12_2,
			num = var_12_3
		})
	end

	getReward(var_12_1)
end

function var_0_0.BindRedPoint(arg_13_0)
	manager.redPoint:bindUIandKey(arg_13_0.draw1Btn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "ONE", {
		x = 150,
		y = 35
	})
	manager.redPoint:bindUIandKey(arg_13_0.draw10Btn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "TEN", {
		x = 150,
		y = 35
	})
end

function var_0_0.UnbindRedPoint(arg_14_0)
	manager.redPoint:unbindUIandKey(arg_14_0.draw10Btn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "TEN")
	manager.redPoint:unbindUIandKey(arg_14_0.draw1Btn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "ONE")
end

function var_0_0.OnExit(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.poolRewardItem_) do
		arg_15_0.poolRewardItem_[iter_15_0]:OnExit()
	end

	arg_15_0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_16_0)
	local var_16_0 = KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1]
	local var_16_1, var_16_2 = KagutsuchiGachaData:GetDrawCost(var_16_0, 1)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_16_1
	})
	manager.windowBar:SetBarCanAdd(var_16_1, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_COMBINE_GAME_DRAW_POOL_DESC")
end

function var_0_0.Dispose(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.poolRewardItem_) do
		arg_17_0.poolRewardItem_[iter_17_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_17_0)
	Object.Destroy(arg_17_0.gameObject_)
end

return var_0_0
