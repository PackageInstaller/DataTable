class = var_0_10000

local var_0_0 = "CompensateMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_GET_REWARD = "CompensateMediator.ON_GET_REWARD"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	CompensateProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	arg_1_0:bind(var_0_1.ON_GET_REWARD, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.GET_COMPENSATE_REWARD, arg_2_1)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[var_1_10002.DEAL_COMPENSATE_REWARD_DONE] = function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_1:getBody()
		local var_4_1 = arg_4_0.viewComponent

		var_3.UpdateOperationDeal(var_4_1)
		arg_4_0:ShowAndCheckDrops(var_4_0.items)

		return
	end
	PlayerProxy = var_2
	var_3_0[var_2.UPDATED] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_0.viewComponent

		var_2.UpdateRes(var_5_0)

		return
	end
	CompensateProxy = var_2
	var_3_0[var_2.Compensate_Remove] = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0.viewComponent

		var_2.UpdateOperationDeal(var_6_0)

		return
	end
	arg_3_0.handleDic = var_3_0

	return
end

function var_0_1.ShowAndCheckDrops(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = {}
	local var_7_1 = #arg_7_1

	if 0 < var_7_1 then
		table = var_7_1

		var_7_1.insert(var_7_0, function(arg_8_0)
			local var_8_0 = arg_7_0.viewComponent
			local var_8_1 = var_1.emit

			BaseUI = var_2_10004

			var_8_1(var_8_0, var_2_10004.ON_ACHIEVE, arg_7_1, arg_8_0)

			return
		end)
	end

	underscore = var_7_1

	if var_7_1.detect(arg_7_1, function(arg_9_0)
		local var_9_0 = arg_9_0.type

		DROP_TYPE_ITEM = var_2_10002

		local var_9_2

		if var_9_0 == var_2_10002 then
			local var_9_1 = arg_9_0:getConfig("type")

			Item = var_2_10002

			if var_9_1 == var_2_10002.SKIN_ASSIGNED_TYPE then
				Item = var_9_1
				var_9_2 = var_9_1.InTimeLimitSkinAssigned(arg_9_0.id)

				goto label_9_0
			end
		end

		var_9_2 = false

		if false then
			var_9_2 = true
		end

		::label_9_0::

		return var_9_2
	end) then
		table = var_4

		var_4.insert(var_7_0, function(arg_10_0)
			pg = var_2_10001

			local var_10_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_10_1 = var_1.ShowMsgBox
			local var_10_2 = {
				hideNo = true
			}

			i18n = var_2_10005

			local var_10_3 = "skin_exchange_usetip"
			local var_10_4 = var_0

			var_10_2.content = var_2_10005(var_10_3, var_8.getName(var_10_4))
			var_10_2.onYes = arg_10_0
			var_10_2.onNo = arg_10_0

			var_10_1(var_10_0, var_10_2)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_7_0, function()
		local var_11_0

		getProxy = var_2_10001
		TechnologyProxy = var_2_10003

		local var_11_1 = var_2_10001(var_2_10003)

		PlayerPrefs = var_2_10002

		if var_2_10002.GetInt("help_research_package", 0) == 0 then
			ipairs = var_2

			for iter_11_0, iter_11_1 in var_2(arg_7_1) do
				local var_11_2 = iter_11_1.type

				DROP_TYPE_ITEM = var_2_10008

				if var_11_2 == var_2_10008 then
					checkExist = var_11_2

					if var_11_2(var_11_1:getItemCanUnlockBluePrint(iter_11_1.id), {
						1
					}) then
						break
					end
				end
			end
		end

		if var_11_0 then
			PlayerPrefs = var_2

			var_2.SetInt("help_research_package", 1)

			PlayerPrefs = var_2

			var_2.Save()

			pg = var_2

			local var_11_3 = var_2.MsgboxMgr.GetInstance()
			local var_11_4 = var_2.ShowMsgBox
			local var_11_5 = {}

			MSGBOX_TYPE_HELP = iter_11_1
			var_11_5.type = iter_11_1
			i18n = iter_11_1
			var_11_5.helps = iter_11_1("help_research_package")
			var_11_5.show_blueprint = var_11_0

			var_11_4(var_11_3, var_11_5)
		end

		return
	end)

	return
end

return var_0_1
