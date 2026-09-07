local NewBulletinBoardLayer = class("NewBulletinBoardLayer", import("..base.BaseUI"))

NewBulletinBoardLayer.CONTENT_TYPE = {
	BANNER = "BANNER",
	RICHTEXT = "RITCHTEXT"
}
NewBulletinBoardLayer.ICON_NAME = {
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
NewBulletinBoardLayer.MAIN_TAB_GAMETIP = {
	"Announcements_Event_Notice",
	"Announcements_System_Notice",
	"Announcements_News"
}
NewBulletinBoardLayer.TITLE_IMAGE_HEIGHT_DEFAULT = 231
NewBulletinBoardLayer.TITLE_IMAGE_HEIGHT_FULL = 734

function NewBulletinBoardLayer:getUIName()
	return "NewBulletinBoardUI"
end

function NewBulletinBoardLayer:init()
	self._closeBtn = self._tf:Find("bg/close_btn")
	self._mainTabContainer = self._tf:Find("bg/notice_list")
	self._subTabGroup = self._tf:Find("bg/title_list/viewport/content"):GetComponent(typeof(ToggleGroup))
	self._subTabContainer = self._tf:Find("bg/title_list/viewport/content")
	self._tabTpl = self._tf:Find("bg/title_list/tab_btn_tpl")

	SetActive(self._tabTpl, false)

	self._subTabList = {}
	self._contentTF = self._tf:Find("bg/content_view/viewport/content")
	self._detailTitleImg = self._contentTF:Find("title_img")
	self._detailTitleImgLayoutElement = self._detailTitleImg:GetComponent(typeof(LayoutElement))
	self._detailTitle = self._contentTF:Find("title")
	self._detailTitleTxt = self._contentTF:Find("title/title_txt/mask/scroll_txt")
	self._detailTimeTxt = self._contentTF:Find("title/time_txt")
	self._detailLine = self._contentTF:Find("line")
	self._bottom = self._contentTF:Find("bottom")
	self._contentContainer = self._contentTF:Find("content_container")
	self._contentTxtTpl = self._contentTF:Find("content_txt")

	setActive(self._contentTxtTpl, false)

	self._contentBannerTpl = self._contentTF:Find("content_banner")

	setActive(self._contentBannerTpl, false)

	self._scrollRect = self._tf:Find("bg/content_view"):GetComponent(typeof(ScrollRect))
	self._dontshow = self._tf:Find("bg/dont_show")
	self._stopRemind = self._tf:Find("bg/dont_show/bottom")
	self._subTabAnims = {}
	self._mainAnim = self._tf:GetComponent(typeof(Animation))
	self._bgAnim = self._tf:Find("bg"):GetComponent(typeof(Animation))
	self._contentAnim = self._tf:Find("bg/content_view"):GetComponent(typeof(Animation))

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self._loadingFlag = {}
	self._contentList = {}
	self._noticeDic = {
		{},
		{},
		{}
	}
	self._redDic = {
		{},
		{},
		{}
	}
	self.noticeKeys = {}
	self.noticeVersions = {}
	self.LTList = {}

	return
end

function NewBulletinBoardLayer:didEnter()
	self._mainAnim:Play("anim_BulletinBoard_in")
	onButton(self, self._closeBtn, function()
		self._mainAnim:Play("anim_BulletinBoard_out")
		LeanTween.delayedCall(0.2, System.Action(function()
			self:emit(NewBulletinBoardLayer.ON_CLOSE)

			return
		end))

		return
	end, SOUND_BACK)
	onToggle(self, self._stopRemind, function(arg_6_0)
		self:emit(NewBulletinBoardMediator.SET_STOP_REMIND, arg_6_0)

		return
	end)
	triggerToggle(self._stopRemind, (getProxy(ServerNoticeProxy):getStopRemind()))
	setText(self._dontshow, i18n("Announcements_Donotshow"))
	LeanTween.rotateAroundLocal(rtf(self._detailTitleImg:Find("loading/Image")), Vector3(0, 0, -1), 360, 5):setLoopClamp()

	return
end

function NewBulletinBoardLayer:updateRed()
	for iter_7_0 = 1, 3 do
		local var_7_0 = false

		for iter_7_1, iter_7_2 in pairs(self._noticeDic[iter_7_0]) do
			self._redDic[iter_7_0][iter_7_1] = PlayerPrefs.HasKey(iter_7_2.code)

			if not self._redDic[iter_7_0][iter_7_1] then
				var_7_0 = true
			end
		end

		setActive(self._mainTabContainer:GetChild(iter_7_0 - 1):Find("Text/red"), var_7_0)
	end

	for iter_7_3 = 1, #self._subTabList do
		setActive(self._subTabList[iter_7_3]:Find("red"), not self._redDic[self.currentMainTab][iter_7_3])
	end

	return
end

function NewBulletinBoardLayer:checkNotice(arg_8_1)
	return arg_8_1.type and arg_8_1.type > 0 and arg_8_1.type < 4 and (arg_8_1.paramType == nil or arg_8_1.paramType == 1 and type(arg_8_1.param) == "string" or arg_8_1.paramType == 2 and type(arg_8_1.param) == "string" or arg_8_1.paramType == 3 and type(arg_8_1.param) == "number" or arg_8_1.paramType == 4 and type(arg_8_1.param) == "number" and pg.activity_banner_notice[arg_8_1.param] ~= nil or arg_8_1.paramType == 5)
end

function NewBulletinBoardLayer:initNotices(arg_9_1)
	self.defaultMainTab = self.contextData.defaultMainTab
	self.defaultSubTab = self.contextData.defaultSubTab

	local var_9_0
	local var_9_1

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		if self:checkNotice(iter_9_1) then
			table.insert(self._noticeDic[iter_9_1.type], iter_9_1)
			table.insert(self._redDic[iter_9_1.type], PlayerPrefs.HasKey(iter_9_1.code))

			if not var_9_1 or var_9_1 < iter_9_1.priority then
				var_9_1 = iter_9_1.priority
				var_9_0 = iter_9_1.type
			end

			table.insert(self.noticeKeys, tostring(iter_9_1.id))
			table.insert(self.noticeVersions, iter_9_1.version)
		else
			Debugger.LogWarning("公告配置错误  id = " .. iter_9_1.id)
		end
	end

	for iter_9_2 = 1, 3 do
		local var_9_2 = self._mainTabContainer:GetChild(iter_9_2 - 1)
		local var_9_3 = var_9_2:Find("selected"):GetComponent(typeof(Animation))

		setText(var_9_2:Find("Text"), i18n(NewBulletinBoardLayer.MAIN_TAB_GAMETIP[iter_9_2]))
		onToggle(self, var_9_2, function(arg_10_0)
			if arg_10_0 then
				if self.currentMainTab and self.currentMainTab == iter_9_2 then
					return
				end

				if self.currentMainTab then
					var_9_3:Play(self.currentMainTab > iter_9_2 and "anim_BB_toptitle_R_in" or "anim_BB_toptitle_L_in")
					self._bgAnim:Play(self.currentMainTab > iter_9_2 and "anim_BulletinBoard_Rin_change" or "anim_BulletinBoard_Lin_change")
				end

				self.currentMainTab = iter_9_2
				self.defaultSubTab = self.tempSubTab
				self.tempSubTab = nil

				self:setNotices(self._noticeDic[iter_9_2])
			end

			return
		end)

		if #self._noticeDic[iter_9_2] == 0 then
			setActive(var_9_2, false)
		end
	end

	self.defaultMainTab = self.defaultMainTab or var_9_0

	if self.defaultMainTab then
		self.tempSubTab = self.defaultSubTab

		triggerToggle(self._mainTabContainer:GetChild(self.defaultMainTab - 1), true)
	end

	BulletinBoardMgr.Inst:ClearCache(self.noticeKeys, self.noticeVersions)

	return
end

function NewBulletinBoardLayer:setNotices(arg_11_1)
	self:clearTab()

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		local var_11_0 = cloneTplTo(self._tabTpl, self._subTabContainer)

		SetActive(var_11_0, true)
		table.insert(self._subTabList, var_11_0)
		table.insert(self._subTabAnims, var_11_0:Find("select_state"):GetComponent(typeof(Animation)))
		setScrollText(var_11_0:Find("common_state/mask/Text"), iter_11_1.btnTitle)
		setScrollText(var_11_0:Find("select_state/mask/Text"), iter_11_1.btnTitle)
		GetSpriteFromAtlasAsync("ui/newbulletinboardui_atlas", NewBulletinBoardLayer.ICON_NAME[iter_11_1.icon], function(arg_12_0)
			setImageSprite(var_11_0:Find("common_state/icon"), arg_12_0)

			return
		end)
		GetSpriteFromAtlasAsync("ui/newbulletinboardui_atlas", NewBulletinBoardLayer.ICON_NAME[iter_11_1.icon] .. "_selected", function(arg_13_0)
			setImageSprite(var_11_0:Find("select_state/icon"), arg_13_0)

			return
		end)
		onToggle(self, var_11_0, function(arg_14_0)
			if arg_14_0 then
				setActive(var_11_0:Find("select_state"), true)

				if self.currentSubTab and self.currentSubTab == iter_11_0 then
					return
				end

				if self.currentSubTab then
					local var_14_0 = self.currentSubTab

					self._subTabAnims[iter_11_0]:Play(self.currentSubTab > iter_11_0 and "anim_BB_lefttitle_B_in" or "anim_BB_lefttitle_T_in")
					self._subTabAnims[var_14_0]:Play(var_14_0 > iter_11_0 and "anim_BB_lefttitle_T_out" or "anim_BB_lefttitle_B_out")

					self.subTabLT = LeanTween.delayedCall(0.26, System.Action(function()
						setActive(self._subTabList[var_14_0]:Find("select_state"), false)

						return
					end)).uniqueId

					self._contentAnim:Play(var_14_0 > iter_11_0 and "anim_BB_view_B_in" or "anim_BB_view_T_in")
				end

				self.currentSubTab = iter_11_0

				PlayerPrefs.SetInt(self._noticeDic[self.currentMainTab][iter_11_0].code, 0)
				self:updateRed()
				self:setNoticeDetail(iter_11_1)
			end

			return
		end, SFX_PANEL)
	end

	self.defaultSubTab = self.defaultSubTab or 1

	triggerToggle(self._subTabList[self.defaultSubTab], true)

	return
end

function NewBulletinBoardLayer:setImage(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_4:Find("img"):GetComponent(typeof(Image))
	local var_16_1 = arg_16_4:Find("loading")

	var_16_0.color = Color.New(0, 0, 0, 0.4)

	setActive(var_16_1, true)

	self._loadingFlag[arg_16_3] = true

	BulletinBoardMgr.Inst:GetSprite(arg_16_1, arg_16_2, arg_16_3, UnityEngine.Events.UnityAction_UnityEngine_Sprite(function(arg_17_0)
		if self._loadingFlag == nil then
			return
		end

		self._loadingFlag[arg_16_3] = nil

		if arg_17_0 ~= nil and not IsNil(arg_16_4) then
			setImageSprite(var_16_0, arg_17_0, false)

			var_16_0.color = Color.New(1, 1, 1)

			setActive(var_16_1, false)
		end

		return
	end))

	return
end

function NewBulletinBoardLayer:setNoticeDetail(arg_18_1)
	local function var_18_0(arg_19_0)
		local var_19_0 = cloneTplTo(self._contentBannerTpl, self._contentContainer)

		table.insert(self._contentList, var_19_0)
		self:setImage(arg_18_1.id, arg_18_1.version, arg_19_0, var_19_0, true, nil)

		return
	end

	local function var_18_1(arg_20_0)
		local var_20_0 = cloneTplTo(self._contentTxtTpl, self._contentContainer)

		table.insert(self._contentList, var_20_0)
		setText(var_20_0, SwitchSpecialChar(arg_20_0, true))
		var_20_0:GetComponent("RichText"):AddListener(function(arg_21_0, arg_21_1)
			if arg_21_0 == "url" then
				Application.OpenURL(arg_21_1)
			end

			return
		end)

		return
	end

	self:clearLoadingPic()
	self:clearLeanTween()
	self:clearContent()

	if arg_18_1.paramType then
		setActive(self._detailTitle, false)
		setActive(self._detailLine, false)
		setActive(self._contentContainer, false)
		setActive(self._bottom, false)

		self._detailTitleImgLayoutElement.preferredHeight = NewBulletinBoardLayer.TITLE_IMAGE_HEIGHT_FULL

		self:setImage(arg_18_1.id, arg_18_1.version, arg_18_1.titleImage, self._detailTitleImg)
		onButton(self, self._detailTitleImg, function()
			if arg_18_1.paramType == 1 then
				Application.OpenURL(arg_18_1.param)
				self:emit(NewBulletinBoardMediator.TRACK_OPEN_URL, arg_18_1.track)
			elseif arg_18_1.paramType == 2 then
				self:emit(NewBulletinBoardMediator.GO_SCENE, arg_18_1.param)
			elseif arg_18_1.paramType == 3 then
				self:emit(NewBulletinBoardMediator.GO_SCENE, SCENE.ACTIVITY, {
					id = arg_18_1.param
				})
			elseif arg_18_1.paramType == 4 then
				self:emit(NewBulletinBoardMediator.GO_SCENE, pg.activity_banner_notice[arg_18_1.param].param[1], pg.activity_banner_notice[arg_18_1.param].param[2])
			elseif arg_18_1.paramType == 5 then
				if not pg.NewStoryMgr.GetInstance():IsPlayed("JIARIBIESHUCHOUBEIZHONG5") then
					self:emit(NewBulletinBoardMediator.GO_SCENE, SCENE.ACTIVITY, {
						id = 5922
					})
				else
					self:emit(NewBulletinBoardMediator.GO_SCENE, SCENE.HOLIDAY_VILLA_MAP)
				end
			end

			self.contextData.defaultMainTab = self.currentMainTab
			self.contextData.defaultSubTab = self.currentSubTab

			return
		end, SFX_PANEL)
	else
		setActive(self._detailTitle, true)
		setActive(self._detailLine, true)
		setActive(self._contentContainer, true)
		setActive(self._bottom, true)
		setScrollText(self._detailTitleTxt, arg_18_1.pageTitle)
		setText(self._detailTimeTxt, arg_18_1.timeDes)

		self._detailTitleImgLayoutElement.preferredHeight = NewBulletinBoardLayer.TITLE_IMAGE_HEIGHT_DEFAULT

		self:setImage(arg_18_1.id, arg_18_1.version, arg_18_1.titleImage, self._detailTitleImg)
		removeOnButton(self._detailTitleImg)

		local function var_18_2(arg_23_0)
			if #arg_23_0 == 0 then
				return ""
			end

			local var_23_0, var_23_1 = string.find(arg_23_0, "^[ ]*\n")

			var_23_1 = var_23_1 or 0

			return string.sub(arg_23_0, var_23_1 + 1, (string.find(arg_23_0, "\n[ ]*$") or #arg_23_0 + 1) - 1)
		end

		local function var_18_3(arg_24_0)
			_.each(string.split(arg_24_0, "<segment/>"), function(arg_25_0)
				local var_25_0 = var_18_2(arg_25_0)

				if #var_25_0 > 0 then
					table.insert(self._contentInfo, {
						type = NewBulletinBoardLayer.CONTENT_TYPE.RICHTEXT,
						text = var_25_0
					})
				end

				return
			end)

			return
		end

		self._contentInfo = {}

		local var_18_4 = 1

		for iter_18_0 in string.gmatch(arg_18_1.content, "<banner>%S-</banner>") do
			local var_18_5, var_18_6 = string.find(iter_18_0, "<banner>")
			local var_18_7, var_18_8 = string.find(iter_18_0, "</banner>")
			local var_18_9 = string.sub(iter_18_0, var_18_6 + 1, var_18_7 - 1)
			local var_18_10, var_18_11 = string.find(arg_18_1.content, iter_18_0, var_18_4, true)

			if var_18_10 ~= nil then
				local var_18_12 = var_18_2(string.sub(arg_18_1.content, var_18_4, var_18_10 - 1))

				if #var_18_12 > 0 then
					var_18_3(var_18_12)
				end
			end

			table.insert(self._contentInfo, {
				type = NewBulletinBoardLayer.CONTENT_TYPE.BANNER,
				text = var_18_9
			})

			var_18_4 = var_18_11 + 1
		end

		if var_18_4 < #arg_18_1.content then
			var_18_3(string.sub(arg_18_1.content, var_18_4, #arg_18_1.content))
		end

		for iter_18_1, iter_18_2 in pairs(self._contentInfo) do
			if iter_18_2.type == NewBulletinBoardLayer.CONTENT_TYPE.RICHTEXT then
				var_18_1(iter_18_2.text)
			elseif iter_18_2.type == NewBulletinBoardLayer.CONTENT_TYPE.BANNER then
				var_18_0(iter_18_2.text)
			end
		end

		self:bannerRotate()
	end

	return
end

function NewBulletinBoardLayer:bannerRotate()
	for iter_26_0, iter_26_1 in pairs(self._contentList) do
		local var_26_0 = iter_26_1:Find("loading/Image")

		if var_26_0 then
			table.insert(self.LTList, LeanTween.rotateAroundLocal(rtf(var_26_0), Vector3(0, 0, -1), 360, 5):setLoopClamp().uniqueId)
		end
	end

	return
end

function NewBulletinBoardLayer:clearLeanTween()
	for iter_27_0, iter_27_1 in pairs(self.LTList or {}) do
		LeanTween.cancel(iter_27_1)
	end

	return
end

function NewBulletinBoardLayer:clearContent()
	for iter_28_0, iter_28_1 in pairs(self._contentList) do
		Destroy(iter_28_1)
	end

	self._contentList = {}

	return
end

function NewBulletinBoardLayer:clearTab()
	if self.subTabLT then
		LeanTween.cancel(self.subTabLT)

		self.subTabLT = nil
	end

	self.currentSubTab = nil

	for iter_29_0, iter_29_1 in pairs(self._subTabList) do
		Destroy(iter_29_1)
	end

	self._subTabList = {}
	self._subTabAnims = {}

	return
end

function NewBulletinBoardLayer:clearLoadingPic()
	for iter_30_0, iter_30_1 in pairs(self._loadingFlag) do
		BulletinBoardMgr.Inst:StopLoader(iter_30_0)

		self._loadingFlag[iter_30_0] = nil
	end

	return
end

function NewBulletinBoardLayer:willExit()
	self:clearLoadingPic()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return NewBulletinBoardLayer
