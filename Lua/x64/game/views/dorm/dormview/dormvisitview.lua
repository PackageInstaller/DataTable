local var_0_0 = class("DormVisitView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormVisitUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.page = {
		{
			obj = arg_3_0.friendObj_,
			module = DormFriendVisitModule
		},
		{
			obj = arg_3_0.recommendObj_,
			module = DormRecommendModule
		},
		{
			obj = arg_3_0.praiseObj_,
			module = DormMypraiseModule
		}
	}
end

function var_0_0.GetPageInst(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.page[arg_4_1]
	local var_4_1

	if var_4_0.entity == nil then
		local var_4_2 = Object.Instantiate(var_4_0.obj, arg_4_0.contentRoot_.transform)

		var_4_0.entity = var_4_0.module.New(var_4_2)
		var_4_1 = true
	end

	if var_4_1 or arg_4_2 then
		if arg_4_1 == arg_4_0.groupID then
			var_4_0.entity:Show()
		else
			var_4_0.entity:Hide()
		end
	end

	return var_4_0.entity
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()
	arg_6_0:BuildContext()
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.enterType = arg_7_0.params_.enterType
	arg_7_0.back = arg_7_0.params_.back or nil

	arg_7_0:RegisterEvents()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_7_0.back == "chooseRoom" then
			JumpTools.OpenPageByJump("/dormChooseRoomView")

			return
		elseif arg_7_0.back == "back" then
			JumpTools.Back()

			return
		end

		local var_8_0 = BackHomeDataManager:GetCurSystem()

		if var_8_0 == DormEnum.DormSystemType.Canteen then
			JumpTools.OpenPageByJump("/restaurantMain")
		elseif var_8_0 == DormEnum.DormSystemType.Dormitory then
			if arg_7_0.enterType == "quick" then
				JumpTools.OpenPageByJump("/dorm")
			else
				JumpTools.OpenPageByJump("/dormChooseRoomView")
			end
		elseif var_8_0 == DormEnum.DormSystemType.Main then
			JumpTools.OpenPageByJump("/dormChooseRoomView")
		elseif var_8_0 == DormEnum.DormSystemType.CricketBattle then
			JumpTools.OpenPageByJump("/idolTraineeCamp")
		end
	end)

	local var_7_0 = 3
	local var_7_1

	if DormVisitTools:GetListIndex() then
		var_7_0 = DormVisitTools:GetListIndex().index
		var_7_1 = DormVisitTools:GetListIndex().subIndex
	end

	local var_7_2 = arg_7_0.groupID or var_7_0

	arg_7_0:SelGroup(var_7_2, var_7_1)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
	arg_9_0:RemoveAllEventListener()

	arg_9_0.enterType = nil
end

function var_0_0.AddUIListener(arg_10_0)
	for iter_10_0 = 1, 3 do
		arg_10_0:AddToggleListener(arg_10_0["tog_" .. iter_10_0], function(arg_11_0)
			if arg_11_0 then
				arg_10_0:SelGroup(iter_10_0)
			end
		end)
	end
end

function var_0_0.SelGroup(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.groupID ~= arg_12_1 then
		arg_12_0.groupID = arg_12_1
		arg_12_0["tog_" .. arg_12_0.groupID].isOn = true

		for iter_12_0 = 1, 3 do
			local var_12_0 = arg_12_0:GetPageInst(iter_12_0, true)
		end
	end

	arg_12_0:RefreshView(arg_12_2)
end

function var_0_0.RefreshView(arg_13_0, arg_13_1)
	arg_13_0:GetPageInst(arg_13_0.groupID):Refresh(arg_13_1)
end

function var_0_0.RegisterEvents(arg_14_0)
	arg_14_0:RegistEventListener(DORM_REFRESH_TEMPLATE_EXHI, function(arg_15_0, arg_15_1)
		local var_15_0

		if arg_15_1 == 1 then
			var_15_0 = arg_14_0.page[1].entity
		elseif arg_15_1 == 2 then
			var_15_0 = arg_14_0.page[2].entity
		elseif arg_15_1 == 3 then
			var_15_0 = arg_14_0.page[3].entity
		end

		var_15_0:Refresh()
	end)
end

function var_0_0.Dispose(arg_16_0)
	for iter_16_0 = 1, 3 do
		local var_16_0 = arg_16_0.page[iter_16_0].entity

		if var_16_0 then
			var_16_0:Dispose()

			arg_16_0.page[iter_16_0].entity = nil
		end
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
