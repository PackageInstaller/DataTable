local var_0_0 = class("BackYardThemeTemplateDescPage", import("....base.BaseSubView"))
local var_0_4 = {
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

function var_0_0.getUIName(arg_2_0)
	return "BackYardThemeTemplateDescPage"
end

function var_0_0.ThemeTemplateUpdate(arg_3_0, arg_3_1)
	if arg_3_0.template and arg_3_0.template.id == arg_3_1.id then
		arg_3_0.template = arg_3_1

		arg_3_0:Flush()
	end

	return
end

function var_0_0.UpdateDorm(arg_4_0, arg_4_1)
	arg_4_0.dorm = arg_4_1

	return
end

function var_0_0.PlayerUpdated(arg_5_0, arg_5_1)
	arg_5_0.player = arg_5_1

	return
end

function var_0_0.OnLoaded(arg_6_0)
	arg_6_0.adpter = arg_6_0._tf:Find("adpter")
	arg_6_0.frame = arg_6_0._tf:Find("adpter/frame")
	arg_6_0.icon = arg_6_0._tf:Find("adpter/frame/icon"):GetComponent(typeof(Image))
	arg_6_0.idTxt = arg_6_0._tf:Find("adpter/frame/ID"):GetComponent(typeof(Text))
	arg_6_0.idLabel = arg_6_0._tf:Find("adpter/frame/ID_label"):GetComponent(typeof(Text))
	arg_6_0.copyBtn = arg_6_0._tf:Find("adpter/frame/copy")
	arg_6_0.nameTxt = arg_6_0._tf:Find("adpter/frame/name"):GetComponent(typeof(Text))
	arg_6_0.mainPanel = arg_6_0._tf:Find("adpter/frame/main")
	arg_6_0.timeTxt = arg_6_0.mainPanel:Find("time"):GetComponent(typeof(Text))
	arg_6_0.btn1 = arg_6_0.mainPanel:Find("desc_btn")
	arg_6_0.btn1Txt = arg_6_0.mainPanel:Find("desc_btn/Text"):GetComponent(typeof(Text))
	arg_6_0.btn2 = arg_6_0.mainPanel:Find("push_btn")
	arg_6_0.btn2Txt = arg_6_0.mainPanel:Find("push_btn/Text"):GetComponent(typeof(Text))
	arg_6_0.heart = arg_6_0.mainPanel:Find("heart")
	arg_6_0.heartSel = arg_6_0.mainPanel:Find("heart/sel")
	arg_6_0.heartTxt = arg_6_0.mainPanel:Find("heart/Text"):GetComponent(typeof(Text))
	arg_6_0.collection = arg_6_0.mainPanel:Find("collection")
	arg_6_0.collectionSel = arg_6_0.mainPanel:Find("collection/sel")
	arg_6_0.collectionTxt = arg_6_0.mainPanel:Find("collection/Text"):GetComponent(typeof(Text))
	arg_6_0.idLabel.text = i18n("word_theme") .. "ID:"

	return
end

function var_0_0.OnInit(arg_7_0)
	onButton(arg_7_0, arg_7_0.copyBtn, function()
		if arg_7_0.player then
			UniPasteBoard.SetClipBoardString(arg_7_0.template.id)
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_id_copy_ok"))
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetUp(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0.pageType = arg_9_1
	arg_9_0.template = arg_9_2
	arg_9_0.dorm = arg_9_3
	arg_9_0.player = arg_9_4

	arg_9_0:RefreshSortBtn()
	arg_9_0:Flush()
	arg_9_0:Show()

	return
end

function var_0_0.RefreshSortBtn(arg_10_0)
	local var_10_1

	if arg_10_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
		local var_10_2

		var_10_2, var_10_1 = BackYardConst.ServerIndex2ThemeSortIndex(getProxy(DormProxy).TYPE)

		goto label_10_0

		var_10_1 = true
	end

	do
		-- block empty
	end

	::label_10_0::

	arg_10_0.sortFlag = var_10_1

	return
end

function var_0_0.Flush(arg_11_0)
	arg_11_0:UpdateWindow()
	arg_11_0:UpdatePlayer()
	arg_11_0:UpdateLikeInfo()
	arg_11_0["Update" .. arg_11_0.pageType](arg_11_0)

	return
end

function var_0_0.Update1(arg_12_0)
	onButton(arg_12_0, arg_12_0.btn1, function()
		arg_12_0.contextData.infoPage:ExecuteAction("SetUp", arg_12_0.template, arg_12_0.dorm, arg_12_0.player)

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.btn2, function()
		arg_12_0.contextData.msgBox:ExecuteAction("SetUp", {
			type = BackYardThemeTemplateMsgBox.TYPE_IMAGE,
			content = i18n("backyard_theme_apply_tip2"),
			srpiteName = arg_12_0.template:GetTextureIconName(),
			md5 = arg_12_0.template:GetIconMd5(),
			onYes = function()
				arg_12_0:emit(NewBackYardThemeTemplateMediator.ON_APPLY_TEMPLATE, arg_12_0.template, function()
					triggerButton(arg_12_0.btn1)

					return
				end)

				return
			end
		})

		return
	end, SFX_PANEL)

	arg_12_0.btn1Txt.text = i18n("courtyard_label_detail")
	arg_12_0.btn2Txt.text = i18n("courtyard_label_place_pnekey")

	return
end

function var_0_0.Update2(arg_17_0)
	local var_17_0 = arg_17_0.template:IsPushed()

	onButton(arg_17_0, arg_17_0.btn1, function()
		arg_17_0:emit(NewBackYardThemeTemplateMediator.ON_DELETE_TEMPLATE, var_0)

		return
	end, SFX_PANEL)
	onButton(arg_17_0, arg_17_0.btn2, function()
		if var_17_0 then
			arg_17_0:emit(NewBackYardThemeTemplateMediator.ON_CANCEL_UPLOAD_TEMPLATE, var_0)
		else
			arg_17_0:emit(NewBackYardThemeTemplateMediator.ON_UPLOAD_TEMPLATE, var_0)
		end

		return
	end, SFX_PANEL)

	if not var_17_0 then
		arg_17_0.timeTxt.text = i18n("backyard_theme_upload_cnt", getProxy(DormProxy):GetUploadThemeTemplateCnt(), BackYardConst.MAX_UPLOAD_THEME_CNT)
	end

	arg_17_0.btn1Txt.text = i18n("courtyard_label_delete")

	local var_17_1 = arg_17_0.btn2Txt

	var_17_1.text = var_17_0 and i18n("courtyard_label_cancel_share") or i18n("courtyard_label_share")

	return
end

function var_0_0.Update3(arg_20_0)
	arg_20_0:Update1()

	arg_20_0.timeTxt.text = i18n("backyard_theme_template_collection_cnt") .. getProxy(DormProxy):GetThemeTemplateCollectionCnt() .. "/" .. BackYardConst.MAX_COLLECTION_CNT
	arg_20_0.btn1Txt.text = i18n("courtyard_label_detail")
	arg_20_0.btn2Txt.text = i18n("courtyard_label_place_pnekey")

	return
end

function var_0_0.UpdatePlayer(arg_21_0)
	if not arg_21_0.template:ExistPlayerInfo() then
		arg_21_0:emit(NewBackYardThemeTemplateMediator.GET_TEMPLATE_PLAYERINFO, arg_21_0.pageType, arg_21_0.template)
	else
		local var_21_0 = arg_21_0.template.player

		arg_21_0.player = arg_21_0.template.player
		arg_21_0.nameTxt.text = var_21_0:GetName()
		arg_21_0.idTxt.text = arg_21_0.template.id
		arg_21_0.timeTxt.text = i18n("backyard_theme_upload_time") .. arg_21_0.template:GetUploadTime()

		LoadSpriteAsync("qicon/" .. var_21_0:getPainting(), function(arg_22_0)
			if IsNil(arg_21_0.icon) then
				return
			end

			arg_21_0.icon.sprite = arg_22_0

			return
		end)

		local var_21_1

		if arg_21_0.preLoadIcon then
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. arg_21_0.preLoadIcon.name, arg_21_0.preLoadIcon.name, arg_21_0.preLoadIcon)

			var_21_1 = var_21_0.id == getProxy(PlayerProxy):getRawData().id
		end

		local var_21_2 = AttireFrame.attireFrameRes(var_21_0, var_21_1, AttireConst.TYPE_ICON_FRAME, var_21_0.propose)

		PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_21_2, var_21_2, true, function(arg_23_0)
			if arg_21_0.icon then
				arg_23_0.name = var_21_2
				findTF(arg_23_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

				setParent(arg_23_0, arg_21_0.icon.gameObject, false)

				arg_21_0.preLoadIcon = arg_23_0
			end

			return
		end)
		onButton(arg_21_0, arg_21_0.icon, function()
			local var_24_0

			if var_21_0.id == getProxy(PlayerProxy):getRawData().id then
				do return end

				var_24_0 = arg_21_0.template:GetName()
			end

			arg_21_0:emit(NewBackYardThemeTemplateMediator.ON_DISPLAY_PLAYER_INFO, var_21_0.id, tf(arg_21_0.icon.gameObject).position, arg_21_0.template.id)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.UpdateLikeInfo(arg_25_0)
	arg_25_0.heartTxt.text = i18n("backyard_theme_word_like") .. arg_25_0.template:GetLikeCnt()
	arg_25_0.collectionTxt.text = i18n("backyard_theme_word_collection") .. arg_25_0.template:GetCollectionCnt()

	local var_25_0 = arg_25_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM
	local var_25_1 = arg_25_0.template:IsLiked()

	onButton(arg_25_0, arg_25_0.heart, function()
		if arg_25_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
			return
		end

		if not var_25_1 then
			arg_25_0:emit(NewBackYardThemeTemplateMediator.ON_LIKE_THEME, arg_25_0.template, arg_25_0.template.time)
		end

		return
	end, SFX_PANEL)
	setActive(arg_25_0.heartSel, var_25_1 or var_25_0)

	local var_25_2 = arg_25_0.template:IsCollected()

	onButton(arg_25_0, arg_25_0.collection, function()
		if arg_25_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
			return
		end

		if var_25_2 then
			arg_25_0.contextData.msgBox:ExecuteAction("SetUp", {
				content = i18n("backyard_theme_cancel_collection"),
				onYes = function()
					arg_25_0:emit(NewBackYardThemeTemplateMediator.ON_COLECT_THEME, arg_25_0.template, true, arg_25_0.template.time)

					return
				end
			})
		else
			arg_25_0:emit(NewBackYardThemeTemplateMediator.ON_COLECT_THEME, arg_25_0.template, false, arg_25_0.template.time)
		end

		return
	end, SFX_PANEL)
	setActive(arg_25_0.collectionSel, arg_25_0.template:IsCollected() or var_25_0)

	return
end

function var_0_0.UpdateWindow(arg_29_0)
	local var_29_0 = true

	if arg_29_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		arg_29_0.frame.sizeDelta = Vector2(arg_29_0.frame.sizeDelta.x, 456)
	elseif arg_29_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
		if arg_29_0.template:IsPushed() then
			arg_29_0.frame.sizeDelta = Vector2(arg_29_0.frame.sizeDelta.x, 456)
		else
			var_29_0 = false
			arg_29_0.frame.sizeDelta = Vector2(arg_29_0.frame.sizeDelta.x, 395)
		end
	elseif arg_29_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
		arg_29_0.frame.sizeDelta = Vector2(arg_29_0.frame.sizeDelta.x, 456)
	end

	setActive(arg_29_0.heart, var_29_0)
	setActive(arg_29_0.collection, var_29_0)

	return
end

function var_0_0.Show(arg_30_0)
	arg_30_0.isShowing = true

	var_0_0.super.Show(arg_30_0)
	pg.UIMgr.GetInstance():OverlayPanel(arg_30_0.adpter, {
		groupName = "NewBackYardThemeTemplateLayer",
		pbList = {
			arg_30_0._tf:Find("adpter/frame")
		}
	})

	return
end

function var_0_0.Hide(arg_31_0)
	arg_31_0.isShowing = false

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_31_0.adpter, arg_31_0._tf)
	var_0_0.super.Hide(arg_31_0)

	return
end

function var_0_0.OnDestroy(arg_32_0)
	if arg_32_0.isShowing then
		arg_32_0:Hide()
	end

	if arg_32_0.preLoadIcon then
		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. arg_32_0.preLoadIcon.name, arg_32_0.preLoadIcon.name, arg_32_0.preLoadIcon)
	end

	return
end

return var_0_0
