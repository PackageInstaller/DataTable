class = var_0_10000

local var_0_0 = "WorldBossHPAwardPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	FuncBuffer = var_1
	arg_1_0.buffer = var_1.New()

	return
end

function var_0_1.getUIName(arg_2_0)
	return "WorldBossHPAwardWindow"
end

function var_0_1.OnInit(arg_3_0)
	setText = var_1_10001

	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_2.Find(var_3_0, "window/top/bg/infomation")

	i18n = var_3_0

	var_1_10001(var_3_1, var_3_0("world_expedition_reward_display"))

	local var_3_2 = arg_3_0._tf

	arg_3_0.itemList = var_1.Find(var_3_2, "window/panel/viewport/list")
	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_3.Find(var_3_4, "window/top/btnBack")

	local function var_3_6()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_3_3, var_3_5, var_3_6, var_5)

	onButton = var_1

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0._tf

	var_1(var_3_7, var_3.Find(var_3_8, "bg_dark"), function()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end)

	local var_3_9 = arg_3_0.buffer

	var_1.SetNotifier(var_3_9, arg_3_0)

	local var_3_10 = arg_3_0.buffer

	var_1.ExcuteAll(var_3_10)

	return
end

function var_0_1.Show(arg_6_0)
	var_0_1.super.Show(arg_6_0)

	pg = var_1

	local var_6_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_6_0, arg_6_0._tf)

	return
end

function var_0_1.Hide(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_7_0, arg_7_0._tf)
	var_0_1.super.Hide(arg_7_0)

	return
end

function var_0_1.UpdateView(arg_8_0, arg_8_1)
	arg_8_0:Show()

	local var_8_0 = arg_8_1:GetHP()

	if arg_8_1:IsPeriodEnemy() then
		math = var_3

		local var_8_1 = var_3.min
		local var_8_2 = var_8_0

		nowWorld = var_1_10005
		var_1_10006 = var_1_10005()
		var_8_0 = var_8_1(var_8_2, var_5.GetHistoryLowestHP(var_1_10006, arg_8_1.id))
	end

	local var_8_3 = arg_8_1
	local var_8_4 = arg_8_1.GetBattleStageId(var_8_3)

	pg = var_8_3

	local var_8_5 = var_8_3.world_expedition_data[var_8_4] and var_4.phase_drop_display

	UIItemList = var_1_10006

	local var_8_6 = var_1_10006.StaticAlign
	local var_8_7 = arg_8_0.itemList
	local var_8_8 = arg_8_0.itemList
	local var_8_9 = var_8.GetChild(var_8_8, 0)
	local var_8_10

	if not var_8_5 or not #var_8_5 then
		var_8_10 = 0
	end

	var_8_6(var_8_7, var_8_9, var_8_10, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_9_0 = var_8_5[arg_9_1 + 1]
		local var_9_1 = var_8_0 <= var_9_0[1]

		setText = var_5

		local var_9_2 = arg_9_2
		local var_9_3 = arg_9_2.Find(var_9_2, "target")

		i18n = var_9_2

		local var_9_4 = "world_expedition_reward_display2"

		math = var_2_10009

		var_5(var_9_3, var_9_2(var_9_4, var_2_10009.ceil(var_9_0[1] / 100)))

		setActive = var_5

		var_5(arg_9_2:Find("mask"), var_9_1)

		UIItemList = var_5

		local var_9_5 = var_5.StaticAlign
		local var_9_6 = arg_9_2:Find("awards")
		local var_9_7 = arg_9_2:Find("awards")

		var_9_5(var_9_6, var_7.GetChild(var_9_7, 0), #var_9_0[2], function(arg_10_0, arg_10_1, arg_10_2)
			UIItemList = var_3_10003

			if arg_10_0 ~= var_3_10003.EventUpdate then
				return
			end

			local var_10_0 = var_9_0[2][arg_10_1 + 1]
			local var_10_1 = {
				type = var_10_0[1],
				id = var_10_0[2],
				count = var_10_0[3]
			}

			updateDrop = var_5

			var_5(arg_10_2:Find("IconTpl"), var_10_1)

			onButton = var_5

			var_5(arg_8_0, arg_10_2:Find("IconTpl"), function()
				local var_11_0 = arg_8_0
				local var_11_1 = var_0.emit

				BaseUI = var_4_10002

				var_11_1(var_11_0, var_4_10002.ON_DROP, var_10_1)

				return
			end)

			return
		end)

		return
	end)

	return
end

return var_0_1
