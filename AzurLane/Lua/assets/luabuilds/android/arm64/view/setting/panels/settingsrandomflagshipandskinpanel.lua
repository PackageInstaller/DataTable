class = var_0_10000

local var_0_0 = "SettingsRandomFlagShipAndSkinPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

var_0_1.EVT_UPDTAE = "SettingsRandomFlagShipAndSkinPanel:EVT_UPDTAE"
var_0_1.SHIP_FREQUENTLYUSED = 1
var_0_1.SHIP_LOCKED = 2
var_0_1.COUSTOM = 3

function var_0_1.GetUIName(arg_1_0)
	return "RandomFlagShipAndSkin"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("random_ship_and_skin_title")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "                                                                                      / RANDOM RANGE"
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "title")
	local var_4_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_4_0.subTitleTxt = var_4_2(var_4_1, var_4(var_1_10006))

	local var_4_3 = {}
	local var_4_4 = var_0_1.SHIP_FREQUENTLYUSED
	local var_4_5 = arg_4_0._tf

	var_4_3[var_4_4] = var_3.Find(var_4_5, "1")

	local var_4_6 = var_0_1.SHIP_LOCKED
	local var_4_7 = arg_4_0._tf

	var_4_3[var_4_6] = var_3.Find(var_4_7, "2")

	local var_4_8 = var_0_1.COUSTOM
	local var_4_9 = arg_4_0._tf

	var_4_3[var_4_8] = var_3.Find(var_4_9, "3")
	arg_4_0.shipToggles = var_4_3

	local var_4_10 = {}
	local var_4_11 = var_0_1.SHIP_FREQUENTLYUSED

	i18n = var_3
	var_4_10[var_4_11] = var_3("random_ship_frequse_mode")

	local var_4_12 = var_0_1.SHIP_LOCKED

	i18n = var_3
	var_4_10[var_4_12] = var_3("random_ship_locked_mode")

	local var_4_13 = var_0_1.COUSTOM

	i18n = var_3
	var_4_10[var_4_13] = var_3("random_ship_custom_mode")
	arg_4_0.shipToggleTxts = var_4_10
	findTF = var_4_10
	arg_4_0.editBtn = var_4_10(arg_4_0._tf, "edit_btn")

	arg_4_0:UpdateSelected()
	arg_4_0:InitToggles()

	return
end

function var_0_1.InitToggles(arg_5_0)
	pairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.shipToggles) do
		onToggle = var_1_10006

		local var_5_0 = arg_5_0
		local var_5_1 = iter_5_1

		local function var_5_2(arg_6_0)
			if arg_6_0 then
				local var_6_0 = arg_5_0

				var_1.UpdateShipRandomMode(var_6_0, iter_5_0)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_5_0, var_5_1, var_5_2, var_1_10011)

		setText = var_1_10006

		var_1_10006(iter_5_1:Find("Text"), arg_5_0.shipToggleTxts[iter_5_0])
	end

	onButton = var_1

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.editBtn

	local function var_5_5()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_7_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_7_1(var_7_0, var_7_2, var_2_10004.RANDOM_DOCKYARD)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_3, var_5_4, var_5_5, var_1_10006)

	return
end

function var_0_1.UpdateShipRandomMode(arg_8_0, arg_8_1)
	if arg_8_1 == var_0_1.COUSTOM and not arg_8_0.refreshFlag then
		getProxy = var_2
		BayProxy = var_1_10004

		local var_8_0 = var_2(var_1_10004)

		if #var_2.getRandomFlagShipPhantomMarks(var_8_0) == 0 then
			pg = var_3
			var_1_10005 = var_3.TipsMgr.GetInstance()

			local var_8_1 = var_3.ShowTips

			i18n = var_1_10006

			var_8_1(var_1_10005, var_1_10006("random_ship_custom_mode_empty"))
		end
	end

	arg_8_0.refreshFlag = nil

	if arg_8_0.randomFlagShipMode ~= arg_8_1 then
		pg = var_2

		local var_8_2 = var_2.m02
		local var_8_3 = var_2.sendNotification

		GAME = var_1_10005

		var_8_3(var_8_2, var_1_10005.CHANGE_RANDOM_SHIP_MODE, {
			mode = arg_8_1
		})
	end

	return
end

function var_0_1.UpdateSelected(arg_9_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)
	local var_9_1 = var_1.getRawData(var_9_0)

	arg_9_0.randomFlagShipMode = var_1.GetRandomFlagShipMode(var_9_1)
	triggerToggle = var_1_10002

	var_1_10002(arg_9_0.shipToggles[var_1], true)

	return
end

function var_0_1.OnRandomFlagshipFlagUpdate(arg_10_0)
	arg_10_0.refreshFlag = true

	arg_10_0:UpdateSelected()

	return
end

return var_0_1
