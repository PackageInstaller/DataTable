local var_0_0 = class("DormProxy", import(".NetProxy"))

var_0_0.DORM_UPDATEED = "DormProxy updated"
var_0_0.LEVEL_UP = "DormProxy level up"
var_0_0.FURNITURE_ADDED = "DormProxy FURNITURE ADDED"
var_0_0.FURNITURE_UPDATED = "DormProxy FURNITURE UPDATED"
var_0_0.SHIP_ADDED = "DormProxy ship added"
var_0_0.SHIP_EXIT = "DormProxy ship exit"
var_0_0.INIMACY_AND_MONEY_ADD = "DormProxy inimacy and money added"
var_0_0.SHIPS_EXP_ADDED = "DormProxy SHIPS_EXP_ADDED"
var_0_0.THEME_ADDED = "DormProxy THEME_ADDED"
var_0_0.THEME_DELETED = "DormProxy THEME_DELETED"
var_0_0.THEME_TEMPLATE_UPDATED = "DormProxy THEME_TEMPLATE_UPDATED"
var_0_0.THEME_TEMPLATE_DELTETED = "DormProxy THEME_TEMPLATE_DELTETED"
var_0_0.COLLECTION_THEME_TEMPLATE_ADDED = "DormProxy COLLECTION_THEME_TEMPLATE_ADDED"
var_0_0.COLLECTION_THEME_TEMPLATE_DELETED = "DormProxy COLLECTION_THEME_TEMPLATE_DELETED"
var_0_0.THEME_TEMPLATE_ADDED = "DormProxy THEME_TEMPLATE_ADDED"
var_0_0.SHOP_THEME_TEMPLATE_DELETED = "DormProxy SHOP_THEME_TEMPLATE_DELETED"

function var_0_0.register(arg_1_0)
	arg_1_0.TYPE = 2
	arg_1_0.PAGE = 1
	arg_1_0.MAX_PAGE = 10
	arg_1_0.lastPages = {
		[2] = math.huge,
		[3] = math.huge,
		[5] = math.huge
	}
	arg_1_0.friendData = nil
	arg_1_0.systemThemes = {}

	arg_1_0:on(19001, function(arg_2_0)
		arg_1_0:sendNotification(GAME.GET_BACKYARD_DATA, {
			isMine = true,
			data = arg_2_0
		})

		return
	end)
	arg_1_0:RequestPopEvent()

	return
end

function var_0_0.OnEnterBackyard(arg_3_0)
	arg_3_0:SettlementShipExp()

	return
end

function var_0_0.OnExitBackyard(arg_4_0)
	arg_4_0:ClearRequestShipExp()

	return
end

function var_0_0.SettlementShipExp(arg_5_0)
	arg_5_0:ClearRequestShipExp()

	if arg_5_0.data:ShouldRequestShipExp() then
		arg_5_0:sendNotification(GAME.BACKYARD_REQUEST_SHIP_EXP)
	else
		arg_5_0:RequestShipExp()
	end

	return
end

function var_0_0.RequestShipExp(arg_6_0)
	arg_6_0.requestShipExpTimer = Timer.New(function()
		arg_6_0:ClearRequestShipExp()
		arg_6_0:sendNotification(GAME.BACKYARD_REQUEST_SHIP_EXP)

		return
	end, arg_6_0.data:GetNextSettlementShipExpTime() - pg.TimeMgr.GetInstance():GetServerTime(), 1)

	arg_6_0.requestShipExpTimer:Start()

	return
end

function var_0_0.ClearRequestShipExp(arg_8_0)
	if arg_8_0.requestShipExpTimer then
		arg_8_0.requestShipExpTimer:Stop()

		arg_8_0.requestShipExpTimer = nil
	end

	return
end

function var_0_0.RequestPopEvent(arg_9_0)
	arg_9_0:ClearRequestPopEvent()

	arg_9_0.requestEventTimer = Timer.New(function()
		arg_9_0:sendNotification(GAME.BACKYARD_REQUEST_POP_EVENT)

		return
	end, pg.gameset.dorm_pop_time.key_value, -1)

	arg_9_0.requestEventTimer:Start()

	return
end

function var_0_0.ClearRequestPopEvent(arg_11_0)
	if arg_11_0.requestEventTimer then
		arg_11_0.requestEventTimer:Stop()

		arg_11_0.requestEventTimer = nil
	end

	return
end

function var_0_0.GetVisitorShip(arg_12_0)
	return arg_12_0.visitorShip
end

function var_0_0.SetVisitorShip(arg_13_0, arg_13_1)
	arg_13_0.visitorShip = arg_13_1

	return
end

function var_0_0.addDorm(arg_14_0, arg_14_1)
	assert(isa(arg_14_1, Dorm), "dorm should instance of Dorm")

	arg_14_0.data = arg_14_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inBackyard")

	return
end

function var_0_0.updateDrom(arg_15_0, arg_15_1, arg_15_2)
	assert(isa(arg_15_1, Dorm), "dorm should instance of Dorm")
	assert(arg_15_1, "drom should exist")

	arg_15_0.data = arg_15_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inBackyard")
	arg_15_0.facade:sendNotification(var_0_0.DORM_UPDATEED, {}, arg_15_2)

	return
end

function var_0_0.getData(arg_16_0)
	if not arg_16_0.data then
		-- block empty
	end

	return Dorm.New({
		id = 1
	}):clone()
end

function var_0_0.GetCustomThemeTemplates(arg_17_0)
	return arg_17_0.customThemeTemplates
end

function var_0_0.SetCustomThemeTemplates(arg_18_0, arg_18_1)
	arg_18_0.customThemeTemplates = arg_18_1

	return
end

function var_0_0.GetCustomThemeTemplateById(arg_19_0, arg_19_1)
	return arg_19_0.customThemeTemplates[arg_19_1]
end

function var_0_0.UpdateCustomThemeTemplate(arg_20_0, arg_20_1)
	arg_20_0.customThemeTemplates[arg_20_1.id] = arg_20_1

	arg_20_0:sendNotification(var_0_0.THEME_TEMPLATE_UPDATED, {
		type = BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM,
		template = arg_20_1
	})

	return
end

function var_0_0.DeleteCustomThemeTemplate(arg_21_0, arg_21_1)
	arg_21_0.customThemeTemplates[arg_21_1] = nil

	arg_21_0:sendNotification(var_0_0.THEME_TEMPLATE_DELTETED, {
		templateId = arg_21_1
	})

	return
end

function var_0_0.AddCustomThemeTemplate(arg_22_0, arg_22_1)
	arg_22_0.customThemeTemplates[arg_22_1.id] = arg_22_1

	arg_22_0:sendNotification(var_0_0.THEME_TEMPLATE_ADDED, {
		template = arg_22_1
	})

	return
end

function var_0_0.GetUploadThemeTemplateCnt(arg_23_0)
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(arg_23_0.customThemeTemplates) do
		if iter_23_1:IsPushed() then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0
end

function var_0_0.GetShopThemeTemplates(arg_24_0)
	return arg_24_0.shopThemeTemplates
end

function var_0_0.SetShopThemeTemplates(arg_25_0, arg_25_1)
	arg_25_0.shopThemeTemplates = arg_25_1

	return
end

function var_0_0.GetShopThemeTemplateById(arg_26_0, arg_26_1)
	return arg_26_0.shopThemeTemplates[arg_26_1]
end

function var_0_0.IsInitShopThemeTemplates(arg_27_0)
	return arg_27_0.shopThemeTemplates ~= nil
end

function var_0_0.UpdateShopThemeTemplate(arg_28_0, arg_28_1)
	arg_28_0.shopThemeTemplates[arg_28_1.id] = arg_28_1

	arg_28_0:sendNotification(var_0_0.THEME_TEMPLATE_UPDATED, {
		type = BackYardConst.THEME_TEMPLATE_TYPE_SHOP,
		template = arg_28_1
	})

	return
end

function var_0_0.DeleteShopThemeTemplate(arg_29_0, arg_29_1)
	arg_29_0.shopThemeTemplates[arg_29_1] = nil

	arg_29_0:sendNotification(var_0_0.SHOP_THEME_TEMPLATE_DELETED, {
		id = arg_29_1
	})

	return
end

function var_0_0.GetCollectionThemeTemplates(arg_30_0)
	return arg_30_0.collectionThemeTemplates
end

function var_0_0.SetCollectionThemeTemplates(arg_31_0, arg_31_1)
	arg_31_0.collectionThemeTemplates = arg_31_1

	return
end

function var_0_0.GetCollectionThemeTemplateById(arg_32_0, arg_32_1)
	return arg_32_0.collectionThemeTemplates[arg_32_1]
end

function var_0_0.AddCollectionThemeTemplate(arg_33_0, arg_33_1)
	arg_33_0.collectionThemeTemplates[arg_33_1.id] = arg_33_1

	arg_33_0:sendNotification(var_0_0.COLLECTION_THEME_TEMPLATE_ADDED, {
		template = arg_33_1
	})

	return
end

function var_0_0.DeleteCollectionThemeTemplate(arg_34_0, arg_34_1)
	arg_34_0.collectionThemeTemplates[arg_34_1] = nil

	arg_34_0:sendNotification(var_0_0.COLLECTION_THEME_TEMPLATE_DELETED, {
		id = arg_34_1
	})

	return
end

function var_0_0.GetThemeTemplateCollectionCnt(arg_35_0)
	local var_35_0 = arg_35_0.collectionThemeTemplates or {}

	return table.getCount(var_35_0)
end

function var_0_0.UpdateCollectionThemeTemplate(arg_36_0, arg_36_1)
	arg_36_0.collectionThemeTemplates[arg_36_1.id] = arg_36_1

	arg_36_0:sendNotification(var_0_0.THEME_TEMPLATE_UPDATED, {
		type = BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION,
		template = arg_36_1
	})

	return
end

function var_0_0.GetTemplateNewID(arg_37_0)
	local var_37_0 = arg_37_0.customThemeTemplates or {}
	local var_37_1 = _.map(_.values(var_37_0), function(arg_38_0)
		return arg_38_0:GetPos()
	end)

	for iter_37_0 = 1, 10 do
		if not table.contains(var_37_1, iter_37_0) then
			return iter_37_0
		end
	end

	return
end

function var_0_0.GetSystemThemes(arg_39_0)
	if not arg_39_0.systemThemes or #arg_39_0.systemThemes == 0 then
		local var_39_0 = pg.backyard_theme_template

		for iter_39_0, iter_39_1 in ipairs(pg.backyard_theme_template.all) do
			if var_39_0[iter_39_1].is_view == 1 then
				table.insert(arg_39_0.systemThemes, (BackYardSystemTheme.New({
					id = iter_39_1
				})))
			end
		end
	end

	return arg_39_0.systemThemes
end

function var_0_0.ResetSystemTheme(arg_40_0, arg_40_1)
	if not arg_40_0.systemThemes or #arg_40_0.systemThemes == 0 then
		return
	end

	for iter_40_0, iter_40_1 in ipairs(arg_40_0.systemThemes) do
		if iter_40_1.id == arg_40_1 then
			arg_40_0.systemThemes[iter_40_0] = BackYardSystemTheme.New({
				id = arg_40_1
			})

			break
		end
	end

	return
end

function var_0_0.NeedRefreshThemeTemplateShop(arg_41_0)
	arg_41_0.refreshThemeTemplateShopTime = arg_41_0.refreshThemeTemplateShopTime or 0

	local var_41_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_41_0 > arg_41_0.refreshThemeTemplateShopTime then
		arg_41_0.refreshThemeTemplateShopTime = var_41_0 + BackYardConst.AUTO_REFRESH_THEME_TEMPLATE_TIME

		return true
	end

	return false
end

function var_0_0.NeedCollectionTip(arg_42_0)
	local var_42_9000
	local var_42_0 = getProxy(PlayerProxy)
	local var_42_1 = var_42_0.getRawData(var_42_9000).id
	local var_42_2 = PlayerPrefs.GetInt("backyard_template" .. var_42_1, 0)
	local var_42_3 = arg_42_0:GetThemeTemplateCollectionCnt()

	if var_42_0 ~= var_42_2 then
		PlayerPrefs.SetInt("backyard_template" .. var_42_1, var_42_3)
		PlayerPrefs.Save()
	end

	if var_42_3 < var_42_2 then
		return true
	end

	return false
end

function var_0_0.NeedShopShowHelp(arg_43_0)
	local var_43_0 = getProxy(PlayerProxy):getRawData().id

	if PlayerPrefs.GetInt("backyard_template_help" .. var_43_0, 0) <= 0 then
		PlayerPrefs.SetInt("backyard_template_help" .. var_43_0, 1)
		PlayerPrefs.Save()

		return true
	end

	return false
end

function var_0_0.GetTag7Furnitures(arg_44_0)
	for iter_44_0, iter_44_1 in ipairs(pg.furniture_data_template.get_id_list_by_tag[7]) do
		if pg.furniture_shop_template[iter_44_1] and pg.furniture_shop_template[iter_44_1].not_for_sale == 0 then
			local var_44_0 = pg.TimeMgr.GetInstance()

			if var_44_0:inTime(pg.furniture_shop_template[iter_44_1].time) then
				table.insert({}, iter_44_1)
			end
		end
	end

	return {}
end

function var_0_0.IsShowRedDot(arg_45_0)
	local var_45_9001
	local var_45_9000
	local var_45_0 = getProxy(PlayerProxy)
	local var_45_1 = pg.SystemOpenMgr.GetInstance()
	local var_45_2 = getProxy(DormProxy).getRawData(var_45_0)
	local var_45_3

	if var_45_1.isOpenSystem(var_45_9001, var_45_0.getRawData(var_45_9000).level, "CourtYardMediator") and not var_45_2.IsLackOfFood(var_45_1) and not var_45_2:AnyShipExistIntimacyOrMoney() then
		::label_45_2::

		var_45_3 = getProxy(SettingsProxy):IsTipNewTheme()
		var_45_3 = var_45_3 or getProxy(SettingsProxy):IsTipNewGemFurniture()
	end

	return var_45_3
end

function var_0_0.remove(arg_46_0)
	arg_46_0:ClearRequestPopEvent()
	arg_46_0:ClearRequestShipExp()

	return
end

return var_0_0
