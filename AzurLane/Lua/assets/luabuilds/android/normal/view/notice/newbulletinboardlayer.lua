class = var_0_10000

local var_0_0 = "NewBulletinBoardLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.CONTENT_TYPE = {
	BANNER = "BANNER",
	RICHTEXT = "RITCHTEXT"
}
var_0_1.ICON_NAME = {
	"activity_common",
	"activity_summary",
	"activity_time_limit",
	"build_time_limit",
	"equibment_skin_new",
	"furniture_new",
	"info_common",
	"skin_new",
	"system_common"
}
var_0_1.MAIN_TAB_GAMETIP = {
	"Announcements_Event_Notice",
	"Announcements_System_Notice",
	"Announcements_News"
}
var_0_1.TITLE_IMAGE_HEIGHT_DEFAULT = 231
var_0_1.TITLE_IMAGE_HEIGHT_FULL = 734

function var_0_1.getUIName(arg_1_0)
	return "NewBulletinBoardUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0._closeBtn = var_1.Find(var_2_0, "bg/close_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0._mainTabContainer = var_1.Find(var_2_1, "bg/notice_list")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "bg/title_list/viewport/content")
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	ToggleGroup = var_1_10004
	arg_2_0._subTabGroup = var_2_4(var_2_3, var_3(var_1_10004))

	local var_2_5 = arg_2_0._tf

	arg_2_0._subTabContainer = var_1.Find(var_2_5, "bg/title_list/viewport/content")

	local var_2_6 = arg_2_0._tf

	arg_2_0._tabTpl = var_1.Find(var_2_6, "bg/title_list/tab_btn_tpl")
	SetActive = var_1

	var_1(arg_2_0._tabTpl, false)

	arg_2_0._subTabList = {}

	local var_2_7 = arg_2_0._tf

	arg_2_0._contentTF = var_1.Find(var_2_7, "bg/content_view/viewport/content")

	local var_2_8 = arg_2_0._contentTF

	arg_2_0._detailTitleImg = var_1.Find(var_2_8, "title_img")

	local var_2_9 = arg_2_0._detailTitleImg
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	LayoutElement = var_1_10004
	arg_2_0._detailTitleImgLayoutElement = var_2_10(var_2_9, var_3(var_1_10004))

	local var_2_11 = arg_2_0._contentTF

	arg_2_0._detailTitle = var_1.Find(var_2_11, "title")

	local var_2_12 = arg_2_0._contentTF

	arg_2_0._detailTitleTxt = var_1.Find(var_2_12, "title/title_txt/mask/scroll_txt")

	local var_2_13 = arg_2_0._contentTF

	arg_2_0._detailTimeTxt = var_1.Find(var_2_13, "title/time_txt")

	local var_2_14 = arg_2_0._contentTF

	arg_2_0._detailLine = var_1.Find(var_2_14, "line")

	local var_2_15 = arg_2_0._contentTF

	arg_2_0._bottom = var_1.Find(var_2_15, "bottom")

	local var_2_16 = arg_2_0._contentTF

	arg_2_0._contentContainer = var_1.Find(var_2_16, "content_container")

	local var_2_17 = arg_2_0._contentTF

	arg_2_0._contentTxtTpl = var_1.Find(var_2_17, "content_txt")
	setActive = var_1

	var_1(arg_2_0._contentTxtTpl, false)

	local var_2_18 = arg_2_0._contentTF

	arg_2_0._contentBannerTpl = var_1.Find(var_2_18, "content_banner")
	setActive = var_1

	var_1(arg_2_0._contentBannerTpl, false)

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_1.Find(var_2_19, "bg/content_view")
	local var_2_21 = var_1.GetComponent

	typeof = var_3
	ScrollRect = var_1_10004
	arg_2_0._scrollRect = var_2_21(var_2_20, var_3(var_1_10004))

	local var_2_22 = arg_2_0._tf

	arg_2_0._dontshow = var_1.Find(var_2_22, "bg/dont_show")

	local var_2_23 = arg_2_0._tf

	arg_2_0._stopRemind = var_1.Find(var_2_23, "bg/dont_show/bottom")
	arg_2_0._subTabAnims = {}

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0._mainAnim = var_2_25(var_2_24, var_3(var_1_10004))

	local var_2_26 = arg_2_0._tf
	local var_2_27 = var_1.Find(var_2_26, "bg")
	local var_2_28 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0._bgAnim = var_2_28(var_2_27, var_3(var_1_10004))

	local var_2_29 = arg_2_0._tf
	local var_2_30 = var_1.Find(var_2_29, "bg/content_view")
	local var_2_31 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0._contentAnim = var_2_31(var_2_30, var_3(var_1_10004))
	pg = var_1

	local var_2_32 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_32, arg_2_0._tf)

	arg_2_0._loadingFlag = {}
	arg_2_0._contentList = {}
	arg_2_0._noticeDic = {
		{},
		{},
		{}
	}
	arg_2_0._redDic = {
		{},
		{},
		{}
	}
	arg_2_0.noticeKeys = {}
	arg_2_0.noticeVersions = {}
	arg_2_0.LTList = {}

	return
end

function var_0_1.didEnter(arg_3_0)
	local var_3_0 = arg_3_0._mainAnim

	var_1.Play(var_3_0, "anim_BulletinBoard_in")

	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0._closeBtn

	local function var_3_3()
		local var_4_0 = arg_3_0._mainAnim

		var_0.Play(var_4_0, "anim_BulletinBoard_out")

		LeanTween = var_0

		local var_4_1 = var_0.delayedCall
		local var_4_2 = 0.2

		System = var_2

		var_4_1(var_4_2, var_2.Action(function()
			local var_5_0 = arg_3_0

			var_0.emit(var_5_0, var_0_1.ON_CLOSE)

			return
		end))

		return
	end

	SOUND_BACK = var_1_10005

	var_1(var_3_1, var_3_2, var_3_3, var_1_10005)

	onToggle = var_1

	var_1(arg_3_0, arg_3_0._stopRemind, function(arg_6_0)
		local var_6_0 = arg_3_0
		local var_6_1 = var_1.emit

		NewBulletinBoardMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.SET_STOP_REMIND, arg_6_0)

		return
	end)

	getProxy = var_1
	ServerNoticeProxy = var_2

	local var_3_4 = var_1(var_2)
	local var_3_5 = var_1.getStopRemind(var_3_4)

	triggerToggle = var_3_4

	var_3_4(arg_3_0._stopRemind, var_3_5)

	setText = var_3_4

	local var_3_6 = arg_3_0._dontshow

	i18n = var_5

	var_3_4(var_3_6, var_5("Announcements_Donotshow"))

	LeanTween = var_3_4

	local var_3_7 = var_3_4.rotateAroundLocal

	rtf = var_3_6

	local var_3_8 = arg_3_0._detailTitleImg
	local var_3_9 = var_3_6(var_5.Find(var_3_8, "loading/Image"))

	Vector3 = var_5

	local var_3_10 = var_3_7(var_3_9, var_5(0, 0, -1), 360, 5)

	var_3.setLoopClamp(var_3_10)

	return
end

function var_0_1.updateRed(arg_7_0)
	for iter_7_0 = 1, 3 do
		var_1_10005 = false
		pairs = var_1_10006

		for iter_7_1, iter_7_2 in var_1_10006(arg_7_0._noticeDic[iter_7_0]) do
			local var_7_0 = arg_7_0._redDic[iter_7_0]

			PlayerPrefs = var_1_10012
			var_7_0[iter_7_1] = var_1_10012.HasKey(iter_7_2.code)

			if not arg_7_0._redDic[iter_7_0][iter_7_1] then
				var_1_10005 = true
			end
		end

		setActive = var_1_10006

		local var_7_1 = arg_7_0._mainTabContainer
		local var_7_2 = var_7.GetChild(var_7_1, iter_7_0 - 1)

		var_1_10006(var_7.Find(var_7_2, "Text/red"), var_1_10005)
	end

	for iter_7_3 = 1, #arg_7_0._subTabList do
		setActive = var_1_10005

		local var_7_3 = arg_7_0._subTabList[iter_7_3]

		var_1_10005(var_6.Find(var_7_3, "red"), not arg_7_0._redDic[arg_7_0.currentMainTab][iter_7_3])
	end

	return
end

function var_0_1.checkNotice(arg_8_0, arg_8_1)
	if arg_8_1.type then
		if arg_8_1.type > 0 and arg_8_1.type < 4 then
			if arg_8_1.paramType ~= nil then
				if arg_8_1.paramType == 1 then
					type = var_8_0

					if var_8_0(arg_8_1.param) ~= "string" then
						if arg_8_1.paramType == 2 then
							type = var_8_0

							if var_8_0(arg_8_1.param) ~= "string" then
								if arg_8_1.paramType == 3 then
									type = var_8_0

									if var_8_0(arg_8_1.param) ~= "number" then
										if arg_8_1.paramType == 4 then
											type = var_8_0

											if var_8_0(arg_8_1.param) == "number" then
												pg = var_8_0

												local var_8_0

												if var_8_0.activity_banner_notice[arg_8_1.param] == nil then
													if arg_8_1.paramType ~= 5 then
														var_8_0 = false

														goto label_8_0
													end
												end

												var_8_0 = true

												::label_8_0::

												return var_8_0
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function var_0_1.initNotices(arg_9_0, arg_9_1)
	arg_9_0.defaultMainTab = arg_9_0.contextData.defaultMainTab
	arg_9_0.defaultSubTab = arg_9_0.contextData.defaultSubTab

	local var_9_0
	local var_9_1

	pairs = var_1_10004

	for iter_9_0, iter_9_1 in var_1_10004(arg_9_1) do
		local var_9_2

		if arg_9_0:checkNotice(iter_9_1) then
			table = var_9_2

			var_9_2.insert(arg_9_0._noticeDic[iter_9_1.type], iter_9_1)

			table = var_9_2
			var_9_2 = var_9_2.insert

			local var_9_3 = arg_9_0._redDic[iter_9_1.type]

			PlayerPrefs = var_11

			var_9_2(var_9_3, var_11.HasKey(iter_9_1.code))

			if not var_9_1 or var_9_1 < iter_9_1.priority then
				var_9_1 = iter_9_1.priority
				var_9_0 = iter_9_1.type
			end

			table = var_9_2
			var_9_2 = var_9_2.insert

			local var_9_4 = arg_9_0.noticeKeys

			tostring = var_11

			var_9_2(var_9_4, var_11(iter_9_1.id))

			table = var_9_2

			var_9_2.insert(arg_9_0.noticeVersions, iter_9_1.version)
		else
			Debugger = var_9_2

			var_9_2.LogWarning("公告配置错误  id = " .. iter_9_1.id)
		end
	end

	for iter_9_2 = 1, 3 do
		local var_9_5 = arg_9_0._mainTabContainer
		local var_9_6 = var_8.GetChild(var_9_5, iter_9_2 - 1)
		local var_9_7 = var_8.Find(var_9_6, "selected")
		local var_9_8 = var_9.GetComponent

		typeof = var_11
		Animation = var_1_10012

		local var_9_9 = var_9_8(var_9_7, var_11(var_1_10012))

		setText = var_9_7
		var_1_10012 = var_8

		local var_9_10 = var_8.Find(var_1_10012, "Text")

		i18n = var_1_10012

		var_9_7(var_9_10, var_1_10012(var_0_1.MAIN_TAB_GAMETIP[iter_9_2]))

		onToggle = var_9_7

		var_9_7(arg_9_0, var_8, function(arg_10_0)
			if arg_10_0 then
				if arg_9_0.currentMainTab and arg_9_0.currentMainTab == iter_9_2 then
					return
				end

				if arg_9_0.currentMainTab then
					local var_10_0 = var_9_9

					var_1.Play(var_10_0, arg_9_0.currentMainTab > iter_9_2 and "anim_BB_toptitle_R_in" or "anim_BB_toptitle_L_in")

					local var_10_1 = arg_9_0._bgAnim

					var_1.Play(var_10_1, arg_9_0.currentMainTab > iter_9_2 and "anim_BulletinBoard_Rin_change" or "anim_BulletinBoard_Lin_change")
				end

				arg_9_0.currentMainTab = iter_9_2
				arg_9_0.defaultSubTab = arg_9_0.tempSubTab
				arg_9_0.tempSubTab = nil

				local var_10_2 = arg_9_0

				var_1.setNotices(var_10_2, arg_9_0._noticeDic[iter_9_2])
			end

			return
		end)

		if #arg_9_0._noticeDic[iter_9_2] == 0 then
			setActive = var_10

			var_10(var_8, false)
		end
	end

	local var_9_11

	if not arg_9_0.defaultMainTab then
		var_9_11 = var_9_0
	end

	arg_9_0.defaultMainTab = var_9_11

	if arg_9_0.defaultMainTab then
		arg_9_0.tempSubTab = arg_9_0.defaultSubTab
		triggerToggle = var_4

		local var_9_12 = arg_9_0._mainTabContainer

		var_4(var_5.GetChild(var_9_12, arg_9_0.defaultMainTab - 1), true)
	end

	BulletinBoardMgr = var_4

	local var_9_13 = var_4.Inst

	var_4.ClearCache(var_9_13, arg_9_0.noticeKeys, arg_9_0.noticeVersions)

	return
end

function var_0_1.setNotices(arg_11_0, arg_11_1)
	arg_11_0:clearTab()

	pairs = var_2

	for iter_11_0, iter_11_1 in var_2(arg_11_1) do
		cloneTplTo = var_1_10007
		var_1_10007 = var_1_10007(arg_11_0._tabTpl, arg_11_0._subTabContainer)
		SetActive = var_8

		var_8(var_1_10007, true)

		table = var_8

		var_8.insert(arg_11_0._subTabList, var_1_10007)

		table = var_8

		local var_11_0 = var_8.insert
		local var_11_1 = arg_11_0._subTabAnims
		local var_11_2 = var_1_10007:Find("select_state")
		local var_11_3 = var_10.GetComponent

		typeof = var_12
		Animation = var_1_10013

		var_11_0(var_11_1, var_11_3(var_11_2, var_12(var_1_10013)))

		setScrollText = var_11_0

		var_11_0(var_1_10007:Find("common_state/mask/Text"), iter_11_1.btnTitle)

		setScrollText = var_11_0

		var_11_0(var_1_10007:Find("select_state/mask/Text"), iter_11_1.btnTitle)

		GetSpriteFromAtlasAsync = var_11_0

		var_11_0("ui/newbulletinboardui_atlas", var_0_1.ICON_NAME[iter_11_1.icon], function(arg_12_0)
			setImageSprite = var_2_10001

			local var_12_0 = var_1_10007

			var_2_10001(var_2.Find(var_12_0, "common_state/icon"), arg_12_0)

			return
		end)

		GetSpriteFromAtlasAsync = var_11_0

		var_11_0("ui/newbulletinboardui_atlas", var_0_1.ICON_NAME[iter_11_1.icon] .. "_selected", function(arg_13_0)
			setImageSprite = var_2_10001

			local var_13_0 = var_1_10007

			var_2_10001(var_2.Find(var_13_0, "select_state/icon"), arg_13_0)

			return
		end)

		onToggle = var_11_0

		local var_11_4 = arg_11_0
		local var_11_5 = var_1_10007

		local function var_11_6(arg_14_0)
			if arg_14_0 then
				setActive = var_2_10001

				local var_14_0 = var_1_10007

				var_2_10001(var_2.Find(var_14_0, "select_state"), true)

				if arg_11_0.currentSubTab and arg_11_0.currentSubTab == iter_11_0 then
					return
				end

				if arg_11_0.currentSubTab then
					local var_14_1 = arg_11_0.currentSubTab
					local var_14_2 = arg_11_0._subTabAnims[iter_11_0]

					var_2.Play(var_14_2, var_14_1 > iter_11_0 and "anim_BB_lefttitle_B_in" or "anim_BB_lefttitle_T_in")

					local var_14_3 = arg_11_0._subTabAnims[var_14_1]

					var_2.Play(var_14_3, var_14_1 > iter_11_0 and "anim_BB_lefttitle_T_out" or "anim_BB_lefttitle_B_out")

					local var_14_4 = arg_11_0

					LeanTween = var_14_3

					local var_14_5 = var_14_3.delayedCall
					local var_14_6 = 0.26

					System = var_2_10005
					var_14_4.subTabLT = var_14_5(var_14_6, var_2_10005.Action(function()
						setActive = var_3_10000

						local var_15_0 = arg_11_0._subTabList[var_14_1]

						var_3_10000(var_1.Find(var_15_0, "select_state"), false)

						return
					end)).uniqueId

					local var_14_7 = arg_11_0._contentAnim

					var_2.Play(var_14_7, var_14_1 > iter_11_0 and "anim_BB_view_B_in" or "anim_BB_view_T_in")
				end

				local var_14_8 = arg_11_0

				var_14_8.currentSubTab = iter_11_0
				PlayerPrefs = var_14_8

				var_14_8.SetInt(arg_11_0._noticeDic[arg_11_0.currentMainTab][iter_11_0].code, 0)

				local var_14_9 = arg_11_0

				var_1.updateRed(var_14_9)

				local var_14_10 = arg_11_0

				var_1.setNoticeDetail(var_14_10, iter_11_1)
			end

			return
		end

		SFX_PANEL = var_12

		var_11_0(var_11_4, var_11_5, var_11_6, var_12)
	end

	local var_11_7

	if not arg_11_0.defaultSubTab then
		var_11_7 = 1
	end

	arg_11_0.defaultSubTab = var_11_7
	triggerToggle = var_11_7

	var_11_7(arg_11_0._subTabList[arg_11_0.defaultSubTab], true)

	return
end

function var_0_1.setImage(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_4:Find("img")
	local var_16_1 = var_5.GetComponent

	typeof = var_7
	Image = var_1_10008

	local var_16_2 = var_16_1(var_16_0, var_7(var_1_10008))
	local var_16_3 = arg_16_4
	local var_16_4 = arg_16_4.Find(var_16_3, "loading")

	Color = var_16_3
	var_16_2.color = var_16_3.New(0, 0, 0, 0.4)
	setActive = var_7

	var_7(var_16_4, true)

	local var_16_5 = arg_16_0._loadingFlag

	var_16_5[arg_16_3] = true
	BulletinBoardMgr = var_16_5

	local var_16_6 = var_16_5.Inst
	local var_16_7 = var_7.GetSprite
	local var_16_8 = arg_16_1
	local var_16_9 = arg_16_2
	local var_16_10 = arg_16_3

	UnityEngine = var_1_10012

	var_16_7(var_16_6, var_16_8, var_16_9, var_16_10, var_1_10012.Events.UnityAction_UnityEngine_Sprite(function(arg_17_0)
		if arg_16_0._loadingFlag == nil then
			return
		end

		local var_17_0 = arg_16_0._loadingFlag

		var_17_0[arg_16_3] = nil

		if arg_17_0 ~= nil then
			IsNil = var_17_0

			if not var_17_0(arg_16_4) then
				setImageSprite = var_1

				var_1(var_16_2, arg_17_0, false)

				local var_17_1 = var_16_2

				Color = var_2
				var_17_1.color = var_2.New(1, 1, 1)
				setActive = var_17_1

				var_17_1(var_16_4, false)
			end
		end

		return
	end))

	return
end

function var_0_1.setNoticeDetail(arg_18_0, arg_18_1)
	local function var_18_0(arg_19_0)
		cloneTplTo = var_2_10001

		local var_19_0 = var_2_10001(arg_18_0._contentBannerTpl, arg_18_0._contentContainer)

		table = var_2

		var_2.insert(arg_18_0._contentList, var_19_0)

		local var_19_1 = arg_18_0

		var_2.setImage(var_19_1, arg_18_1.id, arg_18_1.version, arg_19_0, var_19_0, true, nil)

		return
	end

	local function var_18_1(arg_20_0)
		cloneTplTo = var_2_10001

		local var_20_0 = var_2_10001(arg_18_0._contentTxtTpl, arg_18_0._contentContainer)

		table = var_2

		var_2.insert(arg_18_0._contentList, var_20_0)

		setText = var_2

		local var_20_1 = var_20_0

		SwitchSpecialChar = var_4

		var_2(var_20_1, var_4(arg_20_0, true))

		local var_20_2 = var_20_0:GetComponent("RichText")

		var_2.AddListener(var_20_2, function(arg_21_0, arg_21_1)
			if arg_21_0 == "url" then
				Application = var_3_10002

				var_3_10002.OpenURL(arg_21_1)
			end

			return
		end)

		return
	end

	arg_18_0:clearLoadingPic()
	arg_18_0:clearLeanTween()
	arg_18_0:clearContent()

	local var_18_2

	if arg_18_1.paramType then
		setActive = var_18_2

		var_18_2(arg_18_0._detailTitle, false)

		setActive = var_18_2

		var_18_2(arg_18_0._detailLine, false)

		setActive = var_18_2

		var_18_2(arg_18_0._contentContainer, false)

		setActive = var_18_2

		var_18_2(arg_18_0._bottom, false)

		var_18_2 = arg_18_0._detailTitleImgLayoutElement
		var_18_2.preferredHeight = var_0_1.TITLE_IMAGE_HEIGHT_FULL

		arg_18_0:setImage(arg_18_1.id, arg_18_1.version, arg_18_1.titleImage, arg_18_0._detailTitleImg)

		onButton = var_18_2

		local var_18_3 = arg_18_0
		local var_18_4 = arg_18_0._detailTitleImg

		local function var_18_5()
			if arg_18_1.paramType == 1 then
				Application = var_0

				var_0.OpenURL(arg_18_1.param)

				local var_22_0 = arg_18_0
				local var_22_1 = var_0.emit

				NewBulletinBoardMediator = var_2_10002

				var_22_1(var_22_0, var_2_10002.TRACK_OPEN_URL, arg_18_1.track)
			elseif arg_18_1.paramType == 2 then
				local var_22_2 = arg_18_0
				local var_22_3 = var_0.emit

				NewBulletinBoardMediator = var_2_10002

				var_22_3(var_22_2, var_2_10002.GO_SCENE, arg_18_1.param)
			elseif arg_18_1.paramType == 3 then
				local var_22_4 = arg_18_0
				local var_22_5 = var_0.emit

				NewBulletinBoardMediator = var_2_10002

				local var_22_6 = var_2_10002.GO_SCENE

				SCENE = var_2_10003

				var_22_5(var_22_4, var_22_6, var_2_10003.ACTIVITY, {
					id = arg_18_1.param
				})
			elseif arg_18_1.paramType == 4 then
				pg = var_0

				local var_22_7 = var_0.activity_banner_notice[arg_18_1.param].param
				local var_22_8 = arg_18_0
				local var_22_9 = var_1.emit

				NewBulletinBoardMediator = var_2_10003

				var_22_9(var_22_8, var_2_10003.GO_SCENE, var_22_7[1], var_22_7[2])
			elseif arg_18_1.paramType == 5 then
				pg = var_0

				local var_22_10 = var_0.NewStoryMgr.GetInstance()
				local var_22_13

				if not var_0.IsPlayed(var_22_10, "JIARIBIESHUCHOUBEIZHONG5") then
					local var_22_11 = arg_18_0
					local var_22_12 = var_0.emit

					NewBulletinBoardMediator = var_22_13
					var_22_13 = var_22_13.GO_SCENE
					SCENE = var_2_10003

					var_22_12(var_22_11, var_22_13, var_2_10003.ACTIVITY, {
						id = 5922
					})
				else
					local var_22_14 = arg_18_0
					local var_22_15 = var_0.emit

					NewBulletinBoardMediator = var_22_13

					local var_22_16 = var_22_13.GO_SCENE

					SCENE = var_2_10003

					var_22_15(var_22_14, var_22_16, var_2_10003.HOLIDAY_VILLA_MAP)
				end
			end

			arg_18_0.contextData.defaultMainTab = arg_18_0.currentMainTab
			arg_18_0.contextData.defaultSubTab = arg_18_0.currentSubTab

			return
		end

		SFX_PANEL = var_8

		var_18_2(var_18_3, var_18_4, var_18_5, var_8)
	else
		setActive = var_18_2

		var_18_2(arg_18_0._detailTitle, true)

		setActive = var_18_2

		var_18_2(arg_18_0._detailLine, true)

		setActive = var_18_2

		var_18_2(arg_18_0._contentContainer, true)

		setActive = var_18_2

		var_18_2(arg_18_0._bottom, true)

		setScrollText = var_18_2

		var_18_2(arg_18_0._detailTitleTxt, arg_18_1.pageTitle)

		setText = var_18_2

		var_18_2(arg_18_0._detailTimeTxt, arg_18_1.timeDes)

		arg_18_0._detailTitleImgLayoutElement.preferredHeight = var_0_1.TITLE_IMAGE_HEIGHT_DEFAULT

		arg_18_0:setImage(arg_18_1.id, arg_18_1.version, arg_18_1.titleImage, arg_18_0._detailTitleImg)

		removeOnButton = var_4

		var_4(arg_18_0._detailTitleImg)

		local function var_18_6(arg_23_0)
			local var_23_0 = #arg_23_0

			if #arg_23_0 == 0 then
				return ""
			end

			string = var_2

			local var_23_1, var_23_2 = var_2.find(arg_23_0, "^[ ]*\n")

			var_23_2 = var_23_2 or 0
			string = var_4

			local var_23_3

			if not var_4.find(arg_23_0, "\n[ ]*$") then
				var_23_3 = var_23_0 + 1
			end

			string = var_5

			return var_5.sub(arg_23_0, var_23_2 + 1, var_23_3 - 1)
		end

		local function var_18_7(arg_24_0)
			_ = var_2_10001

			local var_24_0 = var_2_10001.each

			string = var_2_10002

			var_24_0(var_2_10002.split(arg_24_0, "<segment/>"), function(arg_25_0)
				if #var_18_6(arg_25_0) > 0 then
					table = var_2

					var_2.insert(arg_18_0._contentInfo, {
						type = var_0_1.CONTENT_TYPE.RICHTEXT,
						text = var_1
					})
				end

				return
			end)

			return
		end

		arg_18_0._contentInfo = {}

		local var_18_8 = 1

		string = var_7

		for iter_18_0 in var_7.gmatch(arg_18_1.content, "<banner>%S-</banner>") do
			string = var_1_10011

			local var_18_9

			var_1_10011, var_18_9 = var_1_10011.find(iter_18_0, "<banner>")
			string = var_13

			local var_18_10, var_18_11 = var_13.find(iter_18_0, "</banner>")

			string = var_15

			local var_18_12 = var_15.sub(iter_18_0, var_18_9 + 1, var_18_10 - 1)

			string = var_16

			local var_18_13, var_18_14 = var_16.find(arg_18_1.content, iter_18_0, var_18_8, true)
			local var_18_15

			if var_18_13 ~= nil then
				var_18_15 = var_18_6
				string = var_19

				if #var_18_15(var_19.sub(arg_18_1.content, var_18_8, var_18_13 - 1)) > 0 then
					var_18_7(var_18_15)
				end
			end

			table = var_18_15

			var_18_15.insert(arg_18_0._contentInfo, {
				type = var_0_1.CONTENT_TYPE.BANNER,
				text = var_18_12
			})

			var_18_8 = var_18_14 + 1
		end

		local var_18_16

		if var_18_8 < #arg_18_1.content then
			var_18_16 = var_18_7
			string = var_8

			var_18_16(var_8.sub(arg_18_1.content, var_18_8, #arg_18_1.content))
		end

		pairs = var_18_16

		for iter_18_1, iter_18_2 in var_18_16(arg_18_0._contentInfo) do
			if iter_18_2.type == var_0_1.CONTENT_TYPE.RICHTEXT then
				var_18_1(iter_18_2.text)
			elseif iter_18_2.type == var_0_1.CONTENT_TYPE.BANNER then
				var_18_0(iter_18_2.text)
			end
		end

		arg_18_0:bannerRotate()
	end

	return
end

function var_0_1.bannerRotate(arg_26_0)
	pairs = var_1_10001

	for iter_26_0, iter_26_1 in var_1_10001(arg_26_0._contentList) do
		local var_26_0 = iter_26_1

		if iter_26_1.Find(var_26_0, "loading/Image") then
			table = var_26_0

			local var_26_1 = var_26_0.insert
			local var_26_2 = arg_26_0.LTList

			LeanTween = var_1_10009
			var_1_10009 = var_1_10009.rotateAroundLocal
			rtf = var_1_10010
			var_1_10010 = var_1_10010(var_6)
			Vector3 = var_11
			var_1_10010 = var_1_10009(var_1_10010, var_11(0, 0, -1), 360, 5)

			var_26_1(var_26_2, var_1_10009.setLoopClamp(var_1_10010).uniqueId)
		end
	end

	return
end

function var_0_1.clearLeanTween(arg_27_0)
	pairs = var_1_10001

	local var_27_0

	if not arg_27_0.LTList then
		var_27_0 = {}
	end

	for iter_27_0, iter_27_1 in var_1_10001(var_27_0) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_27_1)
	end

	return
end

function var_0_1.clearContent(arg_28_0)
	pairs = var_1_10001

	for iter_28_0, iter_28_1 in var_1_10001(arg_28_0._contentList) do
		Destroy = var_1_10006

		var_1_10006(iter_28_1)
	end

	arg_28_0._contentList = {}

	return
end

function var_0_1.clearTab(arg_29_0)
	if arg_29_0.subTabLT then
		LeanTween = var_1

		var_1.cancel(arg_29_0.subTabLT)

		arg_29_0.subTabLT = nil
	end

	arg_29_0.currentSubTab = nil
	pairs = var_1

	for iter_29_0, iter_29_1 in var_1(arg_29_0._subTabList) do
		Destroy = var_1_10006

		var_1_10006(iter_29_1)
	end

	arg_29_0._subTabList = {}
	arg_29_0._subTabAnims = {}

	return
end

function var_0_1.clearLoadingPic(arg_30_0)
	pairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0._loadingFlag) do
		BulletinBoardMgr = var_1_10006

		local var_30_0 = var_1_10006.Inst

		var_1_10006.StopLoader(var_30_0, iter_30_0)

		var_1_10006 = arg_30_0._loadingFlag
		var_1_10006[iter_30_0] = nil
	end

	return
end

function var_0_1.willExit(arg_31_0)
	arg_31_0:clearLoadingPic()

	pg = var_1

	local var_31_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_31_0, arg_31_0._tf)

	return
end

return var_0_1
