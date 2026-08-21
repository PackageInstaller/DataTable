local var_0_0 = class("ArchivesWorldBossEmptyPage", import(".BaseWorldBossEmptyPage"))

function var_0_0.getUIName(arg_1_0)
	return "ArchivesWorldBossEmptyUI"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	onButton(arg_2_0, arg_2_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.world_archives_boss_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._tf:Find("list_btn"), function()
		arg_2_0:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_ARCHIVES_CHALLENGE)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.activeBtn, function()
		local var_5_0 = WorldBossConst.GetAchieveState()

		if var_5_0 == WorldBossConst.ACHIEVE_STATE_NOSTART then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_no_select_archives"))
		elseif var_5_0 == WorldBossConst.ACHIEVE_STATE_STARTING then
			if WorldBossConst.CanUnlockArchivesBoss() then
				arg_2_0:emit(WorldBossMediator.ON_ACTIVE_ARCHIVES_BOSS)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_archives_item_count_noenough"))
			end
		elseif var_5_0 == WorldBossConst.ACHIEVE_STATE_CLEAR then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_archives_are_clear"))
		end

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.progressTr, function()
		local var_6_0 = WorldBossConst.GetAchieveBossItemInfo()

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_DROP_ITEM,
			name = var_6_0.name,
			content = var_6_0.display,
			iconPath = var_6_0.icon,
			frame = var_6_0.rarity
		})

		return
	end, SFX_PANEL)

	if not pg.NewStoryMgr.GetInstance():IsPlayed("WorldG193") then
		WorldGuider.GetInstance():PlayGuide("WorldG193")
	end

	return
end

function var_0_0.OnUpdate(arg_7_0)
	arg_7_0.archivesWorldbossBtn = arg_7_0.archivesWorldbossBtn or ArchivesWorldbossBtn.New(arg_7_0._tf:Find("archives_btn"), arg_7_0.event)

	local var_7_0 = WorldBossConst.GetAchieveState()
	local var_7_1

	if var_7_0 == WorldBossConst.ACHIEVE_STATE_NOSTART then
		var_7_1 = "text04"
	elseif var_7_0 == WorldBossConst.ACHIEVE_STATE_CLEAR then
		var_7_1 = "text05"
	end

	if var_7_1 then
		local var_7_2 = arg_7_0.noItem:GetComponent(typeof(Image))

		GetSpriteFromAtlasAsync("ui/WorldBossUI_atlas", var_7_1, function(arg_8_0)
			var_7_2.sprite = arg_8_0

			return
		end)
		arg_7_0.noItem:GetComponent(typeof(Image)):SetNativeSize()
	end

	local var_7_3 = WorldBossConst.GetAchieveState() == WorldBossConst.ACHIEVE_STATE_STARTING

	if var_7_3 then
		arg_7_0:UpdateUseItemStyle((WorldBossConst.BossId2MetaId((WorldBossConst.GetArchivesId()))))
	end

	setActive(arg_7_0.useItem, var_7_3)
	setActive(arg_7_0.noItem, not var_7_3)
	arg_7_0.archivesWorldbossBtn:Flush()

	return
end

function var_0_0.OnUpdateRes(arg_9_0)
	if not arg_9_0.progressTxt then
		return
	end

	local var_9_0, var_9_1, var_9_2 = WorldBossConst.GetAchieveBossConsume()

	arg_9_0.progressTxt.text = WorldBossConst.GetAchieveBossItemProgress() .. "/" .. var_9_2

	return
end

function var_0_0.OnDestroy(arg_10_0)
	var_0_0.super.OnDestroy(arg_10_0)

	if arg_10_0.archivesWorldbossBtn then
		arg_10_0.archivesWorldbossBtn:Dispose()

		arg_10_0.archivesWorldbossBtn = nil
	end

	return
end

return var_0_0
