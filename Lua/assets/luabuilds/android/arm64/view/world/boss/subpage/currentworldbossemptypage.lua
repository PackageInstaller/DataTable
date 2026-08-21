local var_0_0 = class("CurrentWorldBossEmptyPage", import(".BaseWorldBossEmptyPage"))

function var_0_0.getUIName(arg_1_0)
	return "CurrentWorldBossEmptyUI"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.timeTxt = arg_2_0._tf:Find("time/Text"):GetComponent(typeof(Text))

	local var_2_0 = WorldBossConst.GetCurrBossGroup() or ""

	arg_2_0:UpdateUseItemStyle(var_2_0)

	arg_2_0.simulateBtn = arg_2_0._tf:Find("simulate_btn")

	return
end

function var_0_0.OnInit(arg_3_0)
	var_0_0.super.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.world_boss_help_meta.tip
		})

		return
	end, SFX_PANEL)
	setActive(arg_3_0.simulateBtn, true)
	onButton(arg_3_0, arg_3_0.simulateBtn, function()
		arg_3_0:emit(WorldBossMediator.ON_UPDATE_BOSS_INFO, function()
			({}).content = i18n("meta_simulated_btn", nowWorld():GetBossProxy().currentBossLV)
			;({}).onYes = function()
				arg_3_0:emit(WorldBossMediator.ON_BATTLE, WorldBossConst.GetCurrBossID(), nil, 1, true)

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({})

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.progressTr, function()
		local var_8_0 = WorldBossConst.GetCurrBossItemInfo()

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
	onButton(arg_3_0, arg_3_0._tf:Find("list_btn"), function()
		arg_3_0:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_CHALLENGE)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.activeBtn, function()
		if WorldBossConst.CanUnlockCurrBoss() then
			arg_3_0:emit(WorldBossMediator.ON_ACTIVE_BOSS, (WorldBossConst.GetCurrBossID()))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_item_count_noenough"))
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdate(arg_11_0)
	local var_11_9000
	local var_11_0 = WorldBossConst.GetCurrBossStartTimeAndEndTime()
	local var_11_1 = pg.TimeMgr.GetInstance():inTime(var_11_0)
	local var_11_2 = var_11_1 and WorldBossConst.CanUnlockCurrBoss()

	setActive(arg_11_0.useItem, var_11_2)
	setActive(arg_11_0.noItem, not var_11_2)

	arg_11_0.timeTxt.text = var_11_1 and pg.TimeMgr.GetInstance().DescDateFromConfig(var_11_9000, var_11_0[1]) .. "~" .. pg.TimeMgr.GetInstance():DescDateFromConfig(var_11_0[2]) or ""
	arg_11_0.metaWorldbossBtn = arg_11_0.metaWorldbossBtn or MetaWorldbossBtn.New(arg_11_0._tf:Find("archives_btn"), arg_11_0.event)
	arg_11_0.ptBtn = arg_11_0.ptBtn or WorldbossPtBtn.New(arg_11_0._tf:Find("point"))

	return
end

function var_0_0.OnUpdateRes(arg_12_0)
	if not arg_12_0.progressTxt then
		return
	end

	local var_12_0, var_12_1, var_12_2 = WorldBossConst.GetCurrBossConsume()

	arg_12_0.progressTxt.text = WorldBossConst.GetCurrBossItemProgress() .. "/" .. var_12_2

	return
end

function var_0_0.OnUpdatePt(arg_13_0, arg_13_1)
	if arg_13_0.ptBtn then
		arg_13_0.ptBtn:Update()
	end

	return
end

function var_0_0.OnDestroy(arg_14_0)
	var_0_0.super.OnDestroy(arg_14_0)

	if arg_14_0.metaWorldbossBtn then
		arg_14_0.metaWorldbossBtn:Dispose()

		arg_14_0.metaWorldbossBtn = nil
	end

	if arg_14_0.ptBtn then
		arg_14_0.ptBtn:Dispose()

		arg_14_0.ptBtn = nil
	end

	return
end

return var_0_0
