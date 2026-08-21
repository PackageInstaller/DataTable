local var_0_0 = class("BackYardDecorationMediator", import("...base.ContextMediator"))

var_0_0.ADD_FURNITURE = "BackYardDecorationMediator:ADD_FURNITURE"
var_0_0.REMOVE_PAPER = "BackYardDecorationMediator:REMOVE_PAPER"
var_0_0.SAVE_ALL = "BackYardDecorationMediator:SAVE_ALL"
var_0_0.ClEAR_ALL = "BackYardDecorationMediator:ClEAR_ALL"
var_0_0.OPEN_SHOP = "BackYardDecorationMediator:OPEN_SHOP"
var_0_0.GET_CUSTOM_THEME = "BackYardDecorationMediator:GET_CUSTOM_THEME"
var_0_0.DELETE_THEME = "BackYardDecorationMediator:DELETE_THEME"
var_0_0.SAVE_THEME = "BackYardDecorationMediator:SAVE_THEME"
var_0_0.APPLY_THEME = "BackYardDecorationMediator:APPLY_THEME"
var_0_0.ADD_FURNITURES = "BackYardDecorationMediator:ADD_FURNITURES"
var_0_0.ON_SELECTED_FURNITRUE = "BackYardDecorationMediator:ON_SELECTED_FURNITRUE"
var_0_0.GET_CURR_FURNITURE = "BackYardDecorationMediator:GET_CURR_FURNITURE"
var_0_0.GET_OTHER_FURNITURE = "BackYardDecorationMediator:GET_OTHER_FURNITURE"
var_0_0.GET_ALL_FURNITURE = "BackYardDecorationMediator:GET_ALL_FURNITURE"
var_0_0.START_TAKE_THEME_PHOTO = "BackYardDecorationMediator:START_TAKE_THEME_PHOTO"
var_0_0.END_TAKE_THEME_PHOTO = "BackYardDecorationMediator:END_TAKE_THEME_PHOTO"
var_0_0.ON_SET_UP = "BackYardDecorationMediator:ON_SET_UP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_SELECTED_FURNITRUE, function(arg_2_0, arg_2_1)
		_courtyard:GetController():SelectFurnitureByConfigId(arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.APPLY_THEME, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0, var_3_1 = arg_1_0:GetCanPutFurnitureForTheme(arg_1_0.dorm, arg_3_1)

		if arg_3_2 then
			arg_3_2(var_3_1, var_3_0)
		end

		return
	end)
	arg_1_0:bind(var_0_0.SAVE_THEME, function(arg_4_0, arg_4_1, arg_4_2)
		if not arg_1_0:AnyFurnitureInFloor(arg_1_0.dorm, getProxy(DormProxy).floor) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_save_empty_theme"))

			return
		end

		pg.UIMgr.GetInstance():LoadingOn()

		local var_4_0 = BackYardBaseThemeTemplate.BuildId(arg_4_1)
		local var_4_1
		local var_4_2
		local var_4_3 = pg.UIMgr.GetInstance().uiCamera:GetComponent(typeof(Camera))

		seriesAsync({
			function(arg_5_0)
				arg_1_0:sendNotification(var_0_0.START_TAKE_THEME_PHOTO)
				BackYardThemeTempalteUtil.TakePreview(var_4_3, function(arg_6_0)
					var_4_1 = arg_6_0

					arg_5_0()

					return
				end)

				return
			end,
			function(arg_7_0)
				onNextTick(arg_7_0)

				return
			end,
			function(arg_8_0)
				BackYardThemeTempalteUtil.TakeIcon(var_4_3, function(arg_9_0)
					var_4_2 = arg_9_0

					arg_8_0()

					return
				end)

				return
			end,
			function(arg_10_0)
				arg_1_0:sendNotification(var_0_0.END_TAKE_THEME_PHOTO)
				onNextTick(arg_10_0)

				return
			end,
			function(arg_11_0)
				if not var_4_1 or not var_4_2 then
					return
				end

				BackYardThemeTempalteUtil.SavePhoto(var_4_0, var_4_1, var_4_2, arg_11_0)

				return
			end,
			function(arg_12_0)
				onNextTick(arg_12_0)

				return
			end,
			function(arg_13_0)
				pg.UIMgr.GetInstance():LoadingOff()
				arg_1_0:sendNotification(GAME.BACKYARD_SAVE_THEME_TEMPLATE, {
					id = arg_4_1,
					name = arg_4_2,
					furnitureputList = _courtyard:GetController():GetStoreyData(),
					iconMd5 = BackYardThemeTempalteUtil.GetIconMd5(var_4_0),
					imageMd5 = BackYardThemeTempalteUtil.GetMd5(var_4_0)
				})
				arg_13_0()

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.DELETE_THEME, function(arg_14_0, arg_14_1)
		arg_1_0:sendNotification(GAME.BACKYARD_DELETE_THEME_TEMPLATE, {
			templateId = arg_14_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.GET_CUSTOM_THEME, function(arg_15_0, arg_15_1)
		arg_1_0:sendNotification(GAME.BACKYARD_GET_THEME_TEMPLATE, {
			type = BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM,
			callback = arg_15_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SHOP, function(arg_16_0)
		_courtyard:GetController():SaveFurnitures()
		arg_1_0.viewComponent:emit(BaseUI.ON_CLOSE)
		arg_1_0:sendNotification(GAME.OPEN_BACKYARD_SHOP)

		return
	end)
	arg_1_0:bind(var_0_0.SAVE_ALL, function(arg_17_0)
		_courtyard:GetController():SaveFurnitures()

		return
	end)
	arg_1_0:bind(var_0_0.ClEAR_ALL, function(arg_18_0, arg_18_1)
		arg_1_0:sendNotification(GAME.ON_APPLY_SELF_THEME)
		_courtyard:GetController():ClearFurnitures()

		return
	end)
	arg_1_0:bind(var_0_0.ADD_FURNITURE, function(arg_19_0, arg_19_1, arg_19_2)
		_courtyard:GetController():AddFurniture({
			selected = true,
			id = arg_1_0:GenUniqueID(arg_1_0.dorm, arg_19_1.configId),
			configId = arg_19_1.configId,
			date = arg_19_1.date
		})
		getProxy(DormProxy):getRawData():ClearNewFlagById(arg_19_1.configId)

		local var_19_0 = arg_1_0.dorm:GetFurniture(arg_19_1.configId)

		var_19_0:ClearNewFlag()
		arg_1_0.viewComponent:UpdateFurnitrue(var_19_0)

		if arg_19_2 then
			arg_19_2()
		end

		return
	end)
	arg_1_0:bind(var_0_0.ADD_FURNITURES, function(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
		table.insert({}, function(arg_21_0)
			arg_1_0.viewComponent:emit(var_0_0.ClEAR_ALL)
			onNextTick(arg_21_0)

			return
		end)

		local function var_20_0(arg_22_0)
			_courtyard:GetController():AddFurniture({
				id = arg_22_0.id,
				configId = arg_22_0.configId,
				parent = arg_22_0.parent,
				position = arg_22_0.position,
				dir = arg_22_0.dir,
				date = arg_22_0.date
			})

			return
		end

		local var_20_1 = math.ceil(#arg_20_2 / 3)

		for iter_20_0, iter_20_1 in pairs(arg_20_2) do
			assert(iter_20_1.position)
			table.insert({}, function(arg_23_0)
				var_20_0(iter_20_1)

				if (iter_20_0 - 1) % var_20_1 == 0 then
					onNextTick(arg_23_0)
				else
					arg_23_0()
				end

				return
			end)
		end

		pg.UIMgr.GetInstance():LoadingOn()
		seriesAsync({}, function()
			if arg_20_3 then
				arg_20_3(arg_20_2)
			end

			arg_1_0:sendNotification(GAME.ON_APPLY_SELF_THEME_DONE, {
				id = arg_20_1
			})
			pg.UIMgr.GetInstance():LoadingOff()

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.REMOVE_PAPER, function(arg_25_0, arg_25_1)
		_courtyard:GetController():RemovePaper(arg_25_1.id)

		return
	end)
	arg_1_0:bind(var_0_0.ON_SET_UP, function(arg_26_0)
		arg_1_0:SetUp()

		return
	end)

	return
end

function var_0_0.AnyFurnitureInFloor(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1:GetThemeList()[arg_27_2]
	local var_27_1

	if not var_27_0 then
		do return false end

		var_27_1 = table.getCount
	end

	return var_27_1((var_27_0:GetAllFurniture())) > 0
end

function var_0_0.GetCanPutFurnitureForTheme(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = getProxy(DormProxy).floor
	local var_28_1 = arg_28_0:GetAllFloorFurnitures(arg_28_1)
	local var_28_2 = {}
	local var_28_3 = false

	if arg_28_2:IsOccupyed(var_28_1, var_28_0) then
		var_28_2 = arg_28_2:GetUsableFurnituresForFloor(var_28_1, var_28_0)
		var_28_3 = false
	else
		for iter_28_0, iter_28_1 in pairs((arg_28_2:GetAllFurniture())) do
			table.insert(var_28_2, iter_28_1)
		end

		var_28_3 = true
	end

	local var_28_4 = arg_28_0:FilterOwnCount(var_28_2)

	table.sort(var_28_4, BackyardThemeFurniture._LoadWeight)

	return var_28_4, var_28_3
end

function var_0_0.FilterOwnCount(arg_29_0, arg_29_1)
	local var_29_0 = getProxy(DormProxy):getRawData()

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		local var_29_1 = ({})[iter_29_1.configId]

		if not ({})[iter_29_1.configId] then
			var_29_1 = 0
		end

		;({})[iter_29_1.configId] = var_29_1 + 1

		if var_29_0:GetOwnFurnitureCount(iter_29_1.configId) >= ({})[iter_29_1.configId] then
			table.insert({}, iter_29_1)
		else
			table.insert({}, iter_29_1.id)
		end
	end

	for iter_29_2, iter_29_3 in ipairs({}) do
		for iter_29_4, iter_29_5 in ipairs({}) do
			if iter_29_5.parent == iter_29_3 then
				iter_29_5.parent = 0
			end
		end
	end

	return {}
end

function var_0_0.GetAllFloorFurnitures(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in pairs(arg_30_1:GetThemeList()) do
		for iter_30_2, iter_30_3 in pairs(iter_30_1:GetAllFurniture()) do
			({})[iter_30_2] = iter_30_3
		end
	end

	return {}
end

function var_0_0.GenUniqueID(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:GetAllFloorFurnitures(arg_31_1)

	for iter_31_0 = 0, arg_31_1:GetOwnFurnitureCount(arg_31_2) - 1 do
		local var_31_1 = BackyardThemeFurniture.GetUniqueId(arg_31_2, iter_31_0)

		if not var_31_0[var_31_1] then
			return var_31_1
		end
	end

	return BackyardThemeFurniture.GetUniqueId(arg_31_2, 0)
end

function var_0_0.SetUp(arg_32_0)
	seriesAsync({
		function(arg_33_0)
			local var_33_0 = getProxy(DormProxy)

			arg_32_0.dorm = var_33_0:getData()

			arg_32_0.viewComponent:SetDorm(arg_32_0.dorm)
			arg_32_0.viewComponent:SetThemes(var_33_0:GetCustomThemeTemplates())
			onNextTick(arg_33_0)

			return
		end,
		function(arg_34_0)
			if arg_32_0.viewComponent.themes then
				arg_34_0()

				return
			end

			arg_32_0.viewComponent:emit(BackYardDecorationMediator.GET_CUSTOM_THEME, arg_34_0)

			return
		end
	}, function()
		arg_32_0.viewComponent:InitPages()

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_36_0)
	return {
		CourtYardEvent._SYN_FURNITURE,
		CourtYardEvent._EXIT_MODE,
		CourtYardEvent._FURNITURE_SELECTED,
		DormProxy.THEME_TEMPLATE_ADDED,
		DormProxy.THEME_TEMPLATE_DELTETED,
		GAME.BACKYARD_GET_THEME_TEMPLATE_DONE,
		GAME.ON_APPLY_SELF_THEME,
		GAME.ON_APPLY_SELF_THEME_DONE,
		CourtYardEvent._DRAG_ITEM,
		CourtYardEvent._DRAG_ITEM_END,
		var_0_0.START_TAKE_THEME_PHOTO,
		var_0_0.END_TAKE_THEME_PHOTO
	}
end

function var_0_0.handleNotification(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1:getName()
	local var_37_1 = arg_37_1:getBody()

	if var_37_0 == CourtYardEvent._SYN_FURNITURE then
		local var_37_2 = getProxy(DormProxy).floor
		local var_37_3 = arg_37_0.dorm:GetTheme(var_37_2)

		for iter_37_0, iter_37_1 in ipairs(var_37_1[1]) do
			local var_37_4 = var_37_3:GetFurniture(iter_37_1.id)

			if var_37_4 then
				var_37_4:UpdatePosition(iter_37_1.position)
				var_37_4:UpdateDir(iter_37_1.dir)
				var_37_4:UpdateParent(iter_37_1.parent)
				var_37_4:UpdateChildList(iter_37_1.child)
				var_37_4:UpdateFloor(var_37_2)
			else
				local var_37_5 = var_37_3:AddFurniture(iter_37_1, var_37_2)
			end

			arg_37_0.viewComponent:UpdateDorm(arg_37_0.dorm)
			arg_37_0.viewComponent:UpdateFurnitrue(arg_37_0.dorm:GetFurniture(iter_37_1.configId))
		end

		for iter_37_2, iter_37_3 in ipairs(var_37_1[2]) do
			local var_37_6 = var_37_3:GetFurniture(iter_37_3)

			var_37_3:DeleteFurniture(iter_37_3)

			if var_37_6 then
				arg_37_0.viewComponent:UpdateDorm(arg_37_0.dorm)
				arg_37_0.viewComponent:UpdateFurnitrue(arg_37_0.dorm:GetFurniture(var_37_6.configId))
			end
		end
	elseif var_37_0 == DormProxy.THEME_TEMPLATE_ADDED then
		arg_37_0.viewComponent:CustomThemeAdded(var_37_1.template)
	elseif var_37_0 == DormProxy.THEME_TEMPLATE_DELTETED then
		arg_37_0.viewComponent:CustomThemeDeleted(var_37_1.templateId)
	elseif var_37_0 == GAME.BACKYARD_GET_THEME_TEMPLATE_DONE then
		arg_37_0.viewComponent:SetThemes(getProxy(DormProxy):GetCustomThemeTemplates())
	elseif var_37_0 == GAME.ON_APPLY_SELF_THEME then
		arg_37_0.viewComponent:OnApplyThemeBefore()
	elseif var_37_0 == GAME.ON_APPLY_SELF_THEME_DONE then
		arg_37_0.viewComponent:OnApplyThemeAfter(var_37_1.id)
	elseif var_37_0 == CourtYardEvent._EXIT_MODE then
		arg_37_0.viewComponent:emit(BaseUI.ON_CLOSE)
	elseif var_37_0 == CourtYardEvent._DRAG_ITEM then
		GetOrAddComponent(arg_37_0.viewComponent._tf, typeof(CanvasGroup)).blocksRaycasts = false
	elseif var_37_0 == CourtYardEvent._DRAG_ITEM_END then
		GetOrAddComponent(arg_37_0.viewComponent._tf, typeof(CanvasGroup)).blocksRaycasts = true
	elseif var_37_0 == var_0_0.START_TAKE_THEME_PHOTO then
		GetOrAddComponent(arg_37_0.viewComponent._tf, typeof(CanvasGroup)).alpha = 0
	elseif var_37_0 == var_0_0.END_TAKE_THEME_PHOTO then
		GetOrAddComponent(arg_37_0.viewComponent._tf, typeof(CanvasGroup)).alpha = 1
	elseif var_37_0 == CourtYardEvent._FURNITURE_SELECTED then
		arg_37_0.viewComponent:emit(BackYardDecrationLayer.INNER_SELECTED_FURNITRUE, var_37_1)
	end

	return
end

return var_0_0
