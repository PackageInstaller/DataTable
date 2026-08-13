class = var_0_10000

local var_0_0 = "CurrentWorldBossChallengePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseWorldBossChallengePage"))

var_0_1.Listeners = {
	onPtUpdated = "OnPtUpdated",
	onRankListUpdated = "OnRankListUpdated",
	onCacheBossUpdated = "OnCacheBossUpdated"
}

function var_0_1.getUIName(arg_1_0)
	return "CurrentWorldBossChallengeUI"
end

function var_0_1.OnFilterBoss(arg_2_0, arg_2_1)
	WorldBossConst = var_1_10002

	return var_1_10002._IsCurrBoss(arg_2_1)
end

function var_0_1.Setup(arg_3_0, arg_3_1)
	pairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(var_0_1.Listeners) do
		arg_3_0[iter_3_0] = function(...)
			var_0_1[iter_3_1](arg_3_0, ...)

			return
		end
	end

	arg_3_0.proxy = arg_3_1

	return
end

function var_0_1.AddListeners(arg_5_0, arg_5_1)
	var_0_1.super.AddListeners(arg_5_0, arg_5_1)

	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.AddListener

	WorldBossProxy = var_5

	var_5_1(var_5_0, var_5.EventPtUpdated, arg_5_0.onPtUpdated)

	return
end

function var_0_1.RemoveListeners(arg_6_0, arg_6_1)
	var_0_1.super.RemoveListeners(arg_6_0, arg_6_1)

	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.RemoveListener

	WorldBossProxy = var_5

	var_6_1(var_6_0, var_5.EventPtUpdated, arg_6_0.onPtUpdated)

	return
end

function var_0_1.OnPtUpdated(arg_7_0, arg_7_1)
	if arg_7_0.ptBtn then
		local var_7_0 = arg_7_0.ptBtn

		var_2.Update(var_7_0)
	end

	return
end

function var_0_1.OnLoaded(arg_8_0)
	var_0_1.super.OnLoaded(arg_8_0)

	WorldBossAwardPage = var_1
	arg_8_0.awardPage = var_1.New(arg_8_0._tf.parent.parent, arg_8_0.event)

	local var_8_0 = arg_8_0._tf

	arg_8_0.switchBtn = var_1.Find(var_8_0, "detail_btn")

	local var_8_1 = arg_8_0._tf

	arg_8_0.archivesChallengeBtn = var_1.Find(var_8_1, "archives_list_btn")

	local var_8_2 = arg_8_0._tf

	arg_8_0.awardBtn = var_1.Find(var_8_2, "main/award_btn")
	setActive = var_1

	local var_8_3 = arg_8_0.archivesChallengeBtn

	LOCK_WORLDBOSS_ARCHIVES = var_4

	var_1(var_8_3, not var_4)

	return
end

function var_0_1.OnInit(arg_9_0)
	var_0_1.super.OnInit(arg_9_0)

	onButton = var_1

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.switchBtn

	local function var_9_2()
		nowWorld = var_2_10000

		local var_10_0 = var_2_10000()
		local var_10_1 = var_0.GetBossProxy(var_10_0)

		if var_0.GetSelfBoss(var_10_1) then
			WorldBossConst = var_2_10001

			if not var_2_10001._IsCurrBoss(var_0) then
				pg = var_1

				local var_10_2 = var_1.TipsMgr.GetInstance()
				local var_10_3 = var_1.ShowTips

				i18n = var_2_10004

				var_10_3(var_10_2, var_2_10004("archives_boss_was_opened"))

				goto label_10_0
			end
		end

		do
			local var_10_4 = arg_9_0
			local var_10_5 = var_1.emit

			WorldBossScene = var_2_10004

			local var_10_6 = var_2_10004.ON_SWITCH

			WorldBossScene = var_2_10005

			var_10_5(var_10_4, var_10_6, var_2_10005.PAGE_CURRENT)
		end

		::label_10_0::

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_9_0, var_9_1, var_9_2, var_1_10006)

	onButton = var_1

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.archivesChallengeBtn

	local function var_9_5()
		local var_11_0 = arg_9_0
		local var_11_1 = var_0.emit

		WorldBossScene = var_2_10003

		local var_11_2 = var_2_10003.ON_SWITCH

		WorldBossScene = var_2_10004

		var_11_1(var_11_0, var_11_2, var_2_10004.PAGE_ARCHIVES_CHALLENGE)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_9_3, var_9_4, var_9_5, var_1_10006)

	onToggle = var_1

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0._tf
	local var_9_8 = var_4.Find(var_9_7, "list_panel/frame/filter/toggles/world")

	local function var_9_9(arg_12_0)
		local var_12_0 = arg_9_0.filterFlags

		if arg_12_0 then
			WorldBoss = var_2_10002

			local var_12_1

			if not var_2_10002.BOSS_TYPE_WORLD then
				var_12_1 = -1
			end

			var_12_0[1] = var_12_1

			local var_12_2 = arg_9_0

			var_1.CheckToggle(var_12_2)

			local var_12_3 = arg_9_0

			var_1.UpdateNonProcessList(var_12_3)

			return
		end
	end

	SFX_PANEL = var_9_7

	var_1(var_9_6, var_9_8, var_9_9, var_9_7)

	onButton = var_1

	local var_9_10 = arg_9_0
	local var_9_11 = arg_9_0._tf
	local var_9_12 = var_4.Find(var_9_11, "point/help")

	local function var_9_13()
		pg = var_2_10000

		local var_13_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_13_1 = var_0.ShowMsgBox
		local var_13_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_13_2.type = var_2_10004
		pg = var_2_10004
		var_13_2.helps = var_2_10004.gametip.world_boss_help_meta.tip

		var_13_1(var_13_0, var_13_2)

		return
	end

	SFX_PANEL = var_9_11

	var_1(var_9_10, var_9_12, var_9_13, var_9_11)

	WorldbossPtBtn = var_1

	local var_9_14 = var_1.New
	local var_9_15 = arg_9_0._tf

	arg_9_0.ptBtn = var_9_14(var_3.Find(var_9_15, "point"))

	return
end

function var_0_1.CheckToggle(arg_14_0)
	var_0_1.super.CheckToggle(arg_14_0)

	_ = var_1

	if var_1.all(arg_14_0.filterFlags, function(arg_15_0)
		return arg_15_0 == -1
	end) then
		triggerToggle = var_1

		local var_14_0 = arg_14_0._tf

		var_1(var_3.Find(var_14_0, "list_panel/frame/filter/toggles/world"), true)
	end

	return
end

function var_0_1.UpdateMainView(arg_16_0, arg_16_1, arg_16_2)
	var_0_1.super.UpdateMainView(arg_16_0, arg_16_1, arg_16_2)

	local var_16_0 = arg_16_1:isDeath()

	setActive = var_1_10004

	var_1_10004(arg_16_0.awardBtn, not var_16_0)

	onButton = var_1_10004

	local var_16_1 = arg_16_0
	local var_16_2 = arg_16_0.awardBtn

	local function var_16_3()
		local var_17_0 = arg_16_0.awardPage

		var_0.ExecuteAction(var_17_0, "Update", arg_16_1)

		return
	end

	SFX_PANEL = var_1_10009

	var_1_10004(var_16_1, var_16_2, var_16_3, var_1_10009)

	return
end

function var_0_1.OnDestroy(arg_18_0)
	var_0_1.super.OnDestroy(arg_18_0)

	if arg_18_0.awardPage then
		local var_18_0 = arg_18_0.awardPage

		var_1.Destroy(var_18_0)

		arg_18_0.awardPage = nil
	end

	if arg_18_0.ptBtn then
		local var_18_1 = arg_18_0.ptBtn

		var_1.Dispose(var_18_1)

		arg_18_0.ptBtn = nil
	end

	return
end

return var_0_1
