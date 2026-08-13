class = var_0_10000

local var_0_0 = "AnniversaryIsland2023Mediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillMediatorTemplate"))

function var_0_1.register(arg_1_0)
	var_0_1.super.register(arg_1_0)

	getProxy = var_1
	ActivityProxy = var_3

	local var_1_0 = var_1(var_3)
	local var_1_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_1_2 = var_1_1(var_1_0, var_1_10004.ACTIVITY_TYPE_BUILDING_BUFF_2)
	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.sendNotification

	GAME = var_1_10005

	var_1_4(var_1_3, var_1_10005.ACTIVITY_OPERATION, {
		cmd = 2,
		activity_id = var_1_2.id
	})

	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = var_0_1.super.listNotificationInterests(arg_2_0)

	table = var_1_10002

	local var_2_1 = var_1_10002.insertto
	local var_2_2 = var_2_0
	local var_2_3 = {}

	ActivityProxy = var_1_10006
	var_2_3[1] = var_1_10006.ACTIVITY_SHOW_AWARDS

	var_2_1(var_2_2, var_2_3)

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	var_0_1.super.handleNotification(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.getName(var_3_0)
	local var_3_2 = arg_3_1:getBody()

	ActivityProxy = var_3_0

	if var_3_1 == var_3_0.ACTIVITY_SHOW_AWARDS then
		local var_3_3 = arg_3_0
		local var_3_4 = arg_3_0.addSubLayers

		Context = var_1_10007

		local var_3_5 = var_1_10007.New
		local var_3_6 = {}

		AwardInfoMediator = var_1_10010
		var_3_6.mediator = var_1_10010
		AnniversaryIslandAwardLayer = var_1_10010
		var_3_6.viewComponent = var_1_10010
		var_3_6.data = {
			items = var_3_2.awards
		}
		var_3_6.onRemoved = var_3_2.callback

		var_3_4(var_3_3, var_3_5(var_3_6))
	end

	return
end

function var_0_1.CheckPreloadData(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_4_0 = var_1_10002(var_1_10004)
	local var_4_1 = var_2.getContextByMediator

	AnniversaryIsland2023Mediator = var_1_10005

	if var_4_1(var_4_0, var_1_10005) then
		getProxy = var_1_10003
		ContextProxy = var_1_10005

		local var_4_2 = var_1_10003(var_1_10005)

		var_1_10003 = var_1_10003.getCurrentContext(var_4_2)

		local var_4_3

		if not arg_4_0.prevContext then
			var_4_3 = var_1_10003
		end

		arg_4_0.prevContext = var_4_3
		getProxy = var_4_3
		ContextProxy = var_1_10006
		var_1_10006 = var_4_3(var_1_10006)

		local var_4_4 = var_4.CleanUntilMediator

		AnniversaryIsland2023Mediator = var_1_10007

		var_4_4(var_1_10006, var_1_10007)
	else
		Context = var_1_10003

		local var_4_5 = var_1_10003.New()

		SCENE = var_1_10003
		var_1_10003 = var_1_10003.SetSceneInfo

		local var_4_6 = var_4_5

		SCENE = var_1_10006

		var_1_10003(var_4_6, var_1_10006.ANNIVERSARY_ISLAND_BACKHILL_2023)

		getProxy = var_1_10003
		ContextProxy = var_4_6

		local var_4_7 = var_1_10003(var_4_6)

		var_1_10003 = var_1_10003.getCurrentContext(var_4_7)

		local var_4_8 = var_4_5

		var_4_5.extendData(var_4_8, {
			fromMediatorName = var_1_10003.mediator.__cname
		})

		getProxy = var_4
		ContextProxy = var_4_8

		local var_4_9 = var_4(var_4_8)

		var_4.pushContext(var_4_9, var_4_5)

		local var_4_10

		if not arg_4_0.prevContext then
			var_4_10 = var_1_10003
		end

		arg_4_0.prevContext = var_4_10
	end

	existCall = var_1_10003

	var_1_10003(arg_4_1)

	return
end

return var_0_1
