local var_0_0 = class("AuctionGameMainEmojiItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiBtn, function()
		local var_3_0 = getProxy(AuctionGameProxy)

		if var_3_0:GetSwitchEmojiFlag() == 1 then
			return
		end

		if var_3_0:GetSendEmojiTimestamp() + pg.gameset.auction_emoji_duration.key_value > pg.TimeMgr.GetInstance():GetServerTime() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("donot_send_emoji_frequently"))

			return
		end

		arg_2_0:emit(AuctionGameMainEmojiMediator.ON_CLICK_EMOJI, arg_2_0.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_4_0, arg_4_1)
	arg_4_0:ReturnEmoji()

	arg_4_0.id = arg_4_1

	PoolMgr.GetInstance():GetPrefab("emoji/" .. pg.emoji_template[arg_4_1].pic, pg.emoji_template[arg_4_1].pic, true, function(arg_5_0)
		if not IsNil(arg_4_0._tf) then
			arg_5_0.name = var_0.pic

			local var_5_0 = arg_5_0:GetComponent(typeof(Image))

			if var_5_0 then
				var_5_0.preserveAspect = true
			end

			tf(arg_5_0).anchoredPosition = Vector2.zero
			rtf(arg_5_0).sizeDelta = Vector2.New(210, 210)

			local var_5_1 = arg_5_0:GetComponent("Animator")

			if var_5_1 then
				var_5_1.enabled = false
			end

			local var_5_2 = arg_5_0:GetComponent("CriManaEffectUI")

			if var_5_2 then
				var_5_2:Pause(true)
			end

			setParent(arg_5_0, arg_4_0._tf)

			arg_4_0.emojiTf = arg_5_0
		else
			PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_0.pic, var_0.pic, arg_5_0)
		end

		return
	end)
	arg_4_0:Show(true)

	return
end

function var_0_0.ReturnEmoji(arg_6_0)
	if not arg_6_0.id then
		return
	end

	if not IsNil(arg_6_0.emojiTf) then
		PoolMgr.GetInstance():ReturnPrefab("emoji/" .. pg.emoji_template[arg_6_0.id].pic, pg.emoji_template[arg_6_0.id].pic, arg_6_0.emojiTf)

		arg_6_0.emojiTf = nil
	end

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	setActive(arg_7_0._go, arg_7_1)

	return
end

function var_0_0.willExit(arg_8_0)
	arg_8_0:ReturnEmoji()
	arg_8_0:detach()
	Object.Destroy(arg_8_0._go)

	return
end

return var_0_0
