local var_0_0 = class("DreamlandFullPreviewScene", import(".FullPreviewSceneTemplate"))

var_0_0.MINIGAME_ID = 66

function var_0_0.getUIName(arg_1_0)
	return "DreamlandFullPreviewUI"
end

function var_0_0.init(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("btns")

	arg_2_0.dreamlandBtn = var_2_0:Find("dreamland")
	arg_2_0.skinBtn = var_2_0:Find("skin")
	arg_2_0.buildBtn = var_2_0:Find("build")
	arg_2_0.battleBtn = var_2_0:Find("battle")
	arg_2_0.minigameBtn = var_2_0:Find("minigame")

	setText(arg_2_0._tf:Find("top/info/Text"), i18n("dreamland_main_desc"))

	arg_2_0.preActId = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_DREAMLAND):getConfig("config_client").preActID

	local var_2_1 = underscore.flatten(pg.activity_template[arg_2_0.preActId].config_data)

	arg_2_0.taskId = var_2_1[#var_2_1]

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/back"), function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/home"), function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.dreamland_main_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.dreamlandBtn, function()
		if arg_3_0.isFinishPre then
			arg_3_0:emit(FullPreviewMediatorTemplate.GO_SCENE, SCENE.DREAMLAND)
		else
			arg_3_0:emit(FullPreviewMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, {
				id = arg_3_0.preActId
			})
		end

		return
	end, SFX_PANEL)
	arg_3_0:BindSkinShop(arg_3_0.skinBtn)
	arg_3_0:BindBuildShip(arg_3_0.buildBtn)
	arg_3_0:BindBattle(arg_3_0.battleBtn)
	arg_3_0:BindMiniGame(arg_3_0.minigameBtn, var_0_0.MINIGAME_ID)
	arg_3_0:UpdateView()

	return
end

function var_0_0.IsFinishPreAct(arg_8_0)
	local var_8_0 = getProxy(TaskProxy)
	local var_8_1 = var_8_0:getTaskById(arg_8_0.taskId) or var_8_0:getFinishTaskById(arg_8_0.taskId)

	return var_8_1 and var_8_1:getTaskStatus() == 2
end

function var_0_0.UpdateView(arg_9_0)
	setActive(arg_9_0.minigameBtn:Find("tip"), var_0_0.MiniGameTip())
	setActive(arg_9_0.dreamlandBtn:Find("dreamland/tip"), var_0_0.DreamlandTip())

	arg_9_0.isFinishPre = arg_9_0:IsFinishPreAct()

	setActive(arg_9_0.dreamlandBtn:Find("dreamland"), arg_9_0.isFinishPre)
	setActive(arg_9_0.dreamlandBtn:Find("pre_act"), not arg_9_0.isFinishPre)
	setActive(arg_9_0.dreamlandBtn:Find("pre_act/tip"), var_0_0.ActivityTip((getProxy(ActivityProxy):getActivityById(arg_9_0.preActId))))

	return
end

function var_0_0.MiniGameTip()
	return var_0_0.IsMiniGameTip(var_0_0.MINIGAME_ID)
end

function var_0_0.DreamlandTip()
	local var_11_9000
	local var_11_0 = getProxy(ActivityProxy)

	return DreamlandData.New(var_11_0.getActivityByType(var_11_9000, ActivityConst.ACTIVITY_TYPE_DREAMLAND), (getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2))).ExistAnyMapOrExploreAward(var_11_0)
end

function var_0_0.ActivityTip(arg_12_0)
	if not arg_12_0 or arg_12_0:isEnd() then
		return false
	end

	local var_12_0 = getProxy(TaskProxy)
	local var_12_1 = underscore.flatten(arg_12_0:getConfig("config_data"))
	local var_12_2 = var_12_0:getTaskById(var_12_1[arg_12_0.data3]) or var_12_0:getFinishTaskById(var_12_1[arg_12_0.data3])
	local var_12_3 = math.min(arg_12_0:getDayIndex(), #var_12_1) - arg_12_0.data3

	if var_12_2:getTaskStatus() == 1 then
		var_12_3 = var_12_3 + 1
	end

	return var_12_3 > 0
end

function var_0_0.IsShowMainTip(arg_13_0)
	return var_0_0.MiniGameTip() or var_0_0.DreamlandTip()
end

return var_0_0
