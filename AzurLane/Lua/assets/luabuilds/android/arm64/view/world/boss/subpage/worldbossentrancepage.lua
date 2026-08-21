local var_0_0 = class("WorldBossEntrancePage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "WorldBossEntranceUI"
end

function var_0_0.Setup(arg_2_0, arg_2_1)
	arg_2_0.proxy = arg_2_1

	return
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0.currentTr = arg_3_0._tf:Find("current")
	arg_3_0.pastTr = arg_3_0._tf:Find("past")
	arg_3_0.currTimeTxt = arg_3_0.currentTr:Find("time"):GetComponent(typeof(Text))
	arg_3_0.currConsumeTxt = arg_3_0.currentTr:Find("consume"):GetComponent(typeof(Text))
	arg_3_0.currAccTxt = arg_3_0.currentTr:Find("acc"):GetComponent(typeof(Text))
	arg_3_0.pastConsumeTxt = arg_3_0.pastTr:Find("consume"):GetComponent(typeof(Text))
	arg_3_0.pastAccTxt = arg_3_0.pastTr:Find("acc"):GetComponent(typeof(Text))
	arg_3_0.currProgressTr = arg_3_0._tf:Find("current_progress")
	arg_3_0.pastProgressTr = arg_3_0._tf:Find("past_progress")
	arg_3_0.currProgressTxt = arg_3_0._tf:Find("current_progress/value"):GetComponent(typeof(Text))
	arg_3_0.pastProgressTxt = arg_3_0._tf:Find("past_progress/value"):GetComponent(typeof(Text))
	arg_3_0.backBtn = arg_3_0._tf:Find("blur_panel/adapt/top/back")

	local var_3_0 = arg_3_0._tf:Find("current"):GetComponent(typeof(Image))

	var_3_0.sprite = GetSpriteFromAtlas("MetaWorldboss/" .. WorldBossConst.GetCurrBossGroup(), "cur")

	var_3_0:SetNativeSize()
	setText(arg_3_0._tf:Find("tip/Text"), i18n("world_boss_item_usage_tip"))
	setText(arg_3_0.currentTr:Find("label"), i18n("world_boss_current_boss_label"))
	setText(arg_3_0.currentTr:Find("label1"), i18n("world_boss_current_boss_label1"))
	setText(arg_3_0.pastTr:Find("label"), i18n("world_boss_current_boss_label"))
	setText(arg_3_0.pastTr:Find("label1"), i18n("world_boss_current_boss_label1"))

	arg_3_0.pastLabels = {
		arg_3_0.pastTr:Find("label"),
		arg_3_0.pastTr:Find("label1"),
		arg_3_0.pastTr:Find("label2"),
		arg_3_0.pastTr:Find("label3")
	}

	return
end

function var_0_0.OnInit(arg_4_0)
	onButton(arg_4_0, arg_4_0.backBtn, function()
		arg_4_0:emit(BaseUI.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.currentTr, function()
		arg_4_0:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_CURRENT)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.pastTr, function()
		arg_4_0:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_ARCHIVES)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.currProgressTr, function()
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
	onButton(arg_4_0, arg_4_0.pastProgressTr, function()
		local var_9_0 = WorldBossConst.GetAchieveBossItemInfo()

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_DROP_ITEM,
			name = var_9_0.name,
			content = var_9_0.display,
			iconPath = var_9_0.icon,
			frame = var_9_0.rarity
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Update(arg_10_0)
	arg_10_0:UpdateCurrent()
	arg_10_0:UpdatePast()
	arg_10_0:Show()

	return
end

function var_0_0.UpdateCurrent(arg_11_0)
	arg_11_0:ClearTimer()
	;(function()
		local var_12_0, var_12_1 = WorldBossConst.GetCurrBossLeftDay()

		arg_11_0.currTimeTxt.text = i18n("world_boss_lefttime", var_12_0)

		if var_12_1 > 0 then
			arg_11_0.timer = Timer.New(function()
				var_0()

				return
			end, var_12_1, 1)

			arg_11_0.timer:Start()
		end

		return
	end)()

	local var_11_1, var_11_2, var_11_3 = WorldBossConst.GetCurrBossConsume()

	arg_11_0.currConsumeTxt.text = var_11_1
	arg_11_0.currAccTxt.text = "<color=#ffdf5d>" .. WorldBossConst.GetCurrBossItemAcc() .. "</color>/" .. var_11_2
	arg_11_0.currProgressTxt.text = WorldBossConst.GetCurrBossItemProgress() .. "/" .. var_11_3

	return
end

function var_0_0.UpdatePast(arg_14_0)
	local var_14_0, var_14_1, var_14_2 = WorldBossConst.GetAchieveBossConsume()

	arg_14_0.pastProgressTxt.text = WorldBossConst.GetAchieveBossItemProgress() .. "/" .. var_14_2

	local var_14_3 = WorldBossConst.GetAchieveState()
	local var_14_4 = arg_14_0.pastTr:GetComponent(typeof(Image))
	local var_14_5

	if WorldBossConst.ACHIEVE_STATE_STARTING == var_14_3 then
		arg_14_0.pastAccTxt.text = "<color=#ffdf5d>" .. WorldBossConst.GetSummonPtOldAcc() .. "</color>/" .. var_14_1
		arg_14_0.pastConsumeTxt.text = var_14_0
		var_14_5 = "useitem_archives"
		var_14_4.sprite = GetSpriteFromAtlas("MetaWorldboss" .. "/" .. WorldBossConst.BossId2MetaId(WorldBossConst.GetArchivesId()), "useitem_archives")

		var_14_4:SetNativeSize()
	else
		arg_14_0.pastAccTxt.text = ""
		arg_14_0.pastConsumeTxt.text = ""

		if WorldBossConst.ACHIEVE_STATE_NOSTART == var_14_3 then
			var_14_5 = "extra_unselect"
		elseif WorldBossConst.ACHIEVE_STATE_CLEAR == var_14_3 then
			var_14_5 = "extra_clear"
		end

		var_14_4.sprite = LoadSprite("MetaWorldboss/" .. var_14_5)

		var_14_4:SetNativeSize()
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.pastLabels) do
		setActive(iter_14_1, WorldBossConst.ACHIEVE_STATE_STARTING == var_14_3)
	end

	return
end

function var_0_0.ClearTimer(arg_15_0)
	if arg_15_0.timer then
		arg_15_0.timer:Stop()

		arg_15_0.timer = nil
	end

	return
end

function var_0_0.OnDestroy(arg_16_0)
	arg_16_0:ClearTimer()

	return
end

return var_0_0
