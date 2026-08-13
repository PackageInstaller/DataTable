class = var_0_10000

local var_0_0 = "BackYardThemeTemplateDescPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = {
	{
		"text_desc",
		"text_allin"
	},
	{
		"text_delete",
		"text_upload",
		"text_cancel_upload"
	},
	{
		"text_desc",
		"text_allin"
	}
}

local function var_0_6(arg_1_0)
	return var_0_5[arg_1_0]
end

function var_0_1.getUIName(arg_2_0)
	return "BackYardThemeTemplateDescPage"
end

function var_0_1.ThemeTemplateUpdate(arg_3_0, arg_3_1)
	if arg_3_0.template and arg_3_0.template.id == arg_3_1.id then
		arg_3_0.template = arg_3_1

		arg_3_0:Flush()
	end

	return
end

function var_0_1.UpdateDorm(arg_4_0, arg_4_1)
	arg_4_0.dorm = arg_4_1

	return
end

function var_0_1.PlayerUpdated(arg_5_0, arg_5_1)
	arg_5_0.player = arg_5_1

	return
end

function var_0_1.OnLoaded(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.adpter = var_1.Find(var_6_0, "adpter")

	local var_6_1 = arg_6_0._tf

	arg_6_0.frame = var_1.Find(var_6_1, "adpter/frame")

	local var_6_2 = arg_6_0._tf
	local var_6_3 = var_1.Find(var_6_2, "adpter/frame/icon")
	local var_6_4 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_6_0.icon = var_6_4(var_6_3, var_3(var_1_10004))

	local var_6_5 = arg_6_0._tf
	local var_6_6 = var_1.Find(var_6_5, "adpter/frame/ID")
	local var_6_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.idTxt = var_6_7(var_6_6, var_3(var_1_10004))

	local var_6_8 = arg_6_0._tf
	local var_6_9 = var_1.Find(var_6_8, "adpter/frame/ID_label")
	local var_6_10 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.idLabel = var_6_10(var_6_9, var_3(var_1_10004))

	local var_6_11 = arg_6_0._tf

	arg_6_0.copyBtn = var_1.Find(var_6_11, "adpter/frame/copy")

	local var_6_12 = arg_6_0._tf
	local var_6_13 = var_1.Find(var_6_12, "adpter/frame/name")
	local var_6_14 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.nameTxt = var_6_14(var_6_13, var_3(var_1_10004))

	local var_6_15 = arg_6_0._tf

	arg_6_0.mainPanel = var_1.Find(var_6_15, "adpter/frame/main")

	local var_6_16 = arg_6_0.mainPanel
	local var_6_17 = var_1.Find(var_6_16, "time")
	local var_6_18 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.timeTxt = var_6_18(var_6_17, var_3(var_1_10004))

	local var_6_19 = arg_6_0.mainPanel

	arg_6_0.btn1 = var_1.Find(var_6_19, "desc_btn")

	local var_6_20 = arg_6_0.mainPanel
	local var_6_21 = var_1.Find(var_6_20, "desc_btn/Text")
	local var_6_22 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.btn1Txt = var_6_22(var_6_21, var_3(var_1_10004))

	local var_6_23 = arg_6_0.mainPanel

	arg_6_0.btn2 = var_1.Find(var_6_23, "push_btn")

	local var_6_24 = arg_6_0.mainPanel
	local var_6_25 = var_1.Find(var_6_24, "push_btn/Text")
	local var_6_26 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.btn2Txt = var_6_26(var_6_25, var_3(var_1_10004))

	local var_6_27 = arg_6_0.mainPanel

	arg_6_0.heart = var_1.Find(var_6_27, "heart")

	local var_6_28 = arg_6_0.mainPanel

	arg_6_0.heartSel = var_1.Find(var_6_28, "heart/sel")

	local var_6_29 = arg_6_0.mainPanel
	local var_6_30 = var_1.Find(var_6_29, "heart/Text")
	local var_6_31 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.heartTxt = var_6_31(var_6_30, var_3(var_1_10004))

	local var_6_32 = arg_6_0.mainPanel

	arg_6_0.collection = var_1.Find(var_6_32, "collection")

	local var_6_33 = arg_6_0.mainPanel

	arg_6_0.collectionSel = var_1.Find(var_6_33, "collection/sel")

	local var_6_34 = arg_6_0.mainPanel
	local var_6_35 = var_1.Find(var_6_34, "collection/Text")
	local var_6_36 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.collectionTxt = var_6_36(var_6_35, var_3(var_1_10004))

	local var_6_37 = arg_6_0.idLabel

	i18n = var_6_35
	var_6_37.text = var_6_35("word_theme") .. "ID:"

	return
end

function var_0_1.OnInit(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.copyBtn

	local function var_7_2()
		if arg_7_0.player then
			UniPasteBoard = var_0

			var_0.SetClipBoardString(arg_7_0.template.id)

			pg = var_0

			local var_8_0 = var_0.TipsMgr.GetInstance()
			local var_8_1 = var_0.ShowTips

			i18n = var_2_10002

			var_8_1(var_8_0, var_2_10002("friend_id_copy_ok"))
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	return
end

function var_0_1.SetUp(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0.pageType = arg_9_1
	arg_9_0.template = arg_9_2
	arg_9_0.dorm = arg_9_3
	arg_9_0.player = arg_9_4

	arg_9_0:RefreshSortBtn()
	arg_9_0:Flush()
	arg_9_0:Show()

	return
end

function var_0_1.RefreshSortBtn(arg_10_0)
	local var_10_0
	local var_10_1
	local var_10_2 = arg_10_0.pageType

	BackYardConst = var_1_10004

	if var_10_2 == var_1_10004.THEME_TEMPLATE_TYPE_CUSTOM then
		BackYardConst = var_10_2

		local var_10_3 = var_10_2.ServerIndex2ThemeSortIndex

		getProxy = var_4
		DormProxy = var_1_10005

		local var_10_4

		var_10_4, var_10_1 = var_10_3(var_4(var_1_10005).TYPE)
	else
		local var_10_5

		var_10_5, var_10_1 = 1, true
	end

	arg_10_0.sortFlag = var_10_1

	return
end

function var_0_1.Flush(arg_11_0)
	arg_11_0:UpdateWindow()
	arg_11_0:UpdatePlayer()
	arg_11_0:UpdateLikeInfo()
	arg_11_0["Update" .. arg_11_0.pageType](arg_11_0)

	return
end

function var_0_1.Update1(arg_12_0)
	onButton = var_1_10001

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.btn1

	local function var_12_2()
		local var_13_0 = arg_12_0.contextData.infoPage

		var_0.ExecuteAction(var_13_0, "SetUp", arg_12_0.template, arg_12_0.dorm, arg_12_0.player)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_12_0, var_12_1, var_12_2, var_1_10005)

	onButton = var_1_10001

	local var_12_3 = arg_12_0
	local var_12_4 = arg_12_0.btn2

	local function var_12_5()
		local var_14_0 = arg_12_0.contextData.msgBox
		local var_14_1 = var_0.ExecuteAction
		local var_14_2 = "SetUp"
		local var_14_3 = {}

		BackYardThemeTemplateMsgBox = var_2_10004
		var_14_3.type = var_2_10004.TYPE_IMAGE
		i18n = var_4
		var_14_3.content = var_4("backyard_theme_apply_tip2")

		local var_14_4 = arg_12_0.template

		var_14_3.srpiteName = var_4.GetTextureIconName(var_14_4)

		local var_14_5 = arg_12_0.template

		var_14_3.md5 = var_4.GetIconMd5(var_14_5)

		function var_14_3.onYes()
			local var_15_0 = arg_12_0
			local var_15_1 = var_0.emit

			NewBackYardThemeTemplateMediator = var_3_10002

			var_15_1(var_15_0, var_3_10002.ON_APPLY_TEMPLATE, arg_12_0.template, function()
				triggerButton = var_4_10000

				var_4_10000(arg_12_0.btn1)

				return
			end)

			return
		end

		var_14_1(var_14_0, var_14_2, var_14_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_12_3, var_12_4, var_12_5, var_1_10005)

	local var_12_6 = arg_12_0.btn1Txt

	i18n = var_12_3
	var_12_6.text = var_12_3("courtyard_label_detail")

	local var_12_7 = arg_12_0.btn2Txt

	i18n = var_2
	var_12_7.text = var_2("courtyard_label_place_pnekey")

	return
end

function var_0_1.Update2(arg_17_0)
	local var_17_0 = arg_17_0.template
	local var_17_1 = var_1.IsPushed(var_17_0)

	onButton = var_17_0

	local var_17_2 = arg_17_0
	local var_17_3 = arg_17_0.btn1

	local function var_17_4()
		local var_18_0 = arg_17_0
		local var_18_1 = var_0.emit

		NewBackYardThemeTemplateMediator = var_2_10002

		var_18_1(var_18_0, var_2_10002.ON_DELETE_TEMPLATE, var_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_17_0(var_17_2, var_17_3, var_17_4, var_1_10007)

	onButton = var_17_0

	local var_17_5 = arg_17_0
	local var_17_6 = arg_17_0.btn2

	local function var_17_7()
		if var_17_1 then
			local var_19_0 = arg_17_0
			local var_19_1 = var_0.emit

			NewBackYardThemeTemplateMediator = var_2_10002

			var_19_1(var_19_0, var_2_10002.ON_CANCEL_UPLOAD_TEMPLATE, var_0)
		else
			local var_19_2 = arg_17_0
			local var_19_3 = var_0.emit

			NewBackYardThemeTemplateMediator = var_2_10002

			var_19_3(var_19_2, var_2_10002.ON_UPLOAD_TEMPLATE, var_0)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_17_0(var_17_5, var_17_6, var_17_7, var_1_10007)

	if not var_17_1 then
		getProxy = var_17_0
		DormProxy = var_17_5
		var_17_5 = var_17_0(var_17_5)

		local var_17_8 = var_3.GetUploadThemeTemplateCnt(var_17_5)

		var_17_5 = arg_17_0.timeTxt
		i18n = var_17_6

		local var_17_9 = "backyard_theme_upload_cnt"
		local var_17_10 = var_17_8

		BackYardConst = var_1_10008
		var_17_5.text = var_17_6(var_17_9, var_17_10, var_1_10008.MAX_UPLOAD_THEME_CNT)
	end

	local var_17_11 = arg_17_0.btn1Txt

	i18n = var_17_5
	var_17_11.text = var_17_5("courtyard_label_delete")

	local var_17_12 = arg_17_0.btn2Txt

	if var_17_1 then
		i18n = var_17_13

		local var_17_13

		if not var_17_13("courtyard_label_cancel_share") then
			i18n = var_17_13
			var_17_13 = var_17_13("courtyard_label_share")
		end

		var_17_12.text = var_17_13

		return
	end
end

function var_0_1.Update3(arg_20_0)
	local var_20_0 = arg_20_0

	arg_20_0.Update1(var_20_0)

	local var_20_1 = arg_20_0.timeTxt

	i18n = var_20_0

	local var_20_2 = var_20_0("backyard_theme_template_collection_cnt")

	getProxy = var_3
	DormProxy = var_1_10004

	local var_20_3 = var_3(var_1_10004)
	local var_20_4 = var_3.GetThemeTemplateCollectionCnt(var_20_3)
	local var_20_5 = "/"

	BackYardConst = var_1_10005
	var_20_1.text = var_20_2 .. var_20_4 .. var_20_5 .. var_1_10005.MAX_COLLECTION_CNT

	local var_20_6 = arg_20_0.btn1Txt

	i18n = var_2
	var_20_6.text = var_2("courtyard_label_detail")

	local var_20_7 = arg_20_0.btn2Txt

	i18n = var_2
	var_20_7.text = var_2("courtyard_label_place_pnekey")

	return
end

function var_0_1.UpdatePlayer(arg_21_0)
	local var_21_0 = arg_21_0.template

	if not var_1.ExistPlayerInfo(var_21_0) then
		local var_21_1 = arg_21_0
		local var_21_2 = arg_21_0.emit

		NewBackYardThemeTemplateMediator = var_1_10003

		var_21_2(var_21_1, var_1_10003.GET_TEMPLATE_PLAYERINFO, arg_21_0.pageType, arg_21_0.template)
	else
		arg_21_0.player = arg_21_0.template.player
		arg_21_0.nameTxt.text = var_1:GetName()
		arg_21_0.idTxt.text = arg_21_0.template.id

		local var_21_3 = arg_21_0.timeTxt

		i18n = var_3

		local var_21_4 = var_3("backyard_theme_upload_time")
		local var_21_5 = arg_21_0.template

		var_21_3.text = var_21_4 .. var_4.GetUploadTime(var_21_5)
		LoadSpriteAsync = var_21_3

		local var_21_6 = "qicon/"
		local var_21_7 = var_1

		var_21_3(var_21_6 .. var_1.getPainting(var_21_7), function(arg_22_0)
			IsNil = var_2_10001

			if var_2_10001(arg_21_0.icon) then
				return
			end

			arg_21_0.icon.sprite = arg_22_0

			return
		end)

		local var_21_8

		if arg_21_0.preLoadIcon then
			var_21_8 = arg_21_0.preLoadIcon.name
			PoolMgr = var_3

			local var_21_9 = var_3.GetInstance()

			var_3.ReturnPrefab(var_21_9, "IconFrame/" .. var_21_8, var_21_8, arg_21_0.preLoadIcon)
		end

		AttireFrame = var_21_8

		local var_21_10 = var_21_8.attireFrameRes
		local var_21_11 = var_1
		local var_21_12 = var_1.id

		getProxy = var_21_7
		PlayerProxy = var_1_10006

		local var_21_13 = var_21_7(var_1_10006)
		local var_21_14 = var_21_12 == var_5.getRawData(var_21_13).id

		AttireConst = var_5

		local var_21_15 = var_21_10(var_21_11, var_21_14, var_5.TYPE_ICON_FRAME, var_1.propose)

		PoolMgr = var_21_11

		local var_21_16 = var_21_11.GetInstance()

		var_3.GetPrefab(var_21_16, "IconFrame/" .. var_21_15, var_21_15, true, function(arg_23_0)
			if arg_21_0.icon then
				arg_23_0.name = var_21_15
				findTF = var_1

				local var_23_0 = var_1(arg_23_0.transform, "icon")
				local var_23_1 = var_1.GetComponent

				typeof = var_2_10004
				Image = var_2_10005
				var_23_1(var_23_0, var_2_10004(var_2_10005)).raycastTarget = false
				setParent = var_3

				var_3(arg_23_0, arg_21_0.icon.gameObject, false)

				arg_21_0.preLoadIcon = arg_23_0
			end

			return
		end)

		onButton = var_3

		local var_21_17 = arg_21_0
		local var_21_18 = arg_21_0.icon

		local function var_21_19()
			local var_24_0 = var_0.id

			getProxy = var_2_10001
			PlayerProxy = var_2_10002

			local var_24_1 = var_2_10001(var_2_10002)

			if var_24_0 == var_1.getRawData(var_24_1).id then
				return
			end

			tf = var_24_0

			local var_24_2 = var_24_0(arg_21_0.icon.gameObject).position
			local var_24_3 = arg_21_0.template
			local var_24_4 = var_1.GetName(var_24_3)
			local var_24_5 = arg_21_0
			local var_24_6 = var_2.emit

			NewBackYardThemeTemplateMediator = var_2_10004

			var_24_6(var_24_5, var_2_10004.ON_DISPLAY_PLAYER_INFO, var_0.id, var_24_2, arg_21_0.template.id)

			return
		end

		SFX_PANEL = var_7

		var_3(var_21_17, var_21_18, var_21_19, var_7)
	end

	return
end

function var_0_1.UpdateLikeInfo(arg_25_0)
	local var_25_0 = arg_25_0.template
	local var_25_1 = arg_25_0.heartTxt

	i18n = var_1_10003
	var_25_1.text = var_1_10003("backyard_theme_word_like") .. var_25_0:GetLikeCnt()

	local var_25_2 = arg_25_0.collectionTxt

	i18n = var_3
	var_25_2.text = var_3("backyard_theme_word_collection") .. var_25_0:GetCollectionCnt()

	local var_25_3 = arg_25_0.pageType

	BackYardConst = var_3

	local var_25_4 = var_25_3 == var_3.THEME_TEMPLATE_TYPE_CUSTOM
	local var_25_5 = var_25_0
	local var_25_6 = var_25_0.IsLiked(var_25_5)

	onButton = var_25_5

	local var_25_7 = arg_25_0
	local var_25_8 = arg_25_0.heart

	local function var_25_9()
		local var_26_0 = arg_25_0.pageType

		BackYardConst = var_2_10001

		if var_26_0 == var_2_10001.THEME_TEMPLATE_TYPE_CUSTOM then
			return
		end

		if not var_25_6 then
			local var_26_1 = arg_25_0
			local var_26_2 = var_0.emit

			NewBackYardThemeTemplateMediator = var_2_10002

			var_26_2(var_26_1, var_2_10002.ON_LIKE_THEME, arg_25_0.template, arg_25_0.template.time)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_25_5(var_25_7, var_25_8, var_25_9, var_1_10008)

	setActive = var_25_5

	var_25_5(arg_25_0.heartSel, var_25_6 or var_25_4)

	local var_25_10 = var_25_0
	local var_25_11 = var_25_0.IsCollected(var_25_10)

	onButton = var_25_10

	local var_25_12 = arg_25_0
	local var_25_13 = arg_25_0.collection

	local function var_25_14()
		local var_27_0 = arg_25_0.pageType

		BackYardConst = var_2_10001

		if var_27_0 == var_2_10001.THEME_TEMPLATE_TYPE_CUSTOM then
			return
		end

		if var_25_11 then
			local var_27_1 = arg_25_0.contextData.msgBox
			local var_27_2 = var_0.ExecuteAction

			var_2_10002 = "SetUp"

			local var_27_3 = {}

			i18n = var_2_10004
			var_27_3.content = var_2_10004("backyard_theme_cancel_collection")

			function var_27_3.onYes()
				local var_28_0 = arg_25_0
				local var_28_1 = var_0.emit

				NewBackYardThemeTemplateMediator = var_3_10002

				var_28_1(var_28_0, var_3_10002.ON_COLECT_THEME, arg_25_0.template, true, arg_25_0.template.time)

				return
			end

			var_27_2(var_27_1, var_2_10002, var_27_3)
		else
			local var_27_4 = arg_25_0
			local var_27_5 = var_0.emit

			NewBackYardThemeTemplateMediator = var_2_10002

			var_27_5(var_27_4, var_2_10002.ON_COLECT_THEME, arg_25_0.template, false, arg_25_0.template.time)
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_25_10(var_25_12, var_25_13, var_25_14, var_1_10009)

	setActive = var_25_10

	var_25_10(arg_25_0.collectionSel, var_25_11 or var_25_4)

	return
end

function var_0_1.UpdateWindow(arg_29_0)
	local var_29_0 = true
	local var_29_1 = arg_29_0.pageType

	BackYardConst = var_1_10003

	if var_29_1 == var_1_10003.THEME_TEMPLATE_TYPE_SHOP then
		var_29_1 = arg_29_0.frame
		Vector2 = var_3
		var_29_1.sizeDelta = var_3(arg_29_0.frame.sizeDelta.x, 456)
	else
		var_29_1 = arg_29_0.pageType
		BackYardConst = var_3

		local var_29_2

		if var_29_1 == var_3.THEME_TEMPLATE_TYPE_CUSTOM then
			var_29_2 = arg_29_0.template

			if var_29_1.IsPushed(var_29_2) then
				var_29_1 = arg_29_0.frame
				Vector2 = var_29_2
				var_29_1.sizeDelta = var_29_2(arg_29_0.frame.sizeDelta.x, 456)
			else
				var_29_0 = false
				var_29_1 = arg_29_0.frame
				Vector2 = var_29_2
				var_29_1.sizeDelta = var_29_2(arg_29_0.frame.sizeDelta.x, 395)
			end
		else
			var_29_1 = arg_29_0.pageType
			BackYardConst = var_29_2

			if var_29_1 == var_29_2.THEME_TEMPLATE_TYPE_COLLECTION then
				var_29_1 = arg_29_0.frame
				Vector2 = var_3
				var_29_1.sizeDelta = var_3(arg_29_0.frame.sizeDelta.x, 456)
			end
		end
	end

	setActive = var_29_1

	var_29_1(arg_29_0.heart, var_29_0)

	setActive = var_29_1

	var_29_1(arg_29_0.collection, var_29_0)

	return
end

function var_0_1.Show(arg_30_0)
	arg_30_0.isShowing = true

	var_0_1.super.Show(arg_30_0)

	pg = var_1

	local var_30_0 = var_1.UIMgr.GetInstance()
	local var_30_1 = var_1.OverlayPanel
	local var_30_2 = arg_30_0.adpter
	local var_30_3 = {
		groupName = "NewBackYardThemeTemplateLayer"
	}
	local var_30_4 = {}
	local var_30_5 = arg_30_0._tf

	var_30_4[1] = var_6.Find(var_30_5, "adpter/frame")
	var_30_3.pbList = var_30_4

	var_30_1(var_30_0, var_30_2, var_30_3)

	return
end

function var_0_1.Hide(arg_31_0)
	arg_31_0.isShowing = false
	pg = var_1

	local var_31_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_31_0, arg_31_0.adpter, arg_31_0._tf)
	var_0_1.super.Hide(arg_31_0)

	return
end

function var_0_1.OnDestroy(arg_32_0)
	if arg_32_0.isShowing then
		var_1_10002 = arg_32_0

		arg_32_0.Hide(var_1_10002)
	end

	if arg_32_0.preLoadIcon then
		local var_32_0 = arg_32_0.preLoadIcon.name

		PoolMgr = var_1_10002

		local var_32_1 = var_1_10002.GetInstance()

		var_2.ReturnPrefab(var_32_1, "IconFrame/" .. var_32_0, var_32_0, arg_32_0.preLoadIcon)
	end

	return
end

return var_0_1
