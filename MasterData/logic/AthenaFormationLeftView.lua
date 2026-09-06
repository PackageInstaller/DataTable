-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/athena/AthenaFormationLeftView.lua

module("logic.extensions.timelimitedchallenge.view.athena.AthenaFormationLeftView", package.seeall)

local AthenaFormationLeftView = class("AthenaFormationLeftView", FormationLeftView)

function AthenaFormationLeftView:onEnter()
	local openParam = self:getOpenParam()

	self._challengeId, self._stageCfg, self._supportPlan = openParam[1], openParam[2], openParam[3]

	AthenaModel.instance:setDefaultSupportPlan(self._challengeId, self._supportPlan)
	AthenaModel.instance:initWitFormation(self._challengeId)
	AthenaFormationLeftView.super.onEnter(self)
	self:setBtnCutePetActive(true)

	if self._supportPlan then
		self:setBtnCutePetActive(false)
	end

	goutil.setActive(self._Btn_Formation.gameObject, false)
	self:_setActiveBtnFormationUse(not self._supportPlan)
end

function AthenaFormationLeftView:_saveCurrFmt()
	if self._supportPlan then
		-- block empty
	else
		AthenaFormationLeftView.super._saveCurrFmt(self)
	end
end

function AthenaFormationLeftView:getSummonPetList()
	return (self._RightView:getAllShowPetList())
end

function AthenaFormationLeftView:_OnClickSeat(go, eventData)
	if self._dragSeat then
		self._dragSeat:ShowPet()
	end

	local ItemSeatCls = self:_getItemSeatCls()
	local itemSeat = ItemSeatCls.Get(go)

	if not itemSeat or not itemSeat:IsOpen() then
		return
	end

	if not itemSeat:isHasPet() then
		return
	end

	local petId = itemSeat:GetData()
	local petMo = self:_getPet(petId)
	local bagPetMo = BagPetsController.instance:getPet(petId)

	CommonTipsMgr.instance:showPetTips((not bagPetMo or nil) and AthenaModel.instance:getPetMo(petId, self._supportPlan, self._challengeId))
end

function AthenaFormationLeftView:_OnClickBtnBuffForm()
	if self._supportPlan then
		local curPetNumber = self:_getCurFormation():getCurExistPetNumber()

		UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, false)
		TipsFacade.instance:openCommonTips(lang("本玩法中,已经解锁的阵法生效后自动设置为<color=#00ff00>满级</color>"))
	else
		AthenaFormationLeftView.super._OnClickBtnBuffForm(self)
	end
end

function AthenaFormationLeftView:_onUpdateBuffFormById(info)
	if self._supportPlan then
		goutil.setActive(self._MarkLock_BuffForm, false)
		goutil.setActive(self._MarkNotActive_BuffForm, false)

		local formId
		local formLv = 0

		if info then
			formId = info.formStrengthId
			formLv = BattleConfig.instance:getFormStrengthMaxLv(info.formStrengthId)
			info.formStrengthLv = formLv
		end

		self:SetFormStrengthInfo(info)
		self:_onSelectBuffForm(formId, formLv)

		if self._CurFormId ~= formId then
			self._CurFormId = checknumber(formId)

			self:_SetPowerAndSpeed()

			if checknumber(formId) > 0 then
				self:_showFormationActive()
			end
		end
	else
		AthenaFormationLeftView.super._onUpdateBuffFormById(self, info)
	end
end

function AthenaFormationLeftView:SetFormStrengthInfo(info)
	self:_getCurFormation():SetFormStrengthInfo(info)

	local formStrengthId = -1

	if info then
		formStrengthId = info.formStrengthId
	end

	if self._supportPlan then
		local fomation = self:_getCurFormation()

		if fomation and (fomation._formStrengInfo == nil or fomation._formStrengInfo.formStrengthId ~= formStrengthId) then
			fomation:SetFormStrengthInfo(info)
		end
	else
		FormationController.instance:setCurrBuffFormInfo(formStrengthId)
	end
end

function AthenaFormationLeftView:_getPet(petId)
	if self._supportPlan then
		return AthenaModel.instance:getPetMo(petId, self._supportPlan, self._challengeId)
	else
		return AthenaFormationLeftView.super._getPet(self, petId)
	end
end

function AthenaFormationLeftView:_getCurFormId()
	if self._supportPlan then
		return 10
	else
		return AthenaFormationLeftView.super._getCurFormId(self)
	end
end

function AthenaFormationLeftView:_getCurFormation()
	if self._supportPlan then
		return AthenaModel.instance:getWitFormation(self._challengeId)
	else
		return AthenaFormationLeftView.super._getCurFormation(self)
	end
end

return AthenaFormationLeftView
