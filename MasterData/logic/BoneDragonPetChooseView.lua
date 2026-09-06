-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/view/BoneDragonPetChooseView.lua

module("logic.extensions.bonedragon.view.BoneDragonPetChooseView", package.seeall)

local BoneDragonPetChooseView = class("BoneDragonPetChooseView", ViewComponent)
local RED_COLOR = "#EA131AFF"
local GREEN_COLOR = "#3E8E28FF"

function BoneDragonPetChooseView:ctor()
	BoneDragonPetChooseView.super.ctor(self)
end

function BoneDragonPetChooseView:unbindEvents()
	BoneDragonPetChooseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnSort)
	GameUtil.rmClickHandler(self._InputC_Search_Clear)
	self._inputSearch:RemoveOnValueChanged()
end

function BoneDragonPetChooseView:bindEvents()
	BoneDragonPetChooseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
	GameUtil.addClickHandler(self._InputC_Search_Clear, self._onClearSearchClick, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
end

function BoneDragonPetChooseView:buildUI()
	BoneDragonPetChooseView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._btnFilter = self:getGo("btnFilter")
	self._btnSort = self:getGo("btnSort")
	self._inputSearch = self:getInput("InputC_Search")
	self._InputC_Search_Clear = self:getBtn("InputC_Search/BtnClear")
	self._txtNeed = self:getTxt("txtNeed")

	local RaceFilterGo = self:getGo("RaceFilter")

	self._raceFilter = ItemFilterExt.New(RaceFilterGo, 1, 7, false, "Cell", "Mark")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BoneDragonPetChooseView:onExit()
	BoneDragonPetChooseView.super.onExit(self)

	self._currSearching = nil

	self._scrollList:dispose()

	self._curViewDatas = {}
end

function BoneDragonPetChooseView:onEnter()
	BoneDragonPetChooseView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_BoneDragonClgSelectPetRes, self._onSelectPetRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 488001
	end

	self._activityType = 488
	self._actCfg = BoneDragonConfig.instance:getActCfg(self._activityId)
	self._sortValue = self:GetSortState()
	self._curViewDatas = {}
	self._allPets = BagModel.instance:getBagPets()
	self._allPets = self:_filterSameRaceId()
	self._choosePetIdList = {}
	self._choosePetList = {}

	for k, v in pairs(self._allPets) do
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end

	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and limit <= #self._curViewDatas then
		-- block empty
	else
		local names, opt = self:GetSortParms()

		names[1] = FormationGroupModel.instance.checkIsInTeamByMo

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._jobDic = self:_initJobDic()
	self._jobCfgDic = BoneDragonConfig.instance:getRecommendJobCfgDic(self._activityId)

	self._scrollList:reloadData(self._curViewDatas)
	self:_updateJobStr()
end

function BoneDragonPetChooseView:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
	local isHit = false

	isHit = self:_isMatch(petCo, pet.rare, pet.curFaceId)

	if not string.nilorempty(self._currSearching) then
		local str = StringUtil.RelpaceEscapeChar(self._currSearching)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function BoneDragonPetChooseView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_BONE_DRAGON, cfg, rare, skinId)
end

function BoneDragonPetChooseView:_updateJobStr()
	local choosePetNum = #self._choosePetList
	local enoughPetNum = choosePetNum == self._actCfg.petLimit

	if enoughPetNum then
		if not GREEN_COLOR then
			local textColor = RED_COLOR

			self._txtNeed.text = string.format("需要精灵%d名(<color=%s>%d</color>/%d)", self._actCfg.petLimit, textColor, choosePetNum, self._actCfg.petLimit)

			for jobName, jobNum in pairs(self._jobDic) do
				local recommendNum = self._jobCfgDic[jobName]
				local enoughPetNum = recommendNum <= jobNum

				if enoughPetNum then
					if not GREEN_COLOR then
						local textColor = RED_COLOR
						local curJobStr = string.format(" %s%d名 (<color=%s>%d</color>/%d)", jobName, recommendNum, textColor, jobNum, recommendNum)

						self._txtNeed.text = self._txtNeed.text .. curJobStr
					end
				end
			end
		end
	end
end

function BoneDragonPetChooseView:_initJobDic()
	local recommendList = self._actCfg.recommendJob
	local jobDic = {}

	for i, jobStr in ipairs(recommendList) do
		local arr = string.split(jobStr, "#")
		local jobName = arr[2]

		jobDic[jobName] = 0
	end

	return jobDic
end

function BoneDragonPetChooseView:_updateCell(view, cell, data)
	local imgChoose = goutil.findChild(cell, "imgChoose")
	local imgBg = goutil.findChild(cell, "imgBg")
	local imgPower = goutil.findChild(cell, "imgPower")
	local btnChoose = goutil.findChild(cell, "btnChoose")
	local petHead = goutil.findChild(cell, "petHead")
	local btnPet = goutil.findChild(cell, "btnPet")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtPower = goutil.findChildTextComponent(cell, "txtPower")
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local changeGroup = cell:GetComponent(ComponentType.UIChangeGroup)
	local curBagPetMo = data
	local skinId = curBagPetMo.curFaceId

	txtPower.text = curBagPetMo:getFightingPower()
	txtLevel.text = curBagPetMo.level
	txtName.text = curBagPetMo.name

	local jobKeyList = PetSkinConfig.instance:getJobKeyList(skinId)
	local chooseIdx = table.indexof(self._choosePetList, data)
	local petId = data.petId
	local hasChoose = checknumber(chooseIdx) ~= 0

	GameUtil.addClickHandler(btnChoose, function()
		if hasChoose then
			local petIdListIdx = table.indexof(self._choosePetIdList, petId)

			table.remove(self._choosePetList, chooseIdx)
			table.remove(self._choosePetIdList, petIdListIdx)

			for i, jobName in ipairs(jobKeyList) do
				if self._jobDic[jobName] then
					self._jobDic[jobName] = Mathf.Max(self._jobDic[jobName] - 1, 0)
				end
			end
		else
			local choosePetNum = #self._choosePetList

			if choosePetNum == self._actCfg.petLimit then
				FloatWordMgr.instance:show("已达选择精灵数量上限")

				return
			end

			table.insert(self._choosePetList, data)
			table.insert(self._choosePetIdList, petId)

			for i, jobName in ipairs(jobKeyList) do
				if self._jobDic[jobName] then
					self._jobDic[jobName] = self._jobDic[jobName] + 1
				end
			end
		end

		self:_updateJobStr()
		self._scrollList:reloadData(self._curViewDatas)
	end, self)
	GameUtil.addClickHandler(btnPet, function()
		local curBagPetMo = BagPetsController.instance:getPet(petId)

		CommonTipsMgr.instance:showPetTips(curBagPetMo)
	end, self)
	MaterialMgr.setCell(MatType.Pet, skinId, petHead)
	GameUtil.SetActive(imgChoose, hasChoose)
	GameUtil.SetActive(imgBg, hasChoose)
	changeGroup:SetState(hasChoose and 1 or 0)
end

function BoneDragonPetChooseView:_clearCell(cell)
	local petHead = goutil.findChild(cell, "petHead")
	local btnPet = goutil.findChild(cell, "btnPet")

	MaterialMgr.resetAll(petHead)
	GameUtil.rmClickHandler(cell)
	GameUtil.rmClickHandler(btnPet)
end

function BoneDragonPetChooseView:_onClickBtnSure()
	local hasEnoughPetNum = #self._choosePetList >= self._actCfg.petLimit
	local finishChooseRequest = self:_isFinishChooseRequest()

	if #self._choosePetList <= 0 then
		FloatWordMgr.instance:show("请至少选择一个精灵")

		return
	end

	if not hasEnoughPetNum then
		local function okFunc()
			BoneDragonController.instance:sendPM_BoneDragonClgSelectPetReq(self._activityId, self._choosePetIdList)
		end

		TipsFacade.instance:openPopupWindow("提示", "未选满精灵，是否继续进入挑战", okFunc, nil)
	elseif not finishChooseRequest then
		local function okFunc()
			BoneDragonController.instance:sendPM_BoneDragonClgSelectPetReq(self._activityId, self._choosePetIdList)
		end

		TipsFacade.instance:openPopupWindow("提示", "未满足推荐选择职业要求数量，是否继续挑战", okFunc, nil)
	else
		BoneDragonController.instance:sendPM_BoneDragonClgSelectPetReq(self._activityId, self._choosePetIdList)
	end
end

function BoneDragonPetChooseView:_onClickBtnCancel()
	UIStateManager.instance:popByName(ViewName.BoneDragonChallengeView)
	self:close()
end

function BoneDragonPetChooseView:_onClickFilter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_BONE_DRAGON, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function BoneDragonPetChooseView:updateFilterData(starList, jobList, rareList)
	local data = PetFilterMgr.instance:getFilterData(PetFilterMgr.TYPE_BONE_DRAGON)

	self._raceFilter:initData(data.raceSelectList)
	self._raceFilter:initActiveList(data.raceActiveList)
	self._raceFilter:initClickAble(data.raceClickAble)
	self:_RefreshPetList()
end

function BoneDragonPetChooseView:_RefreshPetList(force)
	self._curViewDatas = {}
	self._allPets = BagPetsController.instance:getBagPets()
	self._allPets = self:_filterSameRaceId()

	for k, v in pairs(self._allPets) do
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end

	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and limit <= #self._curViewDatas then
		-- block empty
	else
		local names, opt = self:GetSortParms()

		names[1] = FormationGroupModel.instance.checkIsInTeamByMo

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._scrollList:reloadData(self._curViewDatas)
end

function BoneDragonPetChooseView:_onClickSort()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnSort.gameObject)
	local arr = self:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self.onRefreshPetSort, self))
end

function BoneDragonPetChooseView:onRefreshPetSort(idx, onResetCallback)
	self:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, self._sortValue)

	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and self._curViewDatas and limit <= #self._curViewDatas then
		TipsFacade.instance:openCommonTips(ConstConfig.instance:getPetLimltTips())
	else
		local names, opt = self:GetSortParms()

		names[1] = FormationGroupModel.checkIsInTeamByMo

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._scrollList:reloadData(self._curViewDatas)
end

function BoneDragonPetChooseView:SetNextSort(idx)
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

function BoneDragonPetChooseView:GetSortParms(checkIsInTeamFunc)
	local parm1 = {}
	local parm2 = {}
	local sortName

	local function func(data)
		local res = 0

		if checkIsInTeamFunc then
			if data ~= nil then
				res = checkIsInTeamFunc(data)
			end
		elseif data ~= nil and FormationNewModel.instance:HasPetAtCurFormation(data.petId) then
			res = 1
		end

		return res
	end

	local function funcTop(petMo)
		local isTop = BagPetsController.instance:getPetIsTop(petMo.petId)

		return isTop and 1 or 0
	end

	table.insert(parm1, func)
	table.insert(parm2, ArraySort.DESCENDING)
	table.insert(parm1, funcTop)
	table.insert(parm2, ArraySort.DESCENDING)
	table.insert(parm1, "isSupportedPet")
	table.insert(parm2, ArraySort.DESCENDING)

	for k, v in ipairs(self._sortValue) do
		local vArr = BagModel.SORT_VALUE[k]

		if vArr[v + 1] ~= -1 then
			table.insert(parm1, BagModel.SORT_NAME[k])
			table.insert(parm2, vArr[v + 1])
		end
	end

	return parm1, parm2
end

function BoneDragonPetChooseView:GetSortState()
	if self._sortValue == nil and (self._sortValue == nil or #self._sortValue ~= #BagModel.SORT_NAME) then
		self._sortValue = {}

		for i = 1, #BagModel.SORT_NAME do
			self._sortValue[i] = i == 1 and 1 or 0
		end
	end

	return self._sortValue
end

function BoneDragonPetChooseView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_RefreshPetList()
	end
end

function BoneDragonPetChooseView:_onClearSearchClick()
	self._inputSearch.input.text = ""
end

function BoneDragonPetChooseView:_onSelectPetRes()
	UIStateManager.instance:push(ViewName.BoneDragonChooseView, self._activityId)
	self:close()
end

function BoneDragonPetChooseView:_filterSameRaceId()
	local racePetDic = {}
	local allPets = BagPetsController.instance:getBagPets()

	for i, petMo in pairs(allPets) do
		if racePetDic[petMo.raceId] then
			local curPetMo = racePetDic[petMo.raceId]

			if petMo._zdl >= curPetMo._zdl then
				racePetDic[petMo.raceId] = petMo
			end
		else
			racePetDic[petMo.raceId] = petMo
		end
	end

	return racePetDic
end

function BoneDragonPetChooseView:_isFinishChooseRequest()
	local isFinishChoose = true

	for jobName, jobNum in pairs(self._jobCfgDic) do
		local curJobNum = self._jobDic[jobName]

		if curJobNum < jobNum then
			isFinishChoose = false
		end
	end

	return isFinishChoose
end

return BoneDragonPetChooseView
