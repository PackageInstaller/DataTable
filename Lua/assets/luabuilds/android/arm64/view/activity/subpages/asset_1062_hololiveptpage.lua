local HoloLivePtPage = class("HoloLivePtPage", import(".TemplatePage.PtTemplatePage"))

function HoloLivePtPage:OnInit()
	HoloLivePtPage.super.OnInit(self)

	self.charImg = self.bg:Find("charImg")
	self.numImg = self.bg:Find("numImg")
	self.chapterImg = self.bg:Find("chapterImg")
	self.spineCharContainer = self.bg:Find("SpineChar")
	self.scrollTextMask = self.bg:Find("ScrollText")
	self.scrollTextContainer = self.bg:Find("ScrollText/TextList")
	self.scrollTextTpl = self.bg:Find("TextTpl")

	return
end

function HoloLivePtPage:OnDataSetting()
	HoloLivePtPage.super.OnDataSetting(self)

	self.ptCount = self.ptData:GetResProgress()
	self.ptRank = pg.activity_event_pt[self.activity.id].pt_list
	self.picNameList = pg.activity_event_pt[self.activity.id].pic_list

	return
end

function HoloLivePtPage:OnFirstFlush()
	HoloLivePtPage.super.OnFirstFlush(self)
	self:initScrollTextList()

	local var_3_0 = math.floor(self.ptCount / (self.ptRank[2] - self.ptRank[1])) + 1

	if var_3_0 > #self.picNameList then
		var_3_0 = #self.picNameList
	end

	LoadSpriteAtlasAsync("ui/activityuipage/hololiveptpage", self.picNameList[var_3_0], function(arg_4_0)
		setImageSprite(self.charImg, arg_4_0)

		return
	end)
	LoadSpriteAtlasAsync("ui/activityuipage/hololiveptpage", "#" .. var_3_0, function(arg_5_0)
		setImageSprite(self.numImg, arg_5_0)

		return
	end)
	LoadSpriteAtlasAsync("ui/activityuipage/hololiveptpage", "jiaobiao_" .. var_3_0, function(arg_6_0)
		setImageSprite(self.chapterImg, arg_6_0)

		return
	end)

	local var_3_1 = "vtuber_shion"

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar("vtuber_shion", true, function(arg_7_0)
		pg.UIMgr.GetInstance():LoadingOff()

		self.prefab = var_3_1
		self.model = arg_7_0
		tf(arg_7_0).localScale = Vector3(1, 1, 1)

		arg_7_0:GetComponent("SpineAnimUI"):SetAction("stand", 0)
		setParent(arg_7_0, self.spineCharContainer)

		return
	end)

	return
end

function HoloLivePtPage:OnDestroy()
	if self.scrollTextTimer then
		self.scrollTextTimer:Stop()

		self.scrollTextTimer = nil
	end

	if self.prefab and self.model then
		PoolMgr.GetInstance():ReturnSpineChar(self.prefab, self.model)

		self.prefab = nil
		self.model = nil
	end

	return
end

function HoloLivePtPage:initScrollTextList()
	setText(self.scrollTextTpl, self.activity:getConfig("config_client").scrollStr)

	local var_9_0 = self.scrollTextContainer.localPosition.x - (GetComponent(self.scrollTextTpl, "Text").preferredWidth + self.scrollTextMask.rect.width + 50)
	local var_9_1 = 50
	local var_9_2 = 0.016666666666666666

	UIItemList.New(self.scrollTextContainer, self.scrollTextTpl):align(2)

	local var_9_3 = self.scrollTextContainer:GetChild(1)

	self.scrollTextTimer = Timer.New(function()
		self.scrollTextContainer.localPosition = Vector3((self.scrollTextContainer.localPosition.x - var_9_1 * var_9_2 <= var_9_0 or nil) and var_9_3.localPosition.x + self.scrollTextContainer.localPosition.x, 0, 0)

		return
	end, 0.016666666666666666, -1, true)

	self.scrollTextTimer:Start()

	return
end

return HoloLivePtPage
