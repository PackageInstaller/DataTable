local var_0_0 = class("SimBusinessLevelUpView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SimBusinessShopUpgradePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()

	arg_4_0.itemScroll = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, SimBusInessUnlockNewItem)
	arg_4_0.tipsController = arg_4_0.controllers_:GetController("tips")
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.beforeLevel = arg_5_0.params_.beforeLevel
	arg_5_0.curLevel = arg_5_0.params_.curLevel
	arg_5_0.callback = arg_5_0.params_.callback
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgmaskBtn_, nil, function()
		JumpTools.Back()

		if arg_6_0.callback then
			arg_6_0.callback()
		end
	end)
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:RefreshView()
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.RefreshView(arg_10_0)
	if arg_10_0.curLevel then
		arg_10_0.level.text = GetTipsF("SIM_BUSINESS_LEVEL_UP", arg_10_0.curLevel)

		local var_10_0 = SimBusinessData.activityID
		local var_10_1 = SimBusinessPlayerLevelCfg.get_id_list_by_activity_id_level[var_10_0][arg_10_0.curLevel][1]

		arg_10_0.result = {}

		local var_10_2 = SimBusinessPlayerLevelCfg[var_10_1].unlock_goods_list
		local var_10_3 = false

		for iter_10_0 = arg_10_0.beforeLevel, arg_10_0.curLevel - 1 do
			if SimBusinessGame.GetInstance():HasObstacle(iter_10_0) then
				var_10_3 = true

				break
			end
		end

		if var_10_3 then
			arg_10_0.notifyNewArea_.text = GetTips("SIM_BUSINESS_UNLOCK_NEW_AREA")

			arg_10_0.tipsController:SetSelectedState("on")
		else
			arg_10_0.notifyNewArea_.text = ""

			arg_10_0.tipsController:SetSelectedState("off")
		end

		for iter_10_1, iter_10_2 in ipairs(var_10_2) do
			table.insert(arg_10_0.result, {
				id = iter_10_2,
				type = SimBusinessConst.ShowItmeType.good
			})
			SimBusinessTools.SetShowGoodsRedPoint(iter_10_2, true)
		end

		local var_10_4 = SimBusinessPlayerLevelCfg[var_10_1].unlock_shelf_list

		for iter_10_3, iter_10_4 in ipairs(var_10_4) do
			table.insert(arg_10_0.result, {
				id = iter_10_4,
				type = SimBusinessConst.ShowItmeType.shelf
			})
			SimBusinessTools.SetShowShelfRedPoint(iter_10_4, true)
		end

		arg_10_0.itemScroll:StartScroll(#arg_10_0.result)
	end
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:RefreshView(arg_11_0.result[arg_11_1].id, arg_11_0.result[arg_11_1].type)
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.itemScroll:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
