class = var_0_10000

local var_0_0 = "GalleryFullScreenLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "GalleryViewUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_3_0, arg_3_0._tf)
	arg_3_0:updatePicImg()

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.onBackPressed(arg_5_0)
	if not arg_5_0.isShowing then
		arg_5_0:closeView()
	end

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.bg = var_1.Find(var_6_0, "BG")

	local var_6_1 = arg_6_0._tf

	arg_6_0.picImg = var_1.Find(var_6_1, "Pic")

	return
end

function var_0_1.initData(arg_7_0)
	arg_7_0.picID = arg_7_0.contextData.picID

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.bg

	local function var_8_2()
		if not arg_8_0.isShowing then
			local var_9_0 = arg_8_0

			var_0.closeView(var_9_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.picImg

	local function var_8_5()
		if not arg_8_0.isShowing then
			local var_10_0 = arg_8_0

			var_0.closeView(var_10_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	return
end

function var_0_1.updatePicImg(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.gallery_config[arg_11_0.picID].illustration

	GalleryConst = var_1_10003

	local var_11_1 = var_1_10003.PIC_PATH_PREFIX .. var_11_0

	setImageSprite = var_4

	local var_11_2 = arg_11_0.picImg

	LoadSprite = var_1_10006

	var_4(var_11_2, var_1_10006(var_11_1, var_11_0))

	arg_11_0.isShowing = true
	LeanTween = var_4

	local var_11_3 = var_4.value

	go = var_11_2

	local var_11_4 = var_11_3(var_11_2(arg_11_0.picImg), 0, 1, 0.3)
	local var_11_5 = var_4.setOnUpdate

	System = var_6

	local var_11_6 = var_11_5(var_11_4, var_6.Action_float(function(arg_12_0)
		setImageAlpha = var_2_10001

		var_2_10001(arg_11_0.picImg, arg_12_0)

		return
	end))
	local var_11_7 = var_4.setOnComplete

	System = var_6

	var_11_7(var_11_6, var_6.Action(function()
		local var_13_0 = arg_11_0

		var_13_0.isShowing = false
		setImageAlpha = var_13_0

		var_13_0(arg_11_0.picImg, 1)

		return
	end))

	return
end

return var_0_1
