-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/BFMissionLeftView.lua

module("logic.extensions.mission.view.BFMissionLeftView", package.seeall)

local BFMissionLeftView = class("BFMissionLeftView", FormationLeftView)

function BFMissionLeftView:onEnter()
	BFMissionLeftView.super.onEnter(self)
	self:setBtnCutePetActive(false)
	self:_setActiveBtnFormationUse(false)
end

function BFMissionLeftView:_getPet(id)
	return BreakFormationController.instance:getTempMaxPet(id)
end

function BFMissionLeftView:_playFormationAni()
	self._formationChangeFlag = false

	if self._CurFormId and self._CurFormId > 0 then
		local info = FormationNewModel.instance:getFormStrengthInfo(self._CurFormId)

		if info then
			local tb = {}

			tb.formStrengthId = info.formStrengthId
			tb.formStrengthLv = BattleConfig.instance:getFormStrengthMaxLv(self._CurFormId)

			UIStateManager.instance:open(ViewName.FomationactiveView, tb)
		end
	end
end

function BFMissionLeftView:_onSelectBuffForm(formId, formLv)
	formLv = checknumber(formLv)
	formId = checknumber(formId)

	if formId > 0 then
		formLv = BattleConfig.instance:getFormStrengthMaxLv(formId)
	end

	BFMissionLeftView.super._onSelectBuffForm(self, formId, formLv)
end

function BFMissionLeftView:GetFormStrengthIdAndLv()
	local fid = 0
	local flvl = 0
	local info = self:_getCurFormation():GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	return fid, (fid > 0 or nil) and BattleConfig.instance:getFormStrengthMaxLv(fid)
end

function BFMissionLeftView:_OnClickBtnBuffForm()
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(96)

	if not isOpen then
		local cfgFuncOpen = FuncOpenConfig.instance:getFunctionOpenById(96)

		if cfgFuncOpen then
			FloatWordMgr.instance:show(cfgFuncOpen.description)
		end

		return
	end

	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()

	UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, true)
	TipsFacade.instance:openCommonTips(lang("破阵天下玩法中,已经解锁的阵法生效后自动设置为<color=#00ff00>满级</color>"))
end

function BFMissionLeftView:_getItemSeatCls()
	return BFMissionItemSeat
end

function BFMissionLeftView:getIsBoundUseBagPet()
	return false
end

return BFMissionLeftView
