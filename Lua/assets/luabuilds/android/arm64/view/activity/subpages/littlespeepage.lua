local var_0_0 = class("LittleSpeePage", import(".TemplatePage.PtTemplatePage"))

var_0_0.FILL_ANI_TIME = 0.5
var_0_0.IMAGE_ANI_TIME = 0.5
var_0_0.IMAGE_MAX_SCALE = Vector3(2, 2, 2)
var_0_0.TEXT_ANI_TIME = 0.3
var_0_0.TEXT_MAX_SCALE = Vector3(3, 3, 3)

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.heartTpl = arg_1_0.bg:Find("HeartTpl")
	arg_1_0.heartContainer = arg_1_0.bg:Find("HeartContainer")
	arg_1_0.helpBtn = arg_1_0.bg:Find("help_btn")
	arg_1_0.getFinalBtn = arg_1_0.bg:Find("get_final_btn")
	arg_1_0.gotFinalBtn = arg_1_0.bg:Find("got_final_btn")
	arg_1_0.performBtn = arg_1_0.bg:Find("perform_btn")
	arg_1_0.performImage = arg_1_0.performBtn:Find("image")
	arg_1_0.performText = arg_1_0.performBtn:Find("text")
	arg_1_0.performReBtn = arg_1_0.bg:Find("perform_re_btn")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)

	arg_2_0.storyName = arg_2_0.activity:getConfig("config_client").performStory
	arg_2_0.activateStoryName = arg_2_0.activity:getConfig("config_client").activateStory
	arg_2_0.heartUIItemList = UIItemList.New(arg_2_0.heartContainer, arg_2_0.heartTpl)

	arg_2_0.heartUIItemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = arg_3_1 + 1

			arg_3_2.name = arg_3_1 + 1

			local var_3_1 = arg_2_0.ptData:GetLevel()
			local var_3_2 = arg_3_2:Find("Full")

			setFillAmount(var_3_2, 1)
			setActive(var_3_2, var_3_0 <= var_3_1)
		end

		return
	end)
	onButton(arg_2_0, arg_2_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.littleSpee_npc.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.battleBtn, function()
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.getBtn, function()
		arg_2_0:OnGetBtnClick()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.getFinalBtn, function()
		arg_2_0:OnGetBtnClick()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.performBtn, function()
		local var_8_0 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_2_0.storyName)
		local var_8_1 = var_8_0 and var_8_0 ~= 0
		local var_8_2 = "Missing Story Stage ID: "
		local var_8_3 = arg_2_0.storyName or "NIL"

		assert(var_8_1, var_8_2 .. var_8_3)
		arg_2_0:emit(ActivityMediator.GO_PERFORM_COMBAT, {
			stageId = var_8_0
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.performReBtn, function()
		local var_9_0 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_2_0.storyName)
		local var_9_1 = var_9_0 and var_9_0 ~= 0
		local var_9_2 = "Missing Story Stage ID: "
		local var_9_3 = arg_2_0.storyName or "NIL"

		assert(var_9_1, var_9_2 .. var_9_3)
		arg_2_0:emit(ActivityMediator.GO_PERFORM_COMBAT, {
			memory = true,
			stageId = var_9_0
		})

		return
	end, SFX_PANEL)
	setActive(arg_2_0.performReBtn, false)
	setActive(arg_2_0.performBtn, false)
	setActive(arg_2_0.getFinalBtn, false)

	arg_2_0.inGetProcess = false

	return
end

function var_0_0.OnUpdateFlush(arg_10_0)
	var_0_0.super.OnUpdateFlush(arg_10_0)

	local var_10_0, var_10_1 = arg_10_0.ptData:GetLevelProgress()

	arg_10_0.heartUIItemList:align(var_10_1)

	if var_10_0 == var_10_1 then
		setActive(arg_10_0.getBtn, false)
		setActive(arg_10_0.gotBtn, false)

		local var_10_2 = arg_10_0.ptData:CanGetAward()
		local var_10_3 = arg_10_0.ptData:CanGetNextAward()
		local var_10_4 = pg.NewStoryMgr.GetInstance():IsPlayed(arg_10_0.storyName)

		setActive(arg_10_0.performBtn, not var_10_4 and var_10_2)
		setActive(arg_10_0.performReBtn, var_10_4)
		setActive(arg_10_0.getFinalBtn, var_10_4 and var_10_2)
		setActive(arg_10_0.gotFinalBtn, var_10_4 and not var_10_3)

		if not var_10_4 and var_10_2 then
			pg.NewStoryMgr.GetInstance():Play(arg_10_0.activateStoryName)
			setActive(arg_10_0.performBtn, true)
			setLocalScale(arg_10_0.performImage, Vector3.one)
			arg_10_0:managedTween(LeanTween.scale, nil, arg_10_0.performImage, var_0_0.IMAGE_MAX_SCALE, var_0_0.IMAGE_ANI_TIME)
			arg_10_0:managedTween(LeanTween.alphaCanvas, nil, GetOrAddComponent(arg_10_0.performImage, typeof(CanvasGroup)), 1, var_0_0.IMAGE_ANI_TIME / 2):setFrom(0)
			arg_10_0:managedTween(LeanTween.delayedCall, function()
				arg_10_0:managedTween(LeanTween.alphaCanvas, nil, GetOrAddComponent(arg_10_0.performImage, typeof(CanvasGroup)), 0, var_0_0.IMAGE_ANI_TIME / 2)

				return
			end, var_0_0.IMAGE_ANI_TIME / 2, nil)
			setLocalScale(arg_10_0.performText, var_0_0.TEXT_MAX_SCALE)
			arg_10_0:managedTween(LeanTween.scale, nil, arg_10_0.performText, Vector3.one, var_0_0.TEXT_ANI_TIME)
			arg_10_0:managedTween(LeanTween.alphaCanvas, nil, GetOrAddComponent(arg_10_0.performText, typeof(CanvasGroup)), 1, var_0_0.TEXT_ANI_TIME):setFrom(0)
		else
			setActive(arg_10_0.performBtn, false)
		end
	end

	return
end

function var_0_0.OnGetBtnClick(arg_12_0)
	if arg_12_0.inGetProcess then
		return
	end

	arg_12_0.inGetProcess = true

	local var_12_0 = {}
	local var_12_1 = arg_12_0.ptData:GetAward()
	local var_12_2 = getProxy(PlayerProxy):getRawData()
	local var_12_3 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
	local var_12_4, var_12_5 = Task.StaticJudgeOverflow(var_12_2.gold, var_12_2.oil, var_12_3, true, true, {
		{
			var_12_1.type,
			var_12_1.id,
			var_12_1.count
		}
	})

	if var_12_4 then
		table.insert(var_12_0, function(arg_13_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("award_max_warning"),
				items = var_12_5,
				onYes = arg_13_0
			})

			return
		end)

		arg_12_0.inGetProcess = false
	end

	table.insert(var_12_0, function(arg_14_0)
		local var_14_0 = arg_12_0.heartContainer:Find(arg_12_0.ptData:GetLevelProgress() .. "/Full")

		setFillAmount(var_14_0, 0)
		setActive(var_14_0, true)
		arg_12_0:managedTween(LeanTween.value, nil, go(var_14_0), 0, 1, var_0_0.FILL_ANI_TIME):setOnUpdate(System.Action_float(function(arg_15_0)
			setFillAmount(var_14_0, arg_15_0)

			return
		end)):setOnComplete(System.Action(function()
			arg_14_0()

			return
		end))

		return
	end)
	seriesAsync(var_12_0, function()
		local var_17_0, var_17_1 = arg_12_0.ptData:GetResProgress()

		arg_12_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = arg_12_0.ptData:GetId(),
			arg1 = var_17_1
		})

		arg_12_0.inGetProcess = false

		return
	end)

	return
end

return var_0_0
