local IslandShipUpgradePage = class("IslandShipUpgradePage", import("...base.IslandBasePage"))

function IslandShipUpgradePage:getUIName()
	return "IslandShipUpgradeUI"
end

function IslandShipUpgradePage:OnLoaded()
	self.expBar = self._tf:Find("frame/frame_1/exp/bar")
	self.expBarPre = self._tf:Find("frame/frame_1/exp/bar_pre")
	self.levelTxt = self._tf:Find("frame/frame_1/exp/level"):GetComponent(typeof(Text))
	self.expTxt = self._tf:Find("frame/frame_1/exp/Text"):GetComponent(typeof(Text))
	self.closeBtn = self._tf:Find("frame/frame_1/close")
	self.confirmBtn = self._tf:Find("frame/btn_confirm")
	self.delBtn = self._tf:Find("frame/frame_2/del")
	self.maxBtn = self._tf:Find("frame/frame_2/max")
	self.switchBtn = self._tf:Find("frame/frame_1/switch")
	self.uiBreakList = UIItemList.New(self._tf:Find("frame/frame_1/attr/stars"), self._tf:Find("frame/frame_1/attr/stars/tpl"))
	self.uiAttrList = UIItemList.New(self._tf:Find("frame/frame_1/attr/list"), self._tf:Find("frame/frame_1/attr/list/tpl"))
	self.uiItemList = UIItemList.New(self._tf:Find("frame/frame_2/items"), self._tf:Find("frame/frame_2/items/tpl"))

	setText(self._tf:Find("frame/frame_1/title"), i18n("island_word_ship_level_upgrade"))
	setText(self._tf:Find("frame/frame_2/sub_title/Text"), i18n("island_skill_consume_title"))
	setText(self._tf:Find("frame/frame_1/attr/label"), i18n("island_word_ship_level_upgrade_1"))
	setText(self._tf:Find("frame/frame_1/attr/title/Text"), i18n("island_word_ship_rank"))
	setText(self.confirmBtn:Find("Text"), i18n("island_chara_up_button"))

	return
end

function IslandShipUpgradePage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if self:NothingSelected() then
			return
		end

		self:emit(IslandMediator.USE_SHIP_EXP_BOOK, self.ship.id, self.selected)
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.delBtn, function()
		self.selected = {}

		self:UpdateConsume(self.ship)
		self:UpdateLevelPreview()

		return
	end, SFX_PANEL)
	onButton(self, self.maxBtn, function()
		self:FillSelected(self.ship)
		self:UpdateLevelPreview()

		return
	end, SFX_PANEL)

	self.isShowAttrPanel = false

	onToggle(self, self.switchBtn, function(arg_9_0)
		self.isShowAttrPanel = arg_9_0

		if arg_9_0 then
			self:UpdateAttrs(self.ship)
			self:UpdateBreakOutLevel(self.ship)
		end

		return
	end, SFX_PANEL)

	return
end

function IslandShipUpgradePage:OnShow(arg_10_1)
	self.ship = arg_10_1
	self.selected = {}

	self:UpdateLevelAndExp(arg_10_1)
	self:UpdateConsume(arg_10_1)
	self:BlurPanel()

	return
end

function IslandShipUpgradePage:UpdateLevelAndExp(arg_11_1, arg_11_2)
	setActive(self.expBarPre, false)

	local var_11_0 = arg_11_1:GetExp()
	local var_11_1 = arg_11_1:GetTargetExp()
	local var_11_2 = arg_11_1:GetLevel()

	if arg_11_1:IsMaxLevel() then
		setFillAmount(self.expBar, 1)

		self.expTxt.text = ""
	else
		setFillAmount(self.expBar, var_11_0 / var_11_1)

		self.expTxt.text = "<color=#39BFFF>" .. var_11_0 .. "</color>/" .. var_11_1
	end

	self.levelTxt.text = var_11_2

	return
end

function IslandShipUpgradePage:UpdateConsume(arg_12_1)
	local var_12_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetShipExpBooks()

	self.uiItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = var_12_0[arg_13_1 + 1]

			updateCustomDrop(arg_13_2, Drop.New({
				type = DROP_TYPE_ISLAND_ITEM,
				id = var_12_0[arg_13_1 + 1].id,
				count = var_12_0[arg_13_1 + 1].count
			}))
			setActive(arg_13_2:Find("icon_bg/count_bg"), true)
			setText(arg_13_2:Find("icon_bg/count_bg/count"), "X" .. var_12_0[arg_13_1 + 1].count)
			onButton(self, arg_13_2, function()
				if var_13_0.count <= 0 or self:CheckMaxLevel() then
					return
				end

				self:OpenCalcPanel(arg_13_2, var_13_0)

				return
			end, SFX_PANEL)
			self:UpdateCalcPanel(arg_13_2, var_12_0[arg_13_1 + 1])
		end

		return
	end)
	self.uiItemList:align(#var_12_0)

	return
end

function IslandShipUpgradePage:OpenCalcPanel(arg_15_1, arg_15_2)
	self.selected[arg_15_2.id] = math.min(arg_15_2.count, (self.selected[arg_15_2.id] or 0) + 1)

	self:UpdateCalcPanel(arg_15_1, arg_15_2)
	self:UpdateLevelPreview()

	return
end

function IslandShipUpgradePage:CheckMaxLevel()
	local var_16_0 = Clone(self.ship)

	var_16_0:AddExp((self:CalcExpAddition(self.selected)))

	return var_16_0:IsMaxLevel()
end

function IslandShipUpgradePage:UpdateLevelPreview()
	local var_17_0 = Clone(self.ship)
	local var_17_1 = self:CalcExpAddition(self.selected)

	var_17_0:AddExp(var_17_1)
	setActive(self.expBarPre, var_17_1 > 0)

	if var_17_1 > 0 then
		local var_17_2 = var_17_0:GetExp()
		local var_17_3 = var_17_0:GetTargetExp()
		local var_17_4 = var_17_0:GetLevel()

		if var_17_0:IsMaxLevel() then
			setFillAmount(self.expBarPre, 1)

			self.expTxt.text = ""
		else
			setFillAmount(self.expBarPre, var_17_2 / var_17_3)

			self.expTxt.text = "<color=#39BFFF>" .. var_17_2 .. "</color>/" .. var_17_3
		end

		if self.ship:GetLevel() < var_17_4 then
			self.levelTxt.text = var_17_4

			setFillAmount(self.expBar, 0)
		end
	else
		self:UpdateLevelAndExp(self.ship)
	end

	return
end

function IslandShipUpgradePage:UpdateCalcPanel(arg_18_1, arg_18_2)
	local var_18_0 = self.selected[arg_18_2.id] or 0

	setText(arg_18_1:Find("calc/Text"), var_18_0)
	setActive(arg_18_1:Find("calc"), var_18_0 > 0)
	onButton(self, arg_18_1:Find("calc/bg"), function()
		self.selected[arg_18_2.id] = (self.selected[arg_18_2.id] or 0) - 1

		self:UpdateCalcPanel(arg_18_1, arg_18_2)
		self:UpdateLevelPreview()

		return
	end, SFX_PANEL)
	setGray(self.confirmBtn, self:NothingSelected(), true)
	self:UpdateAttrs(self.ship)
	self:UpdateBreakOutLevel(self.ship)

	return
end

function IslandShipUpgradePage:NothingSelected()
	for iter_20_0, iter_20_1 in pairs(self.selected) do
		if iter_20_1 > 0 then
			return false
		end
	end

	return true
end

function IslandShipUpgradePage:FillSelected(arg_21_1)
	self.selected = {}

	local var_21_0 = Clone(arg_21_1)
	local var_21_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetShipExpBooks()

	table.sort(var_21_1, function(arg_22_0, arg_22_1)
		return arg_22_0:GetRarity() > arg_22_1:GetRarity()
	end)

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		for iter_21_2 = 1, iter_21_1.count do
			if var_21_0:IsMaxLevel() then
				break
			end

			var_21_0:AddExp((tonumber(iter_21_1:GetUseArg())))

			self.selected[iter_21_1.id] = (self.selected[iter_21_1.id] or 0) + 1
		end
	end

	self:UpdateConsume(self.ship)

	return
end

function IslandShipUpgradePage:CalcExpAddition(arg_23_1)
	local var_23_0 = 0
	local var_23_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		for iter_23_2 = 1, iter_23_1 do
			var_23_0 = var_23_0 + tonumber(var_23_1:GetItemById(iter_23_0):GetUseArg())
		end
	end

	return var_23_0
end

function IslandShipUpgradePage:UpdateAttrs(arg_24_1)
	if not self.isShowAttrPanel then
		return
	end

	local var_24_0 = arg_24_1:GetGrowthAtt()

	self.uiAttrList:make(function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == UIItemList.EventUpdate then
			arg_25_2:Find("grade_bg"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/IslandShipUI_atlas", IslandShipAttr.Grade2Img((arg_24_1:GetAttrGrade(IslandShipAttr.ATTRS[arg_25_1 + 1])))[2])

			setText(arg_25_2:Find("name"), IslandShipAttr.ToChinese(IslandShipAttr.ATTRS[arg_25_1 + 1]))
			setText(arg_25_2:Find("value"), "+" .. (var_24_0[IslandShipAttr.ATTRS[arg_25_1 + 1]] or 0))
		end

		return
	end)
	self.uiAttrList:align(#IslandShipAttr.ATTRS)

	return
end

function IslandShipUpgradePage:UpdateBreakOutLevel(arg_26_1)
	if not self.isShowAttrPanel then
		return
	end

	self.uiBreakList:make(function(arg_27_0, arg_27_1, arg_27_2)
		if arg_27_0 == UIItemList.EventUpdate then
			setActive(arg_27_2:Find("Image"), true)
		end

		return
	end)
	self.uiBreakList:align(arg_26_1:GetBreakLevel())

	return
end

function IslandShipUpgradePage:OnHide()
	self:UnBlurPanel()

	self.selected = {}

	return
end

return IslandShipUpgradePage
