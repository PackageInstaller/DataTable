local var_0_0 = {}

RED_POINT_ID = {
	ACTIVITY = 13,
	INFOMATION = 15,
	SHOP_TAOBAO = 14,
	FORUM = 1,
	RECHARGE = 400,
	BATTLE_EQUIP = 301
}

function var_0_0.Init(arg_1_0)
	return
end

manager.net:Bind(56001, function(arg_2_0)
	RedPointData:InitRedPointS(arg_2_0.red_dot)
	RedPointData:InitClientRedPoint(arg_2_0.client_finished_red_dot)
end)
manager.net:Bind(56003, function(arg_3_0)
	if isSuccess(arg_3_0.result) then
		if whereami == "battle" or whereami == "battleResult" then
			ShowTips("EXCHANGE_CODE_ALERT2")
		else
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("EXCHANGE_CODE_ALERT1"),
				OkCallback = function()
					return
				end
			})
		end
	else
		ShowTips(arg_3_0.result)
	end
end)

function var_0_0.HandleRedPoint(arg_5_0)
	local var_5_0 = {
		red_dot = arg_5_0
	}

	manager.net:Push(56002, var_5_0)
	RedPointData:SetRedPointOpen(arg_5_0, true)
end

function var_0_0.HandleNeedRedPoint(arg_6_0)
	local var_6_0 = {
		red_dot = arg_6_0
	}

	manager.net:Push(56002, var_6_0)
	RedPointData:SetNeedRedPointOpen(arg_6_0, false)
end

manager.notify:RegistListener(ACTIVITY_MAIN_TOGGLE_CLICK, function(arg_7_0)
	var_0_0.OnActivityMainToggleClick(arg_7_0)
end)

function var_0_0.OnActivityMainToggleClick(arg_8_0)
	if arg_8_0 == ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE then
		local var_8_0 = RedPointConst.WARCHESS_CHINESE .. "_" .. ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE

		RedPointData:SetJsonCacheRedPoint(var_8_0)
		RedPointData:UpdateRedPoint(arg_8_0)
	end
end

function var_0_0.UpdateSDKRedPoint()
	local var_9_0 = {
		activity = 9910,
		forum = 9904,
		shop = 9911,
		attention = 9908,
		suggest = 9902,
		psq = 9907
	}
	local var_9_1 = {}
	local var_9_2 = OperationData:GetOperationOpenList()
	local var_9_3 = PlayerData:GetPlayerInfo().userLevel

	if table.keyof(var_9_2, OperationConst.SUGGEST) ~= nil and not JumpTools.IsSystemLocked(var_9_0.suggest) then
		table.insert(var_9_1, RedPointConst.CUSTOMER_SERVICE_UNREAD)
	end

	if table.keyof(var_9_2, OperationConst.FORUM) ~= nil and not JumpTools.IsSystemLocked(var_9_0.forum) then
		table.insert(var_9_1, RedPointConst.FORUM_PLATFORM)
	end

	if table.keyof(var_9_2, OperationConst.QUESTIONNAIRE) ~= nil and not JumpTools.IsSystemLocked(var_9_0.psq) then
		table.insert(var_9_1, RedPointConst.SURVEY)
	end

	if table.keyof(var_9_2, OperationConst.ATTENTION) ~= nil and not JumpTools.IsSystemLocked(var_9_0.attention) then
		table.insert(var_9_1, RedPointConst.FOLLOW_GIFT)
	end

	if table.keyof(var_9_2, OperationConst.ACTIVITY) ~= nil and not JumpTools.IsSystemLocked(var_9_0.activity) then
		table.insert(var_9_1, RedPointConst.OPERATION_ACTIVITY)
	end

	if table.keyof(var_9_2, OperationConst.SHOP_TAOBAO) ~= nil and not JumpTools.IsSystemLocked(var_9_0.shop) then
		table.insert(var_9_1, RedPointConst.SHOP_TAOBAO)
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if manager.redPoint:getTipValue(iter_9_1) > 0 then
			manager.redPoint:setTip(RedPointConst.MAIN_HOME_SDK, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.MAIN_HOME_SDK, 0)
end

var_0_0:Init()

return var_0_0
