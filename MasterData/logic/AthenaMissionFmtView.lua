-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/athena/AthenaMissionFmtView.lua

module("logic.extensions.timelimitedchallenge.view.athena.AthenaMissionFmtView", package.seeall)

local AthenaMissionFmtView = class("AthenaMissionFmtView", MissionFmtView)

function AthenaMissionFmtView:onEnter()
	local openParam = self:getOpenParam()

	self._challengeId, self._stageCfg, self._supportPlan = openParam[1], openParam[2], openParam[3]

	AthenaMissionFmtView.super.onEnter(self)
end

function AthenaMissionFmtView:_refreshFromation()
	local cCfg = WaterLightHeroTowerConfig.instance:getCreepsById(self._stageCfg.creepsMasterId)
	local teams, formations = self:getTeamAndFormation(cCfg)

	self:_createExtParams(formations)

	local heroSkillId = self:getheroSkillId(nil, teams)

	self:initFormation(formations, teams, heroSkillId)
end

function AthenaMissionFmtView:_setFmtParams(heroSkillId, speed, zdlRadix)
	if self._supportPlan then
		AthenaMissionFmtView.super._setFmtParams(self, heroSkillId, speed, zdlRadix)

		return
	end

	self:_setHeroSkill(heroSkillId)
	self:_updateDomainSkill()
	self:_updatePsychicedSkill()

	self._speed.text = "？？？"
	self._power = zdlRadix
	self._powerTxt.text = "？？？"

	MissionModel.instance:setRightPower(zdlRadix)
	MissionModel.instance:setRightSpeed(speed)
	GlobalDispatcher:dispatch(GlobalNotify.FormationSpeedUpdate)

	local petPoses = {}

	for k, v in pairs(self._existPetPoses) do
		table.insert(petPoses, k)
	end

	MissionModel.instance:setPetPoses(petPoses)
end

function AthenaMissionFmtView:_onClickPower()
	if self._supportPlan then
		AthenaMissionFmtView.super._onClickPower(self)

		return
	end

	FloatWordMgr.instance:show(langPara("全员战斗力:%s", "？？？"))
end

function AthenaMissionFmtView:_selectItem(index)
	if self._supportPlan then
		AthenaMissionFmtView.super._selectItem(self, index)

		return
	end

	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return AthenaMissionFmtView
