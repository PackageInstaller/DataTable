local var_0_0 = {}

manager.net:Bind(62011, function(arg_1_0)
	RegressionDataNew:InitData(arg_1_0)
	var_0_0.CheckTaskRedPoint()
	var_0_0.CheckSignRedPoint()
	var_0_0.CheckPrivilegeRedPoint()
	var_0_0.CheckShopRedPoint()
	var_0_0.SetNewTag()
	var_0_0.SetFirstRed()
end)

function var_0_0.QuerySign(arg_2_0)
	manager.net:SendWithLoadingNew(62012, {
		index = arg_2_0
	}, 62013, var_0_0.OnSignBack)
end

function var_0_0.OnSignBack(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		local var_3_0 = arg_3_1.index

		getReward2(arg_3_0.item_list)
		RegressionDataNew:UpdateSign(var_3_0)
		manager.notify:CallUpdateFunc(REGRESSION_SIGN)
		var_0_0.CheckSignRedPoint()
	else
		ShowTips(arg_3_0.result)
	end
end

manager.net:Bind(62015, function(arg_4_0)
	RegressionDataNew:UpdatePassData(arg_4_0)
	var_0_0.SetNewTag()
end)

function var_0_0.FindRes()
	manager.net:SendWithLoadingNew(62016, {}, 62017, var_0_0.OnFindRes)
end

function var_0_0.OnFindRes(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		RegressionDataNew:UpdateFindTime()
		var_0_0.CheckPrivilegeRedPoint()
		manager.notify:CallUpdateFunc(REGRESSION_FIND_RES)
		getReward2(arg_6_0.item_list)
	else
		ShowTips(arg_6_0.result)
	end
end

function var_0_0.CheckRegressionStory(arg_7_0)
	local var_7_0 = RegressionDataNew:GetRegressionSystemID()
	local var_7_1 = ReturnCfg[var_7_0].return_story
	local var_7_2 = StoryCfg[var_7_1]
	local var_7_3 = VideoTrackCfg[var_7_1 .. ".usm"]
	local var_7_4 = IllustratedData:GetPlotInfo()[var_7_1]
	local var_7_5 = var_7_4 and var_7_4.is_view == 1

	if RegressionDataNew:CheckIsOpenRuturnPool() then
		local var_7_6 = ReturnCfg[RegressionDataNew:GetRegressionSystemID()].return_draw_pool
		local var_7_7 = ActivityDrawPoolCfg[var_7_6].config_list[1]

		if not DrawData:GetDrawRecord(var_7_7) then
			DrawAction.RequestRecord(var_7_7)
		end
	end

	if var_7_5 then
		JumpTools.OpenPageByJump("/regressionNew", arg_7_0)
	else
		gameContext:Go("/blank")
		manager.story:StartStoryById(var_7_1, function(arg_8_0)
			IllustratedAction.ViewIllustration(var_7_1, CollectConst.PLOT)
			JumpTools.OpenPageByJump("/regressionNew", arg_7_0)
		end)
	end
end

manager.net:Bind(62019, function(arg_9_0)
	RegressionDataNew:InitDrawData(arg_9_0)
	var_0_0.SetNewTag()
end)

function var_0_0.ClosePopView()
	manager.net:SendWithLoadingNew(62020, {}, 62021, var_0_0.OnClosePopView)
end

function var_0_0.OnClosePopView(arg_11_0, arg_11_1)
	if isSuccess(arg_11_0.result) then
		RegressionDataNew:UpdatePicSign(false)
	else
		ShowTips(arg_11_0.result)
	end
end

manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function()
	var_0_0.CheckTaskRedPoint()
	var_0_0.CheckPrivilegeRedPoint()
end)
manager.notify:RegistListener(NEW_DAY, function()
	var_0_0.CheckShopRedPoint()
	var_0_0.CheckSignRedPoint()
end)

function var_0_0.CheckTaskRedPoint()
	if not RegressionDataNew:IsRegressionOpen() then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_REWARD, TaskConst.TASK_TYPE.REGRESSION_CURRENT_ACT), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_REWARD, TaskConst.TASK_TYPE.REGRESSION_CURRENT_ACT), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_REWARD, TaskConst.TASK_TYPE.REGRESSION_CURRENT_ACT), 0)

		return
	end

	var_0_0.UpdateTaskRedTip(TaskConst.TASK_TYPE.REGRESSION_CURRENT_ACT, string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_REWARD, TaskConst.TASK_TYPE.REGRESSION_CURRENT_ACT))
	var_0_0.UpdateTaskRedTip(TaskConst.TASK_TYPE.REGRESSION_DRAW, string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_REWARD, TaskConst.TASK_TYPE.REGRESSION_DRAW))
	var_0_0.UpdateTaskRedTip(TaskConst.TASK_TYPE.REGRESSION_TILI, string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_REWARD, TaskConst.TASK_TYPE.REGRESSION_TILI))
end

function var_0_0.SetFirstRed()
	if not RegressionDataNew:IsRegressionOpen() then
		return
	end

	if not getData("Regression", "First" .. RedPointConst.NEW_REGRESSION_SIGN .. RegressionDataNew:GetRegressionEndTime()) then
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_SIGN_FIRST, 1)
	end

	if not getData("Regression", "First" .. TaskConst.TASK_TYPE.REGRESSION_CURRENT_ACT .. RegressionDataNew:GetRegressionEndTime()) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_FIRST, TaskConst.TASK_TYPE.REGRESSION_CURRENT_ACT), 1)
	end

	if not getData("Regression", "First" .. TaskConst.TASK_TYPE.REGRESSION_DRAW .. RegressionDataNew:GetRegressionEndTime()) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_FIRST, TaskConst.TASK_TYPE.REGRESSION_DRAW), 1)
	end

	if not getData("Regression", "First" .. TaskConst.TASK_TYPE.REGRESSION_TILI .. RegressionDataNew:GetRegressionEndTime()) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_FIRST, TaskConst.TASK_TYPE.REGRESSION_TILI), 1)
	end
end

function var_0_0.UpdateTaskRedTip(arg_16_0, arg_16_1)
	local var_16_0 = TaskData2:GetTaskIDListByType(arg_16_0)

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		local var_16_1 = TaskData2:GetTask(iter_16_0)

		if var_16_1.progress >= AssignmentCfg[var_16_1.id].need and var_16_1.complete_flag < 1 then
			manager.redPoint:setTip(arg_16_1, 1)

			return true
		end
	end

	manager.redPoint:setTip(arg_16_1, 0)
end

function var_0_0.CheckSignRedPoint()
	if RegressionDataNew:GetCanSignTimes() > 0 then
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_SIGN_REWARD, 1)
	else
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_SIGN_REWARD, 0)
	end
end

function var_0_0.CheckPrivilegeRedPoint()
	local var_18_0 = RegressionDataNew:GetRegressFindTime()

	if RegressionDataNew:IsCanFinishFindResTask() then
		var_18_0 = var_18_0 + 1
	end

	if var_18_0 > 0 then
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_RES_FIND, 1)
	else
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_RES_FIND, 0)
	end
end

function var_0_0.CheckShopRedPoint(arg_19_0)
	local var_19_0 = RegressionDataNew:GetShopDailyFreeGoodID()

	if not ShopTools.CheckSoldOut(var_19_0) then
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_FREE_DAILY_REWARD, 1)
	else
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_FREE_DAILY_REWARD, 0)
	end

	local var_19_1 = RegressionDataNew:GetShopGoodsList()
	local var_19_2 = false

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		if not ShopTools.CheckSoldOut(iter_19_1.id) then
			if ShopTools.GetPrice(iter_19_1.id) == 0 then
				var_19_2 = true
			end

			break
		end
	end

	if var_19_2 then
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_FREE_REWARD, 1)
	else
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_FREE_REWARD, 0)
	end
end

function var_0_0.SetNewTag(arg_20_0)
	if RegressionDataNew:CheckIsOpenRuturnPool() and not getData("Regression", "DrawPool" .. RegressionDataNew:GetRegressionEndTime()) then
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG, 1, RedPointStyle.SHOW_NEW_TAG)
	else
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG, 0, RedPointStyle.SHOW_NEW_TAG)
	end

	if not getData("Regression", "MonthCard" .. RegressionDataNew:GetRegressionEndTime()) and RegressionDataNew:CheckIsCanBuyRuturnDiscount(111) then
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_MONTHCARD_NEW_TAG, 1, RedPointStyle.SHOW_NEW_TAG)
	else
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_MONTHCARD_NEW_TAG, 0, RedPointStyle.SHOW_NEW_TAG)
	end

	local var_20_0 = RegressionDataNew:GetReturnCfgData().battlepass_discount[2]
	local var_20_1 = RegressionDataNew:GetReturnCfgData().battlepass_discount[3]
	local var_20_2 = true

	if RegressionDataNew:CheckIsBuyPayID(var_20_0) or RegressionDataNew:CheckIsBuyPayID(var_20_1) or not RegressionDataNew:CheckIsSamePassportVsID() then
		var_20_2 = false
	end

	if var_20_2 and PassportData:IsOpen() and PassportData:IsUnlock() and not getData("Regression", "Passport" .. RegressionDataNew:GetRegressionEndTime()) then
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_PASSPORT_NEW_TAG, 1, RedPointStyle.SHOW_NEW_TAG)
	else
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_PASSPORT_NEW_TAG, 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

return var_0_0
