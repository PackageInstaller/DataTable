local AuctionGameMainRoundOverPlayer = class("AuctionGameMainRoundOverPlayer", import("view.base.BasePanel"))

function AuctionGameMainRoundOverPlayer:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameMainRoundOverPlayer.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameMainRoundOverPlayer:Init()
	setText(self.uiSuccessStateText, i18n("auction_main_win"))
	setText(self.uiFailStateText, i18n("auction_main_fail"))

	return
end

function AuctionGameMainRoundOverPlayer:didEnter(arg_3_1)
	local var_3_0 = getProxy(AuctionGameProxy)
	local var_3_1 = var_3_0:GetPlayerVO(arg_3_1.playerID)

	setScrollText(self.uiNameText, var_3_1.name)
	LoadSpriteAsync("qicon/" .. (var_3_1.icon == AuctionGameConst.TB_NPC_ID and pg.ship_skin_template[var_3_1.icon].prefab or Ship.New({
		configId = var_3_1.icon,
		skin_id = var_3_1.skinId
	}):getPrefab()), function(arg_4_0)
		if not IsNil(self.uiIconImage) then
			self.uiIconImage.sprite = arg_4_0
		end

		return
	end)

	local var_3_3 = AttireFrame.attireFrameRes(var_3_1, false, AttireConst.TYPE_ICON_FRAME, var_3_1.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_3_3, var_3_3, true, function(arg_5_0)
		if IsNil(self.uiFrameGo) then
			return
		end

		if self.uiFrameGo then
			arg_5_0.name = var_3_3
			findTF(arg_5_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_5_0, tf(self.uiFrameGo), false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_3_3, var_3_3, arg_5_0)
		end

		return
	end)

	local var_3_4 = var_3_0:GetRoundEventAndBidInfo(var_3_0:GetRound(), var_3_1.id) or {}

	setText(self.uiBidText, StringHelper.ForamtNumber(var_3_4.bidValue))

	if AuctionGameTools.IsNoBid() then
		setActive(self.uiFailStateGo, true)
		setActive(self.uiSuccessStateGo, false)
	elseif AuctionGameTools.IsBidSuccess() then
		setActive(self.uiFailStateGo, false)
		setActive(self.uiSuccessStateGo, var_3_4.state == 1)
	else
		setActive(self.uiFailStateGo, false)
		setActive(self.uiSuccessStateGo, false)
	end

	LoadSpriteAtlasAsync("ui/auctiongameui_atlas", arg_3_1.num, function(arg_6_0)
		if not IsNil(self.uiNumImage) then
			self.uiNumImage.sprite = arg_6_0
		end

		return
	end)

	local var_3_5 = var_3_0:GetRound()

	LoadSpriteAsync(pg.auction_event[var_3_4.eventID or 501].icon, function(arg_7_0)
		if not IsNil(self.uiEventImage) then
			self.uiEventImage.sprite = arg_7_0
		end

		return
	end)

	return
end

function AuctionGameMainRoundOverPlayer:willExit()
	if not IsNil(self.uiFrameGo) then
		local var_8_0 = tf(self.uiFrameGo)

		if var_8_0.childCount > 0 then
			local var_8_1 = var_8_0:GetChild(0)

			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_8_1.gameObject.name, var_8_1.gameObject.name, var_8_1.gameObject)
		end
	end

	self:detach()

	return
end

return AuctionGameMainRoundOverPlayer
