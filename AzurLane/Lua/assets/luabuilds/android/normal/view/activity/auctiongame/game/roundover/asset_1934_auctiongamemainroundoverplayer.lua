class = var_0_10000

local var_0_0 = "AuctionGameMainRoundOverPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.uiSuccessStateText

	i18n = var_1_10003

	var_1_10001(var_2_0, var_1_10003("auction_main_win"))

	setText = var_1_10001

	local var_2_1 = arg_2_0.uiFailStateText

	i18n = var_3

	var_1_10001(var_2_1, var_3("auction_main_fail"))

	return
end

function var_0_1.didEnter(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	AuctionGameProxy = var_1_10003

	local var_3_0 = var_1_10002(var_1_10003)
	local var_3_1 = var_2.GetPlayerVO(var_3_0, arg_3_1.playerID)

	setScrollText = var_3_0

	var_3_0(arg_3_0.uiNameText, var_3_1.name)

	local var_3_2
	local var_3_3 = var_3_1.icon

	AuctionGameConst = var_6

	if var_3_3 == var_6.TB_NPC_ID then
		pg = var_3_3
		var_3_2 = var_3_3.ship_skin_template[var_3_1.icon].prefab
	else
		Ship = var_3_3

		local var_3_4 = var_3_3.New({
			configId = var_3_1.icon,
			skin_id = var_3_1.skinId
		})

		var_3_2 = var_3_3.getPrefab(var_3_4)
	end

	LoadSpriteAsync = var_3_3

	var_3_3("qicon/" .. var_3_2, function(arg_4_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_3_0.uiIconImage) then
			arg_3_0.uiIconImage.sprite = arg_4_0
		end

		return
	end)

	AttireFrame = var_3_3

	local var_3_5 = var_3_3.attireFrameRes
	local var_3_6 = var_3_1
	local var_3_7 = false

	AttireConst = var_1_10008

	local var_3_8 = var_3_5(var_3_6, var_3_7, var_1_10008.TYPE_ICON_FRAME, var_3_1.propose)

	PoolMgr = var_3_6

	local var_3_9 = var_3_6.GetInstance()

	var_6.GetPrefab(var_3_9, "IconFrame/" .. var_3_8, var_3_8, true, function(arg_5_0)
		IsNil = var_2_10001

		if var_2_10001(arg_3_0.uiFrameGo) then
			return
		end

		if arg_3_0.uiFrameGo then
			arg_5_0.name = var_3_8
			findTF = var_1

			local var_5_0 = var_1(arg_5_0.transform, "icon")
			local var_5_1 = var_1.GetComponent

			typeof = var_2_10004
			Image = var_2_10005
			var_5_1(var_5_0, var_2_10004(var_2_10005)).raycastTarget = false
			setParent = var_3

			local var_5_2 = arg_5_0

			tf = var_2_10005

			var_3(var_5_2, var_2_10005(arg_3_0.uiFrameGo), false)
		else
			PoolMgr = var_1

			local var_5_3 = var_1.GetInstance()

			var_1.ReturnPrefab(var_5_3, "IconFrame/" .. var_3_8, var_3_8, arg_5_0)
		end

		return
	end)

	local var_3_10 = var_2:GetRound()
	local var_3_11 = var_3_1.id
	local var_3_12 = var_2
	local var_3_13

	if not var_2.GetRoundEventAndBidInfo(var_3_12, var_3_10, var_3_11) then
		var_3_13 = {}
	end

	setText = var_3_12

	local var_3_14 = arg_3_0.uiBidText

	StringHelper = var_11

	var_3_12(var_3_14, var_11.ForamtNumber(var_3_13.bidValue))

	AuctionGameTools = var_3_12

	if var_3_12.IsNoBid() then
		setActive = var_9

		var_9(arg_3_0.uiFailStateGo, true)

		setActive = var_9

		var_9(arg_3_0.uiSuccessStateGo, false)
	else
		AuctionGameTools = var_9

		if var_9.IsBidSuccess() then
			setActive = var_9

			var_9(arg_3_0.uiFailStateGo, false)

			setActive = var_9

			var_9(arg_3_0.uiSuccessStateGo, var_3_13.state == 1)
		else
			setActive = var_9

			var_9(arg_3_0.uiFailStateGo, false)

			setActive = var_9

			var_9(arg_3_0.uiSuccessStateGo, false)
		end
	end

	LoadSpriteAtlasAsync = var_9

	var_9("ui/auctiongameui_atlas", arg_3_1.num, function(arg_6_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_3_0.uiNumImage) then
			arg_3_0.uiNumImage.sprite = arg_6_0
		end

		return
	end)

	local var_3_15 = var_2:GetRound()
	local var_3_16

	if not var_3_13.eventID then
		var_3_16 = 501
	end

	pg = var_11

	local var_3_17 = var_11.auction_event[var_3_16]

	LoadSpriteAsync = var_12

	var_12(var_3_17.icon, function(arg_7_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_3_0.uiEventImage) then
			arg_3_0.uiEventImage.sprite = arg_7_0
		end

		return
	end)

	return
end

function var_0_1.willExit(arg_8_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_8_0.uiFrameGo) then
		tf = var_1

		if var_1(arg_8_0.uiFrameGo).childCount > 0 then
			local var_8_0 = var_1:GetChild(0).gameObject.name

			PoolMgr = var_4

			local var_8_1 = var_4.GetInstance()

			var_4.ReturnPrefab(var_8_1, "IconFrame/" .. var_8_0, var_8_0, var_2.gameObject)
		end
	end

	arg_8_0:detach()

	return
end

return var_0_1
