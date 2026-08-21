local var_0_0 = {}

manager.net:Bind(34031, function(arg_1_0)
	PassportData:InitWithServerData(arg_1_0)
	var_0_0.UpdateBonusRedPoint()
	var_0_0.UpdateNewSeasonRedPoint()
	TaskRedPoint:UpdatePassportTaskRedTip()
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function()
	var_0_0.UpdateBonusRedPoint()
	TaskRedPoint:UpdatePassportTaskRedTip()
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function(arg_3_0)
	if arg_3_0 == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
		var_0_0.UpdateBonusRedPoint()
	end
end)

function var_0_0.UpdateBonusRedPoint()
	local var_4_0 = PassportData:IsOpen() and PassportData:IsUnlock()

	manager.redPoint:setTip(RedPointConst.PASSPORT_BONUS, #PassportData:GetCanGetBonusList() > 0 and var_4_0 and 1 or 0)
end

function var_0_0.UpdateNewSeasonRedPoint()
	local var_5_0 = getData("passport", "poster_" .. PassportData:GetId()) ~= "1"

	manager.redPoint:setTip(RedPointConst.PASSPORT_NEW_SEASON, var_5_0 and 1 or 0, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.RequestPassportData()
	manager.net:SendWithLoadingNew(34030, {}, 34031, var_0_0.OnPassportData)
end

function var_0_0.OnPassportData(arg_7_0, arg_7_1)
	PassportData:InitWithServerData(arg_7_0)
	var_0_0.UpdateBonusRedPoint()

	if PassportData:GetPayLevel() <= 0 then
		local var_7_0 = gameContext:GetAllOpenPage()

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			if iter_7_1.__cname == "PassportMainView" then
				gameContext:Go("/home")
				ShowTips("BATTLEPASS_EXPIRED")

				break
			end
		end
	end

	TaskRedPoint:UpdatePassportTaskRedTip()
end

function var_0_0.RequestGetBonus(arg_8_0, arg_8_1)
	manager.net:SendWithLoadingNew(34032, {
		id = arg_8_0,
		is_pay = arg_8_1
	}, 34033, var_0_0.OnGetBonus)
end

function var_0_0.OnGetBonus(arg_9_0, arg_9_1)
	if isSuccess(arg_9_0.result) then
		getReward(arg_9_0.reward_list)
		PassportData:GetBonusSuccess(arg_9_1.id, arg_9_0.receive_info)
		var_0_0.UpdateBonusRedPoint()
	else
		ShowTips(arg_9_0.result)
	end
end

function var_0_0.BuyLevel(arg_10_0)
	manager.net:SendWithLoadingNew(34036, {
		num = arg_10_0
	}, 34037, var_0_0.OnBuyLevel)
end

function var_0_0.OnBuyLevel(arg_11_0, arg_11_1)
	if isSuccess(arg_11_0.result) then
		manager.notify:CallUpdateFunc(PASSPORT_ONBUYLEVEL)
		ShowTips("TRANSACTION_SUCCESS")
		var_0_0.UpdateBonusRedPoint()
	else
		ShowTips(arg_11_0.result)
	end
end

function var_0_0.OneKeyGet()
	manager.net:SendWithLoadingNew(34034, {}, 34035, var_0_0.OnOneKeyGet)
end

function var_0_0.OnOneKeyGet(arg_13_0, arg_13_1)
	if isSuccess(arg_13_0.result) then
		PassportData:MarkAllBonusGet(arg_13_0)
		getReward(arg_13_0.reward_list)
		var_0_0.UpdateBonusRedPoint()
	else
		ShowTips(arg_13_0.result)
	end
end

return var_0_0
