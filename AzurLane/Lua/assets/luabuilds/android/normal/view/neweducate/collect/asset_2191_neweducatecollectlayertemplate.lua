class = var_0_10000

local var_0_0 = "NewEducateCollectLayerTemplate"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	assert = var_1_10001

	var_1_10001(nil, "getUIName方法必须由子类实现")

	return
end

function var_0_1.getGroupName(arg_2_0)
	return "NewEducateBaseUI"
end

function var_0_1.initConfig(arg_3_0)
	assert = var_1_10001

	var_1_10001(nil, "initConfig方法必须由子类实现")

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "anim_root")
	local var_4_2 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_4_0.anim = var_4_2(var_4_1, var_3(var_1_10004))

	local var_4_3 = arg_4_0._tf
	local var_4_4 = var_1.Find(var_4_3, "anim_root")
	local var_4_5 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_4_0.animEvent = var_4_5(var_4_4, var_3(var_1_10004))

	local var_4_6 = arg_4_0.animEvent

	var_1.SetEndEvent(var_4_6, function()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_4_7 = arg_4_0._tf

	arg_4_0.closeBtn = var_1.Find(var_4_7, "anim_root/bg")

	local var_4_8 = arg_4_0._tf

	arg_4_0.windowTF = var_1.Find(var_4_8, "anim_root/window")

	local var_4_9 = arg_4_0.windowTF

	arg_4_0.curCntTF = var_1.Find(var_4_9, "collect/cur")

	local var_4_10 = arg_4_0.windowTF

	arg_4_0.allCntTF = var_1.Find(var_4_10, "collect/all")

	local var_4_11 = arg_4_0.windowTF

	arg_4_0.pageTF = var_1.Find(var_4_11, "page")

	local var_4_12 = arg_4_0.windowTF

	arg_4_0.nextBtn = var_1.Find(var_4_12, "next_btn")

	local var_4_13 = arg_4_0.windowTF

	arg_4_0.lastBtn = var_1.Find(var_4_13, "last_btn")

	local var_4_14 = arg_4_0.windowTF

	arg_4_0.paginationTF = var_1.Find(var_4_14, "pagination")

	local var_4_15 = arg_4_0._tf

	arg_4_0.performTF = var_1.Find(var_4_15, "anim_root/perform")
	setActive = var_1

	var_1(arg_4_0.performTF, false)

	onButton = var_1

	local var_4_16 = arg_4_0
	local var_4_17 = arg_4_0.closeBtn

	local function var_4_18()
		local var_6_0 = arg_4_0

		var_0.PlayAnimClose(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_16, var_4_17, var_4_18, var_1_10005)

	onButton = var_1

	local var_4_19 = arg_4_0
	local var_4_20 = arg_4_0.nextBtn

	local function var_4_21()
		local var_7_0 = arg_4_0

		var_0.PlayAnimChange(var_7_0)

		arg_4_0.curPageIndex = arg_4_0.curPageIndex + 1

		local var_7_1 = arg_4_0

		var_0.UpdatePage(var_7_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_19, var_4_20, var_4_21, var_1_10005)

	onButton = var_1

	local var_4_22 = arg_4_0
	local var_4_23 = arg_4_0.lastBtn

	local function var_4_24()
		local var_8_0 = arg_4_0

		var_0.PlayAnimChange(var_8_0)

		arg_4_0.curPageIndex = arg_4_0.curPageIndex - 1

		local var_8_1 = arg_4_0

		var_0.UpdatePage(var_8_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_22, var_4_23, var_4_24, var_1_10005)
	arg_4_0:OverlayPanel(arg_4_0._tf, {
		groupDelta = 2
	})

	return
end

function var_0_1.InitPageInfo(arg_9_0)
	arg_9_0:initConfig()

	arg_9_0.onePageCnt = arg_9_0.pageTF.childCount
	math = var_1
	arg_9_0.pages = var_1.ceil(#arg_9_0.allIds / arg_9_0.onePageCnt)
	arg_9_0.curPageIndex = 1

	return
end

function var_0_1.UpdatePage(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.nextBtn, arg_10_0.pages ~= 1 and arg_10_0.curPageIndex < arg_10_0.pages)

	setActive = var_1_10001

	var_1_10001(arg_10_0.lastBtn, arg_10_0.pages ~= 1 and arg_10_0.curPageIndex > 1)

	setText = var_1_10001

	var_1_10001(arg_10_0.paginationTF, arg_10_0.curPageIndex .. "/" .. arg_10_0.pages)

	local var_10_0 = (arg_10_0.curPageIndex - 1) * arg_10_0.onePageCnt

	for iter_10_0 = 1, arg_10_0.onePageCnt do
		local var_10_1 = arg_10_0.pageTF
		local var_10_2 = var_6.Find(var_10_1, "frame_" .. iter_10_0)

		if arg_10_0.allIds[var_10_0 + iter_10_0] then
			setActive = var_8

			var_8(var_10_2, true)
			arg_10_0:UpdateItem(var_7, var_10_2)
		else
			setActive = var_8

			var_8(var_10_2, false)
		end
	end

	return
end

function var_0_1.UpdateItem(arg_11_0, arg_11_1, arg_11_2)
	assert = var_1_10003

	var_1_10003(nil, "updateItem方法必须由子类实现")

	return
end

function var_0_1.PlayAnimChange(arg_12_0)
	assert = var_1_10001

	var_1_10001(nil, "playAnimClose方法必须由子类实现")

	return
end

function var_0_1.onBackPressed(arg_13_0)
	arg_13_0:PlayAnimClose()

	return
end

function var_0_1.willExit(arg_14_0)
	local var_14_0 = arg_14_0.animEvent

	var_1.SetEndEvent(var_14_0, nil)
	arg_14_0:UnOverlayPanel(arg_14_0._tf)

	return
end

return var_0_1
