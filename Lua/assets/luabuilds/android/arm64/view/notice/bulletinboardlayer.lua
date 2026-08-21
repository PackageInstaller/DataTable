local var_0_0 = class("BulletinBoardLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "BulletinBoardUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0._closeBtn = arg_2_0._tf:Find("close_btn")
	arg_2_0._tabGroup = arg_2_0._tf:Find("title_list/viewport/content"):GetComponent(typeof(ToggleGroup))
	arg_2_0._tabContainer = arg_2_0._tf:Find("title_list/viewport/content")
	arg_2_0._tabTpl = arg_2_0._tf:Find("title_list/tab_btn_tpl")

	SetActive(arg_2_0._tabTpl, false)

	arg_2_0._tabList = {}
	arg_2_0._detailTitleImg = arg_2_0._tf:Find("content_view/viewport/content/title_img/img")
	arg_2_0._detailTitleImgComp = arg_2_0._detailTitleImg:GetComponent(typeof(Image))
	arg_2_0._detailTitleLoading = arg_2_0._tf:Find("content_view/viewport/content/title_img/loading")
	arg_2_0._detailTitleTxt = arg_2_0._tf:Find("content_view/viewport/content/title_txt")
	arg_2_0._detailTimeTxt = arg_2_0._tf:Find("content_view/viewport/content/time_txt")
	arg_2_0._detailContentTxt = arg_2_0._tf:Find("content_view/viewport/content/content_txt")
	arg_2_0._detailContentTxtComp = arg_2_0._detailContentTxt:GetComponent("RichText")

	arg_2_0._detailContentTxtComp:AddListener(function(arg_3_0, arg_3_1)
		if arg_3_0 == "url" then
			Application.OpenURL(arg_3_1)
		end

		return
	end)

	arg_2_0._scrollRect = arg_2_0._tf:Find("content_view"):GetComponent(typeof(ScrollRect))
	arg_2_0._stopRemind = arg_2_0._tf:Find("dontshow_tab")

	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	arg_2_0._loadingFlag = {}

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0._closeBtn, function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end, SOUND_BACK)
	onToggle(arg_4_0, arg_4_0._stopRemind, function(arg_6_0)
		arg_4_0:emit(BulletinBoardMediator.SET_STOP_REMIND, arg_6_0)

		return
	end)
	triggerToggle(arg_4_0._stopRemind, (getProxy(ServerNoticeProxy):getStopRemind()))

	return
end

function var_0_0.setNotices(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		table.insert({}, tostring(iter_7_1.id))
		table.insert({}, iter_7_1.version)

		local var_7_0 = cloneTplTo(arg_7_0._tabTpl, arg_7_0._tabContainer)

		setScrollText(var_7_0:Find("common_state/title_mask/title_txt"), iter_7_1.btnTitle)
		setScrollText(var_7_0:Find("select_state/title_mask/title_txt"), iter_7_1.btnTitle)
		changeToScrollText(var_7_0:Find("common_state/time_txt"), iter_7_1.title)
		changeToScrollText(var_7_0:Find("select_state/time_txt"), iter_7_1.title)
		table.insert(arg_7_0._tabList, var_7_0)
		SetActive(var_7_0, true)

		GetComponent(var_7_0, typeof(Toggle)).group = arg_7_0._tabGroup

		onToggle(arg_7_0, var_7_0, function(arg_8_0)
			if arg_8_0 then
				arg_7_0:setNoticeDetail(iter_7_1)
			end

			setActive(var_7_0:Find("common_state"), not arg_8_0)

			return
		end, SFX_PANEL)
	end

	triggerToggle(arg_7_0._tabList[1], true)
	BulletinBoardMgr.Inst:ClearCache({}, {})

	return
end

function var_0_0.setNoticeDetail(arg_9_0, arg_9_1)
	arg_9_0:clearLoadingPic()
	setText(arg_9_0._detailTitleTxt, arg_9_1.pageTitle)
	setText(arg_9_0._detailTimeTxt, arg_9_1.timeDes)

	arg_9_0._detailTitleImgComp.color = Color.New(0, 0, 0, 0.4)

	setActive(arg_9_0._detailTitleLoading, true)

	arg_9_0._loadingFlag[arg_9_1.titleImage] = true

	BulletinBoardMgr.Inst:GetSprite(arg_9_1.id, arg_9_1.version, arg_9_1.titleImage, UnityEngine.Events.UnityAction_UnityEngine_Sprite(function(arg_10_0)
		arg_9_0._loadingFlag[arg_9_1.titleImage] = nil

		if arg_10_0 ~= nil then
			setImageSprite(arg_9_0._detailTitleImg, arg_10_0, false)

			arg_9_0._detailTitleImgComp.color = Color.New(1, 1, 1, 1)

			setActive(arg_9_0._detailTitleLoading, false)
		end

		return
	end))

	arg_9_0.tempContent = arg_9_1.content
	arg_9_0.realContent = arg_9_1.content
	arg_9_0.loadingCount = 0
	arg_9_0.loadPic = {}

	for iter_9_0 in string.gmatch(arg_9_1.content, "<imgHref>%S-</imgHref>") do
		local var_9_0, var_9_1 = string.find(iter_9_0, "<imgHref>")
		local var_9_2, var_9_3 = string.find(iter_9_0, "</imgHref>")
		local var_9_4 = string.sub(iter_9_0, var_9_1 + 1, var_9_2 - 1)
		local var_9_5 = string.gsub(string.gsub(string.gsub(iter_9_0, "%.", "%%."), "%-", "%%-"), "%?", "%%?")

		arg_9_0.realContent = string.gsub(arg_9_0.realContent, var_9_5, "<icon name=" .. var_9_4 .. " w=2 h=2/>")
		arg_9_0.tempContent = string.gsub(arg_9_0.tempContent, var_9_5, "")

		table.insert(arg_9_0.loadPic, var_9_4)
	end

	setText(arg_9_0._detailContentTxt, (SwitchSpecialChar(arg_9_0.tempContent, true)))

	arg_9_0.loadingCount = #arg_9_0.loadPic

	for iter_9_1, iter_9_2 in ipairs(arg_9_0.loadPic) do
		arg_9_0._loadingFlag[iter_9_2] = true

		BulletinBoardMgr.Inst:GetSprite(arg_9_1.id, arg_9_1.version, iter_9_2, UnityEngine.Events.UnityAction_UnityEngine_Sprite(function(arg_11_0)
			arg_9_0._loadingFlag[iter_9_2] = nil

			if arg_11_0 ~= nil then
				arg_9_0.loadingCount = arg_9_0.loadingCount - 1

				arg_9_0._detailContentTxtComp:AddSprite(arg_11_0.name, arg_11_0)

				if arg_9_0.loadingCount <= 0 then
					setText(arg_9_0._detailContentTxt, SwitchSpecialChar(arg_9_0.realContent, true))
				end
			end

			return
		end))
	end

	return
end

function var_0_0.clearLoadingPic(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._loadingFlag) do
		BulletinBoardMgr.Inst:StopLoader(iter_12_0)

		arg_12_0._loadingFlag[iter_12_0] = nil
	end

	return
end

function var_0_0.willExit(arg_13_0)
	arg_13_0:clearLoadingPic()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_13_0._tf)

	return
end

return var_0_0
