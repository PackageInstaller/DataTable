class = var_0_10000

local var_0_0 = var_0_10000("FeastTaskCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.binder = arg_1_2
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.Find(var_1_0, "name/Text")
	local var_1_2 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.nameTxt = var_1_2(var_1_1, var_6(var_1_10008))

	local var_1_3 = arg_1_0._tf
	local var_1_4 = var_3.Find(var_1_3, "desc")
	local var_1_5 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.descTxt = var_1_5(var_1_4, var_6(var_1_10008))

	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_3.Find(var_1_6, "Text")
	local var_1_8 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.progressTxt = var_1_8(var_1_7, var_6(var_1_10008))

	local var_1_9 = arg_1_0._tf

	arg_1_0.progress = var_3.Find(var_1_9, "progress/bar")
	UIItemList = var_3

	local var_1_10 = var_3.New
	local var_1_11 = arg_1_0._tf
	local var_1_12 = var_5.Find(var_1_11, "awards")
	local var_1_13 = arg_1_0._tf

	arg_1_0.uilist = var_1_10(var_1_12, var_6.Find(var_1_13, "awards/award"))

	local var_1_14 = arg_1_0._tf

	arg_1_0.getBtn = var_3.Find(var_1_14, "btns/get")

	local var_1_15 = arg_1_0._tf

	arg_1_0.gotBtn = var_3.Find(var_1_15, "btns/got")

	local var_1_16 = arg_1_0._tf

	arg_1_0.goBtn = var_3.Find(var_1_16, "btns/go")

	local var_1_17 = {}

	GetSpriteFromAtlas = var_1_10004
	var_1_17[1] = var_1_10004("ui/feasttask_atlas", "t_frame_1")
	GetSpriteFromAtlas = var_4
	var_1_17[2] = var_4("ui/feasttask_atlas", "t_frame_2")
	arg_1_0.sprites = var_1_17

	local var_1_18 = {}

	GetSpriteFromAtlas = var_4
	var_1_18[1] = var_4("ui/feasttask_atlas", "t_progress_1")
	GetSpriteFromAtlas = var_4
	var_1_18[2] = var_4("ui/feasttask_atlas", "t_progress_2")
	arg_1_0.barSprites = var_1_18

	local var_1_19 = {}

	i18n = var_4
	var_1_19[1] = var_4("feast_task_tag_daily")
	i18n = var_4
	var_1_19[2] = var_4("feast_task_tag_activity")
	arg_1_0.tags = var_1_19

	local var_1_20 = arg_1_0._tf
	local var_1_21 = var_3.Find(var_1_20, "progress/bar")
	local var_1_22 = var_3.GetComponent

	typeof = var_6
	Image = var_1_13
	arg_1_0.barImg = var_1_22(var_1_21, var_6(var_1_13))

	local var_1_23 = arg_1_0._tf
	local var_1_24 = var_3.GetComponent

	typeof = var_6
	Image = var_1_13
	arg_1_0.bgImg = var_1_24(var_1_23, var_6(var_1_13))

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	TaskProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)
	local var_2_1

	if not var_2.getTaskById(var_2_0, arg_2_1) then
		var_2_1 = var_2:getFinishTaskById(arg_2_1)
	end

	local var_2_2 = var_2_1:IsActRoutineType() and 1 or 2

	arg_2_0.nameTxt.text = arg_2_0.tags[var_2_2] .. var_2_1:getConfig("name")
	arg_2_0.descTxt.text = var_2_1:getConfig("desc")
	arg_2_0.bgImg.sprite = arg_2_0.sprites[var_2_2]
	arg_2_0.barImg.sprite = arg_2_0.barSprites[var_2_2]

	local var_2_3 = var_2_1:getProgress()
	local var_2_4 = var_2_1:getConfig("target_num")
	local var_2_5 = arg_2_0.progressTxt

	var_2_5.text = var_2_3 .. "/" .. var_2_4
	setFillAmount = var_2_5

	var_2_5(arg_2_0.progress, var_2_3 / var_2_4)

	local var_2_6 = var_2_1:getConfig("award_display")
	local var_2_7 = arg_2_0.uilist

	var_8.make(var_2_7, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = var_2_6[arg_3_1 + 1]
			local var_3_1 = {
				type = var_3_0[1],
				id = var_3_0[2],
				count = var_3_0[3]
			}

			updateDrop = var_5

			var_5(arg_3_2, var_3_1)

			onButton = var_5

			local var_3_2 = arg_2_0.binder
			local var_3_3 = arg_3_2

			local function var_3_4()
				local var_4_0 = arg_2_0.binder
				local var_4_1 = var_0.emit

				BaseUI = var_3_10003

				var_4_1(var_4_0, var_3_10003.ON_DROP, var_3_1)

				return
			end

			SFX_PANEL = var_2_10010

			var_5(var_3_2, var_3_3, var_3_4, var_2_10010)
		end

		return
	end)

	local var_2_8 = arg_2_0.uilist

	var_8.align(var_2_8, #var_2_6)

	local var_2_9 = var_2_1
	local var_2_10 = var_2_1.isFinish(var_2_9)
	local var_2_11 = var_2_1:isReceive()

	setActive = var_2_9

	var_2_9(arg_2_0.getBtn, var_2_10 and not var_2_11)

	setActive = var_2_9

	var_2_9(arg_2_0.gotBtn, var_2_10 and var_2_11)

	setActive = var_2_9

	var_2_9(arg_2_0.goBtn, not var_2_10)

	onButton = var_2_9

	local var_2_12 = arg_2_0.binder
	local var_2_13 = arg_2_0.getBtn

	local function var_2_14()
		local var_5_0 = arg_2_0.binder
		local var_5_1 = var_0.emit

		FeastMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.ON_SUBMIT, arg_2_1)

		return
	end

	SFX_PANEL = var_1_10015

	var_2_9(var_2_12, var_2_13, var_2_14, var_1_10015)

	onButton = var_2_9

	local var_2_15 = arg_2_0.binder
	local var_2_16 = arg_2_0.goBtn

	local function var_2_17()
		local var_6_0 = arg_2_0.binder
		local var_6_1 = var_0.emit

		FeastMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.ON_GO, var_2_1)

		return
	end

	SFX_PANEL = var_1_10015

	var_2_9(var_2_15, var_2_16, var_2_17, var_1_10015)

	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.sprites = nil
	arg_7_0.barSprites = nil

	return
end

return var_0_0
