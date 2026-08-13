class = var_0_10000

local var_0_0 = "NewNavalTacticsLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

var_0_1.ON_UNLOCK = "NewNavalTacticsLayer:ON_UNLOCK"
var_0_1.ON_ADD_STUDENT = "NewNavalTacticsLayer:ON_ADD_STUDENT"
var_0_1.ON_SKILL_SELECTED = "NewNavalTacticsLayer:ON_SKILL_SELECTED"
var_0_1.ON_RESEL_SKILL = "NewNavalTacticsLayer:ON_RESEL_SKILL"
var_0_1.ON_LESSON_SELECTED = "NewNavalTacticsLayer:ON_LESSON_SELECTED"
var_0_1.ON_CANCEL_ADD_STUDENT = "NewNavalTacticsLayer:ON_CANCEL_ADD_STUDENT"

function var_0_1.getUIName(arg_1_0)
	return "NewNavalTacticsUI"
end

function var_0_1.OnUnlockSlot(arg_2_0)
	local var_2_0 = arg_2_0.studentsPage

	if var_1.GetLoaded(var_2_0) then
		local var_2_1 = arg_2_0.studentsPage

		var_1.OnUnlockSlot(var_2_1)
	end

	return
end

function var_0_1.OnAddStudent(arg_3_0)
	local var_3_0 = arg_3_0.studentsPage

	if var_1.GetLoaded(var_3_0) then
		local var_3_1 = arg_3_0.studentsPage

		var_1.OnAddStudent(var_3_1)
	end

	local var_3_2 = arg_3_0.selLessonPage

	if var_1.GetLoaded(var_3_2) then
		local var_3_3 = arg_3_0.selLessonPage

		if var_1.isShowing(var_3_3) then
			local var_3_4 = arg_3_0.selLessonPage

			var_1.Hide(var_3_4)
		end
	end

	return
end

function var_0_1.ResendCancelOp(arg_4_0, arg_4_1)
	arg_4_0.inAddStudentProcess = false
	ipairs = var_2

	for iter_4_0, iter_4_1 in var_2(arg_4_1) do
		local var_4_0 = arg_4_0
		local var_4_1 = arg_4_0.emit

		NewNavalTacticsMediator = var_1_10009

		var_4_1(var_4_0, var_1_10009.ON_CANCEL, iter_4_1[1], iter_4_1[2])
	end

	return
end

function var_0_1.OnExitStudent(arg_5_0)
	local var_5_0 = arg_5_0.studentsPage

	if var_1.GetLoaded(var_5_0) then
		local var_5_1 = arg_5_0.studentsPage

		var_1.OnExitStudent(var_5_1)
	end

	return
end

function var_0_1.BlockEvents(arg_6_0)
	GetOrAddComponent = var_1_10001

	local var_6_0 = arg_6_0._tf

	typeof = var_1_10003
	CanvasGroup = var_1_10004
	var_1_10001(var_6_0, var_1_10003(var_1_10004)).blocksRaycasts = false

	return
end

function var_0_1.UnblockEvents(arg_7_0)
	GetOrAddComponent = var_1_10001

	local var_7_0 = arg_7_0._tf

	typeof = var_1_10003
	CanvasGroup = var_1_10004
	var_1_10001(var_7_0, var_1_10003(var_1_10004)).blocksRaycasts = true

	return
end

function var_0_1.IsInAddStudentProcess(arg_8_0)
	return arg_8_0.inAddStudentProcess
end

function var_0_1.OnUpdateMetaSkillPanel(arg_9_0, arg_9_1)
	if arg_9_0.metaSkillPage then
		local var_9_0 = arg_9_0.metaSkillPage

		var_2.reUpdate(var_9_0)
	end

	return
end

function var_0_1.SetStudents(arg_10_0, arg_10_1)
	arg_10_0.students = arg_10_1

	return
end

function var_0_1.init(arg_11_0)
	local var_11_0 = arg_11_0._tf
	local var_11_1 = var_1.Find(var_11_0, "painting")
	local var_11_2 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_11_0.painting = var_11_2(var_11_1, var_3(var_1_10004))

	local var_11_3 = arg_11_0._tf

	arg_11_0.backBtn = var_1.Find(var_11_3, "adpter/frame/btnBack")

	local var_11_4 = arg_11_0._tf

	arg_11_0.option = var_1.Find(var_11_4, "adpter/frame/option")

	local var_11_5 = arg_11_0._tf

	arg_11_0.stampBtn = var_1.Find(var_11_5, "stamp")

	local var_11_6 = arg_11_0._tf

	arg_11_0.quickFinishPanel = var_1.Find(var_11_6, "painting/quick_finish")

	local var_11_7 = arg_11_0._tf

	arg_11_0.quickFinishText = var_1.Find(var_11_7, "painting/quick_finish/Text")

	local var_11_8 = arg_11_0._tf
	local var_11_9 = var_1.Find(var_11_8, "adpter")

	NewNavalTacticsStudentsPage = var_11_8
	arg_11_0.studentsPage = var_11_8.New(var_11_9, arg_11_0.event)
	NewNavalTacticsUnlockSlotPage = var_2
	arg_11_0.unlockPage = var_2.New(arg_11_0._tf, arg_11_0.event)
	NewNavalTacticsSelSkillsPage = var_2
	arg_11_0.selSkillPage = var_2.New(arg_11_0._tf, arg_11_0.event, arg_11_0.contextData)
	NewNavalTacticsSelLessonPage = var_2
	arg_11_0.selLessonPage = var_2.New(arg_11_0._tf, arg_11_0.event)
	NewNavalTacticsFinishLessonUtil = var_2
	arg_11_0.finishLessonUtil = var_2.New(arg_11_0.studentsPage, arg_11_0.selLessonPage, arg_11_0.selSkillPage)

	return
end

function var_0_1.didEnter(arg_12_0)
	arg_12_0:bind(var_0_1.ON_UNLOCK, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_12_0.unlockPage

		var_2.ExecuteAction(var_13_0, "Show", arg_13_1, function()
			local var_14_0 = arg_12_0
			local var_14_1 = var_0.emit

			NewNavalTacticsMediator = var_3_10002

			var_14_1(var_14_0, var_3_10002.ON_SHOPPING, arg_13_1)

			return
		end)

		return
	end)
	arg_12_0:bind(var_0_1.ON_ADD_STUDENT, function(arg_15_0, arg_15_1)
		getProxy = var_2_10002
		BagProxy = var_2_10003

		local var_15_0 = var_2_10002(var_2_10003)
		local var_15_1 = var_2.ExitTypeItems

		Item = var_2_10004

		if not var_15_1(var_15_0, var_2_10004.LESSON_TYPE) then
			ItemTipPanel = var_2

			local var_15_2 = var_2.ShowItemTipbyID
			local var_15_3 = 16001

			i18n = var_4

			local var_15_4 = "item_lack_title"

			i18n = var_2_10006

			local var_15_5 = var_2_10006("ship_book")

			i18n = var_7

			if not var_15_2(var_15_3, var_4(var_15_4, var_15_5, var_7("ship_book"))) then
				pg = var_2

				local var_15_6 = var_2.TipsMgr.GetInstance()
				local var_15_7 = var_2.ShowTips

				i18n = var_4

				var_15_7(var_15_6, var_4("tactics_no_lesson"))
			end

			return
		end

		local var_15_8 = arg_12_0
		local var_15_9 = var_2.emit

		NewNavalTacticsMediator = var_4

		var_15_9(var_15_8, var_4.ON_SELECT_SHIP, arg_15_1)

		return
	end)
	arg_12_0:bind(var_0_1.ON_SKILL_SELECTED, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_12_0.selLessonPage

		var_2.ExecuteAction(var_16_0, "Show", arg_16_1)

		local var_16_1 = arg_12_0.selSkillPage

		var_2.Hide(var_16_1)

		return
	end)
	arg_12_0:bind(var_0_1.ON_RESEL_SKILL, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_12_0.selLessonPage

		var_2.Hide(var_17_0)

		local var_17_1 = arg_12_0.selSkillPage

		var_2.Show(var_17_1, arg_17_1)

		return
	end)
	arg_12_0:bind(var_0_1.ON_LESSON_SELECTED, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_12_0

		var_2.AddStudentFinish(var_18_0, arg_18_1)

		return
	end)

	setActive = var_1

	local var_12_0 = arg_12_0.stampBtn

	getProxy = var_3
	TaskProxy = var_4

	local var_12_1 = var_3(var_4)

	var_1(var_12_0, var_3.mingshiTouchFlagEnabled(var_12_1))

	LOCK_CLICK_MINGSHI = var_1

	if var_1 then
		setActive = var_1

		var_1(arg_12_0.stampBtn, false)
	end

	onButton = var_1

	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0.stampBtn

	local function var_12_4()
		getProxy = var_2_10000
		TaskProxy = var_2_10001

		local var_19_0 = var_2_10000(var_2_10001)

		var_0.dealMingshiTouchFlag(var_19_0, 3)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_12_2, var_12_3, var_12_4, var_1_10005)

	onButton = var_1

	local var_12_5 = arg_12_0
	local var_12_6 = arg_12_0.backBtn

	local function var_12_7()
		local var_20_0 = arg_12_0

		var_0.closeView(var_20_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_12_5, var_12_6, var_12_7, var_1_10005)

	onButton = var_1

	local var_12_8 = arg_12_0
	local var_12_9 = arg_12_0.option

	local function var_12_10()
		local var_21_0 = arg_12_0

		var_0.emit(var_21_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_12_8, var_12_9, var_12_10, var_1_10005)
	arg_12_0:SetPainting()
	arg_12_0:Init()
	arg_12_0:OnUpdateQuickFinishPanel()

	local var_12_11 = arg_12_0.studentsPage

	var_1.ExecuteAction(var_12_11, "Show", arg_12_0.students)

	return
end

function var_0_1.Init(arg_22_0)
	if arg_22_0.contextData.shipToLesson then
		arg_22_0.inAddStudentProcess = true

		local var_22_0 = arg_22_0.contextData.shipToLesson.skillIndex
		local var_22_1 = arg_22_0.contextData.shipToLesson.shipId
		local var_22_2 = arg_22_0.contextData.shipToLesson.index

		arg_22_0:AddStudent(var_22_1, var_22_2, var_22_0)

		arg_22_0.contextData.shipToLesson = nil
	elseif arg_22_0.contextData.metaShipID then
		arg_22_0.inAddStudentProcess = true

		local var_22_3 = arg_22_0.contextData.metaShipID

		arg_22_0:ShowMetaShipSkill(var_22_3)

		arg_22_0.contextData.metaShipID = nil
	end

	return
end

function var_0_1.OnUpdateQuickFinishPanel(arg_23_0)
	getProxy = var_1_10001
	NavalAcademyProxy = var_1_10002

	local var_23_0 = var_1_10001(var_1_10002)
	local var_23_1 = var_1.getDailyFinishCnt(var_23_0)

	setActive = var_23_0

	var_23_0(arg_23_0.quickFinishPanel, var_23_1 > 0)

	setText = var_23_0

	local var_23_2 = arg_23_0.quickFinishText

	i18n = var_4

	var_23_0(var_23_2, var_4("skill_learn_tip", var_23_1))

	return
end

function var_0_1.SetPainting(arg_24_0)
	ResourceMgr = var_1_10001

	local var_24_0 = var_1_10001.Inst
	local var_24_1 = var_1.getAssetAsync
	local var_24_2 = "Clutter/class_painting"
	local var_24_3 = ""

	typeof = var_1_10005
	Sprite = var_1_10006

	local var_24_4 = var_1_10005(var_1_10006)

	UnityEngine = var_1_10006

	var_24_1(var_24_0, var_24_2, var_24_3, var_24_4, var_1_10006.Events.UnityAction_UnityEngine_Object(function(arg_25_0)
		arg_24_0.painting.sprite = arg_25_0

		local var_25_0 = arg_24_0.painting

		var_1.SetNativeSize(var_25_0)

		return
	end), true, true)

	return
end

function var_0_1.ShowMetaShipSkill(arg_26_0, arg_26_1)
	NavalTacticsMetaSkillsView = var_1_10002
	arg_26_0.metaSkillPage = var_1_10002.New(arg_26_0._tf, arg_26_0.event)

	local var_26_0 = arg_26_0.metaSkillPage

	var_2.Reset(var_26_0)

	local var_26_1 = arg_26_0.metaSkillPage

	var_2.Load(var_26_1)

	local var_26_2 = arg_26_0.metaSkillPage

	var_2.setData(var_26_2, arg_26_1, function()
		arg_26_0.inAddStudentProcess = false

		local var_27_0 = arg_26_0.metaSkillPage

		var_0.Destroy(var_27_0)

		arg_26_0.metaSkillPage = nil

		return
	end)

	return
end

function var_0_1.AddStudent(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	Student = var_1_10004

	local var_28_0 = var_1_10004.New({
		id = arg_28_2,
		ship_id = arg_28_1
	})
	local var_28_1 = arg_28_0.selSkillPage

	var_5.ExecuteAction(var_28_1, "Show", var_28_0, arg_28_3)

	return
end

function var_0_1.AddStudentFinish(arg_29_0, arg_29_1)
	getProxy = var_1_10002
	BayProxy = var_1_10003

	local var_29_0 = var_1_10002(var_1_10003)
	local var_29_1 = var_2.RawGetShipById(var_29_0, arg_29_1.shipId)

	if var_2.isActivityNpc(var_29_1) then
		pg = var_3

		local var_29_2 = var_3.MsgboxMgr.GetInstance()
		local var_29_3 = var_3.ShowMsgBox
		local var_29_4 = {}

		i18n = var_1_10006
		var_29_4.content = var_1_10006("npc_learn_skill_tip")

		function var_29_4.onYes()
			local var_30_0 = arg_29_0

			var_0.StartLesson(var_30_0, arg_29_1, var_0)

			return
		end

		var_29_3(var_29_2, var_29_4)
	else
		arg_29_0:StartLesson(arg_29_1, var_2)
	end

	return
end

function var_0_1.StartLesson(arg_31_0, arg_31_1, arg_31_2)
	Item = var_1_10003

	local var_31_0 = var_1_10003.getConfigData(arg_31_1.lessonId).name
	local var_31_1 = arg_31_1:getSkillId(arg_31_2)
	local var_31_2 = arg_31_2
	local var_31_3 = arg_31_2.getName(var_31_2)

	ShipSkill = var_31_2

	local var_31_4 = var_31_2.New(arg_31_2.skills[var_31_1], arg_31_2.id)
	local var_31_5 = var_6.GetName(var_31_4)

	pg = var_31_4

	local var_31_6 = var_31_4.MsgboxMgr.GetInstance()
	local var_31_7 = var_8.ShowMsgBox
	local var_31_8 = {}

	i18n = var_1_10011
	var_31_8.content = var_1_10011("tactics_lesson_start_tip", var_31_0, var_31_3, var_31_5)

	function var_31_8.onYes()
		local var_32_0 = var_0

		if var_0.IsMaxLevel(var_32_0) then
			pg = var_0

			local var_32_1 = var_0.TipsMgr.GetInstance()
			local var_32_2 = var_0.ShowTips

			i18n = var_2_10002

			var_32_2(var_32_1, var_2_10002("tactics_max_level"))

			return
		end

		local var_32_3 = arg_31_0
		local var_32_4 = var_0.emit

		NewNavalTacticsMediator = var_2_10002

		local var_32_5 = var_2_10002.ON_START
		local var_32_6 = {
			shipId = arg_31_1.shipId
		}
		local var_32_7 = arg_31_1

		var_32_6.skillPos = var_4.getSkillId(var_32_7, arg_31_2)
		var_32_6.lessonId = arg_31_1.lessonId
		var_32_6.roomId = arg_31_1.id

		var_32_4(var_32_3, var_32_5, var_32_6)

		return
	end

	var_31_7(var_31_6, var_31_8)

	return
end

function var_0_1.onBackPressed(arg_33_0)
	local var_33_0 = arg_33_0.finishLessonUtil

	if var_1.IsWorking(var_33_0) then
		return
	end

	var_0_1.super.onBackPressed(arg_33_0)

	return
end

function var_0_1.willExit(arg_34_0)
	if arg_34_0.studentsPage then
		local var_34_0 = arg_34_0.studentsPage

		var_1.Destroy(var_34_0)

		arg_34_0.studentsPage = nil
	end

	if arg_34_0.unlockPage then
		local var_34_1 = arg_34_0.unlockPage

		var_1.Destroy(var_34_1)

		arg_34_0.unlockPage = nil
	end

	if arg_34_0.selSkillPage then
		local var_34_2 = arg_34_0.selSkillPage

		var_1.Destroy(var_34_2)

		arg_34_0.selSkillPage = nil
	end

	if arg_34_0.selLessonPage then
		local var_34_3 = arg_34_0.selLessonPage

		var_1.Destroy(var_34_3)

		arg_34_0.selLessonPage = nil
	end

	if arg_34_0.finishLessonUtil then
		local var_34_4 = arg_34_0.finishLessonUtil

		var_1.Dispose(var_34_4)

		arg_34_0.finishLessonUtil = nil
	end

	if arg_34_0.metaSkillPage then
		local var_34_5 = arg_34_0.metaSkillPage

		var_1.Destroy(var_34_5)

		arg_34_0.metaSkillPage = nil
	end

	return
end

return var_0_1
