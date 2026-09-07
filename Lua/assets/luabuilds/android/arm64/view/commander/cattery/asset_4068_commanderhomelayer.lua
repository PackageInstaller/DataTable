local CommanderHomeLayer = class("CommanderHomeLayer", import("...base.BaseUI"))

CommanderHomeLayer.DESC_PAGE_OPEN = "CommanderHomeLayer:DESC_PAGE_OPEN"
CommanderHomeLayer.DESC_PAGE_CLOSE = "CommanderHomeLayer:DESC_PAGE_CLOSE"

function CommanderHomeLayer:getUIName()
	return "CommanderHomeUI"
end

function CommanderHomeLayer:SetHome(arg_2_1)
	self.home = arg_2_1

	return
end

function CommanderHomeLayer:OnCatteryUpdate(arg_3_1)
	local var_3_0

	for iter_3_0, iter_3_1 in pairs(self.cards) do
		if iter_3_1.cattery.id == arg_3_1 then
			var_3_0 = iter_3_1.cattery

			iter_3_1:Update(iter_3_1.cattery)
		end
	end

	if var_3_0 and self.catteryDescPage:GetLoaded() and self.catteryDescPage:isShowing() then
		self.catteryDescPage:OnCatteryUpdate(var_3_0)
	end

	self:UpdateMain()

	return
end

function CommanderHomeLayer:OnCatteryStyleUpdate(arg_4_1)
	local var_4_0

	for iter_4_0, iter_4_1 in pairs(self.cards) do
		if iter_4_1.cattery.id == arg_4_1 then
			var_4_0 = iter_4_1.cattery

			iter_4_1:UpdateStyle(iter_4_1.cattery)
		end
	end

	if var_4_0 and self.catteryDescPage:GetLoaded() and self.catteryDescPage:isShowing() then
		self.catteryDescPage:OnCatteryStyleUpdate(var_4_0)
	end

	return
end

function CommanderHomeLayer:OnCommanderExpChange(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self.cards) do
		if iter_5_1.cattery:ExistCommander() then
			iter_5_1:Update(iter_5_1.cattery)
		end
	end

	if self.catteryDescPage:GetLoaded() and self.catteryDescPage:isShowing() then
		self.catteryDescPage:FlushCatteryInfo()
	end

	self.awardDisplayView:ExecuteAction("AddPlan", {
		homeExp = 0,
		commanderExps = arg_5_1,
		awards = {}
	})

	return
end

function CommanderHomeLayer:OnCatteryOPDone()
	self:UpdateMain()

	return
end

function CommanderHomeLayer:OnZeroHour()
	self:UpdateMain()

	return
end

function CommanderHomeLayer:OnOpAnimtion(arg_8_1, arg_8_2, arg_8_3)
	setActive(self.opAnim.gameObject, true)

	local var_8_0 = ({
		"clean",
		"feed",
		"play"
	})[arg_8_1]

	if not var_8_0 then
		arg_8_3()

		return
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.timer = Timer.New(function()
		self:CancelOpAnim()

		return
	end, 0.8, 1)

	self.timer:Start()
	self.opAnim:SetTrigger(var_8_0)

	for iter_8_0, iter_8_1 in pairs(self.cards) do
		if table.contains(arg_8_2, iter_8_1.cattery.id) then
			floatAni(iter_8_1.char, 20, 0.1, 2)
		end
	end

	self.callback = arg_8_3

	return
end

function CommanderHomeLayer:CancelOpAnim()
	if self.callback then
		self.timer:Stop()

		self.timer = nil

		self.opAnim:SetTrigger("empty")
		self.callback()

		self.callback = nil

		setActive(self.opAnim.gameObject, false)
	end

	return
end

function CommanderHomeLayer:OnDisplayAwardDone(arg_11_1)
	self.awardDisplayView:ExecuteAction("AddPlan", arg_11_1)

	return
end

function CommanderHomeLayer:init()
	self.frame = self._tf:Find("bg")
	self.closeBtn = self._tf:Find("bg/frame/close_btn")
	self.levelInfoBtn = self._tf:Find("bg/frame/title/help")
	self.levelTxt = self._tf:Find("bg/frame/title/Text"):GetComponent(typeof(Text))
	self.scrollRect = self._tf:Find("bg/frame/scrollrect"):GetComponent("ScrollRect")
	self.scrollRectContent = self._tf:Find("bg/frame/scrollrect/content")
	self.batchBtn = self._tf:Find("bg/frame/batch")
	self.opAnim = self._tf:Find("animation"):GetComponent(typeof(Animator))
	self.UIlist = UIItemList.New(self.scrollRectContent, self.scrollRectContent:Find("tpl"))
	self.helpBtn = self._tf:Find("bg/frame/help")
	self.cntTxt = self._tf:Find("bg/frame/cnt/Text"):GetComponent(typeof(Text))
	self.cards = {}
	self.catteryDescPage = CatteryDescPage.New(self._tf, self.event, self.contextData)
	self.levelInfoPage = CommanderHomeLevelInfoPage.New(self._tf, self.event, self.contextData)
	self.awardDisplayView = CatteryOpAnimPage.New(self._tf, self.event)
	self.batchSelPage = CommanderHomeBatchSelPage.New(self._tf, self.event)
	self.flower = CatteryFlowerView.New(self._tf:Find("bg/frame/flower"))
	self.bubbleTF = self._tf:Find("bg/bubble")
	self.bubbleClean = self.bubbleTF:Find("clean")
	self.bubbleFeed = self.bubbleTF:Find("feed")
	self.bubblePlay = self.bubbleTF:Find("play")

	return
end

function CommanderHomeLayer:RegisterEvent()
	self:bind(CommanderHomeLayer.DESC_PAGE_CLOSE, function()
		setActive(self.frame, true)

		return
	end)
	self:bind(CommanderHomeLayer.DESC_PAGE_OPEN, function()
		setActive(self.frame, false)

		return
	end)

	return
end

function CommanderHomeLayer:didEnter()
	self:RegisterEvent()
	onButton(self, self.closeBtn, function()
		self:emit(CommanderHomeLayer.ON_CLOSE)

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		if self.forbiddenClose then
			return
		end

		self:emit(CommanderHomeLayer.ON_CLOSE)

		return
	end, SFX_PANEL)
	onButton(self, self.levelInfoBtn, function()
		self.levelInfoPage:ExecuteAction("Show", self.home)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.cat_home_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.bubbleClean, function()
		self:CancelOpAnim()
		self:emit(CommanderHomeMediator.ON_CLEAN)

		return
	end, SFX_PANEL)
	onButton(self, self.bubbleFeed, function()
		self:CancelOpAnim()
		self:emit(CommanderHomeMediator.ON_FEED)

		return
	end, SFX_PANEL)
	onButton(self, self.bubblePlay, function()
		self:CancelOpAnim()
		self:emit(CommanderHomeMediator.ON_PLAY)

		return
	end, SFX_PANEL)
	onButton(self, self.batchBtn, function()
		self.batchSelPage:ExecuteAction("Update", self.home)

		return
	end, SFX_PANEL)
	self.UIlist:make(function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == UIItemList.EventUpdate then
			self:OnUpdateItem(arg_25_2, self.displays[arg_25_1 + 1])
		end

		return
	end)
	self:UpdateMain()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function CommanderHomeLayer:OnUpdateItem(arg_26_1, arg_26_2)
	local var_26_0 = self.cards[arg_26_1]

	if not self.cards[arg_26_1] then
		var_26_0 = CatteryCard.New(arg_26_1)
		self.cards[arg_26_1] = var_26_0
	end

	onButton(self, var_26_0._tf, function()
		if not var_26_0.cattery:IsLocked() then
			self.catteryDescPage:ExecuteAction("Update", self.home, var_26_0.cattery)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("cat_home_unlock"))
		end

		return
	end, SFX_PANEL)
	var_26_0:Update(arg_26_2)

	return
end

function CommanderHomeLayer:UpdateMain()
	self.levelTxt.text = "LV." .. self.home:GetLevel()

	self:InitCatteries()
	self.flower:Update(self.home)

	return
end

function CommanderHomeLayer:InitCatteries()
	self.displays = {}

	local var_29_0 = 0
	local var_29_1 = 0

	for iter_29_0, iter_29_1 in pairs((self.home:GetCatteries())) do
		table.insert(self.displays, iter_29_1)

		if iter_29_1:ExistCommander() then
			var_29_1 = var_29_1 + 1
		end

		if not iter_29_1:IsLocked() then
			var_29_0 = var_29_0 + 1
		end
	end

	self.UIlist:align(#self.displays)
	self:UpdateBubble()

	self.cntTxt.text = var_29_1 .. "/" .. var_29_0

	return
end

function CommanderHomeLayer:UpdateBubble()
	local var_30_0 = false
	local var_30_1 = false
	local var_30_2 = false

	for iter_30_0, iter_30_1 in pairs((self.home:GetCatteries())) do
		if iter_30_1:ExistCleanOP() and iter_30_1:CommanderCanClean() then
			var_30_0 = true
		end

		if iter_30_1:ExiseFeedOP() and iter_30_1:CommanderCanFeed() then
			var_30_1 = true
		end

		if iter_30_1:ExistPlayOP() and iter_30_1:CommanderCanPlay() then
			var_30_2 = true
		end
	end

	local var_30_3 = var_30_0 or var_30_1 or var_30_2

	setActive(self.bubbleTF, var_30_0 or var_30_1 or var_30_2)

	if LeanTween.isTweening(self.bubbleTF.gameObject) then
		LeanTween.cancel(self.bubbleTF.gameObject)
	end

	if var_30_3 then
		floatAni(self.bubbleTF, 20, 0.5, -1)
		setActive(self.bubbleClean, var_30_0)
		setActive(self.bubbleFeed, var_30_1 and not var_30_0)
		setActive(self.bubblePlay, var_30_2 and not var_30_1)
	end

	return
end

function CommanderHomeLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance()._normalUIMain)

	if LeanTween.isTweening(self.bubbleTF.gameObject) then
		LeanTween.cancel(self.bubbleTF.gameObject)
	end

	for iter_31_0, iter_31_1 in pairs(self.cards) do
		iter_31_1:Dispose()
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.cards = nil

	self.flower:Dispose()

	self.flower = nil

	self.catteryDescPage:Destroy()

	self.catteryDescPage = nil

	self.levelInfoPage:Destroy()

	self.levelInfoPage = nil

	self.awardDisplayView:Destroy()

	return
end

function CommanderHomeLayer:onBackPressed()
	if self.catteryDescPage:GetLoaded() and self.catteryDescPage:isShowing() then
		self.catteryDescPage:Hide()

		return
	end

	if self.levelInfoPage:GetLoaded() and self.levelInfoPage:isShowing() then
		self.levelInfoPage:Hide()

		return
	end

	if self.batchSelPage:GetLoaded() and self.batchSelPage:isShowing() then
		self.batchSelPage:Hide()
	end

	CommanderHomeLayer.super.onBackPressed(self)

	return
end

return CommanderHomeLayer
