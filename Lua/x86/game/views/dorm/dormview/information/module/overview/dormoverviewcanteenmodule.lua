DormOverviewModuleBase = import("game.views.dorm.DormView.Information.Module.overview.DormOverviewModuleBase")

local var_0_0 = class("DormOverviewCanteenModule", DormOverviewModuleBase)

function var_0_0.ModuleName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/item/Infomation/overview/canteenSubPanel"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListener()
	arg_2_0:InitView()

	arg_2_0.isIn = false
end

function var_0_0.InitView(arg_3_0)
	arg_3_0.heroList = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.heroList[iter_3_0] = DormOverviewCanteenHeroItem.New(arg_3_0["heroItem" .. iter_3_0])
	end

	arg_3_0.scrollHelper = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.taskScroll_, DormOverviewCanteenTaskModule)
	arg_3_0.soldController1 = arg_3_0.foodController1:GetController("soldout")
	arg_3_0.soldController2 = arg_3_0.foodController2:GetController("soldout")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.isIn = true
	arg_4_0.receiveAwardDirty = false

	SetActive(arg_4_0.effectObj_, false)
	manager.redPoint:bindUIandKey(arg_4_0.awardBtn_.transform, RedPointConst.CANTEEN_MAX)
	manager.redPoint:bindUIandKey(arg_4_0.taskTrs_, RedPointConst.CANTEEN_DISPATCH_NONE)
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.isIn = false
	arg_5_0.receiveAwardDirty = false

	SetActive(arg_5_0.effectObj_, false)
	manager.redPoint:unbindUIandKey(arg_5_0.awardBtn_.transform, RedPointConst.CANTEEN_MAX)
	manager.redPoint:unbindUIandKey(arg_5_0.taskTrs_, RedPointConst.CANTEEN_DISPATCH_NONE)
end

function var_0_0.AddListener(arg_6_0)
	arg_6_0:AddBtnListenerScale(arg_6_0.awardBtn_, nil, function()
		local var_7_0, var_7_1 = CanteenData:GetAutoNextAwardTime()

		if CanteenData:GetAutoAwardNum() == 0 then
			ShowTips("CANTEEN_ADMITTED_NULL")

			return
		end

		arg_6_0.receiveAwardDirty = true

		CanteenAction:ReceiveCanteenAutoAward(DormConst.CANTEEN_ID)
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.menuBtn_, nil, function()
		JumpTools.OpenPageByJump("/chooseSignFoodView")
	end)
	arg_6_0:AddBtnListener(arg_6_0.taskBtnMask, nil, function()
		saveData("DormTaskRedpoint", "lastClickTime", manager.time:GetServerTime())
		JumpTools.OpenPageByJump("/dormTaskDispatchView", {
			roomID = DormConst.CANTEEN_ID
		})
	end)
end

function var_0_0.RegisterEvents(arg_10_0)
	arg_10_0:RegistEventListener(DORM_RESTAURANT_UPDATE_FINISH, handler(arg_10_0, arg_10_0.OnRewardUpdate))
	arg_10_0:RegistEventListener(BACKHOME_CATEEN_AWARD_UPDATE, handler(arg_10_0, arg_10_0.OnRewardUpdate))
	arg_10_0:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, handler(arg_10_0, arg_10_0.RenderHeroItem))
end

function var_0_0.Render(arg_11_0)
	arg_11_0:RenderHeroItem()
	arg_11_0:RenderCanteenMenu()
	arg_11_0:RenderAward()
	arg_11_0:RenderTask()
	DormRedPointTools:UpdateCanteenNotify()
end

function var_0_0.RenderHeroItem(arg_12_0)
	arg_12_0.jobList = {}

	for iter_12_0, iter_12_1 in ipairs(DormEnum.RestaurantJobToClientMap) do
		table.insert(arg_12_0.jobList, iter_12_0)
	end

	for iter_12_2 = 1, 3 do
		arg_12_0.heroList[iter_12_2]:RefreshUI(arg_12_0.jobList[iter_12_2])
	end
end

function var_0_0.RenderCanteenMenu(arg_13_0)
	arg_13_0.signFoodList = CanteenFoodData:GetChooseFoodList() or {}

	for iter_13_0 = 1, 2 do
		local var_13_0 = arg_13_0.signFoodList[iter_13_0]

		if var_13_0 then
			SetActive(arg_13_0["foodItem" .. iter_13_0], true)

			arg_13_0["foodIcon" .. iter_13_0].sprite = CanteenTools.GetFoodSprite(var_13_0)

			local var_13_1 = CanteenFoodData:GetSignFoodInfo(var_13_0)

			arg_13_0["soldController" .. iter_13_0]:SetSelectedState(var_13_1.soldNum >= var_13_1.sellNum and "on" or "off")
		else
			SetActive(arg_13_0["foodItem" .. iter_13_0], false)
		end
	end
end

function var_0_0.RenderTask(arg_14_0)
	arg_14_0.taskList = {}

	for iter_14_0, iter_14_1 in ipairs(GameDisplayCfg.canteen_task_id_pos.value) do
		local var_14_0 = CanteenEntrustData:GetEntrustByPos(iter_14_1[2])

		if var_14_0 and var_14_0.id > 0 then
			table.insert(arg_14_0.taskList, var_14_0)
		end
	end

	arg_14_0.scrollHelper:StartScroll(#arg_14_0.taskList)
end

function var_0_0.RenderAward(arg_15_0)
	local var_15_0 = CanteenData:GetAutoAwardNum() or 0
	local var_15_1 = DormSkillData:GetInComeStorageMax()

	arg_15_0.awardNum = var_15_0
	arg_15_0.awardTotalTxt.text = string.format("%d<size=26><color=#767878>/%d</color></size>", var_15_0, var_15_1)
end

function var_0_0.OnRewardUpdate(arg_16_0)
	if (arg_16_0.awardNum or 0) ~= (CanteenData:GetAutoAwardNum() or 0) then
		arg_16_0:RenderAward()

		if arg_16_0.receiveAwardDirty and arg_16_0.isIn then
			arg_16_0.receiveAwardDirty = false

			SetActive(arg_16_0.effectObj_, true)
			arg_16_0.awardAnim_:Play("Get")
		end
	end
end

function var_0_0.indexItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.taskList[arg_17_1]

	arg_17_2:Render(var_17_0)
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.scrollHelper:Dispose()

	for iter_18_0 = 1, 3 do
		arg_18_0.heroList[iter_18_0]:Dispose()
	end

	arg_18_0.heroList = nil

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
