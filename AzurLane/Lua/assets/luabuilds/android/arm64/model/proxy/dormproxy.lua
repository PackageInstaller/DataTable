class = var_0_10000

local var_0_0 = "DormProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.DORM_UPDATEED = "DormProxy updated"
var_0_1.LEVEL_UP = "DormProxy level up"
var_0_1.FURNITURE_ADDED = "DormProxy FURNITURE ADDED"
var_0_1.FURNITURE_UPDATED = "DormProxy FURNITURE UPDATED"
var_0_1.SHIP_ADDED = "DormProxy ship added"
var_0_1.SHIP_EXIT = "DormProxy ship exit"
var_0_1.INIMACY_AND_MONEY_ADD = "DormProxy inimacy and money added"
var_0_1.SHIPS_EXP_ADDED = "DormProxy SHIPS_EXP_ADDED"
var_0_1.THEME_ADDED = "DormProxy THEME_ADDED"
var_0_1.THEME_DELETED = "DormProxy THEME_DELETED"
var_0_1.THEME_TEMPLATE_UPDATED = "DormProxy THEME_TEMPLATE_UPDATED"
var_0_1.THEME_TEMPLATE_DELTETED = "DormProxy THEME_TEMPLATE_DELTETED"
var_0_1.COLLECTION_THEME_TEMPLATE_ADDED = "DormProxy COLLECTION_THEME_TEMPLATE_ADDED"
var_0_1.COLLECTION_THEME_TEMPLATE_DELETED = "DormProxy COLLECTION_THEME_TEMPLATE_DELETED"
var_0_1.THEME_TEMPLATE_ADDED = "DormProxy THEME_TEMPLATE_ADDED"
var_0_1.SHOP_THEME_TEMPLATE_DELETED = "DormProxy SHOP_THEME_TEMPLATE_DELETED"

function var_0_1.register(arg_1_0)
	arg_1_0.TYPE = 2
	arg_1_0.PAGE = 1
	arg_1_0.MAX_PAGE = 10

	local var_1_0 = {}

	math = var_1_10002
	var_1_0[2] = var_1_10002.huge
	math = var_2
	var_1_0[3] = var_2.huge
	math = var_2
	var_1_0[5] = var_2.huge
	arg_1_0.lastPages = var_1_0
	arg_1_0.friendData = nil
	arg_1_0.systemThemes = {}

	arg_1_0:on(19001, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.GET_BACKYARD_DATA, {
			isMine = true,
			data = arg_2_0
		})

		return
	end)
	arg_1_0:RequestPopEvent()

	return
end

function var_0_1.OnEnterBackyard(arg_3_0)
	arg_3_0:SettlementShipExp()

	return
end

function var_0_1.OnExitBackyard(arg_4_0)
	arg_4_0:ClearRequestShipExp()

	return
end

function var_0_1.SettlementShipExp(arg_5_0)
	arg_5_0:ClearRequestShipExp()

	local var_5_0 = arg_5_0.data

	if var_1.ShouldRequestShipExp(var_5_0) then
		local var_5_1 = arg_5_0
		local var_5_2 = arg_5_0.sendNotification

		GAME = var_1_10006

		var_5_2(var_5_1, var_1_10006.BACKYARD_REQUEST_SHIP_EXP)
	else
		arg_5_0:RequestShipExp()
	end

	return
end

function var_0_1.RequestShipExp(arg_6_0)
	local var_6_0 = arg_6_0.data
	local var_6_1 = var_1.GetNextSettlementShipExpTime(var_6_0)

	pg = var_1_10003

	local var_6_2 = var_1_10003.TimeMgr.GetInstance()
	local var_6_3 = var_6_1 - var_3.GetServerTime(var_6_2)

	Timer = var_6_2
	arg_6_0.requestShipExpTimer = var_6_2.New(function()
		local var_7_0 = arg_6_0

		var_0.ClearRequestShipExp(var_7_0)

		local var_7_1 = arg_6_0
		local var_7_2 = var_0.sendNotification

		GAME = var_2_10003

		var_7_2(var_7_1, var_2_10003.BACKYARD_REQUEST_SHIP_EXP)

		return
	end, var_6_3, 1)

	local var_6_4 = arg_6_0.requestShipExpTimer

	var_5.Start(var_6_4)

	return
end

function var_0_1.ClearRequestShipExp(arg_8_0)
	if arg_8_0.requestShipExpTimer then
		local var_8_0 = arg_8_0.requestShipExpTimer

		var_1.Stop(var_8_0)

		arg_8_0.requestShipExpTimer = nil
	end

	return
end

function var_0_1.RequestPopEvent(arg_9_0)
	arg_9_0:ClearRequestPopEvent()

	pg = var_1

	local var_9_0 = var_1.gameset.dorm_pop_time.key_value

	Timer = var_1_10002
	arg_9_0.requestEventTimer = var_1_10002.New(function()
		local var_10_0 = arg_9_0
		local var_10_1 = var_0.sendNotification

		GAME = var_2_10003

		var_10_1(var_10_0, var_2_10003.BACKYARD_REQUEST_POP_EVENT)

		return
	end, var_9_0, -1)

	local var_9_1 = arg_9_0.requestEventTimer

	var_2.Start(var_9_1)

	return
end

function var_0_1.ClearRequestPopEvent(arg_11_0)
	if arg_11_0.requestEventTimer then
		local var_11_0 = arg_11_0.requestEventTimer

		var_1.Stop(var_11_0)

		arg_11_0.requestEventTimer = nil
	end

	return
end

function var_0_1.GetVisitorShip(arg_12_0)
	return arg_12_0.visitorShip
end

function var_0_1.SetVisitorShip(arg_13_0, arg_13_1)
	arg_13_0.visitorShip = arg_13_1

	return
end

function var_0_1.addDorm(arg_14_0, arg_14_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_14_0 = arg_14_1

	Dorm = var_1_10007

	var_1_10002(var_1_10004(var_14_0, var_1_10007), "dorm should instance of Dorm")

	arg_14_0.data = arg_14_1
	pg = var_1_10002

	local var_14_1 = var_1_10002.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_14_1, "inBackyard")

	return
end

function var_0_1.updateDrom(arg_15_0, arg_15_1, arg_15_2)
	assert = var_1_10003
	isa = var_1_10005

	local var_15_0 = arg_15_1

	Dorm = var_1_10008

	var_1_10003(var_1_10005(var_15_0, var_1_10008), "dorm should instance of Dorm")

	assert = var_1_10003

	var_1_10003(arg_15_1, "drom should exist")

	arg_15_0.data = arg_15_1
	pg = var_1_10003

	local var_15_1 = var_1_10003.ShipFlagMgr.GetInstance()

	var_3.UpdateFlagShips(var_15_1, "inBackyard")

	local var_15_2 = arg_15_0.facade

	var_3.sendNotification(var_15_2, var_0_1.DORM_UPDATEED, {}, arg_15_2)

	return
end

function var_0_1.getData(arg_16_0)
	local var_16_0

	if not arg_16_0.data then
		Dorm = var_16_0
		var_16_0 = var_16_0.New({
			id = 1
		})
	end

	return var_16_0:clone()
end

function var_0_1.GetCustomThemeTemplates(arg_17_0)
	return arg_17_0.customThemeTemplates
end

function var_0_1.SetCustomThemeTemplates(arg_18_0, arg_18_1)
	arg_18_0.customThemeTemplates = arg_18_1

	return
end

function var_0_1.GetCustomThemeTemplateById(arg_19_0, arg_19_1)
	return arg_19_0.customThemeTemplates[arg_19_1]
end

function var_0_1.UpdateCustomThemeTemplate(arg_20_0, arg_20_1)
	arg_20_0.customThemeTemplates[arg_20_1.id] = arg_20_1

	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.sendNotification
	local var_20_2 = var_0_1.THEME_TEMPLATE_UPDATED
	local var_20_3 = {}

	BackYardConst = var_1_10007
	var_20_3.type = var_1_10007.THEME_TEMPLATE_TYPE_CUSTOM
	var_20_3.template = arg_20_1

	var_20_1(var_20_0, var_20_2, var_20_3)

	return
end

function var_0_1.DeleteCustomThemeTemplate(arg_21_0, arg_21_1)
	arg_21_0.customThemeTemplates[arg_21_1] = nil

	arg_21_0:sendNotification(var_0_1.THEME_TEMPLATE_DELTETED, {
		templateId = arg_21_1
	})

	return
end

function var_0_1.AddCustomThemeTemplate(arg_22_0, arg_22_1)
	arg_22_0.customThemeTemplates[arg_22_1.id] = arg_22_1

	arg_22_0:sendNotification(var_0_1.THEME_TEMPLATE_ADDED, {
		template = arg_22_1
	})

	return
end

function var_0_1.GetUploadThemeTemplateCnt(arg_23_0)
	local var_23_0 = 0

	pairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_0.customThemeTemplates) do
		if iter_23_1:IsPushed() then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0
end

function var_0_1.GetShopThemeTemplates(arg_24_0)
	return arg_24_0.shopThemeTemplates
end

function var_0_1.SetShopThemeTemplates(arg_25_0, arg_25_1)
	arg_25_0.shopThemeTemplates = arg_25_1

	return
end

function var_0_1.GetShopThemeTemplateById(arg_26_0, arg_26_1)
	return arg_26_0.shopThemeTemplates[arg_26_1]
end

function var_0_1.IsInitShopThemeTemplates(arg_27_0)
	return arg_27_0.shopThemeTemplates ~= nil
end

function var_0_1.UpdateShopThemeTemplate(arg_28_0, arg_28_1)
	arg_28_0.shopThemeTemplates[arg_28_1.id] = arg_28_1

	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_0.sendNotification
	local var_28_2 = var_0_1.THEME_TEMPLATE_UPDATED
	local var_28_3 = {}

	BackYardConst = var_1_10007
	var_28_3.type = var_1_10007.THEME_TEMPLATE_TYPE_SHOP
	var_28_3.template = arg_28_1

	var_28_1(var_28_0, var_28_2, var_28_3)

	return
end

function var_0_1.DeleteShopThemeTemplate(arg_29_0, arg_29_1)
	arg_29_0.shopThemeTemplates[arg_29_1] = nil

	arg_29_0:sendNotification(var_0_1.SHOP_THEME_TEMPLATE_DELETED, {
		id = arg_29_1
	})

	return
end

function var_0_1.GetCollectionThemeTemplates(arg_30_0)
	return arg_30_0.collectionThemeTemplates
end

function var_0_1.SetCollectionThemeTemplates(arg_31_0, arg_31_1)
	arg_31_0.collectionThemeTemplates = arg_31_1

	return
end

function var_0_1.GetCollectionThemeTemplateById(arg_32_0, arg_32_1)
	return arg_32_0.collectionThemeTemplates[arg_32_1]
end

function var_0_1.AddCollectionThemeTemplate(arg_33_0, arg_33_1)
	arg_33_0.collectionThemeTemplates[arg_33_1.id] = arg_33_1

	arg_33_0:sendNotification(var_0_1.COLLECTION_THEME_TEMPLATE_ADDED, {
		template = arg_33_1
	})

	return
end

function var_0_1.DeleteCollectionThemeTemplate(arg_34_0, arg_34_1)
	arg_34_0.collectionThemeTemplates[arg_34_1] = nil

	arg_34_0:sendNotification(var_0_1.COLLECTION_THEME_TEMPLATE_DELETED, {
		id = arg_34_1
	})

	return
end

function var_0_1.GetThemeTemplateCollectionCnt(arg_35_0)
	table = var_1_10001

	local var_35_0 = var_1_10001.getCount
	local var_35_1

	if not arg_35_0.collectionThemeTemplates then
		var_35_1 = {}
	end

	return var_35_0(var_35_1)
end

function var_0_1.UpdateCollectionThemeTemplate(arg_36_0, arg_36_1)
	arg_36_0.collectionThemeTemplates[arg_36_1.id] = arg_36_1

	local var_36_0 = arg_36_0
	local var_36_1 = arg_36_0.sendNotification
	local var_36_2 = var_0_1.THEME_TEMPLATE_UPDATED
	local var_36_3 = {}

	BackYardConst = var_1_10007
	var_36_3.type = var_1_10007.THEME_TEMPLATE_TYPE_COLLECTION
	var_36_3.template = arg_36_1

	var_36_1(var_36_0, var_36_2, var_36_3)

	return
end

function var_0_1.GetTemplateNewID(arg_37_0)
	_ = var_1_10001

	local var_37_0 = var_1_10001.map

	_ = var_1_10003

	local var_37_1 = var_1_10003.values
	local var_37_2

	if not arg_37_0.customThemeTemplates then
		var_37_2 = {}
	end

	local var_37_3 = var_37_0(var_37_1(var_37_2), function(arg_38_0)
		return arg_38_0:GetPos()
	end)

	for iter_37_0 = 1, 10 do
		table = var_1_10006

		if not var_1_10006.contains(var_37_3, iter_37_0) then
			return iter_37_0
		end
	end

	return
end

function var_0_1.GetSystemThemes(arg_39_0)
	if not arg_39_0.systemThemes or #arg_39_0.systemThemes == 0 then
		pg = var_1

		local var_39_0 = var_1.backyard_theme_template

		ipairs = var_1_10002

		for iter_39_0, iter_39_1 in var_1_10002(var_39_0.all) do
			if var_39_0[iter_39_1].is_view == 1 then
				BackYardSystemTheme = var_7

				local var_39_1 = var_7.New({
					id = iter_39_1
				})

				table = var_1_10008

				var_1_10008.insert(arg_39_0.systemThemes, var_39_1)
			end
		end
	end

	return arg_39_0.systemThemes
end

function var_0_1.ResetSystemTheme(arg_40_0, arg_40_1)
	if not arg_40_0.systemThemes or #arg_40_0.systemThemes == 0 then
		return
	end

	ipairs = var_2

	for iter_40_0, iter_40_1 in var_2(arg_40_0.systemThemes) do
		if iter_40_1.id == arg_40_1 then
			local var_40_0 = arg_40_0.systemThemes

			BackYardSystemTheme = var_1_10008
			var_40_0[iter_40_0] = var_1_10008.New({
				id = arg_40_1
			})

			break
		end
	end

	return
end

function var_0_1.NeedRefreshThemeTemplateShop(arg_41_0)
	if not arg_41_0.refreshThemeTemplateShopTime then
		arg_41_0.refreshThemeTemplateShopTime = 0
	end

	pg = var_1

	local var_41_0 = var_1.TimeMgr.GetInstance()
	local var_41_1 = var_1.GetServerTime(var_41_0)

	if arg_41_0.refreshThemeTemplateShopTime < var_41_1 then
		BackYardConst = var_2
		arg_41_0.refreshThemeTemplateShopTime = var_41_1 + var_2.AUTO_REFRESH_THEME_TEMPLATE_TIME

		return true
	end

	return false
end

function var_0_1.NeedCollectionTip(arg_42_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_42_0 = var_1_10001(var_1_10003)
	local var_42_1 = var_1.getRawData(var_42_0).id

	PlayerPrefs = var_1_10002

	local var_42_2 = var_1_10002.GetInt("backyard_template" .. var_42_1, 0)

	if arg_42_0:GetThemeTemplateCollectionCnt() ~= var_42_2 then
		PlayerPrefs = var_4

		var_4.SetInt("backyard_template" .. var_42_1, var_3)

		PlayerPrefs = var_4

		var_4.Save()
	end

	if var_3 < var_42_2 then
		return true
	end

	return false
end

function var_0_1.NeedShopShowHelp(arg_43_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_43_0 = var_1_10001(var_1_10003)
	local var_43_1 = var_1.getRawData(var_43_0).id

	PlayerPrefs = var_1_10002

	local var_43_2 = var_1_10002.GetInt("backyard_template_help" .. var_43_1, 0)

	if not (0 < var_43_2) then
		PlayerPrefs = var_3

		var_3.SetInt("backyard_template_help" .. var_43_1, 1)

		PlayerPrefs = var_3

		var_3.Save()

		return true
	end

	return false
end

function var_0_1.GetTag7Furnitures(arg_44_0)
	local var_44_0 = {}

	pg = var_1_10002

	local var_44_1 = var_1_10002.furniture_data_template.get_id_list_by_tag[7]

	ipairs = var_1_10003

	for iter_44_0, iter_44_1 in var_1_10003(var_44_1) do
		pg = var_1_10008

		if var_1_10008.furniture_shop_template[iter_44_1] and var_1_10008.not_for_sale == 0 then
			pg = var_9

			local var_44_2 = var_9.TimeMgr.GetInstance()

			if var_9.inTime(var_44_2, var_1_10008.time) then
				table = var_9

				var_9.insert(var_44_0, iter_44_1)
			end
		end
	end

	return var_44_0
end

function var_0_1.IsShowRedDot(arg_45_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_45_0 = var_1_10001(var_1_10003)
	local var_45_1 = var_1.getRawData(var_45_0)

	pg = var_1_10002

	local var_45_2 = var_1_10002.SystemOpenMgr.GetInstance()
	local var_45_3 = var_2.isOpenSystem(var_45_2, var_45_1.level, "CourtYardMediator")

	getProxy = var_45_0
	DormProxy = var_5

	local var_45_4 = var_45_0(var_5)
	local var_45_5 = var_3.getRawData(var_45_4)
	local var_45_6 = var_4.IsLackOfFood(var_45_5)
	local var_45_7 = var_4:AnyShipExistIntimacyOrMoney()

	if var_45_3 and not var_45_6 and not var_45_7 then
		::label_45_2::

		getProxy = var_45_5
		SettingsProxy = var_1_10009

		local var_45_8 = var_45_5(var_1_10009)

		if not var_45_5.IsTipNewTheme(var_45_8) then
			getProxy = var_45_5
			SettingsProxy = var_45_8

			local var_45_9 = var_45_5(var_45_8)

			var_45_5 = var_45_5.IsTipNewGemFurniture(var_45_9)
		end
	end

	return var_45_5
end

function var_0_1.remove(arg_46_0)
	arg_46_0:ClearRequestPopEvent()
	arg_46_0:ClearRequestShipExp()

	return
end

return var_0_1
