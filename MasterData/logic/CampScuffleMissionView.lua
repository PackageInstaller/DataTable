-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/scufflemission/CampScuffleMissionView.lua

module("logic.extensions.funcamp.view.scufflemission.CampScuffleMissionView", package.seeall)

local CampScuffleMissionView = class("CampScuffleMissionView", MissionView)

function CampScuffleMissionView:buildUI()
	CampScuffleMissionView.super.buildUI(self)

	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
	self._maxPetCount = checknumber(CampGameConfig.instance:getCommonValueByKey("PET_NUM"))
end

function CampScuffleMissionView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.CS_SetFormRes, self._onSetFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CS_NotifyGameEndRes, self._onGameEndRes, self)
	CampScuffleModel.instance:initFormation()
	self:onEnterInherit()
	self:_hideGameObject()
	self:procMid()
	FastFormation.instance:setCurFormFunc(function()
		return CampScuffleModel.instance:getFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return CampScuffleModel.instance:getAllPets()
	end)

	self._countdown = CampScuffleModel.instance:getFormationCountDown()
	self._isCountDown = true
	self.isWaitingEmeny = false

	uGuiUtil.setImageGrayStateRecursive(self._startBtn.gameObject, self.isWaitingEmeny)
	uGuiUtil.setImageGrayStateRecursive(self._btnOneKey.gameObject, self.isWaitingEmeny)
	uGuiUtil.setImageGrayStateRecursive(self._btnClean.gameObject, self.isWaitingEmeny)
	settimer(1, self._onSecond, self)
end

function CampScuffleMissionView:onExit()
	CampScuffleMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_SetFormRes, self._onSetFormRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_NotifyGameEndRes, self._onGameEndRes, self)
	removetimer(self._onSecond, self)
end

function CampScuffleMissionView:_onSecond()
	if self._isCountDown then
		if self._countdown > 0 then
			self._countdown = self._countdown - 1

			if self._countdown < 2 then
				local formation = CampScuffleModel.instance:getFormation()

				if formation and formation:isEmpty() then
					self:_onClickOneKey()
				end
			end
		else
			self:_enterBattle()

			self._isCountDown = false
		end
	end
end

function CampScuffleMissionView:procMid()
	self:_setDescStr("精灵大乱斗", nil, "击败对方所有精灵即可获胜")
end

function CampScuffleMissionView:_saveFormationEx()
	return
end

function CampScuffleMissionView:_onClickStart()
	local formation = CampScuffleModel.instance:getFormation()

	if formation and formation:isEmpty() then
		FloatWordMgr.instance:show("请先上阵精灵哦")
	elseif self.isWaitingEmeny == false then
		GlobalDispatcher:dispatch(GlobalNotify.CampScuffleClickEnterBattle)
		self:_enterBattle()
	end
end

function CampScuffleMissionView:_onClickOneKey()
	if self.isWaitingEmeny == false then
		SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
		FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), nil, function(posList, petPool)
			local needPets = FastFormation.instance.needPets
			local count = self._maxPetCount - table.nums(petPool)
			local tem = {}

			for i, petMo in ipairs(needPets) do
				local isHas = false

				for k, v in pairs(petPool) do
					if v == petMo then
						isHas = true

						break
					end
				end

				if isHas == false then
					table.insert(tem, petMo)

					count = count - 1

					if count <= 0 then
						break
					end
				end
			end

			for i = 1, self._maxPetCount do
				if table.indexof(posList, i) == false then
					table.insert(posList, i)
				end

				if petPool[i] == nil and #tem > 0 then
					petPool[i] = table.remove(tem, 1)
				end
			end

			return posList, petPool
		end)
		MissionModel.instance:setForceResetOneKey(false)
	end
end

function CampScuffleMissionView:_onClickClean()
	if self.isWaitingEmeny == false then
		CampScuffleMissionView.super._onClickClean(self)
	end
end

function CampScuffleMissionView:_enterBattle()
	self._isCountDown = false

	self:_setMaskBlock(true)

	local var_13_0 = CampScuffleModel.instance:getFormation():GetPositions()

	if not var_13_0 then
		var_13_0 = {}

		local pet_poisition = var_13_0
		local isHasPet = false

		for i = 1, 9 do
			local petId = checknumber(pet_poisition[i])

			if petId > 0 then
				isHasPet = true
			end
		end

		local fmo = CampScuffleModel.instance:getFormation()
		local simpleForm = fmo:createFormPb()

		simpleForm.formId = 10

		if isHasPet then
			CampScuffleAgent.instance:sendCS_SetFormReq(simpleForm)
		end
	end
end

function CampScuffleMissionView:_onSetFormRes()
	self.isWaitingEmeny = true

	uGuiUtil.setImageGrayStateRecursive(self._startBtn.gameObject, self.isWaitingEmeny)
	uGuiUtil.setImageGrayStateRecursive(self._btnOneKey.gameObject, self.isWaitingEmeny)
	uGuiUtil.setImageGrayStateRecursive(self._btnClean.gameObject, self.isWaitingEmeny)
end

function CampScuffleMissionView:_onGameEndRes()
	CampScuffleController.instance:onGameEndRes(function()
		self:_onClickClose()
	end)
end

function CampScuffleMissionView:_hideGameObject()
	goutil.setActive(self._Titlebg, false)
	goutil.setActive(self._btnRule.gameObject, false)
	goutil.setActive(self._closeButton.gameObject, false)
end

function CampScuffleMissionView:_maxPetNum()
	return self._maxPetCount
end

return CampScuffleMissionView
