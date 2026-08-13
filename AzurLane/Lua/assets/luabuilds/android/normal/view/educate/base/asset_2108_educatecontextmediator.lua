class = var_0_10000

local var_0_0 = "EducateContextMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

function var_0_1.onRegister(arg_1_0)
	var_0_1.super.onRegister(arg_1_0)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	EducateBaseUI = var_1_10003

	var_1_1(var_1_0, var_1_10003.EDUCATE_GO_SCENE, function(arg_2_0, arg_2_1, ...)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.GO_SCENE, arg_2_1, ...)

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	EducateBaseUI = var_3

	var_1_3(var_1_2, var_3.EDUCATE_CHANGE_SCENE, function(arg_3_0, arg_3_1, ...)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.CHANGE_SCENE, arg_3_1, ...)

		return
	end)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.bind

	EducateBaseUI = var_3

	var_1_5(var_1_4, var_3.EDUCATE_GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0

		var_3.addSubLayers(var_4_0, arg_4_1, nil, arg_4_2)

		return
	end)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.bind

	EducateBaseUI = var_3

	var_1_7(var_1_6, var_3.EDUCATE_ON_AWARD, function(arg_5_0, arg_5_1)
		if #arg_5_1.items <= 0 then
			return
		end

		EducateHelper = var_2

		local var_5_0 = var_2.FilterDropByTypes
		local var_5_1 = arg_5_1.items
		local var_5_2 = {}

		EducateConst = var_2_10005
		var_5_2[1] = var_2_10005.DROP_TYPE_ATTR
		EducateConst = var_5
		var_5_2[2] = var_5.DROP_TYPE_RES
		EducateConst = var_5
		var_5_2[3] = var_5.DROP_TYPE_ITEM
		EducateConst = var_5
		var_5_2[4] = var_5.DROP_TYPE_BUFF
		EducateConst = var_5
		var_5_2[5] = var_5.DROP_TYPE_POLAROID

		if #var_5_0(var_5_1, var_5_2) <= 0 then
			return
		end

		local var_5_3 = arg_1_0
		local var_5_4 = var_3.addSubLayers

		Context = var_5

		local var_5_5 = var_5.New
		local var_5_6 = {}

		EducateAwardInfoMediator = var_2_10007
		var_5_6.mediator = var_2_10007
		EducateAwardInfoLayer = var_2_10007
		var_5_6.viewComponent = var_2_10007
		var_5_6.data = arg_5_1

		var_5_4(var_5_3, var_5_5(var_5_6))

		return
	end)

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.bind

	EducateBaseUI = var_3

	var_1_9(var_1_8, var_3.EDUCATE_ON_ITEM, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_6_2 = var_2_10004.New
		local var_6_3 = {}

		EducateMsgBoxLayer = var_2_10006
		var_6_3.viewComponent = var_2_10006
		EducateMsgBoxMediator = var_2_10006
		var_6_3.mediator = var_2_10006
		setmetatable = var_2_10006

		local var_6_4 = {}

		EducateMsgBoxLayer = var_2_10008
		var_6_4.type = var_2_10008.TYPE_SINGLE_ITEM
		var_6_3.data = var_2_10006(var_6_4, {
			__index = arg_6_1
		})

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)

	local var_1_10 = arg_1_0
	local var_1_11 = arg_1_0.bind

	EducateBaseUI = var_3

	var_1_11(var_1_10, var_3.EDUCATE_ON_MSG_TIP, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_7_2 = var_2_10004.New
		local var_7_3 = {}

		EducateMsgBoxLayer = var_2_10006
		var_7_3.viewComponent = var_2_10006
		EducateMsgBoxMediator = var_2_10006
		var_7_3.mediator = var_2_10006
		setmetatable = var_2_10006

		local var_7_4 = {}

		EducateMsgBoxLayer = var_2_10008
		var_7_4.type = var_2_10008.TYPE_NORMAL
		var_7_3.data = var_2_10006(var_7_4, {
			__index = arg_7_1
		})

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)

	local var_1_12 = arg_1_0
	local var_1_13 = arg_1_0.bind

	EducateBaseUI = var_3

	var_1_13(var_1_12, var_3.EDUCATE_ON_UNLOCK_TIP, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_8_2 = var_2_10004.New
		local var_8_3 = {}

		EducateUnlockTipLayer = var_2_10006
		var_8_3.viewComponent = var_2_10006
		EducateContextMediator = var_2_10006
		var_8_3.mediator = var_2_10006
		var_8_3.data = arg_8_1

		var_8_1(var_8_0, var_8_2(var_8_3))

		return
	end)

	return
end

return var_0_1
