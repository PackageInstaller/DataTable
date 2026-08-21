local var_0_0 = class("ArchivesWorldBossDetailPage", import(".BaseWorldBossDetailPage"))

function var_0_0.getUIName(arg_1_0)
	return "ArchivesWorldBossDetailUI"
end

function var_0_0.OnAutoBattleResult(arg_2_0, arg_2_1)
	arg_2_0.autoBattleResultMsg:ExecuteAction("Show", {
		battleCnt = arg_2_1.cnt,
		damage = arg_2_1.damage,
		oil = arg_2_1.oil
	})
	arg_2_0:Flush()
	arg_2_0:UpdatePainting(arg_2_0.groupId)

	return
end

function var_0_0.OnAutoBattleStart(arg_3_0)
	arg_3_0:Flush()
	arg_3_0:UpdatePainting(arg_3_0.groupId)

	return
end

function var_0_0.GetResSuffix(arg_4_0)
	return "_archives"
end

function var_0_0.OnLoaded(arg_5_0)
	var_0_0.super.OnLoaded(arg_5_0)

	arg_5_0.currProgressTr = arg_5_0._tf:Find("progress")
	arg_5_0.currProgressTxt = arg_5_0._tf:Find("progress/value"):GetComponent(typeof(Text))
	arg_5_0.listBtn = arg_5_0._tf:Find("list_btn")
	arg_5_0.archivesWorldbossBtn = ArchivesWorldbossBtn.New(arg_5_0._tf:Find("archives_btn"), arg_5_0.event)
	arg_5_0.autoBattleBtn = arg_5_0._tf:Find("btns/auto_btn")
	arg_5_0.autoBattleTimeTxt = arg_5_0.autoBattleBtn:Find("Text"):GetComponent(typeof(Text))
	arg_5_0.battleMask = arg_5_0._tf:Find("battle_mask")
	arg_5_0.helpWindow = ArchivesWorldBossHelpPage.New(arg_5_0._parentTf.parent, arg_5_0.event)
	arg_5_0.autoBattleTip = ArchivesWorldBossAutoBattleTipPage.New(arg_5_0._parentTf.parent, arg_5_0.event)
	arg_5_0.autoBattleMsg = ArchivesWorldBossAutoBattleMsgbox.New(arg_5_0._parentTf.parent, arg_5_0.event)
	arg_5_0.autoBattleResultMsg = ArchivesWorldBossAutoBattleResultMsg.New(arg_5_0._parentTf.parent, arg_5_0.event)

	return
end

function var_0_0.OnInit(arg_6_0)
	var_0_0.super.OnInit(arg_6_0)
	onButton(arg_6_0, arg_6_0.listBtn, function()
		arg_6_0:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_ARCHIVES_CHALLENGE)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.currProgressTr, function()
		local var_8_0 = WorldBossConst.GetAchieveBossItemInfo()

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_DROP_ITEM,
			name = var_8_0.name,
			content = var_8_0.display,
			iconPath = var_8_0.icon,
			frame = var_8_0.rarity
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0._tf:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.world_archives_boss_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.battleMask, function()
		triggerButton(arg_6_0.autoBattleBtn)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.autoBattleBtn, function()
		if pg.TimeMgr.GetInstance():GetServerTime() + WorldBossConst.GetArchivesBossAutoBattleSecond() > arg_6_0.boss:GetExpiredTime() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_no_time_to_auto_battle"))

			return
		end

		local var_11_0 = WorldBossConst.GetAutoBattleState(arg_6_0.boss)

		if var_11_0 == WorldBossConst.AUTO_BATTLE_STATE_STARTING then
			arg_6_0.autoBattleMsg:ExecuteAction("Show", {
				onContent = function()
					local var_12_0 = WorldBossConst.GetAutoBattleLeftTime()

					if var_12_0 <= 0 then
						return nil
					end

					local var_12_1 = pg.TimeMgr.GetInstance()

					return (var_12_1:DescCDTime(var_12_0))
				end,
				title = i18n("world_boss_archives_stop_auto_battle_title"),
				yesText = i18n("world_boss_archives_continue_auto_battle"),
				noText = i18n("world_boss_archives_stop_auto_battle"),
				onNo = function()
					arg_6_0:emit(WorldBossMediator.ON_ARCHIVES_BOSS_STOP_AUTO_BATTLE, arg_6_0.boss.id)

					return
				end
			})
		elseif var_11_0 == WorldBossConst.AUTO_BATTLE_STATE_HIDE then
			pg.TipsMgr.GetInstance():ShowTip(i18n("world_word_expired"))
		elseif var_11_0 == WorldBossConst.AUTO_BATTLE_STATE_LOCK then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_archives_auto_battle_unopen"))
		else
			({}).highestDamage = WorldBossConst.GetHighestDamage()
			;({}).autoBattleCnt = WorldBossConst.GetAutoBattleCnt()
			;({}).oil = WorldBossConst.GetAutoBattleOilConsume()
			;({}).time = WorldBossConst.GetArchivesBossAutoBattleMinute()
			;({}).onYes = function()
				arg_6_0:emit(WorldBossMediator.ON_ARCHIVES_BOSS_AUTO_BATTLE, arg_6_0.boss.id)

				return
			end

			arg_6_0.autoBattleTip:ExecuteAction("Show", {})
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnStart(arg_15_0)
	if nowWorld():GetBossProxy():InAutoBattle() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_archives_need_stop_auto_battle"))

		return
	end

	var_0_0.super.OnStart(arg_15_0)

	return
end

function var_0_0.OnRescue(arg_16_0)
	if arg_16_0.helpWindow then
		arg_16_0.helpWindow:ExecuteAction("Update", arg_16_0.boss)
	end

	return
end

function var_0_0.OnUpdateRes(arg_17_0)
	if not arg_17_0.currProgressTxt then
		return
	end

	local var_17_0, var_17_1, var_17_2 = WorldBossConst.GetAchieveBossConsume()

	arg_17_0.currProgressTxt.text = WorldBossConst.GetAchieveBossItemProgress() .. "/" .. var_17_2

	return
end

function var_0_0.UpdateMainInfo(arg_18_0)
	var_0_0.super.UpdateMainInfo(arg_18_0)

	arg_18_0.levelTxt.text = arg_18_0.boss:GetLevel()
	arg_18_0.hpTxt.text = arg_18_0.boss:GetHP() .. "/<color=#CF4E24>" .. arg_18_0.boss:GetMaxHp() .. "</color>"

	return
end

function var_0_0.OnPaintingLoad(arg_19_0)
	local var_19_0 = arg_19_0.painting:Find("fitter")

	if var_19_0.childCount > 0 then
		local var_19_1 = WorldBossConst.GetAutoBattleState(arg_19_0.boss) == WorldBossConst.AUTO_BATTLE_STATE_STARTING
		local var_19_2 = GetOrAddComponent(var_19_0:GetChild(0), typeof(Gradient))

		if var_19_2 then
			var_19_2.enabled = var_19_1
		end
	end

	return
end

function var_0_0.Show(arg_20_0)
	var_0_0.super.Show(arg_20_0)
	arg_20_0:Flush()

	return
end

function var_0_0.OnBossExpired(arg_21_0)
	if WorldBossConst.GetAutoBattleState(arg_21_0.boss) == WorldBossConst.AUTO_BATTLE_STATE_STARTING then
		if WorldBossConst.GetAutoBattleLeftTime() <= 0 then
			arg_21_0:emit(WorldBossMediator.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER, arg_21_0.boss.id)
		end

		return
	end

	arg_21_0:emit(WorldBossMediator.ON_SELF_BOSS_OVERTIME)

	return
end

function var_0_0.Flush(arg_22_0)
	arg_22_0.archivesWorldbossBtn:Flush()

	local var_22_0 = WorldBossConst.GetAutoBattleState(arg_22_0.boss)
	local var_22_1 = arg_22_0.autoBattleBtn:GetComponent(typeof(Image))

	arg_22_0:RemoveBattleTimer()
	setActive(arg_22_0.battleMask, false)

	arg_22_0.autoBattleTimeTxt.text = ""

	local var_22_2

	if var_22_0 == WorldBossConst.AUTO_BATTLE_STATE_LOCK then
		var_22_2 = "auto_03"
	elseif var_22_0 == WorldBossConst.AUTO_BATTLE_STATE_STARTING then
		var_22_2 = "auto_02"

		arg_22_0:AddBattleTimer()
		setActive(arg_22_0.battleMask, true)
	else
		var_22_2 = "auto_01"
	end

	GetSpriteFromAtlasAsync("ui/WorldBossUI_atlas", var_22_2, function(arg_23_0)
		var_22_1.sprite = arg_23_0

		return
	end)
	setActive(arg_22_0.autoBattleBtn, var_22_0 ~= WorldBossConst.AUTO_BATTLE_STATE_HIDE)
	setGray(arg_22_0.startBtn, WorldBossConst.AUTO_BATTLE_STATE_STARTING == var_22_0, true)

	return
end

function var_0_0.AddBattleTimer(arg_24_0)
	if arg_24_0.boss:IsExpired() then
		return
	end

	if WorldBossConst.GetAutoBattleLeftTime() <= 0 then
		arg_24_0:emit(WorldBossMediator.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER, arg_24_0.boss.id)

		return
	end

	arg_24_0.timer = Timer.New(function()
		local var_25_0 = WorldBossConst.GetAutoBattleLeftTime()

		if var_25_0 < 0 then
			arg_24_0:RemoveBattleTimer()

			arg_24_0.autoBattleTimeTxt.text = ""
		end

		if var_25_0 < 0 and arg_24_0.boss then
			arg_24_0:emit(WorldBossMediator.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER, arg_24_0.boss.id)
		else
			local var_25_1 = arg_24_0.autoBattleTimeTxt

			var_25_1.text = pg.TimeMgr.GetInstance():DescCDTime(var_25_0)
		end

		return
	end, 1, -1)

	arg_24_0.timer.func()
	arg_24_0.timer:Start()

	return
end

function var_0_0.RemoveBattleTimer(arg_26_0)
	if arg_26_0.timer then
		arg_26_0.timer:Stop()

		arg_26_0.timer = nil
	end

	return
end

function var_0_0.Hide(arg_27_0)
	var_0_0.super.Hide(arg_27_0)
	arg_27_0:RemoveBattleTimer()

	return
end

function var_0_0.OnDestroy(arg_28_0)
	local var_28_0 = arg_28_0.painting:Find("fitter"):GetChild(0)

	if var_28_0 and var_28_0:GetComponent(typeof(Gradient)) then
		var_28_0:GetComponent(typeof(Gradient)).enabled = false
	end

	var_0_0.super.OnDestroy(arg_28_0)

	if arg_28_0.helpWindow then
		arg_28_0.helpWindow:Destroy()

		arg_28_0.helpWindow = nil
	end

	if arg_28_0.autoBattleTip then
		arg_28_0.autoBattleTip:Destroy()

		arg_28_0.autoBattleTip = nil
	end

	if arg_28_0.autoBattleMsg then
		arg_28_0.autoBattleMsg:Destroy()

		arg_28_0.autoBattleMsg = nil
	end

	if arg_28_0.archivesWorldbossBtn then
		arg_28_0.archivesWorldbossBtn:Dispose()

		arg_28_0.archivesWorldbossBtn = nil
	end

	if arg_28_0.autoBattleResultMsg then
		arg_28_0.autoBattleResultMsg:Destroy()

		arg_28_0.autoBattleResultMsg = nil
	end

	return
end

return var_0_0
