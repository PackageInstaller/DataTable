local var_0_0 = {}
local var_0_1 = false
local var_0_2 = {}

function var_0_0.Init()
	if var_0_1 then
		return
	end

	var_0_1 = true

	SkinExchangeData:Init()

	var_0_2 = {}
	var_0_2.all = {}

	manager.net:Bind(60069, function(arg_2_0)
		SkinExchangeData:SetData(arg_2_0)

		if ActivitySkinExchangeCfg[arg_2_0.activity_id] then
			for iter_2_0, iter_2_1 in ipairs(ActivitySkinExchangeCfg[arg_2_0.activity_id].cost or {}) do
				if not var_0_2[iter_2_1[1]] then
					var_0_2[iter_2_1[1]] = {}

					table.insert(var_0_2.all, iter_2_1[1])
				end

				table.insert(var_0_2[iter_2_1[1]], arg_2_0.activity_id)
			end
		end
	end)
	manager.notify:RegistListener(CURRENCY_UPDATE, function(arg_3_0)
		if var_0_2[arg_3_0] then
			for iter_3_0, iter_3_1 in ipairs(var_0_2[arg_3_0]) do
				manager.redPoint:setTip(RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_" .. iter_3_1, SkinExchangeTool.IsCanExchange(iter_3_1) and 1 or 0)
			end
		end
	end)
end

function var_0_0.InitRedPointKey(arg_4_0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_" .. arg_4_0, SkinExchangeTool.IsCanExchange(arg_4_0) and 1 or 0)
end

function var_0_0:ExchangeSkin(arg_5_1)
	manager.net:SendWithLoadingNew(60066, {
		activity_id = arg_5_1
	}, 60067, handler(self, self.OnExchangeSkin))
end

function var_0_0.OnExchangeSkin(arg_6_0, arg_6_1, arg_6_2)
	if isSuccess(arg_6_1.result) then
		SkinExchangeData:SetState(arg_6_2.activity_id)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_" .. arg_6_2.activity_id, 0)
		manager.notify:CallUpdateFunc(ACTIVITY_SKIN_EXCHANGE)
		getReward2(arg_6_1.reward_list)
	else
		ShowTips(arg_6_1.result)
	end
end

return var_0_0
