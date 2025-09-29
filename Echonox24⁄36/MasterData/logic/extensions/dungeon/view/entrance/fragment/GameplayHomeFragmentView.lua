-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/fragment/GameplayHomeFragmentView.lua

module("logic.extensions.dungeon.view.entrance.fragment.GameplayHomeFragmentView", package.seeall)

local M = class("GameplayHomeFragmentView", GameplaySubViewBase)

function M:buildUI()
	M.super.buildUI(self)

	self._imgChapter = self._registry:getImage("0&fight_entry_chapter_item_-82559705")
	self._txtChapter = self._registry:getText("0&fight_entry_chapter_item_-702278482")
	self._txtChapterName = self._registry:getText("0&fight_entry_chapter_item_-1106906654")
	self._txtChapterPart = self._registry:getText("0&fight_entry_chapter_item_503559015")
	self._txtLastChapterName = self._registry:getText("fight_entry_homepage_panel_-233767697")
	self._txtTimeLimitMainline = self._registry:getText("fight_entry_homepage_panel_882636645")
	self._txtTimeLimitRegulatory = self._registry:getText("fight_entry_homepage_panel_1042331343")
	self._txtTimeLimitAirWorkShop = self._registry:getText("fight_entry_homepage_panel_1679950741")
	self._tmpProgressAirWorkShop = self._registry:getUIComponent("fight_entry_homepage_panel_1089394524", UIComponentType.TextMeshProUGUI)
	self._goChapterLock = self._registry:getGo("0&fight_entry_chapter_item_-1970950902")
	self._goRightContent = self._registry:getGo("fight_entry_homepage_panel_614034522")
	self._goRightContentItem = goutil.findChild(self._goRightContent, "item1")
	self._goRightNone = self._registry:getGo("fight_entry_homepage_panel_-556002580")
	self._goBottomNone = self._registry:getGo("fight_entry_homepage_panel_1834006440")
	self._goMainline = self._registry:getGo("fight_entry_homepage_panel_-1917272603")
	self._goEquipDungeon = self._registry:getGo("fight_entry_homepage_panel_-1641237997")
	self._goAirWorkShop = self._registry:getGo("fight_entry_homepage_panel_834696693")
	self._btnLastFight = self._registry:getBtn("fight_entry_homepage_panel_2066999732")
	self._btnMainline = self._registry:getBtn("fight_entry_homepage_panel_-194901206")
	self._btnEquipDungeon = self._registry:getBtn("fight_entry_homepage_panel_1023232601")
	self._btnAirWorkShop = self._registry:getBtn("fight_entry_homepage_panel_-918448462")

	self:_initParam()
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._allPeriodicityActivities = nil
end

function M:bindEvents()
	self._btnLastFight:AddClickListener(self._onClickLastFight, self)
	self._btnMainline:AddClickListener(self._onClickMainLine, self)
	self._btnEquipDungeon:AddClickListener(self._onClickEquipDungeon, self)
	self._btnAirWorkShop:AddClickListener(self._onClickAirWorkShop, self)
end

function M:unbindEvents()
	self._btnLastFight:RemoveClickListener()
	self._btnMainline:RemoveClickListener()
	self._btnEquipDungeon:RemoveClickListener()
	self._btnAirWorkShop:RemoveClickListener()
end

function M:onEnter()
	M.super.onEnter(self)
	self:_setEvent(true)
	self:_refreshView()
	RoguelikeAgent.instance:sendListTaskRequest()
	ControlActionAgent.instance:sendGetControlActionsRequest()
	self:_refreshRedDot()
end

function M:onExit()
	M.super.onExit(self)
	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_GET_AIR_MAP_NEWS_REPLY, self._handleOnGetAirMapNewsReply, self)
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self.initLockStatus, self)
		GlobalDispatcher:addEventListener(EventType.CLIMBING_TOWER_DARK_ROUND_CHANGE, self._handleClimbingTowerDarkRoundChange, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_GET_ALL_TASK, self._updateEntryRunGroup, self)
		GlobalDispatcher:addEventListener(EventType.CONTROLACTION_MONITORDATA_FINISH, self._updateControAction, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_GET_AIR_MAP_NEWS_REPLY, self._handleOnGetAirMapNewsReply, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self.initLockStatus, self)
		GlobalDispatcher:removeEventListener(EventType.CLIMBING_TOWER_DARK_ROUND_CHANGE, self._handleClimbingTowerDarkRoundChange, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_GET_ALL_TASK, self._updateEntryRunGroup, self)
		GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_MONITORDATA_FINISH, self._updateControAction, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
	end
end

function M:_initParam()
	local mainGo = self._registry:getMainGO()

	self._goChapterItem = goutil.findChild(mainGo, "fight_entry_chapter_item")
	self._curChapterItem = Astral.SimpleLuaComponentContainer.Add(self._goChapterItem, GameplayChapterItem)

	goutil.setActive(self._goRightContentItem, false)

	self._allPeriodicityActivities = {}

	local chapterCfg = DungeonConfig.instance:getCfgMaterialChapter()

	self._chapterName = {}

	for _, cfg in ipairs(chapterCfg) do
		self._chapterName[cfg.chapterId] = cfg.name
	end

	local systemEnum = GameEnum.SystemEnum

	self._entryComps = {}
	self._entryComps[systemEnum.MainLine] = {
		go = self._goMainline,
		viewName = ViewName.MainlineDungeonView,
		btn = self._btnMainline,
		goTimeLimit = self._registry:getGo("fight_entry_homepage_panel_1350258966"),
		txtTimeLimit = self._txtTimeLimitMainline,
		txtProgress = self._registry:getUIComponent("fight_entry_homepage_panel_982917119", UIComponentType.TextMeshProUGUI),
		sp = {
			imgBg = goutil.findChildImageComponent(self._goMainline, "imgDi")
		}
	}
	self._entryComps[systemEnum.EquipFightActivity] = {
		go = self._goEquipDungeon,
		viewName = ViewName.RedMistEntryView,
		btn = self._btnEquipDungeon,
		goTimeLimit = self._registry:getGo("fight_entry_homepage_panel_-1765018809"),
		txtTimeLimit = self._txtTimeLimitRegulatory,
		sp = {}
	}
	self._entryComps[systemEnum.PvpFightActivity] = {
		go = self._goAirWorkShop,
		viewName = ViewName.AirWorkShopMainView,
		btn = self._btnAirWorkShop,
		goTimeLimit = self._registry:getGo("fight_entry_homepage_panel_-180881245"),
		txtTimeLimit = self._txtTimeLimitAirWorkShop,
		txtProgress = self._registry:getUIComponent("fight_entry_homepage_panel_1089394524", UIComponentType.TextMeshProUGUI),
		sp = {
			goRedPoint = goutil.findChild(self._goAirWorkShop, "red_point"),
			imgLevel = self._registry:getImage("fight_entry_homepage_panel_-189777307"),
			imgQuality = self._registry:getImage("fight_entry_homepage_panel_-590039439"),
			imgLevel2 = self._registry:getImage("fight_entry_homepage_panel_1616942669"),
			goState = self._registry:getGo("fight_entry_homepage_panel_-1155087862"),
			txtStateTitle = self._registry:getText("fight_entry_homepage_panel_985183236"),
			goMsgSign = self._registry:getGo("fight_entry_homepage_panel_1069553446"),
			txtMsgNum = self._registry:getText("fight_entry_homepage_panel_-1641861514"),
			goStateImgs = {
				goutil.findChild(self._goAirWorkShop, "img2/imgGroup/imgUp"),
				goutil.findChild(self._goAirWorkShop, "img2/imgGroup/imgDown"),
				goutil.findChild(self._goAirWorkShop, "img2/imgGroup/imgEqual")
			}
		}
	}
end

function M:_onClickLastFight()
	local type = tonumber(self._recordCfg[1])
	local recordId = tonumber(self._recordCfg[2])
	local recordIndex = self._recordCfg[3]

	if type == 1 then
		local record = Astral.LocalStorage.Instance:GetString("dungeon_latest_info")
		local info = string.split(record, ",")
		local chapterInfo = {}

		chapterInfo.chapterId = tonumber(info[1])
		chapterInfo.dungeonIndex = tonumber(info[2])
		chapterInfo.difficulty = tonumber(info[3])
		chapterInfo.clickDungeon = true
		chapterInfo.needShowChapterSelect = true

		if not DungeonMainLineChapterModel.instance:checkLocalStorageLastLevelIlegal(record) then
			FloatWordMgr.instance:show("跳转失败")

			return
		end

		DungeonMainLineChapterModel.instance:tryEnterChapterScene(false, chapterInfo)
	elseif type == 2 then
		local info = Astral.LocalStorage.Instance:GetString("dungeon_latest_info")
		local dungeonMo = DungeonEquipExploreChapterModel.instance:getDungeonMoById(tonumber(info))

		if not dungeonMo or not dungeonMo:getIsUnlock() then
			FloatWordMgr.instance:show("跳转失败")

			return
		end

		DungeonMaterialChapterModel.instance:setClickChapterIdAndDungeonIndex(recordId, tonumber(recordIndex))
		ViewMgr.instance:open(ViewName.StableAreaChapterView)
	elseif type == 3 then
		local info = Astral.LocalStorage.Instance:GetString("dungeon_latest_info")
		local dungeonMo = DungeonEquipExploreChapterModel.instance:getDungeonMoById(tonumber(info))

		if not dungeonMo or not dungeonMo:getIsUnlock() then
			FloatWordMgr.instance:show("跳转失败")

			return
		end

		DungeonJumpController.instance:jumpToDungeonView(tonumber(info))
	end
end

function M:_onClickMainLine()
	if not self:_checkCanOpen(GameplayEntranceConfig.RecommendActivity.Mainline.SystemEnum) then
		return
	end

	if DungeonMainLineChapterModel.instance:isLastUnlockChapterNeedShow() then
		local latestChapterMo = DungeonMainLineChapterModel.instance:getLatestUnlockChapterMo(DungeonEnum.Difficulty.Easy)
		local chapterId = latestChapterMo:getChapterId()
		local difficulty = 1
		local chapterInfo = {}

		chapterInfo.chapterId = chapterId
		chapterInfo.dungeonIndex = latestChapterMo:getLastUnlockDungeonIndex()
		chapterInfo.difficulty = difficulty
		chapterInfo.needShowChapterSelect = true

		DungeonMainLineChapterModel.instance:tryEnterChapterScene(false, chapterInfo)
	else
		local chapterInfo = DungeonMainLineChapterModel.instance:getDungeonSceneChpaterInfo()

		chapterInfo.needShowChapterSelect = true

		DungeonMainLineChapterModel.instance:tryEnterChapterScene(false, chapterInfo)
	end
end

function M:_onClickRegulatory(co)
	if not self:_checkCanOpen(co.SystemEnum) then
		return
	end

	if not ControlActionModel.instance:isShowLoginView() then
		ViewMgr.instance:open(ViewName.ControlAction)

		return
	end

	ViewMgr.instance:open(co.ViewName)
end

function M:_onClickEquipDungeon()
	local co = GameplayEntranceConfig.RecommendActivity.EquipFightActivity

	if not self:_checkCanOpen(co.SystemEnum) then
		return
	end

	ViewMgr.instance:open(co.ViewName)
end

function M:_onClickAirWorkShop()
	local co = GameplayEntranceConfig.RecommendActivity.AirWorkShop

	if not self:_checkCanOpen(co.SystemEnum) then
		return
	end

	ViewMgr.instance:open(co.ViewName)
end

function M:_onClickPeriodicEntry(co)
	if not SystemOpenFacade.instance:isOpen(co.SystemEnum, true) then
		return
	end

	if not SystemOpenModel.instance:getSystemIsOnline(co.SystemEnum, true) then
		FloatWordMgr.instance:show(lang("tip_system_open_not_online"))

		return
	end

	if co.SystemEnum == GameEnum.SystemEnum.ControlAction then
		self:_onClickRegulatory(co)

		return
	end

	ViewMgr.instance:open(co.ViewName)
end

function M:_refreshView()
	self:_updateBtnLast()
	self:_updateRecommendEntry()
	self:_updatePeriodicEntry()
end

function M:_updateRecommendEntry()
	self:_updateEntryMainLine()
	self:_updateEquipDungeon()
	self:_updateEntryAirWorkShop()

	local systemEnum = GameEnum.SystemEnum

	goutil.setActive(self._goBottomNone, self:_getOpenActivityCount({
		systemEnum.MainLine,
		systemEnum.EquipFightActivity,
		systemEnum.PvpFightActivity
	}) == 0)
end

function M:_updatePeriodicEntry()
	for k, v in pairs(self._allPeriodicityActivities or {}) do
		v:setActive(false)
	end

	local index = 0
	local activity = GameplayEntranceConfig.PeriodicityActivity

	for k, v in pairs(activity) do
		index = index + 1

		local item = self._allPeriodicityActivities[index]

		if not item then
			local go = goutil.cloneAndSetParent(self._goRightContentItem, self._goRightContent.transform)

			item = Astral.SimpleLuaComponentContainer.Add(go, GameplayPeriodicityActivityItem)
			self._allPeriodicityActivities[index] = item
			self._entryComps[v.SystemEnum] = {
				txtProgress = goutil.findChildTextComponent(go, "click/layout/txtTitle/txtProgress"),
				imgProgress = goutil.findChildImageComponent(go, "click/layout/objProgress/imgProgress"),
				objProgress = goutil.findChild(go, "click/layout/objProgress"),
				goTimeLimit = goutil.findChild(go, "click/limitTimeSign"),
				txtTimeLimit = goutil.findChildTextComponent(go, "click/limitTimeSign/txtLimitTime"),
				txtTitle = goutil.findChildTextComponent(go, "click/layout/txtTitle"),
				go = go
			}
		end

		local data = {}

		function data.callback()
			self:_onClickPeriodicEntry(v)
		end

		data.icon = v.BgSpriteName
		data.name = lang(v.NameText)
		data.task = lang(v.TaskText)

		if SystemOpenFacade.instance:isOpen(v.SystemEnum) and SystemOpenModel.instance:getSystemIsOnline(v.SystemEnum, true) then
			item:updateData(data)
		end
	end

	self:_updateEntryClimbingTower()
	self:_updateControAction()

	local systemEnum = GameEnum.SystemEnum

	goutil.setActive(self._goRightNone, self:_getOpenActivityCount({
		systemEnum.RunGroupActivity,
		systemEnum.ControlAction,
		systemEnum.ClimbTowerActivity
	}) == 0)
end

function M:_getOpenActivityCount(systemEnums)
	local curActivityCount = 0

	for k, v in pairs(systemEnums) do
		if SystemOpenFacade.instance:isOpen(v) and SystemOpenModel.instance:getSystemIsOnline(v, true) then
			curActivityCount = curActivityCount + 1
		end
	end

	return curActivityCount
end

function M:_updateBtnLast()
	local recordCfg = Astral.LocalStorage.Instance:GetString("dungeon_latest_type")
	local id = Astral.LocalStorage.Instance:GetString("dungeon_latest_id")

	self._recordCfg = string.split(recordCfg, ",")

	local goLastFight = self._btnLastFight.gameObject

	if id ~= PlayerModel.instance:getId() or string.nilorempty(recordCfg) then
		goutil.setActive(goLastFight, false)

		return
	else
		goutil.setActive(goLastFight, true)
	end

	local recordId = tonumber(self._recordCfg[2])
	local recordIndex = self._recordCfg[3]

	if tonumber(self._recordCfg[1]) == 1 then
		local dungeonCfg = DungeonConfig.instance:getCfgMainLineChapterIncludePlot(recordId)

		if not dungeonCfg then
			goutil.setActive(goLastFight, false)

			return
		end

		local dungeonName = dungeonCfg.name .. recordIndex
		local dungeonCo = DungeonConfig.instance:getDungeonCfgById(recordId)

		if dungeonCo then
			if dungeonCo.type == CommEnum.DungeonType.Mainline then
				local difficultyDesc = DungeonEnum.MainLineDiffName[DungeonEnum.Difficulty.Easy]
				local mainlineCO = DungeonConfig.instance:getCfgMainLineChapterIncludePlot(recordId)

				if mainlineCO then
					difficultyDesc = DungeonEnum.MainLineDiffName[mainlineCO.difficulty]
				else
					printError("Mainline dungeon config is not found, id ", recordId)
				end

				dungeonName = langF("task_mainline_dungeon_format_name", difficultyDesc, dungeonCo.index)
			elseif dungeonCo.type == CommEnum.DungeonType.LightTower then
				dungeonName = langF("task_lighttow_dungeon_format_name", dungeonCo.index)
			elseif dungeonCo.type == CommEnum.DungeonType.DarkTower then
				dungeonName = langF("task_darktow_dungeon_format_name", dungeonCo.index)
			else
				dungeonName = langF("task_common_dungeon_format_name", DungeonConfig.instance:getDungeonTypeName(dungeonCo.type), dungeonCo.index)
			end
		else
			local difficultyDesc = DungeonEnum.MainLineDiffName[DungeonEnum.Difficulty.Easy]
			local co = DungeonConfig.instance:getMainlinePlotDungeonCOByDungeonId(recordId)

			if co then
				dungeonName = langF("task_mainline_dungeon_format_name", difficultyDesc, co.index)
			else
				print("找不到副本", recordId)
			end
		end

		self._txtLastChapterName.text = dungeonName
	else
		self._txtLastChapterName.text = self._chapterName[recordId] .. string.format("%s", recordIndex)
	end
end

function M:_updateEntryMainLine()
	local systemEnum = GameEnum.SystemEnum.MainLine
	local comps = self._entryComps[systemEnum]

	goutil.setActive(comps.go, self:_getOpenActivityCount({
		GameEnum.SystemEnum.MainLine,
		GameEnum.SystemEnum.ControlAction,
		GameEnum.SystemEnum.PvpFightActivity
	}) > 0)
	goutil.setActive(comps.goTimeLimit, false)

	local latestChapterMo = DungeonMainLineChapterModel.instance:getLatestUnlockChapterMo(DungeonEnum.Difficulty.Easy)
	local dungeonIds = latestChapterMo:getNormalDungeonIds()
	local maxProgress = #dungeonIds
	local curProgress = latestChapterMo:getLastUnlockDungeonIndex()
	local dungeonId = dungeonIds[curProgress]
	local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(dungeonId)

	comps.txtProgress.text = dungeonMo and dungeonMo:getIndex() or ""
	comps = comps.sp

	local chapterMOList = DungeonMainLineChapterModel.instance:getAllMainlineChapter()

	self._unlockChapterMOList = {}

	for i, chapterMO in ipairs(chapterMOList) do
		if chapterMO[1]:isPreChapterPassed() then
			table.insert(self._unlockChapterMOList, chapterMO)
		end
	end

	local data = {}

	data.mo = self._unlockChapterMOList[#self._unlockChapterMOList]

	self._curChapterItem:updateData(data)

	local dungeonCO = latestChapterMo:getChapterCO()

	IconLoader.setSprite(comps.imgBg, IconType.Mainline, string.format("fight_chapter/%s_01", dungeonCO.iconRes))

	local chapterInfo = {}
	local info = Astral.LocalStorage.Instance:GetString("mainline_record")
	local id = Astral.LocalStorage.Instance:GetString("dungeon_latest_id")

	if id ~= PlayerModel.instance:getId() or string.nilorempty(info) or not DungeonMainLineChapterModel.instance:checkLocalStorageLastLevelIlegal(info) then
		info = string.split(info, ",")
		chapterInfo.chapterId = tonumber(info[1])
		chapterInfo.dungeonIndex = tonumber(info[2])
		chapterInfo.difficulty = tonumber(info[3])
	else
		chapterInfo.chapterId = latestChapterMo:getChapterId()
		chapterInfo.dungeonIndex = latestChapterMo:getLastUnlockDungeonIndex()
		chapterInfo.difficulty = latestChapterMo:getChapterDifficulty()
	end

	DungeonMainLineChapterModel.instance:recordDungeonSceneChpaterInfo(chapterInfo)
end

function M:initLockStatus()
	for systemEnum, comps in pairs(self._entryComps) do
		local unlock = SystemOpenFacade.instance:isOpen(systemEnum)

		goutil.setActive(comps.go, not unlock)
	end

	self:showUnlock()
end

function M:showUnlock()
	self:_refreshView()
end

function M:_handleClimbingTowerDarkRoundChange(e)
	self:_updateEntryClimbingTower()
end

function M:_handleOnRodeoInfoChange(e)
	self:_updateEntryAirWorkShop()
end

function M:_updateEntryRunGroup()
	local systemEnum = GameEnum.SystemEnum.RunGroupActivity
	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
	local isOnline = SystemOpenModel.instance:getSystemIsOnline(systemEnum, true)
	local comps = self._entryComps[systemEnum]
	local txtProgress = comps.txtProgress
	local txtTime = comps.txtTimeLimit
	local tabId = TaskModel.instance:getTabIdByType(TaskEnum.TaskType.RogueWeekly)

	if not tabId then
		return
	end

	local curTaskList = TaskModel.instance:getTaskList(tabId)
	local progress

	if curTaskList then
		local cur = TaskUtil.getFinishCount(curTaskList)

		progress = unlock and string.format("%s/%s", cur, #curTaskList) or nil
		comps.imgProgress.fillAmount = cur / #curTaskList
	end

	txtProgress.text = progress

	local limitTaskTime = RogueTaskView:getWeekLastTime()
	local tabTime = TextFormatter.formatFullTime(limitTaskTime, true)

	txtTime.text = tabTime

	goutil.setActive(comps.objProgress, false)
	goutil.setActive(comps.go, isOnline and unlock)
end

function M:_updateEntryClimbingTower()
	local systemEnum = GameEnum.SystemEnum.ClimbTowerActivity
	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
	local isOnline = SystemOpenModel.instance:getSystemIsOnline(systemEnum, true)
	local comps = self._entryComps[systemEnum]
	local txtProgress = comps.txtProgress
	local endTimeStamp = 0
	local progress

	if unlock then
		local darkRound = ClimbingTowerDarkModel.instance:getDarkRound()
		local darkRoundCO
		local show = darkRound > 0

		if show then
			darkRoundCO = ClimbingTowerConfig.instance:getDarkRoundCO(darkRound)
		end

		if darkRoundCO == nil then
			show = false
		end

		if show and darkRoundCO:isExpired() then
			show = false
		end

		local bightClearCount = ClimbingTowerModel.instance:getClearDungeonCount()

		if bightClearCount < self:getDarkSideUnLockCondition() or not show then
			local maxStorey = ClimbingTowerConfig.instance:getBrightSideMaxStorey()

			progress = string.format("%s/%s", bightClearCount, maxStorey)
			comps.imgProgress.fillAmount = bightClearCount / maxStorey
			endTimeStamp = 0
			comps.txtTitle.text = lang("tip_climb_tower_bright_side")
		elseif show then
			local maxStorey = darkRoundCO:getDungeonCount()
			local clearCount = ClimbingTowerDarkModel.instance:getClearDungeonCount(darkRound)

			progress = string.format("%s/%s", clearCount, maxStorey)
			comps.imgProgress.fillAmount = clearCount / maxStorey
			comps.txtTitle.text = lang("tip_climb_tower_dark_side")
			endTimeStamp = darkRoundCO:getEndTimeStamp()
		end
	end

	txtProgress.text = progress

	local nowTime = ServerTime.now()
	local remainTimeStr = self:_formatRemainTime(endTimeStamp, nowTime)

	self._entryComps[systemEnum].txtTimeLimit.text = endTimeStamp == 0 and "" or remainTimeStr

	goutil.setActive(comps.go, isOnline and unlock)
	goutil.setActive(comps.objProgress, true)
	goutil.setActive(comps.goTimeLimit, endTimeStamp ~= 0)
end

function M:getDarkSideUnLockCondition()
	if self:getConst("DarkTowerUnlockCondition") then
		return self:getConst("DarkTowerUnlockCondition").numValue
	else
		return 0
	end
end

function M:getConst(key)
	local data = ClimbingTowerConfig.instance:getConfigList(ConfigName.ClimbTowerConst)
	local temp

	for k, v in pairs(data) do
		if v.key == key then
			return v
		end
	end
end

function M:_updateEntryAirWorkShop()
	local systemEnum = GameEnum.SystemEnum.PvpFightActivity
	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
	local isOnline = SystemOpenModel.instance:getSystemIsOnline(systemEnum, true)
	local comps = self._entryComps[systemEnum]

	goutil.setActive(comps.go, unlock and isOnline)

	comps = comps.sp

	local curGrade, state

	if unlock and isOnline then
		curGrade = AirWorkShopChallengeModel.instance:getCurLvGradeStr()
		state = unlock and AirWorkShopChallengeModel.instance:getLvState() or nil
	end

	goutil.setActive(comps.goState, unlock)

	if state then
		local changeLv = AirWorkShopEnum.LvStateNum[state] or 0
		local showIdx = 3
		local showStr = lang("tip_air_lv_state_change_keep")

		if changeLv > 0 then
			showIdx = 1
			showStr = langF("tip_air_lv_state_change_up", changeLv)
		elseif changeLv < 0 then
			showStr = langF("tip_air_lv_state_change_down", math.abs(changeLv))
			showIdx = 2
		end

		for k, v in pairs(comps.goStateImgs) do
			goutil.setActive(v, k == showIdx)
		end

		comps.txtStateTitle.text = showStr

		local changeLvStr = changeLv == 0 and "" or math.abs(changeLv)

		self._entryComps[systemEnum].txtProgress.text = ""
	end

	goutil.setActive(comps.goState, state ~= nil)

	local infoMo = AirWorkShopChallengeModel.instance:getPlayerInfoMo()

	if infoMo then
		local curLv = infoMo:getLv()

		AirWorkShopUtil.rodeoLvImgChange(curLv, comps.imgLevel, comps.imgLevel2, nil, comps.imgQuality)
	end

	local nowTime = ServerTime.now()
	local inCalculateTime = AirWorkShopUtil.getInRodeoCalculateTime(nowTime, false)
	local remainTimeStr

	if inCalculateTime then
		remainTimeStr = lang("tip_air_workshop_in_calculate_time")
	else
		remainTimeStr = self:_formatRemainTime(AirWorkShopUtil.getRodeoEndTimeStamp(nowTime), nowTime)
	end

	self._entryComps[systemEnum].txtTimeLimit.text = remainTimeStr

	local hasRedPoint = false

	if unlock and isOnline then
		local canRodeoSettle = AirWorkShopUtil.getCanRodeoSettle()
		local taskActive = RedDotModel.instance:getDotIsActive(GameEnum.RedPointEnum.AirTask)

		hasRedPoint = canRodeoSettle or taskActive
	end

	goutil.setActive(self._entryComps[systemEnum].sp.goRedPoint, hasRedPoint)

	local allMsgCount = AirWorkShopModel.instance:getAllAirMapNewsCount()

	goutil.setActive(self._entryComps[systemEnum].sp.goMsgSign, allMsgCount > 0 and unlock and isOnline)

	self._entryComps[systemEnum].sp.txtMsgNum.text = allMsgCount > 99 and "99+" or allMsgCount
end

function M:_updateControAction()
	local systemEnum = GameEnum.SystemEnum.ControlAction
	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
	local isOnline = SystemOpenModel.instance:getSystemIsOnline(systemEnum, true)
	local comps = self._entryComps[systemEnum]
	local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(nil, true, true, false)
	local isShow = not inTimeByItem and not inSpTime

	goutil.setActive(comps.go, unlock and isOnline)

	local weekTotalTimes = ControlActionConfig.instance:getConstValue(ControlActionEnum.WeekLimitTime)
	local weekLeftTimes = ControlActionModel.instance:getWeekLeftTimes()
	local weekTimeText = ""

	if weekLeftTimes <= 0 then
		weekTimeText = langF("control_action_week_times_zero", 0, weekTotalTimes)
	else
		weekTimeText = langF("control_action_week_times", weekLeftTimes, weekTotalTimes)
	end

	comps.imgProgress.fillAmount = weekLeftTimes / weekTotalTimes
	comps.txtProgress.text = ""
	comps.txtTitle.text = langF("tip_left_num_s", "#3B3B3B", weekLeftTimes, weekTotalTimes)

	goutil.setActive(comps.goTimeLimit, false)
	goutil.setActive(comps.objProgress, false)
end

function M:_updateEquipDungeon()
	local systemEnum = GameEnum.SystemEnum.EquipFightActivity
	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
	local isOnline = SystemOpenModel.instance:getSystemIsOnline(systemEnum, true)
	local comps = self._entryComps[systemEnum]

	goutil.setActive(comps.go, unlock and isOnline)
	goutil.setActive(comps.goTimeLimit, false)
end

function M:_refreshRedDot(e, info)
	local hasRedPoint = false

	if SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.PvpFightActivity) then
		local canRodeoSettle = AirWorkShopUtil.getCanRodeoSettle()
		local taskActive = RedDotModel.instance:getDotIsActive(GameEnum.RedPointEnum.AirTask)

		hasRedPoint = canRodeoSettle or taskActive
	end

	goutil.setActive(self._entryComps[GameEnum.SystemEnum.PvpFightActivity].sp.goRedPoint, hasRedPoint)
	self:_handleOnGetAirMapNewsReply()
end

function M:_handleOnGetAirMapNewsReply()
	local allMsgCount = 0

	if SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.PvpFightActivity) then
		allMsgCount = AirWorkShopModel.instance:getAllAirMapNewsCount()
	end

	goutil.setActive(self._entryComps[GameEnum.SystemEnum.PvpFightActivity].sp.goMsgSign, allMsgCount > 0)

	self._entryComps[GameEnum.SystemEnum.PvpFightActivity].sp.txtMsgNum.text = allMsgCount > 99 and "99+" or allMsgCount
end

return M
