class = var_0_10000

local var_0_0 = "EducateCollectLayerTemplate"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.EducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	assert = var_1_10001

	var_1_10001(nil, "getUIName方法必须由子类实现")

	return
end

function var_0_1.initConfig(arg_2_0)
	assert = var_1_10001

	var_1_10001(nil, "initConfig方法必须由子类实现")

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "anim_root")
	local var_3_2 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_3_0.anim = var_3_2(var_3_1, var_4(var_1_10006))

	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_1.Find(var_3_3, "anim_root")
	local var_3_5 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_3_0.animEvent = var_3_5(var_3_4, var_4(var_1_10006))

	local var_3_6 = arg_3_0.animEvent

	var_1.SetEndEvent(var_3_6, function()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_3_7 = arg_3_0._tf

	arg_3_0.closeBtn = var_1.Find(var_3_7, "anim_root/bg")

	local var_3_8 = arg_3_0._tf

	arg_3_0.windowTF = var_1.Find(var_3_8, "anim_root/window")

	local var_3_9 = arg_3_0.windowTF

	arg_3_0.curCntTF = var_1.Find(var_3_9, "collect/cur")

	local var_3_10 = arg_3_0.windowTF

	arg_3_0.allCntTF = var_1.Find(var_3_10, "collect/all")

	local var_3_11 = arg_3_0.windowTF

	arg_3_0.pageTF = var_1.Find(var_3_11, "page")

	local var_3_12 = arg_3_0.windowTF

	arg_3_0.nextBtn = var_1.Find(var_3_12, "next_btn")

	local var_3_13 = arg_3_0.windowTF

	arg_3_0.lastBtn = var_1.Find(var_3_13, "last_btn")

	local var_3_14 = arg_3_0.windowTF

	arg_3_0.paginationTF = var_1.Find(var_3_14, "pagination")

	local var_3_15 = arg_3_0._tf

	arg_3_0.performTF = var_1.Find(var_3_15, "anim_root/perform")
	setActive = var_1

	var_1(arg_3_0.performTF, false)
	arg_3_0:initConfig()

	arg_3_0.onePageCnt = arg_3_0.pageTF.childCount
	math = var_1
	arg_3_0.pages = var_1.ceil(#arg_3_0.config.all / arg_3_0.onePageCnt)
	arg_3_0.curPageIndex = 1
	onButton = var_1

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0.closeBtn

	local function var_3_18()
		local var_5_0 = arg_3_0

		var_0.playAnimClose(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_16, var_3_17, var_3_18, var_1_10006)

	onButton = var_1

	local var_3_19 = arg_3_0
	local var_3_20 = arg_3_0.nextBtn

	local function var_3_21()
		local var_6_0 = arg_3_0

		var_0.playAnimChange(var_6_0)

		arg_3_0.curPageIndex = arg_3_0.curPageIndex + 1

		local var_6_1 = arg_3_0

		var_0.updatePage(var_6_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_19, var_3_20, var_3_21, var_1_10006)

	onButton = var_1

	local var_3_22 = arg_3_0
	local var_3_23 = arg_3_0.lastBtn

	local function var_3_24()
		local var_7_0 = arg_3_0

		var_0.playAnimChange(var_7_0)

		arg_3_0.curPageIndex = arg_3_0.curPageIndex - 1

		local var_7_1 = arg_3_0

		var_0.updatePage(var_7_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_22, var_3_23, var_3_24, var_1_10006)
	arg_3_0:OverlayPanel(arg_3_0._tf, {
		groupDelta = 2
	})

	eachChild = var_1

	var_1(arg_3_0.pageTF, function(arg_8_0)
		local var_8_0 = arg_8_0:Find("lock/unlock_btn/Text")
		local var_8_1 = var_1.GetComponent(var_8_0, "RichText")
		local var_8_2 = var_2.AddSprite
		local var_8_3 = "gold"
		local var_8_4 = arg_3_0._tf
		local var_8_5 = var_7.Find(var_8_4, "res/gold")
		local var_8_6 = var_7.GetComponent

		typeof = var_10
		Image = var_2_10012

		var_8_2(var_8_1, var_8_3, var_8_6(var_8_5, var_10(var_2_10012)).sprite)

		setText = var_8_2

		local var_8_7 = var_1

		i18n = var_8_3

		var_8_2(var_8_7, var_8_3("child_could_buy"))

		return
	end)

	return
end

function var_0_1.updatePage(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.nextBtn, arg_9_0.pages ~= 1 and arg_9_0.curPageIndex < arg_9_0.pages)

	setActive = var_1_10001

	var_1_10001(arg_9_0.lastBtn, arg_9_0.pages ~= 1 and arg_9_0.curPageIndex > 1)

	setText = var_1_10001

	var_1_10001(arg_9_0.paginationTF, arg_9_0.curPageIndex .. "/" .. arg_9_0.pages)

	local var_9_0 = (arg_9_0.curPageIndex - 1) * arg_9_0.onePageCnt

	for iter_9_0 = 1, arg_9_0.onePageCnt do
		local var_9_1 = arg_9_0.pageTF
		local var_9_2 = var_6.Find(var_9_1, "frame_" .. iter_9_0)

		if arg_9_0.config[arg_9_0.config.all[var_9_0 + iter_9_0]] then
			setActive = var_8

			var_8(var_9_2, true)
			arg_9_0:updateItem(var_7, var_9_2)
		else
			setActive = var_8

			var_8(var_9_2, false)
		end
	end

	return
end

function var_0_1.updateItem(arg_10_0, arg_10_1, arg_10_2)
	assert = var_1_10003

	var_1_10003(nil, "updateItem方法必须由子类实现")

	return
end

function var_0_1.playAnimChange(arg_11_0)
	assert = var_1_10001

	var_1_10001(nil, "playAnimClose方法必须由子类实现")

	return
end

function var_0_1.playAnimClose(arg_12_0)
	assert = var_1_10001

	var_1_10001(nil, "playAnimClose方法必须由子类实现")

	return
end

function var_0_1.onBackPressed(arg_13_0)
	arg_13_0:playAnimClose()

	return
end

function var_0_1.willExit(arg_14_0)
	local var_14_0 = arg_14_0.animEvent

	var_1.SetEndEvent(var_14_0, nil)
	arg_14_0:UnOverlayPanel(arg_14_0._tf)

	return
end

return var_0_1
