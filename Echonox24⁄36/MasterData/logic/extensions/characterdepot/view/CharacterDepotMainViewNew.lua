-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/view/CharacterDepotMainViewNew.lua

module("logic.extensions.characterdepot.view.CharacterDepotMainViewNew", package.seeall)

local M = class("CharacterDepotMainViewNew", ViewComponent)

M.CareerFilter = {
	[0] = CommEnum.Career2Name[0],
	CommEnum.Career2Name[GameEnum.CareerEnum.Sentinel],
	CommEnum.Career2Name[GameEnum.CareerEnum.Assault],
	CommEnum.Career2Name[GameEnum.CareerEnum.Sniper],
	CommEnum.Career2Name[GameEnum.CareerEnum.Super],
	CommEnum.Career2Name[GameEnum.CareerEnum.Heavy],
	CommEnum.Career2Name[GameEnum.CareerEnum.Cure]
}
M.FilterTyp = {
	CommEnum.HeroSortFieldType.Level,
	CommEnum.HeroSortFieldType.Breakthrough,
	CommEnum.HeroSortFieldType.Authority,
	CommEnum.HeroSortFieldType.MaxHp,
	CommEnum.HeroSortFieldType.Atk,
	CommEnum.HeroSortFieldType.Def,
	CommEnum.HeroSortFieldType.MagicAtk,
	CommEnum.HeroSortFieldType.MagicDef,
	CommEnum.HeroSortFieldType.Quality
}
M.TipsTyp = {
	AdjutantSuc = 1,
	AdjutantAlready = 2
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO.gameObject, ComponentType.CanvasGroup)
	self._showHeroData = HeroDepotModel.instance:getHeroDepotData():getShowDataList()
	self._scroll = self:getUIComponent("character_depot_main_view_copy_-2140476321", UIComponentType.ScrollRect)
	self._loopGridView = LoopGridViewHelper.New(self._scroll.gameObject)

	self._loopGridView:InitGridView(0, self._onCellUpdate, self)

	self._btnSetAdjutant = self:getBtn("character_depot_main_view_copy_-1138422837")
	self._goAlreadyAdjutant = self:getGo("character_depot_main_view_copy_-1123589200")
	self._btnThinking = self:getBtn("character_depot_main_view_copy_472310620")
	self._btnPreview = self:getBtn("character_depot_main_view_copy_-898770537")
	self._btnToAirtightTime = self:getBtnByPath("rightTop/preview_btn_group/btnPreviewHA")
	self._btnToNormalTime = self:getBtnByPath("rightTop/preview_btn_group/btnPreviewQuit")
	self._canvasInAirtightPreview = goutil.findChildComponent(self.mainGO, "preview_heartanchor_hint", ComponentType.CanvasGroup)
	self._canvasInAirtightPreview.alpha = 0

	goutil.setActive(self._canvasInAirtightPreview.gameObject, true)

	self._rectTrContractRoot = self:getUIComponent("character_depot_main_view_copy_-927370376", UIComponentType.RectTransform)
	self._txtTacit = self:getText("character_depot_main_view_copy_-1876678214")
	self._txtName2 = self:getText("character_depot_main_view_copy_-1490159411")
	self._btnDetail = self:getBtn("character_depot_main_view_copy_-1341101868")
	self._btnEquip = self:getBtn("character_depot_main_view_copy_-182762842")
	self._goEquipMarkList = {
		self:getGo("character_depot_main_view_copy_-373260297"),
		self:getGo("character_depot_main_view_copy_1193608913"),
		self:getGo("character_depot_main_view_copy_-1511780833")
	}
	self._btnEcho = self:getBtn("character_depot_main_view_copy_373754052")
	self._goEchoNone = self:getGo("character_depot_main_view_copy_85012110")
	self._goEchoEquip = self:getGo("character_depot_main_view_copy_937774653")
	self._txtRolePowerNum = self:getUIComponent("character_depot_main_view_copy_-1792449784", UIComponentType.Text)
	self._rectTrSignGroup = self:getUIComponent("character_depot_main_view_copy_1077164266", UIComponentType.RectTransform)
	self._goRedDotAnchorBreak = goutil.findChild(self.mainGO, "rightBottom/contract/btnBreak/red_point")
	self._btnContract = self:getBtn("character_depot_main_view_copy_-1201182683")

	local anchorBreakRoot = self:getGo("character_depot_main_view_copy_-844850059")

	self._anchorList = {}

	for i = 0, anchorBreakRoot.transform.childCount - 1 do
		self._anchorList[i + 1] = anchorBreakRoot.transform:GetChild(i).gameObject
	end

	self._goRedDotTacit = goutil.findChild(self.mainGO, "rightBottom/tacit/red_point")
	self._btnTacit = self:getBtn("character_depot_main_view_copy_76378929")
	self._txtTacit = self:getText("character_depot_main_view_copy_-1876678214")
	self._goTacitLock = self:getGo("character_depot_main_view_copy_-505694692")
	self._btnFilterMulti = self:getBtn("character_depot_main_view_copy_-1872514888")
	self._txtFilterMulti = goutil.findChildComponent(self._btnFilterMulti.gameObject, "Label", UIComponentType.Text)
	self._goEmptyLst = self:getGo("empty_unit_-1401348703")

	goutil.setActive(self:getGo("empty_unit_-1492724947"), false)

	self._btnFilter = self:getBtn("character_depot_main_view_copy_2004289771")
	self._txtBtnFilter = self:getText("character_depot_main_view_copy_1974095076")
	self._goUpBtnFilter = self:getGo("character_depot_main_view_copy_-2105082365")
	self._goDownBtnFilter = self:getGo("character_depot_main_view_copy_1761071671")
	self._goFilterPanel = self:getGo("character_depot_main_view_copy_-34623664")
	self._filterCell = {}

	local _content = goutil.findChildComponent(self._goFilterPanel, "Content", UIComponentType.RectTransform)

	while _content.childCount < #M.FilterTyp do
		goutil.cloneAndSetParent(_content:GetChild(0).gameObject, _content)
	end

	for i = 0, _content.childCount - 1 do
		local go = _content:GetChild(i).gameObject
		local show = i < #M.FilterTyp

		if show then
			local typ = M.FilterTyp[i + 1]

			self._filterCell[typ] = self:_buildFilterCell(go, typ)
		end

		goutil.setActive(go, show)
	end

	self._btnFilterMask = self:getBtn("character_depot_main_view_copy_348263280")
	self._goTipsModelOptimizing = goutil.findChild(self.mainGO, "hint").gameObject

	goutil.setActive(self._goTipsModelOptimizing, false)
	self:_regLockStats(GameEnum.SystemEnum.Thought, self._btnThinking.gameObject, nil, nil)
	self:_regLockStats(GameEnum.SystemEnum.RoleModelPreview, self._btnPreview.gameObject, nil, nil)
	self:_regLockStats(GameEnum.SystemEnum.RoleBreak, self._btnContract.gameObject, nil, nil)
	self:_regLockStats(GameEnum.SystemEnum.Tacit, self._goTacitLock, nil, nil)

	self.isThisViewOpen = nil
end

function M:destroyUI()
	self._lockStatsGroup = nil

	for _, value in pairs(self._itemData or {}) do
		value:destroyUI()
	end

	for _, cell in pairs(self._filterCell or {}) do
		cell.btnClick:RemoveClickListener()
	end

	self._itemData = nil
	self._showHeroData = nil

	self._loopGridView:Dispose()

	self._loopGridView = nil
end

function M:bindEvents()
	self._btnToAirtightTime:AddClickListener(self._onClickToAirtightTime, self)
	self._btnToNormalTime:AddClickListener(self._onClickToNormalTime, self)
	self._btnDetail:AddClickListener(self._onClickDetail, self)
	self._btnSetAdjutant:AddClickListener(self._onClickSetAdjutant, self)
	self._btnThinking:AddClickListener(self._onClickThinking, self)
	self._btnFilterMulti:AddClickListener(self._onClickMultiFilter, self)
	self._btnFilter:AddClickListener(self._onClickFilter, self)
	self._btnFilterMask:AddClickListener(self._onClickFilterMask, self)
	self._btnPreview:AddClickListener(self._onClickPreview, self)
	self._btnContract:AddClickListener(self._onClickContract, self)
	self._btnTacit:AddClickListener(self._onClickTacit, self)
	self._btnEquip:AddClickListener(self._onClickEquip, self)
	self._btnEcho:AddClickListener(self._onClickEcho, self)
end

function M:unbindEvents()
	self._btnToAirtightTime:RemoveClickListener()
	self._btnToNormalTime:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._btnSetAdjutant:RemoveClickListener()
	self._btnThinking:RemoveClickListener()
	self._btnFilterMulti:RemoveClickListener()
	self._btnFilter:RemoveClickListener()
	self._btnFilterMask:RemoveClickListener()
	self._btnPreview:RemoveClickListener()
	self._btnContract:RemoveClickListener()
	self._btnTacit:RemoveClickListener()
	self._btnEquip:RemoveClickListener()
	self._btnEcho:RemoveClickListener()
end

function M:onEnter(reasonTyp)
	self._canvasGroup.interactable = true
	self.isThisViewOpen = true

	MainScenePerformUtil.setBgHeroShow(false, true)
	MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdAirtightClock, false)
	MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdTelevision, false)
	self:setEvent(true)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterDepot)
	goutil.setActive(self._btnFilterMask.gameObject, false)
	self:_initSortInfo()
	self:_initHeroData()

	local heroId = self:_initHeroSelect()

	self:_refreshAirtightBtnStatus()
	self:_handleOnSystemOpen()
end

function M:onExit(reasonTyp)
	self._canvasGroup.interactable = false
	self.isThisViewOpen = false

	self:setEvent(false)
	self:_playItemOpenAni(false)
	removetimer(self.updateSelect, self)
	goutil.setActive(self._btnFilterMask.gameObject, false)
	goutil.setActive(self._goFilterPanel, false)

	local displayHero, _ = MainScenePerformUtil.getDisplayAdjutantHeroId()
	local heroId = self._selectHeroId and self._selectHeroId or displayHero
	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	if isNormalClose then
		self._selectHeroId = nil

		HeroDepotModel.instance:clearViewPageMo()
		AirtightRoomController.instance:setPreviewState(nil)
	end

	self._defaultSort = nil

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterDepot)
	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), 1, false, isNormalClose, heroId)
	goutil.setActive(self._goTipsModelOptimizing, false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
		GlobalDispatcher:addEventListener(EventType.FILTER_HERO_DEPOT_DATA, self._handleFilterHeroDepotData, self)
		GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_DISPLAYHERO_SUC, self._handleChangePlayerDisplayHeroSuc, self)
		GlobalDispatcher:addEventListener(EventType.SCENE_FLOW_ENTER_FINISH, self._handleSceneFlowEnterFinish, self)
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_REDPOINT, self._refreshRedDot, self)
		GlobalDispatcher:addEventListener(EventType.TACIT_TASK_INIT_EVENT, self._refreshBreakAndTacitRedDot, self)
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
		GlobalDispatcher:removeEventListener(EventType.FILTER_HERO_DEPOT_DATA, self._handleFilterHeroDepotData, self)
		GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_DISPLAYHERO_SUC, self._handleChangePlayerDisplayHeroSuc, self)
		GlobalDispatcher:removeEventListener(EventType.SCENE_FLOW_ENTER_FINISH, self._handleSceneFlowEnterFinish, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_REDPOINT, self._refreshRedDot, self)
		GlobalDispatcher:removeEventListener(EventType.TACIT_TASK_INIT_EVENT, self._refreshBreakAndTacitRedDot, self)
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
	end
end

function M:_sortTyp2Name(sortType)
	sortType = sortType or 0

	return lang(CommEnum.SortType2LangKey[sortType])
end

function M:_handleRefreshHeroDepotData()
	self:refreshScrollView(false, false)
	self:_refreshBreakAndTacitRedDot()
	self:_updateFightingCapacity()
end

function M:_handleFilterHeroDepotData(e, datalist)
	self._record = CharacterUtil.getFilterViewOpt(CommEnum.HeroFilter.HeroDepot)

	goutil.setActive(self._goUpBtnFilter, self._record.isUpSort)
	goutil.setActive(self._goDownBtnFilter, not self._record.isUpSort)
	HeroDepotModel.instance:setShowDataListSort(datalist)
	self._showHeroData:setMoList(datalist)

	local selectIndex = 1

	for _index, characterData in ipairs(self._showHeroData:getMoList()) do
		if characterData:getId() == self._selectHeroId then
			selectIndex = _index
		end
	end

	local pageMo = HeroDepotModel.instance:getViewPageMo()

	pageMo.index = selectIndex

	HeroDepotModel.instance:setViewPageMo(pageMo)
	self:refreshScrollView(true, true, true)
	self:_updateFilterBtnText()
end

function M:_handleChangePlayerDisplayHeroSuc(e)
	self:updateAdjutantBtnStatus()
	ToolTipsMgr.showCharacterTopToast(lang("tip_set_adjutant_success"), CommEnum.CharacterTopToastIcon.Succ, 1)
end

function M:_handleSceneFlowEnterFinish(e, info)
	if info.sceneType == SceneType.Room then
		MainScenePerformUtil.setBgHeroShow(false, true)
		MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdAirtightClock, false)
		MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdTelevision, false)
		MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), 1, true, not self._viewPresentor:getIsBackOpen(), self._selectHeroId)
	end
end

function M:_handleOnSystemOpen()
	for key, objs in pairs(self._lockStatsGroup or {}) do
		local showOnLock = SystemOpenFacade.instance:isShowOnLock(key)
		local isOpen = SystemOpenFacade.instance:isOpen(key)

		goutil.setActive(objs.root, isOpen or showOnLock and not isOpen)

		if objs.lock then
			goutil.setActive(objs.lock, not isOpen)
		end

		if objs.normal then
			goutil.setActive(objs.normal, isOpen)
		end
	end

	self:_updateBtnEquip()
	self:_updateBtnEcho()
end

function M:_handleAritightStateChange(e, isInAirtightTime, airtightEndTS)
	self:_refreshAirtightBtnStatus()
end

function M:_refreshRedDot()
	self:_refreshCellRedDot()
	self:_refreshBreakAndTacitRedDot()
end

function M:_refreshCellRedDot()
	for _, theItem in pairs(self._itemData or {}) do
		theItem.refreshRedDot()
	end
end

function M:_refreshBreakAndTacitRedDot()
	local heroId = self:getCurHeroData():getId()
	local impressionSysOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Tacit, false)
	local hasImpressionTask = false

	if self:_isVaildToImpressionTask() then
		for i = 1, 3 do
			if hasImpressionTask == false and TacitModel.instance:checkHasRedDot(i) then
				hasImpressionTask = true
			end
		end
	end

	hasImpressionTask = hasImpressionTask or CharacterUtil.isHeroHasTacitTaskCanReceive(heroId, true)

	local isCarryItem1New = CharacterInformationController.instance:isCarryItem1New(heroId)
	local isHasNewCarry = CharacterInformationModel.instance:getIsNewCarryItem(heroId)
	local canSublimed = CharacterUtil.isHeroCanSublimed(heroId)

	goutil.setActive(self._goRedDotTacit, impressionSysOpen and (hasImpressionTask or isCarryItem1New or isHasNewCarry or canSublimed))

	local checkSysOpen = true
	local canBrealLvUp = CharacterUtil.isHeroCanBrealLvUp(heroId, checkSysOpen)

	goutil.setActive(self._goRedDotAnchorBreak, canBrealLvUp)
end

function M:_isVaildToImpressionTask()
	local heroData = self:getCurHeroData()
	local isVaild = true
	local cfg = TacitConfig.instance:getTacitCO(heroData:getId())

	if not cfg then
		isVaild = false
	elseif cfg.isOnLine <= 0 then
		isVaild = false
	end

	return isVaild
end

function M:_onClickThinking()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Thought, true) then
		return
	end

	ViewMgr.instance:open(ViewName.ThinkingMainView)
end

function M:_onClickSetAdjutant()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroId = viewPageMo and viewPageMo.hero:getId() or -1

	PlayerAgent.instance:sendChangeDisplayHeroRequest(heroId)
end

function M:_onClickFilterMask()
	goutil.setActive(self._btnFilterMask.gameObject, false)
	goutil.setActive(self._goFilterPanel, false)
end

function M:_onClickMultiFilter()
	local _tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()

	ViewMgr.instance:open(ViewName.HeroFilterTipsView, {
		moduleType = CommEnum.HeroFilter.HeroDepot,
		data = _tmpHeroList:getMoList(),
		confirmEvent = EventType.FILTER_HERO_DEPOT_DATA
	})
end

function M:_onClickFilter()
	local show = not self._goFilterPanel.activeSelf

	goutil.setActive(self._btnFilterMask.gameObject, show)
	goutil.setActive(self._goFilterPanel, show)
end

function M:_onClickDetail()
	self:setEvent(false)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_xiangqing, nil, nil, nil)
	CharacterSystemFacade.instance:showCharacterSystem(CommEnum.CharacterSystemTab.Detail, nil, true)
end

function M:_onClickPreview()
	local heroData = self:getCurHeroData()

	if not heroData then
		return
	end

	ViewMgr.instance:close(ViewName.CharacterMainSystemViewNew, false, WindowType.WindowCloseReasonType.NormalCloseType, true)
	ViewMgr.instance:open(ViewName.CharacterSkinView, {
		openByMainSystem = true,
		heroId = heroData:getId(),
		skinId = heroData:getSkinId(),
		showType = HeroSkinEnum.ShowType.ModelPreview
	})
end

function M:_onClickToAirtightTime()
	AirtightRoomController.instance:setPreviewState(true)
	self:_refreshAirtightBtnStatus(0.3)
end

function M:_onClickToNormalTime()
	AirtightRoomController.instance:setPreviewState(nil)
	self:_refreshAirtightBtnStatus(0.3)
end

function M:_refreshAirtightBtnStatus(duration)
	duration = duration or 0

	local previewState = AirtightRoomModel.instance:getPreviewState()
	local inTime = AirtightRoomController.instance:getIsInAirtightTime(nil, nil, nil, false)

	goutil.setActive(self._btnToAirtightTime.gameObject, not inTime)
	goutil.setActive(self._btnToNormalTime.gameObject, inTime and previewState == true)
	MainScenePerformUtil.showCanvas(self._canvasInAirtightPreview, inTime and previewState == true, duration)
end

function M:_initSortInfo()
	self._record = CharacterUtil.getFilterViewOpt(CommEnum.HeroFilter.HeroDepot)

	local rule = HeroSortRuleConfig.instance:getHeroDepotRule()

	if not self._record then
		self._isUpSort = false
		self._sortType = CommEnum.HeroSortFieldType.Level

		local var_array = rule[self._sortType]

		self._defaultSort = var_array[1]

		CharacterUtil.saveFilterViewOpt(CommEnum.HeroFilter.HeroDepot, {
			sortType = self._defaultSort,
			isUpSort = self._isUpSort,
			camp = {
				0
			},
			quality = {
				0
			},
			career = {
				0
			},
			color = {
				0
			},
			tag = {
				0
			}
		})
	else
		self._isUpSort = self._record.isUpSort
		self._sortType = self._record.sortType

		local var_array = rule[self._sortType]

		self._defaultSort = var_array[1]
	end

	goutil.setActive(self._goUpBtnFilter, self._isUpSort)
	goutil.setActive(self._goDownBtnFilter, not self._isUpSort)

	for _, cell in pairs(self._filterCell or {}) do
		local upSort

		if cell.filterTyp == self._defaultSort then
			upSort = self._isUpSort
		end

		cell.onSelectFilter(self._defaultSort, upSort)
	end

	self:_updateFilterBtnText()
end

function M:_updateFilterBtnText()
	local moduleType = CommEnum.HeroFilter.HeroDepot
	local record = CharacterUtil.getFilterViewOpt(moduleType)
	local rule = HeroSortRuleConfig.instance:getHeroDepotRule()
	local sortType = record.sortType
	local var_array = rule[sortType]
	local defaultSort = var_array[1]

	self._txtBtnFilter.text = self:_sortTyp2Name(defaultSort)
	self._txtFilterMulti.text = CharacterUtil.isFilterSelected(moduleType) and lang("tip_filter_btn_name_filter") or lang("tip_filter_btn_name_hero_depot")
end

function M:_initHeroData()
	local sortData = HeroDepotModel.instance:sortDepotList()

	if GuideController.instance:isGuiding() then
		local curGuideId = GuideController.instance:getCurGuideId()
		local guideConstData = ConstConfig.instance:getJsonValueByKey("UpgradeGuideId")
		local jsonConfigList = guideConstData.guideData

		for _, jsonConfig in ipairs(jsonConfigList) do
			if jsonConfig.guideId == curGuideId then
				HeroDepotModel.instance:clearSortMark()
				self:_initSortInfo()

				sortData = HeroDepotModel.instance:getHeroDepotData():getShowDataList():getMoList()
				sortData = CharacterUtil.AdjustSortByGuide(sortData, jsonConfig.heroId)

				break
			end
		end
	end

	self._showHeroData:setMoList(sortData)
	HeroDepotModel.instance:setShowDataListSort(sortData)

	local resetPos = not self._viewPresentor:getIsBackOpen()

	self:refreshScrollView(resetPos, true)
end

function M:_initHeroSelect()
	local showHeroId

	if self._viewPresentor:getIsBackOpen() then
		local viewPageMo = HeroDepotModel.instance:getViewPageMo()

		showHeroId = viewPageMo and viewPageMo.hero:getId() or -1
		showHeroId = showHeroId or -1

		if showHeroId <= 0 then
			local displayHero, _ = MainScenePerformUtil.getDisplayAdjutantHeroId()

			showHeroId = displayHero
		end
	else
		local displayHero, _ = MainScenePerformUtil.getDisplayAdjutantHeroId()

		if HeroDepotModel.instance:getHeroInfoByID(displayHero) then
			showHeroId = displayHero
		else
			for index, characterData in ipairs(self._showHeroData:getMoList()) do
				if not showHeroId and self:_heroResourceCheck(characterData:getId(), characterData:getSkinId(), false) then
					showHeroId = characterData:getId()
				end
			end
		end
	end

	local selectIndex = 1

	for _index, characterData in ipairs(self._showHeroData:getMoList()) do
		if characterData:getId() == showHeroId then
			selectIndex = _index
		end
	end

	self:_onCellClick(showHeroId, true, selectIndex)

	return showHeroId
end

function M:_buildFilterCell(go, filterTyp)
	local cell = {}

	cell.go = go
	cell.filterTyp = filterTyp
	cell.isSelect = false
	cell.isUpSort = false
	cell.goUp = goutil.findChild(go, "up", UIComponentType.RectTransform).gameObject
	cell.goDown = goutil.findChild(go, "down", UIComponentType.RectTransform).gameObject
	cell.goSelect = goutil.findChild(go, "select").gameObject
	cell.txtName = goutil.findChildTextComponent(go, "Label")
	cell.txtName.text = self:_sortTyp2Name(filterTyp)
	cell.btnClick = UIComponentType.ButtonAdapter(go)

	cell.btnClick:AddClickListener(function()
		self:_onFilterItemClick(cell.filterTyp)
	end, self)

	function cell.onSelectFilter(theFilterTyp, upSort)
		local isSelect = cell.filterTyp == theFilterTyp

		goutil.setActive(cell.goSelect, isSelect)

		if isSelect and cell.isSelect == isSelect then
			cell.isUpSort = not cell.isUpSort
		end

		if upSort ~= nil then
			cell.isUpSort = upSort
		end

		goutil.setActive(cell.goUp, cell.isUpSort)
		goutil.setActive(cell.goDown, not cell.isUpSort)

		cell.isSelect = isSelect
	end

	return cell
end

function M:_onFilterItemClick(filterTyp)
	local moduleType = CommEnum.HeroFilter.HeroDepot

	for _, cell in pairs(self._filterCell or {}) do
		cell.onSelectFilter(filterTyp)
	end

	local isUpSort = self._filterCell[filterTyp].isUpSort
	local record = CharacterUtil.getFilterViewOpt(moduleType)

	record.sortType = filterTyp
	record.isUpSort = isUpSort

	CharacterUtil.saveFilterViewOpt(moduleType, record)

	local dataLst = HeroDepotModel.instance:sortDepotList()

	self:_handleFilterHeroDepotData(nil, dataLst)
end

function M:refreshScrollView(resetPos, playOpenAni, hardRefresh)
	local count = self._showHeroData:getMoCount()

	self._needPlayItemCellOpenAni = playOpenAni

	goutil.setActive(self._goEmptyLst, count == 0)

	if self._loopGridView:GetLoopGridView().ItemTotalCount ~= count then
		self._loopGridView:SetListItemCount(count, resetPos)

		if hardRefresh then
			self._loopGridView:RefreshAllShownItem()
		end
	else
		self._loopGridView:RefreshAllShownItem()

		if resetPos then
			self._loopGridView:MoveToItemIndex(0)
		end
	end

	self:_playItemOpenAni(playOpenAni)
	removetimer(self.updateSelect, self)
	settimer(0, self.updateSelect, self, false)
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._loopGridView:NewListViewItem("charater_info_item_copy")
	local heroData = self._showHeroData:getMoList()[curIndex]
	local data = {}

	data.heroData = heroData
	data.heroId = heroData:getId()
	data.index = curIndex

	self:_updateCell(item.gameObject, data)

	item.gameObject.name = string.format("item_%s", heroData:getId())

	return item
end

function M:_updateCell(go, data)
	if not self._itemData then
		self._itemData = {}
	end

	local key = go:GetInstanceID()
	local theItem = self._itemData[key]

	if not theItem then
		theItem = {
			go = go,
			canvasGroup = goutil.addComponentOnce(go, ComponentType.CanvasGroup),
			goMaskEffeect = goutil.findChild(go, "mask").gameObject
		}

		goutil.setActive(theItem.goMaskEffeect, false)

		theItem.heroId = data.heroId
		theItem.index = data.index
		theItem.imgQuality = goutil.findChildImageComponent(go, "imgQuality")
		theItem.imgQuality2 = goutil.findChildImageComponent(go, "imgQuality_2")
		theItem.heroHead = goutil.findChildImageComponent(go, "headIcon")
		theItem.imgCareerDi = goutil.findChildImageComponent(go, "career/type1/imgCareerDi")
		theItem.imgCareer = goutil.findChildImageComponent(go, "career/type1/imgCareerSign")
		theItem.txtLv = goutil.findChildTextComponent(go, "txtNum")
		theItem.goSelect = goutil.findChild(go, "select").gameObject
		theItem.goNew = goutil.findChild(go, "goNew").gameObject
		theItem.goRedDot = goutil.findChild(go, "goRedPoint").gameObject
		theItem.goTagRoot = goutil.findChild(go, "objPursuit").gameObject
		theItem.txtTag = goutil.findChildComponent(go, "objPursuit/txtSign", UIComponentType.Text)
		theItem.btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)

		function theItem.isActive()
			return theItem.go.gameObject.activeSelf
		end

		function theItem.getIndex()
			return theItem.index
		end

		function theItem.getHeroId()
			return theItem.heroId
		end

		function theItem.getHeroData()
			return HeroDepotModel.instance:getHeroInfoByID(theItem.getHeroId())
		end

		function theItem.updateSelect(heroId)
			goutil.setActive(theItem.goSelect, theItem.getHeroId() == heroId)
		end

		function theItem.showTag(show)
			if show then
				local mainTags = CharacterConfig.instance:getCharacterTags(theItem.getHeroId(), true)

				if mainTags[1] then
					local name = self:_getTagName(mainTags[1])

					theItem.txtTag.text = name
				else
					show = false
				end
			end

			goutil.setActive(theItem.goTagRoot, show)
		end

		function theItem.playOpenAni(play, duration, delay)
			theItem.canvasGroup:DOKill(false)
			goutil.setActive(theItem.goMaskEffeect, false)

			if play then
				duration = duration or 0.26
				delay = delay or 0
				theItem.canvasGroup.alpha = 0

				goutil.setActive(theItem.goMaskEffeect, true)
				theItem.canvasGroup:DOFade(1, duration):SetEase(DG.Tweening.Ease.Linear):SetDelay(delay):SetAutoKill(true):OnComplete(function()
					goutil.setActive(theItem.goMaskEffeect, false)
				end, self)
			else
				theItem.canvasGroup.alpha = 1
			end
		end

		function theItem.refreshRedDot()
			local _heroData = theItem.getHeroData()

			if _heroData then
				local hasNewHero = _heroData:getHeroIsNewItem()
				local hasHeroCanBreakLvUp = _heroData:getHeroCanBreakLvUp()
				local canSublimed = _heroData:getHeroCanSublimed()

				goutil.setActive(theItem.goNew, hasNewHero)
				goutil.setActive(theItem.goRedDot, not hasNewHero and (hasHeroCanBreakLvUp or canSublimed))
			end
		end

		theItem.btnClick:AddClickListener(function()
			self:_onCellClick(theItem.getHeroId(), false, theItem.getIndex())
		end, self)

		function theItem.destroyUI()
			theItem.btnClick:RemoveClickListener()
		end

		self._itemData[key] = theItem
	end

	theItem.heroId = data.heroId
	theItem.index = data.index

	local characterCO = CharacterConfig.instance:getCfgInfoByID(theItem.heroId)

	if characterCO then
		self._modelID = characterCO.modelId

		local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

		IconLoader.setSprite(theItem.heroHead, IconType.RoleHeadIcon, modelCO.headIconName)
		IconLoader.setSprite(theItem.imgQuality, IconType.DynSpriteAtlas_CharacterDepot, CommEnum.Quality2DepotCardBg[characterCO.quality])
		IconLoader.setSprite(theItem.imgQuality2, IconType.DynSpriteAtlas_CharacterDepot, CommEnum.Quality2DepotCardBg2[characterCO.quality])
		IconLoader.setSprite(theItem.imgCareer, IconType.Skinlib, CommEnum.Career2Icon[characterCO.career])
		IconLoader.setSprite(theItem.imgCareerDi, IconType.Skinlib, CommEnum.ColorType2Icon[characterCO.colorType])
	end

	theItem.txtLv.text = string.format("Lv.%s", data.heroData:getLevel())

	theItem.showTag(false)
	theItem.refreshRedDot()

	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroId = viewPageMo and viewPageMo.hero:getId() or -1

	theItem.updateSelect(heroId)

	theItem.canvasGroup.alpha = self._needPlayItemCellOpenAni and 0 or 1
end

function M:_onCellClick(newHeroId, initCall, index)
	if not self.isThisViewOpen then
		return
	end

	if not initCall and self._selectHeroId and self._selectHeroId == newHeroId then
		return
	end

	local heroData = HeroDepotModel.instance:getHeroInfoByID(newHeroId)

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_character, nil, nil, nil)
	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), 1, true, not self._viewPresentor:getIsBackOpen(), newHeroId)

	local success = self:_changeAdjutantHeroShow(newHeroId, not initCall)

	self._selectHeroId = newHeroId

	HeroDepotModel.instance:setViewPageMo({
		hero = heroData,
		index = index,
		list = {
			heroData
		}
	})

	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(newHeroId)

	self._txtName2.text = heroInfoCO.name

	local breakLv = heroData:getBreakLv()

	for i = 1, self._rectTrContractRoot.childCount - 1 do
		goutil.setActive(self._rectTrContractRoot:GetChild(i).gameObject, i <= breakLv)
	end

	self:_updateSign(newHeroId)
	self:updateSelect()
	self:updateAdjutantBtnStatus()
	self:_refreshModelOptimizingTips(newHeroId)
	self:_updateFightingCapacity()
	self:_updateBtnEquip()
	self:_updateBtnEcho()

	local tacitCO = TacitConfig.instance:getTacitCO(newHeroId)
	local showTacit = tacitCO and tacitCO.isOnLine == 1
	local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Tacit)
	local _tacitStr = heroData:getTacit() >= TacitConfig.instance:getTacitMaxLevel() and "Max" or heroData:getTacit()

	self._txtTacit.text = heroData:getTacit()

	heroData:removeNewItemMark()
	TacitAgent.instance:sendGetTaskInfoRequest(newHeroId)
	self:_refreshAnchorPanel()
	self:_refreshBreakAndTacitRedDot()
end

function M:updateSelect()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroId = viewPageMo and viewPageMo.hero:getId() or -1

	for _, theItem in pairs(self._itemData or {}) do
		theItem.updateSelect(heroId)
	end
end

function M:updateAdjutantBtnStatus()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroId = viewPageMo and viewPageMo.hero:getId() or -1
	local displayHero, _ = MainScenePerformUtil.getDisplayAdjutantHeroId()
	local isAdjutant = displayHero == heroId

	goutil.setActive(self._btnSetAdjutant.gameObject, not isAdjutant)
	goutil.setActive(self._goAlreadyAdjutant.gameObject, isAdjutant)
end

function M:_changeAdjutantHeroShow(newHeroId, isChange)
	local _charcterCfg = CharacterConfig.instance:getCfgInfoByID(newHeroId)

	if not _charcterCfg then
		return false
	end

	local skinId = CharacterSkinUtil.getHeroUsingSkinId(newHeroId)

	if not self:_heroResourceCheck(newHeroId, skinId, true) then
		-- block empty
	end

	local prefix = MainPerformEnum.AnimPrefix.XiangQing
	local forceSet = false
	local mixDuration

	MainScenePerformUtil.changeHeroReq(MainPerformEnum.ElementPointAdjutant, newHeroId, skinId, forceSet, prefix, mixDuration, isChange)

	return true
end

function M:_heroResourceCheck(heroId, skinId, showLog)
	local exist = MainScenePerformUtil.getHeroModelAssetExist(heroId, skinId, showLog)

	if not exist then
		return false
	end

	return true
end

function M:_playItemOpenAni(play)
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = {}

	if play then
		self._scroll.enabled = false

		local duration = 0.1
		local maxDelay = 0.5
		local index = 1

		for _, cell in pairs(self._itemData or {}) do
			if cell.isActive() then
				local delay = index * 0.05

				delay = maxDelay < delay and maxDelay or delay

				cell.playOpenAni(play, duration, delay)

				index = index + 1
			end
		end

		self._needPlayItemCellOpenAni = false

		table.insert(self._cacheTweenLst, DoTweenUtil.DelayedCall(maxDelay, function()
			self._scroll.enabled = true
		end))
	else
		for _, cell in pairs(self._itemData or {}) do
			cell.playOpenAni(false)
		end

		self._cacheTweenLst = nil
		self._needPlayItemCellOpenAni = false
		self._scroll.enabled = true
	end
end

function M:_regLockStats(key, root, objNormal, objLock)
	if not self._lockStatsGroup then
		self._lockStatsGroup = {}
	end

	local data = {}

	data.root = root.gameObject
	data.normal = objNormal and objNormal.gameObject or nil
	data.lock = objLock and objLock.gameObject or nil
	self._lockStatsGroup[key] = data
end

function M:_updateSign(heroId)
	local tags = CharacterConfig.instance:getCharacterTags(heroId)
	local root = self._rectTrSignGroup

	while root.childCount < #tags do
		goutil.cloneAndSetParent(root:GetChild(0).gameObject, root)
	end

	for i = 0, root.childCount - 1 do
		local go = root:GetChild(i).gameObject
		local tagId = tags[i + 1]

		if tagId then
			local txtName = goutil.findChildTextComponent(go, "txtSign")

			txtName.text = self:_getTagName(tagId)
		end

		goutil.setActive(go, tagId)
	end
end

function M:_getTagName(tagId)
	local name = ""

	if tagId then
		local tagCO = ActiveSkillConfig.instance:getSkillTagCO(tagId)

		name = tagCO and tagCO.name or name
	end

	return name
end

function M:_onClickContract()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleBreak, true) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.CharacterPreview) then
		return
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_gongming, nil, nil, nil)
	ViewMgr.instance:open(ViewName.CharacterHeartAnchorBreakView)
end

function M:getCurHeroData()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	return viewPageMo and viewPageMo.hero or false
end

function M:_refreshAnchorPanel()
	local heroData = self:getCurHeroData()
	local curLevel = heroData:getBreakLv()

	for i, v in ipairs(self._anchorList) do
		goutil.setActive(v, i <= curLevel)
	end
end

function M:_refreshTacit()
	local showTacit = false
	local heroData = self:getCurHeroData()

	if heroData then
		local tacitCO = TacitConfig.instance:getTacitCO(heroData:getId())

		if tacitCO then
			showTacit = tacitCO.isOnLine == 1
		end
	end

	self._txtTacit.text = heroData:getTacit()
end

function M:_onClickTacit()
	if ViewMgr.instance:isOpen(ViewName.CharacterPreview) then
		return
	end

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Tacit, true) then
		return
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_yinxiang, nil, nil, nil)
	ViewMgr.instance:open(ViewName.CharacterHeartAnchorView)
end

function M:_onClickEquip()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEquip, true) then
		return
	end

	local heroData = self:getCurHeroData()

	heroData = heroData and HeroDepotModel.instance:getHeroInfoByID(heroData:getId())

	if not heroData then
		return
	end

	local equipHeroData = heroData:getHeroEquipData()
	local equipList = equipHeroData:getEquipList()
	local index = 1

	for i = 1, EquipEnum.MaxPartType do
		if not equipList[i] then
			index = i

			break
		end
	end

	local part = EquipEnum.PartTypeList[index]

	EquipController.instance:setOperateHero(heroData)
	EquipController.instance:setEquipFilterCfgPartType(part)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqigenghuan, nil, nil, nil)
	ViewMgr.instance:open(ViewName.ChangeEquip)
end

function M:_onClickEcho()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEcho, true) then
		return
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_canxianggenghuan, nil, nil, nil)

	local echoItemData = EchoItemController.instance:getCurHeroEchoItem()

	EchoItemMainController.instance:setSelectedEchoItem(echoItemData)

	local params = {
		index = EchoItemMainViewNew.SubViewType.Change
	}

	ViewMgr.instance:open(ViewName.EchoItemMainViewNew, params)
end

function M:_refreshModelOptimizingTips(heroId)
	local isOptimizing = CharacterUtil.isHeroModelOptimizing(heroId)

	goutil.setActive(self._goTipsModelOptimizing, isOptimizing)
end

function M:_updateFightingCapacity()
	local heroData = self:getCurHeroData()

	if heroData then
		heroData = HeroDepotModel.instance:getHeroInfoByID(heroData:getId())

		if self._txtRolePowerNum and not goutil.isNil(self._txtRolePowerNum) then
			self._txtRolePowerNum.text = heroData:getAttribute(BattleExtension_pb.Attribute.FIGHTING_CAPACITY)
		end
	end
end

function M:_updateBtnEquip()
	local sysOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEquip, false)
	local heroData = self:getCurHeroData()
	local equipList = {}

	if heroData then
		heroData = HeroDepotModel.instance:getHeroInfoByID(heroData:getId())

		local equipHeroData = heroData:getHeroEquipData()

		equipList = equipHeroData:getEquipList()
	end

	for index, go in ipairs(self._goEquipMarkList) do
		goutil.setActive(go, equipList[index] ~= nil)
	end

	goutil.setActive(self._btnEquip.gameObject, sysOpen)
end

function M:_updateBtnEcho()
	local sysOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEcho, false)
	local echoItemData = EchoItemController.instance:getCurHeroEchoItem()
	local echoItemId = echoItemData and echoItemData:getId() or 0
	local hasEquip = echoItemId > 0

	goutil.setActive(self._goEchoNone, not hasEquip)
	goutil.setActive(self._goEchoEquip, hasEquip)
	goutil.setActive(self._btnEcho.gameObject, sysOpen)
end

return M
