class = var_0_10000

local var_0_0 = "NewEducateMemoryLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewEducateCollectLayerTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateMemoryUI"
end

function var_0_1.initConfig(arg_2_0)
	pg = var_1_10001
	arg_2_0.config = var_1_10001.child2_memory

	local var_2_0 = arg_2_0.contextData.permanentData

	arg_2_0.allIds = var_1.GetAllMemoryIds(var_2_0)

	local var_2_1 = arg_2_0.contextData.permanentData

	arg_2_0.unlockIds = var_1.GetUnlockMemoryIds(var_2_1)

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:InitPageInfo()

	setText = var_1

	local var_3_0 = arg_3_0.performTF
	local var_3_1 = var_3.Find(var_3_0, "review_btn/Text")

	i18n = var_1_10004

	var_1(var_3_1, var_1_10004("child_btn_review"))

	setText = var_1

	var_1(arg_3_0.curCntTF, #arg_3_0.unlockIds)

	setText = var_1

	var_1(arg_3_0.allCntTF, "/" .. #arg_3_0.allIds)
	arg_3_0:UpdatePage()

	return
end

function var_0_1.UpdateItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.config[arg_4_1]

	table = var_1_10004

	local var_4_1 = var_1_10004.contains(arg_4_0.unlockIds, var_4_0.id)

	setActive = var_1_10005

	var_1_10005(arg_4_2:Find("lock"), not var_4_1)

	setActive = var_1_10005

	var_1_10005(arg_4_2:Find("unlock"), var_4_1)

	setActive = var_1_10005

	var_1_10005(arg_4_2:Find("unlock/new"), false)

	local var_4_3

	if var_4_1 then
		LoadImageSpriteAsync = var_1_10005

		var_1_10005("bg/" .. var_4_0.pic, arg_4_2:Find("unlock/mask/Image"))

		setText = var_1_10005

		var_1_10005(arg_4_2:Find("unlock/name"), var_4_0.desc)

		onButton = var_1_10005

		local var_4_2 = arg_4_0

		var_4_3 = arg_4_2

		local function var_4_4()
			local var_5_0 = arg_4_0

			var_0.ShowPerformWindow(var_5_0, var_4_0)

			return
		end

		SFX_PANEL = var_10

		var_1_10005(var_4_2, var_4_3, var_4_4, var_10)
	else
		removeOnButton = var_1_10005

		var_1_10005(arg_4_2)

		setText = var_1_10005

		local var_4_5 = arg_4_2:Find("lock/Text")

		i18n = var_4_3

		var_1_10005(var_4_5, var_4_3("child_collect_lock"))
	end

	return
end

function var_0_1.ShowPerformWindow(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.performTF
	local var_6_1 = var_2.Find(var_6_0, "Image")

	LoadImageSpriteAsync = var_1_10003

	var_1_10003("bg/" .. arg_6_1.pic, var_6_1)

	setActive = var_1_10003

	var_1_10003(arg_6_0.performTF, true)

	onButton = var_1_10003

	local var_6_2 = arg_6_0
	local var_6_3 = var_6_1

	local function var_6_4()
		setActive = var_2_10000

		var_2_10000(arg_6_0.performTF, false)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_6_2, var_6_3, var_6_4, var_1_10008)

	onButton = var_1_10003

	local var_6_5 = arg_6_0
	local var_6_6 = arg_6_0.performTF
	local var_6_7 = var_6.Find(var_6_6, "review_btn")

	local function var_6_8()
		pg = var_2_10000

		local var_8_0 = var_2_10000.NewStoryMgr.GetInstance()

		var_0.Play(var_8_0, arg_6_1.lua, nil, true)

		return
	end

	SFX_PANEL = var_6_6

	var_1_10003(var_6_5, var_6_7, var_6_8, var_6_6)

	return
end

function var_0_1.PlayAnimChange(arg_9_0)
	local var_9_0 = arg_9_0.anim

	var_1.Stop(var_9_0)

	local var_9_1 = arg_9_0.anim

	var_1.Play(var_9_1, "anim_educate_memory_change")

	return
end

function var_0_1.PlayAnimClose(arg_10_0)
	local var_10_0 = arg_10_0.anim

	var_1.Play(var_10_0, "anim_educate_memory_out")

	return
end

return var_0_1
