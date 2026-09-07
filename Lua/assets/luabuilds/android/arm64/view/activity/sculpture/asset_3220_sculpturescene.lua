local SculptureScene = class("SculptureScene", import("view.base.BaseUI"))

SculptureScene.OPEN_GRATITUDE_PAGE = "SculptureScene:OPEN_GRATITUDE_PAGE"

local var_0_1 = 5
local var_0_2 = 6

function SculptureScene:getUIName()
	return "SculptureUI"
end

function SculptureScene:SetActivity(arg_2_1)
	self.activity = arg_2_1

	return
end

function SculptureScene:GetBaseActivity()
	return getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)
end

function SculptureScene:OnUpdateActivity(arg_4_1, arg_4_2, arg_4_3)
	self:SetActivity(arg_4_3)

	for iter_4_0, iter_4_1 in ipairs(self.cards) do
		if iter_4_1.id == arg_4_2 then
			iter_4_1:Flush(arg_4_3)

			break
		end
	end

	if arg_4_1 == SculptureActivity.STATE_FINSIH then
		if self.gratitudePage and self.gratitudePage:GetLoaded() then
			self.gratitudePage:Flush(arg_4_3)
		end

		self:UpdateAward()
	elseif arg_4_1 == SculptureActivity.STATE_UNLOCK then
		self:EnterDrawLinePage(arg_4_2)
		self:UpdateRes()
	elseif arg_4_1 == SculptureActivity.STATE_DRAW then
		self:EnterPuzzlePage(arg_4_2)
	elseif arg_4_1 == SculptureActivity.STATE_JOINT then
		self:EnterPresentedPage(arg_4_2)
	end

	return
end

function SculptureScene:init()
	self.backBtn = self._tf:Find("back")
	self.helpBtn = self._tf:Find("help")
	self.awardBtn = self._tf:Find("award")
	self.awardTxt = self._tf:Find("award/Text"):GetComponent(typeof(Text))
	self.ore = self._tf:Find("ore")
	self.oreIcon = self._tf:Find("ore/icon"):GetComponent(typeof(Image))
	self.oreTxt = self._tf:Find("ore/Text"):GetComponent(typeof(Text))
	self.feather = self._tf:Find("feather")
	self.featherIcon = self._tf:Find("feather/icon"):GetComponent(typeof(Image))
	self.featherTxt = self._tf:Find("feather/Text"):GetComponent(typeof(Text))
	self.tpl = self._tf:Find("frame/content/tpl")

	setActive(self.tpl, false)

	self.tpls = {}
	self.drawLinePage = SculptureDrawLinePage.New(self._tf, self.event, self.contextData)
	self.puzzlePage = SculpturePuzzlePage.New(self._tf, self.event, self.contextData)
	self.presentedPage = SculpturePresentedPage.New(self._tf, self.event, self.contextData)
	self.gratitudePage = SculptureGratitudePage.New(self._tf, self.event, self.contextDat)
	self.awardInfoPage = SculptureAwardInfoPage.New(self._tf, self.event, self.contextDat)
	self.resMsgBoxPage = SculptureResMsgBoxPage.New(self._tf, self.event)
	self.contextData.msgBoxPage = SculptureMsgBoxPage.New(self._tf, self.event)
	self.contextData.tipPage = SculptureTipPage.New(self._tf, self.event)
	self.contextData.miniMsgBox = SculptureMiniMsgBoxPage.New(self._tf, self.event)
	Input.multiTouchEnabled = false

	self:bind(SculptureScene.OPEN_GRATITUDE_PAGE, function(arg_6_0, arg_6_1)
		self.gratitudePage:ExecuteAction("Show", arg_6_1, self.activity, function()
			if self.presentedPage and self.presentedPage:GetLoaded() then
				self.presentedPage:Hide()
			end

			return
		end)

		return
	end)

	return
end

function SculptureScene:didEnter()
	seriesAsync({
		function(arg_9_0)
			self:UpdateResIcon()
			self:UpdateRes()
			self:UpdateAward()
			self:InitMainView(arg_9_0)

			return
		end,
		function(arg_10_0)
			self:RegisterEvent(arg_10_0)

			return
		end
	})

	return
end

function SculptureScene:UpdateResIcon()
	self.oreIcon.sprite = LoadSprite("props/" .. pg.activity_workbench_item[var_0_1].icon)
	self.featherIcon.sprite = LoadSprite("props/" .. pg.activity_workbench_item[var_0_2].icon)
	rtf(self.oreIcon.gameObject).sizeDelta = Vector2(80, 80)
	rtf(self.featherIcon.gameObject).sizeDelta = Vector2(80, 80)

	return
end

function SculptureScene:InitMainView(arg_12_1)
	self.cards = {}

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self.activity:getConfig("config_data")) do
		table.insert(var_12_0, function(arg_13_0)
			local var_13_0 = #self.tpls > 0
			local var_13_1 = #self.tpls > 0 and table.remove(self.tpls, 1) or Object.Instantiate(self.tpl, self.tpl.parent).transform

			setActive(var_13_1, true)
			table.insert(self.cards, (self:CreateNewCard(var_13_1, iter_12_1)))

			if not var_13_0 then
				onNextTick(arg_13_0)
			else
				arg_13_0()
			end

			return
		end)
	end

	seriesAsync(var_12_0, arg_12_1)

	return
end

function SculptureScene:UpdateRes()
	local var_14_0 = self:GetBaseActivity()

	self.oreTxt.text = var_14_0:getVitemNumber(var_0_1)
	self.featherTxt.text = var_14_0:getVitemNumber(var_0_2)

	return
end

function SculptureScene:UpdateAward()
	local var_15_0, var_15_1 = self.activity:GetAwardProgress()

	self.awardTxt.text = var_15_0 .. "/" .. var_15_1

	return
end

function SculptureScene:CreateNewCard(arg_16_1, arg_16_2)
	local var_16_0 = SculptureCard.New(arg_16_1)

	var_16_0:Update(arg_16_2, self.activity)
	onButton(self, var_16_0.continueBtn, function()
		local var_17_0 = self.activity:GetSculptureState(arg_16_2)

		if var_17_0 == SculptureActivity.STATE_UNLOCK then
			self:EnterDrawLinePage(arg_16_2)
		elseif var_17_0 == SculptureActivity.STATE_DRAW then
			self:EnterPuzzlePage(arg_16_2)
		end

		return
	end, SFX_PANEL)
	onButton(self, var_16_0.lockBtn, function()
		local var_18_0, var_18_1 = self.activity:_GetComsume(arg_16_2)

		self.contextData.msgBoxPage:ExecuteAction("Show", {
			nextBtn = true,
			content = self.activity:getDataConfig(arg_16_2, "describe"),
			consume = var_18_1,
			consumeId = var_18_0,
			onYes = function()
				self:emit(SculptureMediator.ON_UNLOCK_SCULPTURE, arg_16_2)

				return
			end,
			iconName = self.activity:GetResorceName(arg_16_2),
			title = self.activity:GetResorceName(arg_16_2) .. "_title"
		})

		return
	end, SFX_PANEL)
	onButton(self, var_16_0.finishBtn, function()
		self.contextData.msgBoxPage:ExecuteAction("Show", {
			content = self.activity:getDataConfig(arg_16_2, "describe"),
			title = self.activity:GetResorceName(arg_16_2) .. "_title"
		})

		return
	end, SFX_PANEL)
	onButton(self, var_16_0.tr, function()
		if self.activity:GetSculptureState(arg_16_2) == SculptureActivity.STATE_FINSIH then
			triggerButton(var_16_0.finishBtn)
		else
			triggerButton(var_16_0.continueBtn)
		end

		return
	end, SFX_PANEL)
	onButton(self, var_16_0.presentedBtn, function()
		self:EnterPresentedPage(arg_16_2)

		return
	end, SFX_PANEL)

	return var_16_0
end

function SculptureScene:RegisterEvent(arg_23_1)
	onButton(self, self.backBtn, function()
		self:emit(SculptureScene.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(self, self.awardBtn, function()
		self.awardInfoPage:ExecuteAction("Show", self.activity)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.gift_act_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.ore, function()
		self.resMsgBoxPage:ExecuteAction("Show", var_0_1)

		return
	end, SFX_PANEL)
	onButton(self, self.feather, function()
		self.resMsgBoxPage:ExecuteAction("Show", var_0_2)

		return
	end, SFX_PANEL)

	return
end

function SculptureScene:EnterDrawLinePage(arg_29_1)
	self.drawLinePage:ExecuteAction("Show", arg_29_1, self.activity)

	return
end

function SculptureScene:EnterPresentedPage(arg_30_1)
	self.presentedPage:ExecuteAction("Show", arg_30_1, self.activity, function()
		if self.puzzlePage and self.puzzlePage:GetLoaded() then
			self.puzzlePage:Hide()
		end

		return
	end)

	return
end

function SculptureScene:EnterPuzzlePage(arg_32_1)
	self.puzzlePage:ExecuteAction("Show", arg_32_1, self.activity, function()
		if self.drawLinePage and self.drawLinePage:GetLoaded() then
			self.drawLinePage:Hide()
		end

		return
	end)

	return
end

function SculptureScene:onBackPressed()
	SculptureScene.super.onBackPressed(self)

	return
end

function SculptureScene:willExit()
	for iter_35_0, iter_35_1 in ipairs(self.cards) do
		iter_35_1:Dispose()
	end

	self.cards = nil

	if self.contextData.msgBoxPage then
		self.contextData.msgBoxPage:Destroy()

		self.contextData.msgBoxPage = nil
	end

	if self.drawLinePage then
		self.drawLinePage:Destroy()

		self.drawLinePage = nil
	end

	if self.contextData.tipPage then
		self.contextData.tipPage:Destroy()

		self.contextData.tipPage = nil
	end

	if self.puzzlePage then
		self.puzzlePage:Destroy()

		self.puzzlePage = nil
	end

	if self.contextData.miniMsgBox then
		self.contextData.miniMsgBox:Destroy()

		self.contextData.miniMsgBox = nil
	end

	if self.awardInfoPage then
		self.awardInfoPage:Destroy()

		self.awardInfoPage = nil
	end

	if self.resMsgBoxPage then
		self.resMsgBoxPage:Destroy()

		self.resMsgBoxPage = nil
	end

	Input.multiTouchEnabled = true

	return
end

return SculptureScene
