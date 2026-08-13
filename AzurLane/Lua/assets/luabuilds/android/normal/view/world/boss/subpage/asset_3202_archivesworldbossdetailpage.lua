class = var_0_10000

local var_0_0 = "ArchivesWorldBossDetailPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseWorldBossDetailPage"))

function var_0_1.getUIName(arg_1_0)
	return "ArchivesWorldBossDetailUI"
end

function var_0_1.OnAutoBattleResult(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.cnt
	local var_2_1 = arg_2_1.damage
	local var_2_2 = arg_2_1.oil
	local var_2_3 = arg_2_0.autoBattleResultMsg

	var_5.ExecuteAction(var_2_3, "Show", {
		battleCnt = var_2_0,
		damage = var_2_1,
		oil = var_2_2
	})
	arg_2_0:Flush()
	arg_2_0:UpdatePainting(arg_2_0.groupId)

	return
end

function var_0_1.OnAutoBattleStart(arg_3_0)
	arg_3_0:Flush()
	arg_3_0:UpdatePainting(arg_3_0.groupId)

	return
end

function var_0_1.GetResSuffix(arg_4_0)
	return "_archives"
end

function var_0_1.OnLoaded(arg_5_0)
	var_0_1.super.OnLoaded(arg_5_0)

	local var_5_0 = arg_5_0._tf

	arg_5_0.currProgressTr = var_1.Find(var_5_0, "progress")

	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_1.Find(var_5_1, "progress/value")
	local var_5_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_5_0.currProgressTxt = var_5_3(var_5_2, var_3(var_1_10004))

	local var_5_4 = arg_5_0._tf

	arg_5_0.listBtn = var_1.Find(var_5_4, "list_btn")
	ArchivesWorldbossBtn = var_1

	local var_5_5 = var_1.New
	local var_5_6 = arg_5_0._tf

	arg_5_0.archivesWorldbossBtn = var_5_5(var_2.Find(var_5_6, "archives_btn"), arg_5_0.event)

	local var_5_7 = arg_5_0._tf

	arg_5_0.autoBattleBtn = var_1.Find(var_5_7, "btns/auto_btn")

	local var_5_8 = arg_5_0.autoBattleBtn
	local var_5_9 = var_1.Find(var_5_8, "Text")
	local var_5_10 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_5_0.autoBattleTimeTxt = var_5_10(var_5_9, var_3(var_4))

	local var_5_11 = arg_5_0._tf

	arg_5_0.battleMask = var_1.Find(var_5_11, "battle_mask")
	ArchivesWorldBossHelpPage = var_1
	arg_5_0.helpWindow = var_1.New(arg_5_0._parentTf.parent, arg_5_0.event)
	ArchivesWorldBossAutoBattleTipPage = var_1
	arg_5_0.autoBattleTip = var_1.New(arg_5_0._parentTf.parent, arg_5_0.event)
	ArchivesWorldBossAutoBattleMsgbox = var_1
	arg_5_0.autoBattleMsg = var_1.New(arg_5_0._parentTf.parent, arg_5_0.event)
	ArchivesWorldBossAutoBattleResultMsg = var_1
	arg_5_0.autoBattleResultMsg = var_1.New(arg_5_0._parentTf.parent, arg_5_0.event)

	return
end

function var_0_1.OnInit(arg_6_0)
	var_0_1.super.OnInit(arg_6_0)

	onButton = var_1

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.listBtn

	local function var_6_2()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		WorldBossScene = var_2_10002

		local var_7_2 = var_2_10002.ON_SWITCH

		WorldBossScene = var_2_10003

		var_7_1(var_7_0, var_7_2, var_2_10003.PAGE_ARCHIVES_CHALLENGE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_6_0, var_6_1, var_6_2, var_1_10005)

	onButton = var_1

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.currProgressTr

	local function var_6_5()
		WorldBossConst = var_2_10000

		local var_8_0 = var_2_10000.GetAchieveBossItemInfo()

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

	var_1(var_6_3, var_6_4, var_6_5, var_1_10005)

	onButton = var_1

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0._tf
	local var_6_8 = var_3.Find(var_6_7, "help")

	local function var_6_9()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_9_2.type = var_2_10003
		pg = var_2_10003
		var_9_2.helps = var_2_10003.gametip.world_archives_boss_help.tip

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_6_6, var_6_8, var_6_9, var_5)

	onButton = var_1

	local var_6_10 = arg_6_0
	local var_6_11 = arg_6_0.battleMask

	local function var_6_12()
		triggerButton = var_2_10000

		var_2_10000(arg_6_0.autoBattleBtn)

		return
	end

	SFX_PANEL = var_5

	var_1(var_6_10, var_6_11, var_6_12, var_5)

	onButton = var_1

	local var_6_13 = arg_6_0
	local var_6_14 = arg_6_0.autoBattleBtn

	local function var_6_15()
		pg = var_2_10000

		local var_11_0 = var_2_10000.TimeMgr.GetInstance()
		local var_11_1 = var_0.GetServerTime(var_11_0)

		WorldBossConst = var_11_0

		local var_11_2 = var_11_1 + var_11_0.GetArchivesBossAutoBattleSecond()
		local var_11_3 = arg_6_0.boss
		local var_11_5

		if var_1.GetExpiredTime(var_11_3) < var_11_2 then
			pg = var_11_5

			local var_11_4 = var_11_5.TipsMgr.GetInstance()

			var_11_5 = var_11_5.ShowTips
			i18n = var_2_10003

			var_11_5(var_11_4, var_2_10003("world_no_time_to_auto_battle"))

			return
		end

		WorldBossConst = var_11_5

		local var_11_6 = var_11_5.GetAutoBattleState(arg_6_0.boss)

		WorldBossConst = var_2

		local var_11_7

		if var_11_6 == var_2.AUTO_BATTLE_STATE_STARTING then
			var_2_10003 = arg_6_0.autoBattleMsg
			var_11_7 = var_11_7.ExecuteAction
			var_2_10004 = "Show"
			var_2_10005 = {
				onContent = function()
					WorldBossConst = var_3_10000

					if var_3_10000.GetAutoBattleLeftTime() <= 0 then
						return nil
					end

					pg = var_1

					local var_12_0 = var_1.TimeMgr.GetInstance()

					return (var_1.DescCDTime(var_12_0, var_0))
				end
			}
			i18n = var_6
			var_2_10005.title = var_6("world_boss_archives_stop_auto_battle_title")
			i18n = var_6
			var_2_10005.yesText = var_6("world_boss_archives_continue_auto_battle")
			i18n = var_6
			var_2_10005.noText = var_6("world_boss_archives_stop_auto_battle")

			function var_2_10005.onNo()
				local var_13_0 = arg_6_0
				local var_13_1 = var_0.emit

				WorldBossMediator = var_3_10002

				var_13_1(var_13_0, var_3_10002.ON_ARCHIVES_BOSS_STOP_AUTO_BATTLE, arg_6_0.boss.id)

				return
			end

			var_11_7(var_2_10003, var_2_10004, var_2_10005)
		else
			WorldBossConst = var_11_7

			local var_11_8

			if var_11_6 == var_11_7.AUTO_BATTLE_STATE_HIDE then
				pg = var_11_8
				var_2_10003 = var_11_8.TipsMgr.GetInstance()
				var_11_8 = var_11_8.ShowTip
				i18n = var_2_10004

				var_11_8(var_2_10003, var_2_10004("world_word_expired"))
			else
				WorldBossConst = var_11_8

				local var_11_9

				if var_11_6 == var_11_8.AUTO_BATTLE_STATE_LOCK then
					pg = var_11_9
					var_2_10003 = var_11_9.TipsMgr.GetInstance()
					var_11_9 = var_11_9.ShowTips
					i18n = var_2_10004

					var_11_9(var_2_10003, var_2_10004("world_boss_archives_auto_battle_unopen"))
				else
					WorldBossConst = var_11_9

					local var_11_10 = var_11_9.GetHighestDamage()

					WorldBossConst = var_2_10003

					local var_11_11 = var_2_10003.GetAutoBattleCnt()

					WorldBossConst = var_2_10004

					local var_11_12 = var_2_10004.GetAutoBattleOilConsume()

					WorldBossConst = var_2_10005

					local var_11_13 = var_2_10005.GetArchivesBossAutoBattleMinute()
					local var_11_14 = arg_6_0.autoBattleTip

					var_6.ExecuteAction(var_11_14, "Show", {
						highestDamage = var_11_10,
						autoBattleCnt = var_11_11,
						oil = var_11_12,
						time = var_11_13,
						onYes = function()
							local var_14_0 = arg_6_0
							local var_14_1 = var_0.emit

							WorldBossMediator = var_3_10002

							var_14_1(var_14_0, var_3_10002.ON_ARCHIVES_BOSS_AUTO_BATTLE, arg_6_0.boss.id)

							return
						end
					})
				end
			end
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_6_13, var_6_14, var_6_15, var_5)

	return
end

function var_0_1.OnStart(arg_15_0)
	nowWorld = var_1_10001

	local var_15_0 = var_1_10001()
	local var_15_1 = var_1.GetBossProxy(var_15_0)

	if var_1.InAutoBattle(var_15_1) then
		pg = var_1

		local var_15_2 = var_1.TipsMgr.GetInstance()
		local var_15_3 = var_1.ShowTips

		i18n = var_1_10003

		var_15_3(var_15_2, var_1_10003("world_boss_archives_need_stop_auto_battle"))

		return
	end

	var_0_1.super.OnStart(arg_15_0)

	return
end

function var_0_1.OnRescue(arg_16_0)
	if arg_16_0.helpWindow then
		local var_16_0 = arg_16_0.helpWindow

		var_1.ExecuteAction(var_16_0, "Update", arg_16_0.boss)
	end

	return
end

function var_0_1.OnUpdateRes(arg_17_0)
	if not arg_17_0.currProgressTxt then
		return
	end

	WorldBossConst = var_1

	local var_17_0, var_17_1, var_17_2 = var_1.GetAchieveBossConsume()

	WorldBossConst = var_1_10004

	local var_17_3 = var_1_10004.GetAchieveBossItemProgress()

	arg_17_0.currProgressTxt.text = var_17_3 .. "/" .. var_17_2

	return
end

function var_0_1.UpdateMainInfo(arg_18_0)
	var_0_1.super.UpdateMainInfo(arg_18_0)

	local var_18_0 = arg_18_0.boss
	local var_18_1 = var_1.GetHP(var_18_0)
	local var_18_2 = var_1:GetMaxHp()

	arg_18_0.levelTxt.text = var_1:GetLevel()
	arg_18_0.hpTxt.text = var_18_1 .. "/<color=#CF4E24>" .. var_18_2 .. "</color>"

	return
end

function var_0_1.OnPaintingLoad(arg_19_0)
	local var_19_0 = arg_19_0.painting

	if var_1.Find(var_19_0, "fitter").childCount > 0 then
		local var_19_1 = var_1
		local var_19_2 = var_1.GetChild(var_19_1, 0)

		WorldBossConst = var_19_1

		local var_19_3 = var_19_1.GetAutoBattleState(arg_19_0.boss)

		WorldBossConst = var_4

		local var_19_4 = var_19_3 == var_4.AUTO_BATTLE_STATE_STARTING

		GetOrAddComponent = var_1_10005

		local var_19_5 = var_19_2

		typeof = var_1_10007
		Gradient = var_1_10008

		if var_1_10005(var_19_5, var_1_10007(var_1_10008)) then
			var_5.enabled = var_19_4
		end
	end

	return
end

function var_0_1.Show(arg_20_0)
	var_0_1.super.Show(arg_20_0)
	arg_20_0:Flush()

	return
end

function var_0_1.OnBossExpired(arg_21_0)
	WorldBossConst = var_1_10001

	local var_21_0 = var_1_10001.GetAutoBattleState(arg_21_0.boss)

	WorldBossConst = var_2

	if var_21_0 == var_2.AUTO_BATTLE_STATE_STARTING then
		WorldBossConst = var_2

		if var_2.GetAutoBattleLeftTime() <= 0 then
			local var_21_1 = arg_21_0
			local var_21_2 = arg_21_0.emit

			WorldBossMediator = var_1_10004

			var_21_2(var_21_1, var_1_10004.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER, arg_21_0.boss.id)
		end

		return
	end

	local var_21_3 = arg_21_0
	local var_21_4 = arg_21_0.emit

	WorldBossMediator = var_1_10004

	var_21_4(var_21_3, var_1_10004.ON_SELF_BOSS_OVERTIME)

	return
end

function var_0_1.Flush(arg_22_0)
	local var_22_0 = arg_22_0.archivesWorldbossBtn

	var_1.Flush(var_22_0)

	WorldBossConst = var_1

	local var_22_1 = var_1.GetAutoBattleState(arg_22_0.boss)
	local var_22_2 = arg_22_0.autoBattleBtn
	local var_22_3 = var_2.GetComponent

	typeof = var_1_10004
	Image = var_1_10005

	local var_22_4 = var_22_3(var_22_2, var_1_10004(var_1_10005))

	arg_22_0:RemoveBattleTimer()

	setActive = var_3

	var_3(arg_22_0.battleMask, false)

	arg_22_0.autoBattleTimeTxt.text = ""

	local var_22_5

	WorldBossConst = var_4

	if var_22_1 == var_4.AUTO_BATTLE_STATE_LOCK then
		var_22_5 = "auto_03"
	else
		WorldBossConst = var_4

		if var_22_1 == var_4.AUTO_BATTLE_STATE_STARTING then
			var_22_5 = "auto_02"

			arg_22_0:AddBattleTimer()

			setActive = var_4

			var_4(arg_22_0.battleMask, true)
		else
			var_22_5 = "auto_01"
		end
	end

	GetSpriteFromAtlasAsync = var_4

	var_4("ui/WorldBossUI_atlas", var_22_5, function(arg_23_0)
		var_22_4.sprite = arg_23_0

		return
	end)

	setActive = var_4

	local var_22_6 = arg_22_0.autoBattleBtn

	WorldBossConst = var_6

	var_4(var_22_6, var_22_1 ~= var_6.AUTO_BATTLE_STATE_HIDE)

	setGray = var_4

	local var_22_7 = arg_22_0.startBtn

	WorldBossConst = var_6

	var_4(var_22_7, var_6.AUTO_BATTLE_STATE_STARTING == var_22_1, true)

	return
end

function var_0_1.AddBattleTimer(arg_24_0)
	local var_24_0 = arg_24_0.boss

	if var_1.IsExpired(var_24_0) then
		return
	end

	WorldBossConst = var_1

	local var_24_2

	if var_1.GetAutoBattleLeftTime() <= 0 then
		local var_24_1 = arg_24_0

		var_24_2 = arg_24_0.emit
		WorldBossMediator = var_1_10003

		var_24_2(var_24_1, var_1_10003.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER, arg_24_0.boss.id)

		return
	end

	Timer = var_24_2
	arg_24_0.timer = var_24_2.New(function()
		WorldBossConst = var_2_10000

		if var_2_10000.GetAutoBattleLeftTime() < 0 then
			var_2_10002 = arg_24_0

			var_1.RemoveBattleTimer(var_2_10002)

			arg_24_0.autoBattleTimeTxt.text = ""
		end

		if var_0 < 0 and arg_24_0.boss then
			var_2_10002 = arg_24_0

			local var_25_0 = var_1.emit

			WorldBossMediator = var_2_10003

			var_25_0(var_2_10002, var_2_10003.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER, arg_24_0.boss.id)
		else
			local var_25_1 = arg_24_0.autoBattleTimeTxt

			pg = var_2_10002

			local var_25_2 = var_2_10002.TimeMgr.GetInstance()

			var_25_1.text = var_2.DescCDTime(var_25_2, var_0)
		end

		return
	end, 1, -1)

	arg_24_0.timer.func()

	local var_24_3 = arg_24_0.timer

	var_1.Start(var_24_3)

	return
end

function var_0_1.RemoveBattleTimer(arg_26_0)
	if arg_26_0.timer then
		local var_26_0 = arg_26_0.timer

		var_1.Stop(var_26_0)

		arg_26_0.timer = nil
	end

	return
end

function var_0_1.Hide(arg_27_0)
	var_0_1.super.Hide(arg_27_0)
	arg_27_0:RemoveBattleTimer()

	return
end

function var_0_1.OnDestroy(arg_28_0)
	local var_28_0 = arg_28_0.painting
	local var_28_1 = var_1.Find(var_28_0, "fitter")

	if var_1.GetChild(var_28_1, 0) then
		local var_28_2 = var_1
		local var_28_3 = var_1.GetComponent

		typeof = var_1_10004
		Gradient = var_1_10005

		if var_28_3(var_28_2, var_1_10004(var_1_10005)) then
			local var_28_4 = var_1
			local var_28_5 = var_1.GetComponent

			typeof = var_4
			Gradient = var_1_10005
			var_28_5(var_28_4, var_4(var_1_10005)).enabled = false
		end
	end

	var_0_1.super.OnDestroy(arg_28_0)

	if arg_28_0.helpWindow then
		local var_28_6 = arg_28_0.helpWindow

		var_2.Destroy(var_28_6)

		arg_28_0.helpWindow = nil
	end

	if arg_28_0.autoBattleTip then
		local var_28_7 = arg_28_0.autoBattleTip

		var_2.Destroy(var_28_7)

		arg_28_0.autoBattleTip = nil
	end

	if arg_28_0.autoBattleMsg then
		local var_28_8 = arg_28_0.autoBattleMsg

		var_2.Destroy(var_28_8)

		arg_28_0.autoBattleMsg = nil
	end

	if arg_28_0.archivesWorldbossBtn then
		local var_28_9 = arg_28_0.archivesWorldbossBtn

		var_2.Dispose(var_28_9)

		arg_28_0.archivesWorldbossBtn = nil
	end

	if arg_28_0.autoBattleResultMsg then
		local var_28_10 = arg_28_0.autoBattleResultMsg

		var_2.Destroy(var_28_10)

		arg_28_0.autoBattleResultMsg = nil
	end

	return
end

return var_0_1
