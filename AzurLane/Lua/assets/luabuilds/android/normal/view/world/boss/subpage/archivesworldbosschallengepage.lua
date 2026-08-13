class = var_0_10000

local var_0_0 = "ArchivesWorldBossChallengePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseWorldBossChallengePage"))

function var_0_1.getUIName(arg_1_0)
	return "ArchivesWorldBossChallengeUI"
end

function var_0_1.OnFilterBoss(arg_2_0, arg_2_1)
	WorldBossConst = var_1_10002

	return not var_1_10002._IsCurrBoss(arg_2_1)
end

function var_0_1.GetResSuffix(arg_3_0)
	return "_archives"
end

function var_0_1.OnLoaded(arg_4_0)
	var_0_1.super.OnLoaded(arg_4_0)

	local var_4_0 = arg_4_0._tf

	arg_4_0.switchBtn = var_1.Find(var_4_0, "detail_btn")

	local var_4_1 = arg_4_0._tf

	arg_4_0.currentChallengeBtn = var_1.Find(var_4_1, "current_list_btn")

	local var_4_2 = arg_4_0._tf

	arg_4_0.tipTr = var_1.Find(var_4_2, "tip")
	setText = var_1

	local var_4_3 = arg_4_0.tipTr

	i18n = var_3

	var_1(var_4_3, var_3("world_boss_archives_boss_tip"))

	return
end

function var_0_1.OnInit(arg_5_0)
	var_0_1.super.OnInit(arg_5_0)

	onButton = var_1

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.switchBtn

	local function var_5_2()
		nowWorld = var_2_10000

		local var_6_0 = var_2_10000()
		local var_6_1 = var_0.GetBossProxy(var_6_0)

		if var_0.GetSelfBoss(var_6_1) then
			WorldBossConst = var_6_1

			if var_6_1._IsCurrBoss(var_0) then
				pg = var_1

				local var_6_2 = var_1.TipsMgr.GetInstance()
				local var_6_3 = var_1.ShowTips

				i18n = var_2_10003

				var_6_3(var_6_2, var_2_10003("current_boss_was_opened"))

				goto label_6_0
			end
		end

		do
			local var_6_4 = arg_5_0
			local var_6_5 = var_1.emit

			WorldBossScene = var_2_10003

			local var_6_6 = var_2_10003.ON_SWITCH

			WorldBossScene = var_2_10004

			var_6_5(var_6_4, var_6_6, var_2_10004.PAGE_ARCHIVES)
		end

		::label_6_0::

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.currentChallengeBtn

	local function var_5_5()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit

		WorldBossScene = var_2_10002

		local var_7_2 = var_2_10002.ON_SWITCH

		WorldBossScene = var_2_10003

		var_7_1(var_7_0, var_7_2, var_2_10003.PAGE_CHALLENGE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_5_3, var_5_4, var_5_5, var_1_10005)

	onButton = var_1

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0._tf
	local var_5_8 = var_3.Find(var_5_7, "help")

	local function var_5_9()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_8_2.type = var_2_10003
		pg = var_2_10003
		var_8_2.helps = var_2_10003.gametip.world_archives_boss_help.tip

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_5_6, var_5_8, var_5_9, var_5)

	return
end

function var_0_1.UpdateEmptyCard(arg_9_0)
	local var_9_0 = arg_9_0._tf
	local var_9_1 = var_1.Find(var_9_0, "list_panel/mask/tpl")
	local var_9_2 = var_1.Find(var_9_1, "empty")
	local var_9_3 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005

	local var_9_4 = var_9_3(var_9_2, var_4(var_1_10005))

	WorldBossConst = var_9_2

	local var_9_5 = var_9_2.GetAchieveState()

	WorldBossConst = var_4

	if var_9_5 == var_4.ACHIEVE_STATE_STARTING then
		WorldBossConst = var_9_5
		var_9_5 = var_9_5.GetArchivesId()
		WorldBossConst = var_4

		local var_9_6 = var_4.BossId2MetaId(var_9_5)

		GetSpriteFromAtlas = var_5
		var_9_4.sprite = var_5("MetaWorldboss/" .. var_9_6, "item_04")
	else
		GetSpriteFromAtlas = var_9_5
		var_9_4.sprite = var_9_5("MetaWorldboss/extra_empty", "")
	end

	var_9_4:SetNativeSize()

	return
end

return var_0_1
