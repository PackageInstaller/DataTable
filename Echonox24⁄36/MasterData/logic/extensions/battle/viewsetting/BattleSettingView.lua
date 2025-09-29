-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/BattleSettingView.lua

module("logic.extensions.battle.viewsetting.BattleSettingView", package.seeall)

local M = class("BattleSettingView", ViewComponent)

M.SubViewType = {
	GiveUp = 5,
	Task = 2,
	Battle = 3,
	System = 4,
	Report = 1
}

function M:buildUI()
	self._blurGo = self:getGoByPath("common_blur_rt")
	self._btnClose = self:getBtnByPath("title_view/layout/btnReturn_1")

	local adapter = StaticPagerAdapter.New()

	self._viewPager = ViewPager.New(self:getGoByPath("allContent/panel"))

	self._viewPager:setAdapter(adapter)
	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setPageChangeCallBack(self._onSetPageTriggered)
	adapter:addFragmentView(BattleSettingReportFragmentView.New(self:getGoByPath("allContent/panel/content")))
	adapter:addFragmentView(BattleSettingTaskFragmentView.New(self:getGoByPath("allContent/panel/test_task_panel")))
	adapter:addFragmentView(BattleSettingBattleFragmentView.New(self:getGoByPath("allContent/panel/battle_panel")))
	adapter:addFragmentView(BattleSettingSystemFragmentView.New(self:getGoByPath("allContent/panel/system_test_panel")))
	adapter:addFragmentView(BattleSettingGiveUpFragmentView.New(self:getGoByPath("allContent/panel/giveup_panel")))

	self._toggleControl = ToggleTabControl.New()

	self._toggleControl:setViewPager(self._viewPager)
	self._toggleControl:setTabCheckFunc(self._tabCheckFunc)

	self._goTestTask = goutil.findChild(self.mainGO, "allContent/left_tab_content/rightTabList/tab_2")
	self._titleTxt = self:getTextByPath("title_view/layout/btnReturn_1/txtTitle")
	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("8&left_tab_content_-399612422"), LeftTabComp)

	for i = 1, 4 do
		self._toggleControl:addToggleTab(self._tabComp:getToggleTab(i))
	end

	self._toggleControl:addToggleTab(self:getGoByPath("allContent/btnGiveUp"):GetComponent(UIComponentType.SpaceXToggle))
end

function M._tabCheckFunc(tabIndex)
	local canTab = true

	if tabIndex == M.SubViewType.Task then
		canTab = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightTask)
	end

	return canTab
end

function M:destroyUI()
	self._viewPager:destroy()
	self._toggleControl:destroy()

	self._viewPager = nil
	self._toggleControl = nil
	self._btnClose = nil
	self._goTestTask = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	goutil.setWidth(self._blurGo.transform, ViewMgr.instance:getUIWidth())
	self:setEvent(true)
	BattleMgr.instance:internalPause(true)
	self:_refreshToggleByDungeonTyp()
	self:_init()
	self._toggleControl:selectTab(1)
	self._tabComp:setCanvasGroupShow(true)
	self._tabComp:onEnter()
	self._tabComp:playGuiAniTab(true, not self._viewPresentor:getIsBackOpen(), 1)
end

function M:onExit(reasonType)
	self:setEvent(false)

	local isNormalClose = reasonType ~= WindowType.WindowCloseReasonType.QuickCloseType

	self._tabComp:onExit()
	self._tabComp:setCanvasInteractable(false)
	self._tabComp:playGuiAniTab(false, isNormalClose)
	BattleMgr.instance:internalPause(false)
	self._viewPager:clear()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.BATTLE_SETTING_PAGE_CHANGE, self._onSetPage, self)
	else
		GlobalDispatcher:removeEventListener(EventType.BATTLE_SETTING_PAGE_CHANGE, self._onSetPage, self)
	end
end

function M:_onClickClose()
	self:close()
end

function M:_init()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local name = "设置"
	local defaultTab = self.SubViewType.Report
	local flow = BattleMgr.instance:getActiveBattleFlow()

	if dungeonCode then
		name = self:_getLastDungeonName()
	end

	if OOPUtil.isInstanceOf(flow, AirLevelBattleFlow) then
		name = flow:getLevelName()
	end

	self._toggleControl:selectTab(defaultTab)

	self._titleTxt.text = name
end

function M:_getLastDungeonName()
	local name = lang("tip_setting")
	local recordCfg = Astral.LocalStorage.Instance:GetString("dungeon_latest_type")
	local id = Astral.LocalStorage.Instance:GetString("dungeon_latest_id")

	if id ~= PlayerModel.instance:getId() or string.nilorempty(recordCfg) then
		return name
	end

	recordCfg = string.split(recordCfg, ",")

	local recordId = tonumber(recordCfg[2])
	local recordIndex = recordCfg[3]

	if tonumber(recordCfg[1]) == 1 then
		local dungeonCfg = DungeonConfig.instance:getCfgMainLineChapterIncludePlot(recordId)

		if not dungeonCfg then
			return name
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

		name = dungeonName
	end

	return name
end

function M:_refreshToggleByDungeonTyp()
	SystemOpenFacade.instance:judgeUIState(GameEnum.SystemEnum.FightTask, self._goTestTask)

	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if not dungeonCode then
		return
	end
end

function M._onSetPageTriggered(tabIndex)
	GlobalDispatcher:dispatchEvent(EventType.BATTLE_SETTING_PAGE_CHANGE, tabIndex)
end

function M:_onSetPage(_, tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	local duration = needReflash and 0.3 or 0

	if tabIndex == M.SubViewType.GiveUp then
		self._lastTypeIsGiveUp = true

		self._tabComp:playHideAllTabAni()
	else
		if self._lastTypeIsGiveUp then
			self._tabComp:playShowTabAni(tabIndex)
		else
			self._tabComp:MoveSelectMark(tabIndex, duration)
		end

		self._lastTypeIsGiveUp = false
	end
end

function M:_onClickGiveUp(isSelect)
	if isSelect then
		-- block empty
	end
end

return M
