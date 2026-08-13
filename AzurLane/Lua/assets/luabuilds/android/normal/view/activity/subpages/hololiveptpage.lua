class = var_0_10000

local var_0_0 = "HoloLivePtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.charImg = var_1.Find(var_1_0, "charImg")

	local var_1_1 = arg_1_0.bg

	arg_1_0.numImg = var_1.Find(var_1_1, "numImg")

	local var_1_2 = arg_1_0.bg

	arg_1_0.chapterImg = var_1.Find(var_1_2, "chapterImg")

	local var_1_3 = arg_1_0.bg

	arg_1_0.spineCharContainer = var_1.Find(var_1_3, "SpineChar")

	local var_1_4 = arg_1_0.bg

	arg_1_0.scrollTextMask = var_1.Find(var_1_4, "ScrollText")

	local var_1_5 = arg_1_0.bg

	arg_1_0.scrollTextContainer = var_1.Find(var_1_5, "ScrollText/TextList")

	local var_1_6 = arg_1_0.bg

	arg_1_0.scrollTextTpl = var_1.Find(var_1_6, "TextTpl")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	var_0_1.super.OnDataSetting(arg_2_0)

	local var_2_0 = arg_2_0.ptData

	arg_2_0.ptCount = var_1.GetResProgress(var_2_0)
	pg = var_1
	arg_2_0.ptRank = var_1.activity_event_pt[arg_2_0.activity.id].pt_list
	pg = var_1
	arg_2_0.picNameList = var_1.activity_event_pt[arg_2_0.activity.id].pic_list

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	var_0_1.super.OnFirstFlush(arg_3_0)
	arg_3_0:initScrollTextList()

	local var_3_0 = arg_3_0.ptRank[2] - arg_3_0.ptRank[1]

	math = var_2

	local var_3_1

	if var_2.floor(arg_3_0.ptCount / var_3_0) + 1 > #arg_3_0.picNameList then
		var_3_1 = #arg_3_0.picNameList
	end

	local var_3_2 = arg_3_0.picNameList[var_3_1]

	LoadSpriteAtlasAsync = var_1_10004

	var_1_10004("ui/activityuipage/hololiveptpage", var_3_2, function(arg_4_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_3_0.charImg, arg_4_0)

		return
	end)

	LoadSpriteAtlasAsync = var_1_10004

	var_1_10004("ui/activityuipage/hololiveptpage", "#" .. var_3_1, function(arg_5_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_3_0.numImg, arg_5_0)

		return
	end)

	LoadSpriteAtlasAsync = var_1_10004

	var_1_10004("ui/activityuipage/hololiveptpage", "jiaobiao_" .. var_3_1, function(arg_6_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_3_0.chapterImg, arg_6_0)

		return
	end)

	local var_3_3 = "vtuber_shion"

	pg = var_5

	local var_3_4 = var_5.UIMgr.GetInstance()

	var_5.LoadingOn(var_3_4)

	PoolMgr = var_5

	local var_3_5 = var_5.GetInstance()

	var_5.GetSpineChar(var_3_5, var_3_3, true, function(arg_7_0)
		pg = var_2_10001

		local var_7_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_7_0)

		arg_3_0.prefab = var_3_3

		local var_7_1 = arg_3_0

		var_7_1.model = arg_7_0
		tf = var_7_1

		local var_7_2 = var_7_1(arg_7_0)

		Vector3 = var_2
		var_7_2.localScale = var_2(1, 1, 1)

		local var_7_3 = arg_7_0:GetComponent("SpineAnimUI")

		var_1.SetAction(var_7_3, "stand", 0)

		setParent = var_1

		var_1(arg_7_0, arg_3_0.spineCharContainer)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	if arg_8_0.scrollTextTimer then
		local var_8_0 = arg_8_0.scrollTextTimer

		var_1.Stop(var_8_0)

		arg_8_0.scrollTextTimer = nil
	end

	if arg_8_0.prefab and arg_8_0.model then
		PoolMgr = var_1

		local var_8_1 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_8_1, arg_8_0.prefab, arg_8_0.model)

		arg_8_0.prefab = nil
		arg_8_0.model = nil
	end

	return
end

function var_0_1.initScrollTextList(arg_9_0)
	setText = var_1_10001

	local var_9_0 = arg_9_0.scrollTextTpl
	local var_9_1 = arg_9_0.activity

	var_1_10001(var_9_0, var_3.getConfig(var_9_1, "config_client").scrollStr)

	GetComponent = var_1_10001

	local var_9_2 = var_1_10001(arg_9_0.scrollTextTpl, "Text").preferredWidth + arg_9_0.scrollTextMask.rect.width + 50
	local var_9_3 = arg_9_0.scrollTextContainer.localPosition.x - var_9_2
	local var_9_4 = 50
	local var_9_5 = 0.016666666666666666

	UIItemList = var_1_10009

	local var_9_6 = var_1_10009.New(arg_9_0.scrollTextContainer, arg_9_0.scrollTextTpl)

	var_9.align(var_9_6, 2)

	local var_9_7 = arg_9_0.scrollTextContainer
	local var_9_8 = var_10.GetChild(var_9_7, 1)

	Timer = var_9_7
	arg_9_0.scrollTextTimer = var_9_7.New(function()
		local var_10_0

		if arg_9_0.scrollTextContainer.localPosition.x - var_9_4 * var_9_5 <= var_9_3 then
			var_10_0 = var_9_8.localPosition.x + arg_9_0.scrollTextContainer.localPosition.x
		end

		local var_10_1 = arg_9_0.scrollTextContainer

		Vector3 = var_2
		var_10_1.localPosition = var_2(var_10_0, 0, 0)

		return
	end, var_9_5, -1, true)

	local var_9_9 = arg_9_0.scrollTextTimer

	var_11.Start(var_9_9)

	return
end

return var_0_1
