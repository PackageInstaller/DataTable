class = var_0_10000

local var_0_0 = "WorldCruiseShopPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "WorldCruiseShopPage"
end

function var_0_1.UpdateShop(arg_2_0, arg_2_1)
	local var_2_1

	if not arg_2_1 then
		::label_2_0::

		getProxy = var_2_1
		ShopsProxy = var_1_10003

		local var_2_0 = var_2_1(var_1_10003)

		var_2_1 = var_2_1.GetCruiseShop(var_2_0)
	end

	arg_2_0.shop = var_2_1

	return
end

function var_0_1.OnLoaded(arg_3_0)
	arg_3_0:UpdateShop()

	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "frame")

	arg_3_0.lockTF = var_1.Find(var_3_1, "views/lock")
	arg_3_0.remainTF = var_1:Find("views/remain")
	arg_3_0.togglesTF = var_1:Find("toggles")
	eachChild = var_2

	var_2(arg_3_0.togglesTF, function(arg_4_0)
		setText = var_2_10001

		local var_4_0 = arg_4_0
		local var_4_1 = arg_4_0.Find(var_4_0, "unselected/Text")

		i18n = var_4_0

		var_2_10001(var_4_1, var_4_0("cruise_shop_title_" .. arg_4_0.name))

		setText = var_2_10001

		local var_4_2 = arg_4_0
		local var_4_3 = arg_4_0.Find(var_4_2, "selected/Text")

		i18n = var_4_2

		var_2_10001(var_4_3, var_4_2("cruise_shop_title_" .. arg_4_0.name))

		onToggle = var_2_10001

		local var_4_4 = arg_3_0
		local var_4_5 = arg_4_0

		local function var_4_6(arg_5_0)
			if arg_5_0 then
				setActive = var_3_10001

				var_3_10001(arg_3_0.remainTF, arg_4_0.name == "equip_skin")
			end

			local var_5_0 = arg_3_0

			var_1.Flush(var_5_0)

			return
		end

		SFX_PANEL = var_5

		var_2_10001(var_4_4, var_4_5, var_4_6, var_5)

		return
	end)

	local var_3_2 = var_1
	local var_3_3 = var_1.Find(var_3_2, "views")

	string = var_3_2

	local var_3_4 = var_3_2.format
	local var_3_5 = "-%s-"

	i18n = var_1_10005

	local var_3_6 = var_3_4(var_3_5, var_1_10005("word_sell_out"))

	arg_3_0.skinView = var_3_3:Find("skin")
	setText = var_4

	local var_3_7 = arg_3_0.skinView

	var_4(var_5.Find(var_3_7, "tpl_skin/mask/sell_out/Text"), var_3_6)

	GetComponent = var_4

	local var_3_8 = arg_3_0.skinView

	arg_3_0.skinScrollCom = var_4(var_5.Find(var_3_8, "content"), "LScrollRect")

	function arg_3_0.skinScrollCom.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_3_0
		local var_6_1 = var_2.UpdateSkinItem
		local var_6_2 = arg_6_0

		tf = var_2_10005

		var_6_1(var_6_0, var_6_2, var_2_10005(arg_6_1))

		return
	end

	arg_3_0.equipSkinView = var_3_3:Find("equip_skin")
	setText = var_4

	local var_3_9 = arg_3_0.equipSkinView

	var_4(var_5.Find(var_3_9, "tpl_equip_skin/mask/sell_out/Text"), var_3_6)

	GetComponent = var_4

	local var_3_10 = arg_3_0.equipSkinView

	arg_3_0.equipSkinScrollCom = var_4(var_5.Find(var_3_10, "content"), "LScrollRect")

	function arg_3_0.equipSkinScrollCom.onUpdateItem(arg_7_0, arg_7_1)
		local var_7_0 = arg_3_0
		local var_7_1 = var_2.UpdateEquipSkinItem
		local var_7_2 = arg_7_0

		tf = var_2_10005

		var_7_1(var_7_0, var_7_2, var_2_10005(arg_7_1))

		return
	end

	return
end

function var_0_1.OnInit(arg_8_0)
	pg = var_1_10001
	arg_8_0.unlockPhase = var_1_10001.gameset.battlepass_level.key_value
	arg_8_0.paintingList = {}

	return
end

function var_0_1.Flush(arg_9_0, arg_9_1)
	arg_9_0:Show()

	if arg_9_1 then
		arg_9_0:UpdateShop(arg_9_1)
	end

	arg_9_0.isLock = arg_9_0.contextData.phase < arg_9_0.unlockPhase

	local var_9_0 = arg_9_0.shop

	arg_9_0.remainCnt = var_2.GetRemainEquipSkinCnt(var_9_0)
	setText = var_2

	local var_9_1 = arg_9_0.lockTF
	local var_9_2 = var_3.Find(var_9_1, "Image/Text")

	i18n = var_9_1

	var_2(var_9_2, var_9_1("cruise_shop_lock_tip", arg_9_0.contextData.phase, arg_9_0.unlockPhase))

	setActive = var_2

	var_2(arg_9_0.lockTF, arg_9_0.isLock)

	setText = var_2

	local var_9_3 = arg_9_0.remainTF

	i18n = var_4

	var_2(var_9_3, var_4("cruise_shop_limit_tip") .. arg_9_0.remainCnt)

	local var_9_4 = arg_9_0.shop
	local var_9_5 = var_2.getSortGoodsByType

	CruiseShop = var_4
	arg_9_0.skinGoods = var_9_5(var_9_4, var_4.TYPE_SKIN)
	isActive = var_2

	if var_2(arg_9_0.skinView) then
		local var_9_6 = arg_9_0.skinScrollCom

		var_2.SetTotalCount(var_9_6, #arg_9_0.skinGoods)
	end

	local var_9_7 = arg_9_0.shop
	local var_9_8 = var_2.getSortGoodsByType

	CruiseShop = var_4
	arg_9_0.equipSkinGoods = var_9_8(var_9_7, var_4.TYPE_EQUIP_SKIN)
	isActive = var_2

	if var_2(arg_9_0.equipSkinView) then
		local var_9_9 = arg_9_0.equipSkinScrollCom

		var_2.SetTotalCount(var_9_9, #arg_9_0.equipSkinGoods)
	end

	return
end

function var_0_1.UpdateSkinItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.skinGoods[arg_10_1 + 1]
	local var_10_1 = var_3.getDropInfo(var_10_0)
	local var_10_2 = var_3
	local var_10_3

	if not var_3.GetName(var_10_2) then
		var_10_3 = "??"
	end

	string = var_10_2

	if var_10_2.match(var_10_3, "(%d+)") then
		setText = var_6

		local var_10_4 = arg_10_2
		local var_10_5 = arg_10_2.Find(var_10_4, "skin_name")

		shortenString = var_10_4

		var_6(var_10_5, var_10_4(var_10_3, 7))
	else
		setText = var_6

		local var_10_6 = arg_10_2
		local var_10_7 = arg_10_2.Find(var_10_6, "skin_name")

		shortenString = var_10_6

		var_6(var_10_7, var_10_6(var_10_3, 8))
	end

	local var_10_8 = var_10_1
	local var_10_9 = var_10_1.getConfig(var_10_8, "ship_group")

	tonumber = var_10_8

	local var_10_10 = var_10_8(var_10_9 .. "1")

	setText = var_8

	local var_10_11 = arg_10_2
	local var_10_12 = arg_10_2.Find(var_10_11, "name")

	pg = var_10_11

	var_8(var_10_12, var_10_11.ship_data_statistics[var_10_10].name)

	setText = var_8

	var_8(arg_10_2:Find("buy/Text"), var_3:GetPrice())

	local var_10_13 = arg_10_2:Find("icon_mask/painting")
	local var_10_14 = var_10_1
	local var_10_15 = var_10_1.getConfig(var_10_14, "painting")

	retPaintingPrefab = var_10_14

	var_10_14(var_10_13, var_10_15, "pifu")

	setPaintingPrefabAsync = var_10_14

	var_10_14(var_10_13, var_10_15, "pifu", function()
		setLocalPosition = var_2_10000

		var_2_10000(var_10_13, {
			x = 0,
			y = 40
		})

		arg_10_0.paintingList[var_10_15] = var_10_13

		return
	end)

	local var_10_16 = var_3
	local var_10_17 = var_3.canPurchase(var_10_16)

	setActive = var_10_16

	var_10_16(arg_10_2:Find("mask"), not var_10_17)

	onButton = var_10_16

	local var_10_18 = arg_10_0
	local var_10_19 = arg_10_2

	local function var_10_20()
		if not var_10_17 then
			return
		end

		pg = var_0

		local var_12_0 = var_0.NewStyleMsgboxMgr.GetInstance()
		local var_12_1 = var_0.Show

		pg = var_2_10002

		local var_12_2 = var_2_10002.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX
		local var_12_3 = {}

		i18n = var_2_10004

		local var_12_4 = "charge_scene_buy_confirm"
		local var_12_5 = var_0
		local var_12_6 = var_6.GetPrice(var_12_5)
		local var_12_7 = var_0

		var_12_3.contentText = var_2_10004(var_12_4, var_12_6, var_7.GetName(var_12_7))

		function var_12_3.onConfirm()
			getProxy = var_3_10000
			PlayerProxy = var_3_10001

			local var_13_0 = var_3_10000(var_3_10001)
			local var_13_1 = var_0.getData(var_13_0)
			local var_13_2 = var_0.getTotalGem(var_13_1)
			local var_13_3 = var_0

			if var_13_2 < var_1.GetPrice(var_13_3) then
				pg = var_13_2

				local var_13_4 = var_13_2.TipsMgr.GetInstance()
				local var_13_5 = var_0.ShowTips

				i18n = var_13_3

				var_13_5(var_13_4, var_13_3("common_no_resource"))

				return
			end

			local var_13_6 = arg_10_0
			local var_13_7 = var_0.emit

			WorldCruiseMediator = var_13_3

			var_13_7(var_13_6, var_13_3.ON_CRUISE_SHOPPING, var_0.id, 1)

			return
		end

		var_12_1(var_12_0, var_12_2, var_12_3)

		return
	end

	SFX_CONFIRM = var_1_10015

	var_10_16(var_10_18, var_10_19, var_10_20, var_1_10015)

	return
end

function var_0_1.UpdateEquipSkinItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.equipSkinGoods[arg_14_1 + 1]
	local var_14_1 = var_3.getDropInfo(var_14_0)

	updateDrop = var_14_0

	var_14_0(arg_14_2:Find("IconTpl"), var_14_1)

	local var_14_2 = var_3
	local var_14_3

	if not var_3.GetName(var_14_2) then
		var_14_3 = "??"
	end

	string = var_14_2

	if var_14_2.match(var_14_3, "(%d+)") then
		setText = var_6

		local var_14_4 = arg_14_2
		local var_14_5 = arg_14_2.Find(var_14_4, "name")

		shortenString = var_14_4

		var_6(var_14_5, var_14_4(var_14_3, 5))
	else
		setText = var_6

		local var_14_6 = arg_14_2
		local var_14_7 = arg_14_2.Find(var_14_6, "name")

		shortenString = var_14_6

		var_6(var_14_7, var_14_6(var_14_3, 6))
	end

	setText = var_6

	var_6(arg_14_2:Find("buy/Text"), var_3:GetPrice())

	setText = var_6

	local var_14_8 = arg_14_2
	local var_14_9 = arg_14_2.Find(var_14_8, "Text")

	i18n = var_14_8

	local var_14_10 = var_14_8("common_already owned")

	string = var_9

	var_6(var_14_9, var_14_10 .. var_9.format("%s/%s", var_3:GetOwnedCnt(), var_3:getLimitCount()))

	local var_14_11 = var_3
	local var_14_12 = var_3.canPurchase(var_14_11)

	setActive = var_14_11

	var_14_11(arg_14_2:Find("mask"), not var_14_12)

	onButton = var_14_11

	local var_14_13 = arg_14_0
	local var_14_14 = arg_14_2

	local function var_14_15()
		if not var_14_12 then
			return
		end

		local function var_15_0()
			local var_16_0, var_16_1

			if arg_14_0.remainCnt <= 0 then
				pg = var_16_1
				var_16_0 = var_16_1.TipsMgr.GetInstance()
				var_16_1 = var_16_1.ShowTips
				i18n = var_3_10002

				var_16_1(var_16_0, var_3_10002("cruise_limit_count"))

				return
			end

			getProxy = var_16_1
			PlayerProxy = var_16_0

			local var_16_2 = var_16_1(var_16_0)
			local var_16_3 = var_0.getData(var_16_2)
			local var_16_4 = var_0.getTotalGem(var_16_3)
			local var_16_5 = var_0

			if var_16_4 < var_1.GetPrice(var_16_5) then
				pg = var_16_4

				local var_16_6 = var_16_4.TipsMgr.GetInstance()
				local var_16_7 = var_0.ShowTips

				i18n = var_16_5

				var_16_7(var_16_6, var_16_5("common_no_resource"))

				return
			end

			local var_16_8 = arg_14_0
			local var_16_9 = var_0.emit

			WorldCruiseMediator = var_16_5

			var_16_9(var_16_8, var_16_5.ON_CRUISE_SHOPPING, var_0.id, 1)

			return
		end

		pg = var_2_10001

		local var_15_1 = var_2_10001.NewStyleMsgboxMgr.GetInstance()
		local var_15_2 = var_1.Show

		pg = var_2_10003

		local var_15_3 = var_2_10003.NewStyleMsgboxMgr.TYPE_COMMON_DROP
		local var_15_4 = {
			drop = var_14_1
		}
		local var_15_5 = {}
		local var_15_6 = {}

		pg = var_2_10007
		var_15_6.type = var_2_10007.NewStyleMsgboxMgr.BUTTON_TYPE.cancel
		i18n = var_7
		var_15_6.name = var_7("msgbox_text_cancel")
		SFX_CANCEL = var_7
		var_15_6.sound = var_7
		var_15_5[1] = var_15_6

		local var_15_7 = {}

		pg = var_7
		var_15_7.type = var_7.NewStyleMsgboxMgr.BUTTON_TYPE.confirm
		i18n = var_7
		var_15_7.name = var_7("text_exchange")
		var_15_7.func = var_15_0
		SFX_CONFIRM = var_7
		var_15_7.sound = var_7
		var_15_5[2] = var_15_7
		var_15_4.btnList = var_15_5

		var_15_2(var_15_1, var_15_3, var_15_4)

		return
	end

	SFX_CONFIRM = var_11

	var_14_11(var_14_13, var_14_14, var_14_15, var_11)

	return
end

function var_0_1.OnDestroy(arg_17_0)
	pairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0.paintingList) do
		setLocalPosition = var_1_10006

		var_1_10006(iter_17_1, {
			x = 0,
			y = 0
		})

		retPaintingPrefab = var_1_10006

		var_1_10006(iter_17_1, iter_17_0)
	end

	return
end

return var_0_1
