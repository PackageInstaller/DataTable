-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/view/AssignmentDetailsView.lua

module("logic.extensions.AssignmentDetails.view.AssignmentDetailsView", package.seeall)

local AssignmentDetailsView = class("AssignmentDetailsView", ViewComponent)

function AssignmentDetailsView:ctor()
	AssignmentDetailsView.super.ctor(self)
end

function AssignmentDetailsView:buildUI()
	AssignmentDetailsView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._goldBar = self:getGo("goldBar")
	self._title = self:getGo("bg/title"):GetComponent(goutil.Type_UIText)
	self._time = self:getGo("bg/consume/time"):GetComponent(goutil.Type_UIText)
	self._star = {}

	for i = 1, 6 do
		table.insert(self._star, self:getGo("bg/star_" .. i))
	end

	self._base1 = self:getGo("bg/base/item_1")
	self._base2 = self:getGo("bg/base/item_2")
	self._perfect1 = self:getGo("bg/perfect/item_3")
	self._perfect2 = self:getGo("bg/perfect/item_4")
	self._send = self:getGo("bg/send")
	self._sendPet = {}

	for i = 1, 4 do
		table.insert(self._sendPet, self:getGo("bg/send/pet_" .. i))
	end
end

function AssignmentDetailsView:bindEvents()
	AssignmentDetailsView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function AssignmentDetailsView:unbindEvents()
	AssignmentDetailsView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function AssignmentDetailsView:destroyUI()
	AssignmentDetailsView.super.destroyUI(self)
end

function AssignmentDetailsView:onEnter()
	AssignmentDetailsView.super.onEnter(self)
	self:_initOpenParams()
	AssignmentDetailsModel.instance:initRanks(self._sendPet)

	local objList = {
		{
			showAdd = false,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.Coin
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)

	local assignment = AssignmentDetailsModel.instance:getAssignment()

	self._title.text = assignment.taskName

	for i = 1, #self._star do
		goutil.setActive(self._star[i], i <= assignment.taskQuality)
	end

	local isInTime, title, startTime, endTime, cfg = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.petSendPrize)
	local mul = 1

	if isInTime and cfg and checknumber(cfg.featureParam) > 0 then
		mul = checknumber(cfg.featureParam)
	end

	local newhandDoubleValue = NewhandwelfareController.instance:getNewhandDoubleValue()

	mul = mul + newhandDoubleValue
	self._time.text = AssignmentController.instance:secondToDate(assignment.taskTime)

	local sp = string.split(assignment.reward, "#")
	local proxy = MaterialMgr.setCellByCfg(AssignmentController.instance.vipToPrize(sp[1], mul), self._base1)

	Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.7, 0.7, 1)
	goutil.setActive(self._base2, sp[2] ~= nil)

	if sp[2] ~= nil then
		proxy = MaterialMgr.setCellByCfg(AssignmentController.instance.vipToPrize(sp[2], mul), self._base2)

		Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.7, 0.7, 1)
	end

	sp = string.split(assignment.rewardPerfect, "#")
	proxy = MaterialMgr.setCellByCfg(AssignmentController.instance.vipToPrize(sp[1], mul), self._perfect1)

	Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.7, 0.7, 1)
	goutil.setActive(self._perfect2, sp[2] ~= nil)

	if sp[2] ~= nil then
		proxy = MaterialMgr.setCellByCfg(AssignmentController.instance.vipToPrize(sp[2], mul), self._perfect2)

		Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.7, 0.7, 1)
	end

	self._batchSelection = self:getGo("batchSelection")

	uGuiUtil.setImageGrayStateRecursive(self._batchSelection, false)
end

function AssignmentDetailsView:onEnterFinished()
	AssignmentDetailsView.super.onEnterFinished(self)
end

function AssignmentDetailsView:onExit()
	AssignmentDetailsView.super.onExit(self)

	local rank = AssignmentDetailsModel.instance:getRanks()

	for _, pet in ipairs(rank.pets) do
		goutil.destroy(goutil.findChild(self._send, "member_" .. pet.petId))
	end

	for i = 1, #self._sendPet do
		goutil.destroy(self._sendPet[i]:GetComponent("LuaComponentContainer"))
	end

	MaterialMgr.resetAll(self._base1)
	MaterialMgr.resetAll(self._base2)
	MaterialMgr.resetAll(self._perfect1)
	MaterialMgr.resetAll(self._perfect2)
end

function AssignmentDetailsView:onExitFinished()
	AssignmentDetailsView.super.onExitFinished(self)
end

function AssignmentDetailsView:_onClickClose()
	self:_tryOpenOnekeyViewBeforeClose()
end

function AssignmentDetailsView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "assignmentDetail")
end

function AssignmentDetailsView:_initOpenParams()
	local params = self:getOpenParam() or {}

	self._taskId = params[1]
	self._onekeyDispatchInfos = params[2]
end

function AssignmentDetailsView:_tryOpenOnekeyViewBeforeClose()
	if self._taskId then
		if not AssignmentDetailsModel.instance:isRankFull() then
			local text = "不满足派遣数量，退出无法保存！"

			TipsFacade.instance:openPopupWindow("提示", text, function()
				self:close()
				UIStateManager.instance:push(ViewName.AssignmentonekeyView, self._onekeyDispatchInfos)
			end)

			return false
		end

		local ranks = AssignmentDetailsModel.instance:getRanks()

		for i, v in ipairs(self._onekeyDispatchInfos) do
			if v.taskCfg.taskId == self._taskId then
				local petIds = {}

				for _, petMo in ipairs(ranks.pets) do
					table.insert(petIds, petMo.petId)
				end

				v.petIds = petIds

				break
			end
		end

		self:close()
		UIStateManager.instance:push(ViewName.AssignmentonekeyView, self._onekeyDispatchInfos)
	end

	self:close()

	return true
end

return AssignmentDetailsView
