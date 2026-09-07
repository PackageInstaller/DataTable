local PrayPoolScene = class("PrayPoolScene", import("..base.BaseUI"))

function PrayPoolScene:getUIName()
	return "PrayPool"
end

function PrayPoolScene:init()
	self:findUI()
	self:initData()
	self:initEvents()

	return
end

function PrayPoolScene:didEnter()
	self:switchPage((self.prayProxy:getPageState()))

	return
end

function PrayPoolScene:willExit()
	for iter_4_0, iter_4_1 in ipairs(self.subViewList) do
		iter_4_1:Destroy()
	end

	return
end

function PrayPoolScene:onBackPressed()
	local var_5_0

	for iter_5_0, iter_5_1 in ipairs(self.subViewList) do
		var_5_0 = iter_5_1:OnBackPress()
	end

	if not var_5_0 then
		self:emit(PrayPoolScene.ON_BACK)
	end

	return
end

function PrayPoolScene:findUI()
	self.subViewContainer = self._tf:Find("BG/SubViewContainer")
	self.helpBtn = self._tf:Find("BG/HelpBtn")

	onButton(self, self.helpBtn, function()
		if pg.gametip.pray_build_help then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.pray_build_help.tip
			})
		end

		return
	end)

	return
end

function PrayPoolScene:initData()
	self.prayProxy = getProxy(PrayProxy)
	self.prayPoolHomeView = PrayPoolHomeView.New(self.subViewContainer, self.event, self.contextData)
	self.prayPoolSelectPoolView = PrayPoolSelectPoolView.New(self.subViewContainer, self.event, self.contextData)
	self.prayPoolSelectShipView = PrayPoolSelectShipView.New(self.subViewContainer, self.event, self.contextData)
	self.PrayPoolSuccessView = PrayPoolSuccessView.New(self.subViewContainer, self.event, self.contextData)
	self.curSubView = nil
	self.subViewList = {
		[PrayProxy.STATE_HOME] = self.prayPoolHomeView,
		[PrayProxy.STATE_SELECT_POOL] = self.prayPoolSelectPoolView,
		[PrayProxy.STAGE_SELECT_SHIP] = self.prayPoolSelectShipView,
		[PrayProxy.STAGE_BUILD_SUCCESS] = self.PrayPoolSuccessView
	}

	return
end

function PrayPoolScene:initEvents()
	self:bind(PrayPoolConst.SWITCH_TO_SELECT_POOL_PAGE, function(arg_10_0, arg_10_1)
		self:switchPage(arg_10_1)

		return
	end)
	self:bind(PrayPoolConst.SWITCH_TO_SELECT_SHIP_PAGE, function(arg_11_0, arg_11_1)
		self:switchPage(arg_11_1)

		return
	end)
	self:bind(PrayPoolConst.SWITCH_TO_HOME_PAGE, function(arg_12_0, arg_12_1)
		self:switchPage(arg_12_1)

		return
	end)

	return
end

function PrayPoolScene:switchPage(arg_13_1)
	self.subViewList[arg_13_1]:Reset()
	self.subViewList[arg_13_1]:Load()

	if self.curSubView then
		self.curSubView:Destroy()
	end

	self.curSubView = self.subViewList[arg_13_1]

	return
end

return PrayPoolScene
