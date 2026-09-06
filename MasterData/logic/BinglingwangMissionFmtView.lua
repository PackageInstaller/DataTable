-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/binglingwang/mission/BinglingwangMissionFmtView.lua

module("logic.extensions.mission.view.BinglingwangMissionFmtView", package.seeall)

local BinglingwangMissionFmtView = class("BinglingwangMissionFmtView", MissionFmtView)

function BinglingwangMissionFmtView:_getCreepCos()
	local creepsMasterId = self:_getMonsterCo().creepsMasterId

	return (BinglingwangConfig.instance:getCreepsCfg(checknumber(creepsMasterId)))
end

function BinglingwangMissionFmtView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()
	local cCfg

	if params then
		local challengeId = params.challengeId
		local index = params.index
		local infoMo = BinglingwangModel.instance:getChallangeInfoById(challengeId) or {}
		local day = checknumber(infoMo.participateDays)
		local list = BinglingwangConfig.instance:getMonsterCfg(challengeId, day)

		if list then
			if not list[index] then
				return list[index]
			end
		end
	end

	return {}
end

function BinglingwangMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function BinglingwangMissionFmtView:_setRightSpeedAndPower(speed, zdlRadix)
	self._speed.text = "？？？"
	self._power = "？？？"
	self._powerTxt.text = "？？？"

	MissionModel.instance:setRightPower("？？？")
	MissionModel.instance:setRightSpeed("？？？")
end

function BinglingwangMissionFmtView:_selectItem(index)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return BinglingwangMissionFmtView
