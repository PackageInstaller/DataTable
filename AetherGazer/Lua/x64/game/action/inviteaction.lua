local var_0_0 = {}

manager.net:Bind(76201, function(arg_1_0)
	InviteData:InitInviteData(arg_1_0)
	var_0_0.UpdateRedPoint()
	manager.notify:CallUpdateFunc(INVITE_PLOT_READ_REFRESH, plot_id)
end)

function var_0_0.CompletePlot(arg_2_0, arg_2_1)
	local var_2_0 = {
		activity_id = arg_2_0,
		plot_id = arg_2_1
	}

	manager.net:SendWithLoadingNew(76202, var_2_0, 76203, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			InviteData:UpdateCompletePlotData(var_2_0)
			manager.notify:CallUpdateFunc(INVITE_PLOT_READ_REFRESH, arg_2_1)
			var_0_0.UpdateRedPoint()
		else
			ShowTips(GetTips(arg_3_0.result))
		end
	end)
end

function var_0_0.InitRedPointKey(arg_4_0)
	manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(arg_4_0), arg_4_0), {
		RedPointConst.INVITE_MAIN
	})
	manager.redPoint:addGroup(RedPointConst.DRAW, {
		RedPointConst.INVITE_DRAW
	})
end

manager.notify:RegistListener(NEW_DAY, function()
	local var_5_0 = InviteData:GetDataByPara("drawItemId")

	if var_5_0 == 0 or var_5_0 == nil then
		return
	end

	manager.redPoint:setTip(RedPointConst.INVITE_DRAW, 0)
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function(arg_6_0)
	local var_6_0 = InviteData:GetDataByPara("drawItemId")

	if var_6_0 == arg_6_0 then
		local var_6_1 = ItemTools.getItemNum(var_6_0)

		manager.redPoint:setTip(RedPointConst.INVITE_DRAW, var_6_1 > 0 and 1 or 0)
	end
end)

function var_0_0.UpdateRedPoint()
	local var_7_0 = InviteData:GetDataByPara("drawItemId")
	local var_7_1 = ItemTools.getItemNum(var_7_0)
	local var_7_2 = InviteData:GetDataByPara("inviteTimes")
	local var_7_3 = InviteData:GetDataByPara("allComplete")

	manager.redPoint:setTip(RedPointConst.INVITE_DRAW, var_7_1 > 0 and 1 or 0)
	manager.redPoint:setTip(RedPointConst.INVITE_PLOT, var_7_2 > 0 and not var_7_3 and 1 or 0)
end

return var_0_0
