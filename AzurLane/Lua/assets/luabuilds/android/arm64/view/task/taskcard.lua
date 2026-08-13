class = var_0_10000

local var_0_0 = var_0_10000("TaskCard")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 0.3

function var_0_0.Type2Tag(arg_1_0)
	if not var_0_0.types then
		var_0_0.types = {
			[0] = "subtitle_week",
			"subtitle_brach",
			"subtitle_activity",
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			"subtitle_week",
			nil,
			nil,
			"subtitle_activity",
			26,
			"subtitle_activity",
			36,
			"subtitle_activity",
			[nil] = "subtitle_main",
			subtitle_brach = "subtitle_daily"
		}
	end

	return var_0_0.types[arg_1_0]
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_2_0)

	arg_2_0._go = arg_2_1
	tf = var_3
	arg_2_0._tf = var_3(arg_2_0._go)
	arg_2_0.viewComponent = arg_2_2

	local var_2_0 = arg_2_0._tf

	arg_2_0.frame = var_3.Find(var_2_0, "frame")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "frame/desc")
	local var_2_3 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_2_0.descTxt = var_2_3(var_2_2, var_6(var_1_10008))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_3.Find(var_2_4, "frame/tag")
	local var_2_6 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_2_0.tagTF = var_2_6(var_2_5, var_6(var_1_10008))

	local var_2_7 = arg_2_0._tf

	arg_2_0.rewardPanel = var_3.Find(var_2_7, "frame/awards")

	local var_2_8 = arg_2_0.rewardPanel

	arg_2_0._rewardModel = var_3.GetChild(var_2_8, 0)

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "frame/slider")
	local var_2_11 = var_3.GetComponent

	typeof = var_6
	Slider = var_1_10008
	arg_2_0.progressBar = var_2_11(var_2_10, var_6(var_1_10008))

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_3.Find(var_2_12, "frame/slider/Text")
	local var_2_14 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_2_0.progressNum = var_2_14(var_2_13, var_6(var_1_10008))

	local var_2_15 = arg_2_0._tf

	arg_2_0.GotoBtn = var_3.Find(var_2_15, "frame/go_btn")

	local var_2_16 = arg_2_0._tf

	arg_2_0.GetBtn = var_3.Find(var_2_16, "frame/get_btn")

	local var_2_17 = arg_2_0._tf

	arg_2_0.storyIconFrame = var_3.Find(var_2_17, "frame/storyIcon")

	local var_2_18 = arg_2_0._tf

	arg_2_0.storyIcon = var_3.Find(var_2_18, "frame/storyIcon/icon")
	arg_2_0._modelWidth = arg_2_0.frame.rect.width + 100

	local var_2_19 = arg_2_0._tf

	arg_2_0.finishBg = var_3.Find(var_2_19, "frame/finish_bg")

	local var_2_20 = arg_2_0._tf

	arg_2_0.unfinishBg = var_3.Find(var_2_20, "frame/unfinish_bg")

	local var_2_21 = arg_2_0._tf

	arg_2_0.tip = var_3.Find(var_2_21, "frame/tip")
	GetOrAddComponent = var_3
	arg_2_0.cg = var_3(arg_2_0._tf, "CanvasGroup")
	arg_2_0.height = arg_2_0._tf.rect.height

	local var_2_22 = arg_2_0._tf

	arg_2_0.urTag = var_3.Find(var_2_22, "frame/urTag")

	local var_2_23 = arg_2_0._tf

	arg_2_0.lockBg = var_3.Find(var_2_23, "lock_bg")

	local var_2_24 = arg_2_0.lockBg
	local var_2_25 = var_3.Find(var_2_24, "btn/Text")
	local var_2_26 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_2_0.lockTxt = var_2_26(var_2_25, var_6(var_1_10008))
	Vector2 = var_3
	arg_2_0.sIconOldPosition = var_3(0, 20)
	arg_2_0.framePos = arg_2_0.frame.localPosition

	return
end

function var_0_0.update(arg_3_0, arg_3_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_3_0 = arg_3_1

	Task = var_1_10007

	var_1_10002(var_1_10004(var_3_0, var_1_10007), "should be an instance of Task")

	arg_3_0.taskVO = arg_3_1

	if arg_3_1.id == 10302 then
		arg_3_0._go.name = arg_3_1.id
	end

	arg_3_0.descTxt.text = arg_3_1:getConfig("desc")

	local var_3_1 = arg_3_0.tagTF

	GetSpriteFromAtlas = var_3
	var_3_1.sprite = var_3("ui/TaskUI_atlas", var_0_0.Type2Tag(arg_3_1:GetRealType()))

	local var_3_2 = arg_3_1:getConfig("target_num")

	arg_3_0:updateAwards(arg_3_1:getConfig("award_display"))

	local var_3_3 = arg_3_1
	local var_3_4 = arg_3_1.getProgress(var_3_3)

	if arg_3_1:isFinish() then
		arg_3_0.progressNum.text = "COMPLETE"
	elseif arg_3_1:getConfig("sub_type") == 1012 then
		local var_3_5 = arg_3_0.progressNum

		math = var_3_3

		local var_3_6 = var_3_3.floor(var_3_4 / 100)
		local var_3_7 = "/"

		math = var_7
		var_3_5.text = var_3_6 .. var_3_7 .. var_7.floor(var_3_2 / 100)
	else
		arg_3_0.progressNum.text = var_3_4 .. "/" .. var_3_2
	end

	arg_3_0.progressBar.value = var_3_4 / var_3_2

	arg_3_0:updateBtnState(arg_3_1)

	local var_3_8 = arg_3_1
	local var_3_9 = arg_3_1.getConfig(var_3_8, "story_id")
	local var_3_10 = arg_3_1
	local var_3_11 = arg_3_1.IsUrTask(var_3_10)

	setActive = var_3_8

	var_3_8(arg_3_0.urTag, var_3_11)

	setActive = var_3_8

	var_3_8(arg_3_0.storyIconFrame, var_3_9 and var_3_9 ~= "" and not var_3_11)

	if var_3_9 and var_3_9 ~= "" then
		if not arg_3_1:getConfig("story_icon") or var_3_8 == "" then
			var_3_8 = "task_icon_default"
		end

		LoadSpriteAsync = var_3_10

		var_3_10("shipmodels/" .. var_3_8, function(arg_4_0)
			if arg_4_0 then
				setImageSprite = var_2_10001

				var_2_10001(arg_3_0.storyIcon, arg_4_0, true)

				local var_4_0 = arg_3_0

				var_1.UpdateStoryIconPosition(var_4_0, arg_3_1)
			end

			return
		end)

		onButton = var_3_10

		local var_3_12 = arg_3_0
		local var_3_13 = arg_3_0.storyIconFrame

		local function var_3_14()
			pg = var_2_10000

			local var_5_0 = var_2_10000.NewStoryMgr.GetInstance()

			var_0.Play(var_5_0, var_3_9, nil, true)

			return
		end

		SFX_PANEL = var_1_10012

		var_3_10(var_3_12, var_3_13, var_3_14, var_1_10012)
	else
		removeOnButton = var_3_8

		var_3_8(arg_3_0.storyIconFrame)
	end

	local var_3_15 = arg_3_0.cg

	var_3_15.alpha = 1
	setActive = var_3_15

	var_3_15(arg_3_0.frame, true)

	setActive = var_3_15

	var_3_15(arg_3_0._go, true)

	arg_3_0.frame.transform.localPosition = arg_3_0.framePos

	return
end

function var_0_0.UpdateStoryIconPosition(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getConfig("story_icon_shift")

	type = var_1_10003

	if var_1_10003(var_6_0) == "table" and #var_6_0 >= 2 then
		local var_6_1 = var_6_0[1]
		local var_6_2 = var_6_0[2]
		local var_6_3 = arg_6_0.sIconOldPosition

		setAnchoredPosition = var_1_10006

		var_1_10006(arg_6_0.storyIcon, {
			x = var_6_3.x + var_6_1,
			y = var_6_3.y + var_6_2
		})
	else
		local var_6_4 = 0
		local var_6_5 = 0
		local var_6_6 = arg_6_0.sIconOldPosition

		setAnchoredPosition = var_1_10006

		var_1_10006(arg_6_0.storyIcon, {
			x = var_6_6.x + var_6_4,
			y = var_6_6.y + var_6_5
		})
	end

	return
end

function var_0_0.updateBtnState(arg_7_0, arg_7_1)
	local var_7_0 = var_0_1

	removeOnButton = var_1_10003

	var_1_10003(arg_7_0.GotoBtn)

	removeOnButton = var_1_10003

	var_1_10003(arg_7_0.GetBtn)

	if arg_7_1:isLock() then
		var_7_0 = var_0_5
	elseif arg_7_1:isFinish() then
		var_7_0 = arg_7_1:isReceive() and var_0_4 or var_0_3
		onButton = var_3

		local var_7_1 = arg_7_0
		local var_7_2 = arg_7_0.GetBtn

		local function var_7_3()
			local function var_8_0()
				if not arg_7_0.isClick then
					arg_7_0.isClick = true

					local var_9_0 = arg_7_0

					var_0.DoSubmitAnim(var_9_0, function()
						arg_7_0.isClick = nil

						local var_10_0 = arg_7_0

						var_0.Submit(var_10_0, arg_7_1)

						return
					end)
				end

				return
			end

			local var_8_1

			local function var_8_2()
				local var_11_0 = arg_7_1
				local var_11_1 = var_0.getConfig(var_11_0, "sub_type")

				TASK_SUB_TYPE_GIVE_ITEM = var_3_10001

				if var_11_1 ~= var_3_10001 then
					var_11_0 = arg_7_1
					var_11_1 = var_11_1.getConfig(var_11_0, "sub_type")
					TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM = var_3_10001

					if var_11_1 ~= var_3_10001 then
						var_11_0 = arg_7_1
						var_11_1 = var_11_1.getConfig(var_11_0, "sub_type")
						TASK_SUB_TYPE_PLAYER_RES = var_3_10001

						local var_11_2

						if var_11_1 == var_3_10001 then
							DROP_TYPE_ITEM = var_11_1
							var_11_2 = arg_7_1

							local var_11_3 = var_1.getConfig(var_11_2, "sub_type")

							TASK_SUB_TYPE_PLAYER_RES = var_11_0

							if var_11_3 == var_11_0 then
								DROP_TYPE_RESOURCE = var_11_1
							end

							local var_11_4 = {
								type = var_11_1
							}

							tonumber = var_11_0

							local var_11_5 = arg_7_1

							var_11_4.id = var_11_0(var_4.getConfig(var_11_5, "target_id"))

							local var_11_6 = arg_7_1

							var_11_4.count = var_2.getConfig(var_11_6, "target_num")

							local var_11_7 = {}

							MSGBOX_TYPE_ITEM_BOX = var_11_2
							var_11_7.type = var_11_2
							i18n = var_11_2
							var_11_7.content = var_11_2("sub_item_warning")
							var_11_7.items = {
								var_11_4
							}

							function var_11_7.onYes()
								var_8_1()

								return
							end

							pg = var_11_2

							local var_11_8 = var_11_2.MsgboxMgr.GetInstance()

							var_11_2.ShowMsgBox(var_11_8, var_11_7)

							coroutine = var_11_2

							var_11_2.yield()
						end

						local var_11_9 = arg_7_1
						local var_11_10, var_11_11 = var_0.judgeOverflow(var_11_9)

						if var_11_10 then
							local var_11_12 = {}

							MSGBOX_TYPE_ITEM_BOX = var_11_2
							var_11_12.type = var_11_2
							i18n = var_11_2
							var_11_12.content = var_11_2("award_max_warning")
							var_11_12.items = var_11_11

							function var_11_12.onYes()
								var_8_1()

								return
							end

							pg = var_3

							local var_11_13 = var_3.MsgboxMgr.GetInstance()

							var_3.ShowMsgBox(var_11_13, var_11_12)

							coroutine = var_3

							var_3.yield()
						end

						var_8_0()

						return
					end
				end
			end

			coroutine = var_2_10003

			var_2_10003.wrap(var_8_2)()

			return
		end

		SFX_PANEL = var_1_10008

		var_3(var_7_1, var_7_2, var_7_3, var_1_10008)
	else
		var_7_0 = var_0_2
		onButton = var_3

		local var_7_4 = arg_7_0
		local var_7_5 = arg_7_0.GotoBtn

		local function var_7_6()
			local var_14_0 = arg_7_0

			var_0.Skip(var_14_0, arg_7_1)

			return
		end

		SFX_PANEL = var_1_10008

		var_3(var_7_4, var_7_5, var_7_6, var_1_10008)
	end

	SetActive = var_3

	var_3(arg_7_0.GotoBtn, var_7_0 == var_0_2)

	SetActive = var_3

	var_3(arg_7_0.GetBtn, var_7_0 == var_0_3)

	setActive = var_3

	var_3(arg_7_0.finishBg, var_7_0 == var_0_3 or var_7_0 == var_0_4)

	setActive = var_3

	var_3(arg_7_0.unfinishBg, var_7_0 ~= var_0_3 and var_7_0 ~= var_0_4)

	setActive = var_3

	var_3(arg_7_0.tip, var_7_0 == var_0_3 or var_7_0 == var_0_4)

	setActive = var_3

	var_3(arg_7_0.lockBg, var_7_0 == var_0_5)

	setGray = var_3

	var_3(arg_7_0.frame, var_7_0 == var_0_5, true)

	if var_7_0 == var_0_5 then
		local var_7_7 = arg_7_0.lockTxt

		i18n = var_1_10004
		var_7_7.text = var_1_10004("task_lock", arg_7_1:getConfig("level"))
	end

	return
end

function var_0_0.Submit(arg_15_0, arg_15_1)
	if arg_15_1.isWeekTask then
		local var_15_0 = arg_15_0.viewComponent

		var_2.onSubmitForWeek(var_15_0, arg_15_1)
	elseif arg_15_1:isAvatarTask() then
		local var_15_1 = arg_15_0.viewComponent

		var_2.onSubmitForAvatar(var_15_1, arg_15_1)
	else
		local var_15_2 = arg_15_0.viewComponent

		var_2.onSubmit(var_15_2, arg_15_1)
	end

	return
end

function var_0_0.Skip(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.viewComponent

	var_2.onGo(var_16_0, arg_16_1)

	return
end

function var_0_0.updateAwards(arg_17_0, arg_17_1)
	_ = var_1_10002

	local var_17_0 = var_1_10002.slice(arg_17_1, 1, 3)

	for iter_17_0 = arg_17_0.rewardPanel.childCount, #var_17_0 - 1 do
		cloneTplTo = var_1_10008

		var_1_10008(arg_17_0._rewardModel, arg_17_0.rewardPanel)
	end

	local var_17_1 = arg_17_0.rewardPanel.childCount

	for iter_17_1 = 1, var_17_1 do
		local var_17_2 = arg_17_0.rewardPanel
		local var_17_3 = var_8.GetChild(var_17_2, iter_17_1 - 1)
		local var_17_4 = iter_17_1 <= #var_17_0

		setActive = var_17_2

		var_17_2(var_17_3, var_17_4)

		if var_17_4 then
			local var_17_5 = var_17_0[iter_17_1]
			local var_17_6 = {
				type = var_17_5[1],
				id = var_17_5[2],
				count = var_17_5[3]
			}

			updateDrop = var_12

			var_12(var_17_3, var_17_6)

			setActive = var_12
			findTF = var_14

			local var_17_7 = var_14(var_17_3, "got")

			Task = var_15

			var_12(var_17_7, var_15.OwnSpAward(var_17_5))

			onButton = var_12

			local var_17_8 = arg_17_0
			local var_17_9 = var_17_3

			local function var_17_10()
				local var_18_0 = arg_17_0.viewComponent
				local var_18_1 = var_0.emit

				TaskMediator = var_2_10003

				var_18_1(var_18_0, var_2_10003.ON_DROP, var_17_6)

				return
			end

			SFX_PANEL = var_17

			var_12(var_17_8, var_17_9, var_17_10, var_17)
		end
	end

	return
end

function var_0_0.DoSubmitAnim(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.frame.localPosition

	LeanTween = var_1_10003

	local var_19_1 = var_1_10003.alphaCanvas(arg_19_0.cg, 0, var_0_6)

	var_3.setFrom(var_19_1, 1)

	LeanTween = var_3

	local var_19_2 = var_3.value

	go = var_19_1

	local var_19_3 = var_19_2(var_19_1(arg_19_0.frame), var_19_0.x, var_19_0.x + arg_19_0._modelWidth, var_0_6)
	local var_19_4 = var_3.setOnUpdate

	System = var_6

	local var_19_5 = var_19_4(var_19_3, var_6.Action_float(function(arg_20_0)
		local var_20_0 = arg_19_0.frame.transform

		Vector3 = var_2_10002
		var_20_0.localPosition = var_2_10002(arg_20_0, var_19_0.y, var_19_0.z)

		return
	end))
	local var_19_6 = var_3.setOnComplete

	System = var_6

	var_19_6(var_19_5, var_6.Action(function()
		local var_21_0 = arg_19_0.frame.transform

		var_21_0.localPosition = var_19_0
		setActive = var_21_0

		var_21_0(arg_19_0.frame, false)
		arg_19_1()

		return
	end))

	return
end

function var_0_0.dispose(arg_22_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_22_0)

	return
end

return var_0_0
