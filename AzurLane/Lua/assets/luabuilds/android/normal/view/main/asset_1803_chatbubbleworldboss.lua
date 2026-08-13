class = var_0_10000

local var_0_0 = var_0_10000("ChatBubbleWorldBoss")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	tf = var_1_10003
	arg_1_0.tf = var_1_10003(arg_1_1)
	defaultValue = var_3
	arg_1_0.interactable = var_3(arg_1_2, true)
	findTF = var_3

	local var_1_0 = var_3(arg_1_0.tf, "desc/name")

	arg_1_0.nameTF = var_3.GetComponent(var_1_0, "Text")
	findTF = var_3
	arg_1_0.face = var_3(arg_1_0.tf, "face/content")
	findTF = var_3
	arg_1_0.circle = var_3(arg_1_0.tf, "shipicon/frame")
	findTF = var_3

	local var_1_1 = var_3(arg_1_0.tf, "time")

	arg_1_0.timeTF = var_3.GetComponent(var_1_1, "Text")
	findTF = var_3

	local var_1_2 = var_3(arg_1_0.tf, "shipicon/icon")

	arg_1_0.headTF = var_3.GetComponent(var_1_2, "Image")
	findTF = var_3
	arg_1_0.stars = var_3(arg_1_0.tf, "shipicon/stars")
	findTF = var_3
	arg_1_0.star = var_3(arg_1_0.stars, "star")
	findTF = var_3
	arg_1_0.dutyTF = var_3(arg_1_0.tf, "desc/duty")
	findTF = var_3
	arg_1_0.channel = var_3(arg_1_0.tf, "desc/channel")
	findTF = var_3
	arg_1_0.chatframe = var_3(arg_1_0.tf, "chat_fram")
	findTF = var_3

	local var_1_3 = var_3(arg_1_0.tf, "chat_fram/Text")

	arg_1_0.chatContent = var_3.GetComponent(var_1_3, "Text")
	findTF = var_3
	arg_1_0.chatframeSel = var_3(arg_1_0.tf, "chat_fram/sel")
	findTF = var_3
	arg_1_0.chatframeUnsel = var_3(arg_1_0.tf, "chat_fram/unsel")
	setActive = var_3

	var_3(arg_1_0.chatframeSel, true)

	setActive = var_3

	var_3(arg_1_0.chatframeUnsel, false)

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	if arg_2_0.data == arg_2_1 then
		return
	end

	arg_2_0.data = arg_2_1

	local var_2_0 = false

	if arg_2_1.player.icon == 0 then
		var_3.icon = 101171
	end

	local var_2_1 = var_3.propose

	arg_2_0.nameTF.text = var_3.name

	local var_2_2 = arg_2_1.timestamp

	getOfflineTimeStamp = var_6

	local var_2_3

	var_2_3.text, var_2_3 = var_6(var_2_2), arg_2_0.timeTF
	pg = var_2_3

	local var_2_4 = var_2_3.ship_data_statistics[var_3.icon]

	Ship = var_8

	local var_2_5 = var_8.New({
		configId = var_2_4.id
	})
	local var_2_6 = arg_2_0.stars.childCount
	local var_2_7 = var_2_5:getStar()

	for iter_2_0 = var_2_6, var_2_7 - 1 do
		cloneTplTo = var_1_10015

		var_1_10015(arg_2_0.star, arg_2_0.stars)
	end

	local var_2_8 = arg_2_0.stars.childCount

	for iter_2_1 = 0, var_2_8 - 1 do
		local var_2_9 = arg_2_0.stars
		local var_2_10 = var_15.GetChild(var_2_9, iter_2_1).gameObject

		var_16.SetActive(var_2_10, iter_2_1 < var_2_4.star)
	end

	local var_2_11

	if arg_2_0.channel then
		GetSpriteFromAtlas = var_11
		var_2_11 = "channel"
		ChatConst = var_13

		local var_2_12 = var_11(var_2_11, var_13.GetChannelSprite(arg_2_1.type) .. "_1920")

		setImageSprite = var_2_11

		var_2_11(arg_2_0.channel, var_2_12, true)
	end

	local var_2_13 = arg_2_0.headTF

	Color = var_2_11
	var_2_13.color = var_2_11.New(1, 1, 1, 0)
	LoadSpriteAsync = var_2_13

	local var_2_14 = "qicon/"
	local var_2_15 = var_3

	var_2_13(var_2_14 .. var_3.getPainting(var_2_15), function(arg_3_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_2_0.headTF) then
			local var_3_0 = arg_2_0.headTF

			Color = var_2
			var_3_0.color = var_2.white

			local var_3_1 = arg_2_0.headTF
			local var_3_2

			if not arg_3_0 then
				::label_3_0::

				LoadSprite = var_3_2
				var_3_2 = var_3_2("heroicon/unknown")
			end

			var_3_1.sprite = var_3_2
		end

		return
	end)

	local var_2_16

	if arg_2_0.dutyTF then
		setActive = var_2_16

		var_2_16(arg_2_0.dutyTF, var_3.duty)

		if var_3.duty then
			GetSpriteFromAtlas = var_2_16
			var_2_16 = var_2_16("dutyicon", var_3.duty)
			setImageSprite = var_12

			var_12(arg_2_0.dutyTF, var_2_16, true)
		end
	end

	AttireFrame = var_2_16

	local var_2_17 = var_2_16.attireFrameRes
	local var_2_18 = var_3
	local var_2_19 = var_2_0

	AttireConst = var_2_15

	local var_2_20 = var_2_17(var_2_18, var_2_19, var_2_15.TYPE_ICON_FRAME, var_2_1)

	PoolMgr = var_2_18

	local var_2_21 = var_2_18.GetInstance()

	var_12.GetPrefab(var_2_21, "IconFrame/" .. var_2_20, var_2_20, true, function(arg_4_0)
		IsNil = var_2_10001

		if var_2_10001(arg_2_0.tf) then
			return
		end

		if arg_2_0.circle and arg_2_0.data then
			arg_4_0.name = var_2_20
			findTF = var_1

			local var_4_0 = var_1(arg_4_0.transform, "icon")
			local var_4_1 = var_1.GetComponent

			typeof = var_2_10004
			Image = var_2_10005
			var_4_1(var_4_0, var_2_10004(var_2_10005)).raycastTarget = false
			setParent = var_3

			var_3(arg_4_0, arg_2_0.circle, false)
		else
			PoolMgr = var_1

			local var_4_2 = var_1.GetInstance()

			var_1.ReturnPrefab(var_4_2, "IconFrame/" .. var_2_20, var_2_20, arg_4_0)
		end

		return
	end)

	local var_2_22 = arg_2_1.args.wordBossId

	onButton = var_2_21

	local var_2_23
	local var_2_24 = arg_2_0.chatframe

	local function var_2_25()
		if not arg_2_0.interactable then
			pg = var_0

			local var_5_0 = var_0.TipsMgr.GetInstance()
			local var_5_1 = var_0.ShowTips

			i18n = var_2_10002

			var_5_1(var_5_0, var_2_10002("world_boss_inbattle"))

			return
		end

		local var_5_4

		if arg_2_1.args.isDeath then
			local var_5_2 = arg_2_0

			var_5_4.SetGray(var_5_2)

			pg = var_5_4

			local var_5_3 = var_5_4.TipsMgr.GetInstance()

			var_5_4 = var_5_4.ShowTips
			i18n = var_2_10002

			var_5_4(var_5_3, var_2_10002("world_boss_none"))

			return
		end

		pg = var_5_4

		local var_5_5 = var_5_4.WorldBossTipMgr.GetInstance()

		var_0.OnClick(var_5_5, "", var_2_22, arg_2_1.args.lastTime, function()
			local var_6_0 = arg_2_0

			var_0.SetGray(var_6_0)

			return
		end)

		return
	end

	SFX_PANEL = var_17

	var_2_21(var_2_23, var_2_24, var_2_25, var_17)

	if arg_2_1.args.isDeath then
		var_2_23 = arg_2_0

		arg_2_0.SetGray(var_2_23)
	end

	local var_2_26 = arg_2_0.chatContent

	i18n = var_2_23
	var_2_26.text = var_2_23("world_boss_ad", arg_2_1.args.bossName, arg_2_1.args.level)

	return
end

function var_0_0.SetGray(arg_7_0)
	setActive = var_1_10001

	var_1_10001(arg_7_0.chatframeSel, false)

	setActive = var_1_10001

	var_1_10001(arg_7_0.chatframeUnsel, true)

	return
end

function var_0_0.dispose(arg_8_0)
	removeOnButton = var_1_10001

	var_1_10001(arg_8_0.chatframe)

	if arg_8_0.circle.childCount > 0 then
		local var_8_0 = arg_8_0.circle
		local var_8_1 = var_1.GetChild(var_8_0, 0).gameObject

		PoolMgr = var_8_0

		local var_8_2 = var_8_0.GetInstance()

		var_2.ReturnPrefab(var_8_2, "IconFrame/" .. var_8_1.name, var_8_1.name, var_8_1)
	end

	return
end

return var_0_0
