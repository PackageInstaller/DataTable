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

function var_0_0:OnSignBack(arg_3_1)
	if isSuccess(self.result) then
		getReward2(self.item_list)
		RegressionDataNew:UpdateSign(arg_3_1.index)
		manager.notify:CallUpdateFunc(REGRESSION_SIGN)
		var_0_0.CheckSignRedPoint()
	else
		ShowTips(self.result)
	end
end

manager.net:Bind(62015, function(arg_4_0)
	RegressionDataNew:UpdatePassData(arg_4_0)
	var_0_0.SetNewTag()
end)

function var_0_0.FindRes()
	manager.net:SendWithLoadingNew(62016, {}, 62017, var_0_0.OnFindRes)
end

function var_0_0:OnFindRes(arg_6_1)
	if isSuccess(self.result) then
		RegressionDataNew:UpdateFindTime()
		var_0_0.CheckPrivilegeRedPoint()
		manager.notify:CallUpdateFunc(REGRESSION_FIND_RES)
		getReward2(self.item_list)
	else
		ShowTips(self.result)
	end
end

function var_0_0.CheckRegressionStory(arg_7_0)
	local var_7_0 = ReturnCfg[RegressionDataNew:GetRegressionSystemID()].return_story
	local var_7_3 = IllustratedData:GetPlotInfo()[var_7_0]
	local var_7_4 = var_7_3 and var_7_3.is_view == 1

	if RegressionDataNew:CheckIsOpenRuturnPool() then
		local var_7_5 = ActivityDrawPoolCfg[ReturnCfg[RegressionDataNew:GetRegressionSystemID()].return_draw_pool].config_list[1]

		if not DrawData:GetDrawRecord(var_7_5) then
			DrawAction.RequestRecord(var_7_5)
		end
	end

	if var_7_4 then
		JumpTools.OpenPageByJump("/regressionNew", arg_7_0)
	else
		gameContext:Go("/blank")
		manager.story:StartStoryById(var_7_0, function(arg_8_0)
			IllustratedAction.ViewIllustration(var_7_0, CollectConst.PLOT)
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

function var_0_0:OnClosePopView(arg_11_1)
	if isSuccess(self.result) then
		RegressionDataNew:UpdatePicSign(false)
	else
		ShowTips(self.result)
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
	for iter_16_0, iter_16_1 in pairs((TaskData2:GetTaskIDListByType(arg_16_0))) do
		local var_16_0 = TaskData2:GetTask(iter_16_0)

		if var_16_0.progress >= AssignmentCfg[var_16_0.id].need and var_16_0.complete_flag < 1 then
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
	if not ShopTools.CheckSoldOut((RegressionDataNew:GetShopDailyFreeGoodID())) then
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_FREE_DAILY_REWARD, 1)
	end

	local var_19_0

	do
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_FREE_DAILY_REWARD, 0)

		var_19_0 = false
	end

	for iter_19_0, iter_19_1 in ipairs((RegressionDataNew:GetShopGoodsList())) do
		if not ShopTools.CheckSoldOut(iter_19_1.id) then
			if ShopTools.GetPrice(iter_19_1.id) == 0 then
				var_19_0 = true
			end

			break
		end
	end

	if var_19_0 then
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
	end

	local var_20_0

	do
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_MONTHCARD_NEW_TAG, 0, RedPointStyle.SHOW_NEW_TAG)

		var_20_0 = RegressionDataNew:GetReturnCfgData().battlepass_discount[3]
	end

	if (not RegressionDataNew:CheckIsBuyPayID(RegressionDataNew:GetReturnCfgData().battlepass_discount[2]) and not RegressionDataNew:CheckIsBuyPayID(var_20_0) and RegressionDataNew:CheckIsSamePassportVsID() or false) and PassportData:IsOpen() and PassportData:IsUnlock() and not getData("Regression", "Passport" .. RegressionDataNew:GetRegressionEndTime()) then
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_PASSPORT_NEW_TAG, 1, RedPointStyle.SHOW_NEW_TAG)
	else
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_PASSPORT_NEW_TAG, 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

return var_0_0
