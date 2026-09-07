local AuctionGameMainRightPlayerInfo = class("AuctionGameMainRightPlayerInfo", import("view.base.BasePanel"))

function AuctionGameMainRightPlayerInfo:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameMainRightPlayerInfo.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameMainRightPlayerInfo:Init()
	setText(self.uiCompleteText, i18n("auction_main_done"))
	setText(self.uiOperateText, i18n("auction_main_doing"))
	LoadSpriteAtlasAsync("ui/auctiongameui_atlas", string.format("main_emoji_open"), function(arg_3_0)
		if not IsNil(self.uiEmojiImage) then
			self.uiEmojiImage.sprite = arg_3_0
		end

		return
	end)
	onButton(self, self.uiEmojiBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainEmojiLayer,
			mediator = AuctionGameMainEmojiMediator
		}))

		return
	end)

	return
end

function AuctionGameMainRightPlayerInfo:didEnter(arg_5_1)
	self.playerVO = arg_5_1

	setScrollText(self.uiNameText, arg_5_1.name)
	LoadSpriteAsync("qicon/" .. (arg_5_1.icon == AuctionGameConst.TB_NPC_ID and pg.ship_skin_template[arg_5_1.icon].prefab or Ship.New({
		configId = arg_5_1.icon,
		skin_id = arg_5_1.skinId
	}):getPrefab()), function(arg_6_0)
		if not IsNil(self.uiIconImage) then
			self.uiIconImage.sprite = arg_6_0
		end

		return
	end)

	local var_5_1 = AttireFrame.attireFrameRes(arg_5_1, false, AttireConst.TYPE_ICON_FRAME, arg_5_1.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_5_1, var_5_1, true, function(arg_7_0)
		if IsNil(self.uiFrameGo) then
			return
		end

		if self.uiFrameGo then
			arg_7_0.name = var_5_1
			findTF(arg_7_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_7_0, tf(self.uiFrameGo), false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_5_1, var_5_1, arg_7_0)
		end

		return
	end)
	setActive(self.uiEmojiBtn, arg_5_1.id == getProxy(PlayerProxy):getPlayerId())
	self:RefreshUI()
	self:RefreshEmojiBtn()

	return
end

function AuctionGameMainRightPlayerInfo:RefreshUI()
	local var_8_0 = getProxy(AuctionGameProxy)
	local var_8_1 = self.playerVO
	local var_8_2 = var_8_0:GetPlayerOptStateList()[self.playerVO.id]
	local var_8_3 = table.keyof(var_8_0:GetLeaverList(), self.playerVO.id) or table.keyof(var_8_0:GetForfeitList(), var_8_1.id) and var_8_0:GetAuctionState() ~= AuctionGameConst.AUCTION_PHASE.PERSONAL_EVENT or var_8_2 == 1 or var_8_2 == 2

	setActive(self.uiCompleteGo, var_8_3)
	setActive(self.uiOperateGo, not var_8_3)

	return
end

function AuctionGameMainRightPlayerInfo:RefreshEmojiBtn()
	if self.playerVO.id == getProxy(PlayerProxy):getPlayerId() then
		LoadSpriteAtlasAsync("ui/auctiongameui_atlas", getProxy(AuctionGameProxy):GetSwitchEmojiFlag() == 1 and "main_emoji_close" or "main_emoji_open", function(arg_10_0)
			if not IsNil(self.uiEmojiImage) then
				self.uiEmojiImage.sprite = arg_10_0
			end

			return
		end)
	end

	return
end

function AuctionGameMainRightPlayerInfo:ShowEmoji(arg_11_1, arg_11_2)
	if self.playerVO.id ~= arg_11_1 then
		return
	end

	self:ReturnEmoji()

	self.emojiID = arg_11_2

	local var_11_0 = pg.emoji_template[arg_11_2]

	PoolMgr.GetInstance():GetPrefab("emoji/" .. pg.emoji_template[arg_11_2].pic, pg.emoji_template[arg_11_2].pic, true, function(arg_12_0)
		if not IsNil(self.uiEmojiTf) then
			arg_12_0.name = var_11_0.pic

			local var_12_0 = arg_12_0:GetComponent(typeof(Image))

			if var_12_0 then
				var_12_0.preserveAspect = true
			end

			tf(arg_12_0).anchoredPosition = Vector2.zero
			rtf(arg_12_0).sizeDelta = Vector2.New(210, 210)

			local var_12_1 = arg_12_0:GetComponent("Animator")

			if var_12_1 then
				var_12_1.enabled = false
			end

			local var_12_2 = arg_12_0:GetComponent("CriManaEffectUI")

			if var_12_2 then
				var_12_2:Pause(true)
			end

			setParent(arg_12_0, self.uiEmojiTf)

			self.emojiTf = arg_12_0
		else
			PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_11_0.pic, var_11_0.pic, arg_12_0)
		end

		return
	end)
	self:AddEmojiTimer()

	return
end

function AuctionGameMainRightPlayerInfo:ReturnEmoji()
	if not self.emojiID then
		return
	end

	if not IsNil(self.emojiTf) then
		PoolMgr.GetInstance():ReturnPrefab("emoji/" .. pg.emoji_template[self.emojiID].pic, pg.emoji_template[self.emojiID].pic, self.emojiTf)

		self.emojiTf = nil
	end

	return
end

function AuctionGameMainRightPlayerInfo:AddEmojiTimer()
	self:StopEmojiTimer()
	setActive(self.uiEmojiGo, true)

	local var_14_0 = pg.TimeMgr.GetInstance():GetServerTime() + pg.gameset.auction_emoji_duration.key_value

	self.emojiTimer = Timer.New(function()
		if var_14_0 - pg.TimeMgr.GetInstance():GetServerTime() <= 0 then
			self:StopEmojiTimer()
		end

		return
	end, 1, -1)

	self.emojiTimer:Start()

	return
end

function AuctionGameMainRightPlayerInfo:StopEmojiTimer()
	setActive(self.uiEmojiGo, false)

	if self.emojiTimer then
		self.emojiTimer:Stop()

		self.emojiTimer = nil
	end

	return
end

function AuctionGameMainRightPlayerInfo:willExit()
	self:StopEmojiTimer()
	self:ReturnEmoji()

	if not IsNil(self.uiFrameGo) then
		local var_17_0 = tf(self.uiFrameGo)

		if var_17_0.childCount > 0 then
			local var_17_1 = var_17_0:GetChild(0)

			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_17_1.gameObject.name, var_17_1.gameObject.name, var_17_1.gameObject)
		end
	end

	self:detach()

	return
end

return AuctionGameMainRightPlayerInfo
