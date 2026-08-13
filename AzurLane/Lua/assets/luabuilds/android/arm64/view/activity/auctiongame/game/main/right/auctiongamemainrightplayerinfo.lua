class = var_0_10000

local var_0_0 = "AuctionGameMainRightPlayerInfo"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

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

	local var_2_0 = arg_2_0.uiCompleteText

	i18n = var_1_10004

	var_1_10001(var_2_0, var_1_10004("auction_main_done"))

	setText = var_1_10001

	local var_2_1 = arg_2_0.uiOperateText

	i18n = var_4

	var_1_10001(var_2_1, var_4("auction_main_doing"))

	LoadSpriteAtlasAsync = var_1_10001

	local var_2_2 = "ui/auctiongameui_atlas"

	string = var_4

	var_1_10001(var_2_2, var_4.format("main_emoji_open"), function(arg_3_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_2_0.uiEmojiImage) then
			arg_2_0.uiEmojiImage.sprite = arg_3_0
		end

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.uiEmojiBtn, function()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		BaseUI = var_2_10003

		local var_4_2 = var_2_10003.ON_ADD_SUBLAYER

		Context = var_2_10004

		local var_4_3 = var_2_10004.New
		local var_4_4 = {}

		AuctionGameMainEmojiLayer = var_2_10007
		var_4_4.viewComponent = var_2_10007
		AuctionGameMainEmojiMediator = var_2_10007
		var_4_4.mediator = var_2_10007

		var_4_1(var_4_0, var_4_2, var_4_3(var_4_4))

		return
	end)

	return
end

function var_0_1.didEnter(arg_5_0, arg_5_1)
	arg_5_0.playerVO = arg_5_1
	setScrollText = var_1_10002

	var_1_10002(arg_5_0.uiNameText, arg_5_1.name)

	local var_5_0
	local var_5_1 = arg_5_1.icon

	AuctionGameConst = var_4

	if var_5_1 == var_4.TB_NPC_ID then
		pg = var_5_1
		var_5_0 = var_5_1.ship_skin_template[arg_5_1.icon].prefab
	else
		Ship = var_5_1

		local var_5_2 = var_5_1.New({
			configId = arg_5_1.icon,
			skin_id = arg_5_1.skinId
		})

		var_5_0 = var_5_1.getPrefab(var_5_2)
	end

	LoadSpriteAsync = var_5_1

	var_5_1("qicon/" .. var_5_0, function(arg_6_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_5_0.uiIconImage) then
			arg_5_0.uiIconImage.sprite = arg_6_0
		end

		return
	end)

	AttireFrame = var_5_1

	local var_5_3 = var_5_1.attireFrameRes
	local var_5_4 = arg_5_1
	local var_5_5 = false

	AttireConst = var_1_10007

	local var_5_6 = var_5_3(var_5_4, var_5_5, var_1_10007.TYPE_ICON_FRAME, arg_5_1.propose)

	PoolMgr = var_4

	local var_5_7 = var_4.GetInstance()

	var_4.GetPrefab(var_5_7, "IconFrame/" .. var_5_6, var_5_6, true, function(arg_7_0)
		IsNil = var_2_10001

		if var_2_10001(arg_5_0.uiFrameGo) then
			return
		end

		if arg_5_0.uiFrameGo then
			arg_7_0.name = var_5_6
			findTF = var_1

			local var_7_0 = var_1(arg_7_0.transform, "icon")
			local var_7_1 = var_1.GetComponent

			typeof = var_2_10005
			Image = var_2_10007
			var_7_1(var_7_0, var_2_10005(var_2_10007)).raycastTarget = false
			setParent = var_3

			local var_7_2 = arg_7_0

			tf = var_2_10006

			var_3(var_7_2, var_2_10006(arg_5_0.uiFrameGo), false)
		else
			PoolMgr = var_1

			local var_7_3 = var_1.GetInstance()

			var_1.ReturnPrefab(var_7_3, "IconFrame/" .. var_5_6, var_5_6, arg_7_0)
		end

		return
	end)

	setActive = var_4

	local var_5_8 = arg_5_0.uiEmojiBtn
	local var_5_9 = arg_5_1.id

	getProxy = var_8
	PlayerProxy = var_10

	local var_5_10 = var_8(var_10)

	var_4(var_5_8, var_5_9 == var_8.getPlayerId(var_5_10))
	arg_5_0:RefreshUI()
	arg_5_0:RefreshEmojiBtn()

	return
end

function var_0_1.RefreshUI(arg_8_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)
	local var_8_1 = arg_8_0.playerVO
	local var_8_2 = var_8_0
	local var_8_3 = var_8_0.GetPlayerOptStateList(var_8_2)[var_8_1.id]

	table = var_8_2

	if not var_8_2.keyof(var_8_0:GetLeaverList(), var_8_1.id) then
		table = var_8_4

		if var_8_4.keyof(var_8_0:GetForfeitList(), var_8_1.id) then
			local var_8_4 = var_8_0:GetAuctionState()

			AuctionGameConst = var_1_10006

			if var_8_4 == var_1_10006.AUCTION_PHASE.PERSONAL_EVENT then
				if var_8_3 ~= 1 and var_8_3 ~= 2 then
					var_8_4 = false

					goto label_8_0
				end
			end

			var_8_4 = true

			::label_8_0::

			setActive = var_1_10006

			var_1_10006(arg_8_0.uiCompleteGo, var_8_4)

			setActive = var_1_10006

			var_1_10006(arg_8_0.uiOperateGo, not var_8_4)

			return
		end
	end
end

function var_0_1.RefreshEmojiBtn(arg_9_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)
	local var_9_1 = var_1.GetSwitchEmojiFlag(var_9_0)
	local var_9_2 = arg_9_0.playerVO.id

	getProxy = var_9_0
	PlayerProxy = var_1_10006

	local var_9_3 = var_9_0(var_1_10006)

	if var_9_2 == var_4.getPlayerId(var_9_3) then
		LoadSpriteAtlasAsync = var_9_2

		var_9_2("ui/auctiongameui_atlas", var_9_1 == 1 and "main_emoji_close" or "main_emoji_open", function(arg_10_0)
			IsNil = var_2_10001

			if not var_2_10001(arg_9_0.uiEmojiImage) then
				arg_9_0.uiEmojiImage.sprite = arg_10_0
			end

			return
		end)
	end

	return
end

function var_0_1.ShowEmoji(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.playerVO.id ~= arg_11_1 then
		return
	end

	arg_11_0:ReturnEmoji()

	arg_11_0.emojiID = arg_11_2
	pg = var_3

	local var_11_0 = var_3.emoji_template[arg_11_2]

	PoolMgr = var_1_10004

	local var_11_1 = var_1_10004.GetInstance()

	var_4.GetPrefab(var_11_1, "emoji/" .. var_11_0.pic, var_11_0.pic, true, function(arg_12_0)
		IsNil = var_2_10001

		local var_12_1

		if not var_2_10001(arg_11_0.uiEmojiTf) then
			arg_12_0.name = var_11_0.pic

			local var_12_0 = arg_12_0

			var_12_1 = arg_12_0.GetComponent
			typeof = var_2_10004
			Image = var_2_10006

			if var_12_1(var_12_0, var_2_10004(var_2_10006)) then
				var_12_1.preserveAspect = true
			end

			tf = var_2_10002

			local var_12_2 = var_2_10002(arg_12_0)

			Vector2 = var_12_0
			var_12_2.anchoredPosition = var_12_0.zero
			rtf = var_12_2

			local var_12_3 = var_12_2(arg_12_0)

			Vector2 = var_3
			var_12_3.sizeDelta = var_3.New(210, 210)

			if arg_12_0:GetComponent("Animator") then
				var_2.enabled = false
			end

			if arg_12_0:GetComponent("CriManaEffectUI") then
				var_2:Pause(true)
			end

			setParent = var_3

			var_3(arg_12_0, arg_11_0.uiEmojiTf)

			arg_11_0.emojiTf = arg_12_0
		else
			PoolMgr = var_12_1

			local var_12_4 = var_12_1.GetInstance()

			var_1.ReturnPrefab(var_12_4, "emoji/" .. var_11_0.pic, var_11_0.pic, arg_12_0)
		end

		return
	end)
	arg_11_0:AddEmojiTimer()

	return
end

function var_0_1.ReturnEmoji(arg_13_0)
	if not arg_13_0.emojiID then
		return
	end

	IsNil = var_1

	if not var_1(arg_13_0.emojiTf) then
		pg = var_1

		local var_13_0 = var_1.emoji_template[arg_13_0.emojiID]

		PoolMgr = var_2

		local var_13_1 = var_2.GetInstance()

		var_2.ReturnPrefab(var_13_1, "emoji/" .. var_13_0.pic, var_13_0.pic, arg_13_0.emojiTf)

		arg_13_0.emojiTf = nil
	end

	return
end

function var_0_1.AddEmojiTimer(arg_14_0)
	arg_14_0:StopEmojiTimer()

	setActive = var_1

	var_1(arg_14_0.uiEmojiGo, true)

	pg = var_1

	local var_14_0 = var_1.TimeMgr.GetInstance()
	local var_14_1 = var_1.GetServerTime(var_14_0)

	pg = var_1_10002

	local var_14_2 = var_14_1 + var_1_10002.gameset.auction_emoji_duration.key_value

	Timer = var_2
	arg_14_0.emojiTimer = var_2.New(function()
		local var_15_0 = var_14_2

		pg = var_2_10001

		local var_15_1 = var_2_10001.TimeMgr.GetInstance()

		if var_15_0 - var_1.GetServerTime(var_15_1) <= 0 then
			local var_15_2 = arg_14_0

			var_0.StopEmojiTimer(var_15_2)
		end

		return
	end, 1, -1)

	local var_14_3 = arg_14_0.emojiTimer

	var_2.Start(var_14_3)

	return
end

function var_0_1.StopEmojiTimer(arg_16_0)
	setActive = var_1_10001

	var_1_10001(arg_16_0.uiEmojiGo, false)

	if arg_16_0.emojiTimer then
		local var_16_0 = arg_16_0.emojiTimer

		var_1.Stop(var_16_0)

		arg_16_0.emojiTimer = nil
	end

	return
end

function var_0_1.willExit(arg_17_0)
	arg_17_0:StopEmojiTimer()
	arg_17_0:ReturnEmoji()

	IsNil = var_1

	if not var_1(arg_17_0.uiFrameGo) then
		tf = var_1

		if var_1(arg_17_0.uiFrameGo).childCount > 0 then
			local var_17_0 = var_1
			local var_17_1 = var_1.GetChild(var_17_0, 0).gameObject.name

			PoolMgr = var_17_0

			local var_17_2 = var_17_0.GetInstance()

			var_4.ReturnPrefab(var_17_2, "IconFrame/" .. var_17_1, var_17_1, var_2.gameObject)
		end
	end

	arg_17_0:detach()

	return
end

return var_0_1
