local CompensateScene = class("CompensateScene", import("view.base.BaseUI"))

function CompensateScene:getUIName()
	return "CompensateUI"
end

function CompensateScene:ResUISettings()
	return false
end

CompensateScene.optionsPath = {
	"adapt/top/option"
}

function CompensateScene:quickExitFunc()
	self:emit(CompensateScene.ON_HOME)

	return
end

function CompensateScene:init()
	self.proxy = getProxy(CompensateProxy)
	self.rtAdapt = self._tf:Find("adapt")

	setText(self.rtAdapt:Find("top/title"), i18n("compensate_ui_title1"))
	setText(self.rtAdapt:Find("top/title/Text"), i18n("compensate_ui_title2"))
	onButton(self, self.rtAdapt:Find("top/back_btn"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	self.rtLabels = self.rtAdapt:Find("left_length/frame/tagRoot")

	eachChild(self.rtLabels, function(arg_6_0)
		if arg_6_0.name == "mail" then
			toggleName = i18n("compensate_ui_title1")
		end

		setText(arg_6_0:Find("unSelect/Text"), toggleName)
		setText(arg_6_0:Find("selected/Text"), toggleName)
		onToggle(self, arg_6_0, function(arg_7_0)
			if arg_7_0 then
				self:SetPage()
			end

			return
		end, SFX_PANEL)

		return
	end)

	local var_4_0 = self.rtAdapt:Find("main/content")

	self.rtMailLeft = var_4_0:Find("left/left_content")
	self.lsrMailList = self.rtMailLeft:Find("middle/container"):GetComponent("LScrollRect")

	function self.lsrMailList.onUpdateItem(arg_8_0, arg_8_1)
		arg_8_0 = arg_8_0 + 1

		local var_8_0 = tf(arg_8_1)
		local var_8_1 = self.filterMails[arg_8_0]

		onToggle(self, var_8_0, function(arg_9_0)
			if arg_9_0 then
				if self.selectMailId ~= var_8_1.id then
					self:UpdateMailContent(var_8_1)
				end
			elseif var_8_1.id == self.selectMailId then
				self:UpdateMailContent(nil)
			end

			return
		end, SFX_PANEL)
		self:UpdateMailTpl(var_8_0, self.filterMails[arg_8_0])

		return
	end

	self.rtMailRight = var_4_0:Find("right")
	self.rtBtnRightGet = self.rtMailRight:Find("bottom/btn_get")

	onButton(self, self.rtBtnRightGet, function()
		assert(self.selectMailId)
		self:emit(CompensateMediator.ON_GET_REWARD, {
			reward_id = self.selectMailId
		})

		return
	end, SFX_PANEL)

	self.rtMailEmpty = var_4_0:Find("empty")

	setText(self.rtBtnRightGet:Find("Text"), i18n("mail_getone_button"))
	self:InitResBar()

	return
end

function CompensateScene:SetPage()
	self:UpdateMailList()

	return
end

function CompensateScene:didEnter()
	onNextTick(function()
		self.lsrMailList.enabled = true

		triggerToggle(self.rtLabels:Find("mail"), true)

		return
	end)

	return
end

function CompensateScene:UpdateMailList()
	self.filterMails = self.proxy:GetAllRewardList()

	table.sort(self.filterMails, CompareFuncs({
		function(arg_15_0)
			return -arg_15_0.date
		end,
		function(arg_16_0)
			return -arg_16_0.id
		end
	}))

	if #self.filterMails == 0 then
		setActive(self.rtMailLeft, false)
		setActive(self.rtMailRight, false)
		setActive(self.rtMailEmpty, true)
		setText(self.rtMailEmpty:Find("Text"), i18n("compensate_ui_nothing1"))
		setText(self.rtMailEmpty:Find("Text_en"), i18n("compensate_ui_nothing2"))
	else
		setActive(self.rtMailLeft, true)
		setActive(self.rtMailRight, true)
		setActive(self.rtMailEmpty, false)

		if not self.selectMailId then
			self:UpdateMailContent(self.filterMails[1])
		end

		self.lsrMailList:SetTotalCount(#self.filterMails, delta or -1)
	end

	return
end

function CompensateScene:UpdateMailTpl(arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1:Find("content")

	setActive(var_17_0:Find("icon/no_attachment"), #arg_17_2.attachments == 0)
	setActive(var_17_0:Find("icon/IconTpl"), #arg_17_2.attachments > 0)

	if #arg_17_2.attachments > 0 then
		updateDrop(var_17_0:Find("icon/IconTpl"), arg_17_2.attachments[1])
	end

	setText(var_17_0:Find("info/title/Text"), shortenString(arg_17_2.title, 10))
	setText(var_17_0:Find("info/time/Text"), os.date("%Y-%m-%d", arg_17_2.date))

	local var_17_1 = arg_17_2.timestamp - pg.TimeMgr.GetInstance():GetServerTime()

	if math.floor(var_17_1 / 0) >= 1 then
		setText(var_17_0:Find("info/time/out_time/Text"), i18n("compensate_ui_expiration_day", math.floor(var_17_1 / 0)))
	else
		setText(var_17_0:Find("info/time/out_time/Text"), i18n("compensate_ui_expiration_hour", math.floor(var_17_1 / 16)))
	end

	setActive(arg_17_1:Find("got_mark"), arg_17_2.attachFlag)
	setText(arg_17_1:Find("got_mark/got_text"), i18n("mail_reward_got"))
	setActive(arg_17_1:Find("hasread_bg"), true)
	setActive(arg_17_1:Find("noread_bg"), false)

	local var_17_2 = SummerFeastScene.TransformColor("FFFFFF")

	setTextColor(var_17_0:Find("info/title/Text"), var_17_2)
	setTextColor(var_17_0:Find("info/time/Text"), var_17_2)
	triggerToggle(arg_17_1, self.selectMailId == arg_17_2.id)

	return
end

function CompensateScene:UpdateMailContent(arg_18_1)
	eachChild(self.rtMailRight, function(arg_19_0)
		setActive(arg_19_0, tobool(arg_18_1))

		return
	end)

	if not arg_18_1 then
		self.selectMailId = nil

		return
	end

	self.selectMailId = arg_18_1.id

	changeToScrollText(self.rtMailRight:Find("main/title/info/Text"), i18n2(arg_18_1.title))
	setText(self.rtMailRight:Find("main/from/Text"), arg_18_1.sender)
	setText(self.rtMailRight:Find("main/time/Text"), os.date("%Y-%m-%d", arg_18_1.date))
	setText(self.rtMailRight:Find("main/view/content/text/Text"), arg_18_1.text)

	local var_18_0 = self.rtMailRight:Find("main/view/content/attachment")

	setText(var_18_0:Find("got/Text"), i18n("main_mailLayer_attachTaken"))
	setActive(self.rtBtnRightGet, not arg_18_1.attachFlag)
	setActive(var_18_0, #arg_18_1.attachments > 0)

	if #arg_18_1.attachments > 0 then
		local var_18_1 = var_18_0:Find("content")

		UIItemList.StaticAlign(var_18_1, var_18_1:Find("IconTpl"), #arg_18_1.attachments, function(arg_20_0, arg_20_1, arg_20_2)
			arg_20_1 = arg_20_1 + 1

			if arg_20_0 == UIItemList.EventUpdate then
				local var_20_0 = arg_18_1.attachments[arg_20_1]

				updateDrop(arg_20_2, arg_18_1.attachments[arg_20_1])
				onButton(self, arg_20_2, function()
					self:emit(CompensateScene.ON_DROP, var_20_0)

					return
				end, SFX_PANEL)
			end

			return
		end)

		local var_18_2 = arg_18_1.attachFlag

		setCanvasGroupAlpha(var_18_1, arg_18_1.attachFlag and 0.5 or 1)
		setActive(var_18_0:Find("got"), var_18_2)
	end

	return
end

function CompensateScene:onBackPressed()
	triggerButton(self.rtAdapt:Find("top/back_btn"))

	return
end

function CompensateScene:willExit()
	return
end

function CompensateScene:UpdateOperationDeal()
	self:UpdateMailList()

	if self.selectMailId then
		self:UpdateMailContent(underscore.detect(self.filterMails, function(arg_25_0)
			return arg_25_0.id == self.selectMailId
		end))
	end

	return
end

function CompensateScene:InitResBar()
	self.resBar = self._tf:Find("adapt/top/res")
	self.goldMax = self.resBar:Find("gold/max"):GetComponent(typeof(Text))
	self.goldValue = self.resBar:Find("gold/Text"):GetComponent(typeof(Text))
	self.oilMax = self.resBar:Find("oil/max"):GetComponent(typeof(Text))
	self.oilValue = self.resBar:Find("oil/Text"):GetComponent(typeof(Text))
	self.gemValue = self.resBar:Find("gem/Text"):GetComponent(typeof(Text))

	onButton(self, self.resBar:Find("gold"), function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(self, self.resBar:Find("oil"), function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(self, self.resBar:Find("gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)
	self:UpdateRes()

	return
end

function CompensateScene:UpdateRes()
	PlayerResUI.StaticFlush(getProxy(PlayerProxy):getRawData(), self.goldMax, self.goldValue, self.oilMax, self.oilValue, self.gemValue)

	return
end

return CompensateScene
