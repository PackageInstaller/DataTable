local var_0_0 = class("CompensateMediator", import("view.base.ContextMediator"))

var_0_0.ON_GET_REWARD = "CompensateMediator.ON_GET_REWARD"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(CompensateProxy)

	arg_1_0:bind(var_0_0.ON_GET_REWARD, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.GET_COMPENSATE_REWARD, arg_2_1)

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_3_0)
	arg_3_0.handleDic = {
		[GAME.DEAL_COMPENSATE_REWARD_DONE] = function(arg_4_0, arg_4_1)
			arg_4_0.viewComponent:UpdateOperationDeal()
			arg_4_0:ShowAndCheckDrops(arg_4_1:getBody().items)

			return
		end,
		[PlayerProxy.UPDATED] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:UpdateRes()

			return
		end,
		[CompensateProxy.Compensate_Remove] = function(arg_6_0, arg_6_1)
			arg_6_0.viewComponent:UpdateOperationDeal()

			return
		end
	}

	return
end

function var_0_0.ShowAndCheckDrops(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = {}

	if #arg_7_1 > 0 then
		table.insert(var_7_0, function(arg_8_0)
			arg_7_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_7_1, arg_8_0)

			return
		end)
	end

	if underscore.detect(arg_7_1, function(arg_9_0)
		return arg_9_0.type == DROP_TYPE_ITEM and arg_9_0:getConfig("type") == Item.SKIN_ASSIGNED_TYPE and Item.InTimeLimitSkinAssigned(arg_9_0.id)
	end) then
		table.insert(var_7_0, function(arg_10_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("skin_exchange_usetip", var_0:getName()),
				onYes = arg_10_0,
				onNo = arg_10_0
			})

			return
		end)
	end

	seriesAsync(var_7_0, function()
		local var_11_0
		local var_11_1 = getProxy(TechnologyProxy)

		if PlayerPrefs.GetInt("help_research_package", 0) == 0 then
			for iter_11_0, iter_11_1 in ipairs(arg_7_1) do
				if iter_11_1.type == DROP_TYPE_ITEM then
					var_11_0 = checkExist(var_11_1:getItemCanUnlockBluePrint(iter_11_1.id), {
						1
					})

					if var_11_0 then
						break
					end
				end
			end
		end

		if var_11_0 then
			PlayerPrefs.SetInt("help_research_package", 1)
			PlayerPrefs.Save()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = i18n("help_research_package"),
				show_blueprint = var_11_0
			})
		end

		return
	end)

	return
end

return var_0_0
