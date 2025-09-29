-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/fragment/GameplayChallengeFragmentView.lua

module("logic.extensions.dungeon.view.entrance.fragment.GameplayChallengeFragmentView", package.seeall)

local M = class("GameplayChallengeFragmentView", GameplaySubViewBase)

function M:buildUI()
	M.super.buildUI(self)

	self._allItems = {}
	self._entryComps = {}
	self._goContent = self._registry:getGo("fight_entry_challenge_panel_-37007609")

	self:_initChallengeContent()
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._allItems = nil
	self._goContent = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	M.super.onEnter(self)
	self:_setEvent(true)
	self:_refreshView()
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
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_GET_AIR_MAP_NEWS_REPLY, self._handleOnGetAirMapNewsReply, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self.initLockStatus, self)
		GlobalDispatcher:removeEventListener(EventType.CLIMBING_TOWER_DARK_ROUND_CHANGE, self._handleClimbingTowerDarkRoundChange, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_GET_ALL_TASK, self._updateEntryRunGroup, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
	end
end

function M:_handleClimbingTowerDarkRoundChange(e)
	self:_updateEntryClimbingTower()
end

function M:_handleOnRodeoInfoChange(e)
	self:_updateEntryAirWorkShop()
end

function M:_refreshRedDot()
	local hasRedPoint = false

	if SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.PvpFightActivity) then
		local canRodeoSettle = AirWorkShopUtil.getCanRodeoSettle()
		local taskActive = RedDotModel.instance:getDotIsActive(GameEnum.RedPointEnum.AirTask)

		hasRedPoint = canRodeoSettle or taskActive
	end

	goutil.setActive(self._entryComps[GameEnum.SystemEnum.PvpFightActivity].goRedPoint, hasRedPoint)
	self:_handleOnGetAirMapNewsReply()
end

function M:_handleOnGetAirMapNewsReply()
	local allMsgCount = AirWorkShopModel.instance:getAllAirMapNewsCount()

	goutil.setActive(self._entryComps[GameEnum.SystemEnum.PvpFightActivity].goMsgSign, allMsgCount > 0 and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.PvpFightActivity))

	self._entryComps[GameEnum.SystemEnum.PvpFightActivity].txtMsgNum.text = allMsgCount > 99 and "99+" or allMsgCount
end

function M:_initChallengeContent()
	local transform = self._goContent.transform

	for i = 1, transform.childCount do
		local go = transform:GetChild(i - 1).gameObject
		local item = Astral.SimpleLuaComponentContainer.Add(go, GameplayChallengeItem)

		self._allItems[i] = item

		local co = GameplayEntranceConfig.ChallengeActivity[i]

		self._entryComps[co.SystemEnum] = {
			goTimeLimit = goutil.findChild(go, "click/layout/limitTimeSign"),
			goBlackLine = goutil.findChild(go, "click/img3"),
			txtTimeLimit = goutil.findChildTextComponent(go, "click/layout/limitTimeSign/txtLimitTime"),
			txtName = goutil.findChildTextComponent(go, "click/txtName"),
			txtProgress = goutil.findChildTextComponent(go, "click/txtName/txtProgress"),
			goRedPoint = goutil.findChild(go, "click/red_point"),
			goMsgSign = goutil.findChild(go, "click/layout/messageSign"),
			txtMsgNum = goutil.findChildTextComponent(go, "click/layout/messageSign/txtMessageNum"),
			sp = {
				goWorkShop = goutil.findChild(go, "click/objAirWorkShop"),
				imgLevel = goutil.findChildImageComponent(go, "click/objAirWorkShop/imgLevel1"),
				imgQuality = goutil.findChildImageComponent(go, "click/objAirWorkShop/imgLevel1/imgQuality"),
				imgLevel2 = goutil.findChildImageComponent(go, "click/objAirWorkShop/imgLevel1/imgLevel2"),
				imgBg = goutil.findChildImageComponent(go, "click/objAirWorkShop/imgQualityBg_s"),
				goStateImgs = {
					goutil.findChild(go, "click/txtName/txtProgress/imgGroup/imgUp"),
					goutil.findChild(go, "click/txtName/txtProgress/imgGroup/imgDown"),
					goutil.findChild(go, "click/txtName/txtProgress/imgGroup/imgEqual")
				}
			},
			go = go
		}
	end
end

function M:_refreshView()
	self:_updateChallengeContent()
	self:_updateEntryAirWorkShop()
	self:_updateEntryClimbingTower()
	self:_updateEntryRunGroup()
	self:_updateEntryTeach()
end

function M:initLockStatus()
	for systemEnum, comps in pairs(self._entryComps) do
		local unlock = SystemOpenFacade.instance:isOpen(systemEnum)

		goutil.setActive(comps.go, not unlock)
	end

	self:_refreshView()
end

function M:_updateChallengeContent()
	for k, v in pairs(self._allItems) do
		local data = {}

		function data.callback()
			self:_onItemClickCallback(k)
		end

		local co = GameplayEntranceConfig.ChallengeActivity[k]

		data.unlock = self:_getCanOpen(co.SystemEnum)

		local lockDesc

		if not data.unlock then
			local systemOpenCO = SystemOpenConfig.instance:getSystemOpenCOById(co.SystemEnum)

			if systemOpenCO and not string.nilorempty(systemOpenCO:getUnlockText()) then
				lockDesc = systemOpenCO:getUnlockText()
			end
		end

		data.unlockText = lockDesc

		v:updateData(data)
	end
end

function M:_onItemClickCallback(index)
	local co = GameplayEntranceConfig.ChallengeActivity[index]

	if self:_checkCanOpen(co.SystemEnum) then
		ViewMgr.instance:open(co.ViewName)
	end
end

function M:_updateEntryRunGroup()
	local systemEnum = GameEnum.SystemEnum.RunGroupActivity
	local comps = self._entryComps[systemEnum]
	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
	local limitTaskTime = RogueTaskView:getWeekLastTime()
	local tabTime = TextFormatter.formatFullTime(limitTaskTime, true)

	comps.txtTimeLimit.text = tabTime

	local tabId = TaskModel.instance:getTabIdByType(TaskEnum.TaskType.RogueWeekly)
	local progress = ""

	if tabId then
		local curTaskList = TaskModel.instance:getTaskList(tabId)

		if curTaskList then
			local cur = TaskUtil.getFinishCount(curTaskList)

			progress = unlock and string.format("%s/%s", cur, #curTaskList) or nil
		end
	end

	comps.txtName.text = lang("tip_r_task_weekly") .. progress

	goutil.setActive(comps.goBlackLine, unlock)
	goutil.setActive(comps.txtName.gameObject, unlock)
end

function M:_updateEntryTeach()
	local systemEnum = GameEnum.SystemEnum.TeachFightActivity
	local comps = self._entryComps[systemEnum]
	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
	local progress

	if unlock then
		local cur = 0
		local max = 0
		local chapterList = DungeonTeachingChapterModel.instance:getAllChapter()

		for k, chapterMo in pairs(chapterList) do
			local dungeonIds = chapterMo:getDungeonIds()

			max = max + #dungeonIds
			cur = cur + chapterMo:getPassedDungeonCount()
		end

		progress = string.format("总进度%.0f%%", 100 * cur / max)
	end

	comps.txtName.text = progress

	goutil.setActive(comps.goTimeLimit, false)
	goutil.setActive(comps.goBlackLine, unlock)
	goutil.setActive(comps.txtName.gameObject, unlock)
end

function M:_updateEntryAirWorkShop()
	local systemEnum = GameEnum.SystemEnum.PvpFightActivity
	local comp = self._entryComps[systemEnum]
	local comps = self._entryComps[systemEnum].sp
	local infoMo = AirWorkShopChallengeModel.instance:getPlayerInfoMo()

	if infoMo then
		local curLv = infoMo:getLv()

		AirWorkShopUtil.rodeoLvImgChange(curLv, comps.imgLevel, comps.imgLevel2, comps.imgBg, comps.imgQuality)
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

	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
	local isOnline = SystemOpenModel.instance:getSystemIsOnline(systemEnum, true)
	local state, curGrade

	if unlock and isOnline then
		curGrade = AirWorkShopChallengeModel.instance:getCurLvGradeStr()
		state = unlock and AirWorkShopChallengeModel.instance:getLvState() or nil
	end

	local changeLv = 0

	if state then
		changeLv = AirWorkShopEnum.LvStateNum[state] or 0

		local showStr = lang("tip_air_lv_state_change_keep")
		local showIdx = 3

		if changeLv > 0 then
			showIdx = 1
			showStr = langF("tip_air_lv_state_change_up", changeLv)
		elseif changeLv < 0 then
			showIdx = 2
			showStr = langF("tip_air_lv_state_change_down", math.abs(changeLv))
		end

		for k, v in pairs(comps.goStateImgs) do
			goutil.setActive(v, k == showIdx)
		end

		comp.txtName.text = showStr

		local changeLvStr = changeLv == 0 and "" or math.abs(changeLv)

		comp.txtProgress.text = ""
	end

	local isShow = unlock and state

	goutil.setActive(comp.goBlackLine, isShow)
	goutil.setActive(comp.txtName.gameObject, isShow)
	goutil.setActive(comp.txtProgress.gameObject, isShow)
	goutil.setActive(comps.goWorkShop, unlock)

	local hasRedPoint = false

	if unlock and isOnline then
		local canRodeoSettle = AirWorkShopUtil.getCanRodeoSettle()
		local taskActive = RedDotModel.instance:getDotIsActive(GameEnum.RedPointEnum.AirTask)

		hasRedPoint = canRodeoSettle or taskActive
	end

	goutil.setActive(comp.goRedPoint, hasRedPoint)
	self:_handleOnGetAirMapNewsReply()
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
			endTimeStamp = 0
			comps.txtName.text = lang("tip_climb_tower_bright_side")
		elseif show then
			comps.txtName.text = lang("tip_climb_tower_dark_side")

			local maxStorey = darkRoundCO:getDungeonCount()
			local clearCount = ClimbingTowerDarkModel.instance:getClearDungeonCount(darkRound)

			progress = string.format("%s/%s", clearCount, maxStorey)
			endTimeStamp = darkRoundCO:getEndTimeStamp()
		end
	end

	txtProgress.text = progress

	local nowTime = ServerTime.now()
	local remainTimeStr = self:_formatRemainTime(endTimeStamp, nowTime)

	comps.txtTimeLimit.text = endTimeStamp == 0 and "" or remainTimeStr

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

return M
