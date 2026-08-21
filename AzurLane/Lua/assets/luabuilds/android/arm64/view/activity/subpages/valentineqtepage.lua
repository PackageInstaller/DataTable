local var_0_0 = class("ValentineQtePage", import("view.base.BaseActivityPage"))

var_0_0.MINIGAME_HUB_ID = 42
var_0_0.MINIGAME_ID = 50

function var_0_0.OnInit(arg_1_0)
	arg_1_0.awardPreviewBtn = arg_1_0._tf:Find("AD/award_preview_btn")
	arg_1_0.goBtn = arg_1_0._tf:Find("AD/go")
	arg_1_0.indexTxt = arg_1_0._tf:Find("AD/index"):GetComponent(typeof(Text))
	arg_1_0.iconBtn = arg_1_0._tf:Find("AD/icon")
	arg_1_0.markContainer = arg_1_0._tf:Find("AD/marks")
	arg_1_0.markTpl = arg_1_0._tf:Find("AD/marks/1")

	setActive(arg_1_0.markTpl, false)

	arg_1_0.markTrs = {}

	for iter_1_0 = 1, 7 do
		table.insert(arg_1_0.markTrs, (cloneTplTo(arg_1_0.markTpl, arg_1_0.markContainer, iter_1_0)))
	end

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_0.MINIGAME_ID)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.iconBtn, function()
		arg_3_0:ShowAwards()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.indexTxt, function()
		arg_3_0:ShowAwards()

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(MiniGameProxy):GetHubByHubId(var_0_0.MINIGAME_HUB_ID)

	arg_3_0:FlushMarks(var_3_0)
	Canvas.ForceUpdateCanvases()
	arg_3_0:FlushIndex(var_3_0)

	return
end

function var_0_0.ShowAwards(arg_7_0)
	arg_7_0:emit(ActivityMediator.ON_AWARD_WINDOW, arg_7_0:GetDropList(), getProxy(MiniGameProxy):GetHubByHubId(var_0_0.MINIGAME_HUB_ID).usedtime, {
		i18n("Valentine_minigame_label3"),
		i18n("Valentine_minigame_label2")
	})

	return
end

function var_0_0.GetDropList(arg_8_0)
	return pg.mini_game[var_0_0.MINIGAME_ID].simple_config_data.drop_ids
end

function var_0_0.FlushMarks(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.usedtime + arg_9_1.count

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.markTrs) do
		setActive(iter_9_1, iter_9_0 <= var_9_0)
		setActive(iter_9_1:Find("finish"), iter_9_0 <= arg_9_1.usedtime)
		setActive(iter_9_1:Find("finish/line"), arg_9_1.usedtime >= iter_9_0 + 1)
	end

	return
end

function var_0_0.FlushIndex(arg_10_0, arg_10_1)
	arg_10_0.indexTxt.text = "<color=#753330>" .. arg_10_1.usedtime .. "</color><color=#605176>/7</color>"

	return
end

function var_0_0.OnUpdateFlush(arg_11_0)
	return
end

function var_0_0.OnDestroy(arg_12_0)
	return
end

return var_0_0
