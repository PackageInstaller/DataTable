local CommanderHomeLevelInfoPage = class("CommanderHomeLevelInfoPage", import("...base.BaseSubView"))

function CommanderHomeLevelInfoPage:getUIName()
	return "CommanderHomeLevelUI"
end

function CommanderHomeLevelInfoPage:OnLoaded()
	self.close = self._tf:Find("bg/frame/close_btn")
	self.scrollrect = self._tf:Find("bg/frame/scrollrect"):GetComponent("LScrollRect")
	self.levelTxt = self._tf:Find("bg/frame/level/Text"):GetComponent(typeof(Text))
	self.descPanel = self._tf:Find("desc_panel")
	self.descLevelTxt = self.descPanel:Find("frame/level"):GetComponent(typeof(Text))
	self.descTxt = self.descPanel:Find("frame/Text"):GetComponent(typeof(Text))
	self.expTxt = self._tf:Find("bg/frame/level/exp"):GetComponent(typeof(Text))

	setText(self._tf:Find("bg/frame/level/label"), i18n("commander_home_level_label"))

	return
end

function CommanderHomeLevelInfoPage:OnInit()
	self.cards = {}

	function self.scrollrect.onInitItem(arg_4_0)
		self:OnInitItem(arg_4_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_5_0, arg_5_1)
		self:OnUpdateItem(arg_5_0, arg_5_1)

		return
	end

	onButton(self, self.descPanel, function()
		self:CloseDescWindow()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.close, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function CommanderHomeLevelInfoPage:OnInitItem(arg_9_1)
	self.cards[arg_9_1] = CommanderHomeLevelCard.New(arg_9_1, self)

	return
end

function CommanderHomeLevelInfoPage:OnUpdateItem(arg_10_1, arg_10_2)
	if not self.cards[arg_10_2] then
		self:OnInitItem(arg_10_2)
	end

	self.cards[arg_10_2]:Update(self.home, self.displays[arg_10_1 + 1])

	return
end

function CommanderHomeLevelInfoPage:Show(arg_11_1)
	CommanderHomeLevelInfoPage.super.Show(self)

	self.home = arg_11_1

	self:InitMainView()

	return
end

function CommanderHomeLevelInfoPage:InitMainView()
	self.levelTxt.text = "LV." .. self.home:GetLevel()
	self.expTxt.text = self.home:IsMaxLevel() and "EXP MAX" or "EXP " .. self.home.exp .. "/" .. self.home:GetNextLevelExp()

	local var_12_0 = self.home:GetAllLevel()

	self.displays = {}

	local var_12_1 = self.home:bindConfigTable()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		table.insert(self.displays, {
			level = var_12_1[iter_12_1].level,
			totalExp = self.home:GetTargetExpForLevel(iter_12_1),
			tail = iter_12_0 == #var_12_0,
			exp = var_12_1[iter_12_1].home_exp,
			desc = var_12_1[iter_12_1].desc
		})
	end

	self.scrollrect:SetTotalCount(#self.displays)

	return
end

function CommanderHomeLevelInfoPage:ShowDescWindow(arg_13_1, arg_13_2)
	setActive(self.descPanel, true)

	self.descTxt.text = arg_13_1
	self.descLevelTxt.text = "LV." .. arg_13_2

	return
end

function CommanderHomeLevelInfoPage:CloseDescWindow()
	setActive(self.descPanel, false)

	return
end

function CommanderHomeLevelInfoPage:OnDestroy()
	for iter_15_0, iter_15_1 in pairs(self.cards) do
		iter_15_1:Dispose()
	end

	return
end

return CommanderHomeLevelInfoPage
