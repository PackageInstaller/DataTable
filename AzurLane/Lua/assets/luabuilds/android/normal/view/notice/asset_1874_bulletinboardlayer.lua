class = var_0_10000

local var_0_0 = "BulletinBoardLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BulletinBoardUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0._closeBtn = var_1.Find(var_2_0, "close_btn")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "title_list/viewport/content")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	ToggleGroup = var_1_10004
	arg_2_0._tabGroup = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf

	arg_2_0._tabContainer = var_1.Find(var_2_4, "title_list/viewport/content")

	local var_2_5 = arg_2_0._tf

	arg_2_0._tabTpl = var_1.Find(var_2_5, "title_list/tab_btn_tpl")
	SetActive = var_1

	var_1(arg_2_0._tabTpl, false)

	arg_2_0._tabList = {}

	local var_2_6 = arg_2_0._tf

	arg_2_0._detailTitleImg = var_1.Find(var_2_6, "content_view/viewport/content/title_img/img")

	local var_2_7 = arg_2_0._detailTitleImg
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0._detailTitleImgComp = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf

	arg_2_0._detailTitleLoading = var_1.Find(var_2_9, "content_view/viewport/content/title_img/loading")

	local var_2_10 = arg_2_0._tf

	arg_2_0._detailTitleTxt = var_1.Find(var_2_10, "content_view/viewport/content/title_txt")

	local var_2_11 = arg_2_0._tf

	arg_2_0._detailTimeTxt = var_1.Find(var_2_11, "content_view/viewport/content/time_txt")

	local var_2_12 = arg_2_0._tf

	arg_2_0._detailContentTxt = var_1.Find(var_2_12, "content_view/viewport/content/content_txt")

	local var_2_13 = arg_2_0._detailContentTxt

	arg_2_0._detailContentTxtComp = var_1.GetComponent(var_2_13, "RichText")

	local var_2_14 = arg_2_0._detailContentTxtComp

	var_1.AddListener(var_2_14, function(arg_3_0, arg_3_1)
		if arg_3_0 == "url" then
			Application = var_2_10002

			var_2_10002.OpenURL(arg_3_1)
		end

		return
	end)

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_1.Find(var_2_15, "content_view")
	local var_2_17 = var_1.GetComponent

	typeof = var_3
	ScrollRect = var_1_10004
	arg_2_0._scrollRect = var_2_17(var_2_16, var_3(var_1_10004))

	local var_2_18 = arg_2_0._tf

	arg_2_0._stopRemind = var_1.Find(var_2_18, "dontshow_tab")
	pg = var_1

	local var_2_19 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_19, arg_2_0._tf)

	arg_2_0._loadingFlag = {}

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._closeBtn

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	onToggle = var_1_10001

	var_1_10001(arg_4_0, arg_4_0._stopRemind, function(arg_6_0)
		local var_6_0 = arg_4_0
		local var_6_1 = var_1.emit

		BulletinBoardMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.SET_STOP_REMIND, arg_6_0)

		return
	end)

	getProxy = var_1_10001
	ServerNoticeProxy = var_2

	local var_4_3 = var_1_10001(var_2)
	local var_4_4 = var_1.getStopRemind(var_4_3)

	triggerToggle = var_4_3

	var_4_3(arg_4_0._stopRemind, var_4_4)

	return
end

function var_0_1.setNotices(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = {}

	pairs = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10004(arg_7_1) do
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_7_2 = var_7_0

		tostring = var_1_10011

		var_1_10009(var_7_2, var_1_10011(iter_7_1.id))

		table = var_1_10009

		var_1_10009.insert(var_7_1, iter_7_1.version)

		cloneTplTo = var_1_10009
		var_1_10009 = var_1_10009(arg_7_0._tabTpl, arg_7_0._tabContainer)
		setScrollText = var_10

		var_10(var_1_10009:Find("common_state/title_mask/title_txt"), iter_7_1.btnTitle)

		setScrollText = var_10

		var_10(var_1_10009:Find("select_state/title_mask/title_txt"), iter_7_1.btnTitle)

		changeToScrollText = var_10

		var_10(var_1_10009:Find("common_state/time_txt"), iter_7_1.title)

		changeToScrollText = var_10

		var_10(var_1_10009:Find("select_state/time_txt"), iter_7_1.title)

		table = var_10

		var_10.insert(arg_7_0._tabList, var_1_10009)

		SetActive = var_10

		var_10(var_1_10009, true)

		GetComponent = var_10
		var_1_10011 = var_1_10009
		typeof = var_12
		Toggle = var_13
		var_10(var_1_10011, var_12(var_13)).group = arg_7_0._tabGroup
		onToggle = var_1_10011

		local var_7_3 = arg_7_0
		local var_7_4 = var_1_10009

		local function var_7_5(arg_8_0)
			if arg_8_0 then
				local var_8_0 = arg_7_0

				var_2_10001.setNoticeDetail(var_8_0, iter_7_1)
			end

			setActive = var_2_10001

			local var_8_1 = var_1_10009

			var_2_10001(var_2.Find(var_8_1, "common_state"), not arg_8_0)

			return
		end

		SFX_PANEL = var_1_10015

		var_1_10011(var_7_3, var_7_4, var_7_5, var_1_10015)
	end

	triggerToggle = var_4

	var_4(arg_7_0._tabList[1], true)

	BulletinBoardMgr = var_4

	local var_7_6 = var_4.Inst

	var_4.ClearCache(var_7_6, var_7_0, var_7_1)

	return
end

function var_0_1.setNoticeDetail(arg_9_0, arg_9_1)
	arg_9_0:clearLoadingPic()

	setText = var_2

	var_2(arg_9_0._detailTitleTxt, arg_9_1.pageTitle)

	setText = var_2

	var_2(arg_9_0._detailTimeTxt, arg_9_1.timeDes)

	local var_9_0 = arg_9_0._detailTitleImgComp

	Color = var_3
	var_9_0.color = var_3.New(0, 0, 0, 0.4)
	setActive = var_9_0

	var_9_0(arg_9_0._detailTitleLoading, true)

	local var_9_1 = arg_9_0._loadingFlag

	var_9_1[arg_9_1.titleImage] = true
	BulletinBoardMgr = var_9_1

	local var_9_2 = var_9_1.Inst
	local var_9_3 = var_2.GetSprite
	local var_9_4 = arg_9_1.id
	local var_9_5 = arg_9_1.version
	local var_9_6 = arg_9_1.titleImage

	UnityEngine = var_7

	var_9_3(var_9_2, var_9_4, var_9_5, var_9_6, var_7.Events.UnityAction_UnityEngine_Sprite(function(arg_10_0)
		local var_10_0 = arg_9_0._loadingFlag

		var_10_0[arg_9_1.titleImage] = nil

		if arg_10_0 ~= nil then
			setImageSprite = var_10_0

			var_10_0(arg_9_0._detailTitleImg, arg_10_0, false)

			local var_10_1 = arg_9_0._detailTitleImgComp

			Color = var_2
			var_10_1.color = var_2.New(1, 1, 1, 1)
			setActive = var_10_1

			var_10_1(arg_9_0._detailTitleLoading, false)
		end

		return
	end))

	arg_9_0.tempContent = arg_9_1.content
	arg_9_0.realContent = arg_9_1.content
	arg_9_0.loadingCount = 0
	arg_9_0.loadPic = {}
	string = var_2

	for iter_9_0 in var_2.gmatch(arg_9_1.content, "<imgHref>%S-</imgHref>") do
		string = var_9_6

		local var_9_7

		var_9_6, var_9_7 = var_9_6.find(iter_9_0, "<imgHref>")
		string = var_8

		local var_9_8, var_9_9 = var_8.find(iter_9_0, "</imgHref>")

		string = var_10

		local var_9_10 = var_10.sub(iter_9_0, var_9_7 + 1, var_9_8 - 1)
		local var_9_11 = "<icon name=" .. var_9_10 .. " w=2 h=2/>"

		string = var_12

		local var_9_12 = var_12.gsub(iter_9_0, "%.", "%%.")

		string = var_1_10013

		local var_9_13 = var_1_10013.gsub(var_9_12, "%-", "%%-")

		string = var_1_10013

		local var_9_14 = var_1_10013.gsub(var_9_13, "%?", "%%?")

		string = var_1_10013
		arg_9_0.realContent = var_1_10013.gsub(arg_9_0.realContent, var_9_14, var_9_11)
		string = var_1_10013
		arg_9_0.tempContent = var_1_10013.gsub(arg_9_0.tempContent, var_9_14, "")
		table = var_1_10013

		var_1_10013.insert(arg_9_0.loadPic, var_9_10)
	end

	SwitchSpecialChar = var_2

	local var_9_15 = var_2(arg_9_0.tempContent, true)

	setText = var_3

	var_3(arg_9_0._detailContentTxt, var_9_15)

	arg_9_0.loadingCount = #arg_9_0.loadPic
	ipairs = var_3

	for iter_9_1, iter_9_2 in var_3(arg_9_0.loadPic) do
		local var_9_16 = arg_9_0._loadingFlag

		var_9_16[iter_9_2] = true
		BulletinBoardMgr = var_9_16

		local var_9_17 = var_9_16.Inst
		local var_9_18 = var_8.GetSprite
		local var_9_19 = arg_9_1.id
		local var_9_20 = arg_9_1.version
		local var_9_21 = iter_9_2

		UnityEngine = var_1_10013

		var_9_18(var_9_17, var_9_19, var_9_20, var_9_21, var_1_10013.Events.UnityAction_UnityEngine_Sprite(function(arg_11_0)
			arg_9_0._loadingFlag[iter_9_2] = nil

			if arg_11_0 ~= nil then
				arg_9_0.loadingCount = arg_9_0.loadingCount - 1

				local var_11_0 = arg_9_0._detailContentTxtComp

				var_1.AddSprite(var_11_0, arg_11_0.name, arg_11_0)

				if arg_9_0.loadingCount <= 0 then
					setText = var_1

					local var_11_1 = arg_9_0._detailContentTxt

					SwitchSpecialChar = var_3

					var_1(var_11_1, var_3(arg_9_0.realContent, true))
				end
			end

			return
		end))
	end

	return
end

function var_0_1.clearLoadingPic(arg_12_0)
	pairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0._loadingFlag) do
		BulletinBoardMgr = var_1_10006

		local var_12_0 = var_1_10006.Inst

		var_1_10006.StopLoader(var_12_0, iter_12_0)

		var_1_10006 = arg_12_0._loadingFlag
		var_1_10006[iter_12_0] = nil
	end

	return
end

function var_0_1.willExit(arg_13_0)
	arg_13_0:clearLoadingPic()

	pg = var_1

	local var_13_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_0, arg_13_0._tf)

	return
end

return var_0_1
