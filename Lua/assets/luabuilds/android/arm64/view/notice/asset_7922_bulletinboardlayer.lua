local BulletinBoardLayer = class("BulletinBoardLayer", import("..base.BaseUI"))

function BulletinBoardLayer:getUIName()
	return "BulletinBoardUI"
end

function BulletinBoardLayer:init()
	self._closeBtn = self._tf:Find("close_btn")
	self._tabGroup = self._tf:Find("title_list/viewport/content"):GetComponent(typeof(ToggleGroup))
	self._tabContainer = self._tf:Find("title_list/viewport/content")
	self._tabTpl = self._tf:Find("title_list/tab_btn_tpl")

	SetActive(self._tabTpl, false)

	self._tabList = {}
	self._detailTitleImg = self._tf:Find("content_view/viewport/content/title_img/img")
	self._detailTitleImgComp = self._detailTitleImg:GetComponent(typeof(Image))
	self._detailTitleLoading = self._tf:Find("content_view/viewport/content/title_img/loading")
	self._detailTitleTxt = self._tf:Find("content_view/viewport/content/title_txt")
	self._detailTimeTxt = self._tf:Find("content_view/viewport/content/time_txt")
	self._detailContentTxt = self._tf:Find("content_view/viewport/content/content_txt")
	self._detailContentTxtComp = self._detailContentTxt:GetComponent("RichText")

	self._detailContentTxtComp:AddListener(function(arg_3_0, arg_3_1)
		if arg_3_0 == "url" then
			Application.OpenURL(arg_3_1)
		end

		return
	end)

	self._scrollRect = self._tf:Find("content_view"):GetComponent(typeof(ScrollRect))
	self._stopRemind = self._tf:Find("dontshow_tab")

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self._loadingFlag = {}

	return
end

function BulletinBoardLayer:didEnter()
	onButton(self, self._closeBtn, function()
		self:emit(BulletinBoardLayer.ON_CLOSE)

		return
	end, SOUND_BACK)
	onToggle(self, self._stopRemind, function(arg_6_0)
		self:emit(BulletinBoardMediator.SET_STOP_REMIND, arg_6_0)

		return
	end)
	triggerToggle(self._stopRemind, (getProxy(ServerNoticeProxy):getStopRemind()))

	return
end

function BulletinBoardLayer:setNotices(arg_7_1)
	local var_7_0 = {}
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		table.insert(var_7_0, tostring(iter_7_1.id))
		table.insert(var_7_1, iter_7_1.version)

		local var_7_2 = cloneTplTo(self._tabTpl, self._tabContainer)

		setScrollText(var_7_2:Find("common_state/title_mask/title_txt"), iter_7_1.btnTitle)
		setScrollText(var_7_2:Find("select_state/title_mask/title_txt"), iter_7_1.btnTitle)
		changeToScrollText(var_7_2:Find("common_state/time_txt"), iter_7_1.title)
		changeToScrollText(var_7_2:Find("select_state/time_txt"), iter_7_1.title)
		table.insert(self._tabList, var_7_2)
		SetActive(var_7_2, true)

		GetComponent(var_7_2, typeof(Toggle)).group = self._tabGroup

		onToggle(self, var_7_2, function(arg_8_0)
			if arg_8_0 then
				self:setNoticeDetail(iter_7_1)
			end

			setActive(var_7_2:Find("common_state"), not arg_8_0)

			return
		end, SFX_PANEL)
	end

	triggerToggle(self._tabList[1], true)
	BulletinBoardMgr.Inst:ClearCache(var_7_0, var_7_1)

	return
end

function BulletinBoardLayer:setNoticeDetail(arg_9_1)
	self:clearLoadingPic()
	setText(self._detailTitleTxt, arg_9_1.pageTitle)
	setText(self._detailTimeTxt, arg_9_1.timeDes)

	self._detailTitleImgComp.color = Color.New(0, 0, 0, 0.4)

	setActive(self._detailTitleLoading, true)

	self._loadingFlag[arg_9_1.titleImage] = true

	BulletinBoardMgr.Inst:GetSprite(arg_9_1.id, arg_9_1.version, arg_9_1.titleImage, UnityEngine.Events.UnityAction_UnityEngine_Sprite(function(arg_10_0)
		self._loadingFlag[arg_9_1.titleImage] = nil

		if arg_10_0 ~= nil then
			setImageSprite(self._detailTitleImg, arg_10_0, false)

			self._detailTitleImgComp.color = Color.New(1, 1, 1, 1)

			setActive(self._detailTitleLoading, false)
		end

		return
	end))

	self.tempContent = arg_9_1.content
	self.realContent = arg_9_1.content
	self.loadingCount = 0
	self.loadPic = {}

	for iter_9_0 in string.gmatch(arg_9_1.content, "<imgHref>%S-</imgHref>") do
		local var_9_0, var_9_1 = string.find(iter_9_0, "<imgHref>")
		local var_9_2, var_9_3 = string.find(iter_9_0, "</imgHref>")
		local var_9_4 = string.sub(iter_9_0, var_9_1 + 1, var_9_2 - 1)
		local var_9_5 = string.gsub(string.gsub(string.gsub(iter_9_0, "%.", "%%."), "%-", "%%-"), "%?", "%%?")

		self.realContent = string.gsub(self.realContent, var_9_5, "<icon name=" .. var_9_4 .. " w=2 h=2/>")
		self.tempContent = string.gsub(self.tempContent, var_9_5, "")

		table.insert(self.loadPic, var_9_4)
	end

	setText(self._detailContentTxt, (SwitchSpecialChar(self.tempContent, true)))

	self.loadingCount = #self.loadPic

	for iter_9_1, iter_9_2 in ipairs(self.loadPic) do
		self._loadingFlag[iter_9_2] = true

		BulletinBoardMgr.Inst:GetSprite(arg_9_1.id, arg_9_1.version, iter_9_2, UnityEngine.Events.UnityAction_UnityEngine_Sprite(function(arg_11_0)
			self._loadingFlag[iter_9_2] = nil

			if arg_11_0 ~= nil then
				self.loadingCount = self.loadingCount - 1

				self._detailContentTxtComp:AddSprite(arg_11_0.name, arg_11_0)

				if self.loadingCount <= 0 then
					setText(self._detailContentTxt, SwitchSpecialChar(self.realContent, true))
				end
			end

			return
		end))
	end

	return
end

function BulletinBoardLayer:clearLoadingPic()
	for iter_12_0, iter_12_1 in pairs(self._loadingFlag) do
		BulletinBoardMgr.Inst:StopLoader(iter_12_0)

		self._loadingFlag[iter_12_0] = nil
	end

	return
end

function BulletinBoardLayer:willExit()
	self:clearLoadingPic()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return BulletinBoardLayer
