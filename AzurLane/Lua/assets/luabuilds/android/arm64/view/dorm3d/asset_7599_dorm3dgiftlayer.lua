class = var_0_10000

local var_0_0 = "Dorm3dGiftLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dGiftUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "btn_back")

	onButton = var_1_10002

	local var_2_2 = arg_2_0
	local var_2_3 = var_2_1

	local function var_2_4()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_CANCEL = var_1_10007

	var_1_10002(var_2_2, var_2_3, var_2_4, var_1_10007)

	local var_2_5 = arg_2_0._tf

	arg_2_0.rtGiftPanel = var_2.Find(var_2_5, "gift_panel")
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2({
		"all",
		"normal",
		"pro"
	}) do
		onToggle = var_1_10007

		local var_2_6 = arg_2_0
		local var_2_7 = arg_2_0.rtGiftPanel
		local var_2_8 = var_10.Find(var_2_7, "content/toggles/" .. iter_2_1)

		local function var_2_9(arg_4_0)
			if arg_4_0 then
				if arg_2_0.afterFirst then
					quickPlayAnimation = var_1

					var_1(arg_2_0.rtGiftPanel, "anim_dorm3d_giftui_change")
				else
					arg_2_0.afterFirst = true
				end

				local var_4_0 = arg_2_0

				var_1.UpdateSelectToggle(var_4_0, iter_2_1)
			end

			return
		end

		SFX_PANEL = var_2_7

		var_1_10007(var_2_6, var_2_8, var_2_9, var_2_7)
	end

	local var_2_10 = arg_2_0.rtGiftPanel
	local var_2_11 = var_2.Find(var_2_10, "content/view/container")

	UIItemList = var_3

	local var_2_12 = var_3.New
	local var_2_13 = var_2_11
	local var_2_14 = var_2_11

	arg_2_0.giftItemList = var_2_12(var_2_13, var_2_11.Find(var_2_14, "tpl"))

	local var_2_15 = arg_2_0.giftItemList

	var_3.make(var_2_15, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_2_0

			var_3.UpdateGift(var_5_0, arg_5_2, arg_2_0.filterGiftIds[arg_5_1])
		end

		return
	end)

	arg_2_0.showedGiftRecords = {}
	onScroll = var_3

	var_3(arg_2_0, var_2_11, function(arg_6_0)
		local var_6_0 = arg_2_0

		var_1.OnGiftListScroll(var_6_0, arg_6_0)

		return
	end)

	local var_2_16 = arg_2_0.rtGiftPanel

	arg_2_0.btnConfirm = var_3.Find(var_2_16, "bottom/btn_confirm")
	onButton = var_3

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0.btnConfirm

	local function var_2_19()
		local var_7_0 = arg_2_0

		var_0.ConfirmGiveGifts(var_7_0)

		return
	end

	SFX_CONFIRM = var_2_14

	var_3(var_2_17, var_2_18, var_2_19, var_2_14)

	local var_2_20 = arg_2_0._tf

	arg_2_0.rtInfoWindow = var_3.Find(var_2_20, "info_window")
	onButton = var_3

	local var_2_21 = arg_2_0
	local var_2_22 = arg_2_0.rtInfoWindow
	local var_2_23 = var_6.Find(var_2_22, "bg")

	local function var_2_24()
		local var_8_0 = arg_2_0

		var_0.HideInfoWindow(var_8_0)

		return
	end

	SFX_CANCEL = var_2_22

	var_3(var_2_21, var_2_23, var_2_24, var_2_22)

	onButton = var_3

	local var_2_25 = arg_2_0
	local var_2_26 = arg_2_0.rtInfoWindow
	local var_2_27 = var_6.Find(var_2_26, "panel/title/btn_close")

	local function var_2_28()
		local var_9_0 = arg_2_0

		var_0.HideInfoWindow(var_9_0)

		return
	end

	SFX_CANCEL = var_2_26

	var_3(var_2_25, var_2_27, var_2_28, var_2_26)

	local var_2_29 = arg_2_0._tf

	arg_2_0.rtLackWindow = var_3.Find(var_2_29, "lack_window")
	onButton = var_3

	local var_2_30 = arg_2_0
	local var_2_31 = arg_2_0.rtLackWindow
	local var_2_32 = var_6.Find(var_2_31, "bg")

	local function var_2_33()
		local var_10_0 = arg_2_0

		var_0.HideLackWindow(var_10_0)

		return
	end

	SFX_CANCEL = var_2_31

	var_3(var_2_30, var_2_32, var_2_33, var_2_31)

	onButton = var_3

	local var_2_34 = arg_2_0
	local var_2_35 = arg_2_0.rtLackWindow
	local var_2_36 = var_6.Find(var_2_35, "panel/title/btn_close")

	local function var_2_37()
		local var_11_0 = arg_2_0

		var_0.HideLackWindow(var_11_0)

		return
	end

	SFX_CANCEL = var_2_35

	var_3(var_2_34, var_2_36, var_2_37, var_2_35)
	arg_2_0:TempOverlayPanelPB(arg_2_0.rtGiftPanel, {
		pbList = {
			arg_2_0.rtGiftPanel
		},
		baseCamera = arg_2_0.contextData.baseCamera
	})

	return
end

function var_0_1.SetApartment(arg_12_0, arg_12_1)
	arg_12_0.apartment = arg_12_1

	local var_12_0 = arg_12_0.apartment

	arg_12_0.giftIds = var_2.getGiftIds(var_12_0)
	getProxy = var_2
	ApartmentProxy = var_12_0
	arg_12_0.proxy = var_2(var_12_0)

	return
end

function var_0_1.didEnter(arg_13_0)
	triggerToggle = var_1_10001

	local var_13_0 = arg_13_0.rtGiftPanel

	var_1_10001(var_3.Find(var_13_0, "content/toggles/all"), true)
	arg_13_0:UpdateConfirmBtn()

	return
end

function var_0_1.UpdateSelectToggle(arg_14_0, arg_14_1)
	if arg_14_0.toggleState == arg_14_1 then
		return
	end

	arg_14_0.toggleState = arg_14_1

	arg_14_0:UpdateFilterGiftIds()

	local var_14_0 = arg_14_0.giftItemList

	var_2.align(var_14_0, #arg_14_0.filterGiftIds)

	return
end

function var_0_1.UpdateFilterGiftIds(arg_15_0)
	underscore = var_1_10001
	arg_15_0.filterGiftIds = var_1_10001.filter(arg_15_0.giftIds, function(arg_16_0)
		pg = var_2_10001

		if var_2_10001.dorm3d_gift[arg_16_0].hide_if_not_owned == 1 then
			local var_16_0 = arg_15_0.proxy

			if var_2.getGiftCount(var_16_0, arg_16_0) <= 0 then
				return false
			end
		end

		return arg_15_0.toggleState == "all" or arg_15_0.toggleState == "normal" == (var_1.ship_group_id == 0)
	end)
	table = var_1

	local var_15_0 = var_1.sort
	local var_15_1 = arg_15_0.filterGiftIds

	CompareFuncs = var_4

	var_15_0(var_15_1, var_4({
		function(arg_17_0)
			local var_17_0 = arg_15_0.proxy
			local var_17_1 = var_1.getGiftCount(var_17_0, arg_17_0)
			local var_17_2 = 0 < var_17_1 and -1 or 1

			pg = var_2

			return var_17_2 * (var_2.dorm3d_gift[arg_17_0].ship_group_id == 0 and 1 or 2)
		end,
		function(arg_18_0)
			Dorm3dGift = var_2_10001

			local var_18_1

			if var_2_10001.IsSingleGiveGift(arg_18_0) then
				local var_18_0 = arg_15_0.proxy

				if var_1.isGiveGiftDone(var_18_0, arg_18_0) then
					var_18_1 = 1

					goto label_18_0
				end
			end

			var_18_1 = 0

			::label_18_0::

			return var_18_1
		end,
		function(arg_19_0)
			return arg_19_0
		end
	}))

	if arg_15_0.selectGiftId then
		table = var_1

		if not var_1.indexof(arg_15_0.filterGiftIds, arg_15_0.selectGiftId) then
			arg_15_0.selectGiftId = nil
			arg_15_0.selectGiftCount = nil

			arg_15_0:UpdateConfirmBtn()
		end
	end

	return
end

function var_0_1.UpdateGift(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_1.name = arg_20_2

	local var_20_0 = arg_20_1
	local var_20_1 = arg_20_1.Find(var_20_0, "base")

	Drop = var_1_10005

	local var_20_2 = var_1_10005.New
	local var_20_3 = {}

	DROP_TYPE_DORM3D_GIFT = var_1_10008
	var_20_3.type = var_1_10008
	var_20_3.id = arg_20_2

	local var_20_4 = arg_20_0.proxy

	var_20_3.count = var_8.getGiftCount(var_20_4, arg_20_2)

	local var_20_5 = var_20_2(var_20_3)

	updateCustomDrop = var_20_0

	var_20_0(var_20_1:Find("Dorm3dIconTpl"), var_20_5)

	setText = var_20_0

	var_20_0(var_20_1:Find("info/name"), var_20_5:getName())

	local var_20_6 = var_20_5
	local var_20_7 = var_20_5.getConfig(var_20_6, "ship_group_id") ~= 0

	setActive = var_20_3

	var_20_3(var_20_1:Find("mark"), var_20_7)

	setActive = var_20_3

	var_20_3(var_20_1:Find("bg/normal"), not var_20_7)

	setActive = var_20_3

	var_20_3(var_20_1:Find("bg/pro"), var_20_7)

	setText = var_20_3

	local var_20_8 = var_20_1
	local var_20_9 = var_20_1.Find(var_20_8, "info/Text")

	i18n = var_10

	local var_20_10 = var_10("dorm3d_gift_owner_num")

	string = var_20_8

	var_20_3(var_20_9, var_20_10 .. var_20_8.format("%d", var_20_5.count))

	setActive = var_20_3

	local var_20_11 = var_20_1:Find("info/overtime")

	Dorm3dGift = var_10

	var_20_3(var_20_11, var_10.IsExpireSoon(arg_20_2))

	local var_20_12 = var_20_1:Find("info/effect")

	setActive = var_20_6

	var_20_6(var_20_12:Find("favor"), true)

	pg = var_20_6

	local var_20_13 = var_20_6.dorm3d_favor_trigger[var_20_5.cfg.favor_trigger_id].num

	setText = var_9

	var_9(var_20_12:Find("favor/number"), "+" .. var_20_13)

	setActive = var_9

	local var_20_14 = var_20_12:Find("story")

	pg = var_12

	var_9(var_20_14, var_12.dorm3d_gift[arg_20_2].unlock_dialogue_id ~= 0)

	onButton = var_9

	local var_20_15 = arg_20_0
	local var_20_16 = var_20_1
	local var_20_17 = var_20_1.Find(var_20_16, "info/btn_info")

	local function var_20_18()
		local var_21_0 = arg_20_0

		var_0.OpenLackWindow(var_21_0, var_20_5)

		return
	end

	SFX_PANEL = var_20_16

	var_9(var_20_15, var_20_17, var_20_18, var_20_16)

	Dorm3dGift = var_9

	local var_20_19 = var_9.New({
		configId = arg_20_2
	})

	Dorm3dGift = var_10

	local var_20_20, var_20_21

	if var_10.IsSingleGiveGift(arg_20_2) then
		var_20_20 = arg_20_0.proxy
		var_20_21 = var_10.isGiveGiftDone(var_20_20, arg_20_2)
	end

	local var_20_22 = var_20_19:GetShopID()

	setActive = var_20_20

	local var_20_23 = var_20_1

	var_20_20(var_20_1.Find(var_20_23, "info/lack"), var_20_22 ~= 0)

	if var_20_22 ~= 0 then
		CommonCommodity = var_20_20
		var_20_20 = var_20_20.New

		local var_20_24 = {
			id = var_20_22
		}

		Goods = var_15

		local var_20_25 = var_20_20(var_20_24, var_15.TYPE_SHOPSTREET)
		local var_20_26, var_20_27, var_20_28 = var_20_20.GetPrice(var_20_25)

		Drop = var_20_23

		local var_20_29 = var_20_23.New
		local var_20_30 = {}

		DROP_TYPE_RESOURCE = var_1_10019
		var_20_30.type = var_1_10019
		var_20_30.id = var_20_20:GetResType()
		var_20_30.count = var_20_26

		local var_20_31 = var_20_29(var_20_30)

		setActive = var_17
		var_1_10019 = var_20_1:Find("info/lack/tip")

		if var_20_7 then
			::label_20_0::

			if not var_20_21 then
				Dorm3dGift = var_1_10020

				if var_1_10020.GetViewedFlag(arg_20_2) ~= 0 then
					var_1_10020 = false
				else
					var_1_10020 = true
				end

				var_17(var_1_10019, var_1_10020)

				local var_20_32
				local var_20_33 = 0

				_ = var_1_10019

				var_1_10019.each(var_20_19:getConfig("shop_id"), function(arg_22_0)
					pg = var_2_10001

					if var_2_10001.shop_template[arg_22_0].group_type == 2 then
						math = var_2
						var_20_33 = var_2.max(var_1.group_limit, var_20_33)
					end

					return
				end)

				if 0 < var_20_33 then
					var_1_10019 = {}
					getProxy = var_1_10020
					ApartmentProxy = var_22

					local var_20_34 = var_1_10020(var_22)

					var_1_10019[1] = var_20.GetGiftShopCount(var_20_34, var_20_19:GetConfigID())
					var_1_10019[2] = var_20_33
					var_20_32 = var_1_10019
				end

				onButton = var_1_10019

				local var_20_35 = arg_20_0
				local var_20_36 = var_20_1
				local var_20_37 = var_20_1.Find(var_20_36, "info/lack")

				local function var_20_38()
					Dorm3dGift = var_2_10000

					var_2_10000.SetViewedFlag(arg_20_2)

					setActive = var_0

					local var_23_0 = var_20_1

					var_0(var_2.Find(var_23_0, "info/lack/tip"), false)

					local var_23_1 = var_20_19

					if not var_0.CheckBuyLimit(var_23_1) then
						pg = var_0

						local var_23_2 = var_0.TipsMgr.GetInstance()
						local var_23_3 = var_0.ShowTips

						i18n = var_3

						var_23_3(var_23_2, var_3("dorm3d_shop_gift_owned"))

						return
					end

					local var_23_4 = arg_20_0
					local var_23_5 = var_0.emit

					Dorm3dGiftMediator = var_3

					local var_23_6 = var_3.SHOW_SHOPPING_CONFIRM_WINDOW
					local var_23_7 = {}
					local var_23_8 = {}
					local var_23_9 = "<icon name="
					local var_23_10 = var_20_20

					var_23_8.icon = var_23_9 .. var_7.GetResIcon(var_23_10) .. " w=1.1 h=1.1/>"
					var_23_8.off = var_20_27
					var_23_8.cost = var_20_31.count
					var_23_8.old = var_20_28

					local var_23_11 = var_20_5

					var_23_8.name = var_6.getConfig(var_23_11, "name")
					var_23_8.weekLimit = var_20_32
					var_23_7.content = var_23_8
					i18n = var_23_8
					var_23_7.tip = var_23_8("dorm3d_shop_gift_tip")
					var_23_7.drop = var_20_19

					local var_23_12 = arg_20_0.apartment

					var_23_7.groupId = var_5.GetConfigID(var_23_12)

					function var_23_7.onYes()
						local var_24_0 = arg_20_0
						local var_24_1 = var_0.emit

						GAME = var_3_10003

						var_24_1(var_24_0, var_3_10003.SHOPPING, {
							silentTip = true,
							count = 1,
							shopId = var_20_22
						})

						return
					end

					var_23_5(var_23_4, var_23_6, var_23_7)

					return
				end

				SFX_PANEL = var_20_36

				var_1_10019(var_20_35, var_20_37, var_20_38, var_20_36)

				setActive = var_20_20

				var_20_20(arg_20_1:Find("mask"), var_20_21)

				setText = var_20_20

				local var_20_39 = arg_20_1:Find("mask/Image/Text")

				i18n = var_15

				var_20_20(var_20_39, var_15("dorm3d_already_gifted"))

				local function var_20_40(arg_25_0)
					local var_25_0 = arg_20_0

					var_25_0.selectGiftCount = arg_25_0
					setText = var_25_0

					local var_25_1 = arg_20_1

					var_25_0(var_3.Find(var_25_1, "base/PageUtil/Text"), arg_25_0)

					setGray = var_25_0

					local var_25_2 = arg_20_1
					local var_25_3 = var_3.Find(var_25_2, "base/PageUtil/Add")

					math = var_4

					var_25_0(var_25_3, arg_25_0 >= var_4.min(20, var_20_5.count))

					setGray = var_25_0

					local var_25_4 = arg_20_1

					var_25_0(var_3.Find(var_25_4, "base/PageUtil/Minus"), arg_25_0 <= 1)

					return
				end

				;(function()
					math = var_2_10000

					local var_26_0 = var_2_10000.min(20, var_20_5.count)

					pressPersistTrigger = var_2_10001

					local var_26_1 = arg_20_1
					local var_26_2 = var_3.Find(var_26_1, "base/PageUtil/Minus")
					local var_26_3 = 0.5

					local function var_26_4()
						local var_27_0 = arg_20_0.selectGiftCount - 1 <= 0 and arg_20_0.selectGiftCount or var_27_0

						var_20_40(var_27_0)

						return
					end

					local var_26_5
					local var_26_6 = true
					local var_26_7 = true
					local var_26_8 = 0.1

					SFX_PANEL = var_2_10010

					var_2_10001(var_26_2, var_26_3, var_26_4, var_26_5, var_26_6, var_26_7, var_26_8, var_2_10010)

					pressPersistTrigger = var_2_10001

					local var_26_9 = arg_20_1
					local var_26_10 = var_3.Find(var_26_9, "base/PageUtil/Add")
					local var_26_11 = 0.5

					local function var_26_12()
						local var_28_0 = arg_20_0.selectGiftCount + 1 > var_26_0 and var_26_0 or var_28_0

						var_20_40(var_28_0)

						return
					end

					local var_26_13
					local var_26_14 = true
					local var_26_15 = true
					local var_26_16 = 0.1

					SFX_PANEL = var_2_10010

					var_2_10001(var_26_10, var_26_11, var_26_12, var_26_13, var_26_14, var_26_15, var_26_16, var_2_10010)

					return
				end)()

				onToggle = var_14

				local var_20_41 = arg_20_0
				local var_20_42 = arg_20_1

				local function var_20_43(arg_29_0)
					if arg_29_0 then
						var_2_10001 = arg_20_0
						var_2_10001.selectGiftId = arg_20_2

						local var_29_0 = arg_20_0

						var_2_10001.UpdateConfirmBtn(var_29_0)

						var_2_10001 = var_20_40
						math = var_29_0

						var_2_10001(var_29_0.min(1, var_20_5.count))
					elseif arg_20_0.selectGiftId == arg_20_2 then
						var_2_10001 = arg_20_0
						var_2_10001.selectGiftId = nil

						local var_29_1 = arg_20_0

						var_2_10001.UpdateConfirmBtn(var_29_1)
					end

					setActive = var_2_10001

					local var_29_2 = arg_20_1

					var_2_10001(var_3.Find(var_29_2, "base/PageUtil"), arg_29_0)

					return
				end

				SFX_PANEL = var_1_10019

				var_14(var_20_41, var_20_42, var_20_43, var_1_10019)

				setToggleEnabled = var_14

				var_14(arg_20_1, not var_20_21)

				triggerToggle = var_14

				var_14(arg_20_1, arg_20_3)

				return
			end
		end
	end
end

function var_0_1.SingleUpdateGift(arg_30_0, arg_30_1)
	arg_30_0:UpdateFilterGiftIds()

	local var_30_0 = arg_30_0.giftItemList

	var_2.align(var_30_0, #arg_30_0.filterGiftIds)

	table = var_2

	if var_2.indexof(arg_30_0.filterGiftIds, arg_30_1) then
		local var_30_1 = arg_30_0
		local var_30_2 = arg_30_0.UpdateGift
		local var_30_3 = arg_30_0.giftItemList.container

		var_30_2(var_30_1, var_6.GetChild(var_30_3, var_2 - 1), arg_30_1, true)
	end

	return
end

function var_0_1.OnGiftListScroll(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.rtGiftPanel
	local var_31_1 = var_2.Find(var_31_0, "content/view/container")

	GetComponent = var_1_10003

	local var_31_2 = var_31_1

	typeof = var_1_10006
	VerticalLayoutGroup = var_1_10008

	local var_31_3 = var_1_10003(var_31_2, var_1_10006(var_1_10008))
	local var_31_4 = var_31_1.rect.height
	local var_31_5 = var_31_1:GetChild(0).rect.height + var_31_3.spacing
	local var_31_6 = var_31_1.anchoredPosition.y + var_31_4

	math = var_1_10009

	local var_31_7 = var_1_10009.floor((var_7 - var_31_3.padding.top) / var_31_5)

	math = var_1_10010

	local var_31_8 = var_1_10010.ceil((var_31_6 - var_31_3.padding.top) / var_31_5)

	math = var_11

	local var_31_9 = var_11.max(1, var_31_7)

	math = var_12

	for iter_31_0 = var_31_9, var_12.min(#arg_31_0.filterGiftIds, var_31_8) do
		local var_31_10 = arg_31_0.filterGiftIds[iter_31_0]

		if not arg_31_0.showedGiftRecords[var_31_10] then
			local var_31_11 = arg_31_0.showedGiftRecords

			var_31_11[var_31_10] = true
			Dorm3dGift = var_31_11

			local var_31_12 = var_31_11.SetViewedFlag(var_31_10)
		end
	end

	return
end

function var_0_1.UpdateConfirmBtn(arg_32_0)
	setButtonEnabled = var_1_10001

	local var_32_0 = arg_32_0.btnConfirm

	tobool = var_1_10004

	var_1_10001(var_32_0, var_1_10004(arg_32_0.selectGiftId))

	return
end

function var_0_1.ConfirmGiveGifts(arg_33_0)
	local var_33_0 = arg_33_0.proxy

	if var_1.getGiftCount(var_33_0, arg_33_0.selectGiftId) == 0 then
		Dorm3dGift = var_1

		local var_33_3

		if var_1.IsSingleGiveGift(arg_33_0.selectGiftId) then
			local var_33_1 = arg_33_0.proxy

			if var_33_3.isGiveGiftDone(var_33_1, arg_33_0.selectGiftId) then
				pg = var_33_3

				local var_33_2 = var_33_3.TipsMgr.GetInstance()

				var_33_3 = var_33_3.ShowTips
				i18n = var_4

				var_33_3(var_33_2, var_4("dorm3d_shop_gift_already_given"))

				goto label_33_0
			end
		end

		pg = var_33_3

		do
			local var_33_4 = var_33_3.TipsMgr.GetInstance()
			local var_33_5 = var_1.ShowTips

			i18n = var_4

			var_33_5(var_33_4, var_4("dorm3d_shop_gift_not_owned"))
		end

		::label_33_0::

		return
	end

	local var_33_6 = {}
	local var_33_7 = arg_33_0.apartment
	local var_33_8

	if var_2.isMaxFavor(var_33_7) then
		table = var_33_8

		var_33_8.insert(var_33_6, function(arg_34_0)
			pg = var_2_10001

			local var_34_0 = var_2_10001.NewStyleMsgboxMgr.GetInstance()
			local var_34_1 = var_1.Show

			pg = var_2_10004

			local var_34_2 = var_2_10004.NewStyleMsgboxMgr.TYPE_MSGBOX
			local var_34_3 = {}

			i18n = var_2_10006
			var_34_3.contentText = var_2_10006("dorm3d_gift_favor_max")
			var_34_3.onConfirm = arg_34_0

			var_34_1(var_34_0, var_34_2, var_34_3)

			return
		end)
	else
		pg = var_33_8
		var_33_8 = var_33_8.dorm3d_gift[arg_33_0.selectGiftId].favor_trigger_id
		pg = var_3

		local var_33_9 = var_3.dorm3d_favor_trigger[var_33_8]
		local var_33_10 = arg_33_0.apartment.favor + var_33_9.num * arg_33_0.selectGiftCount
		local var_33_11 = arg_33_0.apartment
		local var_33_12 = var_33_10 - var_5.getMaxFavor(var_33_11)

		if 0 < var_33_12 then
			table = var_5

			var_5.insert(var_33_6, function(arg_35_0)
				pg = var_2_10001

				local var_35_0 = var_2_10001.NewStyleMsgboxMgr.GetInstance()
				local var_35_1 = var_1.Show

				pg = var_2_10004

				local var_35_2 = var_2_10004.NewStyleMsgboxMgr.TYPE_MSGBOX
				local var_35_3 = {}

				i18n = var_2_10006
				var_35_3.contentText = var_2_10006("dorm3d_gift_favor_exceed", var_33_12)
				var_35_3.onConfirm = arg_35_0

				var_35_1(var_35_0, var_35_2, var_35_3)

				return
			end)
		end
	end

	seriesAsync = var_33_8

	var_33_8(var_33_6, function()
		local var_36_0 = arg_33_0
		local var_36_1 = var_0.emit

		Dorm3dGiftMediator = var_2_10003

		var_36_1(var_36_0, var_2_10003.GIVE_GIFT, arg_33_0.selectGiftId, arg_33_0.selectGiftCount)

		return
	end)

	return
end

function var_0_1.AfterGiveGift(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1.giftId

	table = var_1_10003

	local var_37_1

	if var_1_10003.indexof(arg_37_0.filterGiftIds, var_37_0) then
		var_37_1 = arg_37_0.giftItemList.container
		var_1_10004 = var_1_10004.GetChild(var_37_1, var_3 - 1)
		quickPlayAnimation = var_5

		var_5(var_1_10004, "anim_dorm3d_giftui_Select")
	end

	pg = var_1_10004

	local var_37_2 = var_1_10004.dorm3d_gift[var_37_0]
	local var_37_3 = {}

	Apartment = var_37_1

	if var_37_1.getGroupConfig(arg_37_0.apartment.configId, var_37_2.reply_dialogue_id) then
		ApartmentProxy = var_1_10007

		local var_37_4 = var_1_10007.CheckUnlockConfig

		pg = var_9

		if var_37_4(var_9.dorm3d_dialogue_group[var_6].unlock) then
			table = var_7

			var_7.insert(var_37_3, function(arg_38_0)
				local var_38_0 = arg_37_0
				local var_38_1 = var_1.emit

				Dorm3dGiftMediator = var_2_10004

				var_38_1(var_38_0, var_2_10004.DO_TALK, var_0, arg_38_0)

				return
			end)
		end
	end

	if var_37_2.unlock_dialogue_id > 0 then
		table = var_7

		var_7.insert(var_37_3, function(arg_39_0)
			pg = var_2_10001

			local var_39_0 = var_2_10001.TipsMgr.GetInstance()
			local var_39_1 = var_1.ShowTips

			i18n = var_2_10004

			var_39_1(var_39_0, var_2_10004("dorm3d_gift_story_unlock"))
			arg_39_0()

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_37_3, function()
		local var_40_0 = arg_37_0

		var_0.CheckLevelUp(var_40_0)

		return
	end)

	return
end

function var_0_1.CheckLevelUp(arg_41_0)
	local var_41_0 = arg_41_0.apartment

	if var_1.canLevelUp(var_41_0) then
		local var_41_1 = arg_41_0
		local var_41_2 = arg_41_0.emit

		Dorm3dRoomMediator = var_1_10004

		var_41_2(var_41_1, var_1_10004.FAVOR_LEVEL_UP, arg_41_0.apartment.configId)
	end

	return
end

function var_0_1.OpenInfoWindow(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0.rtInfoWindow
	local var_42_1 = var_2.Find(var_42_0, "panel")

	setText = var_1_10003

	local var_42_2 = var_42_1:Find("title/Text")

	i18n = var_1_10006

	var_1_10003(var_42_2, var_1_10006("words_information"))

	updateCustomDrop = var_1_10003

	var_1_10003(var_42_1:Find("middle/Dorm3dIconTpl"), arg_42_1)

	local var_42_3 = arg_42_1:getConfig("ship_group_id") ~= 0

	setActive = var_42_0

	var_42_0(var_42_1:Find("middle/Dorm3dIconTpl/mark"), var_42_3)

	setText = var_42_0

	var_42_0(var_42_1:Find("middle/Text"), "???")

	onButton = var_42_0

	local var_42_4 = arg_42_0
	local var_42_5 = var_42_1
	local var_42_6 = var_42_1.Find(var_42_5, "bottom/btn_buy")

	local function var_42_7()
		pg = var_2_10000

		local var_43_0 = var_2_10000.TipsMgr.GetInstance()

		var_0.ShowTips(var_43_0, "without shop config")

		return
	end

	SFX_CONFIRM = var_42_5

	var_42_0(var_42_4, var_42_6, var_42_7, var_42_5)

	setActive = var_42_0

	var_42_0(arg_42_0.rtInfoWindow, true)
	arg_42_0:OverlayPanel(arg_42_0.rtInfoWindow)

	return
end

function var_0_1.HideInfoWindow(arg_44_0)
	setActive = var_1_10001

	var_1_10001(arg_44_0.rtInfoWindow, false)
	arg_44_0:UnOverlayPanel(arg_44_0.rtInfoWindow, arg_44_0._tf)

	return
end

function var_0_1.OpenLackWindow(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0.rtLackWindow
	local var_45_1 = var_2.Find(var_45_0, "panel")

	setText = var_1_10003

	local var_45_2 = var_45_1:Find("title/Text")

	i18n = var_1_10006

	var_1_10003(var_45_2, var_1_10006("child_msg_title_detail"))

	updateCustomDrop = var_1_10003

	var_1_10003(var_45_1:Find("middle/Dorm3dIconTpl"), arg_45_1)

	local var_45_3 = arg_45_1:getConfig("ship_group_id") ~= 0

	setActive = var_45_0

	var_45_0(var_45_1:Find("middle/Dorm3dIconTpl/mark"), var_45_3)

	setText = var_45_0

	var_45_0(var_45_1:Find("middle/info/name"), arg_45_1:getName())

	setText = var_45_0

	local var_45_4 = var_45_1:Find("middle/info/count")

	string = var_7

	var_45_0(var_45_4, var_7.format("count:<color=#39bfff>%d</color>", arg_45_1.count))

	setText = var_45_0

	var_45_0(var_45_1:Find("middle/info/desc"), arg_45_1:getConfig("display"))

	setText = var_45_0

	var_45_0(var_45_1:Find("line/lack/Text"), "lack")

	ItemTipPanel = var_45_0

	local var_45_5

	if not var_45_0.GetDropLackConfig(arg_45_1) or not var_4.description then
		var_45_5 = {}
	end

	local var_45_6 = var_45_1:Find("bottom/container")

	UIItemList = var_7

	var_7.StaticAlign(var_45_6, var_45_6:Find("tpl"), #var_45_5, function(arg_46_0, arg_46_1, arg_46_2)
		arg_46_1 = arg_46_1 + 1
		UIItemList = var_2_10003

		if arg_46_0 == var_2_10003.EventUpdate then
			local var_46_0 = var_45_5[arg_46_1]

			unpack = var_2_10004

			local var_46_1, var_46_2, var_46_3 = var_2_10004(var_46_0)

			setText = var_2_10007

			var_2_10007(arg_46_2:Find("Text"), var_46_1)

			setText = var_2_10007

			local var_46_4 = arg_46_2:Find("btn_go/Text")

			i18n = var_10

			var_2_10007(var_46_4, var_10("feast_res_window_go_label"))

			unpack = var_2_10007

			local var_46_5, var_46_6, var_46_7 = var_2_10007(var_0)

			unpack = var_10

			local var_46_8, var_46_9 = var_10(var_46_6)
			local var_46_10 = #var_46_8
			local var_46_11 = 0 < var_46_10

			if var_46_7 and var_46_7 ~= 0 and var_46_11 then
				getProxy = var_13
				ActivityProxy = var_2_10015

				local var_46_12 = var_13(var_2_10015)

				var_46_11 = var_13.IsActivityNotEnd(var_46_12, var_46_7)
			end

			setActive = var_13

			var_13(arg_46_2:Find("btn_go"), var_46_11)

			onButton = var_13

			local var_46_13 = arg_45_0
			local var_46_14 = arg_46_2
			local var_46_15 = arg_46_2.Find(var_46_14, "btn_go")

			local function var_46_16()
				ItemTipPanel = var_3_10000

				var_3_10000.ConfigGoScene(var_46_8, var_46_9, function()
					local var_48_0 = arg_45_0

					var_0.closeView(var_48_0)

					return
				end)

				return
			end

			SFX_PANEL = var_46_14

			var_13(var_46_13, var_46_15, var_46_16, var_46_14)
		end

		return
	end)

	setActive = var_7

	var_7(arg_45_0.rtLackWindow, true)
	arg_45_0:OverlayPanel(arg_45_0.rtLackWindow)

	return
end

function var_0_1.HideLackWindow(arg_49_0)
	setActive = var_1_10001

	var_1_10001(arg_49_0.rtLackWindow, false)
	arg_49_0:UnOverlayPanel(arg_49_0.rtLackWindow, arg_49_0._tf)

	return
end

function var_0_1.onBackPressed(arg_50_0)
	isActive = var_1_10001

	if var_1_10001(arg_50_0.rtInfoWindow) then
		arg_50_0:HideInfoWindow()

		return
	end

	isActive = var_1

	if var_1(arg_50_0.rtLackWindow) then
		arg_50_0:HideLackWindow()

		return
	end

	var_0_1.super.onBackPressed(arg_50_0)

	return
end

function var_0_1.willExit(arg_51_0)
	isActive = var_1_10001

	if var_1_10001(arg_51_0.rtInfoWindow) then
		arg_51_0:HideInfoWindow()
	end

	isActive = var_1

	if var_1(arg_51_0.rtLackWindow) then
		arg_51_0:HideLackWindow()
	end

	arg_51_0:TempUnOverlayPanelPB(arg_51_0.rtGiftPanel, arg_51_0._tf)

	return
end

return var_0_1
