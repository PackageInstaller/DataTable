local AuctionGameMainEmojiItem = class("AuctionGameMainEmojiItem", import("view.base.BasePanel"))

function AuctionGameMainEmojiItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameMainEmojiItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameMainEmojiItem:Init()
	onButton(self, self.uiBtn, function()
		local var_3_0 = getProxy(AuctionGameProxy)

		if var_3_0:GetSwitchEmojiFlag() == 1 then
			return
		end

		if var_3_0:GetSendEmojiTimestamp() + pg.gameset.auction_emoji_duration.key_value > pg.TimeMgr.GetInstance():GetServerTime() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("donot_send_emoji_frequently"))

			return
		end

		self:emit(AuctionGameMainEmojiMediator.ON_CLICK_EMOJI, self.id)

		return
	end, SFX_PANEL)

	return
end

function AuctionGameMainEmojiItem:didEnter(arg_4_1)
	self:ReturnEmoji()

	self.id = arg_4_1

	local var_4_0 = pg.emoji_template[arg_4_1]

	PoolMgr.GetInstance():GetPrefab("emoji/" .. pg.emoji_template[arg_4_1].pic, pg.emoji_template[arg_4_1].pic, true, function(arg_5_0)
		if not IsNil(self._tf) then
			arg_5_0.name = var_4_0.pic

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

			setParent(arg_5_0, self._tf)

			self.emojiTf = arg_5_0
		else
			PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_4_0.pic, var_4_0.pic, arg_5_0)
		end

		return
	end)
	self:Show(true)

	return
end

function AuctionGameMainEmojiItem:ReturnEmoji()
	if not self.id then
		return
	end

	if not IsNil(self.emojiTf) then
		PoolMgr.GetInstance():ReturnPrefab("emoji/" .. pg.emoji_template[self.id].pic, pg.emoji_template[self.id].pic, self.emojiTf)

		self.emojiTf = nil
	end

	return
end

function AuctionGameMainEmojiItem:Show(arg_7_1)
	setActive(self._go, arg_7_1)

	return
end

function AuctionGameMainEmojiItem:willExit()
	self:ReturnEmoji()
	self:detach()
	Object.Destroy(self._go)

	return
end

return AuctionGameMainEmojiItem
