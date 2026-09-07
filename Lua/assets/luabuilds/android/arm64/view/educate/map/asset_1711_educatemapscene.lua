local EducateMapScene = class("EducateMapScene", import("..base.EducateBaseUI"))

function EducateMapScene:getUIName()
	return "EducateMapUI"
end

function EducateMapScene:preload(arg_2_1)
	if getProxy(EducateProxy):NeedRequestOptsData() then
		pg.m02:sendNotification(GAME.EDUCATE_REQUEST_OPTION, {
			callback = arg_2_1
		})
	else
		arg_2_1()
	end

	return
end

function EducateMapScene:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function EducateMapScene:initData()
	self.config = pg.child_site
	self.siteIdList = getProxy(EducateProxy):GetShowSiteIds()

	return
end

function EducateMapScene:findUI()
	self.topTF = self._tf:Find("ui/top")
	self.homeBtn = self._tf:Find("ui/home_btn/home_btn")

	setText(self.homeBtn:Find("Text"), i18n("child_btn_home"))
	setActive(self.homeBtn, false)

	self.mapTF = self._tf:Find("map")
	self.mapContent = self.mapTF:Find("content")
	self.mapSiteTpl = self.mapTF:Find("site_tpl")

	setText(self.mapSiteTpl:Find("limit/Text"), i18n("child_option_limit"))
	setActive(self.mapSiteTpl, false)

	self.siteUIList = UIItemList.New(self.mapContent, self.mapSiteTpl)
	self.datePanel = EducateDatePanel.New(self.topTF:Find("date"), self.event)

	self.datePanel:RegisterView(self)
	self.datePanel:Load()

	self.resPanel = EducateResPanel.New(self.topTF:Find("res"), self.event, {
		showBg = true
	})

	self.resPanel:RegisterView(self)
	self.resPanel:Load()

	self.topPanel = EducateTopPanel.New(self.topTF:Find("top_right"), self.event)

	self.topPanel:RegisterView(self)
	self.topPanel:Load()

	self.targetPanel = EducateTargetPanel.New(self._tf:Find("ui/target"), self.event)

	self.targetPanel:RegisterView(self)
	self.targetPanel:Load()

	self.archivePanel = EducateArchivePanel.New(self._tf:Find("ui/archive_panel"), self.event)

	self.archivePanel:RegisterView(self)
	self.archivePanel:Load()

	self.detailPanel = EducateSiteDetailPanel.New(self._tf:Find("ui/detail_panel"), self.event, {
		onEnter = function()
			self:MoveTargetPanelLeft()

			return
		end,
		onExit = function()
			self:MoveTargetPanelRight()

			return
		end
	})

	self.detailPanel:RegisterView(self)
	self.detailPanel:Load()

	return
end

function EducateMapScene:addListener()
	onButton(self, self.homeBtn, function()
		self:emit(EducateBaseUI.EDUCATE_CHANGE_SCENE, SCENE.EDUCATE)

		return
	end, SFX_PANEL)

	return
end

function EducateMapScene:didEnter()
	self:OverlayPanel(self.topTF)
	self.siteUIList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			self:updateSiteItem(arg_11_1, arg_11_2)
		end

		return
	end)
	self.siteUIList:align(#self.siteIdList)
	self:playAnim()
	self:CheckTips(function()
		self.siteUIList:align(#self.siteIdList)

		return
	end)

	return
end

function EducateMapScene:playAnim()
	self.siteUIList:each(function(arg_14_0, arg_14_1)
		setActive(arg_14_1, false)

		return
	end)

	local var_13_0 = {}

	table.insert(var_13_0, function(arg_15_0)
		self:managedTween(LeanTween.delayedCall, function()
			arg_15_0()

			return
		end, 0.165, nil)

		return
	end)

	for iter_13_0 = 1, #self.siteIdList do
		table.insert(var_13_0, function(arg_17_0)
			setActive(self.siteUIList.container:GetChild(iter_13_0 - 1), true)
			self:managedTween(LeanTween.delayedCall, function()
				arg_17_0()

				return
			end, 0.033, nil)

			return
		end)
	end

	seriesAsync(var_13_0, function()
		return
	end)

	return
end

function EducateMapScene:CheckTips(arg_20_1)
	local var_20_1 = EducateTipHelper.GetSiteUnlockTipIds()

	if #var_20_1 > 0 then
		self:emit(EducateMapScene.EDUCATE_ON_UNLOCK_TIP, {
			type = EducateUnlockTipLayer.UNLOCK_TYPE_SITE,
			list = var_20_1,
			onExit = arg_20_1
		})
	end

	return
end

function EducateMapScene:updateSiteItem(arg_21_1, arg_21_2)
	local var_21_0 = self.config[self.siteIdList[arg_21_1 + 1]]

	arg_21_2.name = self.config[self.siteIdList[arg_21_1 + 1]].id

	LoadImageSpriteAsync("educatesite/" .. self.config[self.siteIdList[arg_21_1 + 1]].icon, arg_21_2:Find("icon"), true)
	LoadImageSpriteAsync("educatesite/" .. self.config[self.siteIdList[arg_21_1 + 1]].name_pic, arg_21_2:Find("name"), true)
	setActive(arg_21_2:Find("limit"), (underscore.any(getProxy(EducateProxy):GetOptionsBySiteId(self.config[self.siteIdList[arg_21_1 + 1]].id), function(arg_22_0)
		return arg_22_0:IsShowLimit()
	end)))
	setActive(arg_21_2:Find("new"), EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_SITE, self.config[self.siteIdList[arg_21_1 + 1]].id))
	setAnchoredPosition(arg_21_2, {
		x = self.config[self.siteIdList[arg_21_1 + 1]].coordinate[1],
		y = self.config[self.siteIdList[arg_21_1 + 1]].coordinate[2]
	})
	onButton(self, arg_21_2, function()
		self.detailPanel:Show(var_21_0.id)

		return
	end, SFX_PANEL)

	return
end

function EducateMapScene:clearNewTip(arg_24_1)
	eachChild(self.mapContent, function(arg_25_0)
		if tonumber(arg_25_0.name) == arg_24_1 then
			setActive(arg_25_0:Find("new"), false)
		end

		return
	end)

	return
end

function EducateMapScene:updateRes()
	self.resPanel:Flush()

	return
end

function EducateMapScene:updateAttrs()
	self.archivePanel:Flush()

	return
end

function EducateMapScene:updateTime()
	self.siteUIList:align(#self.siteIdList)
	self.datePanel:Flush()

	return
end

function EducateMapScene:updateTarget()
	self.targetPanel:Flush()

	return
end

function EducateMapScene:updateTimeWeekDay(arg_30_1)
	self.datePanel:UpdateWeekDay(arg_30_1)

	return
end

function EducateMapScene:MoveTargetPanelLeft()
	self.targetPanel:SetPosLeft()

	return
end

function EducateMapScene:MoveTargetPanelRight()
	self.targetPanel:SetPosRight()

	return
end

function EducateMapScene:ShowSpecEvent(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	self.detailPanel:showSpecEvent(arg_33_1, arg_33_2, arg_33_3, arg_33_4)

	return
end

function EducateMapScene:ShowSitePerform(arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	self.detailPanel:showSitePerform(arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)

	return
end

function EducateMapScene:onBackPressed()
	if self.detailPanel:isShowing() then
		self.detailPanel:onClose()
	else
		self:emit(EducateMapScene.ON_BACK_PRESSED)
	end

	return
end

function EducateMapScene:willExit()
	self:UnOverlayPanel(self.topTF, self._tf:Find("ui"))
	self.datePanel:Destroy()

	self.datePanel = nil

	self.resPanel:Destroy()

	self.resPanel = nil

	self.topPanel:Destroy()

	self.topPanel = nil

	self.targetPanel:Destroy()

	self.targetPanel = nil

	self.archivePanel:Destroy()

	self.archivePanel = nil

	self.detailPanel:Destroy()

	self.detailPanel = nil

	return
end

return EducateMapScene
