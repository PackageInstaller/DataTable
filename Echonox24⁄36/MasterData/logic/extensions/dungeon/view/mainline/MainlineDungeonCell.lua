-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/mainline/MainlineDungeonCell.lua

module("logic.extensions.dungeon.view.mainline.MainlineDungeonCell", package.seeall)

local M = class("MainlineDungeonCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._isSelected = false

	self:buildUI()
end

function M:buildUI()
	self._animMain = goutil.findChildComponent(self.mainGO, "", ComponentType.Animation)
	self._animUnlockNormal = goutil.findChildComponent(self.mainGO, "normal_unlock_point", ComponentType.Animation)
	self._animUnlockBoss = goutil.findChildComponent(self.mainGO, "boss_unlock_point", ComponentType.Animation)
	self._animUnlockPlot = goutil.findChildComponent(self.mainGO, "special_unlock_point", ComponentType.Animation)
	self._normalLockGo = goutil.findChild(self.mainGO, "normal_lock_point")
	self._normalUnlockGo = goutil.findChild(self.mainGO, "normal_unlock_point")
	self._normalUnlockSelected = goutil.findChild(self._normalUnlockGo, "imgSelect")
	self._bossLockGo = goutil.findChild(self.mainGO, "boss_lock_point")
	self._bossUnlockGo = goutil.findChild(self.mainGO, "boss_unlock_point")
	self._bossUnlockSelected = goutil.findChild(self._bossUnlockGo, "imgSelect")
	self._plotLockGo = goutil.findChild(self.mainGO, "special_lock_point")
	self._plotUnlockGo = goutil.findChild(self.mainGO, "special_unlock_point")
	self._plotUnlockSelected = goutil.findChild(self._plotUnlockGo, "imgSelect")
	self._starPanelGo = goutil.findChild(self.mainGO, "star")
	self._starGetList = {}
	self._starGetList[1] = goutil.findChild(self.mainGO, "star/star1/type2")
	self._starGetList[2] = goutil.findChild(self.mainGO, "star/star2/type2")
	self._starGetList[3] = goutil.findChild(self.mainGO, "star/star3/type2")
	self._normalLockTxt = goutil.findChildTextComponent(self.mainGO, "normal_lock_point/Text")
	self._normalUnlockTxt = goutil.findChildTextComponent(self.mainGO, "normal_unlock_point/Text")
	self._bossLockTxt = goutil.findChildTextComponent(self.mainGO, "boss_lock_point/Text")
	self._bossUnlockTxt = goutil.findChildTextComponent(self.mainGO, "boss_unlock_point/Text")
	self._plotLockTxt = goutil.findChildTextComponent(self.mainGO, "special_lock_point/Text")
	self._plotUnlockTxt = goutil.findChildTextComponent(self.mainGO, "special_unlock_point/Text")
	self._goStatus = goutil.findChild(self.mainGO, "logContent")
	self._goStatusTypeDungeon = goutil.findChild(self._goStatus, "lay/item1")
	self._txtStatusTypeDungeon = goutil.findChildComponent(self._goStatusTypeDungeon, "txtContent1", UIComponentType.TMPText)
	self._goStatusTypePlot = goutil.findChild(self._goStatus, "lay/item2")
	self._goStatusAttribute = goutil.findChild(self._goStatus, "lay/item3")
	self._txtStatusAttribute = goutil.findChildComponent(self._goStatusAttribute, "txtContent", UIComponentType.TMPText)
	self._teachSignGo = goutil.findChild(self.mainGO, "normal_unlock_point/teachSign")
	self._unlockPlotImg = goutil.findChildImageComponent(self.mainGO, "special_unlock_point/Image1")
	self._lockPlotImg = goutil.findChildImageComponent(self.mainGO, "special_lock_point/Image1")
	self._clickBtn = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "click"))

	self._clickBtn:AddClickListener(self._onClick, self)
	goutil.setActive(self._mainlineLockGo, false)

	self._goLabel = goutil.findChild(self.mainGO, "com_label")

	goutil.setActive(self._goLabel, false)

	self._labelCell = Astral.SimpleLuaComponentContainer.Add(self._goLabel, CommLabel)
end

function M:_onClick()
	local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(self._dungeonId)

	if not dungeonMo:getIsUnlock() then
		if not self:_checkTargetDungeon(self._dungeonId) then
			return
		end

		ToolTipsMgr.showBranchUnlockTips(self._dungeonId)
		DungeonDispatcher:dispatchEvent(DungeonEventType.ON_PICK_Dungeon_Node, self._index, false)
	else
		DungeonDispatcher:dispatchEvent(DungeonEventType.ON_PICK_Dungeon_Node, self._index, true)
		CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_diaocha_guanqia, nil, nil, nil)
	end
end

function M:_checkTargetDungeon(dungeonId)
	local co = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonId(dungeonId)
	local unlockCondition = co and co.unlockCondition or {}

	for _, v in ipairs(unlockCondition) do
		if v.type == "dungeon" then
			local targetDungeonId = tonumber(v.value)
			local dungeonM0 = DungeonModel.instance:getDungeonMoById(targetDungeonId)

			if dungeonM0 then
				local hasPassTarget = dungeonM0:hasPassed()

				if not hasPassTarget then
					local dungeonIndex = dungeonM0:getIndex() or ""
					local dungeonName = dungeonM0:getName() or ""
					local dungeonTips = string.format("%s %s", dungeonIndex, dungeonName)

					FloatWordMgr.instance:show(langF("tip_unlock_branch_fail_by_dungeon_limit", dungeonTips))
				end

				return hasPassTarget
			end
		end
	end

	return false
end

function M:setDungeonId(dungeonId, index)
	self._dungeonId = dungeonId
	self._index = index

	self:updateView()
end

function M:getDungeonId()
	return self._dungeonId
end

function M:updateView()
	if self.mainGO then
		local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(self._dungeonId)

		if not dungeonMo then
			goutil.setActive(self.mainGO, false)

			return
		end

		self._normalLockTxt.text = dungeonMo:getIndex()
		self._normalUnlockTxt.text = dungeonMo:getIndex()
		self._bossLockTxt.text = dungeonMo:getIndex()
		self._bossUnlockTxt.text = dungeonMo:getIndex()
		self._plotLockTxt.text = dungeonMo:getIndex()
		self._plotUnlockTxt.text = dungeonMo:getIndex()

		local isUnlock = dungeonMo:getIsUnlock()

		if dungeonMo:getIsPlotNode() then
			goutil.setActive(self._normalLockGo, false)
			goutil.setActive(self._normalUnlockGo, false)
			goutil.setActive(self._bossLockGo, false)
			goutil.setActive(self._bossUnlockGo, false)
			goutil.setActive(self._plotLockGo, not isUnlock)
			goutil.setActive(self._plotUnlockGo, isUnlock)

			dungeonCo = DungeonConfig.instance:getMainlinePlotDungeonCOByDungeonId(self._dungeonId)

			IconLoader.setSprite(self._unlockPlotImg, IconType.MainlinePlotDungeon, dungeonCo.imgName)
			IconLoader.setSprite(self._lockPlotImg, IconType.MainlinePlotDungeon, dungeonCo.imgName)
		else
			local dungeonCo = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonId(self._dungeonId)

			if dungeonCo and dungeonCo.isBoss == 1 then
				goutil.setActive(self._normalLockGo, false)
				goutil.setActive(self._normalUnlockGo, false)
				goutil.setActive(self._bossLockGo, not isUnlock)
				goutil.setActive(self._bossUnlockGo, isUnlock)
			else
				goutil.setActive(self._teachSignGo, isUnlock and dungeonCo.isTeach == 1)
				goutil.setActive(self._normalLockGo, not isUnlock)
				goutil.setActive(self._normalUnlockGo, isUnlock)
				goutil.setActive(self._bossLockGo, false)
				goutil.setActive(self._bossUnlockGo, false)
			end

			goutil.setActive(self._plotLockGo, false)
			goutil.setActive(self._plotUnlockGo, false)
			goutil.setActive(self._starPanelGo, isUnlock)

			if isUnlock then
				local count = dungeonMo:getStarCount()

				for i, star in ipairs(self._starGetList) do
					goutil.setActive(star, i <= count)
				end
			end
		end

		if dungeonMo:getType() == CommEnum.DungeonType.Mainline then
			goutil.setActive(self.mainGO, dungeonMo:getIsUnlock())
		else
			goutil.setActive(self.mainGO, dungeonMo:getIsShowInScene())
		end

		self:updateSelected()
		self:updateStatus()

		local showInScene = dungeonMo:getIsShowInScene()
		local hasShowInScene = DungeonMainLineChapterModel.instance:getShowInSceneCache(self._dungeonId)

		if showInScene and not hasShowInScene then
			self:_playAnimation(self._animMain, "level_item_appear")
			DungeonMainLineChapterModel.instance:setShowInSceneCache(self._dungeonId)
		end

		local hasShow = DungeonMainLineChapterModel.instance:getDungeonCellUnlockCache(self._dungeonId)

		if not hasShow and dungeonMo:getIsUnlock() then
			self:_playAnimation(self._animUnlockNormal, "level_boss_jihuo")
			self:_playAnimation(self._animUnlockBoss, "level_boss_jihuo")
			self:_playAnimation(self._animUnlockPlot, "level_boss_jihuo")
			CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_diaocha_zhuxianjiesuo, nil, nil, nil)
			DungeonMainLineChapterModel.instance:setDungeonCellUnlockCache(self._dungeonId)
		end

		local isPlotUnread = dungeonMo:getIsPlotNode() and not dungeonMo:hasPassed()

		goutil.setActive(self._goLabel, isPlotUnread)
		self._labelCell:setData(CommLabel.SignType.Sign1, lang("unread"))
	else
		printError("该节点没有名牌,副本id:", self._dungeonId)
	end
end

function M:_playAnimation(animation, animName)
	if animation and animation.gameObject.activeSelf then
		animation:Play(animName)
	end
end

function M:setSelected(isSelected)
	self._isSelected = isSelected

	self:updateSelected()
	self:updateStatus()
end

function M:updateSelected()
	goutil.setActive(self._normalUnlockSelected, self._isSelected)
	goutil.setActive(self._bossUnlockSelected, self._isSelected)
	goutil.setActive(self._plotUnlockSelected, self._isSelected)
end

function M:updateStatus()
	if checknumber(self._dungeonId) > 0 then
		local hasUnlockTarget, unlock = DungeonMainLineChapterModel.instance:hasUnlockDungeon(self._dungeonId)
		local hasTypePlot = false
		local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(self._dungeonId)

		if not dungeonMo:getIsPlotNode() then
			local levelCode = dungeonMo:getDungeonBattleCode()
			local levelCO = BattleConfig.instance:getBattleLevelCO(levelCode)
			local plotEventGroup = levelCO.plotEventGroup

			if plotEventGroup > 0 then
				hasTypePlot = BattleConfig.instance:hasAnswerByGroupCode(plotEventGroup)
			end
		end

		local configs = PlayerConfig.instance:getAttributeOfMainline()
		local canGet = false

		for i, v in ipairs(configs) do
			if self._dungeonId == v.id then
				canGet = true
			end
		end

		if not goutil.isNil(self._goStatus) and (hasUnlockTarget or hasTypePlot or canGet) then
			goutil.setActive(self._goStatusTypeDungeon, hasUnlockTarget)

			local colorStr = unlock and "#989898" or "#FFFFFF"

			self._txtStatusTypeDungeon.color = parsecolor(colorStr)

			local img = goutil.findChildImageComponent(self._txtStatusTypeDungeon.gameObject, "Image1")

			img.color = parsecolor(colorStr)

			local txtStr = unlock and lang("tip_mainline_lang_1") or lang("tip_mainline_lang_2")

			self._txtStatusTypeDungeon.text = txtStr

			goutil.setActive(self._goStatusTypePlot, hasTypePlot)

			local attrType, attrName, attrLevel = MainlineDungeonUtil.getAttribute(self._dungeonId)

			if attrType and not dungeonMo:hasPassed() then
				local attrStr = attrName .. attrType .. attrLevel

				self._txtStatusTypeDungeon.text = string.format("%s (%s%s)", txtStr, lang("tip_chapter_node_static1"), attrStr)
			end

			self._txtStatusAttribute.text = MainlineDungeonUtil.getPassAttrDesc()

			goutil.setActive(self._goStatusAttribute, canGet and not dungeonMo:hasPassed())
			goutil.setActive(self._goStatus, self._goStatusTypeDungeon.activeSelf or self._goStatusTypePlot.activeSelf or self._goStatusAttribute.activeSelf)
		else
			goutil.setActive(self._goStatus, false)
		end
	end
end

function M:clear()
	self._clickBtn:RemoveClickListener()
end

return M
