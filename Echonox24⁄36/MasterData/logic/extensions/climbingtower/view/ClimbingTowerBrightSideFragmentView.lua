-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/view/ClimbingTowerBrightSideFragmentView.lua

module("logic.extensions.climbingtower.view.ClimbingTowerBrightSideFragmentView", package.seeall)

local M = class("ClimbingTowerBrightSideFragmentView", ClimbingTowerBasePage)

function M:buildUI()
	M.super.buildUI(self)

	local registry = self:getRegistry()

	self._btnReturn = UIComponentType.ButtonAdapter(registry:findUIElement("title_view_-878360263"))
	self._btnHome = UIComponentType.ButtonAdapter(registry:findUIElement("title_view_1398742689"))

	goutil.setActive(self._btnHome.gameObject, true)

	self._loopListTabEntry = LoopListHelper.New(registry:findUIElement("climbing_tower_tooling_face_panel_1867189586"))

	self._loopListTabEntry:InitListView(0, self._onTabCellUpdate, self)

	local redFogRootBright = registry:findUIElement("climbing_tower_tooling_face_panel_-2096161694", UIComponentType.RectTransform)

	self._redFogBright = {}

	for i = 0, redFogRootBright.childCount - 1 do
		local tmpTr = redFogRootBright:GetChild(i)

		table.insert(self._redFogBright, tmpTr.gameObject)
	end

	self._goDungeonPanel = registry:findUIElement("climbing_tower_tooling_face_panel_1694249436")
	self._guiAnimationRightPanel = goutil.addComponentOnce(self._goDungeonPanel, typeof(Astral.GUITimelineAniLua))
	self._txtDungeonIndex = registry:findUIElement("climbing_tower_tooling_face_panel_-1707505512", UIComponentType.Text)
	self._txtDungeonName = registry:findUIElement("climbing_tower_tooling_face_panel_-2059599759", UIComponentType.Text)
	self._txtDungeonDesc = registry:findUIElement("climbing_tower_tooling_face_panel_350764963", UIComponentType.Text)
	self._dungeonScoreRateGo = registry:findUIElement("2&instance_danger_-1654566369")
	self._goDungeonConditionRoot = registry:findUIElement("climbing_tower_tooling_face_panel_172012355")
	self._dungeonConditionItem = {
		{
			root = registry:findUIElement("climbing_tower_tooling_face_panel_67779130"),
			txtDesc = registry:findUIElement("climbing_tower_tooling_face_panel_1014438165", UIComponentType.Text)
		},
		{
			root = registry:findUIElement("climbing_tower_tooling_face_panel_2134186712"),
			txtDesc = registry:findUIElement("climbing_tower_tooling_face_panel_-2051949473", UIComponentType.Text)
		},
		{
			root = registry:findUIElement("climbing_tower_tooling_face_panel_313444052"),
			txtDesc = registry:findUIElement("climbing_tower_tooling_face_panel_-322236308", UIComponentType.Text)
		}
	}
	self._goDungeonRewardLst = registry:findUIElement("climbing_tower_tooling_face_panel_138133091")
	self._goRewardItemPrefab = registry:findUIElement("0&rewards_detail_item_2141037416")

	goutil.setActive(self._goRewardItemPrefab, false)

	self._btnDugeonMoreReward = UIComponentType.ButtonAdapter(registry:findUIElement("climbing_tower_tooling_face_panel_355509093"))
	self._btnDungeonFight = UIComponentType.ButtonAdapter(registry:findUIElement("climbing_tower_tooling_face_panel_1602043697"))
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._btnReturn = nil

	self._loopListTabEntry:Dispose()

	self._loopListTabEntry = nil
	self._goDungeonPanel = nil
	self._txtDungeonIndex = nil
	self._txtDungeonName = nil
	self._txtDungeonDesc = nil
	self._goDungeonConditionRoot = nil
	self._dungeonConditionItem = nil
	self._goDungeonRewardLst = nil
	self._goRewardItemPrefab = nil
	self._btnDugeonMoreReward = nil
	self._btnDungeonFight = nil
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnDugeonMoreReward:AddClickListener(self._onClickDugeonMoreReward, self)
	self._btnDungeonFight:AddClickListener(self._onClickDungeonFight, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnDugeonMoreReward:RemoveClickListener()
	self._btnDungeonFight:RemoveClickListener()
end

function M:onEnter()
	M.super.onEnter(self)

	self._cellTab = {}
	self._towerId2Cell = {}

	self._guiAnimationRightPanel:StopTimelineAni()
	self:_setDefaultSelectTab(1)

	local clearCount = ClimbingTowerModel.instance:getClearDungeonCount()
	local maxStorey = ClimbingTowerConfig.instance:getBrightSideMaxStorey()

	if maxStorey <= clearCount then
		self:_setDefaultSelectTab(maxStorey)
	else
		self:_setDefaultSelectTab(clearCount > 0 and clearCount + 1 or 1)
	end

	self:refreshEntryTab()
	self:updateRedFogBright(clearCount / maxStorey)
	self:_setEvent(true)
	settimer(0.05, self.setDefaultTabFunc, self, false)
end

function M:onExit()
	removetimer(self.setDefaultTabFunc, self)
	self._guiAnimationRightPanel:StopTimelineAni()
	M.super.onExit(self)

	self._towerId2Cell = nil

	self:_setEvent(false)
	self:setLastTabCell(nil)
	self._loopListTabEntry:ClearCells()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKHOUR, self._handleClockTickHour, self)
		GlobalDispatcher:addEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	else
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKHOUR, self._handleClockTickHour, self)
		GlobalDispatcher:removeEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	end
end

function M:_setDefaultSelectTab(val)
	self._defaultSelectTab = val
end

function M:getDefaultSelectTab()
	return self._defaultSelectTab or 1
end

function M:setDefaultTabFunc()
	self._loopListTabEntry:MoveToItemIndex(self:getDefaultSelectTab() - 1, 0)
	self:_setDefaultSelectTab(nil)
end

function M:getPageTyp()
	return ClimbingTowerEnum.PageTyp.BrightSide
end

function M:_onClickReturn()
	self._guiAnimationRightPanel:StopTimelineAni()
	self._guiAnimationRightPanel:PlayAniByName("close")

	for key, value in pairs(self._cellTab or {}) do
		value:playAnim(false)
	end

	DoTweenUtil.DelayedCall(0.3, function()
		local handler = self:getHandler()

		if handler then
			handler:exitPage(self)
		end
	end)
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickDugeonMoreReward()
	local dungeonId = self._lastTabDungeonId

	ViewMgr.instance:open(ViewName.DungeonRewardDetailView, dungeonId)
end

function M:_onClickDungeonFight()
	local dungeonId = self._lastTabDungeonId
	local dungeonMo = ClimbingTowerModel.instance:getDungeonMoById(dungeonId)

	if dungeonMo:getIsLock() then
		if enableLog then
			printWarn("is lock", dungeonId)
		end

		FloatWordMgr.instance:show(lang("tip_teaching_lock"))

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
	SceneFace.instance:exitScene()
	DungeonController.instance:startDungeonBattle(info)
end

function M:_handleClockTickHour(e)
	return
end

function M:onEntryTabClick(tabCell)
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
	return self._towerId2Cell[self._lastTabTowerId]
end

function M:setLastTabCell(tab)
	self._lastTabTowerId = tab and tab:getTowerCfgId() or nil
	self._lastTabDungeonId = tab and tab:getDungeonId() or nil
end

function M:refreshEntryTab()
	self._dungeonMoLst = {}

	local cfgBrightSideLst = ClimbingTowerConfig.instance:getConfigList(ConfigName.LightMoonTower)
	local len = cfgBrightSideLst and #cfgBrightSideLst or 0

	if len > 0 then
		for _, cfg in ipairs(cfgBrightSideLst) do
			local storeyId = cfg.id
			local dungeonId = cfg.dungeon
			local mo = ClimbingTowerModel.instance:getDungeonMoById(dungeonId)

			if mo then
				table.insert(self._dungeonMoLst, mo)
			else
				len = len - 1

				printError(string.format("无法找到[%s][%s]的明面塔数据", storeyId, dungeonId))
			end
		end
	end

	self._loopListTabEntry:SetListItemCount(len, true)
	self._loopListTabEntry:RefreshAllShownItem()
end

function M:_onTabCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._dungeonMoLst[curIndex]
	local item = self._loopListTabEntry:NewListViewItem("climbing_tower_tab")
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, ClimbingTowerSideTabCell)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, ClimbingTowerSideTabCell)
	end

	shower:setData(data, curIndex, curIndex == #self._dungeonMoLst)
	shower:setHandler(self)

	local defaultTab = self._defaultSelectTab

	if defaultTab and curIndex == defaultTab then
		self:onEntryTabClick(shower)
	end

	local showSelect = self._lastTabTowerId and self._lastTabTowerId == data:getTowerCfgId()

	shower:setSelected(showSelect)

	self._cellTab[item.gameObject:GetInstanceID()] = shower
	self._towerId2Cell[data:getTowerCfgId()] = shower

	if defaultTab and defaultTab <= curIndex and curIndex <= defaultTab + 4 then
		shower:setAlpha(0)
		shower:playAnim(true, (curIndex - defaultTab + 1) * 0.1)
	else
		shower:setAlpha(1)
		shower:playAnim(true)
	end

	return item
end

function M:updateRedFogBright(percentFloat)
	local count = #self._redFogBright
	local step = ClimbingTowerEnum.ClearStepBright
	local hideCount = 0

	if percentFloat <= 0 then
		-- block empty
	elseif percentFloat >= 1 then
		hideCount = count
	else
		local stepCount = math.floor(count / step)
		local reachStep = math.floor(math.floor(percentFloat * 100) / math.floor(1 / step * 100))

		hideCount = reachStep * stepCount
	end

	for index, obj in ipairs(self._redFogBright) do
		local hide = index <= hideCount

		goutil.setActive(obj, not hide)
	end
end

function M:_refreshDungeonInfoPanel(dungeonId)
	local dungeonMo = ClimbingTowerModel.instance:getDungeonMoById(dungeonId)

	self._txtDungeonIndex.text = dungeonMo:getIndex()
	self._txtDungeonName.text = dungeonMo:getName()
	self._txtDungeonDesc.text = dungeonMo:getDesc()

	local scoreRate = DungeonModel.instance:getDungeonScoreRate(dungeonId, DungeonExtension_pb.BattleTeamType.TEAM_MAINLINE) * 1000
	local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, dungeonMo:getScoreGroup())

	DifficultyUtil.setDifficultyFlag(self._dungeonScoreRateGo, scoreCO)
	self:_refreshRewardPanel(dungeonMo)
	self:_refreshStarPanel(dungeonMo)
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

return M
