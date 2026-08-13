class = var_0_10000

local var_0_0 = "LivingAreaCoverPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "LivingAreaCoverUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.tpl = var_1.Find(var_2_0, "bg/tpl")
	setActive = var_1

	var_1(arg_2_0.tpl, false)

	local var_2_1 = arg_2_0._tf

	arg_2_0.frameTF = var_1.Find(var_2_1, "bg/frame")

	local var_2_2 = arg_2_0.frameTF

	arg_2_0.contentTF = var_1.Find(var_2_2, "view/content")

	local var_2_3 = arg_2_0.contentTF

	arg_2_0.unlockTF = var_1.Find(var_2_3, "unlock")
	setText = var_1

	local var_2_4 = arg_2_0.unlockTF
	local var_2_5 = var_2.Find(var_2_4, "title/Text")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("word_unlock"))

	UIItemList = var_1

	local var_2_6 = var_1.New
	local var_2_7 = arg_2_0.unlockTF

	arg_2_0.unlockUIList = var_2_6(var_2.Find(var_2_7, "list"), arg_2_0.tpl)

	local var_2_8 = arg_2_0.contentTF

	arg_2_0.lockTF = var_1.Find(var_2_8, "lock")
	setText = var_1

	local var_2_9 = arg_2_0.lockTF
	local var_2_10 = var_2.Find(var_2_9, "title/Text")

	i18n = var_2_9

	var_1(var_2_10, var_2_9("word_lock"))

	UIItemList = var_1

	local var_2_11 = var_1.New
	local var_2_12 = arg_2_0.lockTF

	arg_2_0.lockUIList = var_2_11(var_2.Find(var_2_12, "list"), arg_2_0.tpl)

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.CheckSet(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.frameTF
	local var_3_5 = var_3.Find(var_3_4, "close")

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.CheckSet(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_3, var_3_5, var_3_6, var_5)

	local var_3_7 = arg_3_0.unlockUIList

	var_1.make(var_3_7, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_3_0

			var_3.updateItem(var_6_0, arg_6_1, arg_6_2, "unlock")
		end

		return
	end)

	local var_3_8 = arg_3_0.lockUIList

	var_1.make(var_3_8, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_3_0

			var_3.updateItem(var_7_0, arg_7_1, arg_7_2, "lock")
		end

		return
	end)

	return
end

function var_0_1.updateItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_1 + 1
	local var_8_1

	if not (arg_8_3 == "unlock") or not arg_8_0.unlockList[var_8_0] then
		var_8_1 = arg_8_0.lockList[var_8_0]
	end

	LoadImageSpriteAsync = var_1_10007

	var_1_10007(var_8_1:GetIcon(), arg_8_2:Find("icon"), true)

	setText = var_1_10007

	var_1_10007(arg_8_2:Find("lock/Image/Text"), var_8_1:GetUnlockText())

	setActive = var_1_10007

	var_1_10007(arg_8_2:Find("lock"), not var_5)

	setActive = var_1_10007

	var_1_10007(arg_8_2:Find("selected"), var_5)

	onButton = var_1_10007

	local var_8_2 = arg_8_0
	local var_8_3 = arg_8_2

	local function var_8_4()
		if not var_0 then
			return
		end

		if arg_8_0.selectedIdx ~= var_8_0 then
			local var_9_0 = var_8_1

			if var_0.IsNew(var_9_0) then
				local var_9_1 = var_8_1

				var_0.ClearNew(var_9_1)

				getProxy = var_0
				LivingAreaCoverProxy = var_9_1

				local var_9_2 = var_0(var_9_1)

				var_0.UpdateCover(var_9_2, var_8_1)
			end

			arg_8_0.selectedIdx = var_8_0

			local var_9_3 = arg_8_0.unlockUIList

			var_0.align(var_9_3, #arg_8_0.unlockList)

			if arg_8_0.contextData and arg_8_0.contextData.onSelected then
				arg_8_0.contextData.onSelected(var_8_1)
			end
		end

		return
	end

	SFX_CONFIRM = var_11

	var_1_10007(var_8_2, var_8_3, var_8_4, var_11)

	setActive = var_1_10007

	var_1_10007(arg_8_2:Find("new"), var_8_1:IsNew())

	setActive = var_1_10007

	var_1_10007(arg_8_2:Find("selected"), var_5 and arg_8_0.selectedIdx == var_8_0)

	return
end

function var_0_1.Show(arg_10_0)
	var_0_1.super.Show(arg_10_0)

	getProxy = var_1
	LivingAreaCoverProxy = var_2

	local var_10_0 = var_1(var_2)

	arg_10_0.coverId = var_1.GetCoverId(var_10_0)
	arg_10_0.unlockList = var_1:GetUnlockList()
	arg_10_0.lockList = var_1:GetLockList()

	arg_10_0:Sort()

	arg_10_0.selectedIdx = 1

	local var_10_1 = arg_10_0.unlockUIList

	var_2.align(var_10_1, #arg_10_0.unlockList)

	local var_10_2 = arg_10_0.lockUIList

	var_2.align(var_10_2, #arg_10_0.lockList)

	quickPlayAnimation = var_2

	var_2(arg_10_0._tf, "anim_dorm3d_areacover_in")

	return
end

function var_0_1.Sort(arg_11_0)
	table = var_1_10001

	local var_11_0 = var_1_10001.sort
	local var_11_1 = arg_11_0.unlockList

	CompareFuncs = var_1_10003

	var_11_0(var_11_1, var_1_10003({
		function(arg_12_0)
			return arg_12_0.id == arg_11_0.coverId and 0 or 1
		end,
		function(arg_13_0)
			return arg_13_0.id
		end
	}))

	table = var_11_0

	local var_11_2 = var_11_0.sort
	local var_11_3 = arg_11_0.lockList

	CompareFuncs = var_3

	var_11_2(var_11_3, var_3({
		function(arg_14_0)
			return arg_14_0.id
		end
	}))

	return
end

function var_0_1.CheckSet(arg_15_0)
	if arg_15_0.unlockList[arg_15_0.selectedIdx].id ~= arg_15_0.coverId then
		pg = var_2

		local var_15_0 = var_2.m02
		local var_15_1 = var_2.sendNotification

		GAME = var_1_10004

		var_15_1(var_15_0, var_1_10004.CHANGE_LIVINGAREA_COVER, {
			coverId = var_1,
			callback = function()
				local var_16_0 = arg_15_0

				var_0.Hide(var_16_0)

				return
			end
		})
	else
		arg_15_0:Hide()
	end

	return
end

function var_0_1.Hide(arg_17_0)
	if arg_17_0:isShowing() and not arg_17_0.inExitAnim then
		arg_17_0.inExitAnim = nil
		quickPlayAnimation = var_1

		var_1(arg_17_0._tf, "anim_dorm3d_areacover_out")

		onDelayTick = var_1

		var_1(function()
			arg_17_0.inExitAnim = nil

			if arg_17_0.contextData and arg_17_0.contextData.onHide then
				arg_17_0.contextData.onHide()
			end

			var_0_1.super.Hide(arg_17_0)

			return
		end, 0.2)
	end

	return
end

function var_0_1.OnDestroy(arg_19_0)
	arg_19_0:Hide()

	return
end

return var_0_1
