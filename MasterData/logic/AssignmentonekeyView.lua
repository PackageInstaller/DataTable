-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/view/AssignmentonekeyView.lua

module("logic.extensions.assignment.view.AssignmentonekeyView", package.seeall)

local AssignmentonekeyView = class("AssignmentonekeyView", ViewComponent)

function AssignmentonekeyView:ctor()
	AssignmentonekeyView.super.ctor(self)
end

function AssignmentonekeyView:unbindEvents()
	AssignmentonekeyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function AssignmentonekeyView:bindEvents()
	AssignmentonekeyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function AssignmentonekeyView:buildUI()
	AssignmentonekeyView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getBtn("viewnode/btnClose")
	self._btnSure = self:getBtn("viewnode/btnSure")
	self._emptyGo = self:getGo("empty")
	self._btnCancel = self:getBtn("viewnode/btnCancel")
end

function AssignmentonekeyView:onExit()
	AssignmentonekeyView.super.onExit(self)
	self._scrollerList:dispose()

	if not self._isOpenDetailViewOp then
		self._initViewDatas = nil
	end
end

function AssignmentonekeyView:onEnter()
	AssignmentonekeyView.super.onEnter(self)

	self._isOpenDetailViewOp = false
	self._initViewDatas = self:getFirstParam()

	self:_calOnekeyDatas()
end

function AssignmentonekeyView:_updateCell(view, cell, data, tag)
	local taskCfg = data.taskCfg
	local goMultipleGo = goutil.findChild(cell.gameObject, "multipleGo")
	local goPetcon = goutil.findChild(cell.gameObject, "petcon")
	local goPet = goutil.findChild(cell.gameObject, "pet")
	local goStars = {}

	for i = 1, 6 do
		goStars[i] = goutil.findChild(cell.gameObject, "star_" .. i)
	end

	local imgAssignChange = goutil.findChild(cell.gameObject, "imgAssign"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "consume/time")
	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "title")

	for i = 1, 6 do
		goutil.setActive(goStars[i], i <= taskCfg.taskQuality)
	end

	txtTitle.text = taskCfg.taskName

	local isPerfect = self:_checkCondintionsPerfect(data.petIds, data.conditions)

	imgAssignChange:SetState(isPerfect and 1 or 0)

	txtTime.text = AssignmentController.instance:secondToDate(taskCfg.taskTime)

	local isInTime, title, startTime, endTime, cfg = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.petSendPrize)
	local mul = 1

	if isInTime and cfg and checknumber(cfg.featureParam) > 0 then
		mul = checknumber(cfg.featureParam)
	end

	local newhandDoubleValue = NewhandwelfareController.instance:getNewhandDoubleValue()

	mul = mul + newhandDoubleValue

	goutil.setActive(goMultipleGo, mul > 1)
	self:_setPets(goPetcon, data.petIds, goPet, taskCfg.taskId)
end

function AssignmentonekeyView:_setPets(goPetcon, petIds, goPet, taskId)
	local singleLine = goPetcon:GetComponent(ComponentType.UILayoutSingleLine)

	for i = 1, goPetcon.transform.childCount do
		local go = goPetcon.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
		goutil.setActive(go, false)
	end

	for i, id in ipairs(petIds) do
		local petMo = BagPetsController.instance:getPet(id)
		local go = goutil.findChild(goPetcon, "pet_" .. i)

		go = go or goutil.cloneAndSetParent(goPet, goPetcon.transform, "pet_" .. i)

		goutil.setActive(go, true)

		local proxy = MaterialMgr.setCellByMo(petMo, go)

		proxy.binder:setCallBack(function()
			self:_onClickPet(taskId, petIds)
		end)
	end

	singleLine:Layout()
end

function AssignmentonekeyView:_onClickPet(taskId, petIds)
	local infos = AssignmentModel.instance:getAssignment()

	for i, data in ipairs(infos) do
		if data.taskId == taskId then
			local petMos = {}

			for _, id in ipairs(petIds) do
				local petMo = BagPetsController.instance:getPet(id)

				table.insert(petMos, petMo)
			end

			AssignmentDetailsModel.instance:setAssignment(data, #petIds, petMos)
			UIStateManager.instance:push(ViewName.AssignmentDetailsView, taskId, self._viewDatas)

			self._isOpenDetailViewOp = true

			self:close()
		end
	end
end

function AssignmentonekeyView:_clearCell(cell)
	local goPetcon = goutil.findChild(cell.gameObject, "petcon")

	for i = 1, goPetcon.transform.childCount do
		MaterialMgr.resetAll(goPetcon.transform:GetChild(i - 1).gameObject)
	end
end

function AssignmentonekeyView:_calOnekeyDatas()
	if self._initViewDatas then
		self._viewDatas = self._initViewDatas
		self._initViewDatas = nil
	else
		self._viewDatas = AssignmentController.instance:getOnekeyDispatchInfos()
	end

	table.sort(self._viewDatas, function(a, b)
		if a.taskCfg.taskQuality == b.taskCfg.taskQuality then
			return a.taskCfg.taskId < b.taskCfg.taskId
		else
			return a.taskCfg.taskQuality > b.taskCfg.taskQuality
		end
	end)
	self._scrollerList:reloadData(self._viewDatas)
	self:_setEmpty()
end

function AssignmentonekeyView:_onClickbtnClose()
	self:close()
end

function AssignmentonekeyView:_onClickbtnSure()
	if not self._viewDatas or #self._viewDatas <= 0 then
		return
	end

	local sendNos = {}
	local hasNoPerfect = false

	for i, v in ipairs(self._viewDatas) do
		local sendNo = {
			taskId = v.taskCfg.taskId,
			petIds = v.petIds
		}

		table.insert(sendNos, sendNo)

		if not hasNoPerfect then
			for i, v in ipairs(v.conditions) do
				if v.num < v[2] then
					hasNoPerfect = true

					break
				end
			end
		end
	end

	if hasNoPerfect then
		TipsFacade.instance:openPopupWindow("派遣任务", "有部分任务没有满足完美条件，完成后只能领取基础奖励，是否继续派遣？", function()
			self:_sendDispatch(sendNos)
		end, nil, "确定", "取消")
	else
		self:_sendDispatch(sendNos)
	end
end

function AssignmentonekeyView:_onClickbtnCancel()
	self:close()
end

function AssignmentonekeyView:_sendDispatch(sendNos)
	AssignmentController.instance:sendDispatchPetsReq(sendNos)
	self:close()
end

function AssignmentonekeyView:_setEmpty()
	local isEmpty = not self._viewDatas or #self._viewDatas <= 0

	goutil.setActive(self._emptyGo, isEmpty)
	goutil.setActive(self._btnSure.gameObject, not isEmpty)
	goutil.setActive(self._btnCancel.gameObject, not isEmpty)
end

function AssignmentonekeyView:_checkCondintionsPerfect(petIds, conditions)
	for i, cond in ipairs(conditions) do
		cond.num = 0
	end

	for i, v in ipairs(petIds) do
		local pet = BagPetsController.instance:getPet(v)

		AssignmentController.instance:_isConditionPassAdd(pet, conditions)
	end

	local isPerfect = true

	for j, cond in ipairs(conditions) do
		isPerfect = isPerfect and cond.num >= cond[2]
	end

	return isPerfect
end

return AssignmentonekeyView
