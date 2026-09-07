local BackYardThemeTemplateDescPage = class("BackYardThemeTemplateDescPage", import("....base.BaseSubView"))
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

function BackYardThemeTemplateDescPage:getUIName()
	return "BackYardThemeTemplateDescPage"
end

function BackYardThemeTemplateDescPage:ThemeTemplateUpdate(arg_3_1)
	if self.template and self.template.id == arg_3_1.id then
		self.template = arg_3_1

		self:Flush()
	end

	return
end

function BackYardThemeTemplateDescPage:UpdateDorm(arg_4_1)
	self.dorm = arg_4_1

	return
end

function BackYardThemeTemplateDescPage:PlayerUpdated(arg_5_1)
	self.player = arg_5_1

	return
end

function BackYardThemeTemplateDescPage:OnLoaded()
	self.adpter = self._tf:Find("adpter")
	self.frame = self._tf:Find("adpter/frame")
	self.icon = self._tf:Find("adpter/frame/icon"):GetComponent(typeof(Image))
	self.idTxt = self._tf:Find("adpter/frame/ID"):GetComponent(typeof(Text))
	self.idLabel = self._tf:Find("adpter/frame/ID_label"):GetComponent(typeof(Text))
	self.copyBtn = self._tf:Find("adpter/frame/copy")
	self.nameTxt = self._tf:Find("adpter/frame/name"):GetComponent(typeof(Text))
	self.mainPanel = self._tf:Find("adpter/frame/main")
	self.timeTxt = self.mainPanel:Find("time"):GetComponent(typeof(Text))
	self.btn1 = self.mainPanel:Find("desc_btn")
	self.btn1Txt = self.mainPanel:Find("desc_btn/Text"):GetComponent(typeof(Text))
	self.btn2 = self.mainPanel:Find("push_btn")
	self.btn2Txt = self.mainPanel:Find("push_btn/Text"):GetComponent(typeof(Text))
	self.heart = self.mainPanel:Find("heart")
	self.heartSel = self.mainPanel:Find("heart/sel")
	self.heartTxt = self.mainPanel:Find("heart/Text"):GetComponent(typeof(Text))
	self.collection = self.mainPanel:Find("collection")
	self.collectionSel = self.mainPanel:Find("collection/sel")
	self.collectionTxt = self.mainPanel:Find("collection/Text"):GetComponent(typeof(Text))
	self.idLabel.text = i18n("word_theme") .. "ID:"

	return
end

function BackYardThemeTemplateDescPage:OnInit()
	onButton(self, self.copyBtn, function()
		if self.player then
			UniPasteBoard.SetClipBoardString(self.template.id)
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_id_copy_ok"))
		end

		return
	end, SFX_PANEL)

	return
end

function BackYardThemeTemplateDescPage:SetUp(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self.pageType = arg_9_1
	self.template = arg_9_2
	self.dorm = arg_9_3
	self.player = arg_9_4

	self:RefreshSortBtn()
	self:Flush()
	self:Show()

	return
end

function BackYardThemeTemplateDescPage:RefreshSortBtn()
	local var_10_1

	if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
		local var_10_2

		var_10_2, var_10_1 = BackYardConst.ServerIndex2ThemeSortIndex(getProxy(DormProxy).TYPE)
	else
		var_10_1 = true
	end

	self.sortFlag = var_10_1

	return
end

function BackYardThemeTemplateDescPage:Flush()
	self:UpdateWindow()
	self:UpdatePlayer()
	self:UpdateLikeInfo()
	self["Update" .. self.pageType](self)

	return
end

function BackYardThemeTemplateDescPage:Update1()
	onButton(self, self.btn1, function()
		self.contextData.infoPage:ExecuteAction("SetUp", self.template, self.dorm, self.player)

		return
	end, SFX_PANEL)
	onButton(self, self.btn2, function()
		self.contextData.msgBox:ExecuteAction("SetUp", {
			type = BackYardThemeTemplateMsgBox.TYPE_IMAGE,
			content = i18n("backyard_theme_apply_tip2"),
			srpiteName = self.template:GetTextureIconName(),
			md5 = self.template:GetIconMd5(),
			onYes = function()
				self:emit(NewBackYardThemeTemplateMediator.ON_APPLY_TEMPLATE, self.template, function()
					triggerButton(self.btn1)

					return
				end)

				return
			end
		})

		return
	end, SFX_PANEL)

	self.btn1Txt.text = i18n("courtyard_label_detail")
	self.btn2Txt.text = i18n("courtyard_label_place_pnekey")

	return
end

function BackYardThemeTemplateDescPage:Update2()
	local var_17_0 = self.template
	local var_17_1 = self.template:IsPushed()

	onButton(self, self.btn1, function()
		self:emit(NewBackYardThemeTemplateMediator.ON_DELETE_TEMPLATE, var_17_0)

		return
	end, SFX_PANEL)
	onButton(self, self.btn2, function()
		if var_17_1 then
			self:emit(NewBackYardThemeTemplateMediator.ON_CANCEL_UPLOAD_TEMPLATE, var_17_0)
		else
			self:emit(NewBackYardThemeTemplateMediator.ON_UPLOAD_TEMPLATE, var_17_0)
		end

		return
	end, SFX_PANEL)

	if not var_17_1 then
		self.timeTxt.text = i18n("backyard_theme_upload_cnt", getProxy(DormProxy):GetUploadThemeTemplateCnt(), BackYardConst.MAX_UPLOAD_THEME_CNT)
	end

	self.btn1Txt.text = i18n("courtyard_label_delete")
	self.btn2Txt.text = var_17_1 and i18n("courtyard_label_cancel_share") or i18n("courtyard_label_share")

	return
end

function BackYardThemeTemplateDescPage:Update3()
	self:Update1()

	self.timeTxt.text = i18n("backyard_theme_template_collection_cnt") .. getProxy(DormProxy):GetThemeTemplateCollectionCnt() .. "/" .. BackYardConst.MAX_COLLECTION_CNT
	self.btn1Txt.text = i18n("courtyard_label_detail")
	self.btn2Txt.text = i18n("courtyard_label_place_pnekey")

	return
end

function BackYardThemeTemplateDescPage:UpdatePlayer()
	if not self.template:ExistPlayerInfo() then
		self:emit(NewBackYardThemeTemplateMediator.GET_TEMPLATE_PLAYERINFO, self.pageType, self.template)
	else
		local var_21_0 = self.template.player

		self.player = self.template.player
		self.nameTxt.text = var_21_0:GetName()
		self.idTxt.text = self.template.id
		self.timeTxt.text = i18n("backyard_theme_upload_time") .. self.template:GetUploadTime()

		LoadSpriteAsync("qicon/" .. var_21_0:getPainting(), function(arg_22_0)
			if IsNil(self.icon) then
				return
			end

			self.icon.sprite = arg_22_0

			return
		end)

		local var_21_1

		if self.preLoadIcon then
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. self.preLoadIcon.name, self.preLoadIcon.name, self.preLoadIcon)

			var_21_1 = var_21_0.id == getProxy(PlayerProxy):getRawData().id
		end

		local var_21_2 = AttireFrame.attireFrameRes(var_21_0, var_21_1, AttireConst.TYPE_ICON_FRAME, var_21_0.propose)

		PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_21_2, var_21_2, true, function(arg_23_0)
			if self.icon then
				arg_23_0.name = var_21_2
				findTF(arg_23_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

				setParent(arg_23_0, self.icon.gameObject, false)

				self.preLoadIcon = arg_23_0
			end

			return
		end)
		onButton(self, self.icon, function()
			if var_21_0.id == getProxy(PlayerProxy):getRawData().id then
				do return end

				local var_24_0 = self.template:GetName()
			end

			self:emit(NewBackYardThemeTemplateMediator.ON_DISPLAY_PLAYER_INFO, var_21_0.id, tf(self.icon.gameObject).position, self.template.id)

			return
		end, SFX_PANEL)
	end

	return
end

function BackYardThemeTemplateDescPage:UpdateLikeInfo()
	self.heartTxt.text = i18n("backyard_theme_word_like") .. self.template:GetLikeCnt()
	self.collectionTxt.text = i18n("backyard_theme_word_collection") .. self.template:GetCollectionCnt()

	local var_25_0 = self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM
	local var_25_1 = self.template:IsLiked()

	onButton(self, self.heart, function()
		if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
			return
		end

		if not var_25_1 then
			self:emit(NewBackYardThemeTemplateMediator.ON_LIKE_THEME, self.template, self.template.time)
		end

		return
	end, SFX_PANEL)
	setActive(self.heartSel, var_25_1 or var_25_0)

	local var_25_2 = self.template:IsCollected()

	onButton(self, self.collection, function()
		if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
			return
		end

		if var_25_2 then
			self.contextData.msgBox:ExecuteAction("SetUp", {
				content = i18n("backyard_theme_cancel_collection"),
				onYes = function()
					self:emit(NewBackYardThemeTemplateMediator.ON_COLECT_THEME, self.template, true, self.template.time)

					return
				end
			})
		else
			self:emit(NewBackYardThemeTemplateMediator.ON_COLECT_THEME, self.template, false, self.template.time)
		end

		return
	end, SFX_PANEL)
	setActive(self.collectionSel, var_25_2 or var_25_0)

	return
end

function BackYardThemeTemplateDescPage:UpdateWindow()
	local var_29_0 = true

	if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		self.frame.sizeDelta = Vector2(self.frame.sizeDelta.x, 456)
	elseif self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
		if self.template:IsPushed() then
			self.frame.sizeDelta = Vector2(self.frame.sizeDelta.x, 456)
		else
			var_29_0 = false
			self.frame.sizeDelta = Vector2(self.frame.sizeDelta.x, 395)
		end
	elseif self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
		self.frame.sizeDelta = Vector2(self.frame.sizeDelta.x, 456)
	end

	setActive(self.heart, var_29_0)
	setActive(self.collection, var_29_0)

	return
end

function BackYardThemeTemplateDescPage:Show()
	self.isShowing = true

	BackYardThemeTemplateDescPage.super.Show(self)
	pg.UIMgr.GetInstance():OverlayPanel(self.adpter, {
		groupName = "NewBackYardThemeTemplateLayer",
		pbList = {
			self._tf:Find("adpter/frame")
		}
	})

	return
end

function BackYardThemeTemplateDescPage:Hide()
	self.isShowing = false

	pg.UIMgr.GetInstance():UnOverlayPanel(self.adpter, self._tf)
	BackYardThemeTemplateDescPage.super.Hide(self)

	return
end

function BackYardThemeTemplateDescPage:OnDestroy()
	if self.isShowing then
		self:Hide()
	end

	if self.preLoadIcon then
		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. self.preLoadIcon.name, self.preLoadIcon.name, self.preLoadIcon)
	end

	return
end

return BackYardThemeTemplateDescPage
