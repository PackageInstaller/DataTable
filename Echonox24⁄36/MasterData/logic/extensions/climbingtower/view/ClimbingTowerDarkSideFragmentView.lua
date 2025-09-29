-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/view/ClimbingTowerDarkSideFragmentView.lua

module("logic.extensions.climbingtower.view.ClimbingTowerDarkSideFragmentView", package.seeall)

local M = class("ClimbingTowerDarkSideFragmentView", ClimbingTowerBasePage)

function M:buildUI()
	M.super.buildUI(self)

	local registry = self:getRegistry()

	self._btnReturn = UIComponentType.ButtonAdapter(registry:findUIElement("title_view_-878360263"))
	self._btnHome = UIComponentType.ButtonAdapter(registry:findUIElement("title_view_1398742689"))

	goutil.setActive(self._btnHome.gameObject, true)

	self._txtDarkSideTime = registry:findUIElement("climbing_tower_dark_face_panel_1258918016", UIComponentType.Text)
	self._nodeEntry = {}

	local nodeLstRoot = registry:findUIElement("climbing_tower_dark_face_panel_-1137363152", UIComponentType.RectTransform)

	for i = 0, nodeLstRoot.childCount - 1 do
		local tmpGo = nodeLstRoot:GetChild(i).gameObject
		local shower = Astral.LuaComponentContainer.Get(tmpGo, ClimbingTowerDarkSideTabCell)

		if shower == nil then
			shower = Astral.LuaComponentContainer.Add(tmpGo, ClimbingTowerDarkSideTabCell)

			shower:buildUI()
		end

		table.insert(self._nodeEntry, shower)
	end

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:addToggleTab(registry:findUIElement("climbing_tower_dark_face_panel_-1349944802", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(registry:findUIElement("climbing_tower_dark_face_panel_-498203556", UIComponentType.SpaceXToggle))

	self._pageGroup = {}
	self._pageGroup[1] = registry:findUIElement("climbing_tower_dark_face_panel_-1020214700")
	self._pageGroup[2] = registry:findUIElement("climbing_tower_dark_face_panel_-1455362509")
	self._trBlueBuffRoot = registry:findUIElement("climbing_tower_dark_face_panel_-1411427108", UIComponentType.RectTransform)
	self._trRedBuffRoot = registry:findUIElement("climbing_tower_dark_face_panel_-352357140", UIComponentType.RectTransform)
	self._goDungeonPanel = registry:findUIElement("climbing_tower_dark_face_panel_-386732745")
	self._txtDungeonIndex = registry:findUIElement("climbing_tower_dark_face_panel_2043001866", UIComponentType.Text)
	self._txtDungeonName = registry:findUIElement("climbing_tower_dark_face_panel_-54073150", UIComponentType.Text)
	self._txtDungeonDesc = registry:findUIElement("climbing_tower_dark_face_panel_-984443327", UIComponentType.Text)
	self._dungeonScoreRateGo = registry:findUIElement("2&instance_danger_-1654566369")
	self._goDungeonConditionRoot = registry:findUIElement("climbing_tower_dark_face_panel_-62489623")
	self._dungeonConditionItem = {
		{
			root = registry:findUIElement("climbing_tower_dark_face_panel_-1835135050"),
			txtDesc = registry:findUIElement("climbing_tower_dark_face_panel_-188073826", UIComponentType.Text)
		},
		{
			root = registry:findUIElement("climbing_tower_dark_face_panel_-1086991073"),
			txtDesc = registry:findUIElement("climbing_tower_dark_face_panel_954825256", UIComponentType.Text)
		},
		{
			root = registry:findUIElement("climbing_tower_dark_face_panel_-1066858535"),
			txtDesc = registry:findUIElement("climbing_tower_dark_face_panel_870797912", UIComponentType.Text)
		}
	}
	self._goDungeonRewardLst = registry:findUIElement("climbing_tower_dark_face_panel_-873713792")
	self._goRewardItemPrefab = registry:findUIElement("rewards_detail_item_2141037416")

	goutil.setActive(self._goRewardItemPrefab, false)

	self._btnDugeonMoreReward = UIComponentType.ButtonAdapter(registry:findUIElement("climbing_tower_dark_face_panel_-1008881786"))
	self._btnDungeonFight = UIComponentType.ButtonAdapter(registry:findUIElement("climbing_tower_dark_face_panel_-735916749"))
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._guiAnimationRightPanel = goutil.addComponentOnce(self._goDungeonPanel, typeof(Astral.GUITimelineAniLua))
	self._canvasGroupLine = registry:findUIElement("climbing_tower_dark_face_panel_1220380774", ComponentType.CanvasGroup)
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._btnReturn = nil
	self._btnHome = nil
	self._txtDarkSideTime = nil

	for _, value in pairs(self._nodeEntry or {}) do
		value:destroyUI()
	end

	self._nodeEntry = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
	self._pageGroup = nil
	self._trBlueBuffRoot = nil
	self._trRedBuffRoot = nil
	self._goDungeonPanel = nil
	self._txtDungeonIndex = nil
	self._txtDungeonName = nil
	self._txtDungeonDesc = nil
	self._dungeonScoreRateGo = nil
	self._goDungeonConditionRoot = nil
	self._dungeonConditionItem = nil
	self._goDungeonRewardLst = nil
	self._goRewardItemPrefab = nil
	self._btnDugeonMoreReward = nil
	self._btnDungeonFight = nil
	self._guiAnimation = nil
	self._guiAnimationRightPanel = nil
	self._canvasGroupLine = nil
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnDugeonMoreReward:AddClickListener(self._onClickDugeonMoreReward, self)
	self._btnDungeonFight:AddClickListener(self._onClickDungeonFight, self)

	for _, value in pairs(self._nodeEntry or {}) do
		value:bindEvents()
	end

	self._guiAnimation:AddListener(self._handleViewAniDoneEvent, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnDugeonMoreReward:RemoveClickListener()
	self._btnDungeonFight:RemoveClickListener()

	for _, value in pairs(self._nodeEntry or {}) do
		value:unbindEvents()
	end

	self._guiAnimation:RemoveListener()
end

function M:onEnter()
	M.super.onEnter(self)

	self._canvasGroupLine.alpha = 1

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")

	local darkRound = ClimbingTowerDarkModel.instance:getDarkRound()

	if enableLog then
		print("暗面轮数：", darkRound)
	end

	self._darkRoundCO = ClimbingTowerConfig.instance:getDarkRoundCO(darkRound)

	if not self._darkRoundCO then
		self:close()

		return
	end

	self._curDarkRound = darkRound

	if self:checkExpire() then
		self:onDarkSideExpire()

		return
	end

	self:refreshEntryTab()

	local clearCount = ClimbingTowerDarkModel.instance:getClearDungeonCount(darkRound)
	local maxStorey = self._darkRoundCO:getDungeonCount()
	local defaultIndex = 1

	if maxStorey <= clearCount then
		defaultIndex = maxStorey
	else
		defaultIndex = clearCount > 0 and clearCount + 1 or 1
	end

	self:onEntryTabClick(self._nodeEntry[defaultIndex])
	self:_setEvent(true)

	local endTimeStamp = self._darkRoundCO:getEndTimeStamp()

	self._darkSideRemainedTime = endTimeStamp - ServerTime.now()

	self:darkTimerControl(true)
end

function M:onExit()
	if self._tweenDelayDefaultTab then
		self._tweenDelayDefaultTab:Kill(false)

		self._tweenDelayDefaultTab = nil
	end

	self._guiAnimation:StopTimelineAni()
	self._guiAnimationRightPanel:StopTimelineAni()
	M.super.onExit(self)
	self:_setEvent(false)
	self:darkTimerControl(false)
	self:setLastTabCell(nil)

	for _, value in pairs(self._nodeEntry or {}) do
		value:onExit()
	end

	self._darkRound = nil
	self._activeIndex = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKHOUR, self._handleClockTickHour, self)
		GlobalDispatcher:addEventListener(EventType.CLIMBING_TOWER_DARK_ROUND_CHANGE, self._handleClimbingTowerDarkRoundChange, self)
		GlobalDispatcher:addEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	else
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKHOUR, self._handleClockTickHour, self)
		GlobalDispatcher:removeEventListener(EventType.CLIMBING_TOWER_DARK_ROUND_CHANGE, self._handleClimbingTowerDarkRoundChange, self)
		GlobalDispatcher:removeEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	end
end

function M:_handleViewAniDoneEvent(tagName, reason)
	if tagName == "close" then
		self._guiAnimation:StopTimelineAni()
		self._guiAnimationRightPanel:StopTimelineAni()
		self._guiAnimation:SetAniTime(0)
		self._guiAnimationRightPanel:SetAniTime(0)

		local handler = self:getHandler()

		if handler then
			handler:exitPage(self)
		end
	end
end

function M:_handleClimbingTowerDarkRoundChange(e)
	local darkRound = ClimbingTowerDarkModel.instance:getDarkRound()

	darkRound = darkRound or -1

	if darkRound ~= self._curDarkRound and self:isEnter() then
		FloatWordMgr.instance:show(lang("tip_dark_round_refresh"))
		self:_onClickReturn()
	end
end

function M:getPageTyp()
	return ClimbingTowerEnum.PageTyp.DarkSide
end

function M:onDarkSideExpire()
	if self:isEnter() then
		FloatWordMgr.instance:show(lang("tip_dark_not_work"))
		self:_onClickReturn()
	end
end

function M:checkExpire()
	local darkRoundCO = ClimbingTowerConfig.instance:getDarkRoundCO(self._curDarkRound)

	if darkRoundCO == nil then
		return true
	end

	return darkRoundCO:isExpired()
end

function M:_onClickReturn()
	self._guiAnimation:PauseAni()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:SetAniTime(0)
	self._guiAnimation:PlayAniByName("close")
	self._guiAnimationRightPanel:StopTimelineAni()
	self._guiAnimationRightPanel:PlayAniByName("close")
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickDugeonMoreReward()
	local dungeonId = self._lastTabDungeonId

	ViewMgr.instance:open(ViewName.DungeonRewardDetailView, dungeonId)
end

function M:_onClickDungeonFight()
	if self:checkExpire() then
		self:onDarkSideExpire()

		return
	end

	local dungeonId = self._lastTabDungeonId
	local dungeonMo = ClimbingTowerDarkModel.instance:getDungeonMoById(dungeonId)

	if dungeonMo:getIsLock() then
		if enableLog then
			printWarn("is lock", dungeonId)
		end

		return
	end

	BattleCalculateModel.instance:setDefaultItemMoList(dungeonMo:getPointCost())

	local info = {}

	info.dungeonCode = dungeonId
	info.afflatusBuff = false
	info.isShowPlot = true
	info.multiCount = 1
	info.gamePlay = BattleEnum.GamePlayType.NORMAL

	if enableLog then
		printWarn("startDungeonBattle", dungeonId)
	end

	self:_startFight(info)
end

function M:_startFight(info)
	local dungeonId = self._lastTabDungeonId
	local dungeonMo = ClimbingTowerModel.instance:getDungeonMoById(dungeonId)

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
	ClimbingTowerDarkModel.instance:setLastDungeonBattleInfo(self._darkRoundCO:getRound(), dungeonId)
	SceneFace.instance:exitScene()
	DungeonController.instance:startDungeonBattle(info)
end

function M:_handleClockTickHour(e)
	if self:checkExpire() then
		self:onDarkSideExpire()

		return
	end
end

function M:onEntryTabClick(tabCell)
	if tabCell:getIsLock() then
		FloatWordMgr.instance:show(lang("tip_finish_pre_level_unlock"))

		return
	end

	if self._lastTabTowerId and self._lastTabTowerId == tabCell:getTowerCfgId() then
		return
	end

	if self:getLastTabCell() then
		self:getLastTabCell():setSelected(false)
	end

	tabCell:setSelected(true)
	self:setLastTabCell(tabCell)

	local dungeonId = tabCell:getDungeonId()

	self:_refreshDungeonInfoPanel(dungeonId)
	goutil.setActive(self._goDungeonPanel, true)
	self._guiAnimationRightPanel:StopTimelineAni()
	self._guiAnimationRightPanel:PlayAniByName("open")
end

function M:getLastTabCell()
	return self._lastTabCell
end

function M:setLastTabCell(tab)
	self._lastTabCell = tab
	self._lastTabTowerId = tab and tab:getTowerCfgId() or nil
	self._lastTabDungeonId = tab and tab:getDungeonId() or nil
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = self._activeIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		self:onDescPageChange()
	end
end

function M:onDescPageChange()
	local page = self._activeIndex

	for key, go in pairs(self._pageGroup) do
		goutil.setActive(go, key == page)
	end
end

function M:refreshEntryTab()
	local dungeonIds = self._darkRoundCO:getDungeonIds()

	if #dungeonIds ~= #self._nodeEntry then
		printError(string.format("暗面轮数[%s],UI入口数量[%s]与实际关卡数[%s]不匹配", self._darkRoundCO:getRound(), #self._nodeEntry, #dungeonIds))
	end

	for i, tabCell in ipairs(self._nodeEntry) do
		local show = false
		local dungeonId = dungeonIds[i] or -1

		if dungeonId > 0 then
			local mo = ClimbingTowerDarkModel.instance:getDungeonMoById(dungeonId)

			if mo then
				show = true

				tabCell:setData(mo, i)
				tabCell:setHandler(self)
				tabCell:setSelected(false)
			end
		end

		tabCell:setActive(show)
	end
end

function M:_refreshDungeonInfoPanel(dungeonId)
	local dungeonMo = ClimbingTowerDarkModel.instance:getDungeonMoById(dungeonId)

	self._txtDungeonIndex.text = dungeonMo:getIndex()
	self._txtDungeonName.text = dungeonMo:getName()
	self._txtDungeonDesc.text = dungeonMo:getDesc()

	local scoreRate = DungeonModel.instance:getDungeonScoreRate(dungeonId, DungeonExtension_pb.BattleTeamType.TEAM_MAINLINE) * 1000
	local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, dungeonMo:getScoreGroup())

	DifficultyUtil.setDifficultyFlag(self._dungeonScoreRateGo, scoreCO)
	self:_refreshRewardPanel(dungeonMo)
	self:_refreshStarPanel(dungeonMo)
	self:_refreshBuff(dungeonMo)
	self._toggleTabControl:selectTab(1)
end

function M:_clearRewardLstPrefab()
	local childCount = self._goDungeonRewardLst.transform.childCount

	if childCount > 1 then
		for i = 1, childCount - 1 do
			goutil.destroy(self._goDungeonRewardLst.transform:GetChild(i).gameObject, true)
		end
	end
end

function M:_refreshRewardPanel(dungeonMo)
	self:_clearRewardLstPrefab()

	local count = 0
	local maxCount = 4
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
			local obj = goutil.cloneAndSetParent(self._goRewardItemPrefab, self._goDungeonRewardLst.transform)

			obj:SetActive(true)

			local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
			local rewardData = RewardData.New({
				code = _itemData:getItemId(),
				count = _itemData:getCount(),
				rewardStatus = dungeonMo:hasPassed() and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot,
				itemSign = CommEnum.BackPackItemSignTyp.First
			})

			objBeh:updateData(rewardData)

			count = count + 1

			if maxCount <= count then
				return
			end
		end
	end

	if maxCount <= count then
		return
	end

	_tmpTable = {}

	for i, code in ipairs(dungeonMo:getImportantPassReward()) do
		table.insert(_tmpTable, ItemUtil.createItemData({
			itemId = code
		}))
	end

	if #_tmpTable > 0 then
		table.sort(_tmpTable, ItemUtil.commonSortFunc)

		for _, _itemData in ipairs(_tmpTable) do
			local obj = goutil.cloneAndSetParent(self._goRewardItemPrefab, self._goDungeonRewardLst.transform)

			obj:SetActive(true)

			local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
			local rewardData = RewardData.New({
				code = _itemData:getItemId(),
				rewardStatus = CommEnum.RewardEnum.CanNotGot
			})

			objBeh:updateData(rewardData)

			count = count + 1

			if maxCount <= count then
				return
			end
		end
	end

	_tmpTable = {}

	if dungeonMo:hasPassed() and count == 0 then
		for i, reward in ipairs(dungeonMo:getAllFirstPassReward()) do
			table.insert(_tmpTable, ItemUtil.createItemData({
				itemId = reward.code,
				count = reward.num
			}))
		end

		if #_tmpTable > 0 then
			table.sort(_tmpTable, ItemUtil.commonSortFunc)

			for _, _itemData in ipairs(_tmpTable) do
				local obj = goutil.cloneAndSetParent(self._goRewardItemPrefab, self._goDungeonRewardLst.transform)

				obj:SetActive(true)

				local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
				local rewardData = RewardData.New({
					code = _itemData:getItemId(),
					count = _itemData:getCount(),
					rewardStatus = dungeonMo:hasPassed() and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot,
					itemSign = CommEnum.BackPackItemSignTyp.Get
				})

				objBeh:updateData(rewardData)

				count = count + 1

				if maxCount <= count then
					return
				end
			end
		end
	end
end

function M:_refreshStarPanel(dungeonMo)
	local star = dungeonMo:getStar()
	local starRequire = dungeonMo:getStarRequire() or {}

	if #starRequire > 0 then
		for i = 1, 3 do
			local show = i <= #starRequire

			if show then
				local dungeonStarCOWrapper = DungeonConfig.instance:getDungeonStarCOWrapper(starRequire[i])

				self._dungeonConditionItem[i].txtDesc.text = dungeonStarCOWrapper and dungeonStarCOWrapper:getDescription() or ""
				self._dungeonConditionItem[i].color = star[i] and Astral.ColorUtil.ParseColor("#FFFFFF") or Astral.ColorUtil.ParseColor("#747474")
			end

			goutil.setActive(self._dungeonConditionItem[i].root, show)
		end
	end

	goutil.setActive(self._goDungeonConditionRoot, #starRequire > 0)
end

function M:_refreshBuff(dungeonMo)
	local blueBuff = {}
	local redBuff = {}

	if dungeonMo then
		local towerCfgId = dungeonMo:getTowerCfgId()
		local darkCO = ClimbingTowerConfig.instance:getDarkTowerCO(towerCfgId)

		if darkCO then
			blueBuff = darkCO:getEffectDetailLstPros()
			redBuff = darkCO:getEffectDetailLstCons()
		end
	end

	while self._trBlueBuffRoot.childCount < #blueBuff do
		local templateGo = self._trBlueBuffRoot:GetChild(0).gameObject

		if templateGo then
			goutil.cloneAndSetParent(templateGo, self._trBlueBuffRoot)
		else
			printError("无法找到蓝色buff模板go")

			break
		end
	end

	for i = 0, self._trBlueBuffRoot.childCount - 1 do
		local tmpGo = self._trBlueBuffRoot:GetChild(i).gameObject
		local show = i < #blueBuff

		goutil.setActive(tmpGo, show)

		if show then
			local data = blueBuff[i + 1]
			local txtBuff = goutil.findChildComponent(tmpGo, "txtBlueBuff", UIComponentType.TextMeshProUGUI)

			txtBuff.text = data.desc
		end
	end

	while self._trRedBuffRoot.childCount < #redBuff do
		local templateGo = self._trRedBuffRoot:GetChild(0).gameObject

		if templateGo then
			goutil.cloneAndSetParent(templateGo, self._trRedBuffRoot)
		else
			printError("无法找到红色buff模板go")

			break
		end
	end

	for i = 0, self._trRedBuffRoot.childCount - 1 do
		local tmpGo = self._trRedBuffRoot:GetChild(i).gameObject
		local show = i < #redBuff

		goutil.setActive(tmpGo, show)

		if show then
			local data = redBuff[i + 1]
			local txtBuff = goutil.findChildComponent(tmpGo, "txtRedBuff", UIComponentType.TextMeshProUGUI)

			txtBuff.text = data.desc
		end
	end
end

function M:darkTimerControl(startTimer)
	if startTimer then
		self:_timerForDarkSide()
		removetimer(self._timerForDarkSide, self)
		settimer(1, self._timerForDarkSide, self, true)
	else
		removetimer(self._timerForDarkSide, self)
	end
end

function M:_timerForDarkSide()
	local remainedTime = self._darkSideRemainedTime

	remainedTime = remainedTime - 1
	remainedTime = remainedTime < 0 and 0 or remainedTime
	self._darkSideRemainedTime = remainedTime

	self:_updateRemainedTime(self._darkSideRemainedTime)
end

function M:_updateRemainedTime(remainedTimeStamp)
	local day, hour, min, sec = 0, 0, 0, 0

	day = math.floor(remainedTimeStamp / 86400)

	if day > 0 then
		self._txtDarkSideTime.text = string.format(lang("tip_left_xx_day"), day)
	else
		local timeStr

		day, hour, min, sec = self:formatRemainedTime(remainedTimeStamp)

		if remainedTimeStamp < 3600 then
			timeStr = string.format("<color=#ff3e48>%02d:%02d:%02d</color>", hour, min, sec)
		else
			timeStr = string.format("%02d:%02d:%02d", hour, min, sec)
		end

		self._txtDarkSideTime.text = string.format("%s %s", lang("tip_left_time"), timeStr)
	end
end

function M:formatRemainedTime(leftTime)
	local day = math.floor(leftTime / 86400)
	local hour = math.floor((leftTime - day * 86400) / 3600)
	local minute = math.floor((leftTime - day * 86400 - hour * 3600) / 60)
	local second = leftTime - day * 86400 - hour * 3600 - minute * 60

	return day, hour, minute, second
end

return M
