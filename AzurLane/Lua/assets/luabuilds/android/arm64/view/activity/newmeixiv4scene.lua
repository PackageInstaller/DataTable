local var_0_0 = class("NewMeixiV4Scene", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "NewMeixiV4UI"
end

function var_0_0.ResUISettings(arg_2_0)
	return true
end

function var_0_0.init(arg_3_0)
	arg_3_0.ani = arg_3_0._tf:Find("TV01")
	arg_3_0.progress = arg_3_0._tf:Find("progress/Text")
	arg_3_0.nodes = arg_3_0._tf:Find("nodes")
	arg_3_0.nodeInfo = arg_3_0._tf:Find("node_info")
	arg_3_0.titleTxt = arg_3_0._tf:Find("progress/title")
	arg_3_0.titleNum = arg_3_0._tf:Find("progress/cur")
	arg_3_0.helpBtn = arg_3_0._tf:Find("help_btn")
	arg_3_0.storyTip = arg_3_0._tf:Find("get_story")
	arg_3_0.taskProxy = getProxy(TaskProxy)
	arg_3_0.storyGroup = pg.activity_template[ActivityConst.NEWMEIXIV4_SKIRMISH_ID].config_client.storys
	arg_3_0.memoryGroup = pg.activity_template[ActivityConst.NEWMEIXIV4_SKIRMISH_ID].config_client.memoryGroup

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("top/back_btn"), function()
		arg_4_0:emit(var_0_0.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0._tf:Find("top/option"), function()
		arg_4_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("MeixiV4_help")
		})

		return
	end, SFX_PANEL)
	setText(arg_4_0.storyTip:Find("bar/tip"), i18n("world_collection_back"))
	arg_4_0:playAni()
	arg_4_0:updateNodes()

	return
end

function var_0_0.setPlayer(arg_8_0, arg_8_1)
	arg_8_0.player = arg_8_1

	arg_8_0:onUpdateRes(arg_8_1)

	return
end

function var_0_0.onUpdateRes(arg_9_0, arg_9_1)
	arg_9_0.player = arg_9_1

	return
end

function var_0_0.playAni(arg_10_0)
	SetActive(arg_10_0.ani, true)
	arg_10_0.ani:GetComponent("DftAniEvent"):SetEndEvent(function(arg_11_0)
		SetActive(arg_10_0.ani, false)

		return
	end)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

	return
end

function var_0_0.setCurIndex(arg_12_0)
	arg_12_0.curIndex = 1
	arg_12_0.clearTaskNum = 0
	arg_12_0.clearTaskNum = (function()
		for iter_13_0, iter_13_1 in ipairs(arg_12_0.contextData.taskList) do
			local var_13_0 = arg_12_0.taskProxy:getTaskById(iter_13_1) or arg_12_0.taskProxy:getFinishTaskById(iter_13_1)

			if var_13_0 then
				return iter_13_0 - 1
			end
		end

		return
	end)()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.contextData.taskList) do
		local var_12_0 = arg_12_0.taskProxy:getTaskById(iter_12_1) or arg_12_0.taskProxy:getFinishTaskById(iter_12_1)
		local var_12_1 = arg_12_0.contextData.taskList[iter_12_0 + 1]
		local var_12_2 = arg_12_0.taskProxy:getTaskById(arg_12_0.contextData.taskList[iter_12_0 + 1]) or arg_12_0.taskProxy:getFinishTaskById(var_12_1)

		if var_12_0 and var_12_0:getTaskStatus() == 2 then
			arg_12_0.curIndex = arg_12_0.curIndex + 1

			if not var_12_1 or not var_12_2 then
				arg_12_0.curIndex = arg_12_0.curIndex - 1
			end
		end
	end

	arg_12_0.curIndex = arg_12_0.curIndex + arg_12_0.clearTaskNum

	return
end

function var_0_0.updateNodes(arg_14_0)
	arg_14_0:setCurIndex()
	setText(arg_14_0.titleTxt, "POSITION " .. string.format("%02d", arg_14_0.curIndex))
	setText(arg_14_0.titleNum, string.format("%02d", arg_14_0.curIndex))
	eachChild(arg_14_0.nodes, function(arg_15_0)
		local var_15_0 = tonumber(arg_15_0.name)

		if not arg_14_0.taskProxy:getTaskById(arg_14_0.contextData.taskList[var_15_0]) then
			local var_15_1 = arg_14_0.taskProxy:getFinishTaskById(arg_14_0.contextData.taskList[var_15_0])
		end

		setActive(arg_15_0, var_15_0 <= arg_14_0.curIndex)
		onButton(arg_14_0, arg_15_0, function()
			arg_14_0:updateNodeInfo(var_15_0)

			return
		end, SFX_PANEL)

		return
	end)
	arg_14_0:updateNodeInfo(arg_14_0.curIndex)

	return
end

function var_0_0.nodeInfoTween(arg_17_0, arg_17_1)
	local var_17_0 = tf(arg_17_0._tf:Find(tostring(arg_17_1), arg_17_0.nodes)).localPosition

	if arg_17_1 == 9 then
		var_17_0.x = var_17_0.x - 80
	end

	if arg_17_1 == 7 then
		var_17_0.y = var_17_0.y - 20
	end

	local function var_17_1()
		setLocalPosition(arg_17_0.nodeInfo, Vector3(var_17_0.x, var_17_0.y + 120, 0))
		setLocalScale(arg_17_0.nodeInfo, Vector3(0, 0, 0))
		LeanTween.scale(tf(arg_17_0.nodeInfo), Vector3.one, 0.1)

		return
	end

	if not isActive(arg_17_0.nodeInfo) then
		setActive(arg_17_0.nodeInfo, true)
		var_17_1()
	else
		(function(arg_19_0)
			setLocalScale(arg_17_0.nodeInfo, Vector3(1, 1, 1))
			LeanTween.scale(tf(arg_17_0.nodeInfo), Vector3.zero, 0.1):setOnComplete(System.Action(function()
				if arg_19_0 then
					arg_19_0()
				end

				return
			end))

			return
		end)(var_17_1)
	end

	return
end

function var_0_0.updateNodeInfo(arg_21_0, arg_21_1)
	updateActivityTaskStatus((getProxy(ActivityProxy):getActivityById(ActivityConst.NEWMEIXIV4_SKIRMISH_ID)))

	local var_21_0 = arg_21_0.taskProxy:getTaskById(arg_21_0.contextData.taskList[arg_21_1]) or arg_21_0.taskProxy:getFinishTaskById(arg_21_0.contextData.taskList[arg_21_1])
	local var_21_1 = pg.task_data_template[arg_21_0.contextData.taskList[arg_21_1]]
	local var_21_2 = var_21_0 and var_21_0:getProgress() or var_21_1.target_num
	local var_21_3 = var_21_0 and var_21_0:getConfig("target_num") or var_21_1.target_num
	local var_21_4 = var_21_0 and var_21_0:getTaskStatus() or 2
	local var_21_5 = var_21_0 and var_21_0:getConfig("desc") or var_21_1.desc

	setSlider(arg_21_0.nodeInfo:Find("progress"), 0, var_21_3, var_21_2)
	setText(arg_21_0.nodeInfo:Find("step"), var_21_2 .. "/" .. var_21_3)
	setText(arg_21_0.nodeInfo:Find("content"), var_21_5)
	setText(arg_21_0.nodeInfo:Find("title"), string.format("%02d", arg_21_1))

	local var_21_6 = arg_21_0.nodeInfo:Find("go_btn")
	local var_21_7 = arg_21_0.nodeInfo:Find("get_btn")
	local var_21_8 = arg_21_0.nodeInfo:Find("step/finish")

	setActive(var_21_6, var_21_4 == 0)
	setActive(var_21_7, var_21_4 == 1)
	setActive(var_21_8, var_21_4 == 2)
	onButton(arg_21_0, var_21_6, function()
		arg_21_0:emit(NewMeixiV4Mediator.ON_TASK_GO, var_21_0)

		return
	end, SFX_PANEL)
	onButton(arg_21_0, var_21_7, function()
		arg_21_0:emit(NewMeixiV4Mediator.ON_TASK_SUBMIT, var_21_0)

		return
	end, SFX_PANEL)
	eachChild(arg_21_0.nodes, function(arg_24_0)
		local var_24_0 = arg_24_0:Find("arrow")

		LeanTween.cancel(var_24_0.gameObject)
		setLocalPosition(var_24_0, Vector3(0, 27, 0))

		if tonumber(arg_24_0.name) == arg_21_1 then
			setActive(var_24_0, true)
			LeanTween.moveY(var_24_0, 40, 0.5):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()
		else
			setActive(var_24_0, false)
		end

		return
	end)
	arg_21_0:nodeInfoTween(arg_21_1)

	return
end

function var_0_0.onUpdateTask(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.storyGroup) do
		if arg_25_0.contextData.taskList[arg_25_0.curIndex] == iter_25_1[1] then
			arg_25_0:getStory(iter_25_1[2], iter_25_1[3])
		end
	end

	arg_25_0:updateNodes()

	return
end

function var_0_0.getStory(arg_26_0, arg_26_1, arg_26_2)
	setActive(arg_26_0.storyTip, true)
	pg.NewStoryMgr.GetInstance():SetPlayedFlag(arg_26_2)
	setText(arg_26_0.storyTip:Find("bar/Anim/Frame/Mask/Name"), pg.memory_template[arg_26_1].title)
	removeOnButton(arg_26_0.storyTip)
	removeOnButton(arg_26_0.storyTip:Find("bar/Button"))
	pg.UIMgr.GetInstance():BlurPanel(arg_26_0.storyTip)
	arg_26_0.storyTip:Find("bar"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		onButton(arg_26_0, arg_26_0.storyTip, function()
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_26_0.storyTip)
			setActive(arg_26_0.storyTip, false)

			return
		end)
		onButton(arg_26_0, arg_26_0.storyTip:Find("bar/Button"), function()
			arg_26_0:emit(NewMeixiV4Mediator.GO_STORY, arg_26_0.memoryGroup)
			triggerButton(arg_26_0.storyTip)

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function var_0_0.willExit(arg_30_0)
	setActive(arg_30_0.storyTip, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_30_0.storyTip)

	return
end

return var_0_0
