class = var_0_10000

local var_0_0 = "CurrentWorldBossEmptyPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseWorldBossEmptyPage"))

function var_0_1.getUIName(arg_1_0)
	return "CurrentWorldBossEmptyUI"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "time/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.timeTxt = var_2_2(var_2_1, var_3(var_1_10004))
	WorldBossConst = var_1

	local var_2_3

	if not var_1.GetCurrBossGroup() then
		var_2_3 = ""
	end

	arg_2_0:UpdateUseItemStyle(var_2_3)

	local var_2_4 = arg_2_0._tf

	arg_2_0.simulateBtn = var_2.Find(var_2_4, "simulate_btn")

	return
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.helpBtn

	local function var_3_2()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_4_2.type = var_2_10003
		pg = var_2_10003
		var_4_2.helps = var_2_10003.gametip.world_boss_help_meta.tip

		var_4_1(var_4_0, var_4_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	setActive = var_1

	var_1(arg_3_0.simulateBtn, true)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.simulateBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		WorldBossMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_UPDATE_BOSS_INFO, function()
			pg = var_3_10000

			local var_6_0 = var_3_10000.MsgboxMgr.GetInstance()
			local var_6_1 = var_0.ShowMsgBox
			local var_6_2 = {}

			i18n = var_3_10003

			local var_6_3 = "meta_simulated_btn"

			nowWorld = var_3_10005

			local var_6_4 = var_3_10005()

			var_6_2.content = var_3_10003(var_6_3, var_5.GetBossProxy(var_6_4).currentBossLV)

			function var_6_2.onYes()
				local var_7_0 = arg_3_0
				local var_7_1 = var_0.emit

				WorldBossMediator = var_4_10002

				local var_7_2 = var_4_10002.ON_BATTLE

				WorldBossConst = var_4_10003

				var_7_1(var_7_0, var_7_2, var_4_10003.GetCurrBossID(), nil, 1, true)

				return
			end

			var_6_1(var_6_0, var_6_2)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.progressTr

	local function var_3_8()
		WorldBossConst = var_2_10000

		local var_8_0 = var_2_10000.GetCurrBossItemInfo()

		pg = var_2_10001

		local var_8_1 = var_2_10001.MsgboxMgr.GetInstance()
		local var_8_2 = var_1.ShowMsgBox
		local var_8_3 = {
			hideNo = true
		}

		MSGBOX_TYPE_DROP_ITEM = var_2_10004
		var_8_3.type = var_2_10004
		var_8_3.name = var_8_0.name
		var_8_3.content = var_8_0.display
		var_8_3.iconPath = var_8_0.icon
		var_8_3.frame = var_8_0.rarity

		var_8_2(var_8_1, var_8_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0._tf
	local var_3_11 = var_3.Find(var_3_10, "list_btn")

	local function var_3_12()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		WorldBossScene = var_2_10002

		local var_9_2 = var_2_10002.ON_SWITCH

		WorldBossScene = var_2_10003

		var_9_1(var_9_0, var_9_2, var_2_10003.PAGE_CHALLENGE)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_9, var_3_11, var_3_12, var_5)

	onButton = var_1

	local var_3_13 = arg_3_0
	local var_3_14 = arg_3_0.activeBtn

	local function var_3_15()
		WorldBossConst = var_2_10000

		local var_10_0

		if var_2_10000.CanUnlockCurrBoss() then
			WorldBossConst = var_10_0
			var_10_0 = var_10_0.GetCurrBossID()
			var_2_10002 = arg_3_0

			local var_10_1 = var_1.emit

			WorldBossMediator = var_2_10003

			var_10_1(var_2_10002, var_2_10003.ON_ACTIVE_BOSS, var_10_0)
		else
			pg = var_10_0

			local var_10_2 = var_10_0.TipsMgr.GetInstance()
			local var_10_3 = var_0.ShowTips

			i18n = var_2_10002

			var_10_3(var_10_2, var_2_10002("world_boss_item_count_noenough"))
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_13, var_3_14, var_3_15, var_5)

	return
end

function var_0_1.OnUpdate(arg_11_0)
	WorldBossConst = var_1_10001

	local var_11_0 = var_1_10001.GetCurrBossStartTimeAndEndTime()

	pg = var_1_10002

	local var_11_1 = var_1_10002.TimeMgr.GetInstance()

	if var_2.inTime(var_11_1, var_11_0) then
		::label_11_0::

		WorldBossConst = var_11_1
		var_11_1 = var_11_1.CanUnlockCurrBoss()
	end

	setActive = var_4

	var_4(arg_11_0.useItem, var_11_1)

	setActive = var_4

	var_4(arg_11_0.noItem, not var_11_1)

	if var_2 then
		local var_11_2 = arg_11_0.timeTxt

		pg = var_5

		local var_11_3 = var_5.TimeMgr.GetInstance()
		local var_11_4 = var_5.DescDateFromConfig(var_11_3, var_11_0[1])
		local var_11_5 = "~"

		pg = var_7

		local var_11_6 = var_7.TimeMgr.GetInstance()

		var_11_2.text = var_11_4 .. var_11_5 .. var_7.DescDateFromConfig(var_11_6, var_11_0[2])
	else
		arg_11_0.timeTxt.text = ""
	end

	local var_11_7

	if not arg_11_0.metaWorldbossBtn then
		MetaWorldbossBtn = var_11_7
		var_11_7 = var_11_7.New

		local var_11_8 = arg_11_0._tf

		var_11_7 = var_11_7(var_5.Find(var_11_8, "archives_btn"), arg_11_0.event)
	end

	arg_11_0.metaWorldbossBtn = var_11_7

	local var_11_9

	if not arg_11_0.ptBtn then
		WorldbossPtBtn = var_11_9
		var_11_9 = var_11_9.New

		local var_11_10 = arg_11_0._tf

		var_11_9 = var_11_9(var_5.Find(var_11_10, "point"))
	end

	arg_11_0.ptBtn = var_11_9

	return
end

function var_0_1.OnUpdateRes(arg_12_0)
	if not arg_12_0.progressTxt then
		return
	end

	WorldBossConst = var_1

	local var_12_0, var_12_1, var_12_2 = var_1.GetCurrBossConsume()

	WorldBossConst = var_1_10004

	local var_12_3 = var_1_10004.GetCurrBossItemProgress()

	arg_12_0.progressTxt.text = var_12_3 .. "/" .. var_12_2

	return
end

function var_0_1.OnUpdatePt(arg_13_0, arg_13_1)
	if arg_13_0.ptBtn then
		local var_13_0 = arg_13_0.ptBtn

		var_2.Update(var_13_0)
	end

	return
end

function var_0_1.OnDestroy(arg_14_0)
	var_0_1.super.OnDestroy(arg_14_0)

	if arg_14_0.metaWorldbossBtn then
		local var_14_0 = arg_14_0.metaWorldbossBtn

		var_1.Dispose(var_14_0)

		arg_14_0.metaWorldbossBtn = nil
	end

	if arg_14_0.ptBtn then
		local var_14_1 = arg_14_0.ptBtn

		var_1.Dispose(var_14_1)

		arg_14_0.ptBtn = nil
	end

	return
end

return var_0_1
