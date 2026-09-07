local WorldCruiseScene = class("WorldCruiseScene", import("view.base.BaseUI"))

WorldCruiseScene.optionsPath = {
	"top/home"
}
WorldCruiseScene.PAGE_AWARD = "award"
WorldCruiseScene.PAGE_TASK = "task"
WorldCruiseScene.PAGE_SHOP = "shop"

local var_0_1 = WorldCruiseScene.PAGE_AWARD

function WorldCruiseScene:getUIName()
	return "WorldCruiseUI"
end

function WorldCruiseScene:preload(arg_2_1)
	local var_2_0 = getProxy(ShopsProxy)

	local function var_2_1()
		self.shop = CruiseShop.New(var_2_0:GetNormalList(), (var_2_0:GetNormalGroupList()))

		var_2_0:SetCruiseShop(self.shop)
		arg_2_1()

		return
	end

	if var_2_0:ShouldRefreshChargeList() then
		pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
			callback = var_2_1
		})
	else
		var_2_1()
	end

	return
end

function WorldCruiseScene:setShop(arg_4_1)
	self.shop = arg_4_1

	return
end

function WorldCruiseScene:setPlayer(arg_5_1)
	self.player = arg_5_1

	return
end

function WorldCruiseScene:setActivity(arg_6_1)
	self.activity = arg_6_1

	for iter_6_0, iter_6_1 in pairs(arg_6_1:GetCrusingInfo()) do
		self[iter_6_0] = iter_6_1
	end

	self.contextData.phase = self.phase

	return
end

function WorldCruiseScene:init()
	self.topUI = self._tf:Find("top")
	self.titleTF = self.topUI:Find("title/Text")
	self.helpBtn = self.topUI:Find("help")
	self.gemResBtn = self.topUI:Find("res/gem")
	self.gemValue = self.gemResBtn:Find("Text"):GetComponent(typeof(Text))
	self.ticketResBtn = self.topUI:Find("res/ticket")
	self.ticketValue = self.ticketResBtn:Find("Text"):GetComponent(typeof(Text))
	self.dayTxt = self.topUI:Find("day/Text"):GetComponent(typeof(Text))
	self.phaseTF = self._tf:Find("frame/phase")

	setText(self.phaseTF:Find("progress"), i18n("cruise_phase_title"))

	self.pages = {
		[WorldCruiseScene.PAGE_AWARD] = WorldCruiseAwardPage.New(self._tf:Find("frame/award_container"), self.event, self.contextData),
		[WorldCruiseScene.PAGE_TASK] = WorldCruiseTaskPage.New(self._tf:Find("frame/task_container"), self.event, self.contextData),
		[WorldCruiseScene.PAGE_SHOP] = WorldCruiseShopPage.New(self._tf:Find("frame/shop_container"), self.event, self.contextData)
	}
	self.togglesTF = self._tf:Find("frame/toggles")

	eachChild(self.togglesTF, function(arg_8_0)
		onButton(self, arg_8_0, function()
			self.contextData.page = arg_8_0.name

			self:SwitchPage()

			return
		end, SFX_PANEL)

		return
	end)

	local var_7_0 = #self.shop:GetCommodities() == 0
	local var_7_1 = self.togglesTF:Find("shop")

	if var_7_0 then
		onButton(self, var_7_1, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("cruise_shop_no_open"))

			return
		end, SFX_PANEL)
	end

	setActive(var_7_1:Find("lock"), var_7_0)
	setText(var_7_1:Find("lock/Text"), i18n("cruise_shop_no_open"))

	self.contextData.windowForCharge = WorldCruiseChargePage.New(self._tf, self.event)

	self:Hx4Channel()

	return
end

function WorldCruiseScene:didEnter()
	LoadImageSpriteAtlasAsync("bg/" .. pg.battlepass_event_pt[self.activity.id].bg, "", self._tf:Find("bg/bg_1"), true)

	local var_11_0 = self._tf:Find("bg/bg_2")

	if pg.battlepass_event_pt[self.activity.id].bg_tips ~= "" then
		LoadImageSpriteAtlasAsync("bg/" .. pg.battlepass_event_pt[self.activity.id].bg_tips, "", var_11_0, true)
		setActive(var_11_0, true)
	else
		setActive(var_11_0, false)
	end

	onButton(self, self.topUI:Find("back"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_HELP, {
			helps = i18n("battlepass_main_help_" .. pg.battlepass_event_pt[self.activity.id].map_name)
		})

		return
	end, SFX_PANEL)
	onButton(self, self.gemResBtn, function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)
	onButton(self, self.ticketResBtn, function()
		shoppingBatchNewStyle(Goods.CRUISE_QUICK_TASK_TICKET_ID, {
			id = Item.QUICK_TASK_PASS_TICKET_ID
		}, 20, "build_ship_quickly_buy_stone")

		return
	end, SFX_PANEL)

	local var_11_1 = self.activity.stopTime - pg.TimeMgr.GetInstance():GetServerTime()

	self.dayTxt.text = i18n("battlepass_main_time_title") .. i18n("battlepass_main_time", math.floor(var_11_1 / 0), math.floor(var_11_1 % 0 / 16))

	self:UpdateRes()
	self:UpdatePhase()
	self:UpdateAwardTip()
	triggerButton(self.togglesTF:Find(self.contextData.page or var_0_1))

	return
end

function WorldCruiseScene:UpdateRes()
	self.gemValue.text = self.player:getTotalGem()
	self.ticketValue.text = getProxy(BagProxy):getItemCountById(Item.QUICK_TASK_PASS_TICKET_ID)

	return
end

function WorldCruiseScene:UpdatePhase()
	setText(self.phaseTF:Find("Text"), "<size=27>lv.</size>" .. self.phase)

	if self.phase < #self.awardList then
		local var_17_0 = self.pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt)

		setSlider(self.phaseTF:Find("slider"), 0, self.awardList[self.phase + 1].pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt), self.pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt))
		setText(self.phaseTF:Find("progress/Text"), var_17_0 .. "/" .. self.awardList[self.phase + 1].pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt))
	else
		setSlider(self.phaseTF:Find("slider"), 0, 1, 1)
		setText(self.phaseTF:Find("progress/Text"), "MAX")
	end

	self.contextData.phase = self.phase

	return
end

function WorldCruiseScene:OnChargeSuccess(arg_18_1)
	self.contextData.windowForCharge:ExecuteAction("ShowUnlockWindow", arg_18_1)

	return
end

function WorldCruiseScene:UpdateAwardTip()
	setActive(self.togglesTF:Find("award/tip"), #self.activity:GetCrusingUnreceiveAward() > 0)

	return
end

function WorldCruiseScene:SwitchPage()
	for iter_20_0, iter_20_1 in pairs(self.pages) do
		if iter_20_0 == self.contextData.page then
			iter_20_1:ExecuteAction("Flush")
		else
			iter_20_1:ExecuteAction("Hide")
		end
	end

	eachChild(self.togglesTF, function(arg_21_0)
		setActive(arg_21_0:Find("unselected"), arg_21_0.name ~= self.contextData.page)
		setActive(arg_21_0:Find("selected"), arg_21_0.name == self.contextData.page)

		return
	end)

	local var_20_0 = self.contextData.page == WorldCruiseScene.PAGE_SHOP

	setActive(self._tf:Find("shop_bg"), self.contextData.page == WorldCruiseScene.PAGE_SHOP)
	setActive(self.phaseTF, not var_20_0)
	setText(self.titleTF, var_20_0 and i18n("cruise_shop_title") or i18n("cruise_title_" .. pg.battlepass_event_pt[self.activity.id].map_name))

	return
end

function WorldCruiseScene:UpdateView()
	self.pages[self.contextData.page]:ExecuteAction("Flush")

	return
end

function WorldCruiseScene:UpdateAwardPage()
	self:UpdateAwardTip()
	self.pages[WorldCruiseScene.PAGE_AWARD]:ExecuteAction("UpdateActivity", self.activity)

	return
end

function WorldCruiseScene:UpdateTaskPage()
	self.pages[WorldCruiseScene.PAGE_TASK]:ExecuteAction("UpdateActivity", self.activity)

	return
end

function WorldCruiseScene:UpdateShopPage()
	self.pages[WorldCruiseScene.PAGE_SHOP]:ExecuteAction("UpdateShop", self.shop)
	self:UpdateView()

	return
end

function WorldCruiseScene:onBackPressed()
	if self.contextData.windowForCharge and self.contextData.windowForCharge:GetLoaded() and self.contextData.windowForCharge:isShowing() then
		self.contextData.windowForCharge:Hide()

		return
	end

	WorldCruiseScene.super.onBackPressed(self)

	return
end

function WorldCruiseScene:willExit()
	if self.contextData.windowForCharge then
		self.contextData.windowForCharge:Destroy()

		self.contextData.windowForCharge = nil
	end

	for iter_27_0, iter_27_1 in pairs(self.pages) do
		iter_27_1:Destroy()

		iter_27_1 = nil
	end

	return
end

local function var_0_2(arg_28_0)
	return (arg_28_0._tf:Find("bg/bg_1/hx_ch" .. pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony()))
end

function WorldCruiseScene:Hx4Channel()
	local var_29_0 = var_0_2(self)

	if not IsNil(var_29_0) then
		setActive(var_29_0, HXSet.isHx())
	end

	return
end

return WorldCruiseScene
