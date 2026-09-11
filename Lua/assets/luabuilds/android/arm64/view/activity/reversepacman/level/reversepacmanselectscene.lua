local ReversePacmanSelectScene = class("ReversePacmanSelectScene", import("view.base.BaseUI"))

ReversePacmanSelectScene.LEVEL_TYPES = {
	EASY = 1,
	HARD = 2
}
ReversePacmanSelectScene.SHIP_TYPES = {
	ALL = 0,
	FOLLOW = 1,
	FLEXIBLE = 3,
	PREJUDGE = 2
}

local var_0_1 = pg.activity_chasing_level
local var_0_2 = pg.activity_chasing_character

function ReversePacmanSelectScene:getUIName()
	return "ReversePacmanSelectUI"
end

function ReversePacmanSelectScene:init()
	setText(self.uiDeployTipText, i18n("reverse_pacman_deploy_tip"))
	setText(self.uiLevelPanelTF:Find("left/title/Text"), i18n("reverse_pacman_select_level_title"))
	setText(self.uiShipPanelTF:Find("left/title/Text"), i18n("reverse_pacman_select_ship_title"))
	onButton(self, self.uiTopTF:Find("back"), function()
		self:onBackPressed()

		return
	end, SOUND_BACK)
	onButton(self, self.uiTopTF:Find("home"), function()
		self:quickExitFunc()

		return
	end, SOUND_BACK)
	setActive(self.uiLevelPanelTF, true)
	eachChild(self.uiLevelTogglesTF, function(arg_5_0)
		local var_5_0 = tonumber(arg_5_0.name)

		setText(arg_5_0:Find("Text"), i18n("reverse_pacman_level_type_" .. var_5_0))
		onToggle(self, arg_5_0, function(arg_6_0)
			if arg_6_0 then
				self:UpdateLevelList(var_5_0)
			end

			return
		end)

		return
	end)

	self.levelUIList = UIItemList.New(self.uiLevelContentTF, self.uiLevelContentTF:Find("tpl"))

	self.levelUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateLevelTpl(arg_7_1, arg_7_2)
		end

		return
	end)
	onButton(self, self.uiDeployBtn, function()
		self:SwitchShipView()

		return
	end, SFX_PANEL)

	self.awardUIList = UIItemList.New(self.uiMapAwardTF, self.uiMapAwardTF:Find("tpl"))

	self.awardUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = self.awards[arg_9_1 + 1]

			updateDrop(arg_9_2, self.awards[arg_9_1 + 1])
			onButton(self, arg_9_2, function()
				self:emit(BaseUI.ON_DROP, var_9_0)

				return
			end, SFX_PANEL)
			setActive(arg_9_2:Find("got"), self.levelGradeRecords[self.selLevelId])
		end

		return
	end)
	setActive(self.uiShipPanelTF, false)
	eachChild(self.uiShipTogglesTF, function(arg_11_0)
		local var_11_0 = tonumber(arg_11_0.name)

		setText(arg_11_0:Find("Text"), var_11_0)
		setText(arg_11_0:Find("Text"), i18n("reverse_pacman_ship_type_" .. var_11_0))
		onToggle(self, arg_11_0, function(arg_12_0)
			if arg_12_0 then
				self:UpdateShipList(var_11_0)
			end

			return
		end)

		return
	end)

	self.shipUIList = UIItemList.New(self.uiShipContentTF, self.uiShipContentTF:Find("tpl"))

	self.shipUIList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			self:UpdateShipTpl(arg_13_1, arg_13_2)
		end

		return
	end)
	onButton(self, self.uiAutoBtn, function()
		self:ApplyAutoDeploy()

		return
	end, SFX_PANEL)
	onButton(self, self.uiStartBtn, function()
		if not underscore.any(self.slotShipIds, function(arg_16_0)
			return arg_16_0 ~= 0
		end) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("reverse_pacman_deploy_empty"))

			return
		end

		local var_15_0 = {}

		for iter_15_0, iter_15_1 in ipairs(self.buffIds) do
			var_15_0[iter_15_0] = iter_15_1 ~= 0 and self.activity:GetVitemNumber(pg.activity_chasing_skill[iter_15_1].item_id) or 0
		end

		self:emit(ReversePacmanSelectMediator.GO_SCENE, SCENE.REVERSE_PACMAN_GAME, {
			levelId = self.selLevelId,
			slotShipIds = self.slotShipIds,
			buffIds = self.buffIds,
			buffCnts = var_15_0,
			eduBuffCnt = self.activity:GetVitemNumber(pg.activity_chasing_skill[ReversePacmanConst.BUFF_EDU].item_id)
		})

		return
	end, SFX_PANEL)

	self.buffSlotUIList = UIItemList.New(self.uiBuffSlotsTF, self.uiBuffSlotsTF:Find("tpl"))

	self.buffSlotUIList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = self.buffIds[arg_17_1 + 1]
			local var_17_1 = self.buffIds[arg_17_1 + 1] == 0

			setActive(arg_17_2:Find("empty"), self.buffIds[arg_17_1 + 1] == 0)
			setActive(arg_17_2:Find("icon"), not var_17_1)

			if not var_17_1 then
				LoadImageSpriteAsync(pg.activity_chasing_skill[var_17_0].icon, arg_17_2:Find("icon"))
			end

			setActive(arg_17_2:Find("Text"), false)
			onButton(self, arg_17_2, function()
				self.buffSubView:ExecuteAction("Show", self.mapData.skillSlotCount, function()
					self:UpdateShipViewWithBuff()

					return
				end)

				return
			end, SFX_PANEL)
		end

		return
	end)

	self.buffSubView = ReversePacmanBuffSubView.New(self._tf, self.event, self.contextData)

	return
end

function ReversePacmanSelectScene:SetData()
	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_REVERSE_PACMAN)

	assert(self.activity and not self.activity:isEnd(), "not exist act, type: " .. ActivityConst.ACTIVITY_TYPE_REVERSE_PACMAN)

	self.mapDataDic = {}

	for iter_20_0, iter_20_1 in ipairs(var_0_1.all) do
		self.mapDataDic[iter_20_1] = require("view.activity.ReversePacman.Maps." .. var_0_1[iter_20_1].map_json)
	end

	self.gridType2tpl = {
		[ReversePacmanConst.GRID.BLOCK] = self.uiMapTpls:Find("block"),
		[ReversePacmanConst.GRID.ROAD] = self.uiMapTpls:Find("road"),
		[ReversePacmanConst.GRID.SPAWN] = self.uiMapTpls:Find("spawn"),
		[ReversePacmanConst.GRID.DEPLOY] = self.uiMapTpls:Find("deploy")
	}
	self.levelTimeRecords = self.activity:GetStageDataList()

	local var_20_0 = underscore.keys(self.levelTimeRecords)

	self.unlockHard = #var_20_0 > 0
	self.levelGradeRecords = {}

	for iter_20_2, iter_20_3 in ipairs(var_20_0) do
		self.levelGradeRecords[iter_20_3] = ReversePacmanConst.GetGrade(self.mapDataDic[iter_20_3].duration - self.levelTimeRecords[iter_20_3], self.mapDataDic[iter_20_3].duration, self.mapDataDic[iter_20_3].ratingThresholds)
	end

	self.allSortShipIds = self.activity:GetRoleIds()

	table.sort(self.allSortShipIds, CompareFuncs({
		function(arg_21_0)
			return -var_0_2[arg_21_0].base_speed
		end,
		function(arg_22_0)
			return arg_22_0
		end
	}))

	return
end

function ReversePacmanSelectScene:didEnter()
	self:SetData()

	local var_23_0 = self.uiLevelTogglesTF:Find(tostring(ReversePacmanSelectScene.LEVEL_TYPES.HARD))

	setActive(var_23_0:Find("lock"), not self.unlockHard)
	onButton(self, var_23_0:Find("lock"), function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("reverse_pacman_select_level_lock_tip"))

		return
	end, SFX_PANEL)
	self:UpdateLevelToggleTips()
	setToggleEnabled(var_23_0, self.unlockHard)
	triggerToggle(self.uiLevelTogglesTF:Find(tostring(self.contextData.levelType or ReversePacmanSelectScene.LEVEL_TYPES.EASY)), true)

	return
end

function ReversePacmanSelectScene:UpdateLevelToggleTips()
	setActive(self.uiLevelTogglesTF:Find(tostring(ReversePacmanSelectScene.LEVEL_TYPES.EASY) .. "/tip"), (underscore.any(var_0_1.all, function(arg_26_0)
		return var_0_1[arg_26_0].difficulty == ReversePacmanSelectScene.LEVEL_TYPES.EASY and self.activity:IsUnlockStage(arg_26_0) and not self.levelGradeRecords[arg_26_0] and self.activity:IsLevelTip(arg_26_0)
	end)))
	setActive(self.uiLevelTogglesTF:Find(tostring(ReversePacmanSelectScene.LEVEL_TYPES.HARD) .. "/tip"), (underscore.any(var_0_1.all, function(arg_27_0)
		return var_0_1[arg_27_0].difficulty == ReversePacmanSelectScene.LEVEL_TYPES.HARD and self.activity:IsUnlockStage(arg_27_0) and not self.levelGradeRecords[arg_27_0] and self.activity:IsLevelTip(arg_27_0)
	end)))

	return
end

function ReversePacmanSelectScene:SwitchLevelView()
	setActive(self.uiLevelPanelTF, true)
	setActive(self.uiDeployBtn, true)
	setActive(self._tf:Find("right/awards"), true)
	setActive(self.uiShipPanelTF, false)
	self:SetDeployVisibility(false)

	return
end

function ReversePacmanSelectScene:UpdateLevelList(arg_29_1)
	self.levelType = arg_29_1
	self.contextData.levelType = arg_29_1
	self.showLevelIds = {}

	for iter_29_0, iter_29_1 in ipairs(var_0_1.all) do
		if var_0_1[iter_29_1].difficulty == arg_29_1 then
			table.insert(self.showLevelIds, iter_29_1)
		end
	end

	self.levelUIList:align(#self.showLevelIds)

	local var_29_0 = (function()
		for iter_30_0, iter_30_1 in ipairs(self.showLevelIds) do
			if not self.levelGradeRecords[iter_30_1] and self.activity:IsUnlockStage(iter_30_1) then
				return iter_30_1
			end
		end

		return self.showLevelIds[1]
	end)()

	triggerButton(self.uiLevelContentTF:Find(tostring(var_29_0)))
	scrollToIndex(self.levelUIList.container, (table.indexof(self.showLevelIds, var_29_0)))

	return
end

function ReversePacmanSelectScene:UpdateLevelTpl(arg_31_1, arg_31_2)
	local var_31_0 = self.showLevelIds[arg_31_1 + 1]

	arg_31_2.name = tostring(self.showLevelIds[arg_31_1 + 1])

	local var_31_1 = var_0_1[var_31_0]

	setText(arg_31_2:Find("unsel/Text"), var_0_1[var_31_0].name)
	setText(arg_31_2:Find("sel/Text"), var_31_1.name)

	local var_31_2 = self.levelGradeRecords[var_31_0]

	setActive(arg_31_2:Find("sel/grade"), self.levelGradeRecords[var_31_0])
	setActive(arg_31_2:Find("unsel/grade"), var_31_2)

	if var_31_2 then
		LoadImageSpriteAtlasAsync("ui/reversepacmanui_atlas", "level_" .. var_31_2, arg_31_2:Find("sel/grade/Image"))
		LoadImageSpriteAtlasAsync("ui/reversepacmanui_atlas", "level_" .. var_31_2 .. "_1", arg_31_2:Find("unsel/grade/Image"))
	end

	local var_31_3 = self.activity:IsUnlockStage(var_31_0)
	local var_31_4 = self.selLevelId == var_31_0

	setActive(arg_31_2:Find("lock"), not var_31_3)
	setActive(arg_31_2:Find("sel"), var_31_3 and var_31_4)
	setActive(arg_31_2:Find("unsel"), var_31_3 and not var_31_4)
	setActive(arg_31_2:Find("tip"), var_31_3 and not var_31_2 and self.activity:IsLevelTip(var_31_0))

	if not var_31_3 then
		setText(arg_31_2:Find("lock/Text"), var_31_1.unlock_date)

		local var_31_5 = pg.TimeMgr.GetInstance()
		local var_31_6 = var_31_5:parseTimeFromConfig(var_31_1.unlock_date[1])

		setText(arg_31_2:Find("lock/Text"), i18n("reverse_pacman_unlock_date_tip", var_31_5:STimeDescS(var_31_6, "%m"), (var_31_5:STimeDescS(var_31_6, "%d"))))
	end

	onButton(self, arg_31_2, function()
		if not var_31_3 then
			return
		end

		if self.selLevelId and var_31_0 == self.selLevelId then
			return
		end

		if not var_31_2 then
			self.activity:SetLevelTip(var_31_0)
			setActive(arg_31_2:Find("tip"), false)
			self:UpdateLevelToggleTips()
		end

		self.selLevelId = var_31_0

		self.levelUIList:align(#self.showLevelIds)
		self:UpdateLevelView()

		return
	end, SFX_PANEL)

	return
end

function ReversePacmanSelectScene:UpdateLevelView()
	self.mapData = self.mapDataDic[self.selLevelId]

	setText(self.uiMapInfosTF:Find("terrain"), var_0_1[self.selLevelId].terrain_tags)
	setText(self.uiMapInfosTF:Find("time"), self.mapData.duration .. "s")
	setText(self.uiMapInfosTF:Find("monster_cnt"), #self.mapData.spawnPoints)
	setText(self.uiMapInfosTF:Find("monster_speed"), var_0_1[self.selLevelId].monster_speed_rating)
	setActive(self.uiMapGradeExistTF, self.levelGradeRecords[self.selLevelId])
	setActive(self.uiMapGradeNoTF, not self.levelGradeRecords[self.selLevelId])

	if self.levelGradeRecords[self.selLevelId] then
		LoadImageSpriteAtlasAsync("ui/reversepacmanui_atlas", "level_" .. self.levelGradeRecords[self.selLevelId], self.uiMapGradeExistTF:Find("Image"), true)
	end

	local var_33_0 = var_0_1[self.selLevelId].first_clear_reward

	self.awards = {}

	if var_33_0 and type(var_33_0) == "table" then
		self.awards = underscore.map(var_33_0, function(arg_34_0)
			return Drop.Create(arg_34_0)
		end)
	end

	self.awardUIList:align(#self.awards)
	self:UpdateMap()
	self:SetDeployVisibility(false)

	return
end

function ReversePacmanSelectScene:UpdateMap()
	removeAllChildren(self.uiMapGridsTF)
	removeAllChildren(self.uiMapRolesTF)

	local var_35_0 = ReversePacmanConst.GRID_SIZE_2
	local var_35_1 = {
		x = self.mapData.width * ReversePacmanConst.GRID_SIZE_2.x,
		y = self.mapData.height * ReversePacmanConst.GRID_SIZE_2.y
	}

	setSizeDelta(self.uiMapGridsTF, var_35_1)
	setSizeDelta(self.uiMapRolesTF, var_35_1)

	self.deployTFs = {}
	self.deployPosList = {}
	self.monsterPosList = {}

	for iter_35_0, iter_35_1 in ipairs(self.mapData.grid) do
		for iter_35_2, iter_35_3 in ipairs(iter_35_1) do
			local var_35_2 = cloneTplTo(self.gridType2tpl[(iter_35_3 ~= ReversePacmanConst.GRID.BLOCK or nil) and (ReversePacmanConst.GRID.ROAD or ReversePacmanConst.GRID.BLOCK)], self.uiMapGridsTF)

			var_35_2.name = iter_35_2 .. "_" .. iter_35_0

			setActive(var_35_2, true)
			setLocalPosition(var_35_2, Vector2((iter_35_2 - 1) * var_35_0.x - var_35_1.x / 2 + var_35_0.x / 2, var_35_1.y / 2 - (iter_35_0 - 1) * var_35_0.y - var_35_0.y / 2))

			if iter_35_3 == ReversePacmanConst.GRID.DEPLOY then
				local var_35_3 = cloneTplTo(self.gridType2tpl[iter_35_3], self.uiMapRolesTF)

				table.insert(self.deployTFs, var_35_3)
				table.insert(self.deployPosList, {
					x = iter_35_2,
					y = iter_35_0
				})
				setLocalPosition(var_35_3, Vector2((iter_35_2 - 1) * var_35_0.x - var_35_1.x / 2 + var_35_0.x / 2, var_35_1.y / 2 - (iter_35_0 - 1) * var_35_0.y - var_35_0.y / 2))
			elseif iter_35_3 == ReversePacmanConst.GRID.SPAWN then
				local var_35_4 = cloneTplTo(self.gridType2tpl[iter_35_3], self.uiMapRolesTF)

				table.insert(self.monsterPosList, {
					x = iter_35_2,
					y = iter_35_0
				})
				setLocalPosition(var_35_4, Vector2((iter_35_2 - 1) * var_35_0.x - var_35_1.x / 2 + var_35_0.x / 2, var_35_1.y / 2 - (iter_35_0 - 1) * var_35_0.y - var_35_0.y / 2))
			end
		end
	end

	for iter_35_4, iter_35_5 in ipairs(self.deployTFs) do
		onButton(self, iter_35_5, function()
			if self.selSlot and self.selSlot == iter_35_4 then
				return
			end

			self.selSlot = iter_35_4

			self:UpdateShipViewWithShipOrSlot()

			return
		end, SFX_PANEL)
	end

	return
end

function ReversePacmanSelectScene:SetDeployVisibility(arg_37_1)
	for iter_37_0, iter_37_1 in ipairs(self.deployTFs) do
		setActive(iter_37_1, arg_37_1)
	end

	return
end

function ReversePacmanSelectScene:SwitchShipView()
	setActive(self.uiLevelPanelTF, false)
	setActive(self.uiDeployBtn, false)
	setActive(self._tf:Find("right/awards"), false)
	setActive(self.uiShipPanelTF, true)
	self:SetDeployVisibility(true)

	self.slotShipIds = {}

	for iter_38_0 = 1, #self.deployTFs do
		table.insert(self.slotShipIds, 0)
	end

	self.selSlot = 1

	if not self.shipType then
		triggerToggle(self.uiShipTogglesTF:Find(tostring(ReversePacmanSelectScene.SHIP_TYPES.ALL)), true)
	end

	self:UpdateShipView()

	return
end

function ReversePacmanSelectScene:UpdateShipView()
	self:UpdateShipViewWithShipOrSlot()
	self:UpdateShipViewWithBuff()

	return
end

function ReversePacmanSelectScene:UpdateShipList(arg_40_1)
	self.shipType = arg_40_1
	self.showShipIds = {}

	for iter_40_0, iter_40_1 in ipairs(self.allSortShipIds) do
		if arg_40_1 == ReversePacmanSelectScene.SHIP_TYPES.ALL or var_0_2[iter_40_1].ai_type == arg_40_1 then
			table.insert(self.showShipIds, iter_40_1)
		end
	end

	self.shipUIList:align(#self.showShipIds)

	return
end

function ReversePacmanSelectScene:UpdateShipTpl(arg_41_1, arg_41_2)
	local var_41_0 = self.showShipIds[arg_41_1 + 1]

	arg_41_2.name = tostring(self.showShipIds[arg_41_1 + 1])

	local var_41_1 = var_0_2[var_41_0]

	setText(arg_41_2:Find("name"), HXSet.hxLan(var_0_2[var_41_0].name))
	setActive(arg_41_2:Find("recommend"), table.contains(self.recommendIds, var_41_0))
	setActive(arg_41_2:Find("sel"), var_41_0 == self.slotShipIds[self.selSlot])
	setActive(arg_41_2:Find("occupy"), table.contains(self.slotShipIds, var_41_0))
	LoadImageSpriteAsync(var_41_1.sd_avatar, arg_41_2:Find("icon"))

	local var_41_2 = arg_41_2:Find("speed/Text")

	setTextColor(var_41_2, Color.white)
	setScrollText(var_41_2, i18n("reverse_pacman_select_ship_speed", ReversePacmanHomeConst.GetSpeedLevel(var_41_1.base_speed).value))
	setScrollText(arg_41_2:Find("tags/resume/Text"), var_41_1.resume_text)
	setScrollText(arg_41_2:Find("tags/trait/Text"), var_41_1.trait_text)
	onButton(self, arg_41_2, function()
		local var_42_0 = var_41_0

		if self.slotShipIds[self.selSlot] == var_41_0 then
			var_42_0 = 0
		end

		for iter_42_0, iter_42_1 in ipairs(self.slotShipIds) do
			if iter_42_1 == var_41_0 then
				self.slotShipIds[iter_42_0] = 0
			end
		end

		self.slotShipIds[self.selSlot] = var_42_0

		self:UpdateShipViewWithShipOrSlot()
		self:AutoSelEmotySlot()

		return
	end, SOUND_BACK)

	return
end

function ReversePacmanSelectScene:AutoSelEmotySlot()
	local var_43_0 = (function()
		for iter_44_0, iter_44_1 in ipairs(self.slotShipIds) do
			if iter_44_1 == 0 then
				return iter_44_0
			end
		end

		return
	end)()

	if var_43_0 and var_43_0 ~= self.selSlot then
		self.selSlot = var_43_0

		self:UpdateShipViewWithShipOrSlot()
	end

	return
end

function ReversePacmanSelectScene:UpdateShipViewWithShipOrSlot()
	self.recommendIds = self.mapData.deployPoints[self.selSlot].recommendedRoleIds

	table.sort(self.showShipIds, CompareFuncs({
		function(arg_46_0)
			return table.contains(self.recommendIds, arg_46_0) and 0 or 1
		end,
		function(arg_47_0)
			return arg_47_0
		end
	}))
	self.shipUIList:align(#self.showShipIds)

	for iter_45_0, iter_45_1 in ipairs(self.deployTFs) do
		setActive(iter_45_1:Find("selected"), self.selSlot == iter_45_0)
		setActive(iter_45_1:Find("ship"), self.slotShipIds[iter_45_0] ~= 0)

		if self.slotShipIds[iter_45_0] ~= 0 then
			LoadImageSpriteAsync(var_0_2[self.slotShipIds[iter_45_0]].sd_avatar, iter_45_1:Find("ship/Image"))
		end
	end

	return
end

function ReversePacmanSelectScene:UpdateShipViewWithBuff()
	self.buffIds = ReversePacmanBuffSubView.GetSelBuffIds(self.mapData.skillSlotCount)

	self.buffSlotUIList:align(self.mapData.skillSlotCount)

	return
end

function ReversePacmanSelectScene:ApplyAutoDeploy()
	local var_49_0 = {}
	local var_49_1 = {}
	local var_49_2 = {}

	for iter_49_0, iter_49_1 in ipairs(self.allSortShipIds) do
		var_49_0[iter_49_1] = true
	end

	for iter_49_2 = 1, #self.deployTFs do
		local var_49_3 = 0

		for iter_49_3, iter_49_4 in ipairs((self.mapData.deployPoints[iter_49_2] or nil) and (self.mapData.deployPoints[iter_49_2].recommendedRoleIds or {})) do
			if var_49_0[iter_49_4] and not var_49_1[iter_49_4] then
				var_49_3 = iter_49_4
				var_49_1[iter_49_4] = true

				break
			end
		end

		self.slotShipIds[iter_49_2] = var_49_3

		if var_49_3 == 0 then
			table.insert(var_49_2, iter_49_2)
		end
	end

	table.sort(var_49_2, CompareFuncs({
		function(arg_50_0)
			return self:_GetNeaestDis(arg_50_0)
		end,
		function(arg_51_0)
			return arg_51_0
		end
	}))

	local var_49_4 = 1

	for iter_49_5, iter_49_6 in ipairs(var_49_2) do
		while var_49_4 <= #self.allSortShipIds and var_49_1[self.allSortShipIds[var_49_4]] do
			var_49_4 = var_49_4 + 1
		end

		local var_49_5 = self.allSortShipIds[var_49_4]

		if not self.allSortShipIds[var_49_4] then
			break
		end

		self.slotShipIds[iter_49_6] = var_49_5
		var_49_1[var_49_5] = true
		var_49_4 = var_49_4 + 1
	end

	self:UpdateShipViewWithShipOrSlot()

	return
end

function ReversePacmanSelectScene:_GetNeaestDis(arg_52_1)
	local var_52_0 = 0

	for iter_52_0, iter_52_1 in ipairs(self.monsterPosList) do
		local var_52_1 = math.abs(iter_52_1.x - self.deployPosList[arg_52_1].x) + math.abs(iter_52_1.y - self.deployPosList[arg_52_1].y)

		var_52_0 = var_52_0 == 0 and var_52_1 or math.min(var_52_0, var_52_1)
	end

	return var_52_0
end

function ReversePacmanSelectScene:onBackPressed()
	if self.buffSubView and self.buffSubView:isShowing() then
		self.buffSubView:ExecuteAction("Hide")

		return
	end

	if isActive(self.uiShipPanelTF) then
		self:SwitchLevelView()

		return
	end

	ReversePacmanSelectScene.super.onBackPressed(self)

	return
end

function ReversePacmanSelectScene:willExit()
	if self.buffSubView then
		self.buffSubView:Destroy()

		self.buffSubView = nil
	end

	return
end

return ReversePacmanSelectScene
