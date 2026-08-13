class = var_0_10000

local var_0_0 = "CourtYardBottomPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "main/bottomPanel"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.granaryBtn = var_1.Find(var_2_0, "bottomleft/feed_btn")

	local var_2_1 = arg_2_0.granaryBtn
	local var_2_2 = var_1.Find(var_2_1, "progress")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Slider = var_1_10006
	arg_2_0.stockBar = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0.granaryBtn
	local var_2_5 = var_1.Find(var_2_4, "time")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.stockTimeTxt = var_2_6(var_2_5, var_4(var_1_10006))

	local var_2_7 = arg_2_0.granaryBtn
	local var_2_8 = var_1.Find(var_2_7, "Text")
	local var_2_9 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.stockTxt = var_2_9(var_2_8, var_4(var_1_10006))

	local var_2_10 = arg_2_0._tf

	arg_2_0.stampBtn = var_1.Find(var_2_10, "stamp")

	local var_2_11 = arg_2_0._tf

	arg_2_0.shopBtn = var_1.Find(var_2_11, "bottomright/shop_btn")

	local var_2_12 = arg_2_0._tf

	arg_2_0.decorateBtn = var_1.Find(var_2_12, "bottomright/decorate_btn")

	local var_2_13 = arg_2_0._tf

	arg_2_0.templateBtn = var_1.Find(var_2_13, "bottomright/theme_template_btn")

	local var_2_14 = arg_2_0._tf

	arg_2_0.shareBtn = var_1.Find(var_2_14, "bottomright/share_btn")

	local var_2_15 = arg_2_0.shopBtn

	arg_2_0.shopTip = var_1.Find(var_2_15, "tip")

	local var_2_16 = arg_2_0._tf

	arg_2_0.trainBtn = var_1.Find(var_2_16, "bottomleft/train_btn")

	local var_2_17 = arg_2_0.trainBtn
	local var_2_18 = var_1.Find(var_2_17, "Text")
	local var_2_19 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.trainBtnTxt = var_2_19(var_2_18, var_4(var_1_10006))

	local var_2_20 = arg_2_0.trainBtn
	local var_2_21 = var_1.Find(var_2_20, "label")
	local var_2_22 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.trainBtnLabel = var_2_22(var_2_21, var_4(var_1_10006))

	local var_2_23 = arg_2_0._tf

	arg_2_0.icon1 = var_1.Find(var_2_23, "bottomleft/train_btn/icon")

	local var_2_24 = arg_2_0._tf

	arg_2_0.icon2 = var_1.Find(var_2_24, "bottomleft/train_btn/icon_1")
	setText = var_1

	local var_2_25 = arg_2_0.granaryBtn
	local var_2_26 = var_3.Find(var_2_25, "label")

	i18n = var_4

	var_1(var_2_26, var_4("courtyard_label_capacity"))

	setText = var_1

	local var_2_27 = arg_2_0.shareBtn
	local var_2_28 = var_3.Find(var_2_27, "Text")

	i18n = var_4

	var_1(var_2_28, var_4("courtyard_label_share"))

	setText = var_1

	local var_2_29 = arg_2_0.shopBtn
	local var_2_30 = var_3.Find(var_2_29, "Text")

	i18n = var_4

	var_1(var_2_30, var_4("courtyard_label_shop"))

	setText = var_1

	local var_2_31 = arg_2_0.decorateBtn
	local var_2_32 = var_3.Find(var_2_31, "Text")

	i18n = var_4

	var_1(var_2_32, var_4("courtyard_label_decoration"))

	setText = var_1

	local var_2_33 = arg_2_0.templateBtn
	local var_2_34 = var_3.Find(var_2_33, "Text")

	i18n = var_4

	var_1(var_2_34, var_4("courtyard_label_template"))

	return
end

function var_0_1.OnRegister(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.stampBtn

	local function var_3_2()
		getProxy = var_2_10000
		TaskProxy = var_2_10002

		local var_4_0 = var_2_10000(var_2_10002)

		var_0.dealMingshiTouchFlag(var_4_0, 7)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.shareBtn

	local function var_3_5()
		pg = var_2_10000

		local var_5_0 = var_2_10000.ShareMgr.GetInstance()
		local var_5_1 = var_0.Share

		pg = var_2_10003

		local var_5_2 = var_2_10003.ShareMgr.TypeBackyard

		pg = var_2_10004

		var_5_1(var_5_0, var_5_2, var_2_10004.ShareMgr.PANEL_TYPE_PINK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.granaryBtn

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		CourtYardMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.GO_GRANARY)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.shopBtn

	local function var_3_11()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		CourtYardMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.GO_SHOP)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.decorateBtn

	local function var_3_14()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		CourtYardMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.OPEN_DECORATION)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10006)

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.templateBtn

	local function var_3_17()
		LOCK_BACKYARD_TEMPLATE = var_2_10000

		if var_2_10000 then
			return
		end

		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		CourtYardMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.GO_THEME_TEMPLATE)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_15, var_3_16, var_3_17, var_1_10006)

	onButton = var_1_10001

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.trainBtn

	local function var_3_20()
		if arg_3_0.contextData.floor == 1 then
			local var_10_0 = arg_3_0
			local var_10_1 = var_0.emit

			CourtYardMediator = var_2_10003

			var_10_1(var_10_0, var_2_10003.SEL_TRAIN_SHIP)
		elseif arg_3_0.contextData.floor == 2 then
			local var_10_2 = arg_3_0
			local var_10_3 = var_0.emit

			CourtYardMediator = var_2_10003

			var_10_3(var_10_2, var_2_10003.SEL_REST_SHIP)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_18, var_3_19, var_3_20, var_1_10006)

	local var_3_21 = arg_3_0
	local var_3_22 = arg_3_0.SetActive
	local var_3_23 = arg_3_0.stampBtn

	LOCK_CLICK_MINGSHI = var_3_20

	local var_3_25

	if not var_3_20 then
		getProxy = var_3_20
		TaskProxy = var_1_10007

		local var_3_24 = var_3_20(var_1_10007)

		var_3_25 = var_5.mingshiTouchFlagEnabled(var_3_24)
	else
		var_3_25 = false
	end

	if false then
		var_3_25 = true
	end

	var_3_22(var_3_21, var_3_23, var_3_25)
	arg_3_0:UpdateShopTip()

	return
end

function var_0_1.OnVisitRegister(arg_11_0)
	setActive = var_1_10001

	var_1_10001(arg_11_0._tf, false)

	return
end

function var_0_1.OnFlush(arg_12_0, arg_12_1)
	if not arg_12_1 then
		bit = var_1_10002

		local var_12_0 = var_1_10002.bor

		BackYardConst = var_1_10004

		local var_12_1 = var_1_10004.DORM_UPDATE_TYPE_UPDATEFOOD

		BackYardConst = var_1_10005

		local var_12_2 = var_1_10005.DORM_UPDATE_TYPE_LEVEL

		BackYardConst = var_1_10006
		var_1_10006 = var_1_10006.DORM_UPDATE_TYPE_SHIP
		BackYardConst = var_1_10007

		local var_12_3 = var_1_10007.DORM_UPDATE_TYPE_USEFOOD

		BackYardConst = var_1_10008
		arg_12_1 = var_12_0(var_12_1, var_12_2, var_1_10006, var_12_3, var_1_10008.DORM_UPDATE_TYPE_EXTENDFOOD)
	end

	local var_12_4 = arg_12_0.dorm

	bit = var_1_10003

	local var_12_5 = var_1_10003.band
	local var_12_6 = arg_12_1

	BackYardConst = var_1_10006

	if not (var_12_5(var_12_6, var_1_10006.DORM_UPDATE_TYPE_UPDATEFOOD) > 0) then
		bit = var_12_7

		local var_12_7 = var_12_7.band
		local var_12_8 = arg_12_1

		BackYardConst = var_6

		if not (var_12_7(var_12_8, var_6.DORM_UPDATE_TYPE_USEFOOD) > 0) then
			bit = var_12_7
			var_12_7 = var_12_7.band

			local var_12_9 = arg_12_1

			BackYardConst = var_6

			if var_12_7(var_12_9, var_6.DORM_UPDATE_TYPE_EXTENDFOOD) > 0 then
				arg_12_0:CalcStockLeftTime()
			end

			bit = var_12_7

			local var_12_10 = var_12_7.band
			local var_12_11 = arg_12_1

			BackYardConst = var_6

			if var_12_10(var_12_11, var_6.DORM_UPDATE_TYPE_SHIP) > 0 then
				arg_12_0:CalcStockLeftTime()
				arg_12_0:UpdateTrainBtn()
			end

			bit = var_3

			local var_12_12 = var_3.band
			local var_12_13 = arg_12_1

			BackYardConst = var_6

			local var_12_16

			if var_12_12(var_12_13, var_6.DORM_UPDATE_TYPE_LEVEL) > 0 then
				SetActive = var_3

				local var_12_14 = arg_12_0.templateBtn

				LOCK_BACKYARD_TEMPLATE = var_12_16

				var_3(var_12_14, not var_12_16)

				LOCK_BACKYARD_TEMPLATE = var_3

				if not var_3 then
					arg_12_0:PlayBackYardThemeTemplate()

					SetActive = var_3

					local var_12_15 = arg_12_0.templateBtn

					if var_12_4:IsMaxLevel() then
						var_12_16 = arg_12_0:IsInner()
					end

					var_3(var_12_15, var_12_16)
				end
			end

			bit = var_3

			local var_12_17 = var_3.band
			local var_12_18 = arg_12_1

			BackYardConst = var_12_16

			if not (var_12_17(var_12_18, var_12_16.DORM_UPDATE_TYPE_UPDATEFOOD) > 0) then
				bit = var_12_19

				local var_12_19 = var_12_19.band
				local var_12_20 = arg_12_1

				BackYardConst = var_6

				if not (var_12_19(var_12_20, var_6.DORM_UPDATE_TYPE_LEVEL) > 0) then
					bit = var_12_19
					var_12_19 = var_12_19.band

					local var_12_21 = arg_12_1

					BackYardConst = var_6

					if not (var_12_19(var_12_21, var_6.DORM_UPDATE_TYPE_USEFOOD) > 0) then
						bit = var_12_19
						var_12_19 = var_12_19.band

						local var_12_22 = arg_12_1

						BackYardConst = var_6

						if var_12_19(var_12_22, var_6.DORM_UPDATE_TYPE_EXTENDFOOD) > 0 then
							pg = var_12_19

							local var_12_23 = var_12_19.dorm_data_template[var_12_4.id].capacity

							arg_12_0.stockBar.value = var_12_4.food / (var_12_23 + var_12_4:GetFoodMax())

							local var_12_24 = arg_12_0.stockTxt

							math = var_5
							var_12_24.text = var_5.ceil(var_12_4.food) .. "/" .. var_12_23 + var_12_4:GetFoodMax()
						end

						arg_12_0:UpdateFloor()

						return
					end
				end
			end
		end
	end
end

function var_0_1.PlayBackYardThemeTemplate(arg_13_0)
	getProxy = var_1_10001
	DormProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)
	local var_13_1 = var_1.getRawData(var_13_0)

	if var_1.IsMaxLevel(var_13_1) then
		pg = var_1

		local var_13_2 = var_1.NewStoryMgr.GetInstance()

		if not var_1.GetPlayedFlag(var_13_2, 90021) then
			_BackyardMsgBoxMgr = var_1

			local var_13_3 = var_1
			local var_13_4 = var_1.Show
			local var_13_5 = {
				modal = true,
				hideNo = true,
				hideClose = true
			}

			i18n = var_1_10005
			var_13_5.content = var_1_10005("open_backyard_theme_template_tip")

			var_13_4(var_13_3, var_13_5)

			pg = var_13_4

			local var_13_6 = var_13_4.m02
			local var_13_7 = var_1.sendNotification

			GAME = var_13_5

			var_13_7(var_13_6, var_13_5.STORY_UPDATE, {
				storyId = "NG0020"
			})
		end
	end

	return
end

function var_0_1.UpdateTrainBtn(arg_14_0)
	if arg_14_0.contextData.floor == 1 then
		local var_14_0 = arg_14_0.trainBtnLabel

		i18n = var_1_10002
		var_14_0.text = var_1_10002("courtyard_label_train")

		local var_14_1 = arg_14_0.trainBtnTxt
		local var_14_2 = arg_14_0.dorm

		var_1_10002 = var_1_10002.GetFloorShipCnt
		DormShip = var_1_10005
		var_14_1.text = var_1_10002(var_14_2, var_1_10005.FLOOR_1) .. "/" .. arg_14_0.dorm.exp_pos
	elseif arg_14_0.contextData.floor == 2 then
		local var_14_3 = arg_14_0.trainBtnLabel

		i18n = var_1_10002
		var_14_3.text = var_1_10002("courtyard_label_rest")

		local var_14_4 = arg_14_0.trainBtnTxt
		local var_14_5 = arg_14_0.dorm
		local var_14_6 = var_2.GetFloorShipCnt

		DormShip = var_1_10005
		var_14_4.text = var_14_6(var_14_5, var_1_10005.FLOOR_2) .. "/" .. arg_14_0.dorm.rest_pos
	end

	return
end

function var_0_1.UpdateShopTip(arg_15_0)
	setActive = var_1_10001

	local var_15_0 = arg_15_0.shopTip

	getProxy = var_1_10004
	SettingsProxy = var_1_10006

	local var_15_1 = var_1_10004(var_1_10006)
	local var_15_3

	if not var_4.IsTipNewTheme(var_15_1) then
		getProxy = var_15_3
		SettingsProxy = var_15_1

		local var_15_2 = var_15_3(var_15_1)

		var_15_3 = var_15_3.IsTipNewGemFurniture(var_15_2)
	end

	var_1_10001(var_15_0, var_15_3)

	return
end

function var_0_1.OnRemoveLayer(arg_16_0, arg_16_1)
	NewBackYardShopMediator = var_1_10002

	if arg_16_1 == var_1_10002 then
		arg_16_0:UpdateShopTip()
	end

	return
end

function var_0_1.CalcStockLeftTime(arg_17_0)
	local var_17_0 = arg_17_0.dorm

	arg_17_0:RemoveTimer()

	arg_17_0.stockTimeTxt.text = ""

	local var_17_1 = var_17_0
	local var_17_2 = var_17_0.GetFloorShipCnt

	DormShip = var_1_10005

	if var_17_2(var_17_1, var_1_10005.FLOOR_1) <= 0 or var_17_0.food <= 0 then
		return
	end

	local var_17_3 = var_17_0:getFoodLeftTime()

	Timer = var_3
	arg_17_0.timer = var_3.New(function()
		math = var_2_10000

		local var_18_0 = var_2_10000.floor(var_17_3)

		pg = var_2_10001

		local var_18_1 = var_2_10001.TimeMgr.GetInstance()
		local var_18_2 = var_18_0 - var_1.GetServerTime(var_18_1)
		local var_18_3 = arg_17_0.stockTimeTxt

		pg = var_2

		local var_18_4 = var_2.TimeMgr.GetInstance()

		var_18_3.text = var_2.DescCDTime(var_18_4, var_18_2)

		if var_18_2 <= 0 then
			local var_18_5 = arg_17_0

			var_1.RemoveTimer(var_18_5)
		end

		return
	end, 1, -1)

	local var_17_4 = arg_17_0.timer

	var_3.Start(var_17_4)
	arg_17_0.timer.func()

	return
end

function var_0_1.RemoveTimer(arg_19_0)
	arg_19_0.stockTimeTxt.text = ""

	if arg_19_0.timer then
		local var_19_0 = arg_19_0.timer

		var_1.Stop(var_19_0)

		arg_19_0.timer = nil
	end

	return
end

function var_0_1.GetMoveY(arg_20_0)
	return {
		{
			arg_20_0._tf,
			-1
		}
	}
end

function var_0_1.UpdateFloor(arg_21_0, arg_21_1)
	SetActive = var_1_10002

	local var_21_0 = arg_21_0.granaryBtn
	local var_21_1 = arg_21_0
	local var_21_2

	if arg_21_0.IsInner(var_21_1) then
		getProxy = var_21_2
		DormProxy = var_21_1
		var_21_2 = var_21_2(var_21_1).floor == 1
	end

	var_1_10002(var_21_0, var_21_2)
	arg_21_0:UpdateTrainBtn()

	setActive = var_2

	local var_21_3 = arg_21_0.icon1

	getProxy = var_21_2
	DormProxy = var_21_1

	var_2(var_21_3, var_21_2(var_21_1).floor == 1)

	setActive = var_2

	local var_21_4 = arg_21_0.icon2

	getProxy = var_5
	DormProxy = var_21_1

	var_2(var_21_4, var_5(var_21_1).floor == 2)

	return
end

function var_0_1.OnDispose(arg_22_0)
	arg_22_0:RemoveTimer()

	return
end

return var_0_1
