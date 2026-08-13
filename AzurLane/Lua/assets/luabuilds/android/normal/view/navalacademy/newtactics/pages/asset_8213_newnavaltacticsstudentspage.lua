class = var_0_10000

local var_0_0 = "NewNavalTacticsStudentsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_1.getUIName(arg_1_0)
	return "NewNavalTacticsStudentsPage"
end

function var_0_1.OnUnlockSlot(arg_2_0)
	arg_2_0:Flush()

	return
end

function var_0_1.OnAddStudent(arg_3_0)
	arg_3_0:Flush()

	return
end

function var_0_1.OnExitStudent(arg_4_0)
	arg_4_0:Flush()

	return
end

function var_0_1.OnLoaded(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.helpBtn = var_1.Find(var_5_0, "help_btn")

	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_1.Find(var_5_1, "info")
	local var_5_3 = arg_5_0._tf
	local var_5_4 = var_2.Find(var_5_3, "add")
	local var_5_5 = arg_5_0._tf
	local var_5_6 = var_3.Find(var_5_5, "lock")

	arg_5_0.cards = {
		{},
		{},
		{}
	}
	table = var_4

	local var_5_7 = var_4.insert
	local var_5_8 = arg_5_0.cards[var_0_2]

	NewNavalTacticsShipCard = var_6

	var_5_7(var_5_8, var_6.New(var_5_2, arg_5_0.event))

	table = var_5_7

	local var_5_9 = var_5_7.insert
	local var_5_10 = arg_5_0.cards[var_0_3]

	NewNavalTacticsEmptyCard = var_6

	var_5_9(var_5_10, var_6.New(var_5_4, arg_5_0.event))

	table = var_5_9

	local var_5_11 = var_5_9.insert
	local var_5_12 = arg_5_0.cards[var_0_4]

	NewNavalTacticsLockCard = var_6

	var_5_11(var_5_12, var_6.New(var_5_6, arg_5_0.event))

	return
end

function var_0_1.OnInit(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.helpBtn

	local function var_6_2()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_7_2.type = var_2_10003
		pg = var_2_10003
		var_7_2.helps = var_2_10003.gametip.tactics_lesson_system_introduce.tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10005)

	return
end

function var_0_1.Show(arg_8_0, arg_8_1)
	var_0_1.super.Show(arg_8_0)

	arg_8_0.students = arg_8_1

	arg_8_0:Flush()

	return
end

function var_0_1.Flush(arg_9_0)
	local var_9_0 = {
		0,
		0,
		0
	}

	getProxy = var_1_10002
	NavalAcademyProxy = var_1_10003

	local var_9_1 = var_1_10002(var_1_10003)
	local var_9_2 = var_2.getSkillClassNum(var_9_1)
	local var_9_3 = 1

	NavalAcademyProxy = var_1_10004

	for iter_9_0 = var_9_3, var_1_10004.MAX_SKILL_CLASS_NUM do
		var_9_0[var_7] = var_9_0[arg_9_0:GetCardType(iter_9_0, var_9_2)] + 1

		arg_9_0:UpdateTypeCard(var_7, var_9_0[var_7], iter_9_0)
	end

	ipairs = var_9_3

	for iter_9_1, iter_9_2 in var_9_3(var_9_0) do
		arg_9_0:ClearDisableCards(iter_9_1, iter_9_2)
	end

	return
end

function var_0_1.GetCardType(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 < arg_10_1 then
		return var_0_4
	else
		local var_10_0

		if not arg_10_0.students[arg_10_1] or not var_0_2 then
			var_10_0 = var_0_3
		end

		return var_10_0
	end

	return
end

function var_0_1.UpdateTypeCard(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_0.cards[arg_11_1][arg_11_2] then
		local var_11_0 = var_4[1]

		var_4[arg_11_2] = var_6.Clone(var_11_0)
	end

	var_5:Enable()

	local var_11_1 = arg_11_0.students[arg_11_3]

	var_5:Update(arg_11_3, var_11_1)

	return
end

function var_0_1.ClearDisableCards(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 = #arg_12_0.cards[arg_12_1], arg_12_2 + 1, -1 do
		local var_12_0 = var_3[iter_12_0]

		var_8.Disable(var_12_0)
	end

	return
end

function var_0_1.GetCard(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.cards[var_0_2]

	underscore = var_3

	return var_3.detect(var_13_0, function(arg_14_0)
		return arg_14_0.index == arg_13_1
	end)
end

function var_0_1.OnDestroy(arg_15_0)
	ipairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0.cards) do
		ipairs = var_1_10006

		for iter_15_2, iter_15_3 in var_1_10006(iter_15_1) do
			iter_15_3:Dispose()
		end
	end

	arg_15_0.cards = nil

	return
end

return var_0_1
