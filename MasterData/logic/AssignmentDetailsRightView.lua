-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/view/AssignmentDetailsRightView.lua

module("logic.extensions.AssignmentDetails.view.AssignmentDetailsRightView", package.seeall)

local AssignmentDetailsRightView = class("AssignmentDetailsRightView", FormationRightView)

function AssignmentDetailsRightView:ctor()
	AssignmentDetailsRightView.super.ctor(self)
end

function AssignmentDetailsRightView:bindEvents()
	AssignmentDetailsRightView.super.bindEvents(self)

	for i = 1, 4 do
		self._sendBtn[i]:AddClickListener(function()
			self:_onClickSendPet(i)
		end, self)
	end

	self._enter:AddClickListener(self._onClickEnter, self)
	self._batchSelection:AddClickListener(self._onClickBatchSelection, self)
end

function AssignmentDetailsRightView:unbindEvents()
	AssignmentDetailsRightView.super.unbindEvents(self)
	self._enter:RemoveClickListener()
	self._batchSelection:RemoveClickListener()
end

function AssignmentDetailsRightView:buildUI()
	AssignmentDetailsRightView.super.buildUI(self)

	self._condition = {}

	for i = 1, 3 do
		table.insert(self._condition, self:getGo("bg/consummate/condition_" .. i))
	end

	self._send = self:getGo("bg/send").transform
	self._sendPet = {}
	self._sendBtn = {}

	for i = 1, 4 do
		table.insert(self._sendPet, self:getGo("bg/send/pet_" .. i))
		table.insert(self._sendBtn, self:getBtn("bg/send/pet_" .. i .. "/button"))
	end

	self._moveList = {}
	self._enter = self:getBtn("bg/enter")

	uGuiUtil.setImageGrayStateRecursive(self._enter, true)

	self._batchSelection = self:getBtn("batchSelection")
end

function AssignmentDetailsRightView:destroyUI()
	return
end

function AssignmentDetailsRightView:onEnter()
	AssignmentDetailsRightView.super.onEnter(self)
	self:_initOpenViewWithParams()
	AssignmentDetailsController.instance:setView(self)

	local j = AssignmentDetailsModel.instance:getConditionCount()

	for i = 1, #self._condition do
		if i <= j then
			AssignmentDetailsController.instance:getConditionText(i, goutil.findChild(self._condition[i], "content"))
			goutil.setActive(self._condition[i], true)
		else
			goutil.setActive(self._condition[i], false)
		end
	end

	local x = AssignmentDetailsModel.instance:getAssignment()

	for i = 1, 4 do
		goutil.setActive(self._sendPet[i], i <= x.petNum)
	end

	settimer(0.02, self._move, self, true)
end

function AssignmentDetailsRightView:onEnterFinished()
	AssignmentDetailsRightView.super.onEnterFinished(self)
end

function AssignmentDetailsRightView:onExit()
	AssignmentDetailsRightView.super.onExit(self)

	local rank = AssignmentDetailsModel.instance:getRanks()

	for _, v in pairs(rank.pets) do
		local petCell = goutil.findChild(self._sendPet[AssignmentDetailsModel.instance:removeRanksMember(v.petId)], "member_" .. v.petId)

		if petCell then
			MaterialMgr.resetAll(petCell)
		end
	end

	for i = 1, #self._moveList do
		if self._moveList[i] and not goutil.isNil(self._moveList[i][1]) then
			MaterialMgr.resetAll(self._moveList[i][1])
		end
	end

	table.clear(self._moveList)
	self:_updateCondition()

	self._curViewDatas = nil

	removetimer(self._move, self)
end

function AssignmentDetailsRightView:onExitFinished()
	return
end

function AssignmentDetailsRightView:initCell(cell)
	local component = ItemPet.AddOnce(cell.gameObject)

	component:addListener(ItemPet.Events.Click, function(data)
		self:_onClickPet(data, cell)
	end)
end

function AssignmentDetailsRightView:_onClickPet(data, cell)
	if self._isInUsePetId[data.petId] then
		FloatWordMgr.instance:show("已被其他任务选择")

		return
	end

	local selectedGo = goutil.findChild(cell.gameObject, "selected")

	selectedGo.transform:SetAsLastSibling()

	if selectedGo.activeSelf == false then
		if AssignmentDetailsController.instance:isMemberPet(data.petId) then
			goutil.setActive(selectedGo, true)
			uGuiUtil.setImageGrayStateRecursive(self._enter, not AssignmentDetailsModel.instance:isRankFull())
		else
			local pet = CharacterConfig.instance:getPetCo(data.raceId)
			local _ranks = AssignmentDetailsModel.instance:getRanks()

			if _ranks.num < _ranks.memberMaxNum and pet ~= nil then
				local petIdx = AssignmentDetailsModel.instance:addRanksMember(data)

				self:_updateCondition()

				local name = "member_" .. data.petId
				local _gameObject = goutil.findChild(self._sendPet[petIdx], name)

				_gameObject = _gameObject or goutil.create("member_" .. data.petId, true)

				goutil.addChildToParent(_gameObject, cell.transform)
				Framework.TransformUtil.SetLocalPos(_gameObject.transform, 0, 0, 0)

				local proxy = MaterialMgr.setCellByMo(data, _gameObject)

				proxy.binder:setAutoTips(false)
				proxy.binder:setCallBack(function()
					self:_onClickPet(data, cell)
				end)
				_gameObject.transform:SetParent(self._sendPet[petIdx].transform)
				Framework.TransformUtil.SetLocalScale(_gameObject.transform, 0.9, 0.9, 0.9)
				_gameObject.transform:SetAsFirstSibling()
				table.insert(self._moveList, {
					_gameObject,
					AssignmentDetailsController.instance:direction(_gameObject:GetComponent("RectTransform").anchoredPosition, Vector2(0, 0)),
					Vector2(0, 0)
				})
				goutil.setActive(selectedGo, true)
				uGuiUtil.setImageGrayStateRecursive(self._enter, not AssignmentDetailsModel.instance:isRankFull())
			else
				FloatWordMgr.instance:show("精灵派遣阵容已满")
			end
		end
	else
		self:_removeSendPet(data.petId)
		goutil.setActive(selectedGo, false)
		self:_updateCondition()
		uGuiUtil.setImageGrayStateRecursive(self._enter, true)
		uGuiUtil.setImageGrayStateRecursive(self._batchSelection, false)
	end
end

function AssignmentDetailsRightView:_onClickSendPet(index)
	local rankMember = AssignmentDetailsModel.instance:getRanks(index)

	if rankMember == nil then
		return nil
	end

	self:_removeSendPet(rankMember.petId)
	uGuiUtil.setImageGrayStateRecursive(self._enter, true)
	uGuiUtil.setImageGrayStateRecursive(self._batchSelection, false)
	self._tableview:ReloadData()
end

function AssignmentDetailsRightView:_onClickEnter()
	local rank = AssignmentDetailsModel.instance:getRanks()

	if rank.num < rank.memberMaxNum then
		FloatWordMgr.instance:show("需要上满精灵才能出发哦！")
	else
		local condition = AssignmentDetailsModel.instance:getCondition()
		local flag = true

		for i, v in ipairs(condition) do
			if v.num < v[2] then
				flag = false

				break
			end
		end

		if flag then
			self:_suerEnter()
		else
			TipsFacade.instance:openPopupWindow("派遣任务", "没有满足完美条件，完成后只能领取基础奖励，是否继续派遣？", function()
				self:_suerEnter()
			end, nil, "确定", "取消")
		end
	end
end

function AssignmentDetailsRightView:_onClickBatchSelection()
	if not AssignmentDetailsModel.instance:isRankFull() or not AssignmentDetailsModel.instance:isQuick() then
		local newViewDatas = self:_getFilterViewDatas()
		local petIds = AssignmentDetailsController.instance:searchConditionPet(newViewDatas)

		for _, petId in ipairs(petIds) do
			for i = 1, #self._curViewDatas do
				if petId == self._curViewDatas[i].petId then
					self._curViewDatas[i].enter = true

					local x = table.remove(petIds.postion, 1)
					local name = "member_" .. petId
					local petCell = goutil.findChild(self._sendPet[x], name)

					if not petCell then
						petCell = goutil.create(name)

						petCell.transform:SetParent(self._sendPet[x].transform)
						Framework.TransformUtil.SetLocalPos(petCell.transform, 0, 0, 0)
						Framework.TransformUtil.SetLocalScale(petCell.transform, 0.9, 0.9, 0.9)
					end

					local proxy = MaterialMgr.setCellByMo(self._curViewDatas[i], petCell)

					petCell.transform:SetAsFirstSibling()

					break
				end
			end
		end

		uGuiUtil.setImageGrayStateRecursive(self._batchSelection, AssignmentDetailsModel.instance:isRankFull())
		uGuiUtil.setImageGrayStateRecursive(self._enter, not AssignmentDetailsModel.instance:isRankFull())
		self:_updateCondition()
		self._tableview:ReloadData()
	else
		FloatWordMgr.instance:show("派遣阵容已满，无需一键选择")
	end
end

function AssignmentDetailsRightView:_removeSendPet(petId)
	for i = #self._moveList, 1, -1 do
		if self._moveList[i] ~= nil then
			local v = self._moveList[i]

			if v[1].name == "member_" .. petId then
				MaterialMgr.resetAll(v[1])
				table.remove(self._moveList, i)

				break
			end
		end
	end

	local index = AssignmentDetailsModel.instance:removeRanksMember(petId)
	local petCell = goutil.findChild(self._sendPet[index], "member_" .. petId)

	MaterialMgr.resetAll(petCell)
	self:_updateCondition()
end

function AssignmentDetailsRightView:_RefreshPetList()
	self._curViewDatas = {}

	local pets = BagPetsController.instance:getBagPets()

	for k, v in pairs(pets) do
		if self:onFilter(v) and not AssignmentDetailsController.instance:isPetInOut(v.petId) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end

	if #self._curViewDatas == 0 then
		FloatWordMgr.instance:show("当前没有可派遣精灵")
	end

	AssignmentDetailsModel.instance:setUsablePetNum(#self._curViewDatas)
	self:rankNow()
end

function AssignmentDetailsRightView:_updateCell(view, cell, data)
	local component = ItemPet.AddOnce(cell.gameObject)

	component:Init(data)
	component:setGray(false)
	goutil.setActive(goutil.findChild(cell.gameObject, "PetCell/item_pet(Clone)/imgLocked"), false)

	local selectedGo = goutil.findChild(cell.gameObject, "selected")

	goutil.setActive(selectedGo, false)

	if AssignmentDetailsController.instance:isMemberPet(data.petId) or self._isInUsePetId[data.petId] then
		goutil.setActive(selectedGo, true)
		selectedGo.transform:SetAsLastSibling()
		uGuiUtil.setImageGrayStateRecursive(self._enter, not AssignmentDetailsModel.instance:isRankFull())
	end
end

function AssignmentDetailsRightView:_updateCondition()
	AssignmentDetailsController.instance:checkCondition()

	for i = 1, AssignmentDetailsModel.instance:getConditionCount() do
		AssignmentDetailsController.instance:getConditionText(i, goutil.findChild(self._condition[i], "content"))
	end
end

function AssignmentDetailsRightView:rankNow()
	if FormationController.instance:checkCanSort(self._curViewDatas) then
		local names, opt = AssignmentDetailsController.instance:GetSortParms()

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
end

function AssignmentDetailsRightView:_move()
	for i = #self._moveList, 1, -1 do
		if self._moveList[i] ~= nil then
			local v = self._moveList[i]

			if not goutil.isNil(v[1]) and not goutil.isNil(v[1].transform) then
				local anchoredPosition = GameUtil.getAnchoredPos(v[1])

				if math.pow(anchoredPosition.x - v[3].x, 2) + math.pow(anchoredPosition.y - v[3].y, 2) <= v[2].length then
					GameUtil.setAnchoredPos(v[1], v[3].x, v[3].y)
					table.remove(self._moveList, i)
				else
					local newPos = anchoredPosition + v[2].direction

					GameUtil.setAnchoredPos(v[1], newPos.x, newPos.y)
				end
			else
				table.remove(self._moveList, i)
			end
		end
	end
end

function AssignmentDetailsRightView:_initOpenViewWithParams()
	local params = self:getOpenParam() or {}

	self._taskId = params[1]

	local onekeyDispatchInfos = params[2]

	self._onekeyDispatchInfos = onekeyDispatchInfos
	self._isInUsePetId = {}

	if onekeyDispatchInfos then
		local ranks = AssignmentDetailsModel.instance:getRanks()
		local ignorePets = {}

		for i, v in pairs(ranks.pets) do
			if v then
				ignorePets[v.petId] = true
			end
		end

		for i, v in ipairs(onekeyDispatchInfos) do
			for _, petId in ipairs(v.petIds) do
				if not ignorePets[petId] then
					self._isInUsePetId[petId] = true
				end
			end
		end
	end

	local ranks = AssignmentDetailsModel.instance:getRanks()

	if ranks and ranks.pets then
		for i = 1, #ranks.pets do
			local petMo = ranks.pets[i]

			if petMo then
				local name = "member_" .. petMo.petId
				local _gameObject = goutil.findChild(self._sendPet[i], name)

				if not _gameObject then
					_gameObject = goutil.create(name)

					local transform = _gameObject.transform

					transform:SetParent(self._sendPet[i].transform)
					Framework.TransformUtil.SetLocalPos(transform, 0, 0, 0)
					Framework.TransformUtil.SetLocalScale(transform, 0.9, 0.9, 0.9)
					transform:SetAsFirstSibling()
				end

				MaterialMgr.setCellByMo(petMo, _gameObject)
			end
		end

		uGuiUtil.setImageGrayStateRecursive(self._batchSelection, AssignmentDetailsModel.instance:isRankFull())
		uGuiUtil.setImageGrayStateRecursive(self._enter, not AssignmentDetailsModel.instance:isRankFull())
		self:_updateCondition()
		self._tableview:ReloadData()
	end
end

function AssignmentDetailsRightView:_getFilterViewDatas()
	local list = {}

	for i, v in ipairs(self._curViewDatas) do
		if not self._isInUsePetId[v.petId] then
			table.insert(list, v)
		end
	end

	return list
end

function AssignmentDetailsRightView:_suerEnter()
	local assignment = AssignmentDetailsModel.instance:getAssignment()
	local rank = AssignmentDetailsModel.instance:getRanks()
	local petIds = {}

	for _, pet in ipairs(rank.pets) do
		table.insert(petIds, tonumber(pet.petId))
	end

	local sendNo = {
		{
			taskId = assignment[1],
			petIds = petIds
		}
	}

	AssignmentController.instance:sendDispatchPetsReq(sendNo)
	self:close()
	self:_tryOpenOnekeyView(assignment.taskId)
end

function AssignmentDetailsRightView:_tryOpenOnekeyView(taskId)
	if self._taskId then
		for i, v in ipairs(self._onekeyDispatchInfos) do
			if v.taskCfg.taskId == taskId then
				table.remove(self._onekeyDispatchInfos, i)
				UIStateManager.instance:push(ViewName.AssignmentonekeyView, self._onekeyDispatchInfos)

				break
			end
		end
	end
end

return AssignmentDetailsRightView
