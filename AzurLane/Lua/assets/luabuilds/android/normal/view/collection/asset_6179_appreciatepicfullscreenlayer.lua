class = var_0_10000

local var_0_0 = "AppreciatePicFullScreenLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AppreciatePicFullScreenUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()
	arg_2_0:updatePanel()

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	local var_4_1 = arg_4_0.resLoader

	var_1.Clear(var_4_1)

	return
end

function var_0_1.findUI(arg_5_0)
	return
end

function var_0_1.initData(arg_6_0)
	AutoLoader = var_1_10001
	arg_6_0.resLoader = var_1_10001.New()
	arg_6_0.curPicInfo = arg_6_0.contextData.curPicInfo

	return
end

function var_0_1.addListener(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.bg

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.closeView(var_8_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.galleryPicImg

	local function var_7_5()
		local var_9_0 = arg_7_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10005)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.mangaPicImg

	local function var_7_8()
		local var_10_0 = arg_7_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10005)

	return
end

function var_0_1.updatePanel(arg_11_0)
	setActive = var_1_10001

	local var_11_0 = arg_11_0.galleryPanel
	local var_11_1 = arg_11_0.curPicInfo.type

	AppreciatePicConst = var_1_10004

	var_1_10001(var_11_0, var_11_1 == var_1_10004.TYPE_GALLERY)

	setActive = var_1_10001

	local var_11_2 = arg_11_0.mangaPanel
	local var_11_3 = arg_11_0.curPicInfo.type

	AppreciatePicConst = var_4

	var_1_10001(var_11_2, var_11_3 == var_4.TYPE_MANGA)

	local var_11_4 = arg_11_0.curPicInfo.type

	AppreciatePicConst = var_11_2

	local var_11_5

	if var_11_4 == var_11_2.TYPE_GALLERY then
		var_11_5 = arg_11_0

		arg_11_0.updateGalleryPanel(var_11_5)
	else
		local var_11_6 = arg_11_0.curPicInfo.type

		AppreciatePicConst = var_11_5

		if var_11_6 == var_11_5.TYPE_MANGA then
			arg_11_0:updateMangaPanel()
		end
	end

	return
end

function var_0_1.updateGalleryPanel(arg_12_0)
	arg_12_0:setImage(arg_12_0.galleryPicImg, arg_12_0.curPicInfo)

	return
end

function var_0_1.updateMangaPanel(arg_13_0)
	arg_13_0:setImage(arg_13_0.mangaPicImg, arg_13_0.curPicInfo)

	return
end

function var_0_1.setImage(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2.path

	GetFileName = var_1_10004

	local var_14_1 = var_1_10004(var_14_0)

	GetComponent = var_5

	local var_14_2 = arg_14_1

	typeof = var_1_10007
	Image = var_1_10008

	local var_14_3 = var_5(var_14_2, var_1_10007(var_1_10008)).sprite

	IsNil = var_14_2

	if not var_14_2(var_14_3) then
		local var_14_4 = var_14_3.name

		string = var_7

		local var_14_5 = var_7.lower(var_14_4)

		string = var_8

		if var_14_5 ~= var_8.lower(var_14_1) then
			local var_14_6 = arg_14_0.resLoader

			var_7.LoadSprite(var_14_6, var_14_0, var_14_1, arg_14_1, false)
		end
	else
		local var_14_7 = arg_14_0.resLoader

		var_6.LoadSprite(var_14_7, var_14_0, var_14_1, arg_14_1, false)
	end

	return
end

return var_0_1
