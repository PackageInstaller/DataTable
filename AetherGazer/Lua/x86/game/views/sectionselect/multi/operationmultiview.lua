local var_0_0 = class("OperationMultiView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.firstMultiItem = OperationMultiItem.New(arg_3_0.doubleoneGo_)
	arg_3_0.secondMultiItem = OperationMultiItem.New(arg_3_0.doubletwoGo_)
	arg_3_0.showStateController_ = arg_3_0.controller_:GetController("state")
	arg_3_0.countController_ = arg_3_0.controller_:GetController("count")
	arg_3_0.onMultUpdate_ = handler(arg_3_0, arg_3_0.OnMultTimeUpdate)
end

function var_0_0.OnMultTimeUpdate(arg_4_0)
	arg_4_0:RefreshShow()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.retractBtn_, nil, function()
		if arg_5_0.showMultiCount >= 2 then
			arg_5_0.showStateController_:SetSelectedState("expand")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.expandBtn_, nil, function()
		arg_5_0.showStateController_:SetSelectedState("retract")
	end)
end

function var_0_0.RefreshUI(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	manager.notify:RegistListener(MULT_TIMES_UPDATE, arg_8_0.onMultUpdate_)

	arg_8_0.chapterID_ = arg_8_1
	arg_8_0.curToggle_ = arg_8_2
	arg_8_0.isStage = arg_8_3

	arg_8_0.ani_:Play("UI_OperationDoubleUI", 0, 0)
	arg_8_0.showStateController_:SetSelectedState("retract")
	arg_8_0:RefreshShow()
end

function var_0_0.RefreshShow(arg_9_0)
	local var_9_0 = arg_9_0.chapterID_
	local var_9_1 = arg_9_0.curToggle_
	local var_9_2 = arg_9_0.isStage

	arg_9_0.showMultiCount = 0

	local var_9_3, var_9_4 = ActivityMultiRewardData:GetMultiRatioByChapterOrToggle(var_9_1, var_9_0)
	local var_9_5 = false

	if var_9_3 and var_9_3 > 0 then
		if ActivityMultiRewardData:GetCountByActivityID(var_9_4) > 0 then
			arg_9_0:GetMultiItem():RefreshActMulti(var_9_3, var_9_4)

			arg_9_0.showMultiCount = arg_9_0.showMultiCount + 1
		else
			var_9_5 = true
		end
	end

	local var_9_6 = true

	if var_9_2 then
		if var_9_1 and (var_9_1 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP or var_9_1 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY) then
			var_9_6 = true
		else
			var_9_6 = false
		end
	elseif var_9_1 and var_9_1 ~= BattleConst.TOGGLE.RESOURCE and var_9_1 ~= BattleConst.TOGGLE.EQUIP then
		var_9_6 = false
	end

	if RegressionDataNew:IsRegressionOpen() and var_9_6 and RegressionDataNew:GetMultipleValue() > 0 then
		local var_9_7 = arg_9_0:GetMultiItem()

		if var_9_7 then
			var_9_7:RefreshRegressionMulti()

			arg_9_0.showMultiCount = arg_9_0.showMultiCount + 1
		end
	end

	if var_9_5 then
		local var_9_8 = arg_9_0:GetMultiItem()

		if var_9_8 then
			var_9_8:RefreshActMulti(var_9_3, var_9_4)

			arg_9_0.showMultiCount = arg_9_0.showMultiCount + 1
		end
	end

	if arg_9_0.showMultiCount == 0 then
		arg_9_0.countController_:SetSelectedState("none")
	elseif arg_9_0.showMultiCount == 1 then
		arg_9_0.countController_:SetSelectedState("one")
	elseif arg_9_0.showMultiCount == 2 then
		arg_9_0.countController_:SetSelectedState("two")
	end
end

function var_0_0.OnExit(arg_10_0)
	manager.notify:RemoveListener(MULT_TIMES_UPDATE, arg_10_0.onMultUpdate_)

	if arg_10_0.firstMultiItem then
		arg_10_0.firstMultiItem:OnExit()
	end

	if arg_10_0.secondMultiItem then
		arg_10_0.secondMultiItem:OnExit()
	end
end

function var_0_0.GetMultiItem(arg_11_0)
	if arg_11_0.showMultiCount == 0 then
		return arg_11_0.firstMultiItem
	else
		return arg_11_0.secondMultiItem
	end
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.firstMultiItem then
		arg_12_0.firstMultiItem:Dispose()

		arg_12_0.firstMultiItem = nil
	end

	if arg_12_0.secondMultiItem then
		arg_12_0.secondMultiItem:Dispose()

		arg_12_0.secondMultiItem = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
