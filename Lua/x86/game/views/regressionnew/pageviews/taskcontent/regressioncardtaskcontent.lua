local var_0_0 = import("game.views.regressionNew.pageViews.RegressionTaskContent")
local var_0_1 = class("RegressionCardTaskContent", var_0_0)

function var_0_1.InitNode(arg_1_0)
	arg_1_0.selectIndex = nil

	arg_1_0:AddBtnListener(arg_1_0.goBtn_, nil, function()
		arg_1_0.isGoToDraw = true

		local var_2_0 = arg_1_0.drawList[arg_1_0.selectIndex].poolId

		JumpTools.GoToSystem("/draw", {
			poolId = var_2_0
		}, ViewConst.SYSTEM_ID.DRAW)
	end)

	arg_1_0.selectPoolList = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.poolList_, RegressionSelectPoolItem)
	arg_1_0.poolSelectStateController = arg_1_0.controller_:GetController("poolSelectState")
end

function var_0_1.GetSelectParams(arg_3_0)
	if not arg_3_0.isGoToDraw then
		return nil, nil
	end

	arg_3_0.isGoToDraw = false

	return 1, 3
end

function var_0_1.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.drawList[arg_4_1].poolId

	arg_4_2:SetData(arg_4_1, var_4_0)
	arg_4_2:RegistCallBack(handler(arg_4_0, arg_4_0.OnItemClick))

	if arg_4_0.selectIndex == arg_4_1 then
		arg_4_2:UpdateSelectState(true)
	end
end

function var_0_1.OnItemClick(arg_5_0, arg_5_1)
	if arg_5_0.selectIndex == arg_5_1 then
		return
	end

	if arg_5_0.selectIndex then
		local var_5_0 = arg_5_0.selectPoolList:GetItemByIndex(arg_5_0.selectIndex)

		if var_5_0 then
			var_5_0:UpdateSelectState(false)
		end
	end

	arg_5_0.selectIndex = arg_5_1

	local var_5_1 = arg_5_0.selectPoolList:GetItemByIndex(arg_5_0.selectIndex)

	if var_5_1 then
		var_5_1:UpdateSelectState(true)
	end

	arg_5_0:UpdateSelectPoolUI()
end

function var_0_1.UpdateSelectPoolUI(arg_6_0)
	if #arg_6_0.drawList == 0 then
		return
	end

	local var_6_0 = arg_6_0.drawList[arg_6_0.selectIndex].poolId
	local var_6_1 = DrawPoolCfg[var_6_0]

	arg_6_0:AddPoolTimer(var_6_0)

	local var_6_2 = var_6_1.unoption_up_items[1][1]

	arg_6_0.heronameTxt_.text = HeroTools.GetHeroFullName(var_6_2)

	arg_6_0:RefreshRoleImage(var_6_2)
end

function var_0_1.RefreshRoleImage(arg_7_0, arg_7_1)
	arg_7_0.poolpictureImg_.spriteSync = "TextureConfig/Character/Portrait/" .. arg_7_1

	arg_7_0.poolpictureImg_:SetNativeSize()

	local var_7_0 = HeroCfg[arg_7_1]

	arg_7_0.campiconImg_.sprite = HeroTools.GetRaceIcon(var_7_0.race)
end

function var_0_1.AddPoolTimer(arg_8_0, arg_8_1)
	if arg_8_0.poolTimer then
		arg_8_0.poolTimer:Stop()

		arg_8_0.poolTimer = nil
	end

	local var_8_0 = arg_8_0.drawList[arg_8_0.selectIndex].actID
	local var_8_1 = ActivityData:GetActivityData(var_8_0).stopTime

	arg_8_0.remainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_8_1))
	arg_8_0.poolTimer = Timer.New(function()
		arg_8_0.remainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_8_1))
	end, 1, -1)

	arg_8_0.poolTimer:Start()
end

function var_0_1.RefreshUI(arg_10_0)
	arg_10_0.descTxt_.text = GetTips("NEW_REGRESSION_DRAW_TASK_DESC")

	local var_10_0 = {}
	local var_10_1 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if ActivityData:GetActivityIsOpen(iter_10_1) then
			local var_10_2 = ActivityDrawPoolCfg[iter_10_1]

			if var_10_2 then
				for iter_10_2, iter_10_3 in ipairs(var_10_2.config_list) do
					if DrawPoolCfg[iter_10_3].pool_show_type == 6 then
						table.insert(var_10_0, {
							poolId = iter_10_3,
							actID = iter_10_1
						})
					end
				end
			end
		end
	end

	table.sort(var_10_0, function(arg_11_0, arg_11_1)
		local var_11_0 = DrawPoolCfg[arg_11_0.poolId]
		local var_11_1 = DrawPoolCfg[arg_11_1.poolId]

		if var_11_0.order == var_11_1.order then
			return arg_11_0.poolId > arg_11_1.poolId
		else
			return var_11_0.order < var_11_1.order
		end
	end)

	if #var_10_0 == 1 then
		arg_10_0.poolSelectStateController:SetSelectedState("hide")
	else
		arg_10_0.poolSelectStateController:SetSelectedState("show")
	end

	arg_10_0.drawList = var_10_0

	arg_10_0.selectPoolList:StartScroll(#arg_10_0.drawList)
	arg_10_0:OnItemClick(arg_10_0.selectIndex or 1)

	local var_10_3 = AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.REGRESSION_DRAW]
	local var_10_4 = TaskData2:GetTask(var_10_3[1])

	arg_10_0.cardnumtxt_.text = string.format(GetTips("NEW_REGRESSION_DRAW_TASK_PROGRESS_DESC"), var_10_4.progress)
end

function var_0_1.Dispose(arg_12_0)
	arg_12_0.selectIndex = nil

	if arg_12_0.poolTimer then
		arg_12_0.poolTimer:Stop()

		arg_12_0.poolTimer = nil
	end

	if arg_12_0.selectPoolList then
		arg_12_0.selectPoolList:Dispose()

		arg_12_0.selectPoolList = nil
	end

	var_0_1.super.Dispose(arg_12_0)
end

return var_0_1
