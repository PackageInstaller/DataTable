local var_0_0 = class("GalleryFullScreenLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "GalleryViewUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	pg.UIMgr.GetInstance():OverlayPanel(arg_3_0._tf)
	arg_3_0:updatePicImg()

	return
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.onBackPressed(arg_5_0)
	if not arg_5_0.isShowing then
		arg_5_0:closeView()
	end

	return
end

function var_0_0.findUI(arg_6_0)
	arg_6_0.bg = arg_6_0._tf:Find("BG")
	arg_6_0.picImg = arg_6_0._tf:Find("Pic")

	return
end

function var_0_0.initData(arg_7_0)
	arg_7_0.picID = arg_7_0.contextData.picID

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.bg, function()
		if not arg_8_0.isShowing then
			arg_8_0:closeView()
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.picImg, function()
		if not arg_8_0.isShowing then
			arg_8_0:closeView()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updatePicImg(arg_11_0)
	setImageSprite(arg_11_0.picImg, LoadSprite(GalleryConst.PIC_PATH_PREFIX .. pg.gallery_config[arg_11_0.picID].illustration, pg.gallery_config[arg_11_0.picID].illustration))

	arg_11_0.isShowing = true

	LeanTween.value(go(arg_11_0.picImg), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_12_0)
		setImageAlpha(arg_11_0.picImg, arg_12_0)

		return
	end)):setOnComplete(System.Action(function()
		arg_11_0.isShowing = false

		setImageAlpha(arg_11_0.picImg, 1)

		return
	end))

	return
end

return var_0_0
