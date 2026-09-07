local PSSHei5Scene = class("PSSHei5Scene", import("view.base.BaseUI"))

PSSHei5Scene.optionsPath = {
	"top/home"
}
PSSHei5Scene.PAGE_AWARD = "award"
PSSHei5Scene.PAGE_TASK = "task"

local var_0_1 = PSSHei5Scene.PAGE_AWARD

function PSSHei5Scene:getUIName()
	return "PSSHei5UI"
end

function PSSHei5Scene:setActivity(arg_2_1)
	self.activity = arg_2_1

	for iter_2_0, iter_2_1 in pairs(arg_2_1:GetHei5Info()) do
		self[iter_2_0] = iter_2_1
	end

	self.contextData.phase = self.phase

	return
end

function PSSHei5Scene:initTplVar()
	self.helpBtnTip = "blackfriday_battlepass_main_help_" .. pg.black_friday_battlepass_event_pt[self.activity.id].map_name
	self.awardPageCls = PSSHei5AwardPage
	self.taskPageCls = PSSHei5TaskPage
	self.chargePageCls = PSSCruiseChargePage
	self.dayTextTip = "blackfriday_battlepass_main_time_title"
	self.titleTextTip = "activity_ninjia_main_title"
	self.rewardTip = "blackfriday_battlepass_rewards"
	self.missionTip = "blackfriday_battlepass_mission"

	return
end

function PSSHei5Scene:init()
	self:initTplVar()

	self.topUI = self._tf:Find("top")
	self.titleTF = self.topUI:Find("title/Text")
	self.helpBtn = self.topUI:Find("help")
	self.dayTxt = self.topUI:Find("day/Text"):GetComponent(typeof(Text))
	self.phaseTF = self._tf:Find("frame/phase")
	self.frame = self._tf:Find("frame")
	self.btnPay = self._tf:Find("frame/phase/btn_pay")
	self.item = self.frame:Find("phase/award/tpl")
	self.items = self.frame:Find("phase/award")
	self.itemList = UIItemList.New(self.items, self.item)

	setActive(self.item, false)
	setText(self.frame:Find("toggles/award/selected/Text"), i18n(self.rewardTip))
	setText(self.frame:Find("toggles/award/unselected/Text"), i18n(self.rewardTip))
	setText(self.frame:Find("toggles/task/selected/Text"), i18n(self.missionTip))
	setText(self.frame:Find("toggles/task/unselected/Text"), i18n(self.missionTip))

	self.pages = {
		[PSSHei5Scene.PAGE_AWARD] = self.awardPageCls.New(self._tf:Find("frame/award_container"), self.event, self.contextData),
		[PSSHei5Scene.PAGE_TASK] = self.taskPageCls.New(self._tf:Find("frame/task_container"), self.event, self.contextData)
	}
	self.togglesTF = self._tf:Find("frame/toggles")

	eachChild(self.togglesTF, function(arg_5_0)
		onButton(self, arg_5_0, function()
			self.contextData.page = arg_5_0.name

			self:SwitchPage()

			return
		end, SFX_PANEL)

		return
	end)

	self.contextData.windowForCharge = self.chargePageCls.New(self._tf, self.event)

	return
end

function PSSHei5Scene:didEnter()
	onButton(self, self.topUI:Find("title/back"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_HELP, {
			helps = i18n(self.helpBtnTip)
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btnPay, function()
		self.contextData.windowForCharge:ExecuteAction("ShowBuyWindow")

		return
	end, SFX_CONFIRM)

	local var_7_0 = self.activity.stopTime - pg.TimeMgr.GetInstance():GetServerTime()

	self.dayTxt.text = i18n(self.dayTextTip) .. i18n("battlepass_main_time", math.floor(var_7_0 / 0), math.floor(var_7_0 % 0 / 16))

	self:UpdatePhase()
	self:UpdateAwardTip()
	triggerButton(self.togglesTF:Find(self.contextData.page or var_0_1))
	self:SetAward()

	return
end

function PSSHei5Scene:SetAward()
	self.config_client = self.activity:getConfig("config_client")[2]
	self.taskProxy = getProxy(TaskProxy)

	self.itemList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventInit then
			local var_12_0 = Drop.Create({
				self.config_client[arg_12_1 + 1][1],
				self.config_client[arg_12_1 + 1][2],
				self.config_client[arg_12_1 + 1][3]
			})

			updateDrop(arg_12_2:Find("item"), var_12_0)
			onButton(self, arg_12_2, function()
				self:emit(BaseUI.ON_NEW_STYLE_DROP, {
					drop = var_12_0
				})

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.itemList:align(#self.config_client)

	return
end

function PSSHei5Scene:UpdatePhase()
	setText(self.phaseTF:Find("Text"), self.phase)

	if self.phase < #self.awardList then
		local var_14_0 = self.pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt)

		self.phaseTF:Find("slider"):GetComponent(typeof(Image)).fillAmount = (self.pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt)) / (self.awardList[self.phase + 1].pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt))

		setText(self.phaseTF:Find("progress/progress1"), var_14_0)
		setText(self.phaseTF:Find("progress/progress2"), "/" .. self.awardList[self.phase + 1].pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt))
	else
		self.phaseTF:Find("slider"):GetComponent(typeof(Image)).fillAmount = 1

		setText(self.phaseTF:Find("progress/progress1"), "MAX")
		setActive(self.phaseTF:Find("progress/progress2"), false)
	end

	self.contextData.phase = self.phase

	setActive(self.btnPay, not self.isPay)

	if not self.isPay then
		if not pg.TimeMgr.GetInstance():inTime(pg.pay_data_display[self.chargePageCls.GetPassID()].time) then
			setActive(self.btnPay, false)
		end
	end

	setText(self.titleTF, i18n(self.titleTextTip))

	return
end

function PSSHei5Scene:OnChargeSuccess(arg_15_1)
	self.contextData.windowForCharge:ExecuteAction("ShowUnlockWindow", arg_15_1)

	return
end

function PSSHei5Scene:UpdateAwardTip()
	setActive(self.togglesTF:Find("award/tip"), #self.activity:GetHei5UnreceiveAward() > 0)

	return
end

function PSSHei5Scene:SwitchPage()
	for iter_17_0, iter_17_1 in pairs(self.pages) do
		if iter_17_0 == self.contextData.page then
			iter_17_1:ExecuteAction("Flush")
		else
			iter_17_1:ExecuteAction("Hide")
		end
	end

	eachChild(self.togglesTF, function(arg_18_0)
		setActive(arg_18_0:Find("unselected"), arg_18_0.name ~= self.contextData.page)
		setActive(arg_18_0:Find("selected"), arg_18_0.name == self.contextData.page)

		return
	end)

	return
end

function PSSHei5Scene:UpdateView()
	self.pages[self.contextData.page]:ExecuteAction("Flush")

	return
end

function PSSHei5Scene:UpdateAwardPage()
	self:UpdateAwardTip()
	self.pages[PSSHei5Scene.PAGE_AWARD]:ExecuteAction("UpdateActivity", self.activity)

	return
end

function PSSHei5Scene:UpdateTaskPage()
	self.pages[PSSHei5Scene.PAGE_TASK]:ExecuteAction("UpdateActivity", self.activity)

	return
end

function PSSHei5Scene:onBackPressed()
	if self.contextData.windowForCharge and self.contextData.windowForCharge:GetLoaded() and self.contextData.windowForCharge:isShowing() then
		self.contextData.windowForCharge:Hide()

		return
	end

	PSSHei5Scene.super.onBackPressed(self)

	return
end

function PSSHei5Scene:willExit()
	return
end

return PSSHei5Scene
