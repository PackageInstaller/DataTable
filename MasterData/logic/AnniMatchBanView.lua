-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnniMatchBanView.lua

module("logic.extensions.annimatch.view.AnniMatchBanView", package.seeall)

local AnniMatchBanView = class("AnniMatchBanView", ViewComponent)

function AnniMatchBanView:ctor()
	AnniMatchBanView.super.ctor(self)
end

function AnniMatchBanView:unbindEvents()
	AnniMatchBanView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnHistory)
	GameUtil.rmClickHandler(self._btnVote)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnSort)
	GameUtil.rmClickHandler(self._InputC_Search_Clear)
end

function AnniMatchBanView:bindEvents()
	AnniMatchBanView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnHistory, self._onClickBtnHistory, self)
	GameUtil.addClickHandler(self._btnVote, self._onClickBtnVote, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
	GameUtil.addClickHandler(self._InputC_Search_Clear, self._onClearSearchClick, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
end

function AnniMatchBanView:buildUI()
	AnniMatchBanView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnHistory = self:getGo("left/btnHistory")
	self._btnVote = self:getGo("vote/btnVote")
	self._txtCantVote = self:getTxt("vote/btnVote/txtCantVote")
	self._inputSearch = self:getInput("vote/InputC_Search")
	self._InputC_Search_Clear = self:getBtn("vote/InputC_Search/BtnClear")
	self._txtHighPet = self:getTxt("highPets/txtHighPet")
	self._txtSelect = self:getTxt("vote/txtSelect")
	self._btnSort = self:getGo("vote/btnSort")
	self._btnFilter = self:getGo("vote/btnFilter")
	self._txtTip = self:getTxt("left/scrView/Viewport/txtTip")

	local RaceFilterGo = self:getGo("RaceFilter")

	self._raceFilter = ItemFilterExt.New(RaceFilterGo, 1, 7, false, "Cell", "Mark")
	self._tableviewVote = self:getGo("vote/tableviewVote")
	self._tablecellVote = self:getGo("vote/tableviewVote/tablecellVote")
	self._scrollList = ScrollerList.create(self._tableviewVote, self._tablecellVote, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tablecellSelectPet = self:getGo("vote/tableviewSelectPet/tablecellSelectPet")
	self._tableviewSelectPet = self:getGo("vote/tableviewSelectPet")
	self._scrollListSelectPet = ScrollerList.create(self._tableviewSelectPet, self._tablecellSelectPet, GameUtil.handler(self._updateCellSelectPet, self), GameUtil.handler(self._clearCellSelectPet, self))
end

function AnniMatchBanView:onExit()
	AnniMatchBanView.super.onExit(self)

	for i = 1, self._sysBanPetNum do
		local cellGo = self:getGo("highPets/petList/cell" .. i)
		local pet = goutil.findChild(cellGo, "pet")

		MaterialMgr.resetAll(pet)
	end

	self._scrollList:dispose()
	self._scrollListSelectPet:dispose()
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_ANNI_MATCH_BAN)
end

function AnniMatchBanView:onEnter()
	AnniMatchBanView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnnualCompetitionBanPetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_AnnualCompetitionBanPetRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.OnAnnimatchInfoUpdate, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 133001
	end

	self._activityType = 133
	self._sysBanPetNum = checknumber(AnnimatchConfig.instance:getCommonByKey("SYS_BAN_PET_NUM"))
	self._userBanPetNum = checknumber(AnnimatchConfig.instance:getCommonByKey("USER_BAN_PET_NUM"))
	self._voteRaceIdMap = {}
	self._voteRaceIdList = {}
	self._curVoteNum = 0
	self._sortValue = self:GetSortState()
	self._curViewDatas = {}

	local curTime = ServerTime.now()
	local sysTimeStamp = 1764277200

	if sysTimeStamp <= curTime then
		self._petMoList = AnnimatchController.instance:getActSysPetMoList(self._activityId)
		self._petIdxMap = AnnimatchController.instance:getAllSysPetIdxMap(self._activityId)
	else
		self._petMoList = AnnimatchController.instance:getAllPetMoList()
		self._petIdxMap = AnnimatchController.instance:getAllPetIdxMap()
	end

	self._choosePetIdList = {}
	self._choosePetList = {}

	self:_onSetUI()
	AnnimatchController.instance:sendPM_AnnualCompetitionBanPetInfoReq(self._activityId)
end

function AnniMatchBanView:_onSetUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	local ruleTip = AnnimatchConfig.instance:getCommonByKey("BAN_PET_RULE_TIP")
	local canVoteWinTimes = checknumber(AnnimatchConfig.instance:getCommonByKey("CAN_BAN_PET_WIN_TIMES"))

	self._txtTip.text = ruleTip
end

function AnniMatchBanView:_onUpdate()
	self._banInfo = AnnimatchModel.instance:getBanPetInfo(self._activityId)
	self._votePetMap = AnnimatchModel.instance:getVoteRaceIdMap(self._activityId)
	self._curViewDatas = {}

	if self._banInfo then
		if #self._banInfo.selfBanRaceIds > 0 then
			self._curVoteNum = #self._banInfo.selfBanRaceIds
			self._voteRaceIdList = {}

			for i, v in ipairs(self._banInfo.selfBanRaceIds) do
				table.insert(self._voteRaceIdList, v)
			end
		end

		if self._banInfo then
			if not self._banInfo.banRaceIds then
				local banRaceIds = {}

				for k, petMo in pairs(self._petMoList) do
					if self:onFilter(petMo) and not table.indexof(banRaceIds, petMo.raceId) then
						self._curViewDatas[#self._curViewDatas + 1] = petMo
					end
				end

				local winTime = checknumber(self._banInfo.totalWinTimes)
				local canVoteWinTimes = checknumber(AnnimatchConfig.instance:getCommonByKey("CAN_BAN_PET_WIN_TIMES"))
				local limit = ConstConfig.instance:getPetLimltCount()

				if limit > 0 and limit <= #self._curViewDatas then
					-- block empty
				else
					local names, opt = AnnimatchController.instance:GetSortParms()

					names[1] = FormationGroupModel.instance.checkIsInTeamByMo

					ArraySort.sortOn(self._curViewDatas, names, opt)
				end

				local banRaceIds = self._banInfo.banRaceIds

				if #banRaceIds > 0 then
					for i = 1, self._sysBanPetNum do
						local cellGo = self:getGo("highPets/petList/cell" .. i)
						local imgEmpty = goutil.findChild(cellGo, "imgEmpty")
						local pet = goutil.findChild(cellGo, "pet")
						local raceId = checknumber(banRaceIds[i])

						if raceId > 0 then
							MaterialMgr.setCell(MatType.Pet, raceId, pet)
						end

						GameUtil.SetActive(imgEmpty, raceId <= 0)
						GameUtil.SetActive(pet, raceId > 0)
					end
				else
					for i = 1, self._sysBanPetNum do
						local cellGo = self:getGo("highPets/petList/cell" .. i)
						local imgEmpty = goutil.findChild(cellGo, "imgEmpty")
						local pet = goutil.findChild(cellGo, "pet")

						GameUtil.SetActive(imgEmpty, true)
						GameUtil.SetActive(pet, false)
					end
				end

				self._txtSelect.text = string.format("%d/%d", self._curVoteNum, self._sysBanPetNum)
				self._txtCantVote.text = winTime < canVoteWinTimes and string.format("<color=#FF0000>本周胜场数%d/%d</color>", winTime, canVoteWinTimes) or string.format("<color=#00AB08>本周胜场数已达%d</color>", canVoteWinTimes)

				self:_RefreshPetList()
				self._scrollListSelectPet:reloadData(self._voteRaceIdList)
			end
		end
	end
end

function AnniMatchBanView:_updateCell(view, cell, data)
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local pet = goutil.findChild(cell, "pet")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local raceId = data.raceId
	local skinId = checknumber(data.curFaceId)
	local selectIdx = table.indexof(self._voteRaceIdList, raceId)
	local voteNum = checknumber(self._votePetMap[raceId])

	if self._banInfo then
		local hasVoted = #self._banInfo.selfBanRaceIds > 0

		if selectIdx and not hasVoted then
			voteNum = voteNum + 1
		end

		txtNum.text = voteNum

		GameUtil.SetActive(imgSelect, selectIdx)

		if skinId > 0 then
			MaterialMgr.setCell(MatType.Pet, skinId, pet)
		else
			MaterialMgr.setCell(MatType.Pet, raceId, pet)
		end

		GameUtil.addClickHandler(cell, function()
			if hasVoted then
				FloatWordMgr.instance:show("本周已过投票，不可重复投票")

				return
			end

			if self._curVoteNum >= self._sysBanPetNum and not selectIdx then
				FloatWordMgr.instance:show("已达最大可投票上限，请先取消选择")

				return
			end

			if selectIdx then
				self._curVoteNum = self._curVoteNum - 1

				table.remove(self._voteRaceIdList, selectIdx)
			else
				self._curVoteNum = self._curVoteNum + 1

				table.insert(self._voteRaceIdList, raceId)
			end

			self:_onUpdate()
		end, self)
	end
end

function AnniMatchBanView:_clearCell(cell)
	local pet = goutil.findChild(cell, "pet")

	GameUtil.rmClickHandler(cell)
	MaterialMgr.resetAll(pet)
end

function AnniMatchBanView:_updateCellSelectPet(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local btnLocat = goutil.findChild(cell, "btnLocat")
	local idx = self._petIdxMap[data]
	local skinId = MaterialMgr.setCell(MatType.Pet, data, pet)

	GameUtil.addClickHandler(btnLocat, function()
		PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_ANNI_MATCH_BAN)
		self:_onClearSearchClick()
		self:_onUpdate()
		self._scrollList:MoveCellToCenter(idx - 1)
	end, self)
end

function AnniMatchBanView:_clearCellSelectPet(cell)
	local pet = goutil.findChild(cell, "pet")
	local btnLocat = goutil.findChild(cell, "btnLocat")

	GameUtil.rmClickHandler(btnLocat)
	MaterialMgr.resetAll(pet)
end

function AnniMatchBanView:_hasUsedSelectBanPet()
	local emptyListLength = #self._emptySelectGoList
	local userBanPetNum = checknumber(AnnimatchConfig.instance:getCommonByKey("USER_BAN_PET_NUM"))

	return emptyListLength ~= userBanPetNum
end

function AnniMatchBanView:_onClickBtnTip()
	local key = AnnimatchConfig.instance:getCommonByKey("BAN_PET_RULE_KEY")

	TipsFacade.instance:openRulesView(key)
end

function AnniMatchBanView:_onClickBtnHistory()
	UIStateManager.instance:push(ViewName.AnnimatchHistoryBanView, self._activityId)
end

function AnniMatchBanView:_onClickBtnVote()
	if self._banInfo then
		local hasVoted = #self._banInfo.selfBanRaceIds > 0

		if hasVoted then
			FloatWordMgr.instance:show("本周已过投票，不可重复投票")

			return
		end

		local winTime = checknumber(self._banInfo.totalWinTimes)
		local canVoteWinTimes = checknumber(AnnimatchConfig.instance:getCommonByKey("CAN_BAN_PET_WIN_TIMES"))

		if winTime < canVoteWinTimes then
			FloatWordMgr.instance:show(string.format("请先达到%d次胜利", canVoteWinTimes))

			return
		end

		if self._curVoteNum == 0 then
			FloatWordMgr.instance:show("请先选择要投票的精灵")

			return
		end

		local function okFunc()
			AnnimatchController.instance:sendPM_AnnualCompetitionBanPetReq(self._activityId, self._voteRaceIdList)
		end

		TipsFacade.instance:openPopupWindow("提示", (self._curVoteNum < self._userBanPetNum or nil) and string.format("当前仍可选择%d只精灵进行投票，是否放弃选择，完成投票。\n<color=#FF0000>完成投票后不可更改</color>", self._userBanPetNum - self._curVoteNum), okFunc, nil, "确定", "取消")
	end
end

function AnniMatchBanView:onFilter(pet)
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

function AnniMatchBanView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_ANNI_MATCH_BAN, cfg, rare, skinId)
end

function AnniMatchBanView:_onClickSort()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnSort.gameObject)
	local arr = self:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self.onRefreshPetSort, self))
end

function AnniMatchBanView:onRefreshPetSort(idx, onResetCallback)
	self:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, self._sortValue)

	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and self._curViewDatas and limit <= #self._curViewDatas then
		TipsFacade.instance:openCommonTips(ConstConfig.instance:getPetLimltTips())
	else
		local names, opt = AnnimatchController.instance:GetSortParms()

		names[1] = FormationGroupModel.checkIsInTeamByMo

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._scrollList:reloadData(self._curViewDatas)
end

function AnniMatchBanView:SetNextSort(idx)
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

function AnniMatchBanView:GetSortState()
	if self._sortValue == nil and (self._sortValue == nil or #self._sortValue ~= #BagModel.SORT_NAME) then
		self._sortValue = {}

		for i = 1, #BagModel.SORT_NAME do
			self._sortValue[i] = i == 1 and 1 or 0
		end
	end

	return self._sortValue
end

function AnniMatchBanView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_RefreshPetList()
	end
end

function AnniMatchBanView:_onClearSearchClick()
	self._inputSearch.input.text = ""
end

function AnniMatchBanView:_onClickFilter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_ANNI_MATCH_BAN, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function AnniMatchBanView:updateFilterData(starList, jobList, rareList)
	local data = PetFilterMgr.instance:getFilterData(PetFilterMgr.TYPE_ANNI_MATCH_BAN)

	self._raceFilter:initData(data.raceSelectList)
	self._raceFilter:initActiveList(data.raceActiveList)
	self._raceFilter:initClickAble(data.raceClickAble)
	self:_RefreshPetList()
end

function AnniMatchBanView:_RefreshPetList(force)
	self._curViewDatas = {}

	if self._banInfo then
		if not self._banInfo.banRaceIds then
			local banRaceIds = {}

			for k, petMo in pairs(self._petMoList) do
				if self:onFilter(petMo) and not table.indexof(banRaceIds, petMo.raceId) then
					self._curViewDatas[#self._curViewDatas + 1] = petMo
				end
			end

			local limit = ConstConfig.instance:getPetLimltCount()

			if limit > 0 and limit <= #self._curViewDatas then
				-- block empty
			else
				local names, opt = AnnimatchController.instance:GetSortParms()

				names[1] = FormationGroupModel.instance.checkIsInTeamByMo

				ArraySort.sortOn(self._curViewDatas, names, opt)
			end

			self._scrollList:reloadData(self._curViewDatas)
		end
	end
end

return AnniMatchBanView
