-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/mission/AceteamBuzhenLeftView.lua

module("logic.extensions.formation.view.AceteamBuzhenLeftView", package.seeall)

local AceteamBuzhenLeftView = class("AceteamBuzhenLeftView", BuzhenLeftView)

function AceteamBuzhenLeftView:onEnter()
	AceteamBuzhenLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(false)
	GlobalDispatcher:addListener(GlobalNotify.FormationPet_POS_FINISH, self.onAllPetSetFinish, self)
	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return AceTeamModel.instance:getPetList()
	end)
end

function AceteamBuzhenLeftView:onExit()
	AceteamBuzhenLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationPet_POS_FINISH, self.onAllPetSetFinish, self)
	FastFormation.instance:setCurFormFunc(nil)
	FastFormation.instance:setGetCurPetList(nil)
end

function AceteamBuzhenLeftView:_setBtnFormationActive()
	return false
end

function AceteamBuzhenLeftView:_saveCurrFmt()
	return
end

function AceteamBuzhenLeftView:GetFormStrengthIdAndLv()
	local fid = 0
	local flvl = 0
	local info = self:_getCurFormation():GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	return fid, (fid > 0 or nil) and BattleConfig.instance:getFormStrengthMaxLv(fid)
end

function AceteamBuzhenLeftView:_OnClickBtnBuffForm()
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(96)

	if not isOpen then
		local cfgFuncOpen = FuncOpenConfig.instance:getFunctionOpenById(96)

		if cfgFuncOpen then
			FloatWordMgr.instance:show(cfgFuncOpen.description)
		end

		return
	end

	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()

	UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, false, true)
end

function AceteamBuzhenLeftView:getCurAllFormStrengthInfo()
	local fsMap = {}

	for i = 1, 8 do
		local _maxlv = BattleConfig.instance:getFormStrengthMaxLv(i)

		fsMap[i] = {
			formStrengthId = i,
			formStrengthLv = _maxlv
		}
	end

	return fsMap
end

function AceteamBuzhenLeftView:_onUpdateBuffFormById(info)
	goutil.setActive(self._MarkLock_BuffForm, false)

	local formId
	local formLv = 0

	if info then
		info.formStrengthLv = BattleConfig.instance:getFormStrengthMaxLv(info.formStrengthId)
	end

	self:SetFormStrengthInfo(info)

	if info then
		formId = info.formStrengthId
		formLv = info.formStrengthLv
	end

	self:_onSelectBuffForm(formId, formLv)

	formId = nil

	if self._CurFormId ~= nil then
		self._CurFormId = checknumber(formId)

		self:_SetPowerAndSpeed()

		if checknumber(formId) > 0 then
			self:_showFormationActive()
		end
	end
end

function AceteamBuzhenLeftView:_getPet(petId)
	return AceTeamModel.instance:getCurTeamPetMo(petId)
end

function AceteamBuzhenLeftView:_getCurFormId()
	return 1
end

function AceteamBuzhenLeftView:_getCurFormation()
	return AceTeamModel.instance:GetCurFormation()
end

function AceteamBuzhenLeftView:getIsBoundUseBagPet()
	return false
end

function AceteamBuzhenLeftView:_getItemSeatCls()
	return AceTeamItemSeat
end

function AceteamBuzhenLeftView:getSummonPetList()
	return AceTeamModel.instance:getPetList()
end

return AceteamBuzhenLeftView
