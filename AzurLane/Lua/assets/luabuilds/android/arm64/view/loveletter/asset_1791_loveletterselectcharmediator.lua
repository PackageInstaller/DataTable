class = var_0_10000

local var_0_0 = "LoveLetterSelectCharMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	LoveLetterSelectCharLayer = var_1_10004

	var_1_1(var_1_0, var_1_10004.SELECT_CHAR, function(arg_2_0, arg_2_1)
		local var_2_0

		if arg_1_0.contextData.isRepair then
			var_2_10004 = arg_1_0
			var_2_0 = var_2_0.addSubLayers
			Context = var_2_10005

			local var_2_1 = var_2_10005.New
			local var_2_2 = {}

			LoveLetterSelectCharConfirmLayer = var_2_10008
			var_2_2.viewComponent = var_2_10008
			LoveLetterSelectCharConfirmMediator = var_2_10008
			var_2_2.mediator = var_2_10008
			var_2_2.data = {
				isRepair = true,
				groupId = arg_2_1,
				itemVO = arg_1_0.contextData.itemVO
			}

			var_2_0(var_2_10004, var_2_1(var_2_2))
		else
			getProxy = var_2_0
			ActivityProxy = var_2_10004

			local var_2_3 = var_2_0(var_2_10004)
			local var_2_4 = var_2.getActivityById(var_2_3, arg_1_0.contextData.actId)

			if var_2.GetTargetGroupId(var_2_4) == arg_2_1 then
				pg = var_3

				local var_2_5 = var_3.TipsMgr.GetInstance()
				local var_2_6 = var_3.ShowTips

				i18n = var_2_10006

				var_2_6(var_2_5, var_2_10006("loveactivity_ui_18"))

				return
			end

			local var_2_7 = arg_1_0
			local var_2_8 = var_3.addSubLayers

			Context = var_2_10006

			local var_2_9 = var_2_10006.New
			local var_2_10 = {}

			LoveLetterSelectCharConfirmLayer = var_2_10009
			var_2_10.viewComponent = var_2_10009
			LoveLetterSelectCharConfirmMediator = var_2_10009
			var_2_10.mediator = var_2_10009
			var_2_10.data = {
				groupId = arg_2_1,
				actId = arg_1_0.contextData.actId
			}

			var_2_8(var_2_7, var_2_9(var_2_10))
		end

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	LoveLetterSelectCharLayer = var_4

	var_1_3(var_1_2, var_4.ON_INDEX, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_3_2 = var_2_10005.New
		local var_3_3 = {}

		CustomIndexLayer = var_2_10008
		var_3_3.viewComponent = var_2_10008
		CustomIndexMediator = var_2_10008
		var_3_3.mediator = var_2_10008
		var_3_3.data = arg_3_1

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)

	getProxy = var_1_3
	CollectionProxy = var_1_2

	local var_1_4 = var_1_3(var_1_2)
	local var_1_5 = arg_1_0.viewComponent

	var_2.setShipGroups(var_1_5, var_1_4:getGroups())

	getProxy = var_2
	BayProxy = var_1_5

	local var_1_6 = var_2(var_1_5)
	local var_1_7 = arg_1_0.viewComponent

	var_3.setProposeList(var_1_7, var_1_6:getProposeGroupList())

	return
end

function var_0_1.initNotificationHandleDic(arg_4_0)
	local var_4_0 = {}

	ActivityProxy = var_1_10002
	var_4_0[var_1_10002.ACTIVITY_OPERATION_DONE] = function(arg_5_0, arg_5_1)
		if arg_5_1:getBody() == arg_5_0.contextData.actId then
			local var_5_0 = arg_5_0.viewComponent

			var_3.closeView(var_5_0)
		end

		return
	end
	GAME = var_2
	var_4_0[var_2.USE_ITEM_DONE] = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0.viewComponent

		var_2.closeView(var_6_0)

		return
	end
	arg_4_0.handleDic = var_4_0

	return
end

return var_0_1
