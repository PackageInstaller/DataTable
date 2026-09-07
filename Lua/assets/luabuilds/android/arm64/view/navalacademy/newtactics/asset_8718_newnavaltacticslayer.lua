local NewNavalTacticsLayer = class("NewNavalTacticsLayer", import("...base.BaseUI"))

NewNavalTacticsLayer.ON_UNLOCK = "NewNavalTacticsLayer:ON_UNLOCK"
NewNavalTacticsLayer.ON_ADD_STUDENT = "NewNavalTacticsLayer:ON_ADD_STUDENT"
NewNavalTacticsLayer.ON_SKILL_SELECTED = "NewNavalTacticsLayer:ON_SKILL_SELECTED"
NewNavalTacticsLayer.ON_RESEL_SKILL = "NewNavalTacticsLayer:ON_RESEL_SKILL"
NewNavalTacticsLayer.ON_LESSON_SELECTED = "NewNavalTacticsLayer:ON_LESSON_SELECTED"
NewNavalTacticsLayer.ON_CANCEL_ADD_STUDENT = "NewNavalTacticsLayer:ON_CANCEL_ADD_STUDENT"

function NewNavalTacticsLayer:getUIName()
	return "NewNavalTacticsUI"
end

function NewNavalTacticsLayer:OnUnlockSlot()
	if self.studentsPage:GetLoaded() then
		self.studentsPage:OnUnlockSlot()
	end

	return
end

function NewNavalTacticsLayer:OnAddStudent()
	if self.studentsPage:GetLoaded() then
		self.studentsPage:OnAddStudent()
	end

	if self.selLessonPage:GetLoaded() and self.selLessonPage:isShowing() then
		self.selLessonPage:Hide()
	end

	return
end

function NewNavalTacticsLayer:ResendCancelOp(arg_4_1)
	self.inAddStudentProcess = false

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		self:emit(NewNavalTacticsMediator.ON_CANCEL, iter_4_1[1], iter_4_1[2])
	end

	return
end

function NewNavalTacticsLayer:OnExitStudent()
	if self.studentsPage:GetLoaded() then
		self.studentsPage:OnExitStudent()
	end

	return
end

function NewNavalTacticsLayer:BlockEvents()
	GetOrAddComponent(self._tf, typeof(CanvasGroup)).blocksRaycasts = false

	return
end

function NewNavalTacticsLayer:UnblockEvents()
	GetOrAddComponent(self._tf, typeof(CanvasGroup)).blocksRaycasts = true

	return
end

function NewNavalTacticsLayer:IsInAddStudentProcess()
	return self.inAddStudentProcess
end

function NewNavalTacticsLayer:OnUpdateMetaSkillPanel(arg_9_1)
	if self.metaSkillPage then
		self.metaSkillPage:reUpdate()
	end

	return
end

function NewNavalTacticsLayer:SetStudents(arg_10_1)
	self.students = arg_10_1

	return
end

function NewNavalTacticsLayer:init()
	self.painting = self._tf:Find("painting"):GetComponent(typeof(Image))
	self.backBtn = self._tf:Find("adpter/frame/btnBack")
	self.option = self._tf:Find("adpter/frame/option")
	self.stampBtn = self._tf:Find("stamp")
	self.quickFinishPanel = self._tf:Find("painting/quick_finish")
	self.quickFinishText = self._tf:Find("painting/quick_finish/Text")
	self.studentsPage = NewNavalTacticsStudentsPage.New(self._tf:Find("adpter"), self.event)
	self.unlockPage = NewNavalTacticsUnlockSlotPage.New(self._tf, self.event)
	self.selSkillPage = NewNavalTacticsSelSkillsPage.New(self._tf, self.event, self.contextData)
	self.selLessonPage = NewNavalTacticsSelLessonPage.New(self._tf, self.event)
	self.finishLessonUtil = NewNavalTacticsFinishLessonUtil.New(self.studentsPage, self.selLessonPage, self.selSkillPage)

	return
end

function NewNavalTacticsLayer:didEnter()
	self:bind(NewNavalTacticsLayer.ON_UNLOCK, function(arg_13_0, arg_13_1)
		self.unlockPage:ExecuteAction("Show", arg_13_1, function()
			self:emit(NewNavalTacticsMediator.ON_SHOPPING, arg_13_1)

			return
		end)

		return
	end)
	self:bind(NewNavalTacticsLayer.ON_ADD_STUDENT, function(arg_15_0, arg_15_1)
		if not getProxy(BagProxy):ExitTypeItems(Item.LESSON_TYPE) then
			if not ItemTipPanel.ShowItemTipbyID(16001, i18n("item_lack_title", i18n("ship_book"), i18n("ship_book"))) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_no_lesson"))
			end

			return
		end

		self:emit(NewNavalTacticsMediator.ON_SELECT_SHIP, arg_15_1)

		return
	end)
	self:bind(NewNavalTacticsLayer.ON_SKILL_SELECTED, function(arg_16_0, arg_16_1)
		self.selLessonPage:ExecuteAction("Show", arg_16_1)
		self.selSkillPage:Hide()

		return
	end)
	self:bind(NewNavalTacticsLayer.ON_RESEL_SKILL, function(arg_17_0, arg_17_1)
		self.selLessonPage:Hide()
		self.selSkillPage:Show(arg_17_1)

		return
	end)
	self:bind(NewNavalTacticsLayer.ON_LESSON_SELECTED, function(arg_18_0, arg_18_1)
		self:AddStudentFinish(arg_18_1)

		return
	end)
	setActive(self.stampBtn, getProxy(TaskProxy):mingshiTouchFlagEnabled())

	if LOCK_CLICK_MINGSHI then
		setActive(self.stampBtn, false)
	end

	onButton(self, self.stampBtn, function()
		getProxy(TaskProxy):dealMingshiTouchFlag(3)

		return
	end, SFX_CONFIRM)
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.option, function()
		self:emit(NewNavalTacticsLayer.ON_HOME)

		return
	end, SFX_PANEL)
	self:SetPainting()
	self:Init()
	self:OnUpdateQuickFinishPanel()
	self.studentsPage:ExecuteAction("Show", self.students)

	return
end

function NewNavalTacticsLayer:Init()
	if self.contextData.shipToLesson then
		self.inAddStudentProcess = true

		self:AddStudent(self.contextData.shipToLesson.shipId, self.contextData.shipToLesson.index, self.contextData.shipToLesson.skillIndex)

		self.contextData.shipToLesson = nil
	elseif self.contextData.metaShipID then
		self.inAddStudentProcess = true

		self:ShowMetaShipSkill(self.contextData.metaShipID)

		self.contextData.metaShipID = nil
	end

	return
end

function NewNavalTacticsLayer:OnUpdateQuickFinishPanel()
	local var_23_0 = getProxy(NavalAcademyProxy):getDailyFinishCnt()

	setActive(self.quickFinishPanel, var_23_0 > 0)
	setText(self.quickFinishText, i18n("skill_learn_tip", var_23_0))

	return
end

function NewNavalTacticsLayer:SetPainting()
	ResourceMgr.Inst:getAssetAsync("Clutter/class_painting", "", typeof(Sprite), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_25_0)
		self.painting.sprite = arg_25_0

		self.painting:SetNativeSize()

		return
	end), true, true)

	return
end

function NewNavalTacticsLayer:ShowMetaShipSkill(arg_26_1)
	self.metaSkillPage = NavalTacticsMetaSkillsView.New(self._tf, self.event)

	self.metaSkillPage:Reset()
	self.metaSkillPage:Load()
	self.metaSkillPage:setData(arg_26_1, function()
		self.inAddStudentProcess = false

		self.metaSkillPage:Destroy()

		self.metaSkillPage = nil

		return
	end)

	return
end

function NewNavalTacticsLayer:AddStudent(arg_28_1, arg_28_2, arg_28_3)
	self.selSkillPage:ExecuteAction("Show", Student.New({
		id = arg_28_2,
		ship_id = arg_28_1
	}), arg_28_3)

	return
end

function NewNavalTacticsLayer:AddStudentFinish(arg_29_1)
	local var_29_0 = getProxy(BayProxy):RawGetShipById(arg_29_1.shipId)

	if var_29_0:isActivityNpc() then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("npc_learn_skill_tip"),
			onYes = function()
				self:StartLesson(arg_29_1, var_29_0)

				return
			end
		})
	else
		self:StartLesson(arg_29_1, var_29_0)
	end

	return
end

function NewNavalTacticsLayer:StartLesson(arg_31_1, arg_31_2)
	local var_31_0 = ShipSkill.New(arg_31_2.skills[arg_31_1:getSkillId(arg_31_2)], arg_31_2.id)

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("tactics_lesson_start_tip", Item.getConfigData(arg_31_1.lessonId).name, arg_31_2:getName(), (var_31_0:GetName())),
		onYes = function()
			if var_31_0:IsMaxLevel() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_max_level"))

				return
			end

			self:emit(NewNavalTacticsMediator.ON_START, {
				shipId = arg_31_1.shipId,
				skillPos = arg_31_1:getSkillId(arg_31_2),
				lessonId = arg_31_1.lessonId,
				roomId = arg_31_1.id
			})

			return
		end
	})

	return
end

function NewNavalTacticsLayer:onBackPressed()
	if self.finishLessonUtil:IsWorking() then
		return
	end

	NewNavalTacticsLayer.super.onBackPressed(self)

	return
end

function NewNavalTacticsLayer:willExit()
	if self.studentsPage then
		self.studentsPage:Destroy()

		self.studentsPage = nil
	end

	if self.unlockPage then
		self.unlockPage:Destroy()

		self.unlockPage = nil
	end

	if self.selSkillPage then
		self.selSkillPage:Destroy()

		self.selSkillPage = nil
	end

	if self.selLessonPage then
		self.selLessonPage:Destroy()

		self.selLessonPage = nil
	end

	if self.finishLessonUtil then
		self.finishLessonUtil:Dispose()

		self.finishLessonUtil = nil
	end

	if self.metaSkillPage then
		self.metaSkillPage:Destroy()

		self.metaSkillPage = nil
	end

	return
end

return NewNavalTacticsLayer
