local TrophyGalleryLayer = class("TrophyGalleryLayer", import("..base.BaseUI"))

TrophyGalleryLayer.Filter = {
	"all",
	"claimed"
}
TrophyGalleryLayer.PAGE_COMMON = 1
TrophyGalleryLayer.PAGE_LIMITED = 2

function TrophyGalleryLayer:getUIName()
	return "TrophyGalleryUI"
end

function TrophyGalleryLayer:setTrophyGroups(arg_2_1)
	self.trophyGroups = arg_2_1

	return
end

function TrophyGalleryLayer:setTrophyList(arg_3_1)
	self.trophyList = arg_3_1

	return
end

function TrophyGalleryLayer:init()
	self._bg = self._tf:Find("bg")
	self._blurPanel = self._tf:Find("blur_panel")
	self._topPanel = self._blurPanel:Find("adapt/top")
	self._backBtn = self._topPanel:Find("back_btn")
	self._helpBtn = self._topPanel:Find("help_btn")
	self._center = self._tf:Find("bg/taskBGCenter")
	self._trophyUpperTpl = self:getTpl("trophy_upper", self._center)
	self._trophyLowerTpl = self:getTpl("trophy_lower", self._center)
	self._trophyContainer = self._tf:Find("bg/taskBGCenter/right_panel/Grid")
	self._scrllPanel = self._tf:Find("bg/taskBGCenter/right_panel")
	self._scrollView = self._scrllPanel:GetComponent("LScrollRect")
	self._trophyDetailPanel = TrophyDetailPanel.New(self._tf:Find("trophyPanel"), self._tf)
	self._filterBtn = self._topPanel:Find("filter/toggle")
	self._trophyCounter = self._topPanel:Find("filter/counter/Text")
	self._reminderRes = self._tf:Find("bg/resource")
	self._pageToggle = {
		self._tf:Find("blur_panel/adapt/left_length/frame/root/common_toggle"),
		self._tf:Find("blur_panel/adapt/left_length/frame/root/limited_toggle"),
		self.toggleLoveLetter
	}
	self._hideExpireBtn = self._tf:Find("blur_panel/adapt/top/expireCheckBox")
	self._hideExpireCheck = self._hideExpireBtn:Find("check")
	self._pageIndex = self.contextData.index or 1
	self._hideExpire = false
	self._trophyTFList = {}
	self._trophyViewCache = {}
	self._trophyMatCache = {}
	self.cardItems = {}
	self.cardList = self.rtScrollContent:GetComponent("LScrollRect")

	function self.cardList.onInitItem(arg_5_0)
		self:onInitCard(arg_5_0)

		return
	end

	function self.cardList.onUpdateItem(arg_6_0, arg_6_1)
		self:onUpdateCard(arg_6_0, arg_6_1)

		return
	end

	function self.cardList.onReturnItem(arg_7_0, arg_7_1)
		self:onReturnCard(arg_7_0, arg_7_1)

		return
	end

	self._loader = AutoLoader.New()

	return
end

function TrophyGalleryLayer:checkTrophyVisible(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1:GetTrophyPage() ~= arg_8_2 then
		return false
	end

	local var_8_0 = false

	if arg_8_3 == "all" then
		var_8_0 = true
	elseif arg_8_3 == "claimed" then
		var_8_0 = arg_8_1:getMaxClaimedTrophy() ~= nil
	end

	if arg_8_2 == TrophyGalleryLayer.PAGE_LIMITED and self._hideExpire and arg_8_1:IsExpire() == 1 then
		if not arg_8_1:getProgressTrophy():isClaimed() then
			var_8_0 = false
		end
	end

	return var_8_0
end

function TrophyGalleryLayer:ensureTrophyViewCache(arg_9_1)
	if self._trophyViewCache[arg_9_1] then
		return self._trophyViewCache[arg_9_1]
	end

	local var_9_0 = cloneTplTo(self._trophyUpperTpl, self._trophyContainer)
	local var_9_1 = cloneTplTo(self._trophyLowerTpl, self._trophyContainer)

	local function var_9_2()
		local var_10_0 = self.trophyGroups[arg_9_1]:getProgressTrophy()

		if not self._trophyTFList[arg_9_1] then
			return
		end

		if var_10_0:canClaimed() and not var_10_0:isClaimed() then
			if not self._trophyTFList[arg_9_1]:IsPlaying() then
				self:emit(TrophyGalleryMediator.ON_TROPHY_CLAIM, var_10_0.id)
			end
		elseif not self._trophyTFList[arg_9_1]:IsPlaying() then
			self:openTrophyDetail(self.trophyGroups[arg_9_1], var_10_0)
		end

		return
	end

	onButton(self, var_9_0.transform:Find("frame"), var_9_2)
	onButton(self, var_9_1.transform:Find("frame"), var_9_2)
	setActive(var_9_0, false)
	setActive(var_9_1, false)

	local var_9_3 = {
		upperGO = var_9_0,
		lowerGO = var_9_1,
		upperView = TrophyView.New(var_9_0),
		lowerView = TrophyView.New(var_9_1)
	}

	self._trophyViewCache[arg_9_1] = var_9_3

	return var_9_3
end

function TrophyGalleryLayer:updateTrophyViewByFilter(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3 == "all" then
		arg_11_1:UpdateTrophyGroup(arg_11_2)
	elseif arg_11_3 == "claimed" then
		arg_11_1:ClaimForm(arg_11_2)
	elseif arg_11_3 == "unclaim" then
		arg_11_1:ProgressingForm(arg_11_2)
	end

	return
end

function TrophyGalleryLayer:updateTrophyReminderMaterial(arg_12_1)
	local var_12_0 = arg_12_1:GetTrophyClaimTipsID()

	if self._trophyMatCache[var_12_0] then
		arg_12_1:SetTrophyReminderMaterial(self._trophyMatCache[var_12_0])

		return
	end

	if checkABExist("artresource/effect/xunzhang/materials/" .. var_12_0) then
		self._loader:LoadBundle("artresource/effect/xunzhang/materials/" .. var_12_0, function(arg_13_0)
			local var_13_0 = arg_13_0:LoadAssetSync(var_12_0, typeof(Material), false, false)

			self._trophyMatCache[var_12_0] = var_13_0

			arg_12_1:SetTrophyReminderMaterial(var_13_0)

			return
		end)
	end

	return
end

function TrophyGalleryLayer:didEnter()
	self:OverlayPanel(self._tf)
	onButton(self, self._backBtn, function()
		self:emit(TrophyGalleryLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(self, self._filterBtn, function()
		self:onFilter()

		return
	end, SFX_PANEL)
	onButton(self, self._helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.medal_help_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self._hideExpireBtn, function()
		self._hideExpire = not self._hideExpire

		setActive(self._hideExpireCheck, not self._hideExpire)
		self:updateTrophyList()

		return
	end, SFX_PANEL)
	triggerButton(self._hideExpireBtn)

	for iter_14_0, iter_14_1 in ipairs(self._pageToggle) do
		onButton(self, iter_14_1, function()
			self:updatePage(iter_14_0)

			return
		end, SFX_PANEL)
	end

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(self.toggleLoveLetter:Find("tip"), {
		"love_letter_level_up",
		"love_letter_level_reward"
	}, function(arg_20_0)
		local var_20_0 = getProxy(LoveLetterProxy)

		setActive(arg_20_0, var_20_0:IsTipLevelUp() or var_20_0:IsTipAllLevelReward())

		return
	end)
	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(self.rtCountLevelPanel:Find("info/icon/tip"), {
		"love_letter_level_up",
		"love_letter_level_reward"
	}, function(arg_21_0)
		setActive(arg_21_0, getProxy(LoveLetterProxy):IsTipAllLevelReward())

		return
	end)

	self._filterIndex = 0

	triggerButton(self._filterBtn)
	triggerButton(self._pageToggle[self._pageIndex])
	self:updateTrophyCounter()

	return
end

function TrophyGalleryLayer:updatePage(arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(self._pageToggle) do
		setActive(iter_22_1:Find("selected"), iter_22_0 == arg_22_1)
		setActive(iter_22_1:Find("Image"), iter_22_0 ~= arg_22_1)
	end

	self._pageIndex = arg_22_1

	local var_22_0 = arg_22_1 == 3

	setActive(self._center, not (arg_22_1 == 3))
	setActive(self._topPanel:Find("filter"), not var_22_0)
	setActive(self.rtLoveLetterPanel, var_22_0)
	setActive(self.rtCountLevelPanel, var_22_0)
	setActive(self.rtCountLevelBg, var_22_0)

	if var_22_0 then
		self:updateLoveLetterPage()
	else
		self:updateTrophyList()
	end

	setActive(self._hideExpireBtn, arg_22_1 == TrophyGalleryLayer.PAGE_LIMITED)

	return
end

function TrophyGalleryLayer:updateTrophyList()
	self._trophyTFList = {}

	for iter_23_0, iter_23_1 in pairs(self._trophyViewCache) do
		setActive(iter_23_1.upperGO, false)
		setActive(iter_23_1.lowerGO, false)
	end

	local var_23_0 = TrophyGalleryLayer.Filter[self._filterIndex]
	local var_23_1 = 1

	for iter_23_2, iter_23_3 in pairs(self.trophyGroups) do
		if self:checkTrophyVisible(iter_23_3, self._pageIndex, var_23_0) then
			local var_23_2 = self:ensureTrophyViewCache(iter_23_2)
			local var_23_3 = math.fmod(var_23_1, 2) == 1
			local var_23_4

			if var_23_3 then
				var_23_4 = var_23_2.upperGO or var_23_2.lowerGO

				local var_23_5

				if var_23_3 then
					var_23_5 = var_23_2.lowerGO or var_23_2.upperGO

					local var_23_6

					if var_23_3 then
						var_23_6 = var_23_2.upperView or var_23_2.lowerView
					end
				end
			end

			setActive(var_23_4, true)
			setActive(var_23_5, false)
			var_23_4.transform:SetSiblingIndex(var_23_1 - 1)
			self:updateTrophyViewByFilter(var_23_6, iter_23_3, var_23_0)
			self:updateTrophyReminderMaterial(var_23_6)

			self._trophyTFList[iter_23_2] = var_23_6
			var_23_1 = var_23_1 + 1
		end
	end

	return
end

function TrophyGalleryLayer:PlayTrophyClaim(arg_24_1)
	self._trophyTFList[arg_24_1]:PlayClaimAnima(self.trophyGroups[arg_24_1], Instantiate(self._reminderRes:Find("claim_fx")), function()
		self:updateTrophyByGroup(arg_24_1)
		self:updateTrophyCounter()

		return
	end)

	return
end

function TrophyGalleryLayer:updateTrophyByGroup(arg_26_1)
	self._trophyTFList[arg_26_1]:UpdateTrophyGroup(self.trophyGroups[arg_26_1])

	return
end

function TrophyGalleryLayer:openTrophyDetail(arg_27_1, arg_27_2)
	self._trophyDetailPanel:SetTrophyGroup(arg_27_1)
	self._trophyDetailPanel:UpdateTrophy(arg_27_2)
	self._trophyDetailPanel:SetActive(true)

	return
end

function TrophyGalleryLayer:updateTrophyCounter()
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in pairs(self.trophyList) do
		if iter_28_1:isClaimed() and not iter_28_1:isHide() then
			var_28_0 = var_28_0 + 1
		end
	end

	setText(self._trophyCounter, var_28_0)

	return
end

function TrophyGalleryLayer:onFilter()
	self._filterIndex = self._filterIndex + 1

	if self._filterIndex > #TrophyGalleryLayer.Filter then
		self._filterIndex = 1
	end

	for iter_29_0 = 1, #TrophyGalleryLayer.Filter do
		setActive(self._filterBtn:GetChild(iter_29_0 - 1), iter_29_0 == self._filterIndex)
	end

	self:updateTrophyList()

	return
end

function TrophyGalleryLayer:updateLoveLetterPage()
	if not self.contextData.checkRalizeGift then
		self.contextData.checkRalizeGift = true

		if getProxy(LoveLetterProxy):IsTipRealizeGift() then
			self:emit(TrophyGalleryMediator.OPEN_REALIZE_GIFT_LAYER)
		end
	end

	self.cardInfos = getProxy(LoveLetterProxy):GetDisplayGroupList()

	self.cardList:SetTotalCount(#self.cardInfos, -1)

	local var_30_0 = getProxy(LoveLetterProxy)
	local var_30_1 = self.rtCountLevelPanel:Find("info")

	setText(var_30_1:Find("word"), i18n("loveactivity_ui_10"))
	setText(var_30_1:Find("count"), (var_30_0:GetAllLevel()))

	local var_30_2, var_30_3 = var_30_0:GetAllLevelProgress()

	if var_30_3 == 0 then
		setSlider(var_30_1:Find("Slider"), 0, 1, 1)
	else
		setSlider(var_30_1:Find("Slider"), 0, var_30_3, var_30_2)
	end

	setText(var_30_1:Find("Slider/Text"), var_30_2 .. "/" .. var_30_3)
	updateDrop(var_30_1:Find("icon/mask/IconTpl"), var_30_0:GetAllLevelNextAward()[1])
	onButton(self, var_30_1:Find("icon/mask/IconTpl"), function()
		self:emit(BaseUI.ON_DROP, drop[1])

		return
	end, SFX_PANEL)
	setActive(var_30_1:Find("icon/got"), var_30_3 == 0)
	onButton(self, var_30_1:Find("click"), function()
		local var_32_0 = getProxy(LoveLetterProxy):GetAllLevelReadyReward()
		local var_32_1 = pg.NewStyleMsgboxMgr.GetInstance()
		local var_32_2 = pg.NewStyleMsgboxMgr.TYPE_LOVE_LETTER_LEVEL_REWARD
		local var_32_3 = {}

		var_32_3.btnList = #var_32_0 > 0 and {
			{
				type = pg.NewStyleMsgboxMgr.BUTTON_TYPE.cancel,
				name = i18n("msgbox_text_cancel"),
				sound = SFX_CANCEL
			},
			{
				type = pg.NewStyleMsgboxMgr.BUTTON_TYPE.confirm,
				name = i18n("mail_get_oneclick"),
				func = function()
					self:emit(TrophyGalleryMediator.ON_GET_ALL_LOVE_LETTER_REWARD, var_32_0)

					return
				end,
				sound = SFX_CONFIRM
			}
		} or nil

		var_32_1:Show(var_32_2, var_32_3)

		return
	end, SFX_PANEL)

	return
end

function TrophyGalleryLayer:onInitCard(arg_34_1)
	local var_34_0 = LoveLetterShipCard.New(arg_34_1)

	onButton(self, var_34_0.go, function()
		if var_34_0.shipGroup then
			self:emit(TrophyGalleryMediator.OPEN_DISPLAY_WINDOW, var_34_0.shipGroup.id)
		end

		return
	end)

	self.cardItems[arg_34_1] = var_34_0

	return
end

function TrophyGalleryLayer:onUpdateCard(arg_36_1, arg_36_2)
	local var_36_0 = self.cardItems[arg_36_2]

	if not self.cardItems[arg_36_2] then
		self:onInitCard(arg_36_2)

		var_36_0 = self.cardItems[arg_36_2]
	end

	local var_36_1 = self.cardInfos[arg_36_1 + 1]

	var_36_0:update(self.cardInfos[arg_36_1 + 1])
	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(arg_36_2.transform:Find("content/pick_up"), {
		"love_letter_level_up"
	}, function(arg_37_0)
		local var_37_0 = getProxy(LoveLetterProxy):GetGroupData(var_36_1.id)

		setActive(arg_37_0, var_37_0:GetDisplayLevel() < var_37_0:GetMaxLevel() and var_37_0:CanLevelUp())

		return
	end)

	return
end

function TrophyGalleryLayer:onReturnCard(arg_38_1, arg_38_2)
	if self.exited then
		return
	end

	if self.cardItems[arg_38_2] then
		self.cardItems[arg_38_2]:clear()
	end

	self.cardItems[arg_38_2] = nil

	return
end

function TrophyGalleryLayer:onBackPressed()
	if self._trophyDetailPanel:IsActive() then
		self._trophyDetailPanel:SetActive(false)
	else
		TrophyGalleryLayer.super.onBackPressed(self)
	end

	return
end

function TrophyGalleryLayer:willExit()
	self._loader:Clear()
	pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(self.toggleLoveLetter:Find("tip"))
	pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(self.rtCountLevelPanel:Find("info/icon/tip"))

	for iter_40_0, iter_40_1 in pairs(self.cardItems) do
		pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(iter_40_0.transform:Find("content/pick_up"))
	end

	self:UnOverlayPanel(self._blurPanel, self._tf)
	self._trophyDetailPanel:Dispose()

	return
end

return TrophyGalleryLayer
