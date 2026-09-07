local AuctionGamePtPage = class("AuctionGamePtPage", import("view.activity.CorePage.CorePageNewPtTemplatePage"))

function AuctionGamePtPage:OnInit()
	AuctionGamePtPage.super.OnInit(self)

	self.get = self.bg:Find("PT_bg/Text")
	self.playerInfo = self.bg:Find("playerInfo")
	self.playerFrame = self.playerInfo:Find("frame")
	self.playerIcon = self.playerInfo:Find("frame/icon")
	self.playerName = self.playerInfo:Find("name")
	self.playerCount = self.playerInfo:Find("count")

	setText(self.bg:Find("tip"), i18n("auction_pt_info"))
	setText(self.bg:Find("get_btn/text"), i18n("auction_signin_collect"))
	setText(self.bg:Find("PT_bg/Text"), i18n("auction_pt_tip"))

	return
end

function AuctionGamePtPage:OnFirstFlush()
	AuctionGamePtPage.super.OnFirstFlush(self)

	return
end

function AuctionGamePtPage:OnUpdateFlush()
	AuctionGamePtPage.super.OnUpdateFlush(self)
	self:setPlayerInfo()
	setActive(self.getBtnGray, false)
	setActive(self.getBtn, true)
	setGray(self.getBtn, self.ptData:GetMaxAvailableTargetIndex() == self.ptData:GetLevel())

	return
end

function AuctionGamePtPage:setPlayerInfo()
	local var_4_0 = getProxy(PlayerProxy):getRawData()

	GetImageSpriteFromAtlasAsync("SquareIcon/" .. getProxy(BayProxy):GetShipPhantom(var_4_0:GetShipPhantomMarks()[1]):getPainting(), "", self.playerIcon)
	setText(self.playerName, var_4_0.name)
	setText(self.playerCount, StringHelper.ForamtNumberK(AuctionGameTools.GetCurrencyCnt()))

	return
end

return AuctionGamePtPage
