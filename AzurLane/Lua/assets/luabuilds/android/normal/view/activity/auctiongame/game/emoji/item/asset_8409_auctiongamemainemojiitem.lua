class = var_0_10000

local var_0_0 = "AuctionGameMainEmojiItem"

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
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiBtn

	local function var_2_2()
		getProxy = var_2_10000
		AuctionGameProxy = var_2_10001

		local var_3_0 = var_2_10000(var_2_10001)

		if var_0.GetSwitchEmojiFlag(var_3_0) == 1 then
			return
		end

		local var_3_1 = var_0
		local var_3_2 = var_0.GetSendEmojiTimestamp(var_3_1)

		pg = var_3_1

		local var_3_3 = var_3_2 + var_3_1.gameset.auction_emoji_duration.key_value

		pg = var_2

		local var_3_4 = var_2.TimeMgr.GetInstance()

		if var_3_3 > var_2.GetServerTime(var_3_4) then
			pg = var_3_3

			local var_3_5 = var_3_3.TipsMgr.GetInstance()
			local var_3_6 = var_1.ShowTips

			i18n = var_3_4

			var_3_6(var_3_5, var_3_4("donot_send_emoji_frequently"))

			return
		end

		local var_3_7 = arg_2_0
		local var_3_8 = var_1.emit

		AuctionGameMainEmojiMediator = var_3_4

		var_3_8(var_3_7, var_3_4.ON_CLICK_EMOJI, arg_2_0.id)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	return
end

function var_0_1.didEnter(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0

	arg_4_0.ReturnEmoji(var_4_0)

	arg_4_0.id = arg_4_1
	pg = var_2

	local var_4_1 = var_2.emoji_template[arg_4_1]

	PoolMgr = var_4_0

	local var_4_2 = var_4_0.GetInstance()

	var_3.GetPrefab(var_4_2, "emoji/" .. var_4_1.pic, var_4_1.pic, true, function(arg_5_0)
		IsNil = var_2_10001

		local var_5_1

		if not var_2_10001(arg_4_0._tf) then
			arg_5_0.name = var_4_1.pic

			local var_5_0 = arg_5_0

			var_5_1 = arg_5_0.GetComponent
			typeof = var_2_10003
			Image = var_2_10004

			if var_5_1(var_5_0, var_2_10003(var_2_10004)) then
				var_5_1.preserveAspect = true
			end

			tf = var_5_0

			local var_5_2 = var_5_0(arg_5_0)

			Vector2 = var_3
			var_5_2.anchoredPosition = var_3.zero
			rtf = var_5_2

			local var_5_3 = var_5_2(arg_5_0)

			Vector2 = var_3
			var_5_3.sizeDelta = var_3.New(210, 210)

			if arg_5_0:GetComponent("Animator") then
				var_2.enabled = false
			end

			if arg_5_0:GetComponent("CriManaEffectUI") then
				var_2:Pause(true)
			end

			setParent = var_3

			var_3(arg_5_0, arg_4_0._tf)

			arg_4_0.emojiTf = arg_5_0
		else
			PoolMgr = var_5_1

			local var_5_4 = var_5_1.GetInstance()

			var_1.ReturnPrefab(var_5_4, "emoji/" .. var_4_1.pic, var_4_1.pic, arg_5_0)
		end

		return
	end)
	arg_4_0:Show(true)

	return
end

function var_0_1.ReturnEmoji(arg_6_0)
	if not arg_6_0.id then
		return
	end

	IsNil = var_1

	if not var_1(arg_6_0.emojiTf) then
		pg = var_1

		local var_6_0 = var_1.emoji_template[arg_6_0.id]

		PoolMgr = var_2

		local var_6_1 = var_2.GetInstance()

		var_2.ReturnPrefab(var_6_1, "emoji/" .. var_6_0.pic, var_6_0.pic, arg_6_0.emojiTf)

		arg_6_0.emojiTf = nil
	end

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	setActive = var_1_10002

	var_1_10002(arg_7_0._go, arg_7_1)

	return
end

function var_0_1.willExit(arg_8_0)
	arg_8_0:ReturnEmoji()
	arg_8_0:detach()

	Object = var_1

	var_1.Destroy(arg_8_0._go)

	return
end

return var_0_1
