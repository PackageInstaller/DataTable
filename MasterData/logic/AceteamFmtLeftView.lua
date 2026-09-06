-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/mission/mission/AceteamFmtLeftView.lua

module("logic.extensions.aceteam.view.mission.mission.AceteamFmtLeftView", package.seeall)

local AceteamFmtLeftView = class("AceteamFmtLeftView", FormationLeftView)

function AceteamFmtLeftView:onExit()
	AceteamFmtLeftView.super.onExit(self)
	FastFormation.instance:setCurFormFunc(nil)
	FastFormation.instance:setGetCurPetList(nil)
end

function AceteamFmtLeftView:onEnter()
	AceteamFmtLeftView.super.onEnter(self)
	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return AceTeamModel.instance:getPetList()
	end)
	self:_setActiveBtnFormation(false)
	self:setBtnCutePetActive(false)
	self:_setActiveBtnFormationUse(false)
end

function AceteamFmtLeftView:_saveCurrFmt()
	return
end

function AceteamFmtLeftView:_getPet(petId)
	return AceTeamModel.instance:getCurTeamPetMo(petId)
end

function AceteamFmtLeftView:_getCurFormId()
	return 1
end

function AceteamFmtLeftView:_getCurFormation()
	return AceTeamModel.instance:GetCurFormation()
end

function AceteamFmtLeftView:_getItemSeatCls()
	return AceTeamItemSeat
end

function AceteamFmtLeftView:GetFormStrengthIdAndLv()
	local fid = 0
	local flvl = 0
	local info = self:_getCurFormation():GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	return fid, (fid > 0 or nil) and BattleConfig.instance:getFormStrengthMaxLv(fid)
end

function AceteamFmtLeftView:_OnClickBtnBuffForm()
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

function AceteamFmtLeftView:getCurAllFormStrengthInfo()
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

function AceteamFmtLeftView:getSummonPetList()
	return AceTeamModel.instance:getPetList()
end

function AceteamFmtLeftView:getIsBoundUseBagPet()
	return false
end

return AceteamFmtLeftView
