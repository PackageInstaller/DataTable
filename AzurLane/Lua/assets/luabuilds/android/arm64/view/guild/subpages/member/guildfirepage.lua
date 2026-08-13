class = var_0_10000

local var_0_0 = "GuildFirePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildMemberBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "GuildFirePage"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.fireconfirmBtn = var_1.Find(var_2_0, "frame/confirm_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.firecancelBtn = var_1.Find(var_2_1, "frame/cancel_btn")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "frame/info/name/Text")
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.firenameTF = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "frame/info/shipicon/icon")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.fireiconTF = var_2_7(var_2_6, var_4(var_1_10006))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "frame/duty")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.fireduty = var_2_10(var_2_9, var_4(var_1_10006))

	local var_2_11 = arg_2_0._tf

	arg_2_0.firestarsTF = var_1.Find(var_2_11, "frame/info/shipicon/stars")

	local var_2_12 = arg_2_0._tf

	arg_2_0.firestarTF = var_1.Find(var_2_12, "frame/info/shipicon/stars/star")

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "frame/info/level/Text")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.firelevelTF = var_2_15(var_2_14, var_4(var_1_10006))

	local var_2_16 = arg_2_0._tf

	arg_2_0.circle = var_1.Find(var_2_16, "frame/info/shipicon/frame")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.firecancelBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.OnShow(arg_6_0)
	local var_6_0 = arg_6_0.guildVO
	local var_6_1 = arg_6_0.playerVO
	local var_6_2 = arg_6_0.memberVO
	local var_6_3 = arg_6_0.firenameTF

	var_6_3.text = var_6_2.name
	AttireFrame = var_6_3

	local var_6_4 = var_6_3.attireFrameRes
	local var_6_5 = var_6_2
	local var_6_6 = var_6_2.id

	getProxy = var_1_10008
	PlayerProxy = var_1_10010

	local var_6_7 = var_1_10008(var_1_10010)
	local var_6_8 = var_6_6 == var_8.getRawData(var_6_7).id

	AttireConst = var_8

	local var_6_9 = var_6_4(var_6_5, var_6_8, var_8.TYPE_ICON_FRAME, var_6_2.propose)

	PoolMgr = var_5

	local var_6_10 = var_5.GetInstance()

	var_5.GetPrefab(var_6_10, "IconFrame/" .. var_6_9, var_6_9, true, function(arg_7_0)
		IsNil = var_2_10001

		if var_2_10001(arg_6_0._tf) then
			return
		end

		if arg_6_0.circle then
			arg_7_0.name = var_6_9
			findTF = var_1

			local var_7_0 = var_1(arg_7_0.transform, "icon")
			local var_7_1 = var_1.GetComponent

			typeof = var_2_10005
			Image = var_2_10007
			var_7_1(var_7_0, var_2_10005(var_2_10007)).raycastTarget = false
			setParent = var_3

			var_3(arg_7_0, arg_6_0.circle, false)
		else
			PoolMgr = var_1

			local var_7_2 = var_1.GetInstance()

			var_1.ReturnPrefab(var_7_2, "IconFrame/" .. var_6_9, var_6_9, arg_7_0)
		end

		return
	end)

	pg = var_5

	local var_6_11 = var_5.ship_data_statistics[var_6_2.icon]

	Ship = var_6

	local var_6_12 = var_6.New({
		configId = var_6_2.icon,
		skin_id = var_6_2.skinId
	})

	LoadSpriteAsync = var_6_10

	var_6_10("qicon/" .. var_6_12:getPainting(), function(arg_8_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_6_0.fireiconTF) then
			arg_6_0.fireiconTF.sprite = arg_8_0
		end

		return
	end)

	GetSpriteFromAtlas = var_6_10

	local var_6_13 = var_6_10("dutyicon", "icon_" .. var_6_2.duty)

	arg_6_0.fireduty.sprite = var_6_13

	for iter_6_0 = arg_6_0.firestarsTF.childCount, var_6_11.star - 1 do
		cloneTplTo = var_1_10013

		var_1_10013(arg_6_0.firestarTF, arg_6_0.firestarsTF)
	end

	for iter_6_1 = 1, var_8 do
		local var_6_14 = arg_6_0.firestarsTF
		local var_6_15 = var_13.GetChild(var_6_14, iter_6_1 - 1)

		setActive = var_1_10014

		var_1_10014(var_6_15, iter_6_1 <= var_6_11.star)
	end

	local var_6_16 = arg_6_0.firelevelTF

	var_6_16.text = "Lv." .. var_6_2.level
	onButton = var_6_16

	local var_6_17 = arg_6_0
	local var_6_18 = arg_6_0.fireconfirmBtn

	local function var_6_19()
		if var_6_2.id == var_6_1.id then
			return
		end

		pg = var_0

		local var_9_0 = var_0.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		i18n = var_2_10004
		var_9_2.content = var_2_10004("guild_fire_tip")

		function var_9_2.onYes()
			local var_10_0 = arg_6_0
			local var_10_1 = var_0.emit

			GuildMemberMediator = var_3_10003

			var_10_1(var_10_0, var_3_10003.FIRE, var_6_2.id)

			local var_10_2 = arg_6_0

			var_0.Hide(var_10_2)

			return
		end

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_CONFIRM = var_1_10014

	var_6_16(var_6_17, var_6_18, var_6_19, var_1_10014)

	return
end

return var_0_1
