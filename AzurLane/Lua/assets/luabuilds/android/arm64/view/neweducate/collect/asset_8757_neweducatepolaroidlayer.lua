class = var_0_10000

local var_0_0 = "NewEducatePolaroidLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewEducateCollectLayerTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducatePolaroidUI"
end

function var_0_1.initConfig(arg_2_0)
	pg = var_1_10001
	arg_2_0.config = var_1_10001.child2_polaroid

	local var_2_0 = arg_2_0.contextData.permanentData

	arg_2_0.allIds = var_1.GetAllPolaroidGroups(var_2_0)

	local var_2_1 = arg_2_0.contextData.permanentData

	arg_2_0.unlockIds = var_1.GetUnlockPolaroidGroups(var_2_1)

	local var_2_2 = arg_2_0.contextData.permanentData

	arg_2_0.polaroidGroup2Ids = var_1.GetPolaroidGroup2Ids(var_2_2)

	local var_2_3 = arg_2_0.contextData.permanentData

	arg_2_0.polaroids = var_1.GetPolaroids(var_2_3)

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:InitPageInfo()

	setText = var_1

	var_1(arg_3_0.curCntTF, #arg_3_0.unlockIds)

	setText = var_1

	var_1(arg_3_0.allCntTF, "/" .. #arg_3_0.allIds)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.performTF

	local function var_3_2()
		setActive = var_2_10000

		var_2_10000(arg_3_0.performTF, false)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)
	arg_3_0:InitShowList()
	arg_3_0:UpdatePage()

	return
end

function var_0_1.InitShowList(arg_5_0)
	arg_5_0.showIds = {}
	arg_5_0.selectedIndex = 1

	local var_5_0 = arg_5_0.performTF

	arg_5_0.groupsTF = var_1.Find(var_5_0, "bg/groups")
	UIItemList = var_1

	local var_5_1 = var_1.New
	local var_5_2 = arg_5_0.groupsTF
	local var_5_3 = arg_5_0.groupsTF

	arg_5_0.showList = var_5_1(var_5_2, var_4.Find(var_5_3, "tpl"))

	local var_5_4 = arg_5_0.showList

	var_1.make(var_5_4, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_5_0.showIds[arg_6_1 + 1]
			local var_6_1 = arg_5_0
			local var_6_2 = var_4.IsUnlock(var_6_1, var_6_0)

			setText = var_2_10005

			var_2_10005(arg_6_2:Find("unlock/unselected/Text"), var_6_0)

			setText = var_2_10005

			var_2_10005(arg_6_2:Find("unlock/selected/Text"), var_6_0)

			setActive = var_2_10005

			var_2_10005(arg_6_2:Find("lock"), not var_6_2)

			setActive = var_2_10005

			var_2_10005(arg_6_2:Find("unlock"), var_6_2)

			setActive = var_2_10005

			var_2_10005(arg_6_2:Find("unlock/selected"), arg_5_0.selectedIndex == arg_6_1 + 1)

			setActive = var_2_10005

			var_2_10005(arg_6_2:Find("unlock/unselected"), arg_5_0.selectedIndex ~= arg_6_1 + 1)

			onButton = var_2_10005

			var_2_10005(arg_5_0, arg_6_2, function(arg_7_0)
				local var_7_0

				if var_6_2 then
					var_7_0 = arg_5_0
					var_7_0.selectedIndex = arg_6_1 + 1

					local var_7_1 = arg_5_0

					var_7_0.UpdatePerform(var_7_1, var_6_0)

					local var_7_2 = arg_5_0.showList

					var_7_0.align(var_7_2, #arg_5_0.showIds)
				else
					pg = var_7_0

					local var_7_3 = var_7_0.TipsMgr.GetInstance()
					local var_7_4 = var_1.ShowTips

					i18n = var_3_10004

					var_7_4(var_7_3, var_3_10004("child_polaroid_lock_tip"))
				end

				return
			end)
		end

		return
	end)

	return
end

function var_0_1.IsUnlock(arg_8_0, arg_8_1)
	return true
end

function var_0_1.UpdateItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.polaroidGroup2Ids[arg_9_1]

	table = var_1_10004

	local var_9_1 = var_1_10004.sort
	local var_9_2 = var_9_0

	CompareFuncs = var_1_10007

	var_9_1(var_9_2, var_1_10007({
		function(arg_10_0)
			table = var_2_10001

			return var_2_10001.contains(arg_9_0.polaroids, arg_10_0) and 0 or 1
		end,
		function(arg_11_0)
			return arg_11_0
		end
	}))

	local var_9_3 = arg_9_0.config[var_9_0[1]]

	table = var_5

	local var_9_4 = var_5.contains(arg_9_0.unlockIds, arg_9_1)

	setActive = var_9_2

	var_9_2(arg_9_2:Find("lock"), not var_9_4)

	setActive = var_9_2

	var_9_2(arg_9_2:Find("unlock"), var_9_4)

	if var_9_4 then
		LoadImageSpriteAsync = var_9_2

		var_9_2("neweducateicon/" .. var_9_3.pic, arg_9_2:Find("unlock/mask/Image"), true)

		setText = var_9_2

		var_9_2(arg_9_2:Find("unlock/name"), var_9_3.title)

		onButton = var_9_2

		local var_9_5 = arg_9_0
		local var_9_6 = arg_9_2

		local function var_9_7()
			local var_12_0 = arg_9_0

			var_0.ShowPerformWindow(var_12_0, var_9_0)

			return
		end

		SFX_PANEL = var_11

		var_9_2(var_9_5, var_9_6, var_9_7, var_11)
	else
		removeOnButton = var_9_2

		var_9_2(arg_9_2)

		setText = var_9_2

		var_9_2(arg_9_2:Find("lock/Text"), var_9_3.condition)
	end

	return
end

function var_0_1.ShowPerformWindow(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.showIds = arg_13_1

	local var_13_0 = arg_13_0.showList

	var_3.align(var_13_0, #arg_13_0.showIds)

	triggerButton = var_3

	local var_13_1 = arg_13_0.groupsTF

	var_3(var_5.GetChild(var_13_1, 0))

	setActive = var_3

	var_3(arg_13_0.performTF, true)

	return
end

function var_0_1.UpdatePerform(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.config[arg_14_1]

	LoadImageSpriteAsync = var_1_10003

	local var_14_1 = "neweducateicon/" .. var_14_0.pic_2
	local var_14_2 = arg_14_0.performTF

	var_1_10003(var_14_1, var_6.Find(var_14_2, "bg/mask/Image"), true)

	setText = var_1_10003

	local var_14_3 = arg_14_0.performTF

	var_1_10003(var_5.Find(var_14_3, "bg/Text"), var_14_0.title)

	return
end

function var_0_1.PlayAnimChange(arg_15_0)
	local var_15_0 = arg_15_0.anim

	var_1.Stop(var_15_0)

	local var_15_1 = arg_15_0.anim

	var_1.Play(var_15_1, "anim_educate_Polaroid_change")

	return
end

function var_0_1.PlayAnimClose(arg_16_0)
	local var_16_0 = arg_16_0.anim

	var_1.Play(var_16_0, "anim_educate_Polaroid_out")

	return
end

return var_0_1
