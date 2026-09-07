local ClassLayer = class("ClassLayer", import("...base.BaseUI"))

function ClassLayer:getUIName()
	return "ClassUI"
end

function ClassLayer:SetStudents(arg_2_1)
	self.shipGroups = arg_2_1

	return
end

function ClassLayer:SetCourse(arg_3_1)
	self.course = arg_3_1

	return
end

function ClassLayer:SetClass(arg_4_1)
	self.resClass = arg_4_1

	return
end

function ClassLayer:OnUpdateResField(arg_5_1)
	if not isa(arg_5_1, ClassResourceField) then
		return
	end

	self:SetClass(arg_5_1)
	self:InitClassInfo()

	if self.resFieldPage:GetLoaded() and self.resFieldPage:isShowing() then
		self.resFieldPage:Update(arg_5_1)
	end

	return
end

function ClassLayer:init()
	self.backBtn = self._tf:Find("blur_panel/adapt/top/back")
	self.lessonTxt = self._tf:Find("blur_panel/adapt/bottom/lesson/mask/Text"):GetComponent("ScrollText")
	self.tranSpeedTxt = self._tf:Find("blur_panel/adapt/bottom/progress/proficiency/value"):GetComponent(typeof(Text))
	self.proficiencyProgressTxt = self._tf:Find("blur_panel/adapt/bottom/progress/proficiency/Text"):GetComponent(typeof(Text))
	self.proficiencyProgress = self._tf:Find("blur_panel/adapt/bottom/progress/proficiency/slider/Image")
	self.tranProgressTxt = self._tf:Find("blur_panel/adapt/bottom/progress/book/Text/value"):GetComponent(typeof(Text))
	self.tranProgress = self._tf:Find("blur_panel/adapt/bottom/progress/book/slider/Image")
	self.exp2ProficiencyRatioTxt = self._tf:Find("blur_panel/adapt/top/proficiency/Text"):GetComponent(typeof(Text))
	self.exp2ProficiencyRatio = self._tf:Find("blur_panel/adapt/top/proficiency")
	self.chatProficiency = self._tf:Find("blur_panel/adapt/top/proficiency/chat")
	self.chatProficiencyTxt = self.chatProficiency:Find("Text"):GetComponent(typeof(Text))
	self.helpBtn = self._tf:Find("blur_panel/adapt/top/btn_help")
	self.upgradeBtn = self._tf:Find("blur_panel/adapt/bottom/upgarde")
	self.teacherSeat = self._tf:Find("scene/desk0")
	self.studentSeats = {
		self._tf:Find("scene/desk1"),
		self._tf:Find("scene/desk2"),
		self._tf:Find("scene/desk3"),
		self._tf:Find("scene/desk4"),
		self._tf:Find("scene/desk5")
	}

	setText(self._tf:Find("blur_panel/adapt/bottom/progress/book/Text/label"), i18n("class_label_gen"))
	setText(self._tf:Find("blur_panel/adapt/bottom/progress/proficiency/label"), i18n("class_label_tran"))
	setText(self._tf:Find("blur_panel/adapt/bottom/upgarde/Text"), i18n("word_levelup"))

	self.chars = {}
	self.resFieldPage = ClassResourcePage.New(self._tf, self.event)

	return
end

function ClassLayer:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(BaseUI.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("course_class_help")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.upgradeBtn, function()
		self.resFieldPage:ExecuteAction("Flush", self.resClass)

		return
	end, SFX_PANEL)
	onButton(self, self.exp2ProficiencyRatio, function()
		self.chatProficiencyTxt.text = i18n("course_proficiency_tip", pg.gameset.level_get_proficency.key_value, self.resClass:GetExp2ProficiencyRatio() * self.course:getExtraRate())

		self:DisplayChatContent()

		return
	end, SFX_PANEL)

	self.students = self:FilterStudents()

	self:InitClassInfo()
	self:LoadClassRoom()

	return
end

function ClassLayer:DisplayChatContent()
	setActive(self.chatProficiency, true)
	setButtonEnabled(self.exp2ProficiencyRatio, false)
	LeanTween.scale(rtf(self.chatProficiency), Vector3(1.5, 1.5, 1), 0.3):setFrom(Vector3.zero):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(self.chatProficiency), Vector3(0, 0, 0), 0.2):setDelay(2):setOnComplete(System.Action(function()
			if not IsNil(self.exp2ProficiencyRatio) then
				setButtonEnabled(self.exp2ProficiencyRatio, true)
				setActive(self.chatProficiency, false)
			end

			return
		end))

		return
	end))

	return
end

function ClassLayer:FilterStudents()
	local var_15_0 = {}
	local var_15_1 = self.course:getConfig("type")

	for iter_15_0, iter_15_1 in pairs(self.shipGroups) do
		if table.contains(var_15_1, iter_15_1.shipConfig.type) then
			table.insert(var_15_0, iter_15_1)
		end
	end

	if #var_15_0 > #self.studentSeats then
		shuffle(var_15_0)
	end

	return var_15_0
end

function ClassLayer:InitClassInfo()
	self.lessonTxt:SetText(i18n("course_class_name", self.course:getConfig("name_show")))

	self.tranSpeedTxt.text = "-" .. self.resClass:GetTranValuePreHour() .. "/h"

	local var_16_0 = self.course:GetProficiency()
	local var_16_1 = self.resClass:GetMaxProficiency()

	self.proficiencyProgressTxt.text = var_16_0 .. "/" .. var_16_1

	setFillAmount(self.proficiencyProgress, var_16_0 / var_16_1)

	local var_16_2 = self.resClass:GetTarget()
	local var_16_3 = self.resClass:GetPlayerRes() % var_16_2

	self.tranProgressTxt.text = " <color=#92FC63FF>" .. var_16_3 .. "</color>/" .. var_16_2

	setFillAmount(self.tranProgress, var_16_3 / var_16_2)

	self.exp2ProficiencyRatioTxt.text = self.resClass:GetExp2ProficiencyRatio() * self.course:getExtraRate() .. "%"

	return
end

function ClassLayer:LoadClassRoom()
	local var_17_0 = {}

	for iter_17_0 = 1, math.min(#self.students, #self.studentSeats) do
		table.insert(var_17_0, function(arg_18_0)
			self:LoadChar(self.students[iter_17_0]:GetSkin().prefab, function(arg_19_0)
				self:AddStudent(arg_19_0, self.studentSeats[iter_17_0])
				arg_18_0()

				return
			end)

			return
		end)
	end

	table.insert(var_17_0, function(arg_20_0)
		self:LoadChar(Ship.New({
			configId = self.course:getConfig("id")
		}):getPrefab(), function(arg_21_0)
			self:AddTeacher(arg_21_0, self.teacherSeat)
			arg_20_0()

			return
		end)

		return
	end)
	pg.UIMgr.GetInstance():LoadingOn()
	seriesAsync(var_17_0, function()
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function ClassLayer:AddStudent(arg_23_1, arg_23_2)
	arg_23_1:SetLocalScale(Vector3(-0.9, 0.9, 1))
	arg_23_1:SetLocalPosition(Vector3(37, 62, 0))
	arg_23_1:SetParent(arg_23_2)
	setActive(arg_23_2:Find("icon"), true)
	arg_23_1:SetAction("sit", 0)
	arg_23_1:SetSiblingIndex(0)

	return
end

function ClassLayer:AddTeacher(arg_24_1, arg_24_2)
	arg_24_1:SetLocalScale(Vector3(0.9, 0.9, 1))
	arg_24_1:SetLocalPosition(Vector3(0, 0, 0))
	arg_24_1:SetParent(arg_24_2)
	arg_24_1:SetAction("stand2", 0)

	return
end

function ClassLayer:willExit()
	self:ClearChars()
	self.resFieldPage:Destroy()

	self.resFieldPage = nil

	return
end

function ClassLayer:LoadChar(arg_26_1, arg_26_2)
	local var_26_0 = SpineAnimChar.New()

	var_26_0:SetPaint(arg_26_1)
	var_26_0:Load(true, function(arg_27_0)
		if self.exited then
			arg_27_0:Dispose()

			return
		end

		arg_27_0:SetLayer(Layer.UI)

		self.chars[arg_26_1] = arg_27_0

		arg_26_2(arg_27_0)

		return
	end)

	return
end

function ClassLayer:ClearChars()
	for iter_28_0, iter_28_1 in pairs(self.chars) do
		iter_28_1:Dispose()
	end

	self.chars = {}

	return
end

function ClassLayer:onBackPressed()
	if self.resFieldPage and self.resFieldPage:GetLoaded() and self.resFieldPage:isShowing() then
		self.resFieldPage:Hide()

		return
	end

	ClassLayer.super.onBackPressed(self)

	return
end

return ClassLayer
