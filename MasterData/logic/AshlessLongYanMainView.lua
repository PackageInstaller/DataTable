-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/view/AshlessLongYanMainView.lua

module("logic.extensions.ashlesslongyan.view.AshlessLongYanMainView", package.seeall)

local AshlessLongYanMainView = class("AshlessLongYanMainView", ViewComponent)

function AshlessLongYanMainView:buildUI()
	AshlessLongYanMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redBtnJump1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._redBtnJump2 = self:getGo("jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redBtnJump3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
	self._btnStartGo = self:getGo("btnStart")
	self._btnStart = self:getGo("btnStart/btn")
	self._redBtnStart = self:getGo("btnStart/btn/redPoint")
	self._imgPass = self:getGo("btnStart/btn/imgPass")
end

function AshlessLongYanMainView:bindEvents()
	AshlessLongYanMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, function()
		local key = self._actData.ruleKeyMain

		TipsFacade.instance:openRulesView(key)
	end)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function AshlessLongYanMainView:unbindEvents()
	AshlessLongYanMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg1_btn)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg2_btn)
end

function AshlessLongYanMainView:onEnter()
	AshlessLongYanMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = AshlessLongYanController.instance:getActivityId()
	end

	self._activityType = AshlessLongYanController.instance:getActivityType()

	local isInTime = AshlessLongYanController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = AshlessLongYanConfig.instance:getActData(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.HandlePM_AshlessLongYanGetInfoRes, self._onUpdate, self)
	AshlessLongYanController.instance:sendPM_AshlessLongYanGetInfoReq(self._activityId)
end

function AshlessLongYanMainView:onExit()
	AshlessLongYanMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	RedPointController.instance:unregRedPoint(self._redBtnJump1)
	RedPointController.instance:unregRedPoint(self._redBtnJump2)
	RedPointController.instance:unregRedPoint(self._redBtnJump3)
end

function AshlessLongYanMainView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local redInfoList = {
		{
			not string.nilorempty(self._actData.jumpRedIdOne) and string.split(self._actData.jumpRedIdOne, "#"),
			self._redBtnJump1
		},
		{
			not string.nilorempty(self._actData.jumpRedIdTwo) and string.split(self._actData.jumpRedIdTwo, "#"),
			self._redBtnJump2
		},
		{
			not string.nilorempty(self._actData.jumpRedIdThree) and string.split(self._actData.jumpRedIdThree, "#"),
			self._redBtnJump3
		}
	}

	for _, redInfo in ipairs(redInfoList) do
		local list = redInfo[1]
		local redGo = redInfo[2]

		if list then
			local redIdList = {}

			for _, redId in ipairs(list) do
				if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
					table.insert(redIdList, redId)
				end
			end

			if #redIdList > 0 and not goutil.isNil(redGo) then
				RedPointController.instance:regRedPoint(redGo, unpack(redIdList))
			end
		end
	end

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())
end

function AshlessLongYanMainView:_onUpdate()
	local result = AshlessLongYanController.instance:getTryStartClgResultAndTips(false, self._activityId)

	GameUtil.SetActive(self._imgPass, result == GameEnum.ResultCode.IsPass)
end

function AshlessLongYanMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function AshlessLongYanMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function AshlessLongYanMainView:_getRaceId()
	return AshlessLongYanController.instance:getRaceId(self._activityId)
end

function AshlessLongYanMainView:_getSkinId()
	return AshlessLongYanController.instance:getSkinId(self._activityId)
end

function AshlessLongYanMainView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	GotoMgr.gotoByString(jumpToStr)
end

function AshlessLongYanMainView:_onClickBtnStart()
	local result = AshlessLongYanController.instance:getTryStartClgResultAndTips(true, self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.AshlessLongYanStageView, self._activityId)
end

return AshlessLongYanMainView
