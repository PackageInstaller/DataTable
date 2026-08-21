local var_0_0 = class("MailMediator", import("view.base.ContextMediator"))

var_0_0.ON_REQUIRE = "MailMediator.ON_REQUIRE"
var_0_0.ON_OPERATION = "MailMediator.ON_OPERATION"
var_0_0.ON_DELETE_COLLECTION = "MailMediator.ON_DELETE_COLLECTION"
var_0_0.ON_WITHDRAWAL = "MailMediator.ON_WITHDRAWAL"
var_0_0.ON_EXTEND_STORE = "MailMediator.ON_EXTEND_STORE"
var_0_0.ON_GET_MAIL_TITLE = "MailMediator.ON_GET_MAIL_TITLE"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(MailProxy)

	arg_1_0:bind(var_0_0.ON_REQUIRE, function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_1 == "collection" then
			arg_1_0:sendNotification(GAME.GET_COLLECTION_MAIL_LIST, {
				callback = arg_2_2
			})
		elseif type(arg_2_1) == "number" then
			arg_1_0:sendNotification(GAME.GET_MAIL_LIST_TO_INDEX, {
				index = arg_2_1,
				callback = arg_2_2
			})
		else
			arg_1_0:sendNotification(GAME.GET_MAIL_LIST, {
				cmd = arg_2_1,
				callback = arg_2_2
			})
		end

		return
	end)
	arg_1_0:bind(var_0_0.ON_OPERATION, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.DEAL_MAIL_OPERATION, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_DELETE_COLLECTION, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.DELETE_COLLECTION_MAIL, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_WITHDRAWAL, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.GET_STORE_RES, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_EXTEND_STORE, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.EXTEND_STORE_CAPACITY, {
			isDiamond = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_GET_MAIL_TITLE, function(arg_7_0, arg_7_1, arg_7_2)
		arg_1_0:sendNotification(GAME.GET_MAIL_TITLE_LIST, {
			mailList = arg_7_1,
			callback = arg_7_2
		})

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_8_0)
	arg_8_0.handleDic = {
		[GAME.DEAL_MAIL_OPERATION_DONE] = function(arg_9_0, arg_9_1)
			local var_9_0 = arg_9_1:getBody()

			arg_9_0.viewComponent:UpdateOperationDeal(var_9_0.cmd, var_9_0.ids, var_9_0.ignoreTips)
			arg_9_0:ShowAndCheckDrops(var_9_0.items)

			return
		end,
		[GAME.DELETE_COLLECTION_MAIL_DONE] = function(arg_10_0, arg_10_1)
			arg_10_0.viewComponent:UpdateCollectionDelete((arg_10_1:getBody()))
			pg.TipsMgr.GetInstance():ShowTips(i18n("main_mailMediator_mailDelete"))

			return
		end,
		[GAME.GET_STORE_RES_DONE] = function(arg_11_0, arg_11_1)
			local var_11_0 = arg_11_1:getBody()

			arg_11_0.viewComponent:UpdateStore()
			pg.TipsMgr.GetInstance():ShowTips(i18n("mail_storeroom_taken_1"))

			return
		end,
		[GAME.EXTEND_STORE_CAPACITY_DONE] = function(arg_12_0, arg_12_1)
			local var_12_0 = arg_12_1:getBody()

			arg_12_0.viewComponent:UpdateStore()
			pg.TipsMgr.GetInstance():ShowTips(i18n("mail_storeroom_extend_1"))

			return
		end,
		[GAME.MAIL_DOUBLE_CONFIREMATION_MSGBOX] = function(arg_13_0, arg_13_1)
			arg_13_0.viewComponent:ShowDoubleConfiremationMsgBox((arg_13_1:getBody()))

			return
		end,
		[PlayerProxy.UPDATED] = function(arg_14_0, arg_14_1)
			arg_14_0.viewComponent:UpdateRes()

			return
		end
	}
	arg_8_0.handleElse = nil

	return
end

function var_0_0.ShowAndCheckDrops(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	local var_15_0 = {}

	if #arg_15_1 > 0 then
		table.insert(var_15_0, function(arg_16_0)
			arg_15_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_15_1, arg_16_0)

			return
		end)
	end

	if underscore.detect(arg_15_1, function(arg_17_0)
		return arg_17_0.type == DROP_TYPE_ITEM and arg_17_0:getConfig("type") == Item.SKIN_ASSIGNED_TYPE and Item.InTimeLimitSkinAssigned(arg_17_0.id)
	end) then
		table.insert(var_15_0, function(arg_18_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("skin_exchange_usetip", var_0:getName()),
				onYes = arg_18_0,
				onNo = arg_18_0
			})

			return
		end)
	end

	seriesAsync(var_15_0, function()
		local var_19_0
		local var_19_1 = getProxy(TechnologyProxy)

		if PlayerPrefs.GetInt("help_research_package", 0) == 0 then
			for iter_19_0, iter_19_1 in ipairs(arg_15_1) do
				if iter_19_1.type == DROP_TYPE_ITEM then
					var_19_0 = checkExist(var_19_1:getItemCanUnlockBluePrint(iter_19_1.id), {
						1
					})

					if var_19_0 then
						break
					end
				end
			end
		end

		if var_19_0 then
			PlayerPrefs.SetInt("help_research_package", 1)
			PlayerPrefs.Save()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = i18n("help_research_package"),
				show_blueprint = var_19_0
			})
		end

		return
	end)

	return
end

return var_0_0
