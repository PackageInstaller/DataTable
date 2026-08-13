class = var_0_10000

local var_0_0 = "BackYardDecorationMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.ADD_FURNITURE = "BackYardDecorationMediator:ADD_FURNITURE"
var_0_1.REMOVE_PAPER = "BackYardDecorationMediator:REMOVE_PAPER"
var_0_1.SAVE_ALL = "BackYardDecorationMediator:SAVE_ALL"
var_0_1.ClEAR_ALL = "BackYardDecorationMediator:ClEAR_ALL"
var_0_1.OPEN_SHOP = "BackYardDecorationMediator:OPEN_SHOP"
var_0_1.GET_CUSTOM_THEME = "BackYardDecorationMediator:GET_CUSTOM_THEME"
var_0_1.DELETE_THEME = "BackYardDecorationMediator:DELETE_THEME"
var_0_1.SAVE_THEME = "BackYardDecorationMediator:SAVE_THEME"
var_0_1.APPLY_THEME = "BackYardDecorationMediator:APPLY_THEME"
var_0_1.ADD_FURNITURES = "BackYardDecorationMediator:ADD_FURNITURES"
var_0_1.ON_SELECTED_FURNITRUE = "BackYardDecorationMediator:ON_SELECTED_FURNITRUE"
var_0_1.GET_CURR_FURNITURE = "BackYardDecorationMediator:GET_CURR_FURNITURE"
var_0_1.GET_OTHER_FURNITURE = "BackYardDecorationMediator:GET_OTHER_FURNITURE"
var_0_1.GET_ALL_FURNITURE = "BackYardDecorationMediator:GET_ALL_FURNITURE"
var_0_1.START_TAKE_THEME_PHOTO = "BackYardDecorationMediator:START_TAKE_THEME_PHOTO"
var_0_1.END_TAKE_THEME_PHOTO = "BackYardDecorationMediator:END_TAKE_THEME_PHOTO"
var_0_1.ON_SET_UP = "BackYardDecorationMediator:ON_SET_UP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_SELECTED_FURNITRUE, function(arg_2_0, arg_2_1)
		_courtyard = var_2_10002

		local var_2_0 = var_2_10002:GetController()

		var_2.SelectFurnitureByConfigId(var_2_0, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.APPLY_THEME, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1, var_3_2 = var_3.GetCanPutFurnitureForTheme(var_3_0, arg_1_0.dorm, arg_3_1)

		if arg_3_2 then
			arg_3_2(var_3_2, var_3_1)
		end

		return
	end)
	arg_1_0:bind(var_0_1.SAVE_THEME, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.AnyFurnitureInFloor
		local var_4_2 = arg_1_0.dorm

		getProxy = var_2_10007
		DormProxy = var_2_10009

		if not var_4_1(var_4_0, var_4_2, var_2_10007(var_2_10009).floor) then
			pg = var_2_10004

			local var_4_3 = var_2_10004.TipsMgr.GetInstance()

			var_2_10004 = var_2_10004.ShowTips
			i18n = var_7

			var_2_10004(var_4_3, var_7("backyard_save_empty_theme"))

			return
		end

		pg = var_2_10004

		local var_4_4 = var_2_10004.UIMgr.GetInstance()

		var_4.LoadingOn(var_4_4)

		BackYardBaseThemeTemplate = var_4

		local var_4_5 = var_4.BuildId(arg_4_1)
		local var_4_6
		local var_4_7

		pg = var_7

		local var_4_8 = var_7.UIMgr.GetInstance().uiCamera
		local var_4_9 = var_7.GetComponent

		typeof = var_2_10010
		Camera = var_2_10012

		local var_4_10 = var_4_9(var_4_8, var_2_10010(var_2_10012))

		seriesAsync = var_2_10008

		var_2_10008({
			function(arg_5_0)
				local var_5_0 = arg_1_0

				var_1.sendNotification(var_5_0, var_0_1.START_TAKE_THEME_PHOTO)

				BackYardThemeTempalteUtil = var_1

				var_1.TakePreview(var_4_10, function(arg_6_0)
					var_4_6 = arg_6_0

					arg_5_0()

					return
				end)

				return
			end,
			function(arg_7_0)
				onNextTick = var_3_10001

				var_3_10001(arg_7_0)

				return
			end,
			function(arg_8_0)
				BackYardThemeTempalteUtil = var_3_10001

				var_3_10001.TakeIcon(var_4_10, function(arg_9_0)
					var_4_7 = arg_9_0

					arg_8_0()

					return
				end)

				return
			end,
			function(arg_10_0)
				local var_10_0 = arg_1_0

				var_1.sendNotification(var_10_0, var_0_1.END_TAKE_THEME_PHOTO)

				onNextTick = var_1

				var_1(arg_10_0)

				return
			end,
			function(arg_11_0)
				if not var_4_6 or not var_4_7 then
					return
				end

				BackYardThemeTempalteUtil = var_1

				var_1.SavePhoto(var_4_5, var_4_6, var_4_7, arg_11_0)

				return
			end,
			function(arg_12_0)
				onNextTick = var_3_10001

				var_3_10001(arg_12_0)

				return
			end,
			function(arg_13_0)
				BackYardThemeTempalteUtil = var_3_10001

				local var_13_0 = var_3_10001.GetMd5(var_4_5)

				BackYardThemeTempalteUtil = var_3_10002

				local var_13_1 = var_3_10002.GetIconMd5(var_4_5)

				_courtyard = var_3

				local var_13_2 = var_3:GetController()
				local var_13_3 = var_3.GetStoreyData(var_13_2)

				pg = var_4

				local var_13_4 = var_4.UIMgr.GetInstance()

				var_4.LoadingOff(var_13_4)

				local var_13_5 = arg_1_0
				local var_13_6 = var_4.sendNotification

				GAME = var_3_10007

				var_13_6(var_13_5, var_3_10007.BACKYARD_SAVE_THEME_TEMPLATE, {
					id = arg_4_1,
					name = arg_4_2,
					furnitureputList = var_13_3,
					iconMd5 = var_13_1,
					imageMd5 = var_13_0
				})
				arg_13_0()

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_1.DELETE_THEME, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_1_0
		local var_14_1 = var_2.sendNotification

		GAME = var_2_10005

		var_14_1(var_14_0, var_2_10005.BACKYARD_DELETE_THEME_TEMPLATE, {
			templateId = arg_14_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GET_CUSTOM_THEME, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_1_0
		local var_15_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_15_2 = var_2_10005.BACKYARD_GET_THEME_TEMPLATE
		local var_15_3 = {}

		BackYardConst = var_2_10007
		var_15_3.type = var_2_10007.THEME_TEMPLATE_TYPE_CUSTOM
		var_15_3.callback = arg_15_1

		var_15_1(var_15_0, var_15_2, var_15_3)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SHOP, function(arg_16_0)
		_courtyard = var_2_10001

		local var_16_0 = var_2_10001:GetController()

		var_1.SaveFurnitures(var_16_0)

		local var_16_1 = arg_1_0.viewComponent
		local var_16_2 = var_1.emit

		BaseUI = var_2_10004

		var_16_2(var_16_1, var_2_10004.ON_CLOSE)

		local var_16_3 = arg_1_0
		local var_16_4 = var_1.sendNotification

		GAME = var_4

		var_16_4(var_16_3, var_4.OPEN_BACKYARD_SHOP)

		return
	end)
	arg_1_0:bind(var_0_1.SAVE_ALL, function(arg_17_0)
		_courtyard = var_2_10001

		local var_17_0 = var_2_10001:GetController()

		var_1.SaveFurnitures(var_17_0)

		return
	end)
	arg_1_0:bind(var_0_1.ClEAR_ALL, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_1_0
		local var_18_1 = var_2.sendNotification

		GAME = var_2_10005

		var_18_1(var_18_0, var_2_10005.ON_APPLY_SELF_THEME)

		_courtyard = var_18_1

		local var_18_2 = var_18_1:GetController()

		var_2.ClearFurnitures(var_18_2)

		return
	end)
	arg_1_0:bind(var_0_1.ADD_FURNITURE, function(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0 = arg_1_0
		local var_19_1 = var_3.GenUniqueID(var_19_0, arg_1_0.dorm, arg_19_1.configId)

		_courtyard = var_2_10004

		local var_19_2 = var_2_10004:GetController()

		var_4.AddFurniture(var_19_2, {
			selected = true,
			id = var_19_1,
			configId = arg_19_1.configId,
			date = arg_19_1.date
		})

		getProxy = var_4
		DormProxy = var_19_2

		local var_19_3 = var_4(var_19_2)
		local var_19_4 = var_4.getRawData(var_19_3)

		var_4.ClearNewFlagById(var_19_4, arg_19_1.configId)

		local var_19_5 = arg_1_0.dorm
		local var_19_6 = var_4.GetFurniture(var_19_5, arg_19_1.configId)

		var_4.ClearNewFlag(var_19_6)

		local var_19_7 = arg_1_0.viewComponent

		var_5.UpdateFurnitrue(var_19_7, var_4)

		if arg_19_2 then
			arg_19_2()
		end

		return
	end)
	arg_1_0:bind(var_0_1.ADD_FURNITURES, function(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
		local var_20_0 = {}

		table = var_2_10005

		var_2_10005.insert(var_20_0, function(arg_21_0)
			local var_21_0 = arg_1_0.viewComponent

			var_1.emit(var_21_0, var_0_1.ClEAR_ALL)

			onNextTick = var_1

			var_1(arg_21_0)

			return
		end)

		local function var_20_1(arg_22_0)
			_courtyard = var_3_10001

			local var_22_0 = var_3_10001:GetController()

			var_1.AddFurniture(var_22_0, {
				id = arg_22_0.id,
				configId = arg_22_0.configId,
				parent = arg_22_0.parent,
				position = arg_22_0.position,
				dir = arg_22_0.dir,
				date = arg_22_0.date
			})

			return
		end

		math = var_2_10006

		local var_20_2 = var_2_10006.ceil(#arg_20_2 / 3)

		pairs = var_7

		for iter_20_0, iter_20_1 in var_7(arg_20_2) do
			assert = var_2_10012

			var_2_10012(iter_20_1.position)

			table = var_2_10012

			var_2_10012.insert(var_20_0, function(arg_23_0)
				var_20_1(iter_20_1)

				if (iter_20_0 - 1) % var_20_2 == 0 then
					onNextTick = var_1

					var_1(arg_23_0)
				else
					arg_23_0()
				end

				return
			end)
		end

		pg = var_7

		local var_20_3 = var_7.UIMgr.GetInstance()

		var_7.LoadingOn(var_20_3)

		seriesAsync = var_7

		var_7(var_20_0, function()
			if arg_20_3 then
				arg_20_3(arg_20_2)
			end

			local var_24_0 = arg_1_0
			local var_24_1 = var_0.sendNotification

			GAME = var_3_10003

			var_24_1(var_24_0, var_3_10003.ON_APPLY_SELF_THEME_DONE, {
				id = arg_20_1
			})

			pg = var_24_1

			local var_24_2 = var_24_1.UIMgr.GetInstance()

			var_0.LoadingOff(var_24_2)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.REMOVE_PAPER, function(arg_25_0, arg_25_1)
		_courtyard = var_2_10002

		local var_25_0 = var_2_10002:GetController()

		var_2.RemovePaper(var_25_0, arg_25_1.id)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SET_UP, function(arg_26_0)
		local var_26_0 = arg_1_0

		var_1.SetUp(var_26_0)

		return
	end)

	return
end

function var_0_1.AnyFurnitureInFloor(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_1:GetThemeList()[arg_27_2] then
		return false
	end

	local var_27_0 = var_4:GetAllFurniture()

	table = var_1_10006

	return var_1_10006.getCount(var_27_0) > 0
end

function var_0_1.GetCanPutFurnitureForTheme(arg_28_0, arg_28_1, arg_28_2)
	getProxy = var_1_10003
	DormProxy = var_1_10005

	local var_28_0 = var_1_10003(var_1_10005).floor
	local var_28_1 = arg_28_0:GetAllFloorFurnitures(arg_28_1)
	local var_28_2 = arg_28_2:IsOccupyed(var_28_1, var_28_0)
	local var_28_3 = {}
	local var_28_4 = false

	if var_28_2 then
		var_28_3 = arg_28_2:GetUsableFurnituresForFloor(var_28_1, var_28_0)
		var_28_4 = false
	else
		local var_28_5 = arg_28_2:GetAllFurniture()

		pairs = var_9

		for iter_28_0, iter_28_1 in var_9(var_28_5) do
			table = var_1_10014

			var_1_10014.insert(var_28_3, iter_28_1)
		end

		var_28_4 = true
	end

	local var_28_6 = arg_28_0:FilterOwnCount(var_28_3)

	table = var_8

	local var_28_7 = var_8.sort
	local var_28_8 = var_28_6

	BackyardThemeFurniture = var_11

	var_28_7(var_28_8, var_11._LoadWeight)

	return var_28_6, var_28_4
end

function var_0_1.FilterOwnCount(arg_29_0, arg_29_1)
	local var_29_0 = {}
	local var_29_1 = {}
	local var_29_2 = {}

	getProxy = var_1_10005
	DormProxy = var_1_10007

	local var_29_3 = var_1_10005(var_1_10007)
	local var_29_4 = var_5.getRawData(var_29_3)

	ipairs = var_1_10006

	for iter_29_0, iter_29_1 in var_1_10006(arg_29_1) do
		var_1_10011 = iter_29_1.configId

		local var_29_5

		if not var_29_1[iter_29_1.configId] then
			var_29_5 = 0
		end

		var_29_1[var_1_10011] = var_29_5 + 1
		var_1_10011 = var_29_4:GetOwnFurnitureCount(iter_29_1.configId)

		if var_29_1[iter_29_1.configId] <= var_1_10011 then
			table = var_12

			var_12.insert(var_29_0, iter_29_1)
		else
			table = var_12

			var_12.insert(var_29_2, iter_29_1.id)
		end
	end

	ipairs = var_6

	for iter_29_2, iter_29_3 in var_6(var_29_2) do
		ipairs = var_1_10011

		for iter_29_4, iter_29_5 in var_1_10011(var_29_0) do
			if iter_29_5.parent == iter_29_3 then
				iter_29_5.parent = 0
			end
		end
	end

	return var_29_0
end

function var_0_1.GetAllFloorFurnitures(arg_30_0, arg_30_1)
	local var_30_0 = {}

	pairs = var_1_10003

	for iter_30_0, iter_30_1 in var_1_10003(arg_30_1:GetThemeList()) do
		pairs = var_1_10008

		for iter_30_2, iter_30_3 in var_1_10008(iter_30_1:GetAllFurniture()) do
			var_30_0[iter_30_2] = iter_30_3
		end
	end

	return var_30_0
end

function var_0_1.GenUniqueID(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:GetAllFloorFurnitures(arg_31_1)
	local var_31_1 = arg_31_1:GetOwnFurnitureCount(arg_31_2)

	for iter_31_0 = 0, var_31_1 - 1 do
		BackyardThemeFurniture = var_1_10009

		if not var_31_0[var_1_10009.GetUniqueId(arg_31_2, iter_31_0)] then
			return var_1_10009
		end
	end

	BackyardThemeFurniture = var_5

	return var_5.GetUniqueId(arg_31_2, 0)
end

function var_0_1.SetUp(arg_32_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_33_0)
			getProxy = var_2_10001
			DormProxy = var_2_10003

			local var_33_0 = var_2_10001(var_2_10003)

			arg_32_0.dorm = var_33_0:getData()

			local var_33_1 = arg_32_0.viewComponent

			var_2.SetDorm(var_33_1, arg_32_0.dorm)

			local var_33_2 = arg_32_0.viewComponent

			var_2.SetThemes(var_33_2, var_33_0:GetCustomThemeTemplates())

			onNextTick = var_2

			var_2(arg_33_0)

			return
		end,
		function(arg_34_0)
			if arg_32_0.viewComponent.themes then
				arg_34_0()

				return
			end

			local var_34_0 = arg_32_0.viewComponent
			local var_34_1 = var_1.emit

			BackYardDecorationMediator = var_2_10004

			var_34_1(var_34_0, var_2_10004.GET_CUSTOM_THEME, arg_34_0)

			return
		end
	}, function()
		local var_35_0 = arg_32_0.viewComponent

		var_0.InitPages(var_35_0)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_36_0)
	local var_36_0 = {}

	CourtYardEvent = var_1_10002
	var_36_0[1] = var_1_10002._SYN_FURNITURE
	CourtYardEvent = var_2
	var_36_0[2] = var_2._EXIT_MODE
	CourtYardEvent = var_2
	var_36_0[3] = var_2._FURNITURE_SELECTED
	DormProxy = var_2
	var_36_0[4] = var_2.THEME_TEMPLATE_ADDED
	DormProxy = var_2
	var_36_0[5] = var_2.THEME_TEMPLATE_DELTETED
	GAME = var_2
	var_36_0[6] = var_2.BACKYARD_GET_THEME_TEMPLATE_DONE
	GAME = var_2
	var_36_0[7] = var_2.ON_APPLY_SELF_THEME
	GAME = var_2
	var_36_0[8] = var_2.ON_APPLY_SELF_THEME_DONE
	CourtYardEvent = var_2
	var_36_0[9] = var_2._DRAG_ITEM
	CourtYardEvent = var_2
	var_36_0[10] = var_2._DRAG_ITEM_END
	var_36_0[11] = var_0_1.START_TAKE_THEME_PHOTO
	var_36_0[12] = var_0_1.END_TAKE_THEME_PHOTO

	return var_36_0
end

function var_0_1.handleNotification(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1
	local var_37_1 = arg_37_1.getName(var_37_0)
	local var_37_2 = arg_37_1:getBody()

	CourtYardEvent = var_37_0

	local var_37_3

	if var_37_1 == var_37_0._SYN_FURNITURE then
		var_37_3 = var_37_2[1]

		local var_37_4 = var_37_2[2]

		getProxy = var_1_10006
		DormProxy = var_1_10008
		var_1_10006 = var_1_10006(var_1_10008).floor
		var_1_10009 = arg_37_0.dorm
		var_1_10007 = var_1_10007.GetTheme(var_1_10009, var_1_10006)
		ipairs = var_1_10008

		for iter_37_0, iter_37_1 in var_1_10008(var_37_3) do
			if var_1_10007:GetFurniture(iter_37_1.id) then
				var_13:UpdatePosition(iter_37_1.position)
				var_13:UpdateDir(iter_37_1.dir)
				var_13:UpdateParent(iter_37_1.parent)
				var_13:UpdateChildList(iter_37_1.child)
				var_13:UpdateFloor(var_1_10006)
			else
				local var_37_5 = var_1_10007:AddFurniture(iter_37_1, var_1_10006)
			end

			local var_37_6 = arg_37_0.viewComponent

			var_14.UpdateDorm(var_37_6, arg_37_0.dorm)

			local var_37_7 = arg_37_0.viewComponent
			local var_37_8 = var_14.UpdateFurnitrue
			local var_37_9 = arg_37_0.dorm

			var_37_8(var_37_7, var_17.GetFurniture(var_37_9, iter_37_1.configId))
		end

		ipairs = var_8

		for iter_37_2, iter_37_3 in var_8(var_37_4) do
			local var_37_10 = var_1_10007:GetFurniture(iter_37_3)

			var_1_10007:DeleteFurniture(iter_37_3)

			if var_37_10 then
				local var_37_11 = arg_37_0.viewComponent

				var_14.UpdateDorm(var_37_11, arg_37_0.dorm)

				local var_37_12 = arg_37_0.viewComponent
				local var_37_13 = var_14.UpdateFurnitrue
				local var_37_14 = arg_37_0.dorm

				var_37_13(var_37_12, var_17.GetFurniture(var_37_14, var_37_10.configId))
			end
		end
	else
		DormProxy = var_37_3

		if var_37_1 == var_37_3.THEME_TEMPLATE_ADDED then
			var_1_10006 = arg_37_0.viewComponent

			var_4.CustomThemeAdded(var_1_10006, var_37_2.template)
		else
			DormProxy = var_4

			if var_37_1 == var_4.THEME_TEMPLATE_DELTETED then
				var_1_10006 = arg_37_0.viewComponent

				var_4.CustomThemeDeleted(var_1_10006, var_37_2.templateId)
			else
				GAME = var_4

				local var_37_15

				if var_37_1 == var_4.BACKYARD_GET_THEME_TEMPLATE_DONE then
					getProxy = var_37_15
					DormProxy = var_1_10006
					var_37_15 = var_37_15(var_1_10006)
					var_1_10007 = arg_37_0.viewComponent

					var_5.SetThemes(var_1_10007, var_37_15:GetCustomThemeTemplates())
				else
					GAME = var_37_15

					if var_37_1 == var_37_15.ON_APPLY_SELF_THEME then
						local var_37_16 = arg_37_0.viewComponent

						var_4.OnApplyThemeBefore(var_37_16)
					else
						GAME = var_4

						if var_37_1 == var_4.ON_APPLY_SELF_THEME_DONE then
							local var_37_17 = arg_37_0.viewComponent

							var_4.OnApplyThemeAfter(var_37_17, var_37_2.id)
						else
							CourtYardEvent = var_4

							local var_37_19

							if var_37_1 == var_4._EXIT_MODE then
								local var_37_18 = arg_37_0.viewComponent

								var_37_19 = var_37_19.emit
								BaseUI = var_1_10007

								var_37_19(var_37_18, var_1_10007.ON_CLOSE)
							else
								CourtYardEvent = var_37_19

								local var_37_21

								if var_37_1 == var_37_19._DRAG_ITEM then
									GetOrAddComponent = var_37_21

									local var_37_20 = arg_37_0.viewComponent._tf

									typeof = var_1_10007
									CanvasGroup = var_1_10009
									var_37_21 = var_37_21(var_37_20, var_1_10007(var_1_10009))
									var_37_21.blocksRaycasts = false
								else
									CourtYardEvent = var_37_21

									if var_37_1 == var_37_21._DRAG_ITEM_END then
										GetOrAddComponent = var_4

										local var_37_22 = arg_37_0.viewComponent._tf

										typeof = var_1_10007
										CanvasGroup = var_1_10009
										var_4(var_37_22, var_1_10007(var_1_10009)).blocksRaycasts = true
									elseif var_37_1 == var_0_1.START_TAKE_THEME_PHOTO then
										GetOrAddComponent = var_4

										local var_37_23 = arg_37_0.viewComponent._tf

										typeof = var_1_10007
										CanvasGroup = var_1_10009
										var_4(var_37_23, var_1_10007(var_1_10009)).alpha = 0
									else
										local var_37_25

										if var_37_1 == var_0_1.END_TAKE_THEME_PHOTO then
											GetOrAddComponent = var_37_25

											local var_37_24 = arg_37_0.viewComponent._tf

											typeof = var_1_10007
											CanvasGroup = var_1_10009
											var_37_25 = var_37_25(var_37_24, var_1_10007(var_1_10009))
											var_37_25.alpha = 1
										else
											CourtYardEvent = var_37_25

											if var_37_1 == var_37_25._FURNITURE_SELECTED then
												local var_37_26 = arg_37_0.viewComponent
												local var_37_27 = var_4.emit

												BackYardDecrationLayer = var_1_10007

												var_37_27(var_37_26, var_1_10007.INNER_SELECTED_FURNITRUE, var_37_2)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
