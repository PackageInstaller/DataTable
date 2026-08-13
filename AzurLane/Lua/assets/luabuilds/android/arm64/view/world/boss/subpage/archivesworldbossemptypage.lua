class = var_0_10000

local var_0_0 = "ArchivesWorldBossEmptyPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseWorldBossEmptyPage"))

function var_0_1.getUIName(arg_1_0)
	return "ArchivesWorldBossEmptyUI"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.helpBtn

	local function var_2_2()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_3_2.type = var_2_10004
		pg = var_2_10004
		var_3_2.helps = var_2_10004.gametip.world_archives_boss_help.tip

		var_3_1(var_3_0, var_3_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_4.Find(var_2_4, "list_btn")

	local function var_2_6()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		WorldBossScene = var_2_10003

		local var_4_2 = var_2_10003.ON_SWITCH

		WorldBossScene = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004.PAGE_ARCHIVES_CHALLENGE)

		return
	end

	SFX_PANEL = var_2_4

	var_1(var_2_3, var_2_5, var_2_6, var_2_4)

	onButton = var_1

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.activeBtn

	local function var_2_9()
		WorldBossConst = var_2_10000

		local var_5_0 = var_2_10000.GetAchieveState()

		WorldBossConst = var_2_10001

		local var_5_2

		if var_5_0 == var_2_10001.ACHIEVE_STATE_NOSTART then
			pg = var_5_2

			local var_5_1 = var_5_2.TipsMgr.GetInstance()

			var_5_2 = var_5_2.ShowTips
			i18n = var_2_10004

			var_5_2(var_5_1, var_2_10004("world_boss_no_select_archives"))
		else
			WorldBossConst = var_5_2

			local var_5_4

			if var_5_0 == var_5_2.ACHIEVE_STATE_STARTING then
				WorldBossConst = var_5_4

				if var_5_4.CanUnlockArchivesBoss() then
					local var_5_3 = arg_2_0

					var_5_4 = var_5_4.emit
					WorldBossMediator = var_2_10004

					var_5_4(var_5_3, var_2_10004.ON_ACTIVE_ARCHIVES_BOSS)
				else
					pg = var_5_4

					local var_5_5 = var_5_4.TipsMgr.GetInstance()

					var_5_4 = var_5_4.ShowTips
					i18n = var_2_10004

					var_5_4(var_5_5, var_2_10004("world_boss_archives_item_count_noenough"))
				end
			else
				WorldBossConst = var_5_4

				if var_5_0 == var_5_4.ACHIEVE_STATE_CLEAR then
					pg = var_1

					local var_5_6 = var_1.TipsMgr.GetInstance()
					local var_5_7 = var_1.ShowTips

					i18n = var_2_10004

					var_5_7(var_5_6, var_2_10004("world_boss_archives_are_clear"))
				end
			end
		end

		return
	end

	SFX_PANEL = var_2_4

	var_1(var_2_7, var_2_8, var_2_9, var_2_4)

	onButton = var_1

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.progressTr

	local function var_2_12()
		WorldBossConst = var_2_10000

		local var_6_0 = var_2_10000.GetAchieveBossItemInfo()

		pg = var_2_10001

		local var_6_1 = var_2_10001.MsgboxMgr.GetInstance()
		local var_6_2 = var_1.ShowMsgBox
		local var_6_3 = {
			hideNo = true
		}

		MSGBOX_TYPE_DROP_ITEM = var_2_10005
		var_6_3.type = var_2_10005
		var_6_3.name = var_6_0.name
		var_6_3.content = var_6_0.display
		var_6_3.iconPath = var_6_0.icon
		var_6_3.frame = var_6_0.rarity

		var_6_2(var_6_1, var_6_3)

		return
	end

	SFX_PANEL = var_2_4

	var_1(var_2_10, var_2_11, var_2_12, var_2_4)

	pg = var_1

	local var_2_13 = var_1.NewStoryMgr.GetInstance()

	if not var_1.IsPlayed(var_2_13, "WorldG193") then
		WorldGuider = var_1

		local var_2_14 = var_1.GetInstance()

		var_1.PlayGuide(var_2_14, "WorldG193")
	end

	return
end

function var_0_1.OnUpdate(arg_7_0)
	local var_7_0

	if not arg_7_0.archivesWorldbossBtn then
		ArchivesWorldbossBtn = var_7_0
		var_7_0 = var_7_0.New
		var_1_10005 = arg_7_0._tf
		var_7_0 = var_7_0(var_1_10003.Find(var_1_10005, "archives_btn"), arg_7_0.event)
	end

	arg_7_0.archivesWorldbossBtn = var_7_0
	WorldBossConst = var_7_0

	local var_7_1 = var_7_0.GetAchieveState()
	local var_7_2

	WorldBossConst = var_1_10003

	if var_7_1 == var_1_10003.ACHIEVE_STATE_NOSTART then
		var_7_2 = "text04"
	else
		WorldBossConst = var_7_3

		if var_7_1 == var_7_3.ACHIEVE_STATE_CLEAR then
			var_7_2 = "text05"
		end
	end

	local var_7_3

	if var_7_2 then
		var_1_10005 = arg_7_0.noItem
		var_7_3 = var_7_3.GetComponent
		typeof = var_1_10006
		Image = var_1_10008
		var_7_3 = var_7_3(var_1_10005, var_1_10006(var_1_10008))
		GetSpriteFromAtlasAsync = var_1_10004

		var_1_10004("ui/WorldBossUI_atlas", var_7_2, function(arg_8_0)
			var_7_3.sprite = arg_8_0

			return
		end)

		var_1_10006 = var_7_3

		var_7_3.SetNativeSize(var_1_10006)
	end

	WorldBossConst = var_7_3

	local var_7_4 = var_7_3.GetAchieveState()

	WorldBossConst = var_1_10004

	if var_7_4 == var_1_10004.ACHIEVE_STATE_STARTING then
		WorldBossConst = var_1_10005
		var_1_10005 = var_1_10005.GetArchivesId()
		WorldBossConst = var_1_10006

		local var_7_5 = var_1_10006.BossId2MetaId(var_1_10005)

		arg_7_0:UpdateUseItemStyle(var_7_5)
	end

	setActive = var_1_10005

	var_1_10005(arg_7_0.useItem, var_4)

	setActive = var_1_10005

	var_1_10005(arg_7_0.noItem, not var_4)

	local var_7_6 = arg_7_0.archivesWorldbossBtn

	var_5.Flush(var_7_6)

	return
end

function var_0_1.OnUpdateRes(arg_9_0)
	if not arg_9_0.progressTxt then
		return
	end

	WorldBossConst = var_1

	local var_9_0, var_9_1, var_9_2 = var_1.GetAchieveBossConsume()

	WorldBossConst = var_1_10004

	local var_9_3 = var_1_10004.GetAchieveBossItemProgress()

	arg_9_0.progressTxt.text = var_9_3 .. "/" .. var_9_2

	return
end

function var_0_1.OnDestroy(arg_10_0)
	var_0_1.super.OnDestroy(arg_10_0)

	if arg_10_0.archivesWorldbossBtn then
		local var_10_0 = arg_10_0.archivesWorldbossBtn

		var_1.Dispose(var_10_0)

		arg_10_0.archivesWorldbossBtn = nil
	end

	return
end

return var_0_1
