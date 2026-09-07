local WorldMediaCollectionAlbumGroupLayer = class("WorldMediaCollectionAlbumGroupLayer", import(".WorldMediaCollectionSubLayer"))

WorldMediaCollectionAlbumGroupLayer.ALBUM_TYPE_BASE = 1
WorldMediaCollectionAlbumGroupLayer.ALBUM_TYPE_LOVE_LETTER = 2

function WorldMediaCollectionAlbumGroupLayer:getUIName()
	return "WorldMediaCollectionAlbumGroupUI"
end

function WorldMediaCollectionAlbumGroupLayer:OnInit()
	WorldMediaCollectionAlbumGroupLayer.super.OnInit(self)
	assert(self.viewParent, "Need assign ViewParent for " .. self.__cname)

	self.albumGroups = _.map(pg.activity_medal_group.all, function(arg_3_0)
		return pg.activity_medal_group[arg_3_0]
	end)
	self.albumGroupList = self._tf:Find("GroupRect"):GetComponent("LScrollRect")

	function self.albumGroupList.onInitItem(arg_4_0)
		self:onInitAlbumGroup(arg_4_0)

		return
	end

	function self.albumGroupList.onUpdateItem(arg_5_0, arg_5_1)
		self:onUpdateAlbumGroup(arg_5_0 + 1, arg_5_1)

		return
	end

	self.albumGroupInfos = {}

	setActive(tf(self.albumGroupList):Find("GroupItem"), false)

	self.albumGroupViewport = tf(self.albumGroupList):Find("Viewport")
	self.albumGroupsGrid = tf(self.albumGroupList):Find("Viewport/Content"):GetComponent(typeof(GridLayoutGroup))
	self.loader = AutoLoader.New()

	setText(self._tf:Find("top/expireCheckBox/text"), i18n("word_show_expire_content"))

	self.showExpireBtn = self._tf:Find("top/expireCheckBox/click")
	self.showExpireCheckBox = self._tf:Find("top/expireCheckBox/checkBox/check")
	self.showExpire = false

	setActive(self.showExpireCheckBox, self.showExpire)
	onButton(self, self.showExpireBtn, function()
		self.showExpire = not self.showExpire

		setActive(self.showExpireCheckBox, self.showExpire)
		self:ExpireFilter()
		self:UpdateView()

		return
	end)

	self.rectAnchorX = self._tf:Find("GroupRect").anchoredPosition.x

	onToggle(self, self.toggleBase, function(arg_7_0)
		if arg_7_0 then
			self:SetPage(false)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.toggleLoveLetter, function(arg_8_0)
		if arg_8_0 then
			self:SetPage(true)
		end

		return
	end, SFX_PANEL)

	self.initDic = {}
	self.cardItems = {}
	self.cardList = self.rtScrollRect:GetComponent("LScrollRect")

	function self.cardList.onInitItem(arg_9_0)
		self:onInitCard(arg_9_0)

		return
	end

	function self.cardList.onUpdateItem(arg_10_0, arg_10_1)
		self:onUpdateCard(arg_10_0, arg_10_1)

		return
	end

	function self.cardList.onReturnItem(arg_11_0, arg_11_1)
		self:onReturnCard(arg_11_0, arg_11_1)

		return
	end

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(self.toggleLoveLetter:Find("tip"), {
		"love_letter_unlock_letter"
	}, function(arg_12_0)
		setActive(arg_12_0, getProxy(LoveLetterProxy):IsTipUnlockLetter())

		return
	end)

	if self.contextData.albumType == WorldMediaCollectionAlbumGroupLayer.ALBUM_TYPE_LOVE_LETTER then
		triggerToggle(self.toggleLoveLetter, true)
	else
		triggerToggle(self.toggleBase, true)
	end

	return
end

function WorldMediaCollectionAlbumGroupLayer:SetPage(arg_13_1)
	setActive(self.rtGroupRect, not arg_13_1)
	setActive(self.rtExpireCheckBox, not arg_13_1)
	setActive(self.rtLoveLetterPanel, arg_13_1)

	if not self.initDic[arg_13_1] then
		switch(arg_13_1, {
			[false] = function()
				self:ExpireFilter()
				self:UpdateView()

				return
			end,
			[true] = function()
				self:updateLoveLetterPage()

				return
			end
		}, nil)

		self.initDic[arg_13_1] = true
	end

	return
end

function WorldMediaCollectionAlbumGroupLayer:onInitAlbumGroup(arg_16_1)
	if self.exited then
		return
	end

	onButton(self, arg_16_1, function()
		if self.albumGroupInfos[arg_16_1] then
			self.viewParent:ShowAlbum(self.albumGroupInfos[arg_16_1])
		end

		return
	end, SOUND_BACK)

	return
end

function WorldMediaCollectionAlbumGroupLayer:onUpdateAlbumGroup(arg_18_1, arg_18_2)
	if self.exited then
		return
	end

	local var_18_0 = self.albumGroups[arg_18_1]

	self.albumGroupInfos[arg_18_2] = self.albumGroups[arg_18_1]

	self.loader:GetSpriteQuiet(var_18_0.entrance_picture, "", tf(arg_18_2):Find("BG"))
	setActive(tf(arg_18_2):Find("expireMask"), ActivityMedalGroup.IsMedalGroupCollectionGrey(var_18_0.id) and ActivityMedalGroup.GetMedalGroupStateByID(var_18_0.id) < ActivityMedalGroup.STATE_ACTIVE)

	return
end

function WorldMediaCollectionAlbumGroupLayer:Return2MemoryGroup()
	self.albumGroupList:SetTotalCount(#self.albumGroups, (self:GetIndexRatio(0)))

	return
end

function WorldMediaCollectionAlbumGroupLayer:SwitchReddotMemory()
	local var_20_0 = 0
	local var_20_1 = getProxy(PlayerProxy):getRawData().id

	for iter_20_0, iter_20_1 in ipairs(self.albumGroups) do
		if PlayerPrefs.GetInt("ALBUM_GROUP_NOTIFICATION" .. var_20_1 .. " " .. iter_20_1.id, 0) == 1 then
			var_20_0 = iter_20_0

			break
		end
	end

	if var_20_0 == 0 then
		return
	end

	self.albumGroupList:SetTotalCount(#self.albumGroups, (self:GetIndexRatio(var_20_0)))

	return
end

function WorldMediaCollectionAlbumGroupLayer:GetIndexRatio(arg_21_1)
	local var_21_0 = 0

	if arg_21_1 > 0 then
		var_21_0 = ((self.albumGroupsGrid.cellSize.y + self.albumGroupsGrid.spacing.y) * math.floor((arg_21_1 - 1) / self.albumGroupsGrid.constraintCount) + self.albumGroupList.paddingFront) / ((self.albumGroupsGrid.cellSize.y + self.albumGroupsGrid.spacing.y) * math.ceil(#self.albumGroups / self.albumGroupsGrid.constraintCount) - self.albumGroupViewport.rect.height)
		var_21_0 = Mathf.Clamp01(var_21_0)
	end

	return var_21_0
end

function WorldMediaCollectionAlbumGroupLayer:ExpireFilter()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(pg.activity_medal_group.all) do
		if self.showExpire or ActivityMedalGroup.GetMedalGroupStateByID(pg.activity_medal_group[iter_22_1].id) >= ActivityMedalGroup.STATE_ACTIVE then
			table.insert(var_22_0, pg.activity_medal_group[iter_22_1])
		end
	end

	self.albumGroups = var_22_0

	return
end

function WorldMediaCollectionAlbumGroupLayer:UpdateView()
	setAnchoredPosition(self._tf:Find("GroupRect"), {
		x = WorldMediaCollectionScene.WorldRecordLock() and 0 or self.rectAnchorX
	})
	self.albumGroupList:SetTotalCount(#self.albumGroups, 0)

	return
end

function WorldMediaCollectionAlbumGroupLayer:updateLoveLetterPage()
	self.cardInfos = getProxy(LoveLetterProxy):GetDisplayLetterList()

	onDelayTick(function()
		self.cardList.enabled = true

		self.cardList:SetTotalCount(#self.cardInfos, 0)

		return
	end, 0.001)

	return
end

function WorldMediaCollectionAlbumGroupLayer:onInitCard(arg_26_1)
	local var_26_0 = LoveLetterShipCard.New(arg_26_1)

	self.cardItems[arg_26_1] = var_26_0

	onButton(self, var_26_0.go, function()
		if var_26_0.shipGroup then
			self:emit(WorldMediaCollectionMediator.OPEN_LOVE_LETTER_DISPLAY, var_26_0.shipGroup.id)
		end

		return
	end)

	return
end

function WorldMediaCollectionAlbumGroupLayer:onUpdateCard(arg_28_1, arg_28_2)
	local var_28_0 = self.cardItems[arg_28_2]

	if not self.cardItems[arg_28_2] then
		self:onInitCard(arg_28_2)

		var_28_0 = self.cardItems[arg_28_2]
	end

	local var_28_1 = self.cardInfos[arg_28_1 + 1]

	var_28_0:update(self.cardInfos[arg_28_1 + 1])
	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(arg_28_2.transform:Find("content/pick_up"), {
		"love_letter_unlock_letter"
	}, function(arg_29_0)
		local var_29_0 = getProxy(LoveLetterProxy):GetGroupData(var_28_1.id)

		setActive(arg_29_0, underscore.any(var_29_0:GetDisplayLetterList(), function(arg_30_0)
			return not var_29_0:GetLetterUnlock(arg_30_0)
		end))

		return
	end)

	return
end

function WorldMediaCollectionAlbumGroupLayer:onReturnCard(arg_31_1, arg_31_2)
	if self.exited then
		return
	end

	if self.cardItems[arg_31_2] then
		self.cardItems[arg_31_2]:clear()
	end

	self.cardItems[arg_31_2] = nil

	return
end

function WorldMediaCollectionAlbumGroupLayer:OnDestroy()
	for iter_32_0, iter_32_1 in pairs(self.cardItems) do
		pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(iter_32_0.transform:Find("content/pick_up"))
	end

	pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(self.toggleLoveLetter:Find("tip"))

	return
end

return WorldMediaCollectionAlbumGroupLayer
