class = var_0_10000

local var_0_0 = "MailMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_REQUIRE = "MailMediator.ON_REQUIRE"
var_0_1.ON_OPERATION = "MailMediator.ON_OPERATION"
var_0_1.ON_DELETE_COLLECTION = "MailMediator.ON_DELETE_COLLECTION"
var_0_1.ON_WITHDRAWAL = "MailMediator.ON_WITHDRAWAL"
var_0_1.ON_EXTEND_STORE = "MailMediator.ON_EXTEND_STORE"
var_0_1.ON_GET_MAIL_TITLE = "MailMediator.ON_GET_MAIL_TITLE"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	MailProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)

	arg_1_0:bind(var_0_1.ON_REQUIRE, function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_1 == "collection" then
			local var_2_0 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_2_10005

			var_2_10003(var_2_0, var_2_10005.GET_COLLECTION_MAIL_LIST, {
				callback = arg_2_2
			})
		else
			type = var_2_10003

			if var_2_10003(arg_2_1) == "number" then
				local var_2_1 = arg_1_0
				local var_2_2 = var_3.sendNotification

				GAME = var_2_10005

				var_2_2(var_2_1, var_2_10005.GET_MAIL_LIST_TO_INDEX, {
					index = arg_2_1,
					callback = arg_2_2
				})
			else
				local var_2_3 = arg_1_0
				local var_2_4 = var_3.sendNotification

				GAME = var_2_10005

				var_2_4(var_2_3, var_2_10005.GET_MAIL_LIST, {
					cmd = arg_2_1,
					callback = arg_2_2
				})
			end
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_OPERATION, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.DEAL_MAIL_OPERATION, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_DELETE_COLLECTION, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.DELETE_COLLECTION_MAIL, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_WITHDRAWAL, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.GET_STORE_RES, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_EXTEND_STORE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.EXTEND_STORE_CAPACITY, {
			isDiamond = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_GET_MAIL_TITLE, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0
		local var_7_1 = var_3.sendNotification

		GAME = var_2_10005

		var_7_1(var_7_0, var_2_10005.GET_MAIL_TITLE_LIST, {
			mailList = arg_7_1,
			callback = arg_7_2
		})

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_8_0)
	local var_8_0 = {}

	GAME = var_1_10002
	var_8_0[var_1_10002.DEAL_MAIL_OPERATION_DONE] = function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1:getBody()
		local var_9_1 = arg_9_0.viewComponent

		var_3.UpdateOperationDeal(var_9_1, var_9_0.cmd, var_9_0.ids, var_9_0.ignoreTips)
		arg_9_0:ShowAndCheckDrops(var_9_0.items)

		return
	end
	GAME = var_2
	var_8_0[var_2.DELETE_COLLECTION_MAIL_DONE] = function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_1:getBody()
		local var_10_1 = arg_10_0.viewComponent

		var_3.UpdateCollectionDelete(var_10_1, var_10_0)

		pg = var_3

		local var_10_2 = var_3.TipsMgr.GetInstance()
		local var_10_3 = var_3.ShowTips

		i18n = var_5

		var_10_3(var_10_2, var_5("main_mailMediator_mailDelete"))

		return
	end
	GAME = var_2
	var_8_0[var_2.GET_STORE_RES_DONE] = function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_1:getBody()
		local var_11_1 = arg_11_0.viewComponent

		var_3.UpdateStore(var_11_1)

		pg = var_3

		local var_11_2 = var_3.TipsMgr.GetInstance()
		local var_11_3 = var_3.ShowTips

		i18n = var_2_10005

		var_11_3(var_11_2, var_2_10005("mail_storeroom_taken_1"))

		return
	end
	GAME = var_2
	var_8_0[var_2.EXTEND_STORE_CAPACITY_DONE] = function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1:getBody()
		local var_12_1 = arg_12_0.viewComponent

		var_3.UpdateStore(var_12_1)

		pg = var_3

		local var_12_2 = var_3.TipsMgr.GetInstance()
		local var_12_3 = var_3.ShowTips

		i18n = var_2_10005

		var_12_3(var_12_2, var_2_10005("mail_storeroom_extend_1"))

		return
	end
	GAME = var_2
	var_8_0[var_2.MAIL_DOUBLE_CONFIREMATION_MSGBOX] = function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_1:getBody()
		local var_13_1 = arg_13_0.viewComponent

		var_3.ShowDoubleConfiremationMsgBox(var_13_1, var_13_0)

		return
	end
	PlayerProxy = var_2
	var_8_0[var_2.UPDATED] = function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0.viewComponent

		var_2.UpdateRes(var_14_0)

		return
	end
	arg_8_0.handleDic = var_8_0
	arg_8_0.handleElse = nil

	return
end

function var_0_1.ShowAndCheckDrops(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	local var_15_0 = {}

	if #arg_15_1 > 0 then
		table = var_3

		var_3.insert(var_15_0, function(arg_16_0)
			local var_16_0 = arg_15_0.viewComponent
			local var_16_1 = var_1.emit

			BaseUI = var_2_10003

			var_16_1(var_16_0, var_2_10003.ON_ACHIEVE, arg_15_1, arg_16_0)

			return
		end)
	end

	underscore = var_3

	if var_3.detect(arg_15_1, function(arg_17_0)
		local var_17_0 = arg_17_0.type

		DROP_TYPE_ITEM = var_2_10002

		local var_17_3

		if var_17_0 == var_2_10002 then
			local var_17_1 = arg_17_0
			local var_17_2 = arg_17_0.getConfig(var_17_1, "type")

			Item = var_17_1

			if var_17_2 == var_17_1.SKIN_ASSIGNED_TYPE then
				Item = var_17_2
				var_17_3 = var_17_2.InTimeLimitSkinAssigned(arg_17_0.id)

				goto label_17_0
			end
		end

		var_17_3 = false

		if false then
			var_17_3 = true
		end

		::label_17_0::

		return var_17_3
	end) then
		table = var_4

		var_4.insert(var_15_0, function(arg_18_0)
			pg = var_2_10001

			local var_18_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_18_1 = var_1.ShowMsgBox
			local var_18_2 = {
				hideNo = true
			}

			i18n = var_2_10004

			local var_18_3 = "skin_exchange_usetip"
			local var_18_4 = var_0

			var_18_2.content = var_2_10004(var_18_3, var_6.getName(var_18_4))
			var_18_2.onYes = arg_18_0
			var_18_2.onNo = arg_18_0

			var_18_1(var_18_0, var_18_2)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_15_0, function()
		local var_19_0

		getProxy = var_2_10001
		TechnologyProxy = var_2_10002

		local var_19_1 = var_2_10001(var_2_10002)

		PlayerPrefs = var_2_10002

		if var_2_10002.GetInt("help_research_package", 0) == 0 then
			ipairs = var_2

			for iter_19_0, iter_19_1 in var_2(arg_15_1) do
				local var_19_2 = iter_19_1.type

				DROP_TYPE_ITEM = var_2_10008

				if var_19_2 == var_2_10008 then
					checkExist = var_19_2

					if var_19_2(var_19_1:getItemCanUnlockBluePrint(iter_19_1.id), {
						1
					}) then
						break
					end
				end
			end
		end

		if var_19_0 then
			PlayerPrefs = var_2

			var_2.SetInt("help_research_package", 1)

			PlayerPrefs = var_2

			var_2.Save()

			pg = var_2

			local var_19_3 = var_2.MsgboxMgr.GetInstance()
			local var_19_4 = var_2.ShowMsgBox
			local var_19_5 = {}

			MSGBOX_TYPE_HELP = iter_19_0
			var_19_5.type = iter_19_0
			i18n = iter_19_0
			var_19_5.helps = iter_19_0("help_research_package")
			var_19_5.show_blueprint = var_19_0

			var_19_4(var_19_3, var_19_5)
		end

		return
	end)

	return
end

return var_0_1
