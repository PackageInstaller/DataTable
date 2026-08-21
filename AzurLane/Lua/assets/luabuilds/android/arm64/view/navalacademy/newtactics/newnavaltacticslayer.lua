local var_0_0 = class("NewNavalTacticsLayer", import("...base.BaseUI"))

var_0_0.ON_UNLOCK = "NewNavalTacticsLayer:ON_UNLOCK"
var_0_0.ON_ADD_STUDENT = "NewNavalTacticsLayer:ON_ADD_STUDENT"
var_0_0.ON_SKILL_SELECTED = "NewNavalTacticsLayer:ON_SKILL_SELECTED"
var_0_0.ON_RESEL_SKILL = "NewNavalTacticsLayer:ON_RESEL_SKILL"
var_0_0.ON_LESSON_SELECTED = "NewNavalTacticsLayer:ON_LESSON_SELECTED"
var_0_0.ON_CANCEL_ADD_STUDENT = "NewNavalTacticsLayer:ON_CANCEL_ADD_STUDENT"

function var_0_0.getUIName(arg_1_0)
	return "NewNavalTacticsUI"
end

function var_0_0.OnUnlockSlot(arg_2_0)
	if arg_2_0.studentsPage:GetLoaded() then
		arg_2_0.studentsPage:OnUnlockSlot()
	end

	return
end

function var_0_0.OnAddStudent(arg_3_0)
	if arg_3_0.studentsPage:GetLoaded() then
		arg_3_0.studentsPage:OnAddStudent()
	end

	if arg_3_0.selLessonPage:GetLoaded() and arg_3_0.selLessonPage:isShowing() then
		arg_3_0.selLessonPage:Hide()
	end

	return
end

function var_0_0.ResendCancelOp(arg_4_0, arg_4_1)
	arg_4_0.inAddStudentProcess = false

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:emit(NewNavalTacticsMediator.ON_CANCEL, iter_4_1[1], iter_4_1[2])
	end

	return
end

function var_0_0.OnExitStudent(arg_5_0)
	if arg_5_0.studentsPage:GetLoaded() then
		arg_5_0.studentsPage:OnExitStudent()
	end

	return
end

function var_0_0.BlockEvents(arg_6_0)
	GetOrAddComponent(arg_6_0._tf, typeof(CanvasGroup)).blocksRaycasts = false

	return
end

function var_0_0.UnblockEvents(arg_7_0)
	GetOrAddComponent(arg_7_0._tf, typeof(CanvasGroup)).blocksRaycasts = true

	return
end

function var_0_0.IsInAddStudentProcess(arg_8_0)
	return arg_8_0.inAddStudentProcess
end

function var_0_0.OnUpdateMetaSkillPanel(arg_9_0, arg_9_1)
	if arg_9_0.metaSkillPage then
		arg_9_0.metaSkillPage:reUpdate()
	end

	return
end

function var_0_0.SetStudents(arg_10_0, arg_10_1)
	arg_10_0.students = arg_10_1

	return
end

function var_0_0.init(arg_11_0)
	arg_11_0.painting = arg_11_0._tf:Find("painting"):GetComponent(typeof(Image))
	arg_11_0.backBtn = arg_11_0._tf:Find("adpter/frame/btnBack")
	arg_11_0.option = arg_11_0._tf:Find("adpter/frame/option")
	arg_11_0.stampBtn = arg_11_0._tf:Find("stamp")
	arg_11_0.quickFinishPanel = arg_11_0._tf:Find("painting/quick_finish")
	arg_11_0.quickFinishText = arg_11_0._tf:Find("painting/quick_finish/Text")
	arg_11_0.studentsPage = NewNavalTacticsStudentsPage.New(arg_11_0._tf:Find("adpter"), arg_11_0.event)
	arg_11_0.unlockPage = NewNavalTacticsUnlockSlotPage.New(arg_11_0._tf, arg_11_0.event)
	arg_11_0.selSkillPage = NewNavalTacticsSelSkillsPage.New(arg_11_0._tf, arg_11_0.event, arg_11_0.contextData)
	arg_11_0.selLessonPage = NewNavalTacticsSelLessonPage.New(arg_11_0._tf, arg_11_0.event)
	arg_11_0.finishLessonUtil = NewNavalTacticsFinishLessonUtil.New(arg_11_0.studentsPage, arg_11_0.selLessonPage, arg_11_0.selSkillPage)

	return
end

function var_0_0.didEnter(arg_12_0)
	arg_12_0:bind(var_0_0.ON_UNLOCK, function(arg_13_0, arg_13_1)
		arg_12_0.unlockPage:ExecuteAction("Show", arg_13_1, function()
			arg_12_0:emit(NewNavalTacticsMediator.ON_SHOPPING, arg_13_1)

			return
		end)

		return
	end)
	arg_12_0:bind(var_0_0.ON_ADD_STUDENT, function(arg_15_0, arg_15_1)
		if not getProxy(BagProxy):ExitTypeItems(Item.LESSON_TYPE) then
			if not ItemTipPanel.ShowItemTipbyID(16001, i18n("item_lack_title", i18n("ship_book"), i18n("ship_book"))) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_no_lesson"))
			end

			return
		end

		arg_12_0:emit(NewNavalTacticsMediator.ON_SELECT_SHIP, arg_15_1)

		return
	end)
	arg_12_0:bind(var_0_0.ON_SKILL_SELECTED, function(arg_16_0, arg_16_1)
		arg_12_0.selLessonPage:ExecuteAction("Show", arg_16_1)
		arg_12_0.selSkillPage:Hide()

		return
	end)
	arg_12_0:bind(var_0_0.ON_RESEL_SKILL, function(arg_17_0, arg_17_1)
		arg_12_0.selLessonPage:Hide()
		arg_12_0.selSkillPage:Show(arg_17_1)

		return
	end)
	arg_12_0:bind(var_0_0.ON_LESSON_SELECTED, function(arg_18_0, arg_18_1)
		arg_12_0:AddStudentFinish(arg_18_1)

		return
	end)
	setActive(arg_12_0.stampBtn, getProxy(TaskProxy):mingshiTouchFlagEnabled())

	if LOCK_CLICK_MINGSHI then
		setActive(arg_12_0.stampBtn, false)
	end

	onButton(arg_12_0, arg_12_0.stampBtn, function()
		getProxy(TaskProxy):dealMingshiTouchFlag(3)

		return
	end, SFX_CONFIRM)
	onButton(arg_12_0, arg_12_0.backBtn, function()
		arg_12_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_12_0, arg_12_0.option, function()
		arg_12_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	arg_12_0:SetPainting()
	arg_12_0:Init()
	arg_12_0:OnUpdateQuickFinishPanel()
	arg_12_0.studentsPage:ExecuteAction("Show", arg_12_0.students)

	return
end

function var_0_0.Init(arg_22_0)
	if arg_22_0.contextData.shipToLesson then
		arg_22_0.inAddStudentProcess = true

		arg_22_0:AddStudent(arg_22_0.contextData.shipToLesson.shipId, arg_22_0.contextData.shipToLesson.index, arg_22_0.contextData.shipToLesson.skillIndex)

		arg_22_0.contextData.shipToLesson = nil
	elseif arg_22_0.contextData.metaShipID then
		arg_22_0.inAddStudentProcess = true

		arg_22_0:ShowMetaShipSkill(arg_22_0.contextData.metaShipID)

		arg_22_0.contextData.metaShipID = nil
	end

	return
end

function var_0_0.OnUpdateQuickFinishPanel(arg_23_0)
	local var_23_0 = getProxy(NavalAcademyProxy):getDailyFinishCnt()

	setActive(arg_23_0.quickFinishPanel, var_23_0 > 0)
	setText(arg_23_0.quickFinishText, i18n("skill_learn_tip", var_23_0))

	return
end

function var_0_0.SetPainting(arg_24_0)
	ResourceMgr.Inst:getAssetAsync("Clutter/class_painting", "", typeof(Sprite), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_25_0)
		arg_24_0.painting.sprite = arg_25_0

		arg_24_0.painting:SetNativeSize()

		return
	end), true, true)

	return
end

function var_0_0.ShowMetaShipSkill(arg_26_0, arg_26_1)
	arg_26_0.metaSkillPage = NavalTacticsMetaSkillsView.New(arg_26_0._tf, arg_26_0.event)

	arg_26_0.metaSkillPage:Reset()
	arg_26_0.metaSkillPage:Load()
	arg_26_0.metaSkillPage:setData(arg_26_1, function()
		arg_26_0.inAddStudentProcess = false

		arg_26_0.metaSkillPage:Destroy()

		arg_26_0.metaSkillPage = nil

		return
	end)

	return
end

function var_0_0.AddStudent(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0.selSkillPage:ExecuteAction("Show", Student.New({
		id = arg_28_2,
		ship_id = arg_28_1
	}), arg_28_3)

	return
end

function var_0_0.AddStudentFinish(arg_29_0, arg_29_1)
	local var_29_0 = getProxy(BayProxy):RawGetShipById(arg_29_1.shipId)

	if var_29_0:isActivityNpc() then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("npc_learn_skill_tip"),
			onYes = function()
				arg_29_0:StartLesson(arg_29_1, var_29_0)

				return
			end
		})
	else
		arg_29_0:StartLesson(arg_29_1, var_29_0)
	end

	return
end

function var_0_0.StartLesson(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = ShipSkill.New(arg_31_2.skills[arg_31_1:getSkillId(arg_31_2)], arg_31_2.id)

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("tactics_lesson_start_tip", Item.getConfigData(arg_31_1.lessonId).name, arg_31_2:getName(), (ShipSkill.New(arg_31_2.skills[arg_31_1:getSkillId(arg_31_2)], arg_31_2.id):GetName())),
		onYes = function()
			if var_31_0:IsMaxLevel() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_max_level"))

				return
			end

			arg_31_0:emit(NewNavalTacticsMediator.ON_START, {
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

function var_0_0.onBackPressed(arg_33_0)
	if arg_33_0.finishLessonUtil:IsWorking() then
		return
	end

	var_0_0.super.onBackPressed(arg_33_0)

	return
end

function var_0_0.willExit(arg_34_0)
	if arg_34_0.studentsPage then
		arg_34_0.studentsPage:Destroy()

		arg_34_0.studentsPage = nil
	end

	if arg_34_0.unlockPage then
		arg_34_0.unlockPage:Destroy()

		arg_34_0.unlockPage = nil
	end

	if arg_34_0.selSkillPage then
		arg_34_0.selSkillPage:Destroy()

		arg_34_0.selSkillPage = nil
	end

	if arg_34_0.selLessonPage then
		arg_34_0.selLessonPage:Destroy()

		arg_34_0.selLessonPage = nil
	end

	if arg_34_0.finishLessonUtil then
		arg_34_0.finishLessonUtil:Dispose()

		arg_34_0.finishLessonUtil = nil
	end

	if arg_34_0.metaSkillPage then
		arg_34_0.metaSkillPage:Destroy()

		arg_34_0.metaSkillPage = nil
	end

	return
end

return var_0_0
