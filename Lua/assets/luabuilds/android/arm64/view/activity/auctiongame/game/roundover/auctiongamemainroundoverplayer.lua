local var_0_0 = class("AuctionGameMainRoundOverPlayer", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	setText(arg_2_0.uiSuccessStateText, i18n("auction_main_win"))
	setText(arg_2_0.uiFailStateText, i18n("auction_main_fail"))

	return
end

function var_0_0.didEnter(arg_3_0, arg_3_1)
	local var_3_0 = getProxy(AuctionGameProxy)
	local var_3_1 = var_3_0:GetPlayerVO(arg_3_1.playerID)

	setScrollText(arg_3_0.uiNameText, var_3_1.name)

	local var_3_2 = var_3_1.icon == AuctionGameConst.TB_NPC_ID and pg.ship_skin_template[var_3_1.icon].prefab or Ship.New({
		configId = var_3_1.icon,
		skin_id = var_3_1.skinId
	}):getPrefab()

	LoadSpriteAsync("qicon/" .. var_3_2, function(arg_4_0)
		if not IsNil(arg_3_0.uiIconImage) then
			arg_3_0.uiIconImage.sprite = arg_4_0
		end

		return
	end)

	local var_3_3 = AttireFrame.attireFrameRes(var_3_1, false, AttireConst.TYPE_ICON_FRAME, var_3_1.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_3_3, var_3_3, true, function(arg_5_0)
		if IsNil(arg_3_0.uiFrameGo) then
			return
		end

		if arg_3_0.uiFrameGo then
			arg_5_0.name = var_3_3
			findTF(arg_5_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_5_0, tf(arg_3_0.uiFrameGo), false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_3_3, var_3_3, arg_5_0)
		end

		return
	end)

	local var_3_4 = var_3_0:GetRoundEventAndBidInfo(var_3_0:GetRound(), var_3_1.id) or {}

	setText(arg_3_0.uiBidText, StringHelper.ForamtNumber(var_3_4.bidValue))

	if AuctionGameTools.IsNoBid() then
		setActive(arg_3_0.uiFailStateGo, true)
		setActive(arg_3_0.uiSuccessStateGo, false)
	elseif AuctionGameTools.IsBidSuccess() then
		setActive(arg_3_0.uiFailStateGo, false)
		setActive(arg_3_0.uiSuccessStateGo, var_3_4.state == 1)
	else
		setActive(arg_3_0.uiFailStateGo, false)
		setActive(arg_3_0.uiSuccessStateGo, false)
	end

	LoadSpriteAtlasAsync("ui/auctiongameui_atlas", arg_3_1.num, function(arg_6_0)
		if not IsNil(arg_3_0.uiNumImage) then
			arg_3_0.uiNumImage.sprite = arg_6_0
		end

		return
	end)

	local var_3_5 = var_3_0:GetRound()
	local var_3_6 = var_3_4.eventID or 501

	LoadSpriteAsync(pg.auction_event[var_3_6].icon, function(arg_7_0)
		if not IsNil(arg_3_0.uiEventImage) then
			arg_3_0.uiEventImage.sprite = arg_7_0
		end

		return
	end)

	return
end

function var_0_0.willExit(arg_8_0)
	if not IsNil(arg_8_0.uiFrameGo) then
		local var_8_0 = tf(arg_8_0.uiFrameGo)

		if var_8_0.childCount > 0 then
			local var_8_1 = var_8_0:GetChild(0)

			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_8_1.gameObject.name, var_8_1.gameObject.name, var_8_1.gameObject)
		end
	end

	arg_8_0:detach()

	return
end

return var_0_0
