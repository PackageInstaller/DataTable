-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/JobWorkerSelectView.lua

module("logic.extensions.houseworker.view.JobWorkerSelectView", package.seeall)

local M = class("JobWorkerSelectView", ViewComponent)
local SixDimEnum = CommEnum.Qua2Score
local HeroHouseSortType = CommEnum.HeroHouseSortType

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._titleName = self:getText("2&title_view_-788888785")
	self._autoSelectBtn = self:getBtn("room_role_list_view_-2053314981")
	self._ensureBtn = self:getBtn("room_role_list_view_-1152500058")
	self._roomNameTxt = self:getText("room_role_list_view_920934558")
	self._roomPerosonTxt = self:getText("room_role_list_view_1399452580")
	self._selectEmptyGo = goutil.findChild(self.mainGO, "leftContent/txtEmptyHint")
	self._attrPanelGo = goutil.findChild(self.mainGO, "leftContent/roomSpecialityScroll")
	self._attrContentGo = goutil.findChild(self.mainGO, "leftContent/roomSpecialityScroll/viewPort/Content")
	self._attrItemGo = goutil.findChild(self.mainGO, "leftContent/roomSpecialityScroll/viewPort/Content/room_speciality_layout")
	self._heroDataPanelGo = goutil.findChild(self.mainGO, "leftContent/content2")
	self._workerNameTxt = goutil.findChildTextComponent(self.mainGO, "leftContent/content2/txtName")
	self._moodPanelGo = goutil.findChild(self.mainGO, "leftContent/content2/mood")
	self._moodCell = Astral.LuaComponentContainer.Add(self._moodPanelGo, HouseHeroMoodCell)
	self._loopListHelper = LoopGridViewHelper.New(self:getGo("room_role_list_view_1597595517"))

	self._loopListHelper:InitGridView(0, self._onCellUpdate, self)

	self._sixDimInfoFlag = UIPolygon.Get(goutil.findChild(self.mainGO, "leftContent/content2/sixDimensionInfo/imgDimension"))
	self._sixDimPowerValue = goutil.findChildTextComponent(self.mainGO, "leftContent/content2/sixDimensionInfo/txtPower/txtLevel")
	self._sixDimAgileValue = goutil.findChildTextComponent(self.mainGO, "leftContent/content2/sixDimensionInfo/txtAgile/txtLevel")
	self._sixDimLuckyValue = goutil.findChildTextComponent(self.mainGO, "leftContent/content2/sixDimensionInfo/txtLucky/txtLevel")
	self._sixDimKnowledgeValue = goutil.findChildTextComponent(self.mainGO, "leftContent/content2/sixDimensionInfo/txtKnowledge/txtLevel")
	self._sixDimtInsightValue = goutil.findChildTextComponent(self.mainGO, "leftContent/content2/sixDimensionInfo/txtInsight/txtLevel")
	self._sixDimCommunicateValue = goutil.findChildTextComponent(self.mainGO, "leftContent/content2/sixDimensionInfo/txtCommunicate/txtLevel")
	self._attrItemList = {}
	self._sortBtns = {}
	self._sortBtns[HeroHouseSortType.HouseSkill] = self:getBtnByPath("centerContent/filter/sortBtn1")
	self._sortBtns[HeroHouseSortType.Mood] = self:getBtnByPath("centerContent/filter/sortBtn2")
	self._sortBtns[HeroHouseSortType.WorkType] = self:getBtnByPath("centerContent/filter/sortBtn3")
	self._btnFilter = self:getBtn("room_role_list_view_-260143039")
	self._btnMoodRecord = self:getBtnByPath("leftContent/content2/btnInfo")
	self._hintGo = self:getGo("room_role_list_view_-1825969837")
	self._markView = Astral.LuaComponentContainer.Add(self._hintGo, LivingFacilitiesMarkView)
end

function M:destroyUI()
	self._loopListHelper:Dispose()

	self._loopListHelper = nil
	self._attrItemList = nil
	self._markView = nil
end

function M:bindEvents()
	self._autoSelectBtn:AddClickListener(self._onClickAutoSelectBtn, self)
	self._ensureBtn:AddClickListener(self._onClickEnsureBtn, self)
	self._sortBtns[HeroHouseSortType.HouseSkill]:AddClickListener(self._onClickSortBtnHouseSkill, self)
	self._sortBtns[HeroHouseSortType.Mood]:AddClickListener(self._onClickSortBtnMood, self)
	self._sortBtns[HeroHouseSortType.WorkType]:AddClickListener(self._onClickSortBtnWorkType, self)
	self._btnFilter:AddClickListener(self._onClickBtnFilter, self)
	self._btnMoodRecord:AddClickListener(self._onClickBtnMoodRecord, self)
end

function M:unbindEvents()
	self._autoSelectBtn:RemoveClickListener()
	self._ensureBtn:RemoveClickListener()
	self._sortBtns[HeroHouseSortType.Mood]:RemoveClickListener()
	self._sortBtns[HeroHouseSortType.HouseSkill]:RemoveClickListener()
	self._sortBtns[HeroHouseSortType.WorkType]:RemoveClickListener()
	self._btnFilter:RemoveClickListener()
	self._btnMoodRecord:RemoveClickListener()
end

function M:_bindEvents()
	return
end

function M:_unbindEvents()
	return
end

function M:onEnter()
	self:_setEvents(true)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	self:_bindEvents()

	local info = self:getFirstParam()

	info = info[1] and info[1] or info

	if info then
		self._jobCode = info.jobCode
		self._clickIndex = info.clickIndex
		self._maxSelectPerson = info.maxSelectPerson
		self._openType = info.openType
		self._bunkList = info.bunkList or {}
		self._zoneId = info.zoneId
	end

	self._lastSelectHero = 0
	self._sortType = HouseWorkerModel.instance:getSortType(self._openType)
	self._sortAscending = HouseWorkerModel.instance:getAscending(self._openType, self._sortType)

	self:_initData()
	self:_refreshView()
end

function M:_initData()
	self._selectHeroToIndex = {}
	self._selectIndexToHero = {}

	if self._openType == HouseEnum.OpenType.Job then
		local jobDataList = HouseWorkerModel.instance:getScheduleByJob(self._jobCode)

		for i, v in ipairs(jobDataList) do
			if v.hero and v.hero > 0 then
				self._selectHeroToIndex[v.hero] = v.index
				self._selectIndexToHero[v.index] = v.hero
			end
		end
	elseif self._openType == HouseEnum.OpenType.Dorm then
		for i, bunkInfo in pairs(self._bunkList) do
			local heroId = bunkInfo.heroId

			if heroId > 0 then
				self._selectHeroToIndex[heroId] = i
				self._selectIndexToHero[i] = heroId
			end
		end
	end

	for i = 1, self._maxSelectPerson do
		if self._selectIndexToHero[i] then
			self._lastSelectHero = self._selectIndexToHero[i]
		end
	end
end

function M:_refreshView()
	self:_refreshLeftView()
	self:_refreshRightView()
end

function M:onExit()
	self:_setEvents(false)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	self:_unbindEvents()
	HouseWorkerModel.instance:setFilterIdxs({})
	self._loopListHelper:ClearCells()
	self:_clearAttrItems()
end

function M:_setEvents(isOn)
	if isOn then
		HouseDispatcher:addEventListener(HouseEventType.REPLY_GET_SINGLE_HERO_FEATURE, self._onReplyGetSingleHeroFeature, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.REPLY_GET_SINGLE_HERO_FEATURE, self._onReplyGetSingleHeroFeature, self)
	end
end

function M:_onReplyGetSingleHeroFeature(e, heroId)
	self:_refreshView()
end

function M:_refreshLeftView()
	self:_refreshLivingFacilitiesMark()

	local count = 0

	for k, v in pairs(self._selectHeroToIndex) do
		if v then
			count = count + 1
		end
	end

	self._roomPerosonTxt.text = string.format(lang("tip_work_number_d_d"), count, self._maxSelectPerson)

	if self._openType == HouseEnum.OpenType.Job then
		self._titleName.text = lang("tip_work_in")

		local jobConfig = HouseWorkerModel.instance:getJobConfigByJobCode(self._jobCode)

		self._roomNameTxt.text = jobConfig.jobName
	else
		self._titleName.text = lang("tip_dormitory_in")
		self._roomNameTxt.text = ""
	end

	if self._lastSelectHero > 0 then
		goutil.setActive(self._selectEmptyGo, false)
		goutil.setActive(self._heroDataPanelGo, true)
		goutil.setActive(self._attrPanelGo, true)

		local heroFeatureMo = HeroHouseFeatureModel.instance:getFeatureMO(self._lastSelectHero)

		if heroFeatureMo then
			self._moodCell:updateMood(heroFeatureMo:getMood())
		end

		local heroMO = HeroDepotModel.instance:getHeroInfoByID(self._lastSelectHero)

		self._workerNameTxt.text = heroMO:getName()

		self:_initSixDimInfo(heroMO:getSixDim())

		local skillList = HeroHouseFeatureModel.instance:getFeatureSkillByHeroId(self._lastSelectHero)

		self:_clearAttrItems()

		for i, v in ipairs(skillList) do
			if v.isUnlock then
				local itemGo = goutil.cloneAndSetParent(self._attrItemGo, self._attrContentGo.transform)

				goutil.setActive(itemGo, true)
				table.insert(self._attrItemList, itemGo)

				local nameTxt = goutil.findChildTextComponent(itemGo, "specialityName/txtSpecialityName")
				local descTxt = goutil.findChildTextComponent(itemGo, "suitAttribute_2")
				local iconImg = goutil.findChildImageComponent(itemGo, "specialityName/icon")
				local skillCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseSkill, v.skillId)

				if skillCO then
					nameTxt.text = skillCO.name
					descTxt.text = skillCO.description

					IconLoader.setSprite(iconImg, IconType.DynSpriteAtlas_Room, string.format("room_peculiarity_%s", skillCO.icon))
				else
					printError(string.format("hero[%s],无法从[%s]找到[%s]的配置", self._lastSelectHero, ConfigName.HouseSkill, v.skillId))
				end
			end
		end

		if self._openType == HouseEnum.OpenType.Dorm then
			local schedule = HouseWorkerModel.instance:getScheduleByHeroId(self._lastSelectHero)
			local jobConfig = HouseWorkerModel.instance:getJobConfigByJobCode(schedule.job)

			self._roomNameTxt.text = jobConfig.roomName
		end
	else
		goutil.setActive(self._selectEmptyGo, true)
		goutil.setActive(self._heroDataPanelGo, false)
		goutil.setActive(self._attrPanelGo, false)
	end
end

function M:_refreshLivingFacilitiesMark()
	if self._openType == HouseEnum.OpenType.Dorm then
		local heros = {}

		for _, heroId in pairs(self._selectIndexToHero) do
			if heroId then
				table.insert(heros, heroId)
			end
		end

		local genderMark = LivingFacilitiesZoneController.instance:getGenderMarkByHeros(heros, self._zoneId)
		local campMark = LivingFacilitiesZoneController.instance:getCampMarkByHeros(heros, self._zoneId)

		self._markView:updateData(genderMark, campMark)
	else
		self._markView:setVisiable(false)
	end
end

function M:_clearAttrItems()
	for _, itemGo in ipairs(self._attrItemList) do
		goutil.destroy(itemGo)
	end

	self._attrItemList = {}
end

function M:_initSixDimInfo(sixdim)
	for _, v in ipairs(sixdim) do
		if _ == 1 then
			self._sixDimPowerValue.text = SixDimEnum[v]

			TextUtils.SetColor(self._sixDimPowerValue, self:_getAttrColor(v))
			self._sixDimInfoFlag:InitPolygon(2, v / 6)
		elseif _ == 2 then
			self._sixDimAgileValue.text = SixDimEnum[v]

			TextUtils.SetColor(self._sixDimAgileValue, self:_getAttrColor(v))
			self._sixDimInfoFlag:InitPolygon(1, v / 6)
		elseif _ == 3 then
			self._sixDimKnowledgeValue.text = SixDimEnum[v]

			TextUtils.SetColor(self._sixDimKnowledgeValue, self:_getAttrColor(v))
			self._sixDimInfoFlag:InitPolygon(0, v / 6)
		elseif _ == 4 then
			self._sixDimCommunicateValue.text = SixDimEnum[v]

			TextUtils.SetColor(self._sixDimCommunicateValue, self:_getAttrColor(v))
			self._sixDimInfoFlag:InitPolygon(5, v / 6)
		elseif _ == 5 then
			self._sixDimtInsightValue.text = SixDimEnum[v]

			TextUtils.SetColor(self._sixDimtInsightValue, self:_getAttrColor(v))
			self._sixDimInfoFlag:InitPolygon(4, v / 6)
		elseif _ == 6 then
			self._sixDimLuckyValue.text = SixDimEnum[v]

			TextUtils.SetColor(self._sixDimLuckyValue, self:_getAttrColor(v))
			self._sixDimInfoFlag:InitPolygon(3, v / 6)
		end
	end
end

function M:_getAttrColor(index)
	return CharacterCOUtil.qua2Color(index)
end

function M:_refreshRightView()
	for type, btn in pairs(self._sortBtns) do
		local selectedGO = goutil.findChild(btn.gameObject, "select")
		local upGO = goutil.findChild(btn.gameObject, "imgUp")
		local downGO = goutil.findChild(btn.gameObject, "imgDown")

		goutil.setActive(selectedGO, type == self._sortType)
		goutil.setActive(upGO, type == self._sortType and self._sortAscending == true)
		goutil.setActive(downGO, type == self._sortType and self._sortAscending == false)
	end

	local _tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()

	if self._openType == HouseEnum.OpenType.Dorm then
		_tmpHeroList = HouseWorkerModel.instance:getAllWorkHero()
	end

	local filters = HouseWorkerModel.instance:getFilters()
	local idxs = HouseWorkerModel.instance:getFilterIdxs()
	local fliterTypes = {}

	for _, idx in pairs(idxs) do
		table.insert(fliterTypes, filters[idx])
	end

	local sortData = self:_duelSort(_tmpHeroList:getMoList(), fliterTypes, self._sortType, self._sortAscending)

	self._heroMoList = sortData

	self._loopListHelper:SetListItemCount(#self._heroMoList, true)
	self._loopListHelper:RefreshAllShownItem()
	self._loopListHelper:MoveToItemIndex(0)
end

function M:_duelSort(orgMoLst, fliterTypes, sortTyp, ascending)
	local preData = {}
	local maxPosVal = 0

	for heroId, posVal in pairs(self._selectHeroToIndex or {}) do
		preData[posVal] = {
			heroId = heroId,
			posVal = posVal
		}
		maxPosVal = maxPosVal < posVal and posVal or maxPosVal
	end

	local sortData = {}

	for _, value in ipairs(orgMoLst) do
		local heroId = value:getId()

		if self._selectHeroToIndex[heroId] then
			local posVal = self._selectHeroToIndex[heroId]

			preData[posVal].data = value
		else
			table.insert(sortData, value)
		end
	end

	self:_filterNoSettled(sortData, fliterTypes)

	local type = HouseEnum.RoomType.Living

	if self._openType == HouseEnum.OpenType.Job then
		local jobConfig = HouseWorkerModel.instance:getJobConfigByJobCode(self._jobCode)

		type = jobConfig.roomType
	end

	local params = {
		roomType = type,
		isDorm = self._openType == HouseEnum.OpenType.Dorm
	}

	sortData = CharacterUtil.HouseSortAndFitler(sortData, fliterTypes, sortTyp, params, ascending)

	if maxPosVal > 0 then
		local returnLst = {}

		for i = 1, maxPosVal do
			if preData[i] then
				table.insert(returnLst, preData[i])
			end
		end

		for _, pData in ipairs(returnLst) do
			local pos = pData.posVal
			local data = pData.data

			if pos > #sortData then
				table.insert(sortData, data)
			else
				table.insert(sortData, pos, data)
			end
		end
	end

	return sortData
end

function M:_filterNoSettled(sortData, fliterTypes)
	local noSettledIndex = table.indexof(fliterTypes, CommEnum.HeroHouseFilterType.NoSettled)

	if noSettledIndex then
		table.remove(fliterTypes, noSettledIndex)

		for i = #sortData, 1, -1 do
			local heroId = sortData[i]:getId()
			local isHeroSettled = false

			if self._openType == HouseEnum.OpenType.Dorm then
				local zoneMo = LivingFacilitiesZoneController.instance:findZoneByHeroId(heroId)

				if zoneMo ~= nil then
					isHeroSettled = true
				end
			elseif self._openType == HouseEnum.OpenType.Job then
				local schedule = HouseWorkerModel.instance:getScheduleByHeroId(heroId)

				if schedule ~= nil then
					isHeroSettled = true
				end
			end

			if isHeroSettled then
				table.remove(sortData, i)
			end
		end
	end
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local itemData = self._heroMoList[curIndex]
	local item = self._loopListHelper:NewListViewItem("role_arrange_item1")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, HouseWorkerSelectRoleCell)

	shower:setData(itemData)
	shower:setSelectIndex(self._selectHeroToIndex[itemData:getId()])
	shower:setClickCallBack(self._selectHero, self)

	if self._openType == HouseEnum.OpenType.Dorm then
		local zoneMo = LivingFacilitiesZoneController.instance:findZoneByHeroId(itemData:getId())

		if zoneMo and zoneMo:getId() ~= self._zoneId then
			shower:setSettledOther(true)
			shower:setNotSettled(false)
		else
			shower:setSettledOther(false)

			if zoneMo then
				shower:setNotSettled(false)
			else
				shower:setNotSettled(true)
			end
		end
	else
		local schedule = HouseWorkerModel.instance:getScheduleByHeroId(itemData:getId())

		if schedule and schedule.job ~= self._jobCode then
			shower:setSettledOther(true)
		else
			shower:setSettledOther(false)
		end

		shower:setNotSettled(false)
	end

	return item
end

function M:_selectHero(heroId)
	if self._selectHeroToIndex[heroId] then
		self._selectIndexToHero[self._selectHeroToIndex[heroId]] = nil
		self._selectHeroToIndex[heroId] = nil
		self._lastSelectHero = 0
	else
		local index = self:_getSelectIndex()

		if not index then
			if self._openType == HouseEnum.OpenType.Dorm then
				FloatWordMgr.instance:show(lang("tip_work_people_num_max"))
			else
				FloatWordMgr.instance:show(lang("tip_career_num_max"))
			end

			return
		end

		if self._openType == HouseEnum.OpenType.Dorm then
			local zoneMo = LivingFacilitiesZoneController.instance:findZoneByHeroId(heroId)

			if zoneMo and zoneMo:getId() ~= self._zoneId then
				local dialog = Dialog.showMessage(lang("tip_sure_select"), lang("tip_role_other_room"))

				dialog:setConfirmListener(function()
					self._selectHeroToIndex[heroId] = index
					self._selectIndexToHero[index] = heroId
					self._lastSelectHero = heroId

					self._loopListHelper:RefreshAllShownItem()
					self:_refreshLeftView()
				end, self)

				return
			end

			self._selectHeroToIndex[heroId] = index
			self._selectIndexToHero[index] = heroId
			self._lastSelectHero = heroId
		else
			local schedule = HouseWorkerModel.instance:getScheduleByHeroId(heroId)

			if schedule and schedule.job ~= self._jobCode then
				local dialog = Dialog.showMessage(lang("tip_sure_select"), lang("tip_role_other_facility"))

				dialog:setConfirmListener(function()
					self._selectHeroToIndex[heroId] = index
					self._selectIndexToHero[index] = heroId
					self._lastSelectHero = heroId

					self._loopListHelper:RefreshAllShownItem()
					self:_refreshLeftView()
				end, self)

				return
			end

			self._selectHeroToIndex[heroId] = index
			self._selectIndexToHero[index] = heroId
			self._lastSelectHero = heroId
		end
	end

	self._loopListHelper:RefreshAllShownItem()
	self:_refreshLeftView()
end

function M:_ensureSelect()
	local index = self:_getSelectIndex()

	if not index then
		FloatWordMgr.instance:show(lang("tip_career_num_max"))

		return
	end
end

function M:_getSelectIndex()
	for i = 1, self._maxSelectPerson do
		if not self._selectIndexToHero[i] then
			return i
		end
	end

	return false
end

function M:_onClickAutoSelectBtn()
	if self._openType == HouseEnum.OpenType.Job then
		local index = self:_getSelectIndex()
		local needSelectCount = 3

		if index then
			for i, v in pairs(self._selectHeroToIndex) do
				if v then
					needSelectCount = needSelectCount - 1
				end
			end
		else
			FloatWordMgr.instance:show(lang("tip_career_num_max"))

			return
		end

		local jobConfig = HouseWorkerModel.instance:getJobConfigByJobCode(self._jobCode)
		local roomType = jobConfig.roomType
		local heroList = {}

		for i, heroMo in ipairs(self._heroMoList) do
			local schedule = HouseWorkerModel.instance:getScheduleByHeroId(heroMo:getId())
			local eduState = HeroHouseFeatureModel.instance:getHeroThoughtEduState(heroMo:getId())

			if eduState == HouseMainEnum.HeroThoughtEduState.CanWork and (not schedule or schedule and schedule.job == self._jobCode) and not self._selectHeroToIndex[heroMo:getId()] then
				local heroLevelTable = {
					commonLevel = 0,
					level = 0,
					heroId = heroMo:getId()
				}
				local houseJobSort = heroMo:getCharacterCo().houseJobSort

				if houseJobSort then
					for i, v in ipairs(houseJobSort) do
						if v.type == roomType then
							heroLevelTable.level = v.level
						end

						if v.type == 0 then
							heroLevelTable.commonLevel = v.level
						end
					end
				end

				table.insert(heroList, heroLevelTable)
			end
		end

		table.sort(heroList, function(moA, moB)
			if moA.level == moB.level then
				if moA.commonLevel == moB.commonLevel then
					return moA.heroId < moB.heroId
				else
					return moA.commonLevel > moB.commonLevel
				end
			else
				return moA.level > moB.level
			end
		end)

		for i = 1, needSelectCount do
			if heroList[i] then
				self:_selectHero(heroList[i].heroId)
			end
		end
	elseif self._openType == HouseEnum.OpenType.Dorm then
		local index = self:_getSelectIndex()
		local needSelectCount = self._maxSelectPerson

		if index then
			for i, v in pairs(self._selectHeroToIndex) do
				if v then
					needSelectCount = needSelectCount - 1
				end
			end
		else
			FloatWordMgr.instance:show(lang("tip_work_people_num_max"))

			return
		end

		local heroList = HouseWorkerModel.instance:getAllWorkHero()

		heroList:sortMoList(function(moA, moB)
			return moA:getId() < moB:getId()
		end)

		for i, heroMo in ipairs(heroList:getMoList()) do
			local heroId = heroMo:getId()
			local zoneMo = LivingFacilitiesZoneController.instance:findZoneByHeroId(heroId)

			if zoneMo and zoneMo:getId() then
				-- block empty
			elseif needSelectCount > 0 then
				self:_selectHero(heroId)

				needSelectCount = needSelectCount - 1
			end
		end
	end
end

function M:_onClickEnsureBtn()
	if self._openType == HouseEnum.OpenType.Job then
		local heroList = {}

		for i = 1, self._maxSelectPerson do
			if self._selectIndexToHero[i] then
				table.insert(heroList, self._selectIndexToHero[i])
			else
				table.insert(heroList, 0)
			end
		end

		GlobalDispatcher:dispatchEvent(EventType.HOUSE_HERO_SELECT_ENSURE, heroList)
	elseif self._openType == HouseEnum.OpenType.Dorm then
		local bunkList = {}

		for i, bunkInfo in ipairs(self._bunkList) do
			local hero = self._selectIndexToHero[i]

			hero = hero or 0

			local bunk = {}

			bunk.furnitureUUId = bunkInfo.furnitureUUId
			bunk.index = bunkInfo.index
			bunk.heroId = hero

			table.insert(bunkList, bunk)
		end

		LivingFacilitiesAgent.instance:sendSetBunkRequest(bunkList)
	end

	self:close()
end

function M:_clickSortType(sortType)
	if self._sortType == sortType then
		self._sortAscending = not self._sortAscending
	else
		self._sortType = sortType
		self._sortAscending = HouseWorkerModel.instance:getAscending(self._openType, self._sortType)
	end

	self:_refreshRightView()
end

function M:_onClickSortBtnMood()
	self:_clickSortType(HeroHouseSortType.Mood)
end

function M:_onClickSortBtnHouseSkill()
	self:_clickSortType(HeroHouseSortType.HouseSkill)
end

function M:_onClickSortBtnWorkType()
	self:_clickSortType(HeroHouseSortType.WorkType)
end

function M:_onClickBtnFilter()
	local filterData = {}
	local filterNames = {}
	local filters = HouseWorkerModel.instance:getFilters()

	for _, filterType in ipairs(filters) do
		table.insert(filterNames, CommEnum.HouseFilterType2Name[filterType])
	end

	filterData.titleName = lang("tip_house_hero_selected_skill_sort")
	filterData.filterTypeNameList = filterNames
	filterData.selectedIdxs = HouseWorkerModel.instance:getFilterIdxs()

	local param = {}

	param.filterDataList = {
		filterData
	}
	param.ensureCallback = self._ensureFilter
	param.ensureTarget = self

	ViewMgr.instance:open(ViewName.FilterTips, param)
end

function M:_ensureFilter(filterSelectedIdxs)
	HouseWorkerModel.instance:setFilterIdxs(filterSelectedIdxs[1])
	self:_refreshRightView()
end

function M:_onClickBtnMoodRecord()
	if self._lastSelectHero > 0 then
		ViewMgr.instance:open(ViewName.HouseHeroMoodRecord, self._lastSelectHero)
	end
end

return M
