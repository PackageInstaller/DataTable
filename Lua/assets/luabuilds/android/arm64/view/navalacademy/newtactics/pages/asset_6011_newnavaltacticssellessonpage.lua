local NewNavalTacticsSelLessonPage = class("NewNavalTacticsSelLessonPage", import("....base.BaseSubView"))

function NewNavalTacticsSelLessonPage:getUIName()
	return "NewNavalTacticsLessonPage"
end

function NewNavalTacticsSelLessonPage:OnLoaded()
	self.skillPanel = self._tf:Find("skill")
	self.cancelBtn = self._tf:Find("cancel_btn")
	self.confirmBtn = self._tf:Find("confirm_btn")
	self.toggleGroup = self._tf:Find("items"):GetComponent(typeof(ToggleGroup))
	self.lessonNameTxt = self._tf:Find("introl/name"):GetComponent(typeof(Text))
	self.lessonDescTxt = self._tf:Find("introl/desc"):GetComponent(typeof(Text))
	self.lessonExpTxt = self._tf:Find("introl/exp_Text"):GetComponent(typeof(Text))
	self.lessonTimeTxt = self._tf:Find("introl/timer_Text"):GetComponent(typeof(Text))
	self.skillCard = NewNavalTacticsAdditionSkillCard.New(self._tf:Find("skill/info"))
	self.itemTpls = {
		self._tf:Find("items/scorll/content/item")
	}
	self.startPos = self.itemTpls[1].anchoredPosition
	self.space = Vector2(60, 30)
	self.cloumnCnt = 6

	setText(self._tf:Find("introl/exp_label"), i18n("tactics_class_get_exp"))
	setText(self._tf:Find("introl/timer_label"), i18n("tactics_class_spend_time"))
	setText(self.confirmBtn:Find("Image"), i18n("tactics_class_start"))
	setText(self.cancelBtn:Find("Image"), i18n("tactics_class_cancel"))

	return
end

function NewNavalTacticsSelLessonPage:OnInit()
	onButton(self, self.cancelBtn, function()
		self:Cancel()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if not self.selLessonId or not self.spendTime then
			return
		end

		self.student:setLesson(self.selLessonId)
		self.student:setTime(self.spendTime)
		self:emit(NewNavalTacticsLayer.ON_LESSON_SELECTED, self.student)

		return
	end, SFX_PANEL)
	onButton(self, self.skillPanel, function()
		if not self.canBack then
			return
		end

		self:emit(NewNavalTacticsLayer.ON_RESEL_SKILL, self.student)

		return
	end, SFX_PANEL)

	return
end

function NewNavalTacticsSelLessonPage:SetHideCallback(arg_7_1)
	self.hideCallback = arg_7_1

	return
end

function NewNavalTacticsSelLessonPage:Show(arg_8_1, arg_8_2)
	NewNavalTacticsSelLessonPage.super.Show(self)

	self.canBack = defaultValue(arg_8_2, true)

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	if arg_8_1 ~= self.student then
		self.selLessonId = nil
		self.spendTime = nil
		self.student = arg_8_1

		self:Flush()
	else
		self:Flush()
	end

	return
end

function NewNavalTacticsSelLessonPage:Cancel()
	self:emit(NewNavalTacticsMediator.ON_CANCEL_ADD_STUDENT)

	return
end

function NewNavalTacticsSelLessonPage:Hide()
	NewNavalTacticsSelLessonPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance().UIMain)

	if self.hideCallback then
		self.hideCallback()

		self.hideCallback = nil
	end

	return
end

function NewNavalTacticsSelLessonPage:Flush()
	local var_11_0 = getProxy(BayProxy):RawGetShipById(self.student.shipId)

	self:UpdateLessons(self.student:getSkillId(var_11_0), var_11_0)

	return
end

function NewNavalTacticsSelLessonPage:GetLessons()
	local var_12_0 = getProxy(BagProxy):getItemsByType(Item.LESSON_TYPE)

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:getConfig("rarity")
		local var_13_1 = arg_13_1:getConfig("rarity")

		if var_13_0 == var_13_1 then
			return arg_13_0.id < arg_13_1.id
		else
			return var_13_1 < var_13_0
		end

		return
	end)

	return var_12_0
end

function NewNavalTacticsSelLessonPage:UpdateLessons(arg_14_1, arg_14_2)
	local var_14_0 = self:GetLessons()

	for iter_14_0 = 1, #var_14_0 do
		local var_14_1 = self.itemTpls[iter_14_0]

		if not self.itemTpls[iter_14_0] then
			var_14_1 = Object.Instantiate(self.itemTpls[1].gameObject, self.itemTpls[1].parent).transform
			self.itemTpls[iter_14_0] = var_14_1
		end

		setActive(var_14_1, true)
		self:UpdateLesson(var_14_1, var_14_0[iter_14_0], arg_14_1, arg_14_2)
	end

	for iter_14_1 = #self.itemTpls, #var_14_0 + 1, -1 do
		setActive(self.itemTpls[iter_14_1], false)
	end

	if #var_14_0 > 0 then
		self.toggleGroup:SetAllTogglesOff()
		triggerToggle(self.itemTpls[1], true)
	end

	return
end

function NewNavalTacticsSelLessonPage:UpdateLesson(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	updateItem(arg_15_1, Item.New({
		id = arg_15_2.id,
		count = arg_15_2.count
	}))
	setText(arg_15_1:Find("icon_bg/count"), arg_15_2.count)

	local var_15_0 = Item.getConfigData(arg_15_2.id)
	local var_15_1 = var_15_0.usage_arg[1]
	local var_15_2 = 100

	if pg.skill_data_template[arg_15_3].type == var_15_0.usage_arg[3] then
		var_15_2 = var_15_2 + var_15_0.usage_arg[4]
	end

	local var_15_3 = var_15_0.usage_arg[2] * (var_15_2 / 100)

	onToggle(self, arg_15_1, function(arg_16_0)
		if arg_16_0 then
			self.selLessonId = arg_15_2.id
			self.spendTime = var_15_1

			self:UpdateLessonDesc(arg_15_2.id, var_15_3, var_15_1)
			self:UpdateSkill(arg_15_3, var_15_3, arg_15_4)
		end

		return
	end, SFX_PANEL)
	setText(arg_15_1:Find("addition"), var_15_2 == 100 and "" or "EXP" .. var_15_2 .. "%")

	return
end

function NewNavalTacticsSelLessonPage:UpdatePosition(arg_17_1, arg_17_2)
	arg_17_1.anchoredPosition = Vector2(self.startPos.x + (((arg_17_2 % self.cloumnCnt == 0 or nil) and self.cloumnCnt) - 1) * (arg_17_1.sizeDelta.x + self.space.x), self.startPos.y - (math.ceil(arg_17_2 / self.cloumnCnt) - 1) * (arg_17_1.sizeDelta.y + self.space.y))

	return
end

function NewNavalTacticsSelLessonPage:UpdateLessonDesc(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = Item.getConfigData(arg_18_1)

	self.lessonNameTxt.text = var_18_0.name .. "   -"
	self.lessonDescTxt.text = var_18_0.display
	self.lessonExpTxt.text = arg_18_2
	self.lessonTimeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(arg_18_3)

	return
end

function NewNavalTacticsSelLessonPage:UpdateSkill(arg_19_1, arg_19_2, arg_19_3)
	self.skillCard:Update(ShipSkill.New(arg_19_3.skills[arg_19_1], arg_19_3.id), arg_19_2)

	return
end

function NewNavalTacticsSelLessonPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	self.skillCard:Dispose()

	self.skillCard = nil

	return
end

return NewNavalTacticsSelLessonPage
