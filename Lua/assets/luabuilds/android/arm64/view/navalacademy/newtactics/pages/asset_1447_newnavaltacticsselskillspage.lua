local NewNavalTacticsSelSkillsPage = class("NewNavalTacticsSelSkillsPage", import("....base.BaseSubView"))

function NewNavalTacticsSelSkillsPage:getUIName()
	return "NewNavalTacticsSkillsPage"
end

function NewNavalTacticsSelSkillsPage:OnLoaded()
	self.confrimBtn = self._tf:Find("frame/confirm_btn")
	self.skillTpl = self._tf:Find("frame/skill_container/content/skill")
	self.emptyTpl = self._tf:Find("frame/skill_container/content/empty")
	self.toggleGroup = self._tf:Find("frame/skill_container/content"):GetComponent(typeof(ToggleGroup))
	self.skillCards = {
		NewNavalTacticsSkillCard.New(self.skillTpl)
	}
	self.emptyTpls = {
		self.emptyTpl
	}

	setText(self.confrimBtn:Find("Image"), i18n("tactics_class_start"))
	setText(self._tf:Find("frame/bg/title"), i18n("nav_tactics_sel_skill_title"))

	return
end

function NewNavalTacticsSelSkillsPage:SetCancelCallback(arg_3_1)
	self.onCancelCallback = arg_3_1

	return
end

function NewNavalTacticsSelSkillsPage:SetHideCallback(arg_4_1)
	self.onHideCallback = arg_4_1

	return
end

function NewNavalTacticsSelSkillsPage:OnInit()
	onButton(self, self._tf, function()
		self:Cancel()
		self:Hide()

		if self.onCancelCallback then
			self.onCancelCallback()

			self.onCancelCallback = nil
		end

		return
	end, SFX_PANEL)
	onButton(self, self.confrimBtn, function()
		if not self.selSkill or not self.selIndex then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_should_exist_skill"))

			return
		end

		if self.selSkill:IsMaxLevel() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_max_level"))

			return
		end

		self.student:setSkillIndex(self.selIndex)
		self:emit(NewNavalTacticsLayer.ON_SKILL_SELECTED, self.student)

		return
	end, SFX_PANEL)

	return
end

function NewNavalTacticsSelSkillsPage:Show(arg_8_1, arg_8_2)
	NewNavalTacticsSelSkillsPage.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	if arg_8_1 ~= self.student then
		self.skillIndex = arg_8_2
		self.student = arg_8_1
		self.selSkill = nil
		self.selIndex = nil

		self:UpdateSkillList(arg_8_1)
	end

	return
end

function NewNavalTacticsSelSkillsPage:Cancel()
	self:emit(NewNavalTacticsMediator.ON_CANCEL_ADD_STUDENT)

	return
end

function NewNavalTacticsSelSkillsPage:Hide()
	NewNavalTacticsSelSkillsPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance().UIMain)

	if self.onHideCallback then
		self.onHideCallback()

		self.onHideCallback = nil
	end

	return
end

function NewNavalTacticsSelSkillsPage:UpdateSkillList(arg_11_1)
	local var_11_0 = getProxy(BayProxy):RawGetShipById(arg_11_1.shipId)
	local var_11_1 = var_11_0:getSkillList()
	local var_11_2 = #var_11_1
	local var_11_3 = #var_11_1 >= 3 and var_11_2 or 3

	for iter_11_0 = 1, #var_11_1 do
		self:UpdateSkill(iter_11_0, ShipSkill.New(var_11_0.skills[var_11_1[iter_11_0]], var_11_0.id))
	end

	local var_11_4 = 0

	for iter_11_1 = var_11_2 + 1, var_11_3 do
		var_11_4 = var_11_4 + 1

		self:UpdateEmptySkill(var_11_4, iter_11_1)
	end

	self:ClearShipCards(self.skillCards, var_11_2)
	self:ClearEmtptyTpls(self.emptyTpls, var_11_4)

	if var_11_2 > 0 then
		self.toggleGroup:SetAllTogglesOff()
		triggerToggle(self.skillCards[1]._tf, true)
	end

	if self.skillIndex then
		self:TriggerDefault(var_11_1)
	end

	return
end

function NewNavalTacticsSelSkillsPage:TriggerDefault(arg_12_1)
	if self.skillIndex and self.skillIndex > 0 then
		triggerToggle(self.skillCards[self.skillIndex]._tf, true)
		triggerButton(self.confrimBtn)
	end

	self.skillIndex = nil

	return
end

function NewNavalTacticsSelSkillsPage:UpdateSkill(arg_13_1, arg_13_2)
	local var_13_0 = self.skillCards[arg_13_1]

	if not self.skillCards[arg_13_1] then
		var_13_0 = NewNavalTacticsSkillCard.New(Object.Instantiate(self.skillTpl, self.skillTpl.parent))
		self.skillCards[arg_13_1] = var_13_0
	end

	var_13_0._tf:SetSiblingIndex(arg_13_1 - 1)
	var_13_0:Enable()
	var_13_0:Update(arg_13_2)
	onToggle(self, var_13_0._tf, function(arg_14_0)
		if arg_14_0 then
			self.selSkill = arg_13_2
			self.selIndex = arg_13_1
		end

		return
	end, SFX_PANEL)

	return
end

function NewNavalTacticsSelSkillsPage:ClearShipCards(arg_15_1, arg_15_2)
	for iter_15_0 = #arg_15_1, arg_15_2 + 1, -1 do
		arg_15_1[iter_15_0]:Disable()
	end

	return
end

function NewNavalTacticsSelSkillsPage:UpdateEmptySkill(arg_16_1, arg_16_2)
	local var_16_0 = self.emptyTpls[arg_16_1]

	if not self.emptyTpls[arg_16_1] then
		var_16_0 = Object.Instantiate(self.emptyTpl, self.emptyTpl.parent)
		self.emptyTpls[arg_16_1] = var_16_0
	end

	var_16_0:SetSiblingIndex(arg_16_2 - 1)
	setActive(var_16_0, true)

	return
end

function NewNavalTacticsSelSkillsPage:ClearEmtptyTpls(arg_17_1, arg_17_2)
	for iter_17_0 = #arg_17_1, arg_17_2 + 1, -1 do
		setActive(arg_17_1[iter_17_0], false)
	end

	return
end

function NewNavalTacticsSelSkillsPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	for iter_18_0, iter_18_1 in ipairs(self.skillCards) do
		iter_18_1:Dispose()
	end

	self.skillCards = nil

	return
end

return NewNavalTacticsSelSkillsPage
