-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/stack/BagPetColView.lua

module("logic.extensions.roleinfo.view.stack.BagPetColView", package.seeall)

local BagPetColView = class("BagPetColView", ViewComponent)

function BagPetColView:ctor()
	BagPetColView.super.ctor(self)
end

function BagPetColView:bindEvents()
	BagPetColView.super.bindEvents(self)
	GameUtil.addClickHandler(self._clickMask, self.close, self)
	GameUtil.addClickHandler(self._btnClear, self._onClearSearch, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
end

function BagPetColView:unbindEvents()
	BagPetColView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._clickMask)
	GameUtil.rmClickHandler(self._btnClear)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnSort)
	self._inputSearch:RemoveOnValueChanged()
end

function BagPetColView:buildUI()
	BagPetColView.super.buildUI(self)

	self._clickMask = self:getGo("clickMask")
	self._petScrollerview = self:getGo("Nego_Right/petScrollerview")
	self._petScrollercell = self:getGo("Nego_Right/petScrollercell")
	self._btnSort = self:getGo("Nego_Right/btnSort")
	self._btnFilter = self:getGo("Nego_Right/btnFilter")
	self._btnClear = self:getGo("Nego_Right/InputC_Search/BtnClear")
	self._bagPetScrollList = ScrollerList.create(self._petScrollerview, self._petScrollercell, GameUtil.handler(self._updateBagPetCell, self), GameUtil.handler(self._clearBagPetCell, self))
	self._inputSearch = self:getInput("Nego_Right/InputC_Search")
end

function BagPetColView:onEnter()
	BagPetColView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._bagPetMoList = params[1]

	self._bagPetScrollList:reloadData(self._bagPetMoList)
end

function BagPetColView:onExit()
	BagPetColView.super.onExit(self)
	self._bagPetScrollList:dispose()
end

function BagPetColView:_updateBagPetCell(view, cell, petMo, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local imgReduce = goutil.findChild(mainGo, "imgReduce")
	local petId = petMo:getPetId()
	local raceId = petMo:getDefineId()
	local isSelected = self:_isSelectedPetOfPetId(petId)

	GameUtil.SetActive(imgReduce, isSelected)

	local proxy = MaterialMgr.setCellByMo(petMo, item)

	proxy.binder:setAutoTips(false)
	proxy.binder:setSelected(isSelected)
	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickBagPetCell, self, petMo))
end

function BagPetColView:_clearBagPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local imgReduce = goutil.findChild(mainGo, "imgReduce")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnSelect)
end

function BagPetColView:_onClickBagPetCell(petMo)
	local petId = petMo:getPetId()
	local raceId = petMo:getDefineId()
	local isPetSelected = self:_isSelectedPetOfPetId(petId)
	local isNeedUpdate = false

	if isPetSelected then
		self:_setFavourPetIds(petId, false)

		isNeedUpdate = true
	else
		local isFull = self:_isFullOfFavour()

		if not isFull or isFull and self:_isSelectedPetOfRaceId(raceId) then
			self:_setFavourPetIds(petId, true)

			local petIdx = self:_getCardInfoMo():getFavourPetCount() + 1

			for i, v in ipairs(self:_getCardInfoMo():getFavourPetIds()) do
				if v == petId then
					petIdx = i
				end
			end

			GlobalDispatcher:dispatch(GlobalNotify.CardInfoMarkPetIdxAsNew, petIdx, true)

			isNeedUpdate = true
		else
			FloatWordMgr.instance:show(string.format("最多可展示%s只精灵", self:_getMaxCountOfFavourPet()))
		end
	end

	if isNeedUpdate then
		local petIds = self:_getPetIdListOfFavour()

		GlobalDispatcher:dispatch(GlobalNotify.UpdateCardInfoBagPetScrollview)
		self:_updateBagPetScrollview()
		RoleController.instance:sendPM_ChangePetFavorPetsReq(petIds)
	end
end

function BagPetColView:_setFavourPetIds(petId, isAdd)
	self:_getCardInfoMo():setFavourPetIds(petId, isAdd)
end

function BagPetColView:_isFullOfFavour()
	local maxCount = self:_getMaxCountOfFavourPet()

	return maxCount <= self:_getCardInfoMo():getFavourPetCount()
end

function BagPetColView:_isSelectedPetOfRaceId(raceId)
	return self:_getCardInfoMo():isHaveFavourPetOfRace(raceId)
end

function BagPetColView:_getCardBelong()
	return RoleModel.CardBelong.Other
end

function BagPetColView:_getCardInfoMo()
	return RoleModel.instance:getCardInfoMo(self:_getCardBelong())
end

function BagPetColView:_getPetIdListOfFavour()
	return self:_getCardInfoMo():getFavourPetIds()
end

function BagPetColView:_updateBagPetScrollview()
	self._bagPetScrollList:reloadData(self._bagPetMoList or {})
end

function BagPetColView:_getNewIdxList()
	return self._petIdxAsNew or {}
end

function BagPetColView:_getMaxCountOfFavourPet()
	return 6
end

function BagPetColView:_isSelectedPetOfPetId(petId)
	return self:_getCardInfoMo():isHaveFavourPet(petId)
end

function BagPetColView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_onUpdateBagPetColUI()
	end
end

function BagPetColView:_onClearSearch()
	self._inputSearch.input.text = ""
end

function BagPetColView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter)

	local function func()
		self:_onUpdateBagPetColUI()
	end

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, func)
end

function BagPetColView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function BagPetColView:_onUpdateBagPetColUI()
	self:_updateBagPetList()
	self._bagPetScrollList:reloadData(self._bagPetMoList or {})
end

function BagPetColView:_updateBagPetList()
	self._bagPetMoList = {}

	if not BagPetsController.instance:getReady() then
		return
	end

	local allPets = BagPetsController.instance:getBagPets()

	for k, v in ipairs(allPets) do
		if self:onFilter(v) then
			table.insert(self._bagPetMoList, v)
		end
	end

	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and limit <= #self._bagPetMoList then
		-- block empty
	else
		local names, opt = BagModel.instance:GetSortParms()

		names[1] = FormationGroupModel.checkIsInTeamByMo

		ArraySort.sortOn(self._bagPetMoList, names, opt)
	end

	self:_updateBagPetListOfSelect()
end

function BagPetColView:_updateBagPetListOfSelect()
	if self._bagPetMoList == nil then
		return
	end

	local selectedList = {}
	local unselectedList = {}

	for _, petMo in ipairs(self._bagPetMoList) do
		if self:_isSelectedPetOfPetId(petMo:getPetId()) then
			table.insert(selectedList, petMo)
		else
			table.insert(unselectedList, petMo)
		end
	end

	local mergedList = {}

	for _, item in ipairs(selectedList) do
		table.insert(mergedList, item)
	end

	for _, item in ipairs(unselectedList) do
		table.insert(mergedList, item)
	end

	self._bagPetMoList = mergedList
end

function BagPetColView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnSort)
	local arr = BagModel.instance:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self.onRefreshPetSort, self))
end

function BagPetColView:onRefreshPetSort(idx, onResetCallback)
	BagModel.instance:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, BagModel.instance:GetSortState())

	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and self._bagPetMoList and limit <= #self._bagPetMoList then
		-- block empty
	else
		local names, opt = BagModel.instance:GetSortParms()

		names[1] = FormationGroupModel.checkIsInTeamByMo

		ArraySort.sortOn(self._bagPetMoList, names, opt)
	end

	self:_updateBagPetListOfSelect()
	self._bagPetScrollList:reloadData(self._bagPetMoList or {})
end

function BagPetColView:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
	local isHit = self:_isMatch(petCo, pet.rare, pet.curFaceId)

	if not string.nilorempty(self._currSearching) then
		local str = StringUtil.RelpaceEscapeChar(self._currSearching)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function BagPetColView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, cfg, rare, skinId)
end

return BagPetColView
