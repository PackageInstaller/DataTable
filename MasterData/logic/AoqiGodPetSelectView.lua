-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodPetSelectView.lua

module("logic.extensions.aoqigod.view.AoqiGodPetSelectView", package.seeall)

local AoqiGodPetSelectView = class("AoqiGodPetSelectView", ViewComponent)

function AoqiGodPetSelectView:ctor()
	AoqiGodPetSelectView.super.ctor(self)
end

function AoqiGodPetSelectView:unbindEvents()
	AoqiGodPetSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnSort)
	GameUtil.rmClickHandler(self._InputC_Search_Clear)
end

function AoqiGodPetSelectView:bindEvents()
	AoqiGodPetSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
	GameUtil.addClickHandler(self._InputC_Search_Clear, self._onClearSearchClick, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
end

function AoqiGodPetSelectView:buildUI()
	AoqiGodPetSelectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTip = self:getTxt("scrollView/Viewport/Content")
	self._tipsStr = self._txtTip.text
	self._btnSort = self:getGo("btnSort")
	self._btnFilter = self:getGo("btnFilter")
	self._inputSearch = self:getInput("InputC_Search")
	self._InputC_Search_Clear = self:getBtn("InputC_Search/BtnClear")

	local RaceFilterGo = self:getGo("RaceFilter")

	self._raceFilter = ItemFilterExt.New(RaceFilterGo, 1, 7, false, "Cell", "Mark")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function AoqiGodPetSelectView:onExit()
	AoqiGodPetSelectView.super.onExit(self)
	self._scrollList:dispose()
end

function AoqiGodPetSelectView:onEnter()
	AoqiGodPetSelectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodSeekHelpRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._actData = AoqiGodConfig.instance:getActData(self._activityId)
	self._helpCfgs = AoqiGodController.instance:getClgCfgSort(self._activityId)
	self._petMoList = AoqiGodController.instance:getPetMoList(self._activityId)
	self._petChallengeIdMap = AoqiGodController.instance:getPetChallengeIdMap(self._activityId)
	self._aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(self._activityId)
	self._caller = self._aoqiGodMo:getCaller()
	self._curChallengeId = self._caller and self._caller:getChallengeId() or 0

	self:_onUpdate()
end

function AoqiGodPetSelectView:_onUpdate()
	self._curChallengeId = self._caller and self._caller:getChallengeId() or 0
	self._txtTip.text = string.format(self._tipsStr, self._aoqiGodMo:getLeftCountOfCallerPublicInWeek(), self._aoqiGodMo:getLeftCountOfCaller(), self._actData.helpTimeHour)
	self._curViewDatas = {}

	for k, petMo in pairs(self._petMoList) do
		if self:onFilter(petMo) then
			self._curViewDatas[#self._curViewDatas + 1] = petMo
		end
	end

	local names, opt = AoqiGodController.instance:GetSortParms(self._activityId)

	ArraySort.sortOn(self._curViewDatas, names, opt)
	self._scrollList:reloadData(self._curViewDatas)
end

function AoqiGodPetSelectView:_updateCell(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local mask = goutil.findChild(cell, "mask")
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local donthave = goutil.findChild(cell, "donthave")
	local help = goutil.findChild(cell, "help")
	local hasGain = goutil.findChild(cell, "hasGain")
	local awakeLv = goutil.findChild(cell, "awakeLv")
	local imgAwake = goutil.findChild(cell, "awakeLv/imgAwake")
	local txtBtnSelect = goutil.findChildTextComponent(cell, "btnSelect/txt")
	local awakeChangeComp = imgAwake:GetComponent("UIImageSpriteChange")
	local petList = BagModel.instance:getPetsByRaceId(data.raceId)
	local hasPet = #petList > 0
	local challengeId = self._petChallengeIdMap[data.raceId]
	local isDoing = challengeId == self._curChallengeId
	local maxAwakeLv = BagModel.instance:getMaxAwakenLv(data.raceId)
	local finishItem = self._aoqiGodMo:getFinishItem(challengeId)
	local isHasGain = finishItem ~= nil
	local hasHelpTime = self._aoqiGodMo:getLeftCountOfCallerPublicInWeek() > 0

	txtBtnSelect.text = "选择"

	awakeChangeComp:SetState(maxAwakeLv)
	MaterialMgr.setCell(MatType.Pet, data.raceId, pet)
	GameUtil.SetActive(awakeLv, hasPet)
	GameUtil.SetActive(donthave, not hasPet)
	GameUtil.SetActive(help, isDoing)

	if isDoing then
		GameUtil.SetActive(mask, false)

		txtBtnSelect.text = "已选"
	else
		GameUtil.SetActive(mask, isHasGain or not hasHelpTime)
	end

	GameUtil.SetActive(hasGain, isHasGain)
	GameUtil.addClickHandler(btnSelect, function()
		self:_onClickPet(data.raceId)
	end, self)
end

function AoqiGodPetSelectView:_clearCell(cell)
	local pet = goutil.findChild(cell, "pet")

	MaterialMgr.resetAll(pet)
end

function AoqiGodPetSelectView:_onClickPet(raceId)
	local challengeId = self._petChallengeIdMap[raceId]
	local petData = CharacterConfig.instance:getPetCo(raceId)

	if petData then
		if not petData.name then
			local result = AoqiGodController.instance:getTryPublicCallerResultAndTips(true, self._activityId, challengeId)

			if result ~= GameEnum.ResultCode.Success then
				return
			end

			if challengeId == self._curChallengeId then
				FloatWordMgr.instance:show("正在求助中，不可同时发起多个求助")

				return
			end

			if self._aoqiGodMo:getFinishItem(challengeId) ~= nil then
				FloatWordMgr.instance:show("本期已完成挑战，不可再次求助")

				return
			end

			if self._aoqiGodMo:getLeftCountOfCallerPublicInWeek() <= 0 then
				FloatWordMgr.instance:show("已无求助次数")

				return
			end

			UIStateManager.instance:push(ViewName.AoqiGodCharmCostView, self._activityId, challengeId)
		end
	end
end

function AoqiGodPetSelectView:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
	local isHit = false

	isHit = self:_isMatch(petCo, pet.rare, pet.faceId)

	if not string.nilorempty(self._currSearching) then
		local str = StringUtil.RelpaceEscapeChar(self._currSearching)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function AoqiGodPetSelectView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_AOQI_GOD, cfg, rare, skinId)
end

function AoqiGodPetSelectView:_onClickSort()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnSort.gameObject)
	local arr = self:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self.onRefreshPetSort, self))
end

function AoqiGodPetSelectView:onRefreshPetSort(idx, onResetCallback)
	self:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, self._sortValue)

	local names, opt = AoqiGodController.instance:GetSortParms(self._activityId)

	ArraySort.sortOn(self._curViewDatas, names, opt)
	self._scrollList:reloadData(self._curViewDatas)
end

function AoqiGodPetSelectView:SetNextSort(idx)
	self._sortValue = self:GetSortState()

	local v = self._sortValue[idx]

	v = v + 1

	local vArr = BagModel.SORT_VALUE[idx]

	v = v % #vArr

	if idx ~= #BagModel.SORT_VALUE then
		for i = 1, #BagModel.SORT_VALUE - 1 do
			self._sortValue[i] = 0
		end
	end

	self._sortValue[idx] = v
end

function AoqiGodPetSelectView:GetSortState()
	if self._sortValue == nil and (self._sortValue == nil or #self._sortValue ~= #BagModel.SORT_NAME) then
		self._sortValue = {}

		for i = 1, #BagModel.SORT_NAME do
			self._sortValue[i] = i == 1 and 1 or 0
		end
	end

	return self._sortValue
end

function AoqiGodPetSelectView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_RefreshPetList()
	end
end

function AoqiGodPetSelectView:_onClearSearchClick()
	self._inputSearch.input.text = ""
end

function AoqiGodPetSelectView:_onClickFilter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_AOQI_GOD, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function AoqiGodPetSelectView:_RefreshPetList(force)
	self._curViewDatas = {}

	for k, petMo in pairs(self._petMoList) do
		if self:onFilter(petMo) then
			self._curViewDatas[#self._curViewDatas + 1] = petMo
		end
	end

	local names, opt = AoqiGodController.instance:GetSortParms(self._activityId)

	ArraySort.sortOn(self._curViewDatas, names, opt)
	self._scrollList:reloadData(self._curViewDatas)
end

function AoqiGodPetSelectView:updateFilterData(starList, jobList, rareList)
	local data = PetFilterMgr.instance:getFilterData(PetFilterMgr.TYPE_AOQI_GOD)

	self._raceFilter:initData(data.raceSelectList)
	self._raceFilter:initActiveList(data.raceActiveList)
	self._raceFilter:initClickAble(data.raceClickAble)
	self:_RefreshPetList()
end

return AoqiGodPetSelectView
