-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/mission/AnniMatchFormationLeftView.lua

module("logic.extensions.annimatch.view.mission.AnniMatchFormationLeftView", package.seeall)

local AnniMatchFormationLeftView = class("AnniMatchFormationLeftView", BuzhenLeftView)

function AnniMatchFormationLeftView:onEnter()
	AnniMatchFormationLeftView.super.onEnter(self)
	self._Btn_Formation:SetActive(false)
	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return self:getAllShowPetList()
	end)
	self:setBtnCutePetActive(false)
	self:_setActiveBtnFormationUse(false)
end

function AnniMatchFormationLeftView:onExit()
	self:_onExitUnbindingEvent()
end

function AnniMatchFormationLeftView:_getCurFormation()
	local activityId = self._viewPresentor:getFirstParam()

	return (AnnimatchModel.instance:getFormationMo(activityId))
end

function AnniMatchFormationLeftView:_getPet(id)
	local list = self:getAllShowPetList()

	for i, v in ipairs(list) do
		if v.petId == id then
			return v
		end
	end
end

function AnniMatchFormationLeftView:getAllShowPetList()
	local activityId = self._viewPresentor:getFirstParam()

	return AnnimatchModel.instance:getPetList(activityId)
end

function AnniMatchFormationLeftView:getSummonPetList()
	return self:getAllShowPetList()
end

function AnniMatchFormationLeftView:GetFormStrengthIdAndLv()
	local fid = 0
	local flvl = 0
	local info = self:_getCurFormation():GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	return fid, (fid > 0 or nil) and BattleConfig.instance:getFormStrengthMaxLv(fid)
end

function AnniMatchFormationLeftView:_OnClickBtnBuffForm()
	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()

	UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, false, true)
end

function AnniMatchFormationLeftView:checkBuffFormIsOpen()
	return true
end

function AnniMatchFormationLeftView:getCurAllFormStrengthInfo()
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

function AnniMatchFormationLeftView:getIsBoundUseBagPet()
	return false
end

function AnniMatchFormationLeftView:_getItemSeatCls()
	MoyanItemSeat.curGetPetCallBack = GameUtil.handler(self._getPet, self)

	return MoyanItemSeat
end

return AnniMatchFormationLeftView
