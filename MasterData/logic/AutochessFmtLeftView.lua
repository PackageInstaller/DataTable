-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessFmtLeftView.lua

module("logic.extensions.autochess.view.AutochessFmtLeftView", package.seeall)

local AutochessFmtLeftView = class("AutochessFmtLeftView", FormationLeftView)

function AutochessFmtLeftView:buildUI()
	AutochessFmtLeftView.super.buildUI(self)
end

function AutochessFmtLeftView:onEnter()
	AutochessFmtLeftView.super.onEnter(self)
	self.addGEvent(self, AutochessController.PetUp, self._onPetUp, self)

	if self._elementSkillGo then
		goutil.setActive(self._elementSkillGo, false)
	end

	self:setBtnCutePetActive(false)
	self:setBtnFormActive(false)
end

function AutochessFmtLeftView:_getItemSeatCls()
	return AutochessItemSeat
end

function AutochessFmtLeftView:_isExceedSpecifiedNumber()
	local roundId = AutochessModel.instance:getRoundId()
	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()
	local specificNumber = AutochessConfig.instance:getRoundFormationNum(roundId)

	return specificNumber <= curPetNumber
end

function AutochessFmtLeftView:_showFailedTips()
	local roundId = AutochessModel.instance:getRoundId()
	local specificNumber = AutochessConfig.instance:getRoundFormationNum(roundId)
	local content = langPara("最多上阵%d只精灵哦！", specificNumber)

	FloatWordMgr.instance:show(content)
end

function AutochessFmtLeftView:_getCurFormation()
	return AutochessModel.instance:getCurrFormation()
end

function AutochessFmtLeftView:_getPet(id)
	return AutochessModel.instance:getPet(id)
end

function AutochessFmtLeftView:_RefeshSeats()
	self:dealWithLimitPetPos()

	local toId = self:_getHeroSkillId()
	local skills = self:_getPetsHeroSkills()

	if TableUtil.isHad(skills, toId) then
		-- block empty
	else
		toId = table.getn(skills) > 0 and skills[1] or 0
	end

	self:_changeHeroSkillId(toId)

	local positions = self:_getCurFormation():GetPositions()

	for i, petId in ipairs(positions) do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])
		local petMo

		itemSeat:SetSeatInfo(i, (petId > 0 or nil) and self:_getPet(petId), self:_getCurElementMap())
		itemSeat:SetSelect(false)
		itemSeat:SetRestrain("", false)
		itemSeat:setStar(self)
	end

	self:_SetHeroSkill(toId)
	self:_updateStartOrder()
end

function AutochessFmtLeftView:_onPetUp(raceId)
	local pos = self:_getCurFormation():GetPositions()
	local itemSeat

	for i = 1, 9 do
		local petId = pos[i]

		if petId and petId > 0 then
			local cfg = AutochessConfig.instance:getCreepsCfg(petId)

			if cfg.raceId == raceId then
				itemSeat = self:_getItemSeatByPetId(petId)

				break
			end
		end
	end

	if itemSeat then
		itemSeat:playUpEffect()
	end
end

function AutochessFmtLeftView:_OnSeatValueChanged(pos, petId)
	AutochessFmtLeftView.super._OnSeatValueChanged(self, pos, petId)

	local fmt = self:_getCurFormation()
	local form = fmt:createFormPb()

	AutoChessAgent.instance:sendPM_ACSetFormationReq(form)
end

function AutochessFmtLeftView:getIsBoundUseBagPet()
	return false
end

function AutochessFmtLeftView:_OnClickBtnBuffForm()
	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()
	local isShowLvlupBtn = false
	local isClientMaxLvl = true

	UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, isShowLvlupBtn, isClientMaxLvl)
end

return AutochessFmtLeftView
