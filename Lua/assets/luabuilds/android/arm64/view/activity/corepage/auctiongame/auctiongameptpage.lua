local var_0_0 = class("AuctionGamePtPage", import("view.activity.CorePage.CorePageNewPtTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.get = arg_1_0.bg:Find("PT_bg/Text")
	arg_1_0.playerInfo = arg_1_0.bg:Find("playerInfo")
	arg_1_0.playerFrame = arg_1_0.playerInfo:Find("frame")
	arg_1_0.playerIcon = arg_1_0.playerInfo:Find("frame/icon")
	arg_1_0.playerName = arg_1_0.playerInfo:Find("name")
	arg_1_0.playerCount = arg_1_0.playerInfo:Find("count")

	setText(arg_1_0.bg:Find("tip"), i18n("auction_pt_info"))
	setText(arg_1_0.bg:Find("get_btn/text"), i18n("auction_signin_collect"))
	setText(arg_1_0.bg:Find("PT_bg/Text"), i18n("auction_pt_tip"))

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	var_0_0.super.OnUpdateFlush(arg_3_0)
	arg_3_0:setPlayerInfo()
	setActive(arg_3_0.getBtnGray, false)
	setActive(arg_3_0.getBtn, true)
	setGray(arg_3_0.getBtn, arg_3_0.ptData:GetMaxAvailableTargetIndex() == arg_3_0.ptData:GetLevel())

	return
end

function var_0_0.setPlayerInfo(arg_4_0)
	local var_4_9000
	local var_4_0 = getProxy(PlayerProxy)
	local var_4_1 = var_4_0.getRawData(var_4_9000)

	GetImageSpriteFromAtlasAsync("SquareIcon/" .. getProxy(BayProxy).GetShipPhantom(var_4_0, var_4_1:GetShipPhantomMarks()[1]):getPainting(), "", arg_4_0.playerIcon)
	setText(arg_4_0.playerName, var_4_1.name)
	setText(arg_4_0.playerCount, StringHelper.ForamtNumberK(AuctionGameTools.GetCurrencyCnt()))

	return
end

return var_0_0
