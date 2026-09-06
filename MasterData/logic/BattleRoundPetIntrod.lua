-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/round/BattleRoundPetIntrod.lua

module("logic.extensions.battle.model.round.BattleRoundPetIntrod", package.seeall)

local BattleRoundPetIntrod = class("BattleRoundPetIntrod", BattleRoundBase)

function BattleRoundPetIntrod:ctor()
	self.roundType = BattleRoundBase.RoundPetIntrod
end

function BattleRoundPetIntrod:start()
	BattleRoundPetIntrod.super.start(self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClosed, self)

	self._isDone = nil

	local legendParam = MissionModel.instance:getRuleParam()

	if legendParam and legendParam.battleType == MissionConst.BattleLegend then
		local isShow = not GameUtil.getUserDayData(MissionConst.BattleLegend .. legendParam.challengeId)

		if isShow then
			ViewMgr.instance:open(ViewName.PetIntroductionView, self.raceId, legendParam)
		else
			self._isDone = true
		end
	else
		ViewMgr.instance:open(ViewName.PetIntroductionView, self.raceId)
	end
end

function BattleRoundPetIntrod:finish()
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClosed, self)
	BattleRoundPetIntrod.super.finish(self)
end

function BattleRoundPetIntrod:isDone()
	return self._isDone
end

function BattleRoundPetIntrod:_onViewClosed(view)
	if view.viewName == ViewName.PetIntroductionView then
		self._isDone = true
	end
end

return BattleRoundPetIntrod
