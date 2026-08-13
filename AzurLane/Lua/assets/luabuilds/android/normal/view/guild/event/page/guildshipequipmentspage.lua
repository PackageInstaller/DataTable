class = var_0_10000

local var_0_0 = "GuildShipEquipmentsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "GuildShipEquipmentsPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/ship_info/shipname")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.shipNameTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/ship_info/username")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.userNameTxt = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "frame/ship_info/ship_type")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.shipTypeIcon = var_2_8(var_2_7, var_3(var_1_10004))
	UIItemList = var_1

	local var_2_9 = var_1.New
	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "frame/ship_info/stars")
	local var_2_12 = arg_2_0._tf

	arg_2_0.shipStarList = var_2_9(var_2_11, var_3.Find(var_2_12, "frame/ship_info/stars/star_tpl"))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "frame/ship_info/lv/Text")
	local var_2_15 = var_1.GetComponent

	typeof = var_3
	Text = var_2_12
	arg_2_0.shipLvTxt = var_2_15(var_2_14, var_3(var_2_12))
	UIItemList = var_1

	local var_2_16 = var_1.New
	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_2.Find(var_2_17, "frame/equipemtns")
	local var_2_19 = arg_2_0._tf

	arg_2_0.equipmentList = var_2_16(var_2_18, var_3.Find(var_2_19, "frame/equipemtns/equipment_tpl"))
	getProxy = var_1
	PlayerProxy = var_2_18

	local var_2_20 = var_1(var_2_18)

	arg_2_0.playerId = var_1.getRawData(var_2_20).id

	local var_2_21 = arg_2_0._tf

	arg_2_0.nextBtn = var_1.Find(var_2_21, "frame/next")

	local var_2_22 = arg_2_0._tf

	arg_2_0.prevBtn = var_1.Find(var_2_22, "frame/prev")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.nextBtn

	local function var_3_5()
		if arg_3_0.onNext then
			arg_3_0.onNext()
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.prevBtn

	local function var_3_8()
		if arg_3_0.onPrev then
			arg_3_0.onPrev()
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.SetCallBack(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.onPrev = arg_7_1
	arg_7_0.onNext = arg_7_2

	return
end

function var_0_1.Show(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	var_0_1.super.Show(arg_8_0)

	arg_8_0.OnHide = arg_8_3

	if arg_8_4 then
		arg_8_4()
	end

	arg_8_0:Flush(arg_8_1, arg_8_2)

	pg = var_5

	local var_8_0 = var_5.UIMgr.GetInstance()

	var_5.BlurPanel(var_8_0, arg_8_0._tf)

	setActive = var_5

	var_5(arg_8_0.nextBtn, arg_8_0.onNext ~= nil)

	SetActive = var_5

	var_5(arg_8_0.prevBtn, arg_8_0.onPrev ~= nil)

	return
end

function var_0_1.Flush(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.ship = arg_9_1
	arg_9_0.member = arg_9_2

	arg_9_0:UpdateShipInfo()
	arg_9_0:UpdateEquipments()

	return
end

function var_0_1.Refresh(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:Flush(arg_10_1, arg_10_2)

	return
end

function var_0_1.UpdateShipInfo(arg_11_0)
	local var_11_0 = arg_11_0.ship
	local var_11_1 = arg_11_0.member

	arg_11_0.shipNameTxt.text = var_11_0:getName()

	local var_11_2

	if arg_11_0.playerId == var_11_1.id then
		var_11_2 = ""
	else
		i18n = var_11_2
		var_11_2 = var_11_2("guild_ship_from") .. var_11_1.name
	end

	local var_11_3 = arg_11_0.userNameTxt

	var_11_3.text = var_11_2
	pg = var_11_3

	local var_11_4 = var_11_3.ship_data_statistics[var_11_0.configId]
	local var_11_5 = arg_11_0.shipTypeIcon

	GetSpriteFromAtlas = var_1_10006

	local var_11_6 = "shiptype"

	shipType2print = var_1_10008
	var_11_5.sprite = var_1_10006(var_11_6, var_1_10008(var_11_4.type))

	local var_11_7 = var_11_0:getMaxStar()
	local var_11_8 = var_11_0:getStar()
	local var_11_9 = arg_11_0.shipStarList

	var_7.make(var_11_9, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			setActive = var_3

			var_3(arg_12_2:Find("star_tpl"), arg_12_1 <= var_11_8)
		end

		return
	end)

	local var_11_10 = arg_11_0.shipStarList

	var_7.align(var_11_10, var_11_7)

	arg_11_0.shipLvTxt.text = var_11_0.level

	return
end

function var_0_1.UpdateEquipments(arg_13_0)
	local var_13_0 = arg_13_0.ship
	local var_13_1 = var_1.getActiveEquipments(var_13_0)
	local var_13_2 = arg_13_0.equipmentList

	var_3.make(var_13_2, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = var_13_1[arg_14_1 + 1]

			setActive = var_4

			var_4(arg_14_2:Find("info"), var_14_0)

			setActive = var_4

			var_4(arg_14_2:Find("empty"), not var_14_0)

			if var_14_0 then
				updateEquipment = var_4

				var_4(arg_14_2:Find("info"), var_14_0)

				setText = var_4

				local var_14_1 = arg_14_2
				local var_14_2 = arg_14_2.Find(var_14_1, "info/name_bg/Text")

				shortenString = var_14_1

				var_4(var_14_2, var_14_1(var_14_0:getConfig("name"), 5))
			end
		end

		return
	end)

	local var_13_3 = arg_13_0.equipmentList

	var_3.align(var_13_3, 5)

	return
end

function var_0_1.Hide(arg_15_0)
	var_0_1.super.Hide(arg_15_0)

	pg = var_1

	local var_15_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_15_0, arg_15_0._tf, arg_15_0._parentTf)

	if arg_15_0.OnHide then
		arg_15_0.OnHide()

		arg_15_0.OnHide = nil
	end

	return
end

function var_0_1.OnDestroy(arg_16_0)
	arg_16_0:Hide()

	return
end

return var_0_1
