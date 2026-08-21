local var_0_0 = class("NewNavalTacticsStudentsPage", import("....base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function var_0_0.getUIName(arg_1_0)
	return "NewNavalTacticsStudentsPage"
end

function var_0_0.OnUnlockSlot(arg_2_0)
	arg_2_0:Flush()

	return
end

function var_0_0.OnAddStudent(arg_3_0)
	arg_3_0:Flush()

	return
end

function var_0_0.OnExitStudent(arg_4_0)
	arg_4_0:Flush()

	return
end

function var_0_0.OnLoaded(arg_5_0)
	arg_5_0.helpBtn = arg_5_0._tf:Find("help_btn")
	arg_5_0.cards = {
		{},
		{},
		{}
	}

	table.insert(arg_5_0.cards[var_0_1], NewNavalTacticsShipCard.New(arg_5_0._tf:Find("info"), arg_5_0.event))
	table.insert(arg_5_0.cards[var_0_2], NewNavalTacticsEmptyCard.New(arg_5_0._tf:Find("add"), arg_5_0.event))
	table.insert(arg_5_0.cards[var_0_3], NewNavalTacticsLockCard.New(arg_5_0._tf:Find("lock"), arg_5_0.event))

	return
end

function var_0_0.OnInit(arg_6_0)
	onButton(arg_6_0, arg_6_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.tactics_lesson_system_introduce.tip
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_8_0, arg_8_1)
	var_0_0.super.Show(arg_8_0)

	arg_8_0.students = arg_8_1

	arg_8_0:Flush()

	return
end

function var_0_0.Flush(arg_9_0)
	local var_9_0 = getProxy(NavalAcademyProxy):getSkillClassNum()

	for iter_9_0 = 1, NavalAcademyProxy.MAX_SKILL_CLASS_NUM do
		local var_9_1 = arg_9_0:GetCardType(iter_9_0, var_9_0)

		;({
			0,
			0,
			0
		})[var_9_1] = ({
			0,
			0,
			0
		})[var_9_1] + 1

		arg_9_0:UpdateTypeCard(var_9_1, ({
			0,
			0,
			0
		})[var_9_1], iter_9_0)
	end

	for iter_9_1, iter_9_2 in ipairs({
		0,
		0,
		0
	}) do
		arg_9_0:ClearDisableCards(iter_9_1, iter_9_2)
	end

	return
end

function var_0_0.GetCardType(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 < arg_10_1 then
		do return var_0_3 end

		goto label_10_0
	end

	::label_10_0::

	if arg_10_0.students[arg_10_1] then
		do
			return var_0_1 or var_0_2
		end

		return
	end
end

function var_0_0.UpdateTypeCard(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0.cards[arg_11_1][arg_11_2]

	if not arg_11_0.cards[arg_11_1][arg_11_2] then
		var_11_0 = arg_11_0.cards[arg_11_1][1]:Clone()
		arg_11_0.cards[arg_11_1][arg_11_2] = var_11_0
	end

	var_11_0:Enable()
	var_11_0:Update(arg_11_3, arg_11_0.students[arg_11_3])

	return
end

function var_0_0.ClearDisableCards(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 = #arg_12_0.cards[arg_12_1], arg_12_2 + 1, -1 do
		arg_12_0.cards[arg_12_1][iter_12_0]:Disable()
	end

	return
end

function var_0_0.GetCard(arg_13_0, arg_13_1)
	return underscore.detect(arg_13_0.cards[var_0_1], function(arg_14_0)
		return arg_14_0.index == arg_13_1
	end)
end

function var_0_0.OnDestroy(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.cards) do
		for iter_15_2, iter_15_3 in ipairs(iter_15_1) do
			iter_15_3:Dispose()
		end
	end

	arg_15_0.cards = nil

	return
end

return var_0_0
