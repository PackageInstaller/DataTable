class = var_0_10000

local var_0_0 = "TownSkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "TownSkinPageUI"
end

function var_0_1.init(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)

	arg_2_0.activity = var_1.getActivityById(var_2_0, 5535)

	local var_2_1 = arg_2_0.activity

	arg_2_0.story = var_1.getConfig(var_2_1, "config_client").story
	arg_2_0.storyStateDic = {}

	arg_2_0:ShowMask(false)

	arg_2_0.isPlaying = false

	arg_2_0:InitStoryState()
	arg_2_0:UpdateStoryView()
	arg_2_0:UpdateItemView(arg_2_0.activity)

	return
end

function var_0_1.InitStoryState(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0.story) do
		checkExist = var_1_10006

		if var_1_10006(arg_3_0.story, {
			iter_3_0
		}, {
			1
		}) then
			var_1_10006 = false

			local var_3_0 = iter_3_1[1]

			pg = var_8

			local var_3_1 = var_8.NewStoryMgr.GetInstance()

			if var_8.IsPlayed(var_3_1, var_3_0) then
				var_1_10006 = true
			end

			pg = var_8

			local var_3_2 = var_8.NewStoryMgr.GetInstance()
			local var_3_3 = var_8.StoryName2StoryId(var_3_2, var_3_0)

			arg_3_0.storyStateDic[var_3_3] = var_1_10006
		end
	end

	return
end

function var_0_1.UpdateStoryView(arg_4_0)
	local var_4_0 = {
		"pittsburgh",
		"indiana",
		"fargo",
		"kersaint",
		"friedrich",
		"painleve"
	}

	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(var_4_0) do
		local var_4_1 = arg_4_0.story[iter_4_0][1]

		pg = var_1_10008

		local var_4_2 = var_1_10008.NewStoryMgr.GetInstance()

		var_1_10008 = var_1_10008.StoryName2StoryId(var_4_2, var_4_1)

		local var_4_3 = arg_4_0.storyStateDic[var_1_10008]
		local var_4_4 = arg_4_0._tf
		local var_4_5 = var_10.Find(var_4_4, "frame/bg/" .. iter_4_1 .. "/locked")
		local var_4_6 = arg_4_0._tf
		local var_4_7 = var_11.Find(var_4_6, "frame/bg/" .. iter_4_1 .. "/unlocked")

		setActive = var_4_6

		var_4_6(var_4_5, not var_4_3)

		setActive = var_4_6

		var_4_6(var_4_7, var_4_3)

		if var_4_3 then
			onButton = var_4_6

			var_4_6(arg_4_0, var_4_7, function()
				pg = var_2_10000

				local var_5_0 = var_2_10000.NewStoryMgr.GetInstance()
				local var_5_1 = var_0.Play

				pg = var_2_10002

				local var_5_2 = var_2_10002.NewStoryMgr.GetInstance()

				var_5_1(var_5_0, var_2.StoryId2StoryName(var_5_2, var_1_10008), nil, true)

				return
			end)
		else
			onButton = var_4_6

			var_4_6(arg_4_0, var_4_5, function()
				getProxy = var_2_10000
				ActivityProxy = var_2_10001

				local var_6_0 = var_2_10000(var_2_10001)
				local var_6_2

				if var_0.getActivityById(var_6_0, 5535).data1 <= 0 then
					pg = var_6_2

					local var_6_1 = var_6_2.TipsMgr.GetInstance()

					var_6_2 = var_6_2.ShowTips
					i18n = var_2_10003

					var_6_2(var_6_1, var_2_10003("activity_0815_town_memory"))

					return
				end

				pg = var_6_2

				local var_6_3 = var_6_2.m02
				local var_6_4 = var_1.sendNotification

				GAME = var_2_10003

				var_6_4(var_6_3, var_2_10003.ACTIVITY_UNLOCKSTORY, {
					cmd = 1,
					activity_id = arg_4_0.activity.id,
					arg1 = var_1_10008
				})

				return
			end)
		end
	end

	return
end

function var_0_1.UpdateItemView(arg_7_0, arg_7_1)
	setText = var_1_10002

	local var_7_0 = arg_7_0._tf
	local var_7_1 = var_3.Find(var_7_0, "frame/des/count")

	tostring = var_7_0

	var_1_10002(var_7_1, var_7_0(arg_7_1.data1))

	return
end

function var_0_1.UpdataStoryState(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.storyId

	arg_8_0.storyStateDic[var_8_0] = true

	local var_8_1 = 0

	ipairs = var_4

	for iter_8_0, iter_8_1 in var_4(arg_8_0.story) do
		local var_8_2 = iter_8_1[1]

		pg = var_1_10010

		local var_8_3 = var_1_10010.NewStoryMgr.GetInstance()

		if var_1_10010.StoryName2StoryId(var_8_3, var_8_2) == var_8_0 then
			var_8_1 = iter_8_0
		end
	end

	local var_8_4 = {
		"pittsburgh",
		"indiana",
		"fargo",
		"kersaint",
		"friedrich",
		"painleve"
	}

	ipairs = var_5

	for iter_8_2, iter_8_3 in var_5(var_8_4) do
		if iter_8_2 == var_8_1 then
			local var_8_5 = arg_8_0.storyStateDic[var_8_0]
			local var_8_6 = arg_8_0._tf
			local var_8_7 = var_11.Find(var_8_6, "frame/bg/" .. iter_8_3 .. "/locked")
			local var_8_8 = arg_8_0._tf
			local var_8_9 = var_12.Find(var_8_8, "frame/bg/" .. iter_8_3 .. "/unlocked")
			local var_8_10 = var_8_7
			local var_8_11 = var_8_7.GetComponent

			typeof = var_15
			Animation = var_16

			local var_8_12 = var_8_11(var_8_10, var_15(var_16))
			local var_8_13 = var_13.GetClip(var_8_12, "anim_cowboy_skin_fargo_unlock").length

			var_13:Play("anim_cowboy_skin_fargo_unlock")
			arg_8_0:ShowMask(true)

			arg_8_0.isPlaying = true
			onDelayTick = var_15

			var_15(function()
				arg_8_0.isPlaying = false

				local var_9_0 = arg_8_0

				var_0.ShowMask(var_9_0, false)

				setActive = var_0

				var_0(var_8_7, not var_8_5)

				setActive = var_0

				var_0(var_8_9, var_8_5)

				pg = var_0

				local var_9_1 = var_0.NewStoryMgr.GetInstance()
				local var_9_2 = var_0.Play

				pg = var_2

				local var_9_3 = var_2.NewStoryMgr.GetInstance()

				var_9_2(var_9_1, var_2.StoryId2StoryName(var_9_3, var_8_0))

				return
			end, var_8_13)

			if var_8_5 then
				onButton = var_15

				var_15(arg_8_0, var_8_9, function()
					pg = var_2_10000

					local var_10_0 = var_2_10000.NewStoryMgr.GetInstance()
					local var_10_1 = var_0.Play

					pg = var_2_10002

					local var_10_2 = var_2_10002.NewStoryMgr.GetInstance()

					var_10_1(var_10_0, var_2.StoryId2StoryName(var_10_2, var_8_0), nil, true)

					return
				end)
			else
				onButton = var_15

				var_15(arg_8_0, var_8_7, function()
					getProxy = var_2_10000
					ActivityProxy = var_2_10001

					local var_11_0 = var_2_10000(var_2_10001)
					local var_11_2

					if var_0.getActivityById(var_11_0, 5535).data1 <= 0 then
						pg = var_11_2

						local var_11_1 = var_11_2.TipsMgr.GetInstance()

						var_11_2 = var_11_2.ShowTips
						i18n = var_2_10003

						var_11_2(var_11_1, var_2_10003("activity_0815_town_memory"))

						return
					end

					pg = var_11_2

					local var_11_3 = var_11_2.m02
					local var_11_4 = var_1.sendNotification

					GAME = var_2_10003

					var_11_4(var_11_3, var_2_10003.ACTIVITY_UNLOCKSTORY, {
						cmd = 1,
						activity_id = arg_8_0.activity.id,
						arg1 = var_8_0
					})

					return
				end)
			end
		end
	end

	return
end

function var_0_1.didEnter(arg_12_0)
	onButton = var_1_10001

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0._tf
	local var_12_2 = var_3.Find(var_12_1, "frame/back")

	local function var_12_3()
		local var_13_0 = arg_12_0

		var_0.onBackPressed(var_13_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_12_0, var_12_2, var_12_3, var_5)

	onButton = var_1_10001

	local var_12_4 = arg_12_0
	local var_12_5 = arg_12_0._tf
	local var_12_6 = var_3.Find(var_12_5, "bg")

	local function var_12_7()
		local var_14_0 = arg_12_0

		var_0.onBackPressed(var_14_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_12_4, var_12_6, var_12_7, var_5)

	onButton = var_1_10001

	local var_12_8 = arg_12_0
	local var_12_9 = arg_12_0._tf

	var_1_10001(var_12_8, var_3.Find(var_12_9, "frame/des/itemDes"), function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_15_0 = var_2_10000(var_2_10001)
		local var_15_1 = var_0.getActivityById(var_15_0, 5535).data1
		local var_15_2 = {}

		DROP_TYPE_VITEM = var_2
		var_15_2.type = var_2

		local var_15_3 = arg_12_0.activity

		var_15_2.id = var_2.getConfig(var_15_3, "config_id")
		var_15_2.count = var_15_1

		local var_15_4 = arg_12_0
		local var_15_5 = var_2.emit

		BaseUI = var_4

		var_15_5(var_15_4, var_4.ON_DROP, var_15_2)

		return
	end)

	pg = var_1_10001

	local var_12_10 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_12_10, arg_12_0._tf)

	return
end

function var_0_1.ShowMask(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._tf
	local var_16_1

	var_16_1, GetOrAddComponent = var_2.Find(var_16_0, "mask"), var_16_0
	typeof = var_1_10005
	CanvasGroup = var_1_10006
	var_16_0(var_16_1, var_1_10005(var_1_10006)).blocksRaycasts = arg_16_1

	return
end

function var_0_1.willExit(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_17_0, arg_17_0._tf)

	return
end

function var_0_1.onBackPressed(arg_18_0)
	if arg_18_0.isPlaying then
		return
	end

	arg_18_0.super.onBackPressed(arg_18_0)

	return
end

return var_0_1
