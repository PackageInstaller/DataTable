local RefluxScene = class("RefluxScene", import("..base.BaseUI"))

RefluxScene.Sign = 1
RefluxScene.Task = 2
RefluxScene.PT = 3
RefluxScene.Shop = 4

function RefluxScene:getUIName()
	return "RefluxUI"
end

function RefluxScene:preload(arg_2_1)
	local function var_2_0()
		arg_2_1()

		return
	end

	if getProxy(ShopsProxy):ShouldRefreshChargeList() then
		pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
			callback = var_2_0
		})
	else
		var_2_0()
	end

	return
end

function RefluxScene:init()
	self:findUI()
	self:initData()
	self:addListener()

	return
end

function RefluxScene:didEnter()
	self:updateRedPotList()

	if not getProxy(RefluxProxy):isInRefluxTime() then
		self:closeView()

		return
	end

	if not self:tryOpenLetterView() then
		self:tryAutoOpenLastView()
	end

	self:updateDay()

	return
end

function RefluxScene:willExit()
	for iter_6_0, iter_6_1 in ipairs(self.viewList) do
		if iter_6_1 and iter_6_1:GetLoaded() then
			iter_6_1:Destroy()
		end
	end

	return
end

function RefluxScene:onBackPressed()
	if self.letterView and self.letterView:isShowing() then
		self.letterView:OnBackPress()

		return
	end

	self:closeView()

	return
end

function RefluxScene:findUI()
	self.letterContainer = self._tf:Find("PanelLetter")
	self.panelContainer = self._tf:Find("PanelContainer")

	local var_8_0 = self._tf:Find("left/left_bar")

	self.letterBtn = var_8_0:Find("letter")
	self.signToggle = var_8_0:Find("tabs/sign")
	self.taskToggle = var_8_0:Find("tabs/task")
	self.ptToggle = var_8_0:Find("tabs/pt")
	self.shopToggle = var_8_0:Find("tabs/shop")
	self.toggleList = {
		[RefluxScene.Sign] = self.signToggle,
		[RefluxScene.Task] = self.taskToggle,
		[RefluxScene.PT] = self.ptToggle,
		[RefluxScene.Shop] = self.shopToggle
	}
	self.redPotList = {
		[RefluxScene.Sign] = self.signToggle:Find("Red"),
		[RefluxScene.Task] = self.taskToggle:Find("Red"),
		[RefluxScene.PT] = self.ptToggle:Find("Red"),
		[RefluxScene.Shop] = self.shopToggle:Find("Red")
	}
	self.backBtn = var_8_0:Find("back")
	self.dayText = self._tf:Find("time/text")

	setText(self._tf:Find("time/icon"), i18n("reflux_word_1"))
	setText(self._tf:Find("time/icon1"), i18n("word_date"))

	return
end

function RefluxScene:initData()
	self.curViewIndex = 0
	self.letterView = RefluxLetterView.New(self.letterContainer, self.event, self.contextData)
	self.signView = RefluxSignView.New(self.panelContainer, self.event, self.contextData)
	self.taskView = RefluxTaskView.New(self.panelContainer, self.event, self.contextData)
	self.ptView = RefluxPTView.New(self.panelContainer, self.event, self.contextData)
	self.shopView = RefluxShopView.New(self.panelContainer, self.event, self.contextData)
	self.viewList = {
		[RefluxScene.Sign] = self.signView,
		[RefluxScene.Task] = self.taskView,
		[RefluxScene.PT] = self.ptView,
		[RefluxScene.Shop] = self.shopView
	}

	return
end

function RefluxScene:addListener()
	onButton(self, self.backBtn, function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self.letterBtn, function()
		self:switchLetter()

		return
	end, SFX_PANEL)
	onToggle(self, self.signToggle, function(arg_13_0)
		if arg_13_0 == true then
			self:switchPage(RefluxScene.Sign)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.taskToggle, function(arg_14_0)
		if arg_14_0 == true then
			self:switchPage(RefluxScene.Task)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.ptToggle, function(arg_15_0)
		if arg_15_0 == true then
			self:switchPage(RefluxScene.PT)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.shopToggle, function(arg_16_0)
		if arg_16_0 == true then
			self:switchPage(RefluxScene.Shop)
			self:updateRedPotList()
		end

		return
	end, SFX_PANEL)

	return
end

function RefluxScene:tryOpenLetterView()
	local var_17_0 = getProxy(PlayerProxy):getRawData().id .. "_" .. getProxy(RefluxProxy).returnTimestamp

	if PlayerPrefs.GetInt(var_17_0, 0) ~= 1 then
		PlayerPrefs.SetInt(var_17_0, 1)
		PlayerPrefs.Save()
		self.letterView:ActionInvoke("setCloseFunc", function()
			triggerToggle(self.toggleList[RefluxScene.Sign], true)

			return
		end)
		self:switchLetter()

		return true
	else
		return false
	end

	return
end

function RefluxScene:switchPage(arg_19_1)
	if self.curViewIndex ~= arg_19_1 then
		self.viewList[arg_19_1]:Load()
		self.viewList[arg_19_1]:ActionInvoke("Show")
		self.viewList[arg_19_1]:ActionInvoke("updateOutline")

		if self.curViewIndex > 0 then
			self.viewList[self.curViewIndex]:Hide()
		end

		self.curViewIndex = arg_19_1
		self.contextData.lastViewIndex = arg_19_1
	end

	return
end

function RefluxScene:tryAutoOpenLastView()
	if self.contextData.lastViewIndex then
		triggerToggle(self.toggleList[self.contextData.lastViewIndex], true)
	else
		triggerToggle(self.toggleList[RefluxScene.Sign], true)
	end

	return
end

function RefluxScene:switchLetter()
	self.letterView:Load()
	self.letterView:ActionInvoke("Show")

	return
end

function RefluxScene:updateRedPotList()
	setActive(self.redPotList[RefluxScene.Sign], false)
	setActive(self.redPotList[RefluxScene.Task], (RefluxTaskView.isAnyTaskCanGetAward()))
	setActive(self.redPotList[RefluxScene.PT], (RefluxPTView.isAnyPTCanGetAward()))
	setActive(self.redPotList[RefluxScene.Shop], (RefluxShopView.isShowRedPot()))

	return
end

function RefluxScene:updateDay()
	local var_23_0 = pg.TimeMgr.GetInstance()

	setText(self.dayText, #pg.return_sign_template.all - math.clamp(var_23_0:DiffDay(getProxy(RefluxProxy).returnTimestamp, var_23_0:GetServerTime()), 0, #pg.return_sign_template.all - 1))

	return
end

return RefluxScene
