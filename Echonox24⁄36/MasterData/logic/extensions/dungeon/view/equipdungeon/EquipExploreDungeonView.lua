-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/EquipExploreDungeonView.lua

module("logic.extensions.dungeon.view.equipdungeon.EquipExploreDungeonView", package.seeall)

local M = class("EquipExploreDungeonView", ViewComponent)
local SystemOpenMap = {
	[2001] = GameEnum.SystemEnum.EquipmentDungeonChapter1,
	[2002] = GameEnum.SystemEnum.EquipmentDungeonChapter2,
	[2003] = GameEnum.SystemEnum.EquipmentDungeonChapter3
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._btnReturn = self:getBtn("title_view_-878360263")
	self._btnScrollEmptyPlace = self:getBtn("equip_explore_seed_view_-1288292407")
	self._scrollEntry = self:getUIComponent("equip_explore_seed_view_-784503167", UIComponentType.ScrollRect)
	self._rectTrTabRoot = self:getUIComponent("equip_explore_seed_view_-1546688835", UIComponentType.RectTransform)
	self._canvasGroupTabRoot = self:getUIComponent("equip_explore_seed_view_-1546688835", ComponentType.CanvasGroup)
	self._guiAnimTab = goutil.addComponentOnce(self._rectTrTabRoot.gameObject, typeof(Astral.GUITimelineAniLua))
	self._rectTrLvDetailPanel = self:getUIComponent("equip_explore_seed_view_-1725249366", UIComponentType.RectTransform)
	self._canvsGroupLvDetail = self:getUIComponent("equip_explore_seed_view_-1725249366", ComponentType.CanvasGroup)
	self._guiAnimDetailPanel = goutil.addComponentOnce(self._rectTrLvDetailPanel.gameObject, typeof(Astral.GUITimelineAniLua))
	self._orgPosXTabRoot = self._rectTrTabRoot.anchoredPosition.x
	self._orgPosXLvDetailPanel = self._rectTrLvDetailPanel.anchoredPosition.x

	local rectTrPosRoot = self:getUIComponent("equip_explore_seed_view_-1446938649", UIComponentType.RectTransform)

	self._focusPos = {}

	for i = 0, rectTrPosRoot.childCount - 1 do
		local tmpTr = rectTrPosRoot:GetChild(i)

		table.insert(self._focusPos, {
			anchPosX = tmpTr.anchoredPosition.x,
			anchPosY = tmpTr.anchoredPosition.y,
			scale = tmpTr.localScale.x
		})
	end

	self._rectTrSceneBg = self:getUIComponent("equip_explore_seed_view_-1288292407", UIComponentType.RectTransform)
	self._orgScaleScene = 1
	self._txtDungeonName = self:getText("equip_explore_seed_view_-498438052")
	self._dungeonScoreRateGo = self:getGo("13&instance_danger_-1654566369")
	self._txtDungeonInfo = self:getText("equip_explore_seed_view_-409678695")
	self._btnMoreReward = self:getBtn("equip_explore_seed_view_-654031699")
	self._rewardListGo = self:getGo("equip_explore_seed_view_-937055327")
	self._btnFight = self:getBtn("equip_explore_seed_view_-723936389")
	self._btnQuickFight = self:getBtn("equip_explore_seed_view_-1746502352")
	self._costTxt = self:getText("equip_explore_seed_view_-1609997131")
	self._btnEnemy = self:getBtnByPath("middle/levelDetailsPanel/layout/enemyInfo/Image1")

	local btn_skill_bonusGo = goutil.findChild(self._btnMoreReward.transform.parent.gameObject, "btn_skill_bonus")

	self._btnSkillUp = UIComponentType.ButtonAdapter(goutil.findChild(btn_skill_bonusGo, "btnUp"))
	self._btnSkillDown = UIComponentType.ButtonAdapter(goutil.findChild(btn_skill_bonusGo, "btnDown"))

	goutil.setActive(self._btnSkillUp.gameObject, AchievementModel.instance:isGetSkill(CommEnum.CharacterSkillType.Type5))
	goutil.setActive(self._btnSkillDown.gameObject, false)
end

function M:destroyUI()
	self._btnReturn = nil
	self._scrollEntry = nil
	self._cellEntry = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnScrollEmptyPlace:AddClickListener(self._onClickScrollEmptyPlace, self)
	self._btnMoreReward:AddClickListener(self._onClickMoreReward, self)
	self._btnFight:AddClickListener(self._onClickFight, self)
	self._btnQuickFight:AddClickListener(self._onClickQuickFight, self)
	self._guiAnimTab:AddListener(self._dealTimelineTab, self)
	self._btnEnemy:AddClickListener(self._onClickBtnEnemy, self)
	self._btnSkillUp:AddClickListener(self._onOpenSkillSmallTips, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnScrollEmptyPlace:RemoveClickListener()
	self._btnMoreReward:RemoveClickListener()
	self._btnFight:RemoveClickListener()
	self._btnQuickFight:RemoveClickListener()
	self._guiAnimTab:RemoveListener()
	self._btnEnemy:RemoveClickListener()
	self._btnSkillUp:RemoveClickListener()
end

function M:onEnter()
	self._guiAnimation:StopTimelineAni()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Material)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_EquipExplore)

	self._entranceScrollShow = false
	self._detailPanelShow = false
	self._openAniFinish = false
	self._canvsGroupLvDetail.interactable = self._detailPanelShow
	self._canvsGroupLvDetail.blocksRaycasts = self._detailPanelShow
	self._canvasGroupTabRoot.interactable = self._entranceScrollShow
	self._canvasGroupTabRoot.blocksRaycasts = self._entranceScrollShow

	self:setEvent(true)
	self:setCurChapterId(nil)
	self:setCurDungeonId(nil)
	self:_refreshData()
	self:_refreshEntry()
	self:_refreshEntryLock()
	self:_setFocusEntry(false, false)
	self:_setEntranceScrollShow(false, false)
	self:_setLevelDetailsPanelShow(false, false)

	local info = self:getFirstParam()
	local openParamChapterId = info and info.chapterId or nil
	local chapterId, dungeonId = DungeonEquipExploreChapterModel.instance:getClickChapterIdAndDungeonIndex()
	local defaultSelectChapterId = openParamChapterId and openParamChapterId or chapterId

	if self._tweenDelayDefaultTab then
		self._tweenDelayDefaultTab:Kill(false)

		self._tweenDelayDefaultTab = nil
	end

	self._defaultSelectChapter = defaultSelectChapterId

	self._guiAnimation:PlayAniByName("open")
end

function M:onExit(reasonTyp)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Material)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_EquipExplore)
	self:setEvent(false)

	self._chapterList = nil

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")

	if self._tweenDelayDefaultTab then
		self._tweenDelayDefaultTab:Kill(false)

		self._tweenDelayDefaultTab = nil
	end

	if reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType then
		DungeonEquipExploreChapterModel.instance:setClickChapterIdAndDungeonIndex(nil, nil)
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.EQUIP_EXPLORE_DUNGEON_SELECT, self._handleEquipExploreDungeonSelect, self)
		GlobalDispatcher:addEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._handleMultiFightTipsConfirm, self)
		self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
		GlobalDispatcher:addEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	else
		GlobalDispatcher:removeEventListener(EventType.EQUIP_EXPLORE_DUNGEON_SELECT, self._handleEquipExploreDungeonSelect, self)
		GlobalDispatcher:removeEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._handleMultiFightTipsConfirm, self)
		self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
		GlobalDispatcher:removeEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	end
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	if tagName == "open" then
		self._openAniFinish = true

		local chapterCfgMo = DungeonEquipExploreChapterModel.instance:getChapterMoByChapterId(self._defaultSelectChapter)

		if chapterCfgMo and not self:isExpire(self._defaultSelectChapter, false) then
			self:onClickEntry(self._defaultSelectChapter)
		end
	end
end

function M:_handleEquipExploreDungeonSelect(e, dungeonId)
	self:setCurDungeonId(dungeonId)
	self:_setLevelDetailsPanelShow(true, true, dungeonId)
end

function M:_handleMultiFightTipsConfirm(e, tipsInfo)
	local chapterId = self:getCurChapterId()

	if self:isExpire(chapterId, true) then
		return
	end

	local curDungeonId = self:getCurDungeonId()

	if curDungeonId ~= tipsInfo.dungeonId then
		return
	end

	local dungeonId = tipsInfo.dungeonId
	local multiCount = tipsInfo.multiCount
	local gamePlay = tipsInfo.gamePlay
	local dungeonMo = self:getDungeonMo(dungeonId)

	if not dungeonMo then
		return
	end

	local pointCost = dungeonMo:getPointCost()

	print(string.format("挑战[%d]，倍数[%d]", dungeonId, multiCount))
	BattleCalculateModel.instance:setDefaultItemMoList(pointCost * multiCount)

	local info = {}

	info.dungeonCode = dungeonId
	info.afflatusBuff = false
	info.isShowPlot = false
	info.multiCount = multiCount
	info.gamePlay = gamePlay

	self:_startFight(info, false)
end

function M:_startFight(info, checkDanger)
	if checkDanger == nil then
		checkDanger = true
	end

	if not checkDanger then
		self:_goFight(false, info)

		return
	end

	local dungeonId = self:getCurDungeonId()
	local dungeonMo = self:getDungeonMo(dungeonId)

	if not dungeonMo:getIsPlotNode() then
		local scoreRate = DungeonModel.instance:getDungeonScoreRate(dungeonId) * 1000
		local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, dungeonMo:getScoreGroup())

		if not DungeonController.instance:tryOpenDangerTips(scoreCO, info) then
			self:_goFight(false, info)
		end
	else
		self:_goFight(false, info)
	end
end

function M:_goFight(_, info)
	local chapterId = self:getCurChapterId()
	local dungeonId = self:getCurDungeonId()

	DungeonEquipExploreChapterModel.instance:setClickChapterIdAndDungeonIndex(chapterId, dungeonId)
	Astral.LocalStorage.Instance:SetString("dungeon_latest_type", string.format("3,%d,%02d", chapterId, self._dungeonId2Pos[dungeonId]))
	Astral.LocalStorage.Instance:SetString("dungeon_latest_info", dungeonId)
	Astral.LocalStorage.Instance:SetString("dungeon_latest_id", PlayerModel.instance:getId())
	SceneFace.instance:exitScene()
	DungeonController.instance:startDungeonBattle(info)
end

function M:_onClickReturn()
	local curChapter = self:getCurChapterId()

	if curChapter then
		self:_onClickScrollEmptyPlace()
	else
		self:back()
	end
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickScrollEmptyPlace()
	local curChapter = self:getCurChapterId()

	if not curChapter then
		return
	end

	printWarn("点击空白位置")
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_EXPLORE_CHAPTER_SELECT, nil)
	self:setCurChapterId(nil)
	self:_setFocusEntry(false, true)
	self:_setEntranceScrollShow(false, true)

	if self._detailPanelShow then
		self:_setLevelDetailsPanelShow(false, true)
	end
end

function M:onClickEntry(chapterIdClick)
	if not chapterIdClick then
		return
	end

	local isOpen = SystemOpenFacade.instance:isOpen(SystemOpenMap[chapterIdClick], true)

	if not isOpen then
		return
	end

	if self:isExpire(chapterIdClick, true) then
		self:_refreshEntryLock()

		return
	end

	local orgChapterId = self:getCurChapterId()

	if orgChapterId and orgChapterId == chapterIdClick then
		self:_onClickScrollEmptyPlace()

		return
	end

	if not self._openAniFinish then
		return
	end

	self:setCurChapterId(chapterIdClick)

	local chapterId = self:getCurChapterId()

	self:_getChapterPos()

	if orgChapterId and orgChapterId ~= chapterId then
		self:_setLevelDetailsPanelShow(false, true)
		self:_setEntranceScrollShow(false, true, nil, function()
			self:_setFocusEntry(true, true, chapterId)
			self:_setEntranceScrollShow(true, true, chapterId)
		end)
	else
		self:_setFocusEntry(true, true, chapterId)
		self:_setEntranceScrollShow(true, true, chapterId)
	end
end

function M:_getChapterPos()
	local dungeonIds = DungeonEquipExploreChapterModel.instance:getChapterMoByChapterId(self:getCurChapterId()):getDungeonIds()

	self._dungeonId2Pos = {}

	for i, v in ipairs(dungeonIds) do
		self._dungeonId2Pos[v] = i
	end
end

function M:_onClickFight()
	local chapterId = self:getCurChapterId()
	local dungeonId = self:getCurDungeonId()
	local dungeonMo = self:getDungeonMo(dungeonId)

	if dungeonMo:getIsLock() then
		printWarn(string.format("dungeonId[%s]未解锁", dungeonId))

		if not dungeonMo:getPreDungeonPassed() then
			FloatWordMgr.instance:show(lang("tip_teaching_lock"))
		elseif PlayerModel.instance:getLevel() < dungeonMo:getUnlockLevel() then
			if dungeonMo:getUnlockLevel() >= 100 then
				FloatWordMgr.instance:show(lang("tip_system_open_not_online"))

				return
			end

			FloatWordMgr.instance:show(string.format(lang("tip_player_not_reach_level"), self:_formatLevel(dungeonMo:getUnlockLevel())))
		end

		return
	end

	local curEnergy = ItemModel.instance:getItemCountByItemId(CommEnum.CurrencyCodeEnum.TlCode)
	local needEnergy = dungeonMo:getPointCost()

	if self:isExpire(chapterId, true) then
		self:close()

		return
	end

	if self:_checkBackpackLimit() then
		local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_warehouse_undercapacity"))

		dialog:setConfirmButtonText(lang("tip_common_sure"))

		return
	end

	if curEnergy < needEnergy then
		ToolTipsMgr.showHealthExchangeTips()

		return
	end

	BattleCalculateModel.instance:setDefaultItemMoList(needEnergy)

	local info = {}

	info.dungeonCode = dungeonId
	info.afflatusBuff = false
	info.isShowPlot = true
	info.multiCount = 1
	info.gamePlay = BattleEnum.GamePlayType.NORMAL

	self:_startFight(info)
end

function M:_onClickQuickFight()
	local gamePlay = BattleEnum.GamePlayType.CONSECUTIVE
	local chapterId = self:getCurChapterId()
	local dungeonId = self:getCurDungeonId()
	local dungeonMo = self:getDungeonMo(dungeonId)

	if dungeonMo == nil then
		printError(string.format("无法获取dungeonId[%d]的关卡数据", dungeonId))

		return
	end

	local chapterMo = DungeonEquipExploreChapterModel.instance:getChapterMoByChapterId(chapterId)

	if not chapterMo then
		printError("无法找到chapterMo数据,id->", chapterId)

		return
	end

	local starCount = dungeonMo:getStarCount()
	local hasPassed = dungeonMo:getIsClear()
	local pointCost = dungeonMo:getPointCost()
	local canOpenMulti = chapterMo:getCanOpenMulti()
	local multiOpenCondition = chapterMo:getMultiplicityOpenCondition()
	local canQuickFight = false
	local maxCount = 0
	local backPackLimit = self:_checkBackpackLimit()
	local canProxy = chapterMo:canProxy()

	if gamePlay == BattleEnum.GamePlayType.RECORD then
		maxCount = chapterMo:getMultiMaxCount()

		if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonMultipleBattle, true) then
			return
		end

		if not canOpenMulti then
			FloatWordMgr.instance:show(lang("tip_not_open_multiple"))

			return
		elseif not hasPassed then
			FloatWordMgr.instance:show(lang("tip_pass_open_multiple"))

			return
		end
	elseif gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		maxCount = chapterMo:getConsecutiveLimit()

		if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonConsecutiveBattle, true) then
			return
		end

		if maxCount <= 0 then
			FloatWordMgr.instance:show(lang("tip_not_open_consecutive"))

			return
		elseif not hasPassed then
			FloatWordMgr.instance:show(lang("tip_pass_open_consecutive"))

			return
		end
	else
		return
	end

	if backPackLimit then
		local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_warehouse_undercapacity"))

		dialog:setConfirmButtonText(lang("tip_common_sure"))

		return
	end

	ToolTipsMgr.showMultiFightTipsView(dungeonId, maxCount, canQuickFight, canProxy, gamePlay)
end

function M:_onClickMoreReward()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_click, nil, nil, nil)
	ViewMgr.instance:open(ViewName.DungeonRewardDetailView, self:getCurDungeonId())
end

function M:_checkQucikFightBtn()
	local chapterId = self:getCurChapterId()
	local chapterCfgMo = DungeonEquipExploreChapterModel.instance:getChapterMoByChapterId(chapterId)

	if not chapterCfgMo then
		printError(string.format("无法从[t_%s]找到[%s]的配置，model没有找到对应的Mo", ConfigName.DungeonMaterialChapter, chapterId))
		goutil.setActive(self._btnQuickFight.gameObject, false)

		return
	end

	local dungeonId = self:getCurDungeonId()
	local dungeonMo = self:getDungeonMo(dungeonId)

	if not dungeonMo then
		goutil.setActive(self._btnQuickFight.gameObject, false)

		return
	end

	local gamePlay = BattleEnum.GamePlayType.CONSECUTIVE
	local showBtn = true
	local hasPassed = dungeonMo:hasPassed()

	if gamePlay == BattleEnum.GamePlayType.RECORD then
		showBtn = hasPassed and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonMultipleBattle, false) and chapterCfgMo:getCanOpenMulti()
	elseif gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		local maxCount = chapterCfgMo:getConsecutiveLimit()

		showBtn = hasPassed and maxCount and maxCount > 0 and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonConsecutiveBattle, false)
	end

	goutil.setActive(self._btnQuickFight.gameObject, showBtn)
end

function M:getDungeonMo(dungeonId)
	local dungeonMo = DungeonEquipExploreChapterModel.instance:getDungeonMoById(dungeonId)

	if dungeonMo == nil then
		printError(string.format("无法获取dungeonId[%d]的关卡数据", dungeonId))
	end

	return dungeonMo
end

function M:getCurChapterId()
	return self._chapterId
end

function M:setCurChapterId(chapterId)
	self._chapterId = chapterId
end

function M:getCurDungeonId()
	return self._curDungeonId
end

function M:setCurDungeonId(dungeonId)
	self._curDungeonId = dungeonId
end

function M:isExpire(chapterId, withPopup)
	local chapterCfgMo = DungeonEquipExploreChapterModel.instance:getChapterMoByChapterId(chapterId)

	if not chapterCfgMo then
		printError(string.format("无法从[t_%s]找到[%s]的配置，model没有找到对应的Mo", ConfigName.DungeonMaterialChapter, chapterId))

		return true
	end

	if chapterCfgMo:getIsInWeekDay() then
		return false
	else
		if withPopup then
			local expireStr = string.format(lang("tip_copy_s"), chapterCfgMo:getWeekDayStr())

			FloatWordMgr.instance:show(expireStr)
		end

		return true
	end
end

function M:_checkBackpackLimit()
	local equipMaxCount = PlayerModel.instance:getBackpackLimit(GameEnum.ItemTypeEnum.EquipItemType, "EquipmentBackpackCapacity")
	local curEquipCount = ItemModel.instance:getItemCountByTS(GameEnum.ItemTypeEnum.EquipItemType, 0)

	return equipMaxCount <= curEquipCount
end

function M:_refreshData()
	local chapterList = DungeonEquipExploreChapterModel.instance:getAllChapter()

	self._chapterList = {}

	for k, v in pairs(chapterList) do
		table.insert(self._chapterList, v)
	end

	table.sort(self._chapterList, function(chapter1, chapter2)
		return chapter1:getChapterId() < chapter2:getChapterId()
	end)
end

function M:_refreshEntry()
	local rootTr = self._scrollEntry.content
	local uiCount = rootTr.childCount

	if uiCount ~= #self._chapterList then
		printWarn(string.format("<color=#45e6f9>入口ui数量[%d]与数据[%d]不匹配</color>", uiCount, #self._chapterList))
	end

	if #self._chapterList > 0 then
		self._cellEntry = {}

		for index, value in ipairs(self._chapterList) do
			local uiIndex = index - 1
			local tmpTr

			if uiIndex < rootTr.childCount then
				tmpTr = rootTr:GetChild(uiIndex)
			end

			local entryGo

			if tmpTr then
				entryGo = goutil.findChild(tmpTr.gameObject, string.format("equip_explore_pos_entry_%s", index))
			end

			if entryGo then
				local chapterId = value:getChapterId()
				local shower = Astral.LuaComponentContainer.Get(entryGo.gameObject, EquipExploreEntryTabView)

				if shower == nil then
					shower = Astral.LuaComponentContainer.Add(entryGo.gameObject, EquipExploreEntryTabView)
				end

				local isOpen = SystemOpenFacade.instance:isOpen(SystemOpenMap[chapterId])

				shower:setIsLock(not isOpen)
				shower:setHandler(self)
				shower:setChapterMo(value)

				self._cellEntry[chapterId] = {
					shower = shower,
					root = tmpTr,
					focusPos = self._focusPos[index]
				}
			end
		end
	else
		printWarn("无任何签关卡数据")

		for _, comps in pairs(self._cellEntry or {}) do
			comps.shower:setIsLock(true)
		end
	end
end

function M:_refreshEntryLock()
	for chapterId, comps in pairs(self._cellEntry or {}) do
		local isLock = not self:_isInWeekDay(chapterId)

		comps.shower:setIsLock(isLock)
	end
end

function M:_isInWeekDay(chapterId)
	local mo = DungeonEquipExploreChapterModel.instance:getChapterMoByChapterId(chapterId)
	local inWeekDay = false

	if mo then
		inWeekDay = mo:getIsInWeekDay()
	else
		printError(string.format("无法从ChapterModel找到[%d]的数据", chapterId))
	end

	return inWeekDay
end

function M:_setFocusEntry(focus, needTween, chapterId)
	local duration = 0.2
	local trScene = self._rectTrSceneBg

	trScene:DOKill(false)

	for _, comps in pairs(self._cellEntry or {}) do
		comps.root:DOKill(false)
	end

	local focusPos = focus and self._cellEntry[chapterId].focusPos or nil
	local anchPosXScene = focus and focusPos.anchPosX or 0
	local anchPosYScene = focus and focusPos.anchPosY or 0
	local scaleScene = focus and focusPos.scale or self._orgScaleScene
	local scaleEntry = focus and 1 / focusPos.scale or 1 / self._orgScaleScene
	local endPos = Vector3.New(anchPosXScene, anchPosYScene, 0)

	if needTween then
		trScene:DOAnchorPos(endPos, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)

		local endScale = Vector3.New(scaleScene, scaleScene, 1)

		trScene:DOScale(endScale, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)

		local endScaleEntry = Vector3.New(scaleEntry, scaleEntry, 1)

		for _, comps in pairs(self._cellEntry or {}) do
			comps.root:DOScale(endScaleEntry, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
		end
	else
		RectTransformUtils.SetAnchoredPosition(trScene, anchPosXScene, anchPosYScene)
		RectTransformUtils.SetScale(trScene, scaleScene, scaleScene, 1)

		for _, comps in pairs(self._cellEntry or {}) do
			RectTransformUtils.SetScale(comps.root, scaleEntry, scaleEntry, 1)
		end
	end
end

function M:_setEntranceScrollShow(show, needTween, chapterId, callBackFunc)
	self._entranceScrollShow = show
	self._canvasGroupTabRoot.interactable = self._entranceScrollShow
	self._canvasGroupTabRoot.blocksRaycasts = self._entranceScrollShow

	local duration = 0.5
	local rectTr = self._rectTrTabRoot

	self._entranceTabAniCallBack = callBackFunc

	rectTr:DOKill()

	local posX = show and self._orgPosXTabRoot or self._orgPosXTabRoot - 800

	if needTween then
		local animName = show and "opan" or "close"

		self._guiAnimTab:StopTimelineAni()
		self._guiAnimTab:PlayAniByName(animName)
	else
		RectTransformUtils.SetAnchoredPosition(rectTr, posX, rectTr.anchoredPosition.y)

		if self._entranceTabAniCallBack then
			self._entranceTabAniCallBack(self)

			self._entranceTabAniCallBack = nil
		end
	end

	if show then
		printWarn(string.format("<color=#2c2c>%s</color>", chapterId))

		self._chapterCfgMo = DungeonEquipExploreChapterModel.instance:getChapterMoByChapterId(chapterId)
		self._canOpenMulti = self._chapterCfgMo:getCanOpenMulti()

		GlobalDispatcher:dispatchEvent(EventType.EQUIP_EXPLORE_CHAPTER_SELECT, chapterId)
	end
end

function M:_dealTimelineTab(tagName)
	if self._entranceTabAniCallBack then
		self._entranceTabAniCallBack(self)

		self._entranceTabAniCallBack = nil
	end
end

function M:_setLevelDetailsPanelShow(show, needTween, dungeonId)
	self._detailPanelShow = show
	self._canvsGroupLvDetail.interactable = self._detailPanelShow
	self._canvsGroupLvDetail.blocksRaycasts = self._detailPanelShow

	local duration = 0.5
	local rectTr = self._rectTrLvDetailPanel

	rectTr:DOKill()

	local posX = show and self._orgPosXLvDetailPanel or self._orgPosXLvDetailPanel + 1000

	if needTween then
		local animName = show and "open" or "close"

		if self._detailPanelShow and show then
			animName = "qiehuan"
		end

		self._guiAnimDetailPanel:StopTimelineAni()
		self._guiAnimDetailPanel:PlayAniByName(animName)
	else
		RectTransformUtils.SetAnchoredPosition(rectTr, posX, rectTr.anchoredPosition.y)
	end

	if show then
		local dungeonMo = self:getDungeonMo(dungeonId)
		local scoreRate = DungeonModel.instance:getDungeonScoreRate(dungeonMo:getId(), dungeonMo:getChapterId()) * 1000
		local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, dungeonMo:getScoreGroup())

		self._txtDungeonName.text = dungeonMo:getName()

		DifficultyUtil.setDifficultyFlag(self._dungeonScoreRateGo, scoreCO)

		self._txtDungeonInfo.text = dungeonMo:getDesc()
		self._costTxt.text = dungeonMo:getPointCost()

		self:_refreshRewardPanel(dungeonMo)
		self:_checkQucikFightBtn()
	end
end

function M:_refreshEnemyPanel(dungeonMo)
	goutil.clearChildren(self._bossListGo)

	local hasEnterDungeon = DungeonModel.instance:getIfDungeonEntered(dungeonMo:getId())

	if dungeonMo:hasPassed() then
		hasEnterDungeon = true
	end

	local enemyList = dungeonMo:getEnemyIds()

	for i, v in ipairs(enemyList) do
		if i <= 3 then
			local obj = self:getResInstance(ResName.Common_enemy_head)

			obj:SetActive(true)

			local objBeh = Astral.LuaComponentContainer.Add(obj, MonsterHeadCell)

			goutil.addChildToParent(obj, self._bossListGo)
			objBeh:setShowMonsterStatus(hasEnterDungeon)
			objBeh:setMonsterCode(v)
		end
	end

	if #enemyList > 3 then
		local obj = self:getResInstance(ResName.Common_enemy_head)

		obj:SetActive(true)

		local objBeh = Astral.LuaComponentContainer.Add(obj, MonsterHeadCell)

		goutil.addChildToParent(obj, self._bossListGo)
		objBeh:setShowMonsterStatus(false)
		objBeh:setMonsterCode(0)
	end
end

function M:_onClickBtnEnemy()
	local dungeonId = self:getCurDungeonId()
	local luaTable = {}

	luaTable.dungeonMo = self:getDungeonMo(dungeonId)

	ViewMgr.instance:open(ViewName.DungeonEnemy, luaTable)
end

function M:_refreshRewardPanel(dungeonMo)
	local maxNum = 3
	local root = self._rewardListGo.transform
	local itemPrefab = root:GetChild(0).gameObject
	local hasPassed = dungeonMo:hasPassed()
	local lst = {}

	if not hasPassed then
		local _tmpTable = {}

		for i, reward in ipairs(dungeonMo:getAllFirstPassReward()) do
			table.insert(_tmpTable, ItemUtil.createItemData({
				itemId = reward.code,
				count = reward.num
			}))
		end

		if #_tmpTable > 0 then
			table.sort(_tmpTable, ItemUtil.commonSortFunc)

			for _, _itemData in ipairs(_tmpTable) do
				local rewardData = RewardData.New({
					code = _itemData:getItemId(),
					count = _itemData:getCount(),
					rewardStatus = hasPassed and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot,
					itemData = _itemData,
					itemSign = CommEnum.BackPackItemSignTyp.First,
					signTyp = CommEnum.BackPackItemSignTyp.First
				})

				table.insert(lst, rewardData)

				if maxNum <= #lst then
					break
				end
			end
		end
	end

	if maxNum > #lst then
		local _tmpTable = {}

		for i, code in ipairs(dungeonMo:getImportantPassReward()) do
			table.insert(_tmpTable, ItemUtil.createItemData({
				itemId = code
			}))
		end

		if #_tmpTable > 0 then
			table.sort(_tmpTable, ItemUtil.commonSortFunc)

			for _, _itemData in ipairs(_tmpTable) do
				local rewardData = RewardData.New({
					code = _itemData:getItemId(),
					itemData = _itemData,
					rewardStatus = CommEnum.RewardEnum.CanNotGot
				})

				table.insert(lst, rewardData)

				if maxNum <= #lst then
					break
				end
			end
		end
	end

	if hasPassed and #lst == 0 then
		local _tmpTable = {}

		for i, reward in ipairs(dungeonMo:getAllFirstPassReward()) do
			table.insert(_tmpTable, ItemUtil.createItemData({
				itemId = reward.code,
				count = reward.num
			}))
		end

		if #_tmpTable > 0 then
			table.sort(_tmpTable, ItemUtil.commonSortFunc)

			for _, _itemData in ipairs(_tmpTable) do
				local rewardData = RewardData.New({
					code = _itemData:getItemId(),
					count = _itemData:getCount(),
					rewardStatus = hasPassed and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot,
					itemSign = CommEnum.BackPackItemSignTyp.Get,
					itemData = _itemData,
					signTyp = CommEnum.BackPackItemSignTyp.Get
				})

				table.insert(lst, rewardData)

				if maxNum <= #lst then
					break
				end
			end
		end
	end

	while root.childCount < #lst do
		goutil.cloneAndSetParent(itemPrefab, root)
	end

	for i = 0, root.childCount - 1 do
		local tmpGo = root:GetChild(i).gameObject
		local show = i < #lst

		if show then
			local data = lst[i + 1]
			local itemCell = Astral.LuaComponentContainer.Add(tmpGo, RewardCell)

			itemCell:updateData(data)
		end

		goutil.setActive(tmpGo, show)
	end
end

function M:_onOpenSkillSmallTips()
	local param = {}

	param.obj = self._btnSkillUp.transform.parent.gameObject
	param.skillType = CommEnum.CharacterSkillType.Type5

	ViewMgr.instance:open(ViewName.AchievementSkillSmallTips, param)
end

return M
